-- Enable RLS on posts table
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to insert posts (user_id must match their auth.uid)
CREATE POLICY "Authenticated users can insert posts" ON posts
FOR INSERT
WITH CHECK (auth.role() = 'authenticated' AND user_id = auth.uid());

-- Allow authenticated users to update their own posts
CREATE POLICY "Authenticated users can update own posts" ON posts
FOR UPDATE
USING (auth.role() = 'authenticated' AND user_id = auth.uid());

-- Allow authenticated users to delete their own posts
CREATE POLICY "Authenticated users can delete own posts" ON posts
FOR DELETE
USING (auth.role() = 'authenticated' AND user_id = auth.uid());

-- Allow authenticated users to select (view) all posts
CREATE POLICY "Authenticated users can view posts" ON posts
FOR SELECT
USING (auth.role() = 'authenticated'); 