-- Real-time Features Migration
-- This migration adds real-time functionality for notifications, votes, and comments

-- Enable realtime for all relevant tables
ALTER PUBLICATION supabase_realtime ADD TABLE questions;
ALTER PUBLICATION supabase_realtime ADD TABLE answers;
ALTER PUBLICATION supabase_realtime ADD TABLE question_votes;
ALTER PUBLICATION supabase_realtime ADD TABLE answer_votes;
ALTER PUBLICATION supabase_realtime ADD TABLE answer_comments;
ALTER PUBLICATION supabase_realtime ADD TABLE question_notifications;
ALTER PUBLICATION supabase_realtime ADD TABLE answer_notifications;

-- Function to broadcast vote count updates
CREATE OR REPLACE FUNCTION broadcast_vote_update()
RETURNS TRIGGER AS $$
DECLARE
    vote_count INTEGER;
    vote_score INTEGER;
    target_type TEXT;
    target_id INTEGER;
BEGIN
    -- Determine if this is a question or answer vote
    IF TG_TABLE_NAME = 'question_votes' THEN
        target_type := 'question';
        target_id := NEW.question_id;
        
        -- Calculate vote count and score for question
        SELECT 
            COUNT(*),
            COALESCE(SUM(vote_value), 0)
        INTO vote_count, vote_score
        FROM question_votes 
        WHERE question_id = NEW.question_id;
        
        -- Update question view_count (we'll use this for vote count)
        UPDATE questions 
        SET view_count = vote_count 
        WHERE id = NEW.question_id;
        
    ELSIF TG_TABLE_NAME = 'answer_votes' THEN
        target_type := 'answer';
        target_id := NEW.answer_id;
        
        -- Calculate vote count and score for answer
        SELECT 
            COUNT(*),
            COALESCE(SUM(vote_value), 0)
        INTO vote_count, vote_score
        FROM answer_votes 
        WHERE answer_id = NEW.answer_id;
    END IF;
    
    -- Broadcast the update via realtime
    PERFORM pg_notify(
        'vote_update',
        json_build_object(
            'target_type', target_type,
            'target_id', target_id,
            'vote_count', vote_count,
            'vote_score', vote_score,
            'user_id', NEW.user_id,
            'vote_value', NEW.vote_value
        )::text
    );
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to broadcast comment updates
CREATE OR REPLACE FUNCTION broadcast_comment_update()
RETURNS TRIGGER AS $$
DECLARE
    comment_data JSONB;
BEGIN
    -- Build comment data
    comment_data := json_build_object(
        'id', NEW.id,
        'answer_id', NEW.answer_id,
        'user_id', NEW.user_id,
        'body', NEW.body,
        'parent_comment_id', NEW.parent_comment_id,
        'created_at', NEW.created_at,
        'action', TG_OP
    );
    
    -- Broadcast the comment update
    PERFORM pg_notify(
        'comment_update',
        comment_data::text
    );
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to broadcast notification updates
CREATE OR REPLACE FUNCTION broadcast_notification_update()
RETURNS TRIGGER AS $$
DECLARE
    notification_data JSONB;
BEGIN
    -- Build notification data
    notification_data := json_build_object(
        'id', NEW.id,
        'user_id', NEW.user_id,
        'notification_type', NEW.notification_type,
        'message', NEW.message,
        'is_read', NEW.is_read,
        'related_id', NEW.related_id,
        'created_at', NEW.created_at,
        'action', TG_OP
    );
    
    -- Broadcast the notification update
    PERFORM pg_notify(
        'notification_update',
        notification_data::text
    );
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to create notifications for real-time updates
CREATE OR REPLACE FUNCTION create_realtime_notifications()
RETURNS TRIGGER AS $$
BEGIN
    -- Create notification for new answer
    IF TG_OP = 'INSERT' AND TG_TABLE_NAME = 'answers' THEN
        INSERT INTO question_notifications (
            question_id, 
            user_id, 
            notification_type, 
            message, 
            related_id
        )
        SELECT 
            NEW.question_id,
            q.user_id,
            'answer',
            'Someone answered your question: ' || LEFT(q.title, 50) || '...',
            NEW.id
        FROM questions q
        WHERE q.id = NEW.question_id AND q.user_id != NEW.user_id;
    END IF;
    
    -- Create notification for new comment
    IF TG_OP = 'INSERT' AND TG_TABLE_NAME = 'answer_comments' THEN
        INSERT INTO answer_notifications (
            answer_id,
            user_id,
            notification_type,
            message,
            related_id
        )
        SELECT 
            NEW.answer_id,
            a.user_id,
            'comment',
            'Someone commented on your answer',
            NEW.id
        FROM answers a
        WHERE a.id = NEW.answer_id AND a.user_id != NEW.user_id;
    END IF;
    
    -- Create notification for vote
    IF TG_OP = 'INSERT' AND TG_TABLE_NAME = 'question_votes' THEN
        INSERT INTO question_notifications (
            question_id,
            user_id,
            notification_type,
            message,
            related_id
        )
        SELECT 
            NEW.question_id,
            q.user_id,
            'vote',
            CASE 
                WHEN NEW.vote_value = 1 THEN 'Someone upvoted your question'
                ELSE 'Someone downvoted your question'
            END,
            NEW.id
        FROM questions q
        WHERE q.id = NEW.question_id AND q.user_id != NEW.user_id;
    END IF;
    
    IF TG_OP = 'INSERT' AND TG_TABLE_NAME = 'answer_votes' THEN
        INSERT INTO answer_notifications (
            answer_id,
            user_id,
            notification_type,
            message,
            related_id
        )
        SELECT 
            NEW.answer_id,
            a.user_id,
            'vote',
            CASE 
                WHEN NEW.vote_value = 1 THEN 'Someone upvoted your answer'
                ELSE 'Someone downvoted your answer'
            END,
            NEW.id
        FROM answers a
        WHERE a.id = NEW.answer_id AND a.user_id != NEW.user_id;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for real-time updates
CREATE TRIGGER realtime_vote_update_trigger
    AFTER INSERT OR UPDATE OR DELETE ON question_votes
    FOR EACH ROW EXECUTE FUNCTION broadcast_vote_update();

CREATE TRIGGER realtime_answer_vote_update_trigger
    AFTER INSERT OR UPDATE OR DELETE ON answer_votes
    FOR EACH ROW EXECUTE FUNCTION broadcast_vote_update();

CREATE TRIGGER realtime_comment_update_trigger
    AFTER INSERT OR UPDATE OR DELETE ON answer_comments
    FOR EACH ROW EXECUTE FUNCTION broadcast_comment_update();

CREATE TRIGGER realtime_notification_update_trigger
    AFTER INSERT OR UPDATE OR DELETE ON question_notifications
    FOR EACH ROW EXECUTE FUNCTION broadcast_notification_update();

CREATE TRIGGER realtime_answer_notification_update_trigger
    AFTER INSERT OR UPDATE OR DELETE ON answer_notifications
    FOR EACH ROW EXECUTE FUNCTION broadcast_notification_update();

CREATE TRIGGER realtime_notification_creation_trigger
    AFTER INSERT ON answers
    FOR EACH ROW EXECUTE FUNCTION create_realtime_notifications();

CREATE TRIGGER realtime_comment_notification_trigger
    AFTER INSERT ON answer_comments
    FOR EACH ROW EXECUTE FUNCTION create_realtime_notifications();

CREATE TRIGGER realtime_vote_notification_trigger
    AFTER INSERT ON question_votes
    FOR EACH ROW EXECUTE FUNCTION create_realtime_notifications();

CREATE TRIGGER realtime_answer_vote_notification_trigger
    AFTER INSERT ON answer_votes
    FOR EACH ROW EXECUTE FUNCTION create_realtime_notifications();

-- Function to get real-time vote counts
CREATE OR REPLACE FUNCTION get_vote_counts(target_type TEXT, target_id INTEGER)
RETURNS TABLE(vote_count BIGINT, vote_score BIGINT) AS $$
BEGIN
    IF target_type = 'question' THEN
        RETURN QUERY
        SELECT 
            COUNT(*)::BIGINT as vote_count,
            COALESCE(SUM(vote_value), 0)::BIGINT as vote_score
        FROM question_votes 
        WHERE question_id = target_id;
    ELSIF target_type = 'answer' THEN
        RETURN QUERY
        SELECT 
            COUNT(*)::BIGINT as vote_count,
            COALESCE(SUM(vote_value), 0)::BIGINT as vote_score
        FROM answer_votes 
        WHERE answer_id = target_id;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Function to get unread notification count
CREATE OR REPLACE FUNCTION get_unread_notification_count(user_uuid UUID)
RETURNS INTEGER AS $$
DECLARE
    total_count INTEGER;
BEGIN
    SELECT 
        COALESCE(COUNT(*), 0) INTO total_count
    FROM (
        SELECT id FROM question_notifications 
        WHERE user_id = user_uuid AND is_read = FALSE
        UNION ALL
        SELECT id FROM answer_notifications 
        WHERE user_id = user_uuid AND is_read = FALSE
    ) combined_notifications;
    
    RETURN total_count;
END;
$$ LANGUAGE plpgsql;

-- Function to mark notifications as read
CREATE OR REPLACE FUNCTION mark_notifications_as_read(user_uuid UUID, notification_ids INTEGER[])
RETURNS INTEGER AS $$
DECLARE
    question_updated INTEGER;
    answer_updated INTEGER;
BEGIN
    UPDATE question_notifications 
    SET is_read = TRUE 
    WHERE user_id = user_uuid AND id = ANY(notification_ids);
    
    GET DIAGNOSTICS question_updated = ROW_COUNT;
    
    UPDATE answer_notifications 
    SET is_read = TRUE 
    WHERE user_id = user_uuid AND id = ANY(notification_ids);
    
    GET DIAGNOSTICS answer_updated = ROW_COUNT;
    
    RETURN question_updated + answer_updated;
END;
$$ LANGUAGE plpgsql;

-- Grant permissions for real-time functions
GRANT EXECUTE ON FUNCTION get_vote_counts(TEXT, INTEGER) TO authenticated;
GRANT EXECUTE ON FUNCTION get_unread_notification_count(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION mark_notifications_as_read(UUID, INTEGER[]) TO authenticated; 