-- Remove authentication requirement for AI answers
-- Drop existing policies
DROP POLICY IF EXISTS "Authenticated users can create AI answers" ON ai_answers;
DROP POLICY IF EXISTS "Users can update their own AI answers" ON ai_answers;
DROP POLICY IF EXISTS "Users can delete their own AI answers" ON ai_answers;

-- Create new policies that allow anonymous access
-- Anyone can create AI answers (no authentication required)
CREATE POLICY "Anyone can create AI answers" ON ai_answers
    FOR INSERT WITH CHECK (true);

-- Anyone can update AI answers (no authentication required)
CREATE POLICY "Anyone can update AI answers" ON ai_answers
    FOR UPDATE USING (true);

-- Anyone can delete AI answers (no authentication required)
CREATE POLICY "Anyone can delete AI answers" ON ai_answers
    FOR DELETE USING (true);

-- The SELECT policy already allows anyone to read AI answers
-- "Anyone can read AI answers" policy remains unchanged 