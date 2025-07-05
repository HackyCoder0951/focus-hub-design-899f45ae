# Database Schema Implementation

## Overview

The Focus Hub database is built on PostgreSQL via Supabase, featuring a comprehensive schema designed for social networking, Q&A, chat, and resource sharing functionality.

## Core Tables

### 1. User Management Tables

#### `profiles` Table
```sql
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  location TEXT,
  website TEXT,
  member_type member_type_enum DEFAULT 'student',
  status TEXT DEFAULT 'active',
  last_seen TIMESTAMP WITH TIME ZONE,
  settings JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### `user_roles` Table
```sql
CREATE TABLE user_roles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  role app_role DEFAULT 'user',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 2. Social Feed Tables

#### `posts` Table
```sql
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  media_url TEXT,
  is_deleted BOOLEAN DEFAULT FALSE,
  flag_status TEXT DEFAULT 'clean',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### `comments` Table
```sql
CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  parent_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### `likes` Table
```sql
CREATE TABLE likes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(post_id, user_id)
);
```

#### `comment_likes` Table
```sql
CREATE TABLE comment_likes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(comment_id, user_id)
);
```

### 3. Q&A Module Tables

#### `questionanswers` Table
```sql
CREATE TABLE questionanswers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  answer TEXT,
  is_answered BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### `answers` Table
```sql
CREATE TABLE answers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question_id UUID REFERENCES questionanswers(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  answer TEXT NOT NULL,
  is_accepted BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### `question_votes` Table
```sql
CREATE TABLE question_votes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question_id UUID REFERENCES questionanswers(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  vote_type INTEGER CHECK (vote_type IN (-1, 0, 1)),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(question_id, user_id)
);
```

#### `answer_votes` Table
```sql
CREATE TABLE answer_votes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  answer_id UUID REFERENCES answers(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  vote_type INTEGER CHECK (vote_type IN (-1, 0, 1)),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(answer_id, user_id)
);
```

#### `ai_answers` Table
```sql
CREATE TABLE ai_answers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question_id UUID REFERENCES questionanswers(id) ON DELETE CASCADE,
  answer TEXT NOT NULL,
  generated_by TEXT NOT NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 4. Chat System Tables

#### `chats` Table
```sql
CREATE TABLE chats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT,
  is_group BOOLEAN DEFAULT FALSE,
  created_by UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### `chat_members` Table
```sql
CREATE TABLE chat_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  chat_id UUID REFERENCES chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  is_admin BOOLEAN DEFAULT FALSE,
  typing BOOLEAN DEFAULT FALSE,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(chat_id, user_id)
);
```

#### `chat_messages` Table
```sql
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  chat_id UUID REFERENCES chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT,
  media_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 5. Resource Sharing Tables

#### `filemodels` Table
```sql
CREATE TABLE filemodels (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  file_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_type TEXT,
  file_size INTEGER,
  description TEXT,
  is_public BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 6. Social Features Tables

#### `followers` Table
```sql
CREATE TABLE followers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  follower_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  following_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(follower_id, following_id)
);
```

### 7. Notification Tables

#### `notifications` Table
```sql
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  data JSONB,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### `qanotifications` Table
```sql
CREATE TABLE qanotifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  question_id UUID REFERENCES questionanswers(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 8. Moderation Tables

#### `content_flags` Table
```sql
CREATE TABLE content_flags (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  flagged_by_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  reason TEXT,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Database Functions

### User Management Functions

#### `handle_new_user()` - Trigger Function
```sql
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, member_type, status)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'member_type',
    'active'
  );
  INSERT INTO public.user_roles (user_id, role)
  VALUES (new.id, 'user');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

#### `has_role()` - Role Check Function
```sql
CREATE OR REPLACE FUNCTION has_role(_user_id UUID, _role app_role)
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
  )
$$ LANGUAGE sql STABLE SECURITY DEFINER;
```

### Chat Functions

#### `leave_group()` - Group Management
```sql
CREATE OR REPLACE FUNCTION leave_group(p_chat_id UUID, p_user_id UUID)
RETURNS VOID AS $$
DECLARE
  admin_count INTEGER;
  member_count INTEGER;
  new_admin_id UUID;
BEGIN
  -- Remove user from chat_members
  DELETE FROM chat_members WHERE chat_id = p_chat_id AND user_id = p_user_id;

  -- Check remaining admins
  SELECT COUNT(*) INTO admin_count FROM chat_members WHERE chat_id = p_chat_id AND is_admin = true;
  
  IF admin_count = 0 THEN
    -- Promote earliest member to admin
    SELECT user_id INTO new_admin_id FROM chat_members WHERE chat_id = p_chat_id ORDER BY joined_at ASC LIMIT 1;
    IF new_admin_id IS NOT NULL THEN
      UPDATE chat_members SET is_admin = true WHERE chat_id = p_chat_id AND user_id = new_admin_id;
    END IF;
  END IF;

  -- Check remaining members
  SELECT COUNT(*) INTO member_count FROM chat_members WHERE chat_id = p_chat_id;
  IF member_count = 0 THEN
    -- Delete chat if no members remain
    DELETE FROM chat_messages WHERE chat_id = p_chat_id;
    DELETE FROM chats WHERE id = p_chat_id;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### File Management Functions

#### `handle_file_deletion()` - File Cleanup
```sql
CREATE OR REPLACE FUNCTION handle_file_deletion()
RETURNS TRIGGER AS $$
BEGIN
  DECLARE
    file_path TEXT;
  BEGIN
    file_path := REPLACE(OLD.file_url, 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/', '');
    
    DELETE FROM storage.objects 
    WHERE bucket_id = 'uploads' 
    AND name = file_path;
    
    RETURN OLD;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'Failed to delete file from storage: %', SQLERRM;
      RETURN OLD;
  END;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

## Row Level Security (RLS) Policies

### Profiles Table Policies
```sql
-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Users can view all profiles
CREATE POLICY "Profiles are viewable by everyone" ON profiles
  FOR SELECT USING (true);

-- Users can update their own profile
CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

-- Users can insert their own profile
CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);
```

### Posts Table Policies
```sql
-- Enable RLS
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Users can view non-deleted posts
CREATE POLICY "Posts are viewable by everyone" ON posts
  FOR SELECT USING (is_deleted = false);

-- Users can create posts
CREATE POLICY "Users can create posts" ON posts
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Users can update their own posts
CREATE POLICY "Users can update own posts" ON posts
  FOR UPDATE USING (auth.uid() = user_id);

-- Users can delete their own posts
CREATE POLICY "Users can delete own posts" ON posts
  FOR DELETE USING (auth.uid() = user_id);
```

### Chat Tables Policies
```sql
-- Chats table
ALTER TABLE chats ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view chats they're members of" ON chats
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM chat_members 
      WHERE chat_id = chats.id AND user_id = auth.uid()
    )
  );

-- Chat members table
ALTER TABLE chat_members ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view chat members" ON chat_members
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM chat_members cm 
      WHERE cm.chat_id = chat_members.chat_id AND cm.user_id = auth.uid()
    )
  );

-- Chat messages table
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view messages in their chats" ON chat_messages
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM chat_members 
      WHERE chat_id = chat_messages.chat_id AND user_id = auth.uid()
    )
  );
```

## Indexes for Performance

```sql
-- Posts indexes
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at DESC);
CREATE INDEX idx_posts_is_deleted ON posts(is_deleted);

-- Comments indexes
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
CREATE INDEX idx_comments_parent_id ON comments(parent_id);

-- Chat indexes
CREATE INDEX idx_chat_members_chat_id ON chat_members(chat_id);
CREATE INDEX idx_chat_members_user_id ON chat_members(user_id);
CREATE INDEX idx_chat_messages_chat_id ON chat_messages(chat_id);
CREATE INDEX idx_chat_messages_created_at ON chat_messages(created_at DESC);

-- Q&A indexes
CREATE INDEX idx_questionanswers_user_id ON questionanswers(user_id);
CREATE INDEX idx_questionanswers_is_answered ON questionanswers(is_answered);
CREATE INDEX idx_answers_question_id ON answers(question_id);

-- Followers indexes
CREATE INDEX idx_followers_follower_id ON followers(follower_id);
CREATE INDEX idx_followers_following_id ON followers(following_id);

-- Notifications indexes
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
```

## Data Types and Enums

```sql
-- User roles
CREATE TYPE app_role AS ENUM ('admin', 'user');

-- Member types
CREATE TYPE member_type_enum AS ENUM ('student', 'alumni');
```

## Triggers

```sql
-- Auto-create profile on user signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Auto-delete files from storage
CREATE TRIGGER on_file_deletion
  AFTER DELETE ON filemodels
  FOR EACH ROW EXECUTE FUNCTION handle_file_deletion();

-- Auto-update files in storage
CREATE TRIGGER on_file_update
  AFTER UPDATE ON filemodels
  FOR EACH ROW EXECUTE FUNCTION handle_file_update();
```

This database schema provides a robust foundation for the Focus Hub platform, with proper relationships, security policies, and performance optimizations. 