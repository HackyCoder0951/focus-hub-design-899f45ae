-- USERS: handled by Supabase Auth (auth.users)

-- 1. PROFILES
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  location TEXT,
  website TEXT,
  settings JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. POSTS
CREATE TABLE IF NOT EXISTS public.posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  media_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);
CREATE INDEX IF NOT EXISTS idx_posts_user_id ON public.posts(user_id);

-- 3. LIKES
CREATE TABLE IF NOT EXISTS public.likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  post_id UUID REFERENCES public.posts(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, post_id)
);
CREATE INDEX IF NOT EXISTS idx_likes_post_id ON public.likes(post_id);

-- 4. FOLLOWERS
CREATE TABLE IF NOT EXISTS public.followers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  follower_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  following_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(follower_id, following_id)
);
CREATE INDEX IF NOT EXISTS idx_followers_follower_id ON public.followers(follower_id);
CREATE INDEX IF NOT EXISTS idx_followers_following_id ON public.followers(following_id);

-- 5. NOTIFICATIONS
CREATE TABLE IF NOT EXISTS public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  data JSONB,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON public.notifications(user_id);

-- 6. CHATS
CREATE TABLE IF NOT EXISTS public.chats (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  is_group BOOLEAN NOT NULL DEFAULT FALSE,
  name TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 7. CHAT_MEMBERS
CREATE TABLE IF NOT EXISTS public.chat_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_id UUID REFERENCES public.chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(chat_id, user_id)
);
CREATE INDEX IF NOT EXISTS idx_chat_members_chat_id ON public.chat_members(chat_id);
CREATE INDEX IF NOT EXISTS idx_chat_members_user_id ON public.chat_members(user_id);

-- 8. CHAT_MESSAGES
CREATE TABLE IF NOT EXISTS public.chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_id UUID REFERENCES public.chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  content TEXT,
  media_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_chat_messages_chat_id ON public.chat_messages(chat_id);

-- 9. FILEMODELS
CREATE TABLE IF NOT EXISTS public.filemodels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  file_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_type TEXT,
  file_size INTEGER,
  description TEXT,
  is_public BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_filemodels_user_id ON public.filemodels(user_id);

-- 10. QUESTIONANSWERS
CREATE TABLE IF NOT EXISTS public.questionanswers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  answer TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  is_answered BOOLEAN NOT NULL DEFAULT FALSE
);
CREATE INDEX IF NOT EXISTS idx_questionanswers_user_id ON public.questionanswers(user_id);

-- 11. QANOTIFICATIONS
CREATE TABLE IF NOT EXISTS public.qanotifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  question_id UUID REFERENCES public.questionanswers(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_qanotifications_user_id ON public.qanotifications(user_id);

-- RLS POLICIES
-- PROFILES
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);

-- POSTS
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view posts" ON public.posts FOR SELECT USING (true);
CREATE POLICY "Users can insert posts" ON public.posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own posts" ON public.posts FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete their own posts" ON public.posts FOR DELETE USING (auth.uid() = user_id);

-- LIKES
ALTER TABLE public.likes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can like posts" ON public.likes FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view likes" ON public.likes FOR SELECT USING (true);
CREATE POLICY "Users can delete their own likes" ON public.likes FOR DELETE USING (auth.uid() = user_id);

-- FOLLOWERS
ALTER TABLE public.followers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can follow/unfollow" ON public.followers FOR INSERT WITH CHECK (auth.uid() = follower_id);
CREATE POLICY "Users can view followers" ON public.followers FOR SELECT USING (true);
CREATE POLICY "Users can delete their own follows" ON public.followers FOR DELETE USING (auth.uid() = follower_id);

-- NOTIFICATIONS
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view their notifications" ON public.notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert notifications" ON public.notifications FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their notifications" ON public.notifications FOR UPDATE USING (auth.uid() = user_id);

-- CHATS
ALTER TABLE public.chats ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view chats" ON public.chats FOR SELECT USING (true);
CREATE POLICY "Users can insert chats" ON public.chats FOR INSERT WITH CHECK (true);

-- CHAT_MEMBERS
ALTER TABLE public.chat_members ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view chat members" ON public.chat_members FOR SELECT USING (true);
CREATE POLICY "Users can insert chat members" ON public.chat_members FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete themselves from chat" ON public.chat_members FOR DELETE USING (auth.uid() = user_id);

-- CHAT_MESSAGES
ALTER TABLE public.chat_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view chat messages" ON public.chat_messages FOR SELECT USING (true);
CREATE POLICY "Users can insert chat messages" ON public.chat_messages FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete their own messages" ON public.chat_messages FOR DELETE USING (auth.uid() = user_id);

-- FILEMODELS
ALTER TABLE public.filemodels ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view public files" ON public.filemodels FOR SELECT USING (is_public OR auth.uid() = user_id);
CREATE POLICY "Users can insert files" ON public.filemodels FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own files" ON public.filemodels FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete their own files" ON public.filemodels FOR DELETE USING (auth.uid() = user_id);

-- QUESTIONANSWERS
ALTER TABLE public.questionanswers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view questions" ON public.questionanswers FOR SELECT USING (true);
CREATE POLICY "Users can insert questions" ON public.questionanswers FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own questions" ON public.questionanswers FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete their own questions" ON public.questionanswers FOR DELETE USING (auth.uid() = user_id);

-- QANOTIFICATIONS
ALTER TABLE public.qanotifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view their Q&A notifications" ON public.qanotifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert Q&A notifications" ON public.qanotifications FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their Q&A notifications" ON public.qanotifications FOR UPDATE USING (auth.uid() = user_id); 