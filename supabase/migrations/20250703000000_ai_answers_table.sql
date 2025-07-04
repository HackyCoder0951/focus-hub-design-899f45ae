-- Create ai_answers table
CREATE TABLE IF NOT EXISTS ai_answers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    question_id UUID NOT NULL REFERENCES questionanswers(id) ON DELETE CASCADE,
    answer TEXT NOT NULL,
    generated_by TEXT NOT NULL DEFAULT 'openai',
    user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_ai_answers_question_id ON ai_answers(question_id);
CREATE INDEX IF NOT EXISTS idx_ai_answers_created_at ON ai_answers(created_at);

-- Enable RLS
ALTER TABLE ai_answers ENABLE ROW LEVEL SECURITY;

-- RLS Policies
-- Anyone can read AI answers
CREATE POLICY "Anyone can read AI answers" ON ai_answers
    FOR SELECT USING (true);

-- Only authenticated users can create AI answers
CREATE POLICY "Authenticated users can create AI answers" ON ai_answers
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Only the user who created the AI answer can update/delete it
CREATE POLICY "Users can update their own AI answers" ON ai_answers
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own AI answers" ON ai_answers
    FOR DELETE USING (auth.uid() = user_id);

-- Add trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_ai_answers_updated_at 
    BEFORE UPDATE ON ai_answers 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column(); 