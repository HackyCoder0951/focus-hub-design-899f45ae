-- Complete Q&A Module Schema Migration
-- This migration creates all necessary tables for the Q&A system
-- Assumes users are managed by Supabase Auth (auth.users)

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Questions Table
CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    category TEXT,
    status TEXT DEFAULT 'open' CHECK (status IN ('open', 'closed', 'duplicate')),
    best_answer_id INTEGER, -- Will be set by trigger or application logic
    view_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Question Tags Table (Normalized tags)
CREATE TABLE IF NOT EXISTS question_tags (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
    tag_name TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(question_id, tag_name)
);

-- 3. Question Votes Table
CREATE TABLE IF NOT EXISTS question_votes (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    vote_value SMALLINT CHECK (vote_value IN (1, -1)), -- 1 for upvote, -1 for downvote
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(question_id, user_id)
);

-- 4. Question Notifications Table
CREATE TABLE IF NOT EXISTS question_notifications (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    notification_type TEXT CHECK (notification_type IN ('answer', 'comment', 'vote', 'best_answer')),
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    related_id INTEGER, -- ID of related answer, comment, etc.
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Answers Table
CREATE TABLE IF NOT EXISTS answers (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    body TEXT NOT NULL,
    is_accepted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. AI Answer Table
CREATE TABLE IF NOT EXISTS ai_answers (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
    answer_text TEXT NOT NULL,
    confidence_score DECIMAL(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
    model_used TEXT,
    tokens_used INTEGER,
    processing_time_ms INTEGER,
    relevance_score DECIMAL(3,2),
    completeness_score DECIMAL(3,2),
    user_feedback_rating INTEGER CHECK (user_feedback_rating BETWEEN 1 AND 5),
    generation_attempts INTEGER DEFAULT 1,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. Answer Comments Table
CREATE TABLE IF NOT EXISTS answer_comments (
    id SERIAL PRIMARY KEY,
    answer_id INTEGER REFERENCES answers(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    parent_comment_id INTEGER REFERENCES answer_comments(id) ON DELETE CASCADE,
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. Answer Votes Table
CREATE TABLE IF NOT EXISTS answer_votes (
    id SERIAL PRIMARY KEY,
    answer_id INTEGER REFERENCES answers(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    vote_value SMALLINT CHECK (vote_value IN (1, -1)), -- 1 for upvote, -1 for downvote
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(answer_id, user_id)
);

-- 9. Answer Notifications Table
CREATE TABLE IF NOT EXISTS answer_notifications (
    id SERIAL PRIMARY KEY,
    answer_id INTEGER REFERENCES answers(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    notification_type TEXT CHECK (notification_type IN ('comment', 'vote', 'acceptance', 'mention')),
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    related_id INTEGER, -- ID of related comment, vote, etc.
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 10. Answer Tags Table
CREATE TABLE IF NOT EXISTS answer_tags (
    id SERIAL PRIMARY KEY,
    answer_id INTEGER REFERENCES answers(id) ON DELETE CASCADE,
    tag_name TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(answer_id, tag_name)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_questions_user_id ON questions(user_id);
CREATE INDEX IF NOT EXISTS idx_questions_category ON questions(category);
CREATE INDEX IF NOT EXISTS idx_questions_status ON questions(status);
CREATE INDEX IF NOT EXISTS idx_questions_created_at ON questions(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_questions_title_gin ON questions USING gin(to_tsvector('english', title));
CREATE INDEX IF NOT EXISTS idx_questions_body_gin ON questions USING gin(to_tsvector('english', body));

CREATE INDEX IF NOT EXISTS idx_question_tags_question_id ON question_tags(question_id);
CREATE INDEX IF NOT EXISTS idx_question_tags_tag_name ON question_tags(tag_name);

CREATE INDEX IF NOT EXISTS idx_question_votes_question_id ON question_votes(question_id);
CREATE INDEX IF NOT EXISTS idx_question_votes_user_id ON question_votes(user_id);

CREATE INDEX IF NOT EXISTS idx_question_notifications_user_id ON question_notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_question_notifications_question_id ON question_notifications(question_id);
CREATE INDEX IF NOT EXISTS idx_question_notifications_is_read ON question_notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_question_notifications_created_at ON question_notifications(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_answers_question_id ON answers(question_id);
CREATE INDEX IF NOT EXISTS idx_answers_user_id ON answers(user_id);
CREATE INDEX IF NOT EXISTS idx_answers_is_accepted ON answers(is_accepted);
CREATE INDEX IF NOT EXISTS idx_answers_created_at ON answers(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_ai_answers_question_id ON ai_answers(question_id);
CREATE INDEX IF NOT EXISTS idx_ai_answers_confidence_score ON ai_answers(confidence_score DESC);

CREATE INDEX IF NOT EXISTS idx_answer_comments_answer_id ON answer_comments(answer_id);
CREATE INDEX IF NOT EXISTS idx_answer_comments_user_id ON answer_comments(user_id);
CREATE INDEX IF NOT EXISTS idx_answer_comments_parent_comment_id ON answer_comments(parent_comment_id);

CREATE INDEX IF NOT EXISTS idx_answer_votes_answer_id ON answer_votes(answer_id);
CREATE INDEX IF NOT EXISTS idx_answer_votes_user_id ON answer_votes(user_id);

CREATE INDEX IF NOT EXISTS idx_answer_notifications_answer_id ON answer_notifications(answer_id);
CREATE INDEX IF NOT EXISTS idx_answer_notifications_user_id ON answer_notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_answer_notifications_is_read ON answer_notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_answer_notifications_created_at ON answer_notifications(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_answer_tags_answer_id ON answer_tags(answer_id);
CREATE INDEX IF NOT EXISTS idx_answer_tags_tag_name ON answer_tags(tag_name);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_questions_updated_at BEFORE UPDATE ON questions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_question_votes_updated_at BEFORE UPDATE ON question_votes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_answers_updated_at BEFORE UPDATE ON answers
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_answer_comments_updated_at BEFORE UPDATE ON answer_comments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_answer_votes_updated_at BEFORE UPDATE ON answer_votes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to update question's best_answer_id when an answer is accepted
CREATE OR REPLACE FUNCTION update_best_answer()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.is_accepted = TRUE THEN
        -- Set this answer as the best answer for the question
        UPDATE questions 
        SET best_answer_id = NEW.id 
        WHERE id = NEW.question_id;
    ELSIF OLD.is_accepted = TRUE AND NEW.is_accepted = FALSE THEN
        -- Remove best answer if answer is unaccepted
        UPDATE questions 
        SET best_answer_id = NULL 
        WHERE id = NEW.question_id AND best_answer_id = NEW.id;
    END IF;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger for updating best answer
CREATE TRIGGER update_best_answer_trigger
    AFTER UPDATE ON answers
    FOR EACH ROW
    EXECUTE FUNCTION update_best_answer();

-- Function to increment view count
CREATE OR REPLACE FUNCTION increment_question_views()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE questions 
    SET view_count = view_count + 1 
    WHERE id = NEW.question_id;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Enable Row Level Security (RLS)
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE answer_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE answer_votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE answer_notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE answer_tags ENABLE ROW LEVEL SECURITY;

-- RLS Policies for questions
CREATE POLICY "Authenticated users can select questions" ON questions
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can insert questions" ON questions
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update questions" ON questions
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can delete questions" ON questions
    FOR DELETE USING (auth.role() = 'authenticated');

-- RLS Policies for question_tags
CREATE POLICY "Question tags are viewable by everyone" ON question_tags
    FOR SELECT USING (true);

CREATE POLICY "Question owners can manage tags" ON question_tags
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM questions 
            WHERE questions.id = question_tags.question_id 
            AND questions.user_id = auth.uid()
        )
    );

-- RLS Policies for question_votes
CREATE POLICY "Question votes are viewable by everyone" ON question_votes
    FOR SELECT USING (true);

CREATE POLICY "Users can vote on questions" ON question_votes
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own votes" ON question_votes
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own votes" ON question_votes
    FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for question_notifications
CREATE POLICY "Users can view their own notifications" ON question_notifications
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "System can insert notifications" ON question_notifications
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update their own notifications" ON question_notifications
    FOR UPDATE USING (auth.uid() = user_id);

-- RLS Policies for answers
CREATE POLICY "Authenticated users can select answers" ON answers
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can insert answers" ON answers
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update answers" ON answers
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can delete answers" ON answers
    FOR DELETE USING (auth.role() = 'authenticated');

-- RLS Policies for ai_answers
CREATE POLICY "AI can select ai_answers" ON ai_answers
    FOR SELECT USING (true);

CREATE POLICY "AI can insert ai_answers" ON ai_answers
    FOR INSERT WITH CHECK (true);

CREATE POLICY "AI can update ai_answers" ON ai_answers
    FOR UPDATE USING (true);

-- RLS Policies for answer_tags
CREATE POLICY "AI can select answer_tags" ON answer_tags
    FOR SELECT USING (true);

CREATE POLICY "AI can insert answer_tags" ON answer_tags
    FOR INSERT WITH CHECK (true);

CREATE POLICY "AI can update answer_tags" ON answer_tags
    FOR UPDATE USING (true);

CREATE POLICY "AI can delete answer_tags" ON answer_tags
    FOR DELETE USING (true);

-- RLS Policies for answer_comments
CREATE POLICY "Answer comments are viewable by everyone" ON answer_comments
    FOR SELECT USING (true);

CREATE POLICY "Users can insert their own comments" ON answer_comments
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own comments" ON answer_comments
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own comments" ON answer_comments
    FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for answer_votes
CREATE POLICY "Answer votes are viewable by everyone" ON answer_votes
    FOR SELECT USING (true);

CREATE POLICY "Users can vote on answers" ON answer_votes
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own votes" ON answer_votes
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own votes" ON answer_votes
    FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for answer_notifications
CREATE POLICY "Users can view their own answer notifications" ON answer_notifications
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "System can insert answer notifications" ON answer_notifications
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update their own answer notifications" ON answer_notifications
    FOR UPDATE USING (auth.uid() = user_id);

-- Grant necessary permissions
GRANT ALL ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO authenticated;

-- Create some helpful views
CREATE OR REPLACE VIEW question_stats AS
SELECT 
    q.id,
    q.title,
    q.view_count,
    COUNT(DISTINCT a.id) as answer_count,
    COUNT(DISTINCT qv.id) as vote_count,
    SUM(CASE WHEN qv.vote_value = 1 THEN 1 ELSE 0 END) - SUM(CASE WHEN qv.vote_value = -1 THEN 1 ELSE 0 END) as vote_score
FROM questions q
LEFT JOIN answers a ON q.id = a.question_id
LEFT JOIN question_votes qv ON q.id = qv.question_id
GROUP BY q.id, q.title, q.view_count;

-- Comments
COMMENT ON TABLE questions IS 'Main questions table for the Q&A system';
COMMENT ON TABLE question_tags IS 'Tags associated with questions for categorization';
COMMENT ON TABLE question_votes IS 'Votes (upvotes/downvotes) on questions';
COMMENT ON TABLE question_notifications IS 'Notifications for question-related activities';
COMMENT ON TABLE answers IS 'Answers to questions';
COMMENT ON TABLE ai_answers IS 'AI-generated answers to questions';
COMMENT ON TABLE answer_comments IS 'Comments on answers';
COMMENT ON TABLE answer_votes IS 'Votes (upvotes/downvotes) on answers';
COMMENT ON TABLE answer_notifications IS 'Notifications for answer-related activities';
COMMENT ON TABLE answer_tags IS 'Tags associated with answers for categorization'; 