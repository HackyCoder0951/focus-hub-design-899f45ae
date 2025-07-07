# Database Schema Implementation

## Overview

The Focus Hub database is built on PostgreSQL via Supabase, featuring a comprehensive schema designed for social networking, Q&A, chat, AI-powered answers, resource sharing, notifications, and moderation. The schema includes robust relationships, row-level security (RLS), triggers, and performance indexes.

## Data Types and Enums

```sql
CREATE TYPE app_role AS ENUM ('admin', 'user');
CREATE TYPE member_type_enum AS ENUM ('student', 'alumni');
```

---

### `ai_answers`
AI-generated answers to questions.
```sql
CREATE TABLE ai_answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID,
  answer_text TEXT NOT NULL,
  model_used TEXT,
  tokens_used INTEGER,
  processing_time_ms INTEGER,
  user_feedback_rating INTEGER CHECK (user_feedback_rating >= 1 AND user_feedback_rating <= 5),
  generation_attempts INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  user_id UUID,
  generated_by TEXT
);
```

### `answer_comments`
Comments on answers.
```sql
CREATE TABLE answer_comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  answer_id UUID,
  user_id UUID,
  parent_comment_id UUID,
  body TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### `answer_notifications`
Notifications for answer-related activities.
```sql
CREATE TABLE answer_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  answer_id UUID,
  user_id UUID,
  notification_type TEXT,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  related_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CHECK (notification_type IN ('comment', 'vote', 'acceptance', 'mention'))
);
```

### `answer_tags`
Tags associated with answers for categorization.
```sql
CREATE TABLE answer_tags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  answer_id UUID,
  tag_name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(answer_id, tag_name)
);
```

### `answer_votes`
Votes (upvotes/downvotes) on answers.
```sql
CREATE TABLE answer_votes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  answer_id UUID,
  user_id UUID,
  vote_value SMALLINT CHECK (vote_value IN (1, -1)),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(answer_id, user_id)
);
```

### `answers`
Answers to questions.
```sql
CREATE TABLE answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID,
  user_id UUID,
  body TEXT NOT NULL,
  is_accepted BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### `chat_members`
Members of chat groups.
```sql
CREATE TABLE chat_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_id UUID,
  user_id UUID,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  is_admin BOOLEAN DEFAULT FALSE,
  typing BOOLEAN DEFAULT FALSE,
  UNIQUE(chat_id, user_id)
);
```

### `chat_messages`
Messages in chats.
```sql
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_id UUID,
  user_id UUID,
  content TEXT,
  media_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
```

### `chats`
Chat groups and direct messages.
```sql
CREATE TABLE chats (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  is_group BOOLEAN DEFAULT FALSE NOT NULL,
  name TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  created_by UUID
);
```

### `comment_likes`
Likes on comments.
```sql
CREATE TABLE comment_likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  comment_id UUID,
  user_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  UNIQUE(comment_id, user_id)
);
```

### `comments`
Comments on posts, supporting threading.
```sql
CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID,
  user_id UUID,
  content TEXT NOT NULL,
  parent_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
```

### `content_flags`
Flags for posts or comments for moderation.
```sql
CREATE TABLE content_flags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  flagged_by_user_id UUID,
  post_id UUID,
  comment_id UUID,
  reason TEXT,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CHECK ((post_id IS NOT NULL AND comment_id IS NULL) OR (post_id IS NULL AND comment_id IS NOT NULL))
);
```

### `filemodels`
File uploads and metadata.
```sql
CREATE TABLE filemodels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  file_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_type TEXT,
  file_size INTEGER,
  description TEXT,
  is_public BOOLEAN DEFAULT FALSE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
```

### `followers`
User following relationships.
```sql
CREATE TABLE followers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  follower_id UUID,
  following_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  UNIQUE(follower_id, following_id)
);
```

### `likes`
Likes on posts.
```sql
CREATE TABLE likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID,
  user_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
  UNIQUE(post_id, user_id)
);
```

### `notifications`
General notifications for users.
```sql
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  type TEXT NOT NULL,
  data JSONB,
  is_read BOOLEAN DEFAULT FALSE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
```

### `posts`
User posts with media support and moderation status.
```sql
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  content TEXT NOT NULL,
  media_url TEXT,
  image_url TEXT,
  file_url TEXT,
  is_deleted BOOLEAN DEFAULT FALSE,
  flag_status TEXT DEFAULT 'normal',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### `profiles`
User profile information linked to Supabase Auth.
```sql
CREATE TABLE profiles (
  id UUID PRIMARY KEY,
  email TEXT NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  location TEXT,
  website TEXT,
  settings JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  member_type TEXT DEFAULT 'student',
  status TEXT DEFAULT 'active',
  last_seen TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CONSTRAINT member_type_check CHECK (member_type IN ('student', 'alumni'))
);
```

### `question_notifications`
Notifications for question-related activities.
```sql
CREATE TABLE question_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID,
  user_id UUID,
  notification_type TEXT,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  related_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CHECK (notification_type IN ('answer', 'comment', 'vote', 'best_answer'))
);
```

### `question_tags`
Tags associated with questions for categorization.
```sql
CREATE TABLE question_tags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID,
  tag_name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(question_id, tag_name)
);
```

### `question_votes`
Votes (upvotes/downvotes) on questions.
```sql
CREATE TABLE question_votes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID,
  user_id UUID,
  vote_value SMALLINT CHECK (vote_value IN (1, -1)),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(question_id, user_id)
);
```

### `questionanswers`
Main questions table for the Q&A system.
```sql
CREATE TABLE questionanswers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  question TEXT NOT NULL,
  answer TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_answered BOOLEAN DEFAULT FALSE
);
```

### `questions`
Main questions table for the Q&A system.
```sql
CREATE TABLE questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  category TEXT,
  status TEXT DEFAULT 'open',
  best_answer_id UUID,
  view_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CONSTRAINT questions_status_check CHECK (status IN ('open', 'closed', 'duplicate'))
);
```

### `reputation_events`
Tracks user reputation changes.
```sql
CREATE TABLE reputation_events (
  id SERIAL PRIMARY KEY,
  user_id UUID,
  type TEXT NOT NULL,
  value INTEGER NOT NULL,
  related_id INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### `tags`
Global tags for categorization.
```sql
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### `user_roles`
Role-based access control for admin and user permissions.
```sql
CREATE TABLE user_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  role app_role DEFAULT 'user',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, role)
);
```

### `votes`
Legacy votes table for questions and answers.
```sql
CREATE TABLE votes (
  id SERIAL PRIMARY KEY,
  user_id UUID,
  target_id INTEGER NOT NULL,
  target_type TEXT CHECK (target_type IN ('question', 'answer')),
  value SMALLINT CHECK (value IN (1, -1)),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, target_id, target_type)
);
```

## Indexes, Triggers, and Policies

- All major tables have appropriate indexes for performance (see schema file for full list).
- Row Level Security (RLS) is enabled on all major tables.
- Policies are defined for CRUD operations, admin privileges, and user-specific access.
- Triggers and functions handle real-time updates, file management, and user onboarding.

This database schema provides a robust, secure, and scalable foundation for the Focus Hub platform. 