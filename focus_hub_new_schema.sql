

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."app_role" AS ENUM (
    'admin',
    'user'
);


ALTER TYPE "public"."app_role" OWNER TO "postgres";


CREATE TYPE "public"."member_type_enum" AS ENUM (
    'student',
    'alumni'
);


ALTER TYPE "public"."member_type_enum" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."broadcast_comment_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."broadcast_comment_update"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."broadcast_notification_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."broadcast_notification_update"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."broadcast_vote_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    vote_count INTEGER;
    vote_score INTEGER;
    target_type TEXT;
    target_id UUID;
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
$$;


ALTER FUNCTION "public"."broadcast_vote_update"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_realtime_notifications"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."create_realtime_notifications"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_unread_notification_count"("user_uuid" "uuid") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."get_unread_notification_count"("user_uuid" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_vote_counts"("target_type" "text", "target_id" "uuid") RETURNS TABLE("vote_count" bigint, "vote_score" bigint)
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."get_vote_counts"("target_type" "text", "target_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_file_deletion"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Extract filename from file_url
  DECLARE
    file_path TEXT;
  BEGIN
    -- Extract the path from the file_url (remove domain and bucket prefix)
    file_path := REPLACE(OLD.file_url, 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/', '');
    
    -- Delete from storage
    DELETE FROM storage.objects 
    WHERE bucket_id = 'uploads' 
    AND name = file_path;
    
    RETURN OLD;
  EXCEPTION
    WHEN OTHERS THEN
      -- Log error but don't fail the deletion
      RAISE WARNING 'Failed to delete file from storage: %', SQLERRM;
      RETURN OLD;
  END;
END;
$$;


ALTER FUNCTION "public"."handle_file_deletion"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_file_update"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- If file_url changed, delete old file from storage
  IF OLD.file_url != NEW.file_url THEN
    DECLARE
      old_file_path TEXT;
    BEGIN
      -- Extract the path from the old file_url
      old_file_path := REPLACE(OLD.file_url, 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/', '');
      
      -- Delete old file from storage
      DELETE FROM storage.objects 
      WHERE bucket_id = 'uploads' 
      AND name = old_file_path;
    EXCEPTION
      WHEN OTHERS THEN
        -- Log error but don't fail the update
        RAISE WARNING 'Failed to delete old file from storage: %', SQLERRM;
    END;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_file_update"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
BEGIN
  RAISE NOTICE 'member_type value: %', new.raw_user_meta_data ->> 'member_type';
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
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."has_role"("_user_id" "uuid", "_role" "public"."app_role") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
  )
$$;


ALTER FUNCTION "public"."has_role"("_user_id" "uuid", "_role" "public"."app_role") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."leave_group"("p_chat_id" "uuid", "p_user_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  admin_count integer;
  member_count integer;
  new_admin_id uuid;
begin
  -- Remove the user from chat_members
  delete from chat_members where chat_id = p_chat_id and user_id = p_user_id;

  -- Check if any admins remain
  select count(*) into admin_count from chat_members where chat_id = p_chat_id and is_admin = true;

  if admin_count = 0 then
    -- Promote the earliest-joined member to admin, if any remain
    select user_id into new_admin_id from chat_members where chat_id = p_chat_id order by joined_at asc limit 1;
    if new_admin_id is not null then
      update chat_members set is_admin = true where chat_id = p_chat_id and user_id = new_admin_id;
    end if;
  end if;

  -- Check if any members remain
  select count(*) into member_count from chat_members where chat_id = p_chat_id;
  if member_count = 0 then
    -- Delete all messages and the chat itself
    delete from chat_messages where chat_id = p_chat_id;
    delete from chats where id = p_chat_id;
  end if;
end;
$$;


ALTER FUNCTION "public"."leave_group"("p_chat_id" "uuid", "p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."mark_notifications_as_read"("user_uuid" "uuid", "notification_ids" "uuid"[]) RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."mark_notifications_as_read"("user_uuid" "uuid", "notification_ids" "uuid"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."ai_answers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "question_id" "uuid",
    "answer_text" "text" NOT NULL,
    "model_used" "text",
    "tokens_used" integer,
    "processing_time_ms" integer,
    "user_feedback_rating" integer,
    "generation_attempts" integer DEFAULT 1,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "user_id" "uuid",
    "generated_by" "text",
    CONSTRAINT "ai_answers_user_feedback_rating_check" CHECK ((("user_feedback_rating" >= 1) AND ("user_feedback_rating" <= 5)))
);


ALTER TABLE "public"."ai_answers" OWNER TO "postgres";


COMMENT ON TABLE "public"."ai_answers" IS 'AI-generated answers to questions';



CREATE TABLE IF NOT EXISTS "public"."answer_comments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "answer_id" "uuid",
    "user_id" "uuid",
    "parent_comment_id" "uuid",
    "body" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."answer_comments" OWNER TO "postgres";


COMMENT ON TABLE "public"."answer_comments" IS 'Comments on answers';



CREATE TABLE IF NOT EXISTS "public"."answer_notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "answer_id" "uuid",
    "user_id" "uuid",
    "notification_type" "text",
    "message" "text" NOT NULL,
    "is_read" boolean DEFAULT false,
    "related_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "answer_notifications_notification_type_check" CHECK (("notification_type" = ANY (ARRAY['comment'::"text", 'vote'::"text", 'acceptance'::"text", 'mention'::"text"])))
);


ALTER TABLE "public"."answer_notifications" OWNER TO "postgres";


COMMENT ON TABLE "public"."answer_notifications" IS 'Notifications for answer-related activities';



CREATE TABLE IF NOT EXISTS "public"."answer_tags" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "answer_id" "uuid",
    "tag_name" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."answer_tags" OWNER TO "postgres";


COMMENT ON TABLE "public"."answer_tags" IS 'Tags associated with answers for categorization';



CREATE TABLE IF NOT EXISTS "public"."answer_votes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "answer_id" "uuid",
    "user_id" "uuid",
    "vote_value" smallint,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "answer_votes_vote_value_check" CHECK (("vote_value" = ANY (ARRAY[1, '-1'::integer])))
);


ALTER TABLE "public"."answer_votes" OWNER TO "postgres";


COMMENT ON TABLE "public"."answer_votes" IS 'Votes (upvotes/downvotes) on answers';



CREATE TABLE IF NOT EXISTS "public"."answers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "question_id" "uuid",
    "user_id" "uuid",
    "body" "text" NOT NULL,
    "is_accepted" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."answers" OWNER TO "postgres";


COMMENT ON TABLE "public"."answers" IS 'Answers to questions';



CREATE TABLE IF NOT EXISTS "public"."chat_members" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "chat_id" "uuid",
    "user_id" "uuid",
    "joined_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "is_admin" boolean DEFAULT false,
    "typing" boolean DEFAULT false
);


ALTER TABLE "public"."chat_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chat_messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "chat_id" "uuid",
    "user_id" "uuid",
    "content" "text",
    "media_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."chat_messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chats" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "is_group" boolean DEFAULT false NOT NULL,
    "name" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_by" "uuid"
);


ALTER TABLE "public"."chats" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."comment_likes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "comment_id" "uuid",
    "user_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."comment_likes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."comments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "post_id" "uuid",
    "user_id" "uuid",
    "content" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "parent_id" "uuid"
);


ALTER TABLE "public"."comments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."content_flags" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "flagged_by_user_id" "uuid" NOT NULL,
    "post_id" "uuid",
    "comment_id" "uuid",
    "reason" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "status" "text" DEFAULT 'pending'::"text",
    CONSTRAINT "only_one_content" CHECK (((("post_id" IS NOT NULL) AND ("comment_id" IS NULL)) OR (("post_id" IS NULL) AND ("comment_id" IS NOT NULL))))
);


ALTER TABLE "public"."content_flags" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."filemodels" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "file_url" "text" NOT NULL,
    "file_name" "text" NOT NULL,
    "file_type" "text",
    "file_size" integer,
    "description" "text",
    "is_public" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."filemodels" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."followers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "follower_id" "uuid",
    "following_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."followers" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."likes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "post_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."likes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "type" "text" NOT NULL,
    "data" "jsonb",
    "is_read" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."notifications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."posts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "content" "text" NOT NULL,
    "media_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "is_deleted" boolean DEFAULT false NOT NULL,
    "file_url" "text",
    "image_url" "text",
    "flag_status" "text" DEFAULT 'normal'::"text"
);


ALTER TABLE "public"."posts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "email" "text" NOT NULL,
    "full_name" "text",
    "avatar_url" "text",
    "bio" "text",
    "location" "text",
    "website" "text",
    "settings" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "member_type" "text" DEFAULT 'student'::"public"."member_type_enum",
    "status" "text" DEFAULT 'active'::"text",
    "last_seen" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "member_type_check" CHECK (("member_type" = ANY (ARRAY['student'::"text", 'alumni'::"text"])))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."question_notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "question_id" "uuid",
    "user_id" "uuid",
    "notification_type" "text",
    "message" "text" NOT NULL,
    "is_read" boolean DEFAULT false,
    "related_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "question_notifications_notification_type_check" CHECK (("notification_type" = ANY (ARRAY['answer'::"text", 'comment'::"text", 'vote'::"text", 'best_answer'::"text"])))
);


ALTER TABLE "public"."question_notifications" OWNER TO "postgres";


COMMENT ON TABLE "public"."question_notifications" IS 'Notifications for question-related activities';



CREATE TABLE IF NOT EXISTS "public"."question_votes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "question_id" "uuid",
    "user_id" "uuid",
    "vote_value" smallint,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "question_votes_vote_value_check" CHECK (("vote_value" = ANY (ARRAY[1, '-1'::integer])))
);


ALTER TABLE "public"."question_votes" OWNER TO "postgres";


COMMENT ON TABLE "public"."question_votes" IS 'Votes (upvotes/downvotes) on questions';



CREATE TABLE IF NOT EXISTS "public"."questions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "title" "text" NOT NULL,
    "body" "text" NOT NULL,
    "category" "text",
    "status" "text" DEFAULT 'open'::"text",
    "best_answer_id" "uuid",
    "view_count" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "questions_status_check" CHECK (("status" = ANY (ARRAY['open'::"text", 'closed'::"text", 'duplicate'::"text"])))
);


ALTER TABLE "public"."questions" OWNER TO "postgres";


COMMENT ON TABLE "public"."questions" IS 'Main questions table for the Q&A system';



CREATE OR REPLACE VIEW "public"."question_stats" AS
 SELECT "q"."id",
    "q"."title",
    "q"."view_count",
    "count"(DISTINCT "a"."id") AS "answer_count",
    "count"(DISTINCT "qv"."id") AS "vote_count",
    ("sum"(
        CASE
            WHEN ("qv"."vote_value" = 1) THEN 1
            ELSE 0
        END) - "sum"(
        CASE
            WHEN ("qv"."vote_value" = '-1'::integer) THEN 1
            ELSE 0
        END)) AS "vote_score"
   FROM (("public"."questions" "q"
     LEFT JOIN "public"."answers" "a" ON (("q"."id" = "a"."question_id")))
     LEFT JOIN "public"."question_votes" "qv" ON (("q"."id" = "qv"."question_id")))
  GROUP BY "q"."id", "q"."title", "q"."view_count";


ALTER VIEW "public"."question_stats" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."question_tags" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "question_id" "uuid",
    "tag_name" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."question_tags" OWNER TO "postgres";


COMMENT ON TABLE "public"."question_tags" IS 'Tags associated with questions for categorization';



CREATE TABLE IF NOT EXISTS "public"."reputation_events" (
    "id" integer NOT NULL,
    "user_id" "uuid",
    "type" "text" NOT NULL,
    "value" integer NOT NULL,
    "related_id" integer,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."reputation_events" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."reputation_events_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."reputation_events_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."reputation_events_id_seq" OWNED BY "public"."reputation_events"."id";



CREATE TABLE IF NOT EXISTS "public"."tags" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."tags" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."tags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."tags_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."tags_id_seq" OWNED BY "public"."tags"."id";



CREATE TABLE IF NOT EXISTS "public"."user_roles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "public"."app_role" DEFAULT 'user'::"public"."app_role" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."user_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."votes" (
    "id" integer NOT NULL,
    "user_id" "uuid",
    "target_id" integer NOT NULL,
    "target_type" "text",
    "value" smallint,
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "votes_target_type_check" CHECK (("target_type" = ANY (ARRAY['question'::"text", 'answer'::"text"]))),
    CONSTRAINT "votes_value_check" CHECK (("value" = ANY (ARRAY[1, '-1'::integer])))
);


ALTER TABLE "public"."votes" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."votes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."votes_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."votes_id_seq" OWNED BY "public"."votes"."id";



ALTER TABLE ONLY "public"."reputation_events" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."reputation_events_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."tags" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tags_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."votes" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."votes_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."ai_answers"
    ADD CONSTRAINT "ai_answers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."answer_comments"
    ADD CONSTRAINT "answer_comments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."answer_notifications"
    ADD CONSTRAINT "answer_notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."answer_tags"
    ADD CONSTRAINT "answer_tags_answer_id_tag_name_key" UNIQUE ("answer_id", "tag_name");



ALTER TABLE ONLY "public"."answer_tags"
    ADD CONSTRAINT "answer_tags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."answer_votes"
    ADD CONSTRAINT "answer_votes_answer_id_user_id_key" UNIQUE ("answer_id", "user_id");



ALTER TABLE ONLY "public"."answer_votes"
    ADD CONSTRAINT "answer_votes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."answers"
    ADD CONSTRAINT "answers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_members"
    ADD CONSTRAINT "chat_members_chat_id_user_id_key" UNIQUE ("chat_id", "user_id");



ALTER TABLE ONLY "public"."chat_members"
    ADD CONSTRAINT "chat_members_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chats"
    ADD CONSTRAINT "chats_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."comment_likes"
    ADD CONSTRAINT "comment_likes_comment_id_user_id_key" UNIQUE ("comment_id", "user_id");



ALTER TABLE ONLY "public"."comment_likes"
    ADD CONSTRAINT "comment_likes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."content_flags"
    ADD CONSTRAINT "content_flags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."filemodels"
    ADD CONSTRAINT "filemodels_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."followers"
    ADD CONSTRAINT "followers_follower_id_following_id_key" UNIQUE ("follower_id", "following_id");



ALTER TABLE ONLY "public"."followers"
    ADD CONSTRAINT "followers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."likes"
    ADD CONSTRAINT "likes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."likes"
    ADD CONSTRAINT "likes_user_id_post_id_key" UNIQUE ("user_id", "post_id");



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."posts"
    ADD CONSTRAINT "posts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."question_notifications"
    ADD CONSTRAINT "question_notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."question_tags"
    ADD CONSTRAINT "question_tags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."question_tags"
    ADD CONSTRAINT "question_tags_question_id_tag_name_key" UNIQUE ("question_id", "tag_name");



ALTER TABLE ONLY "public"."question_votes"
    ADD CONSTRAINT "question_votes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."question_votes"
    ADD CONSTRAINT "question_votes_question_id_user_id_key" UNIQUE ("question_id", "user_id");



ALTER TABLE ONLY "public"."questions"
    ADD CONSTRAINT "questions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reputation_events"
    ADD CONSTRAINT "reputation_events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tags"
    ADD CONSTRAINT "tags_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."tags"
    ADD CONSTRAINT "tags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_user_id_role_key" UNIQUE ("user_id", "role");



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_user_id_target_id_target_type_key" UNIQUE ("user_id", "target_id", "target_type");



CREATE INDEX "idx_ai_answers_question_id" ON "public"."ai_answers" USING "btree" ("question_id");



CREATE INDEX "idx_answer_comments_answer_id" ON "public"."answer_comments" USING "btree" ("answer_id");



CREATE INDEX "idx_answer_comments_parent_comment_id" ON "public"."answer_comments" USING "btree" ("parent_comment_id");



CREATE INDEX "idx_answer_comments_user_id" ON "public"."answer_comments" USING "btree" ("user_id");



CREATE INDEX "idx_answer_notifications_answer_id" ON "public"."answer_notifications" USING "btree" ("answer_id");



CREATE INDEX "idx_answer_notifications_created_at" ON "public"."answer_notifications" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_answer_notifications_is_read" ON "public"."answer_notifications" USING "btree" ("is_read");



CREATE INDEX "idx_answer_notifications_user_id" ON "public"."answer_notifications" USING "btree" ("user_id");



CREATE INDEX "idx_answer_tags_answer_id" ON "public"."answer_tags" USING "btree" ("answer_id");



CREATE INDEX "idx_answer_tags_tag_name" ON "public"."answer_tags" USING "btree" ("tag_name");



CREATE INDEX "idx_answer_votes_answer_id" ON "public"."answer_votes" USING "btree" ("answer_id");



CREATE INDEX "idx_answer_votes_user_id" ON "public"."answer_votes" USING "btree" ("user_id");



CREATE INDEX "idx_answers_created_at" ON "public"."answers" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_answers_is_accepted" ON "public"."answers" USING "btree" ("is_accepted");



CREATE INDEX "idx_answers_question_id" ON "public"."answers" USING "btree" ("question_id");



CREATE INDEX "idx_answers_user_id" ON "public"."answers" USING "btree" ("user_id");



CREATE INDEX "idx_chat_members_chat_id" ON "public"."chat_members" USING "btree" ("chat_id");



CREATE INDEX "idx_chat_members_user_id" ON "public"."chat_members" USING "btree" ("user_id");



CREATE INDEX "idx_chat_messages_chat_id" ON "public"."chat_messages" USING "btree" ("chat_id");



CREATE INDEX "idx_filemodels_public" ON "public"."filemodels" USING "btree" ("is_public") WHERE ("is_public" = true);



CREATE INDEX "idx_filemodels_search" ON "public"."filemodels" USING "gin" ("to_tsvector"('"english"'::"regconfig", (("file_name" || ' '::"text") || COALESCE("description", ''::"text"))));



CREATE INDEX "idx_filemodels_user_created" ON "public"."filemodels" USING "btree" ("user_id", "created_at" DESC);



CREATE INDEX "idx_filemodels_user_id" ON "public"."filemodels" USING "btree" ("user_id");



CREATE INDEX "idx_followers_follower_id" ON "public"."followers" USING "btree" ("follower_id");



CREATE INDEX "idx_followers_following_id" ON "public"."followers" USING "btree" ("following_id");



CREATE INDEX "idx_likes_post_id" ON "public"."likes" USING "btree" ("post_id");



CREATE INDEX "idx_notifications_user_id" ON "public"."notifications" USING "btree" ("user_id");



CREATE INDEX "idx_posts_user_id" ON "public"."posts" USING "btree" ("user_id");



CREATE INDEX "idx_question_notifications_created_at" ON "public"."question_notifications" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_question_notifications_is_read" ON "public"."question_notifications" USING "btree" ("is_read");



CREATE INDEX "idx_question_notifications_question_id" ON "public"."question_notifications" USING "btree" ("question_id");



CREATE INDEX "idx_question_notifications_user_id" ON "public"."question_notifications" USING "btree" ("user_id");



CREATE INDEX "idx_question_tags_question_id" ON "public"."question_tags" USING "btree" ("question_id");



CREATE INDEX "idx_question_tags_tag_name" ON "public"."question_tags" USING "btree" ("tag_name");



CREATE INDEX "idx_question_votes_question_id" ON "public"."question_votes" USING "btree" ("question_id");



CREATE INDEX "idx_question_votes_user_id" ON "public"."question_votes" USING "btree" ("user_id");



CREATE INDEX "idx_questions_body_gin" ON "public"."questions" USING "gin" ("to_tsvector"('"english"'::"regconfig", "body"));



CREATE INDEX "idx_questions_category" ON "public"."questions" USING "btree" ("category");



CREATE INDEX "idx_questions_created_at" ON "public"."questions" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_questions_status" ON "public"."questions" USING "btree" ("status");



CREATE INDEX "idx_questions_title_gin" ON "public"."questions" USING "gin" ("to_tsvector"('"english"'::"regconfig", "title"));



CREATE INDEX "idx_questions_user_id" ON "public"."questions" USING "btree" ("user_id");



CREATE OR REPLACE TRIGGER "file_deletion_trigger" AFTER DELETE ON "public"."filemodels" FOR EACH ROW EXECUTE FUNCTION "public"."handle_file_deletion"();



CREATE OR REPLACE TRIGGER "file_update_trigger" AFTER UPDATE ON "public"."filemodels" FOR EACH ROW EXECUTE FUNCTION "public"."handle_file_update"();



CREATE OR REPLACE TRIGGER "realtime_answer_notification_update_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."answer_notifications" FOR EACH ROW EXECUTE FUNCTION "public"."broadcast_notification_update"();



CREATE OR REPLACE TRIGGER "realtime_answer_vote_notification_trigger" AFTER INSERT ON "public"."answer_votes" FOR EACH ROW EXECUTE FUNCTION "public"."create_realtime_notifications"();



CREATE OR REPLACE TRIGGER "realtime_answer_vote_update_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."answer_votes" FOR EACH ROW EXECUTE FUNCTION "public"."broadcast_vote_update"();



CREATE OR REPLACE TRIGGER "realtime_comment_notification_trigger" AFTER INSERT ON "public"."answer_comments" FOR EACH ROW EXECUTE FUNCTION "public"."create_realtime_notifications"();



CREATE OR REPLACE TRIGGER "realtime_comment_update_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."answer_comments" FOR EACH ROW EXECUTE FUNCTION "public"."broadcast_comment_update"();



CREATE OR REPLACE TRIGGER "realtime_notification_creation_trigger" AFTER INSERT ON "public"."answers" FOR EACH ROW EXECUTE FUNCTION "public"."create_realtime_notifications"();



CREATE OR REPLACE TRIGGER "realtime_notification_update_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."question_notifications" FOR EACH ROW EXECUTE FUNCTION "public"."broadcast_notification_update"();



CREATE OR REPLACE TRIGGER "realtime_vote_notification_trigger" AFTER INSERT ON "public"."question_votes" FOR EACH ROW EXECUTE FUNCTION "public"."create_realtime_notifications"();



CREATE OR REPLACE TRIGGER "realtime_vote_update_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."question_votes" FOR EACH ROW EXECUTE FUNCTION "public"."broadcast_vote_update"();



ALTER TABLE ONLY "public"."ai_answers"
    ADD CONSTRAINT "ai_answers_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_comments"
    ADD CONSTRAINT "answer_comments_answer_id_fkey" FOREIGN KEY ("answer_id") REFERENCES "public"."answers"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_comments"
    ADD CONSTRAINT "answer_comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "public"."answer_comments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_comments"
    ADD CONSTRAINT "answer_comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_notifications"
    ADD CONSTRAINT "answer_notifications_answer_id_fkey" FOREIGN KEY ("answer_id") REFERENCES "public"."answers"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_notifications"
    ADD CONSTRAINT "answer_notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_tags"
    ADD CONSTRAINT "answer_tags_answer_id_fkey" FOREIGN KEY ("answer_id") REFERENCES "public"."answers"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_votes"
    ADD CONSTRAINT "answer_votes_answer_id_fkey" FOREIGN KEY ("answer_id") REFERENCES "public"."answers"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answer_votes"
    ADD CONSTRAINT "answer_votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answers"
    ADD CONSTRAINT "answers_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."answers"
    ADD CONSTRAINT "answers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_members"
    ADD CONSTRAINT "chat_members_chat_id_fkey" FOREIGN KEY ("chat_id") REFERENCES "public"."chats"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_members"
    ADD CONSTRAINT "chat_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_chat_id_fkey" FOREIGN KEY ("chat_id") REFERENCES "public"."chats"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comment_likes"
    ADD CONSTRAINT "comment_likes_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comment_likes"
    ADD CONSTRAINT "comment_likes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."comments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."content_flags"
    ADD CONSTRAINT "content_flags_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments"("id");



ALTER TABLE ONLY "public"."content_flags"
    ADD CONSTRAINT "content_flags_flagged_by_user_id_fkey" FOREIGN KEY ("flagged_by_user_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."content_flags"
    ADD CONSTRAINT "content_flags_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."filemodels"
    ADD CONSTRAINT "filemodels_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."ai_answers"
    ADD CONSTRAINT "fk_aianswers_user" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."answers"
    ADD CONSTRAINT "fk_answers_user" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."questions"
    ADD CONSTRAINT "fk_questions_user" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."followers"
    ADD CONSTRAINT "followers_follower_id_fkey" FOREIGN KEY ("follower_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."followers"
    ADD CONSTRAINT "followers_following_id_fkey" FOREIGN KEY ("following_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."likes"
    ADD CONSTRAINT "likes_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."likes"
    ADD CONSTRAINT "likes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."posts"
    ADD CONSTRAINT "posts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."question_notifications"
    ADD CONSTRAINT "question_notifications_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."question_notifications"
    ADD CONSTRAINT "question_notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."question_tags"
    ADD CONSTRAINT "question_tags_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."question_votes"
    ADD CONSTRAINT "question_votes_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."question_votes"
    ADD CONSTRAINT "question_votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."questions"
    ADD CONSTRAINT "questions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reputation_events"
    ADD CONSTRAINT "reputation_events_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "AI can delete answer_tags" ON "public"."answer_tags" FOR DELETE USING (true);



CREATE POLICY "AI can insert ai_answers" ON "public"."ai_answers" FOR INSERT WITH CHECK (true);



CREATE POLICY "AI can insert answer_tags" ON "public"."answer_tags" FOR INSERT WITH CHECK (true);



CREATE POLICY "AI can select ai_answers" ON "public"."ai_answers" FOR SELECT USING (true);



CREATE POLICY "AI can select answer_tags" ON "public"."answer_tags" FOR SELECT USING (true);



CREATE POLICY "AI can update ai_answers" ON "public"."ai_answers" FOR UPDATE USING (true);



CREATE POLICY "AI can update answer_tags" ON "public"."answer_tags" FOR UPDATE USING (true);



CREATE POLICY "Admins can delete any flag" ON "public"."content_flags" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles"
  WHERE (("user_roles"."user_id" = "auth"."uid"()) AND ("user_roles"."role" = 'admin'::"public"."app_role")))));



CREATE POLICY "Admins can insert roles" ON "public"."user_roles" FOR INSERT WITH CHECK ("public"."has_role"("auth"."uid"(), 'admin'::"public"."app_role"));



CREATE POLICY "Admins can remove members" ON "public"."chat_members" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."chat_members" "cm"
  WHERE (("cm"."chat_id" = "chat_members"."chat_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."is_admin" = true)))));



CREATE POLICY "Admins can update admin status" ON "public"."chat_members" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."chat_members" "cm"
  WHERE (("cm"."chat_id" = "chat_members"."chat_id") AND ("cm"."user_id" = "auth"."uid"()) AND ("cm"."is_admin" = true)))));



CREATE POLICY "Admins can update any flag" ON "public"."content_flags" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles"
  WHERE (("user_roles"."user_id" = "auth"."uid"()) AND ("user_roles"."role" = 'admin'::"public"."app_role")))));



CREATE POLICY "Admins can update any profile" ON "public"."profiles" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles"
  WHERE (("user_roles"."user_id" = "auth"."uid"()) AND ("user_roles"."role" = 'admin'::"public"."app_role")))));



CREATE POLICY "Admins can update group info" ON "public"."chats" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."chat_members"
  WHERE (("chat_members"."chat_id" = "chats"."id") AND ("chat_members"."user_id" = "auth"."uid"()) AND ("chat_members"."is_admin" = true)))));



CREATE POLICY "Admins can update roles" ON "public"."user_roles" FOR UPDATE USING ("public"."has_role"("auth"."uid"(), 'admin'::"public"."app_role"));



CREATE POLICY "Admins can view all flags" ON "public"."content_flags" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."user_roles"
  WHERE (("user_roles"."user_id" = "auth"."uid"()) AND ("user_roles"."role" = 'admin'::"public"."app_role")))));



CREATE POLICY "Admins can view all roles" ON "public"."user_roles" FOR SELECT USING ("public"."has_role"("auth"."uid"(), 'admin'::"public"."app_role"));



CREATE POLICY "All users can view all flags" ON "public"."content_flags" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Allow all users to read admin roles" ON "public"."user_roles" FOR SELECT USING (true);



CREATE POLICY "Allow users to update their own last_seen" ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id"));



CREATE POLICY "Allow users to update their own typing status" ON "public"."chat_members" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Answer comments are viewable by everyone" ON "public"."answer_comments" FOR SELECT USING (true);



CREATE POLICY "Answer votes are viewable by everyone" ON "public"."answer_votes" FOR SELECT USING (true);



CREATE POLICY "Anyone can add any user to chat" ON "public"."chat_members" FOR INSERT WITH CHECK (true);



CREATE POLICY "Authenticated users can delete answers" ON "public"."answers" FOR DELETE USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can delete own posts" ON "public"."posts" FOR DELETE USING ((("auth"."role"() = 'authenticated'::"text") AND ("user_id" = "auth"."uid"())));



CREATE POLICY "Authenticated users can delete questions" ON "public"."questions" FOR DELETE USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can insert answers" ON "public"."answers" FOR INSERT WITH CHECK (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can insert posts" ON "public"."posts" FOR INSERT WITH CHECK ((("auth"."role"() = 'authenticated'::"text") AND ("user_id" = "auth"."uid"())));



CREATE POLICY "Authenticated users can insert questions" ON "public"."questions" FOR INSERT WITH CHECK (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can select answers" ON "public"."answers" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can select questions" ON "public"."questions" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can update answers" ON "public"."answers" FOR UPDATE USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can update own posts" ON "public"."posts" FOR UPDATE USING ((("auth"."role"() = 'authenticated'::"text") AND ("user_id" = "auth"."uid"())));



CREATE POLICY "Authenticated users can update questions" ON "public"."questions" FOR UPDATE USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Authenticated users can view posts" ON "public"."posts" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Public can view all profiles" ON "public"."profiles" FOR SELECT USING (true);



CREATE POLICY "Question owners can manage tags" ON "public"."question_tags" USING ((EXISTS ( SELECT 1
   FROM "public"."questions"
  WHERE (("questions"."id" = "question_tags"."question_id") AND ("questions"."user_id" = "auth"."uid"())))));



CREATE POLICY "Question tags are viewable by everyone" ON "public"."question_tags" FOR SELECT USING (true);



CREATE POLICY "Question votes are viewable by everyone" ON "public"."question_votes" FOR SELECT USING (true);



CREATE POLICY "System can insert answer notifications" ON "public"."answer_notifications" FOR INSERT WITH CHECK (true);



CREATE POLICY "System can insert notifications" ON "public"."question_notifications" FOR INSERT WITH CHECK (true);



CREATE POLICY "Users can delete own files" ON "public"."filemodels" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own comments" ON "public"."answer_comments" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own comments" ON "public"."comments" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own files" ON "public"."filemodels" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own follows" ON "public"."followers" FOR DELETE USING (("auth"."uid"() = "follower_id"));



CREATE POLICY "Users can delete their own likes" ON "public"."likes" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own messages" ON "public"."chat_messages" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own votes" ON "public"."answer_votes" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own votes" ON "public"."question_votes" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete themselves from chat" ON "public"."chat_members" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can flag posts" ON "public"."content_flags" FOR INSERT WITH CHECK (("auth"."uid"() = "flagged_by_user_id"));



CREATE POLICY "Users can follow/unfollow" ON "public"."followers" FOR INSERT WITH CHECK (("auth"."uid"() = "follower_id"));



CREATE POLICY "Users can insert chat messages" ON "public"."chat_messages" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert chats" ON "public"."chats" FOR INSERT WITH CHECK (true);



CREATE POLICY "Users can insert files" ON "public"."filemodels" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert notifications" ON "public"."notifications" FOR INSERT WITH CHECK (true);



CREATE POLICY "Users can insert own files" ON "public"."filemodels" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own comments" ON "public"."answer_comments" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own comments" ON "public"."comments" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own profile" ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "Users can like posts" ON "public"."likes" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can like/unlike comments" ON "public"."comment_likes" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can unlike their own comment like" ON "public"."comment_likes" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update own files" ON "public"."filemodels" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their notifications" ON "public"."notifications" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own answer notifications" ON "public"."answer_notifications" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own comments" ON "public"."answer_comments" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own comments" ON "public"."comments" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own files" ON "public"."filemodels" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own notifications" ON "public"."question_notifications" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own profile" ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can update their own votes" ON "public"."answer_votes" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own votes" ON "public"."question_votes" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view all comment likes" ON "public"."comment_likes" FOR SELECT USING (true);



CREATE POLICY "Users can view all comments" ON "public"."comments" FOR SELECT USING (true);



CREATE POLICY "Users can view chat members" ON "public"."chat_members" FOR SELECT USING (true);



CREATE POLICY "Users can view chat messages" ON "public"."chat_messages" FOR SELECT USING (true);



CREATE POLICY "Users can view chats" ON "public"."chats" FOR SELECT USING (true);



CREATE POLICY "Users can view followers" ON "public"."followers" FOR SELECT USING (true);



CREATE POLICY "Users can view likes" ON "public"."likes" FOR SELECT USING (true);



CREATE POLICY "Users can view own and public files" ON "public"."filemodels" FOR SELECT USING ((("auth"."uid"() = "user_id") OR ("is_public" = true)));



CREATE POLICY "Users can view public files" ON "public"."filemodels" FOR SELECT USING (("is_public" OR ("auth"."uid"() = "user_id")));



CREATE POLICY "Users can view their notifications" ON "public"."notifications" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own answer notifications" ON "public"."answer_notifications" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own notifications" ON "public"."question_notifications" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own profile" ON "public"."profiles" FOR SELECT USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can view their own roles" ON "public"."user_roles" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can vote on answers" ON "public"."answer_votes" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can vote on questions" ON "public"."question_votes" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."ai_answers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."answer_comments" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."answer_notifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."answer_tags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."answer_votes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."answers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chat_members" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chat_messages" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chats" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."comment_likes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."comments" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."content_flags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."filemodels" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."followers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."likes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."posts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."question_notifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."question_tags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."question_votes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."questions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."answer_comments";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."answer_notifications";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."answer_votes";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."answers";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."chat_members";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."chat_messages";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."chats";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."comment_likes";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."comments";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."filemodels";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."followers";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."likes";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."notifications";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."posts";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."profiles";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."question_notifications";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."question_votes";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."questions";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."user_roles";






GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."broadcast_comment_update"() TO "anon";
GRANT ALL ON FUNCTION "public"."broadcast_comment_update"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."broadcast_comment_update"() TO "service_role";



GRANT ALL ON FUNCTION "public"."broadcast_notification_update"() TO "anon";
GRANT ALL ON FUNCTION "public"."broadcast_notification_update"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."broadcast_notification_update"() TO "service_role";



GRANT ALL ON FUNCTION "public"."broadcast_vote_update"() TO "anon";
GRANT ALL ON FUNCTION "public"."broadcast_vote_update"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."broadcast_vote_update"() TO "service_role";



GRANT ALL ON FUNCTION "public"."create_realtime_notifications"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_realtime_notifications"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_realtime_notifications"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_unread_notification_count"("user_uuid" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_unread_notification_count"("user_uuid" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_unread_notification_count"("user_uuid" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_vote_counts"("target_type" "text", "target_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_vote_counts"("target_type" "text", "target_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_vote_counts"("target_type" "text", "target_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_file_deletion"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_file_deletion"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_file_deletion"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_file_update"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_file_update"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_file_update"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."has_role"("_user_id" "uuid", "_role" "public"."app_role") TO "anon";
GRANT ALL ON FUNCTION "public"."has_role"("_user_id" "uuid", "_role" "public"."app_role") TO "authenticated";
GRANT ALL ON FUNCTION "public"."has_role"("_user_id" "uuid", "_role" "public"."app_role") TO "service_role";



GRANT ALL ON FUNCTION "public"."leave_group"("p_chat_id" "uuid", "p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."leave_group"("p_chat_id" "uuid", "p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."leave_group"("p_chat_id" "uuid", "p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."mark_notifications_as_read"("user_uuid" "uuid", "notification_ids" "uuid"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."mark_notifications_as_read"("user_uuid" "uuid", "notification_ids" "uuid"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."mark_notifications_as_read"("user_uuid" "uuid", "notification_ids" "uuid"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";


















GRANT ALL ON TABLE "public"."ai_answers" TO "anon";
GRANT ALL ON TABLE "public"."ai_answers" TO "authenticated";
GRANT ALL ON TABLE "public"."ai_answers" TO "service_role";



GRANT ALL ON TABLE "public"."answer_comments" TO "anon";
GRANT ALL ON TABLE "public"."answer_comments" TO "authenticated";
GRANT ALL ON TABLE "public"."answer_comments" TO "service_role";



GRANT ALL ON TABLE "public"."answer_notifications" TO "anon";
GRANT ALL ON TABLE "public"."answer_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."answer_notifications" TO "service_role";



GRANT ALL ON TABLE "public"."answer_tags" TO "anon";
GRANT ALL ON TABLE "public"."answer_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."answer_tags" TO "service_role";



GRANT ALL ON TABLE "public"."answer_votes" TO "anon";
GRANT ALL ON TABLE "public"."answer_votes" TO "authenticated";
GRANT ALL ON TABLE "public"."answer_votes" TO "service_role";



GRANT ALL ON TABLE "public"."answers" TO "anon";
GRANT ALL ON TABLE "public"."answers" TO "authenticated";
GRANT ALL ON TABLE "public"."answers" TO "service_role";



GRANT ALL ON TABLE "public"."chat_members" TO "anon";
GRANT ALL ON TABLE "public"."chat_members" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_members" TO "service_role";



GRANT ALL ON TABLE "public"."chat_messages" TO "anon";
GRANT ALL ON TABLE "public"."chat_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_messages" TO "service_role";



GRANT ALL ON TABLE "public"."chats" TO "anon";
GRANT ALL ON TABLE "public"."chats" TO "authenticated";
GRANT ALL ON TABLE "public"."chats" TO "service_role";



GRANT ALL ON TABLE "public"."comment_likes" TO "anon";
GRANT ALL ON TABLE "public"."comment_likes" TO "authenticated";
GRANT ALL ON TABLE "public"."comment_likes" TO "service_role";



GRANT ALL ON TABLE "public"."comments" TO "anon";
GRANT ALL ON TABLE "public"."comments" TO "authenticated";
GRANT ALL ON TABLE "public"."comments" TO "service_role";



GRANT ALL ON TABLE "public"."content_flags" TO "anon";
GRANT ALL ON TABLE "public"."content_flags" TO "authenticated";
GRANT ALL ON TABLE "public"."content_flags" TO "service_role";



GRANT ALL ON TABLE "public"."filemodels" TO "anon";
GRANT ALL ON TABLE "public"."filemodels" TO "authenticated";
GRANT ALL ON TABLE "public"."filemodels" TO "service_role";



GRANT ALL ON TABLE "public"."followers" TO "anon";
GRANT ALL ON TABLE "public"."followers" TO "authenticated";
GRANT ALL ON TABLE "public"."followers" TO "service_role";



GRANT ALL ON TABLE "public"."likes" TO "anon";
GRANT ALL ON TABLE "public"."likes" TO "authenticated";
GRANT ALL ON TABLE "public"."likes" TO "service_role";



GRANT ALL ON TABLE "public"."notifications" TO "anon";
GRANT ALL ON TABLE "public"."notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."notifications" TO "service_role";



GRANT ALL ON TABLE "public"."posts" TO "anon";
GRANT ALL ON TABLE "public"."posts" TO "authenticated";
GRANT ALL ON TABLE "public"."posts" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."question_notifications" TO "anon";
GRANT ALL ON TABLE "public"."question_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."question_notifications" TO "service_role";



GRANT ALL ON TABLE "public"."question_votes" TO "anon";
GRANT ALL ON TABLE "public"."question_votes" TO "authenticated";
GRANT ALL ON TABLE "public"."question_votes" TO "service_role";



GRANT ALL ON TABLE "public"."questions" TO "anon";
GRANT ALL ON TABLE "public"."questions" TO "authenticated";
GRANT ALL ON TABLE "public"."questions" TO "service_role";



GRANT ALL ON TABLE "public"."question_stats" TO "anon";
GRANT ALL ON TABLE "public"."question_stats" TO "authenticated";
GRANT ALL ON TABLE "public"."question_stats" TO "service_role";



GRANT ALL ON TABLE "public"."question_tags" TO "anon";
GRANT ALL ON TABLE "public"."question_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."question_tags" TO "service_role";



GRANT ALL ON TABLE "public"."reputation_events" TO "anon";
GRANT ALL ON TABLE "public"."reputation_events" TO "authenticated";
GRANT ALL ON TABLE "public"."reputation_events" TO "service_role";



GRANT ALL ON SEQUENCE "public"."reputation_events_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."reputation_events_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."reputation_events_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tags" TO "anon";
GRANT ALL ON TABLE "public"."tags" TO "authenticated";
GRANT ALL ON TABLE "public"."tags" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tags_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tags_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tags_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."user_roles" TO "anon";
GRANT ALL ON TABLE "public"."user_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."user_roles" TO "service_role";



GRANT ALL ON TABLE "public"."votes" TO "anon";
GRANT ALL ON TABLE "public"."votes" TO "authenticated";
GRANT ALL ON TABLE "public"."votes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."votes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."votes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."votes_id_seq" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






























RESET ALL;
