# Security Implementation

## Overview

This document outlines the comprehensive security measures implemented in Focus Hub, including authentication, authorization, data protection, and security best practices.

## Authentication Security

### 1. Supabase Auth Configuration

**File**: `src/integrations/supabase/client.ts`
```typescript
import { createClient } from '@supabase/supabase-js';
import type { Database } from './types';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL!;
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY!;

// Create Supabase client with security configurations
export const supabase = createClient<Database>(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true,
    flowType: 'pkce', // Use PKCE flow for enhanced security
  },
  global: {
    headers: {
      'X-Client-Info': 'focus-hub-web',
    },
  },
});
```

### 2. Session Management

**File**: `src/contexts/AuthContext.tsx`
```typescript
export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  // ... existing state

  useEffect(() => {
    // Set up auth state listener with security checks
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, session) => {
        console.log('Auth state changed:', event, session?.user?.email);
        
        // Validate session
        if (session) {
          const isValid = await validateSession(session);
          if (!isValid) {
            await supabase.auth.signOut();
            return;
          }
        }
        
        setSession(session);
        setUser(session?.user ?? null);
        
        if (session?.user) {
          // Fetch user data with security checks
          await fetchUserData(session.user.id);
        } else {
          setProfile(null);
          setUserRole(null);
        }
        setLoading(false);
      }
    );

    // Check for existing session
    supabase.auth.getSession().then(async ({ data: { session } }) => {
      if (session) {
        const isValid = await validateSession(session);
        if (!isValid) {
          await supabase.auth.signOut();
          return;
        }
      }
      
      setSession(session);
      setUser(session?.user ?? null);
      if (session?.user) {
        await fetchUserData(session.user.id);
      }
      setLoading(false);
    });

    return () => subscription.unsubscribe();
  }, []);

  // Session validation function
  const validateSession = async (session: Session): Promise<boolean> => {
    try {
      // Check if user is still active in database
      const { data: profile, error } = await supabase
        .from('profiles')
        .select('status')
        .eq('id', session.user.id)
        .single();

      if (error || !profile) return false;
      
      // Check if user is banned or inactive
      if (profile.status === 'banned' || profile.status === 'inactive') {
        return false;
      }

      return true;
    } catch (error) {
      console.error('Session validation error:', error);
      return false;
    }
  };

  // Secure sign-in with rate limiting
  const signIn = async (email: string, password: string) => {
    try {
      // Check rate limiting
      const rateLimitKey = `signin_attempts_${email}`;
      const attempts = localStorage.getItem(rateLimitKey);
      const attemptCount = attempts ? parseInt(attempts) : 0;
      
      if (attemptCount >= 5) {
        const lastAttempt = localStorage.getItem(`${rateLimitKey}_time`);
        const timeDiff = Date.now() - (lastAttempt ? parseInt(lastAttempt) : 0);
        
        if (timeDiff < 15 * 60 * 1000) { // 15 minutes
          toast({
            title: "Too many attempts",
            description: "Please wait 15 minutes before trying again",
            variant: "destructive",
          });
          return { error: { message: "Rate limited" } };
        } else {
          localStorage.removeItem(rateLimitKey);
          localStorage.removeItem(`${rateLimitKey}_time`);
        }
      }

      const { error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        // Increment failed attempts
        localStorage.setItem(rateLimitKey, (attemptCount + 1).toString());
        localStorage.setItem(`${rateLimitKey}_time`, Date.now().toString());
        
        toast({
          title: "Sign in failed",
          description: error.message,
          variant: "destructive",
        });
      } else {
        // Reset attempts on successful login
        localStorage.removeItem(rateLimitKey);
        localStorage.removeItem(`${rateLimitKey}_time`);
        
        toast({
          title: "Welcome back!",
          description: "You have been signed in successfully.",
        });
      }

      return { error };
    } catch (error: any) {
      toast({
        title: "Sign in failed",
        description: error.message,
        variant: "destructive",
      });
      return { error };
    }
  };

  // Secure sign-out
  const signOut = async () => {
    try {
      // Clear local storage
      localStorage.clear();
      
      // Sign out from Supabase
      const { error } = await supabase.auth.signOut();
      
      if (error) {
        toast({
          title: "Sign out failed",
          description: error.message,
          variant: "destructive",
        });
      } else {
        // Clear all state
        setUser(null);
        setSession(null);
        setProfile(null);
        setUserRole(null);
        
        toast({
          title: "Signed out",
          description: "You have been signed out successfully.",
        });
        navigate('/');
      }
    } catch (error: any) {
      toast({
        title: "Sign out failed",
        description: error.message,
        variant: "destructive",
      });
    }
  };

  // ... rest of the component
};
```

## Authorization & Access Control

### 1. Role-Based Access Control (RBAC)

**File**: `src/components/ProtectedRoute.tsx`
```typescript
import { useAuth } from '@/contexts/AuthContext';
import { Navigate, useLocation } from 'react-router-dom';
import { useEffect, useState } from 'react';

interface ProtectedRouteProps {
  children: React.ReactNode;
  requireAdmin?: boolean;
  requiredRoles?: string[];
  permissions?: string[];
}

export const ProtectedRoute: React.FC<ProtectedRouteProps> = ({ 
  children, 
  requireAdmin = false,
  requiredRoles = [],
  permissions = []
}) => {
  const { user, loading, isAdmin, userRole } = useAuth();
  const location = useLocation();
  const [hasPermission, setHasPermission] = useState<boolean | null>(null);

  useEffect(() => {
    const checkPermissions = async () => {
      if (!user || permissions.length === 0) {
        setHasPermission(true);
        return;
      }

      try {
        // Check user permissions against database
        const { data, error } = await supabase
          .from('user_permissions')
          .select('permission')
          .eq('user_id', user.id)
          .in('permission', permissions);

        if (error) throw error;
        
        const userPermissions = data?.map(p => p.permission) || [];
        const hasAllPermissions = permissions.every(p => userPermissions.includes(p));
        
        setHasPermission(hasAllPermissions);
      } catch (error) {
        console.error('Permission check error:', error);
        setHasPermission(false);
      }
    };

    checkPermissions();
  }, [user, permissions]);

  if (loading || hasPermission === null) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  if (!user) {
    // Redirect to login with return URL
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  if (requireAdmin && !isAdmin) {
    return <Navigate to="/app" replace />;
  }

  if (requiredRoles.length > 0 && !requiredRoles.includes(userRole || '')) {
    return <Navigate to="/app" replace />;
  }

  if (!hasPermission) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-2">Access Denied</h1>
          <p className="text-muted-foreground">
            You don't have permission to access this page.
          </p>
        </div>
      </div>
    );
  }

  return <>{children}</>;
};
```

### 2. Database-Level Security

#### Row Level Security (RLS) Policies

```sql
-- Enable RLS on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE chats ENABLE ROW LEVEL SECURITY;
ALTER TABLE filemodels ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view all profiles" ON profiles
  FOR SELECT USING (true);

CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Posts policies
CREATE POLICY "Users can view non-deleted posts" ON posts
  FOR SELECT USING (is_deleted = false);

CREATE POLICY "Users can create posts" ON posts
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own posts" ON posts
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own posts" ON posts
  FOR DELETE USING (auth.uid() = user_id);

-- Admin policies
CREATE POLICY "Admin can view all posts" ON posts
  FOR SELECT USING (has_role(auth.uid(), 'admin'));

CREATE POLICY "Admin can delete any post" ON posts
  FOR DELETE USING (has_role(auth.uid(), 'admin'));

-- Chat policies
CREATE POLICY "Users can view chats they're members of" ON chats
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM chat_members 
      WHERE chat_id = chats.id AND user_id = auth.uid()
    )
  );

-- File policies
CREATE POLICY "Users can view public files" ON filemodels
  FOR SELECT USING (is_public = true);

CREATE POLICY "Users can view own files" ON filemodels
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can upload files" ON filemodels
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own files" ON filemodels
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own files" ON filemodels
  FOR DELETE USING (auth.uid() = user_id);
```

## Data Protection

### 1. Input Validation & Sanitization

**File**: `src/lib/validation.ts`
```typescript
import { z } from 'zod';
import DOMPurify from 'dompurify';

// Input validation schemas
export const userProfileSchema = z.object({
  full_name: z.string().min(1).max(100).transform(val => DOMPurify.sanitize(val)),
  bio: z.string().max(500).optional().transform(val => val ? DOMPurify.sanitize(val) : null),
  location: z.string().max(100).optional().transform(val => val ? DOMPurify.sanitize(val) : null),
  website: z.string().url().optional().transform(val => val ? DOMPurify.sanitize(val) : null),
});

export const postSchema = z.object({
  content: z.string().min(1).max(2000).transform(val => DOMPurify.sanitize(val)),
  media_url: z.string().url().optional(),
});

export const commentSchema = z.object({
  content: z.string().min(1).max(1000).transform(val => DOMPurify.sanitize(val)),
});

export const questionSchema = z.object({
  question: z.string().min(10).max(500).transform(val => DOMPurify.sanitize(val)),
});

// File upload validation
export const fileUploadSchema = z.object({
  file: z.instanceof(File).refine(
    (file) => file.size <= 50 * 1024 * 1024, // 50MB limit
    'File size must be less than 50MB'
  ).refine(
    (file) => {
      const allowedTypes = [
        'image/jpeg',
        'image/png',
        'image/gif',
        'image/webp',
        'application/pdf',
        'text/plain',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      ];
      return allowedTypes.includes(file.type);
    },
    'File type not allowed'
  ),
  description: z.string().max(500).optional().transform(val => val ? DOMPurify.sanitize(val) : null),
  isPublic: z.boolean().default(false),
});

// Validation utility functions
export const validateInput = <T>(schema: z.ZodSchema<T>, data: unknown): T => {
  try {
    return schema.parse(data);
  } catch (error) {
    if (error instanceof z.ZodError) {
      throw new Error(`Validation error: ${error.errors.map(e => e.message).join(', ')}`);
    }
    throw error;
  }
};

// XSS Protection
export const sanitizeHtml = (html: string): string => {
  return DOMPurify.sanitize(html, {
    ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a', 'p', 'br'],
    ALLOWED_ATTR: ['href', 'target'],
  });
};

// SQL Injection Protection (for dynamic queries)
export const escapeSqlIdentifier = (identifier: string): string => {
  return `"${identifier.replace(/"/g, '""')}"`;
};
```

### 2. Content Security Policy (CSP)

**File**: `src/lib/csp.ts`
```typescript
export const cspConfig = {
  'default-src': ["'self'"],
  'script-src': [
    "'self'",
    "'unsafe-inline'", // Required for Vite HMR in development
    process.env.NODE_ENV === 'development' ? "'unsafe-eval'" : '',
  ].filter(Boolean),
  'style-src': [
    "'self'",
    "'unsafe-inline'", // Required for Tailwind CSS
  ],
  'img-src': [
    "'self'",
    "data:",
    "https:",
    "https://*.supabase.co",
  ],
  'connect-src': [
    "'self'",
    "https://*.supabase.co",
    process.env.NODE_ENV === 'development' ? "ws://localhost:*" : '',
  ].filter(Boolean),
  'font-src': [
    "'self'",
    "data:",
  ],
  'object-src': ["'none'"],
  'base-uri': ["'self'"],
  'form-action': ["'self'"],
  'frame-ancestors': ["'none'"],
  'upgrade-insecure-requests': [],
};

export const generateCSPHeader = (): string => {
  return Object.entries(cspConfig)
    .map(([key, values]) => `${key} ${values.join(' ')}`)
    .join('; ');
};
```

## API Security

### 1. API Rate Limiting

**File**: `src/api/middleware/rateLimit.ts`
```typescript
import { Request, Response, NextFunction } from 'express';

interface RateLimitConfig {
  windowMs: number;
  maxRequests: number;
  message: string;
}

class RateLimiter {
  private requests: Map<string, { count: number; resetTime: number }> = new Map();

  constructor(private config: RateLimitConfig) {}

  middleware = (req: Request, res: Response, next: NextFunction) => {
    const key = this.getKey(req);
    const now = Date.now();

    const requestData = this.requests.get(key);
    
    if (!requestData || now > requestData.resetTime) {
      // Reset or create new request data
      this.requests.set(key, {
        count: 1,
        resetTime: now + this.config.windowMs,
      });
      return next();
    }

    if (requestData.count >= this.config.maxRequests) {
      return res.status(429).json({
        error: 'Too many requests',
        message: this.config.message,
        retryAfter: Math.ceil((requestData.resetTime - now) / 1000),
      });
    }

    // Increment request count
    requestData.count++;
    this.requests.set(key, requestData);
    next();
  };

  private getKey(req: Request): string {
    // Use IP address and user ID if available
    const userKey = req.user?.id || 'anonymous';
    return `${req.ip}-${userKey}`;
  }
}

// Rate limit configurations
export const rateLimits = {
  auth: new RateLimiter({
    windowMs: 15 * 60 * 1000, // 15 minutes
    maxRequests: 5,
    message: 'Too many authentication attempts. Please try again later.',
  }),
  
  api: new RateLimiter({
    windowMs: 60 * 1000, // 1 minute
    maxRequests: 100,
    message: 'Too many API requests. Please slow down.',
  }),
  
  upload: new RateLimiter({
    windowMs: 60 * 60 * 1000, // 1 hour
    maxRequests: 10,
    message: 'Too many file uploads. Please try again later.',
  }),
};
```

### 2. Request Validation

**File**: `src/api/middleware/validation.ts`
```typescript
import { Request, Response, NextFunction } from 'express';
import { z } from 'zod';

export const validateRequest = (schema: z.ZodSchema) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      const validatedData = schema.parse({
        body: req.body,
        query: req.query,
        params: req.params,
      });
      
      req.validated = validatedData;
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          error: 'Validation error',
          details: error.errors,
        });
      }
      next(error);
    }
  };
};

// Request schemas
export const createPostSchema = z.object({
  body: z.object({
    content: z.string().min(1).max(2000),
    media_url: z.string().url().optional(),
  }),
});

export const updateProfileSchema = z.object({
  body: z.object({
    full_name: z.string().min(1).max(100).optional(),
    bio: z.string().max(500).optional(),
    location: z.string().max(100).optional(),
    website: z.string().url().optional(),
  }),
});
```

## Security Headers

### 1. Security Middleware

**File**: `src/api/middleware/security.ts`
```typescript
import { Request, Response, NextFunction } from 'express';
import helmet from 'helmet';

export const securityHeaders = helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
      connectSrc: ["'self'", "https://*.supabase.co"],
      fontSrc: ["'self'", "data:"],
      objectSrc: ["'none'"],
      mediaSrc: ["'self'"],
      frameSrc: ["'none'"],
    },
  },
  crossOriginEmbedderPolicy: false,
  crossOriginResourcePolicy: { policy: "cross-origin" },
});

export const additionalSecurityHeaders = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  // Security headers
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('X-XSS-Protection', '1; mode=block');
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
  res.setHeader('Permissions-Policy', 'camera=(), microphone=(), geolocation=()');
  
  // Remove server information
  res.removeHeader('X-Powered-By');
  
  next();
};
```

## Error Handling & Logging

### 1. Secure Error Handling

**File**: `src/lib/errorHandler.ts`
```typescript
export class AppError extends Error {
  constructor(
    public message: string,
    public statusCode: number = 500,
    public isOperational: boolean = true
  ) {
    super(message);
    Error.captureStackTrace(this, this.constructor);
  }
}

export const handleError = (error: Error, req?: Request, res?: Response) => {
  if (error instanceof AppError) {
    // Operational error - log but don't expose details
    console.error('Operational error:', {
      message: error.message,
      statusCode: error.statusCode,
      url: req?.url,
      method: req?.method,
      user: req?.user?.id,
    });

    if (res) {
      return res.status(error.statusCode).json({
        error: error.message,
        ...(process.env.NODE_ENV === 'development' && { stack: error.stack }),
      });
    }
  } else {
    // Programming error - log full details
    console.error('Programming error:', {
      message: error.message,
      stack: error.stack,
      url: req?.url,
      method: req?.method,
      user: req?.user?.id,
    });

    if (res) {
      return res.status(500).json({
        error: 'Internal server error',
        ...(process.env.NODE_ENV === 'development' && { 
          message: error.message,
          stack: error.stack 
        }),
      });
    }
  }
};

// Global error handler for React
export const globalErrorHandler = (error: Error, errorInfo: React.ErrorInfo) => {
  console.error('React error:', {
    message: error.message,
    stack: error.stack,
    componentStack: errorInfo.componentStack,
  });

  // Send to error tracking service in production
  if (process.env.NODE_ENV === 'production') {
    // Example: Sentry.captureException(error, { extra: errorInfo })
  }
};
```

## Security Best Practices

### 1. Password Security

```typescript
// Password validation
export const validatePassword = (password: string): boolean => {
  const minLength = 8;
  const hasUpperCase = /[A-Z]/.test(password);
  const hasLowerCase = /[a-z]/.test(password);
  const hasNumbers = /\d/.test(password);
  const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

  return (
    password.length >= minLength &&
    hasUpperCase &&
    hasLowerCase &&
    hasNumbers &&
    hasSpecialChar
  );
};

// Password strength indicator
export const getPasswordStrength = (password: string): 'weak' | 'medium' | 'strong' => {
  let score = 0;
  
  if (password.length >= 8) score++;
  if (/[A-Z]/.test(password)) score++;
  if (/[a-z]/.test(password)) score++;
  if (/\d/.test(password)) score++;
  if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) score++;
  if (password.length >= 12) score++;

  if (score < 3) return 'weak';
  if (score < 5) return 'medium';
  return 'strong';
};
```

### 2. File Upload Security

```typescript
// File type validation
export const validateFileType = (file: File): boolean => {
  const allowedTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
    'application/pdf',
    'text/plain',
  ];

  return allowedTypes.includes(file.type);
};

// File size validation
export const validateFileSize = (file: File, maxSize: number = 50 * 1024 * 1024): boolean => {
  return file.size <= maxSize;
};

// File content validation
export const validateFileContent = async (file: File): Promise<boolean> => {
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const array = new Uint8Array(e.target?.result as ArrayBuffer);
      
      // Check file signatures
      const signatures = {
        jpeg: [0xFF, 0xD8, 0xFF],
        png: [0x89, 0x50, 0x4E, 0x47],
        gif: [0x47, 0x49, 0x46],
        pdf: [0x25, 0x50, 0x44, 0x46],
      };

      const isValid = Object.values(signatures).some(signature =>
        signature.every((byte, index) => array[index] === byte)
      );

      resolve(isValid);
    };
    reader.readAsArrayBuffer(file);
  });
};
```

This security implementation provides comprehensive protection for the Focus Hub application, including authentication, authorization, data validation, and security best practices. 