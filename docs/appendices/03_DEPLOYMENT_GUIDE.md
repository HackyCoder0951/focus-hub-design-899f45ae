# Deployment Guide
## Focus Hub Social Learning Platform

---

## Table of Contents

1. [Environment Setup](#1-environment-setup)
2. [Configuration Management](#2-configuration-management)
3. [Deployment Procedures](#3-deployment-procedures)
4. [Monitoring and Logging](#4-monitoring-and-logging)
5. [Troubleshooting Guide](#5-troubleshooting-guide)
6. [Security Considerations](#6-security-considerations)
7. [Performance Optimization](#7-performance-optimization)

---

## 1. Environment Setup

### 1.1 Prerequisites

#### 1.1.1 System Requirements
- **Operating System**: Ubuntu 20.04+ / CentOS 8+ / macOS 12+
- **Node.js**: Version 18.0.0 or higher
- **npm**: Version 8.0.0 or higher
- **Git**: Version 2.30.0 or higher
- **Docker**: Version 20.10+ (optional)
- **Docker Compose**: Version 2.0+ (optional)

#### 1.1.2 Cloud Services
- **Supabase Account**: For database and authentication
- **Vercel Account**: For frontend deployment
- **GitHub Account**: For version control and CI/CD

### 1.2 Local Development Setup

#### 1.2.1 Clone Repository
```bash
# Clone the repository
git clone https://github.com/your-username/focus-hub.git
cd focus-hub

# Install dependencies
npm install
```

#### 1.2.2 Environment Variables
Create `.env.local` file in the root directory:

```bash
# Supabase Configuration
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

# AI Integration
VITE_GROQ_API_KEY=your_groq_api_key
VITE_OPENAI_API_KEY=your_openai_api_key

# Application Configuration
VITE_APP_URL=http://localhost:5173
VITE_API_URL=http://localhost:3000/api
NODE_ENV=development
```

#### 1.2.3 Database Setup
```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Initialize Supabase project
supabase init

# Start local Supabase
supabase start

# Apply migrations
supabase db push
```

#### 1.2.4 Start Development Server
```bash
# Start development server
npm run dev

# The application will be available at http://localhost:5173
```

### 1.3 Production Environment Setup

#### 1.3.1 Supabase Production Setup
1. **Create Supabase Project**:
   - Go to https://supabase.com
   - Create new project
   - Note down project URL and API keys

2. **Configure Database**:
   ```bash
   # Set production database URL
   supabase link --project-ref your-project-ref
   
   # Apply production migrations
   supabase db push
   ```

3. **Configure Authentication**:
   - Set up email templates
   - Configure OAuth providers (Google, GitHub)
   - Set up password policies

4. **Configure Storage**:
   - Set up storage buckets
   - Configure CORS policies
   - Set up file size limits

#### 1.3.2 Vercel Production Setup
1. **Connect GitHub Repository**:
   - Go to https://vercel.com
   - Import GitHub repository
   - Configure build settings

2. **Environment Variables**:
   ```bash
   # Set production environment variables
   VITE_SUPABASE_URL=your_production_supabase_url
   VITE_SUPABASE_ANON_KEY=your_production_supabase_anon_key
   VITE_GROQ_API_KEY=your_production_groq_api_key
   VITE_APP_URL=https://your-domain.vercel.app
   ```

3. **Custom Domain** (Optional):
   - Add custom domain in Vercel dashboard
   - Configure DNS records
   - Set up SSL certificate

---

## 2. Configuration Management

### 2.1 Environment Configuration

#### 2.1.1 Development Configuration
```javascript
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    host: true
  },
  build: {
    outDir: 'dist',
    sourcemap: true
  },
  define: {
    'process.env.NODE_ENV': '"development"'
  }
})
```

#### 2.1.2 Production Configuration
```javascript
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist',
    sourcemap: false,
    minify: 'terser',
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
          ui: ['@radix-ui/react-dialog', '@radix-ui/react-dropdown-menu']
        }
      }
    }
  },
  define: {
    'process.env.NODE_ENV': '"production"'
  }
})
```

### 2.2 Database Configuration

#### 2.2.1 Supabase Configuration
```typescript
// src/integrations/supabase/client.ts
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
  },
  realtime: {
    params: {
      eventsPerSecond: 10
    }
  }
})
```

#### 2.2.2 Database Connection Pooling
```sql
-- Configure connection pooling
ALTER SYSTEM SET max_connections = 100;
ALTER SYSTEM SET shared_buffers = '256MB';
ALTER SYSTEM SET effective_cache_size = '1GB';
ALTER SYSTEM SET maintenance_work_mem = '64MB';
ALTER SYSTEM SET checkpoint_completion_target = 0.9;
ALTER SYSTEM SET wal_buffers = '16MB';
ALTER SYSTEM SET default_statistics_target = 100;
```

### 2.3 Security Configuration

#### 2.3.1 CORS Configuration
```typescript
// API CORS configuration
const corsOptions = {
  origin: [
    'http://localhost:5173',
    'https://your-domain.vercel.app',
    'https://your-custom-domain.com'
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}
```

#### 2.3.2 Content Security Policy
```html
<!-- index.html -->
<meta http-equiv="Content-Security-Policy" content="
  default-src 'self';
  script-src 'self' 'unsafe-inline' 'unsafe-eval' https://vercel.live;
  style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
  font-src 'self' https://fonts.gstatic.com;
  img-src 'self' data: https: blob:;
  connect-src 'self' https://*.supabase.co https://api.groq.com;
  frame-src 'self';
">
```

---

## 3. Deployment Procedures

### 3.1 Automated Deployment (CI/CD)

#### 3.1.1 GitHub Actions Workflow
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Run linting
        run: npm run lint
      
      - name: Build application
        run: npm run build
        env:
          VITE_SUPABASE_URL: ${{ secrets.VITE_SUPABASE_URL }}
          VITE_SUPABASE_ANON_KEY: ${{ secrets.VITE_SUPABASE_ANON_KEY }}

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

#### 3.1.2 Environment Secrets
Configure the following secrets in GitHub repository:

```bash
# Required secrets
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key
VITE_SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
VITE_GROQ_API_KEY=your_groq_api_key
VERCEL_TOKEN=your_vercel_token
VERCEL_ORG_ID=your_org_id
VERCEL_PROJECT_ID=your_project_id
```

### 3.2 Manual Deployment

#### 3.2.1 Build Application
```bash
# Install dependencies
npm ci

# Run tests
npm test

# Build for production
npm run build

# The built application will be in the 'dist' directory
```

#### 3.2.2 Deploy to Vercel
```bash
# Install Vercel CLI
npm install -g vercel

# Login to Vercel
vercel login

# Deploy to production
vercel --prod
```

#### 3.2.3 Deploy to Custom Server
```bash
# Copy built files to server
scp -r dist/* user@your-server:/var/www/focus-hub/

# Configure Nginx
sudo nano /etc/nginx/sites-available/focus-hub

# Enable site
sudo ln -s /etc/nginx/sites-available/focus-hub /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx
```

### 3.3 Database Deployment

#### 3.3.1 Migration Deployment
```bash
# Apply migrations to production
supabase db push --db-url $SUPABASE_DB_URL

# Verify migration status
supabase db diff --db-url $SUPABASE_DB_URL
```

#### 3.3.2 Seed Data Deployment
```bash
# Apply seed data
supabase db reset --db-url $SUPABASE_DB_URL

# Or apply specific seed files
psql $SUPABASE_DB_URL -f supabase/seed.sql
```

---

## 4. Monitoring and Logging

### 4.1 Application Monitoring

#### 4.1.1 Vercel Analytics
```typescript
// Enable Vercel Analytics
import { Analytics } from '@vercel/analytics/react'

function App() {
  return (
    <>
      <YourApp />
      <Analytics />
    </>
  )
}
```

#### 4.1.2 Error Tracking
```typescript
// Sentry integration
import * as Sentry from '@sentry/react'

Sentry.init({
  dsn: import.meta.env.VITE_SENTRY_DSN,
  environment: import.meta.env.NODE_ENV,
  integrations: [
    new Sentry.BrowserTracing(),
    new Sentry.Replay()
  ],
  tracesSampleRate: 1.0,
  replaysSessionSampleRate: 0.1,
  replaysOnErrorSampleRate: 1.0,
})
```

### 4.2 Database Monitoring

#### 4.2.1 Supabase Dashboard
- **Real-time Metrics**: Monitor database performance
- **Query Analysis**: Identify slow queries
- **Connection Pooling**: Monitor connection usage
- **Storage Usage**: Track file storage consumption

#### 4.2.2 Custom Monitoring Queries
```sql
-- Monitor active connections
SELECT count(*) as active_connections 
FROM pg_stat_activity 
WHERE state = 'active';

-- Monitor slow queries
SELECT query, mean_time, calls, total_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Monitor table sizes
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

### 4.3 Logging Configuration

#### 4.3.1 Application Logging
```typescript
// Logger configuration
import { createLogger, format, transports } from 'winston'

const logger = createLogger({
  level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
  format: format.combine(
    format.timestamp(),
    format.errors({ stack: true }),
    format.json()
  ),
  defaultMeta: { service: 'focus-hub' },
  transports: [
    new transports.File({ filename: 'error.log', level: 'error' }),
    new transports.File({ filename: 'combined.log' })
  ]
})

if (process.env.NODE_ENV !== 'production') {
  logger.add(new transports.Console({
    format: format.simple()
  }))
}
```

#### 4.3.2 API Logging
```typescript
// API request logging middleware
import morgan from 'morgan'

const logFormat = process.env.NODE_ENV === 'production' 
  ? 'combined' 
  : 'dev'

app.use(morgan(logFormat, {
  stream: {
    write: (message) => logger.info(message.trim())
  }
}))
```

---

## 5. Troubleshooting Guide

### 5.1 Common Issues

#### 5.1.1 Build Failures
```bash
# Clear cache and reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Clear Vite cache
rm -rf node_modules/.vite

# Check for TypeScript errors
npm run type-check
```

#### 5.1.2 Database Connection Issues
```bash
# Check Supabase connection
supabase status

# Verify environment variables
echo $VITE_SUPABASE_URL
echo $VITE_SUPABASE_ANON_KEY

# Test database connection
supabase db ping
```

#### 5.1.3 Authentication Issues
```bash
# Check Supabase auth configuration
supabase auth list

# Verify OAuth providers
supabase auth providers list

# Test authentication flow
curl -X POST https://your-project.supabase.co/auth/v1/signup \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

### 5.2 Performance Issues

#### 5.2.1 Slow Page Loads
```bash
# Check bundle size
npm run build -- --analyze

# Optimize images
npm run optimize-images

# Check network requests
# Use browser DevTools Network tab
```

#### 5.2.2 Database Performance
```sql
-- Check slow queries
SELECT query, mean_time, calls, total_time
FROM pg_stat_statements
WHERE mean_time > 100
ORDER BY mean_time DESC;

-- Check index usage
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
WHERE idx_scan = 0;
```

### 5.3 Security Issues

#### 5.3.1 CORS Errors
```typescript
// Check CORS configuration
const corsOptions = {
  origin: function (origin, callback) {
    const allowedOrigins = [
      'http://localhost:5173',
      'https://your-domain.vercel.app'
    ]
    if (!origin || allowedOrigins.indexOf(origin) !== -1) {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  }
}
```

#### 5.3.2 Authentication Errors
```typescript
// Debug authentication
supabase.auth.onAuthStateChange((event, session) => {
  console.log('Auth event:', event)
  console.log('Session:', session)
})
```

---

## 6. Security Considerations

### 6.1 Environment Security

#### 6.1.1 Environment Variables
```bash
# Never commit sensitive data
echo ".env.local" >> .gitignore
echo ".env.production" >> .gitignore

# Use secure variable storage
# GitHub Secrets for CI/CD
# Vercel Environment Variables for deployment
```

#### 6.1.2 API Security
```typescript
// Rate limiting
import rateLimit from 'express-rate-limit'

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
})

app.use('/api/', limiter)
```

### 6.2 Database Security

#### 6.2.1 Row Level Security
```sql
-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- Create security policies
CREATE POLICY "Users can view public posts" ON posts
    FOR SELECT USING (is_published = true);
```

#### 6.2.2 Connection Security
```sql
-- Use SSL connections
ALTER SYSTEM SET ssl = on;
ALTER SYSTEM SET ssl_cert_file = '/path/to/server.crt';
ALTER SYSTEM SET ssl_key_file = '/path/to/server.key';
```

### 6.3 Application Security

#### 6.3.1 Input Validation
```typescript
// Validate user input
import { z } from 'zod'

const userSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  full_name: z.string().min(2).max(100)
})

const validateUser = (data: unknown) => {
  return userSchema.parse(data)
}
```

#### 6.3.2 XSS Prevention
```typescript
// Sanitize user input
import DOMPurify from 'dompurify'

const sanitizeHtml = (html: string) => {
  return DOMPurify.sanitize(html)
}
```

---

## 7. Performance Optimization

### 7.1 Frontend Optimization

#### 7.1.1 Code Splitting
```typescript
// Lazy load components
import { lazy, Suspense } from 'react'

const AdminDashboard = lazy(() => import('./pages/AdminDashboard'))
const Chat = lazy(() => import('./pages/Chat'))

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <AdminDashboard />
    </Suspense>
  )
}
```

#### 7.1.2 Image Optimization
```typescript
// Use optimized images
import { Image } from '@next/image'

function OptimizedImage({ src, alt, ...props }) {
  return (
    <Image
      src={src}
      alt={alt}
      width={400}
      height={300}
      placeholder="blur"
      blurDataURL="data:image/jpeg;base64,..."
      {...props}
    />
  )
}
```

### 7.2 Backend Optimization

#### 7.2.1 Database Optimization
```sql
-- Create indexes for frequently queried columns
CREATE INDEX idx_posts_author_created ON posts(author_id, created_at);
CREATE INDEX idx_comments_post_created ON comments(post_id, created_at);
CREATE INDEX idx_questions_category_status ON questions(category, status);

-- Use partial indexes for filtered queries
CREATE INDEX idx_posts_published ON posts(created_at) WHERE is_published = true;
```

#### 7.2.2 Caching Strategy
```typescript
// Implement caching
import { createClient } from 'redis'

const redis = createClient({
  url: process.env.REDIS_URL
})

const cacheData = async (key: string, data: any, ttl: number = 3600) => {
  await redis.setEx(key, ttl, JSON.stringify(data))
}

const getCachedData = async (key: string) => {
  const data = await redis.get(key)
  return data ? JSON.parse(data) : null
}
```

### 7.3 CDN Configuration

#### 7.3.1 Static Asset Optimization
```typescript
// Configure CDN for static assets
const cdnConfig = {
  baseURL: 'https://cdn.your-domain.com',
  assets: ['images', 'fonts', 'icons'],
  cacheControl: 'public, max-age=31536000'
}
```

#### 7.3.2 API Response Caching
```typescript
// Cache API responses
app.use('/api/posts', (req, res, next) => {
  res.set('Cache-Control', 'public, max-age=300') // 5 minutes
  next()
})
```

---

*This deployment guide provides comprehensive instructions for setting up, configuring, deploying, monitoring, and optimizing the Focus Hub platform in various environments.* 