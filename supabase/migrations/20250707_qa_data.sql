-- Sample Q&A Data Seed
-- Using real user UUIDs from your auth.users table
-- Priya Kumari: 1319be79-c9ec-450f-8115-4445c9da6d98
-- Anjali Kulkarni: 2ce68cde-0d58-4a03-9e4c-5e5e041eae03

-- 1. Insert Questions
INSERT INTO questions (id, user_id, title, body, category, status, view_count, created_at, updated_at)
VALUES
  (gen_random_uuid(), '1319be79-c9ec-450f-8115-4445c9da6d98', 'How do I use React hooks?', 'I am new to React and want to understand hooks.', 'React', 'open', 10, NOW(), NOW()),
  (gen_random_uuid(), '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'What is a closure in JavaScript?', 'Can someone explain closures with an example?', 'JavaScript', 'open', 5, NOW(), NOW());

-- 2. Insert Answers
INSERT INTO answers (id, question_id, user_id, body, is_accepted, created_at, updated_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'How do I use React hooks?' LIMIT 1), '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'You can use useState and useEffect for state and side effects.', FALSE, NOW(), NOW()),
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'What is a closure in JavaScript?' LIMIT 1), '1319be79-c9ec-450f-8115-4445c9da6d98', 'A closure is a function that remembers its outer variables.', FALSE, NOW(), NOW());

-- 3. Insert Question Votes
INSERT INTO question_votes (id, question_id, user_id, vote_value, created_at, updated_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'How do I use React hooks?' LIMIT 1), '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 1, NOW(), NOW()),
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'What is a closure in JavaScript?' LIMIT 1), '1319be79-c9ec-450f-8115-4445c9da6d98', 1, NOW(), NOW());

-- 4. Insert Answer Votes
INSERT INTO answer_votes (id, answer_id, user_id, vote_value, created_at, updated_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM answers WHERE body LIKE '%useState%' LIMIT 1), '1319be79-c9ec-450f-8115-4445c9da6d98', 1, NOW(), NOW());

-- 5. Insert Question Tags
INSERT INTO question_tags (id, question_id, tag_name, created_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'How do I use React hooks?' LIMIT 1), 'react', NOW()),
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'What is a closure in JavaScript?' LIMIT 1), 'javascript', NOW());

-- 6. Insert Answer Comments
INSERT INTO answer_comments (id, answer_id, user_id, parent_comment_id, body, created_at, updated_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM answers WHERE body LIKE '%useState%' LIMIT 1), '1319be79-c9ec-450f-8115-4445c9da6d98', NULL, 'Thanks, that helped!', NOW(), NOW());

-- 7. Insert Question Notifications
INSERT INTO question_notifications (id, question_id, user_id, notification_type, message, is_read, related_id, created_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'How do I use React hooks?' LIMIT 1), '1319be79-c9ec-450f-8115-4445c9da6d98', 'answer', 'Your question has a new answer!', FALSE, NULL, NOW());

-- 8. Insert Answer Notifications
INSERT INTO answer_notifications (id, answer_id, user_id, notification_type, message, is_read, related_id, created_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM answers WHERE body LIKE '%useState%' LIMIT 1), '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'comment', 'Someone commented on your answer.', FALSE, NULL, NOW());

-- 9. Insert AI Answers
INSERT INTO ai_answers (id, question_id, answer_text, confidence_score, model_used, tokens_used, processing_time_ms, relevance_score, completeness_score, user_feedback_rating, generation_attempts, created_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM questions WHERE title = 'How do I use React hooks?' LIMIT 1), 'React hooks let you use state and lifecycle features in function components.', 0.95, 'gpt-4', 120, 500, 0.9, 0.95, 5, 1, NOW());

-- 10. Insert Answer Tags
INSERT INTO answer_tags (id, answer_id, tag_name, created_at)
VALUES
  (gen_random_uuid(), (SELECT id FROM answers WHERE body LIKE '%useState%' LIMIT 1), 'react', NOW()); 