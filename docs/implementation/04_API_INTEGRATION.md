# API Integration Implementation

## Overview

The Focus Hub API integration is built around Supabase, providing a comprehensive backend-as-a-service solution with PostgreSQL database, authentication, real-time subscriptions, and file storage.

## Supabase Client Setup

### 1. Client Configuration

**File**: `src/integrations/supabase/client.ts`
```typescript
import { createClient } from '@supabase/supabase-js';
import type { Database } from './types';

const SUPABASE_URL = "https://hfiltwodcwlqwxrwfjyp.supabase.co";
const SUPABASE_PUBLISHABLE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhmaWx0d29kY3dscXd4cndmanlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyMDM1NjUsImV4cCI6MjA2Njc3OTU2NX0.hZtaDcr5z_l0YlsMj47zO4I6zW1lEmt9QM8ZJAJMouI";

export const supabase = createClient<Database>(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);
```

### 2. TypeScript Types

**File**: `src/integrations/supabase/types.ts`
```typescript
export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          email: string
          full_name: string | null
          avatar_url: string | null
          bio: string | null
          location: string | null
          website: string | null
          member_type: string | null
          status: string | null
          last_seen: string | null
          settings: Json | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          email: string
          full_name?: string | null
          avatar_url?: string | null
          bio?: string | null
          location?: string | null
          website?: string | null
          member_type?: string | null
          status?: string | null
          last_seen?: string | null
          settings?: Json | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          full_name?: string | null
          avatar_url?: string | null
          bio?: string | null
          location?: string | null
          website?: string | null
          member_type?: string | null
          status?: string | null
          last_seen?: string | null
          settings?: Json | null
          created_at?: string
          updated_at?: string
        }
      }
      posts: {
        Row: {
          id: string
          user_id: string | null
          content: string
          media_url: string | null
          is_deleted: boolean
          flag_status: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id?: string | null
          content: string
          media_url?: string | null
          is_deleted?: boolean
          flag_status?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string | null
          content?: string
          media_url?: string | null
          is_deleted?: boolean
          flag_status?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      // Additional table types...
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      has_role: {
        Args: {
          _user_id: string
          _role: "admin" | "user"
        }
        Returns: boolean
      }
      leave_group: {
        Args: {
          p_chat_id: string
          p_user_id: string
        }
        Returns: undefined
      }
    }
    Enums: {
      app_role: "admin" | "user"
    }
  }
}
```

## API Utilities

### 1. Base API Functions

**File**: `src/lib/api.ts`
```typescript
import { supabase } from '@/integrations/supabase/client';

// Generic error handler
export const handleApiError = (error: any) => {
  console.error('API Error:', error);
  return {
    error: error.message || 'An unexpected error occurred',
    details: error
  };
};

// Generic success response
export const handleApiSuccess = (data: any) => {
  return {
    data,
    error: null
  };
};

// Type-safe API response
export type ApiResponse<T> = {
  data: T | null;
  error: string | null;
};

// Generic fetch function with error handling
export const apiFetch = async <T>(
  query: Promise<{ data: T | null; error: any }>
): Promise<ApiResponse<T>> => {
  try {
    const { data, error } = await query;
    
    if (error) {
      return handleApiError(error);
    }
    
    return handleApiSuccess(data);
  } catch (error: any) {
    return handleApiError(error);
  }
};
```

### 2. Authentication API

**File**: `src/api/auth.ts`
```typescript
import { supabase } from '@/integrations/supabase/client';
import { apiFetch, ApiResponse } from '@/lib/api';

export interface SignUpData {
  email: string;
  password: string;
  fullName: string;
  memberType: string;
}

export interface SignInData {
  email: string;
  password: string;
}

export const authApi = {
  // Sign up new user
  signUp: async (data: SignUpData): Promise<ApiResponse<any>> => {
    const redirectUrl = `${window.location.origin}/app`;
    
    return apiFetch(
      supabase.auth.signUp({
        email: data.email,
        password: data.password,
        options: {
          emailRedirectTo: redirectUrl,
          data: {
            full_name: data.fullName,
            member_type: data.memberType
          }
        }
      })
    );
  },

  // Sign in user
  signIn: async (data: SignInData): Promise<ApiResponse<any>> => {
    return apiFetch(
      supabase.auth.signInWithPassword({
        email: data.email,
        password: data.password,
      })
    );
  },

  // Sign out user
  signOut: async (): Promise<ApiResponse<any>> => {
    return apiFetch(supabase.auth.signOut());
  },

  // Get current session
  getSession: async (): Promise<ApiResponse<any>> => {
    return apiFetch(supabase.auth.getSession());
  },

  // Reset password
  resetPassword: async (email: string): Promise<ApiResponse<any>> => {
    return apiFetch(
      supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/reset-password`
      })
    );
  },

  // Update password
  updatePassword: async (password: string): Promise<ApiResponse<any>> => {
    return apiFetch(
      supabase.auth.updateUser({ password })
    );
  }
};
```

### 3. Profile API

**File**: `src/api/profile.ts`
```typescript
import { supabase } from '@/integrations/supabase/client';
import { apiFetch, ApiResponse } from '@/lib/api';

export interface Profile {
  id: string;
  email: string;
  full_name: string | null;
  avatar_url: string | null;
  bio: string | null;
  location: string | null;
  website: string | null;
  member_type: string | null;
  status: string | null;
  last_seen: string | null;
  settings: any | null;
  created_at: string;
  updated_at: string;
}

export interface UpdateProfileData {
  full_name?: string;
  bio?: string;
  location?: string;
  website?: string;
  avatar_url?: string;
}

export const profileApi = {
  // Get user profile
  getProfile: async (userId: string): Promise<ApiResponse<Profile>> => {
    return apiFetch(
      supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single()
    );
  },

  // Update user profile
  updateProfile: async (userId: string, data: UpdateProfileData): Promise<ApiResponse<Profile>> => {
    return apiFetch(
      supabase
        .from('profiles')
        .update({
          ...data,
          updated_at: new Date().toISOString()
        })
        .eq('id', userId)
        .select()
        .single()
    );
  },

  // Get profile by username or email
  searchProfiles: async (query: string): Promise<ApiResponse<Profile[]>> => {
    return apiFetch(
      supabase
        .from('profiles')
        .select('*')
        .or(`full_name.ilike.%${query}%,email.ilike.%${query}%`)
        .limit(10)
    );
  },

  // Update last seen
  updateLastSeen: async (userId: string): Promise<ApiResponse<any>> => {
    return apiFetch(
      supabase
        .from('profiles')
        .update({ last_seen: new Date().toISOString() })
        .eq('id', userId)
    );
  }
};
```

### 4. Posts API

**File**: `src/api/posts.ts`
```typescript
import { supabase } from '@/integrations/supabase/client';
import { apiFetch, ApiResponse } from '@/lib/api';

export interface Post {
  id: string;
  user_id: string;
  content: string;
  media_url: string | null;
  is_deleted: boolean;
  flag_status: string | null;
  created_at: string;
  updated_at: string;
  profiles?: {
    full_name: string;
    avatar_url: string | null;
  };
  likes?: { id: string }[];
  comments?: { id: string }[];
}

export interface CreatePostData {
  content: string;
  media_url?: string;
}

export const postsApi = {
  // Get all posts
  getPosts: async (limit = 20, offset = 0): Promise<ApiResponse<Post[]>> => {
    return apiFetch(
      supabase
        .from('posts')
        .select(`
          *,
          profiles (full_name, avatar_url),
          likes (id),
          comments (id)
        `)
        .eq('is_deleted', false)
        .order('created_at', { ascending: false })
        .range(offset, offset + limit - 1)
    );
  },

  // Get user posts
  getUserPosts: async (userId: string, limit = 20, offset = 0): Promise<ApiResponse<Post[]>> => {
    return apiFetch(
      supabase
        .from('posts')
        .select(`
          *,
          profiles (full_name, avatar_url),
          likes (id),
          comments (id)
        `)
        .eq('user_id', userId)
        .eq('is_deleted', false)
        .order('created_at', { ascending: false })
        .range(offset, offset + limit - 1)
    );
  },

  // Create new post
  createPost: async (data: CreatePostData): Promise<ApiResponse<Post>> => {
    return apiFetch(
      supabase
        .from('posts')
        .insert([data])
        .select(`
          *,
          profiles (full_name, avatar_url)
        `)
        .single()
    );
  },

  // Update post
  updatePost: async (postId: string, data: Partial<CreatePostData>): Promise<ApiResponse<Post>> => {
    return apiFetch(
      supabase
        .from('posts')
        .update({
          ...data,
          updated_at: new Date().toISOString()
        })
        .eq('id', postId)
        .select()
        .single()
    );
  },

  // Delete post (soft delete)
  deletePost: async (postId: string): Promise<ApiResponse<any>> => {
    return apiFetch(
      supabase
        .from('posts')
        .update({ is_deleted: true })
        .eq('id', postId)
    );
  },

  // Like/unlike post
  toggleLike: async (postId: string, userId: string): Promise<ApiResponse<any>> => {
    // Check if already liked
    const { data: existingLike } = await supabase
      .from('likes')
      .select('id')
      .eq('post_id', postId)
      .eq('user_id', userId)
      .single();

    if (existingLike) {
      // Unlike
      return apiFetch(
        supabase
          .from('likes')
          .delete()
          .eq('post_id', postId)
          .eq('user_id', userId)
      );
    } else {
      // Like
      return apiFetch(
        supabase
          .from('likes')
          .insert({ post_id: postId, user_id: userId })
      );
    }
  }
};
```

### 5. Comments API

**File**: `src/api/comments.ts`
```typescript
import { supabase } from '@/integrations/supabase/client';
import { apiFetch, ApiResponse } from '@/lib/api';

export interface Comment {
  id: string;
  post_id: string;
  user_id: string;
  content: string;
  parent_id: string | null;
  created_at: string;
  profiles?: {
    full_name: string;
    avatar_url: string | null;
  };
  comment_likes?: { id: string }[];
}

export interface CreateCommentData {
  post_id: string;
  content: string;
  parent_id?: string;
}

export const commentsApi = {
  // Get comments for a post
  getComments: async (postId: string): Promise<ApiResponse<Comment[]>> => {
    return apiFetch(
      supabase
        .from('comments')
        .select(`
          *,
          profiles (full_name, avatar_url),
          comment_likes (id)
        `)
        .eq('post_id', postId)
        .order('created_at', { ascending: true })
    );
  },

  // Create new comment
  createComment: async (data: CreateCommentData): Promise<ApiResponse<Comment>> => {
    return apiFetch(
      supabase
        .from('comments')
        .insert([data])
        .select(`
          *,
          profiles (full_name, avatar_url)
        `)
        .single()
    );
  },

  // Delete comment
  deleteComment: async (commentId: string): Promise<ApiResponse<any>> => {
    return apiFetch(
      supabase
        .from('comments')
        .delete()
        .eq('id', commentId)
    );
  },

  // Like/unlike comment
  toggleCommentLike: async (commentId: string, userId: string): Promise<ApiResponse<any>> => {
    // Check if already liked
    const { data: existingLike } = await supabase
      .from('comment_likes')
      .select('id')
      .eq('comment_id', commentId)
      .eq('user_id', userId)
      .single();

    if (existingLike) {
      // Unlike
      return apiFetch(
        supabase
          .from('comment_likes')
          .delete()
          .eq('comment_id', commentId)
          .eq('user_id', userId)
      );
    } else {
      // Like
      return apiFetch(
        supabase
          .from('comment_likes')
          .insert({ comment_id: commentId, user_id: userId })
      );
    }
  }
};
```

### 6. File Upload API

**File**: `src/api/files.ts`
```typescript
import { supabase } from '@/integrations/supabase/client';
import { apiFetch, ApiResponse } from '@/lib/api';

export interface FileModel {
  id: string;
  user_id: string;
  file_name: string;
  file_url: string;
  file_type: string | null;
  file_size: number | null;
  description: string | null;
  is_public: boolean;
  created_at: string;
}

export interface UploadFileData {
  file: File;
  description?: string;
  isPublic?: boolean;
}

export const filesApi = {
  // Upload file to storage
  uploadFile: async (data: UploadFileData): Promise<ApiResponse<FileModel>> => {
    const fileExt = data.file.name.split('.').pop();
    const fileName = `${Date.now()}-${Math.random().toString(36).substring(2)}.${fileExt}`;
    const filePath = `uploads/${fileName}`;

    // Upload to storage
    const { error: uploadError } = await supabase.storage
      .from('uploads')
      .upload(filePath, data.file);

    if (uploadError) {
      return { data: null, error: uploadError.message };
    }

    // Get public URL
    const { data: { publicUrl } } = supabase.storage
      .from('uploads')
      .getPublicUrl(filePath);

    // Save file record to database
    return apiFetch(
      supabase
        .from('filemodels')
        .insert([{
          file_name: data.file.name,
          file_url: publicUrl,
          file_type: data.file.type,
          file_size: data.file.size,
          description: data.description,
          is_public: data.isPublic || false
        }])
        .select()
        .single()
    );
  },

  // Get user files
  getUserFiles: async (userId: string): Promise<ApiResponse<FileModel[]>> => {
    return apiFetch(
      supabase
        .from('filemodels')
        .select('*')
        .eq('user_id', userId)
        .order('created_at', { ascending: false })
    );
  },

  // Get public files
  getPublicFiles: async (): Promise<ApiResponse<FileModel[]>> => {
    return apiFetch(
      supabase
        .from('filemodels')
        .select('*')
        .eq('is_public', true)
        .order('created_at', { ascending: false })
    );
  },

  // Delete file
  deleteFile: async (fileId: string): Promise<ApiResponse<any>> => {
    return apiFetch(
      supabase
        .from('filemodels')
        .delete()
        .eq('id', fileId)
    );
  }
};
```

## Real-time Subscriptions

### 1. Posts Subscription

```typescript
export const subscribeToPosts = (callback: (payload: any) => void) => {
  return supabase
    .channel('posts')
    .on('postgres_changes', 
      { event: '*', schema: 'public', table: 'posts' },
      callback
    )
    .subscribe();
};
```

### 2. Chat Messages Subscription

```typescript
export const subscribeToChatMessages = (chatId: string, callback: (payload: any) => void) => {
  return supabase
    .channel(`chat:${chatId}`)
    .on('postgres_changes', 
      { 
        event: '*', 
        schema: 'public', 
        table: 'chat_messages',
        filter: `chat_id=eq.${chatId}`
      },
      callback
    )
    .subscribe();
};
```

### 3. Notifications Subscription

```typescript
export const subscribeToNotifications = (userId: string, callback: (payload: any) => void) => {
  return supabase
    .channel(`notifications:${userId}`)
    .on('postgres_changes', 
      { 
        event: '*', 
        schema: 'public', 
        table: 'notifications',
        filter: `user_id=eq.${userId}`
      },
      callback
    )
    .subscribe();
};
```

## Error Handling

### 1. Global Error Handler

```typescript
export const handleSupabaseError = (error: any) => {
  if (error.code === 'PGRST116') {
    return { error: 'Record not found' };
  }
  
  if (error.code === '23505') {
    return { error: 'Duplicate entry' };
  }
  
  if (error.code === '42501') {
    return { error: 'Access denied' };
  }
  
  return { error: error.message || 'An unexpected error occurred' };
};
```

### 2. Network Error Handler

```typescript
export const handleNetworkError = (error: any) => {
  if (error.code === 'NETWORK_ERROR') {
    return { error: 'Network connection error. Please check your internet connection.' };
  }
  
  if (error.code === 'TIMEOUT') {
    return { error: 'Request timeout. Please try again.' };
  }
  
  return { error: error.message };
};
```

## API Hooks

### 1. Custom Hook for Posts

```typescript
import { useState, useEffect } from 'react';
import { postsApi, Post } from '@/api/posts';

export const usePosts = (limit = 20) => {
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [hasMore, setHasMore] = useState(true);
  const [offset, setOffset] = useState(0);

  const fetchPosts = async (reset = false) => {
    try {
      setLoading(true);
      const currentOffset = reset ? 0 : offset;
      
      const { data, error } = await postsApi.getPosts(limit, currentOffset);
      
      if (error) {
        setError(error);
        return;
      }
      
      if (data) {
        if (reset) {
          setPosts(data);
        } else {
          setPosts(prev => [...prev, ...data]);
        }
        
        setHasMore(data.length === limit);
        setOffset(currentOffset + data.length);
      }
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const refresh = () => {
    setOffset(0);
    fetchPosts(true);
  };

  const loadMore = () => {
    if (!loading && hasMore) {
      fetchPosts();
    }
  };

  useEffect(() => {
    fetchPosts(true);
  }, []);

  return {
    posts,
    loading,
    error,
    hasMore,
    refresh,
    loadMore
  };
};
```

This API integration provides a comprehensive, type-safe interface to the Supabase backend with proper error handling, real-time subscriptions, and custom hooks for easy consumption in React components. 