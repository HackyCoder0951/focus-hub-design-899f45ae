INSERT INTO "public"."profiles" 
("id", "email", "full_name", "avatar_url", "bio", "location", "website", "settings", "created_at", "updated_at") 
VALUES ('1319be79-c9ec-450f-8115-4445c9da6d98', 'priyakumari@gmail.com', 'Priya Kumari', null, null, null, null, null, '2025-06-29 19:08:02.258108+00', '2025-06-29 19:08:02.258108+00'), 
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'jignesh.vision.17@gmail.com', 'Jignesh Ameta', null, 'Full-stack developer passionate about creating amazing user experiences.', 'San Francisco, CA', 'https://johndoe.dev', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-06-29 14:14:42.054242+00', '2025-06-29 14:14:42.054242+00'), 
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'reddyarjun@gmail.com', 'Arjun Reddy', null, null, null, null, null, '2025-06-29 19:06:46.970067+00', '2025-06-29 19:06:46.970067+00'), 
('67f2070a-0399-485a-a8e1-e73241df52c0', 'vishnusingh@gmail.com', 'Vishnu Singh', null, null, null, null, null, '2025-06-29 19:09:56.966044+00', '2025-06-29 19:09:56.966044+00'), 
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'reddyvishal@gmail.com', 'Vishal Reddy', null, null, null, null, null, '2025-06-29 19:10:52.290034+00', '2025-06-29 19:10:52.290034+00'), 
('702dc5d1-9186-4350-b20f-d3007319a327', 'singhbhasker@gmail.com', 'Bhasker Singh', null, null, null, null, null, '2025-06-29 19:14:07.082442+00', '2025-06-29 19:14:07.082442+00'), 
('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'aakashkumar@gmail.com', 'Aakash Kumar', null, null, null, null, null, '2025-06-29 19:11:53.892531+00', '2025-06-29 19:11:53.892531+00'), 
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'kkamlesh@gmail.com', 'Kamlesh K', null, null, null, null, null, '2025-06-29 19:06:15.319534+00', '2025-06-29 19:06:15.319534+00'), 
('e657b686-9443-4cc9-800b-bc7fa4985e35', 'parinita.k@gmail.com', 'Parinita Reddy', null, null, null, null, null, '2025-06-29 19:15:00.793431+00', '2025-06-29 19:15:00.793431+00'), 
('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'kumararjun@gmail.com', 'Arjun Kumar R', null, null, null, null, null, '2025-06-29 19:07:33.749964+00', '2025-06-29 19:07:33.749964+00'),
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'priyankaks@gmail.com', 'Priyanka KS', null, null, null, null, null, '2025-06-29 19:09:16.693123+00', '2025-06-29 19:09:16.693123+00');

-- Sample chat data for testing
INSERT INTO public.chats (id, is_group, name, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', false, NULL, '2024-01-15 10:00:00+00'),
('550e8400-e29b-41d4-a716-446655440002', false, NULL, '2024-01-16 14:30:00+00'),
('550e8400-e29b-41d4-a716-446655440003', true, 'IT Support Team', '2024-01-17 09:15:00+00'),
('550e8400-e29b-41d4-a716-446655440004', false, NULL, '2024-01-18 16:45:00+00');

-- Chat members (connecting users to chats)
INSERT INTO public.chat_members (chat_id, user_id, joined_at) VALUES
-- Chat 1: Priya Kumari and Jignesh Ameta
('550e8400-e29b-41d4-a716-446655440001', '1319be79-c9ec-450f-8115-4445c9da6d98', '2024-01-15 10:00:00+00'),
('550e8400-e29b-41d4-a716-446655440001', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2024-01-15 10:00:00+00'),

-- Chat 2: Priya Kumari and Arjun Reddy
('550e8400-e29b-41d4-a716-446655440002', '1319be79-c9ec-450f-8115-4445c9da6d98', '2024-01-16 14:30:00+00'),
('550e8400-e29b-41d4-a716-446655440002', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2024-01-16 14:30:00+00'),

-- Chat 3: Group chat with multiple users
('550e8400-e29b-41d4-a716-446655440003', '1319be79-c9ec-450f-8115-4445c9da6d98', '2024-01-17 09:15:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2024-01-17 09:15:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2024-01-17 09:15:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '67f2070a-0399-485a-a8e1-e73241df52c0', '2024-01-17 09:15:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2024-01-17 09:15:00+00'),

-- Chat 4: Priya Kumari and Vishnu Singh
('550e8400-e29b-41d4-a716-446655440004', '1319be79-c9ec-450f-8115-4445c9da6d98', '2024-01-18 16:45:00+00'),
('550e8400-e29b-41d4-a716-446655440004', '67f2070a-0399-485a-a8e1-e73241df52c0', '2024-01-18 16:45:00+00');

-- Sample chat messages
INSERT INTO public.chat_messages (chat_id, user_id, content, created_at) VALUES
-- Chat 1 messages (Priya and Jignesh)
('550e8400-e29b-41d4-a716-446655440001', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Hey Jignesh! How is the new React project going?', '2024-01-15 10:05:00+00'),
('550e8400-e29b-41d4-a716-446655440001', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'It\'s going great! The new hooks are really making the code cleaner.', '2024-01-15 10:07:00+00'),
('550e8400-e29b-41d4-a716-446655440001', '1319be79-c9ec-450f-8115-4445c9da6d98', 'That\'s awesome! Can you share some examples?', '2024-01-15 10:10:00+00'),
('550e8400-e29b-41d4-a716-446655440001', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'Sure! I\'ll send you the GitHub repo link.', '2024-01-15 10:12:00+00'),

-- Chat 2 messages (Priya and Arjun)
('550e8400-e29b-41d4-a716-446655440002', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'Hi Priya, do you have time for a quick meeting about the database optimization?', '2024-01-16 14:35:00+00'),
('550e8400-e29b-41d4-a716-446655440002', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Of course! When works for you?', '2024-01-16 14:40:00+00'),
('550e8400-e29b-41d4-a716-446655440002', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'How about tomorrow at 2 PM?', '2024-01-16 14:42:00+00'),

-- Chat 3 messages (group chat)
('550e8400-e29b-41d4-a716-446655440003', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Good morning team! 👋', '2024-01-17 09:20:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'Morning Priya!', '2024-01-17 09:22:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'Good morning everyone!', '2024-01-17 09:25:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '67f2070a-0399-485a-a8e1-e73241df52c0', 'Hi team! 🚀', '2024-01-17 09:30:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Anyone up for a quick standup in 10 minutes?', '2024-01-17 09:35:00+00'),
('550e8400-e29b-41d4-a716-446655440003', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'I\'m in! 👍', '2024-01-17 09:36:00+00'),

-- Chat 4 messages (Priya and Vishnu)
('550e8400-e29b-41d4-a716-446655440004', '67f2070a-0399-485a-a8e1-e73241df52c0', 'Hey Priya! I loved your presentation on TypeScript best practices!', '2024-01-18 16:50:00+00'),
('550e8400-e29b-41d4-a716-446655440004', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Thank you Vishnu! I\'m glad you found it helpful. 😊', '2024-01-18 16:55:00+00'),
('550e8400-e29b-41d4-a716-446655440004', '67f2070a-0399-485a-a8e1-e73241df52c0', 'Do you have any resources you could share?', '2024-01-18 17:00:00+00');

ALTER TABLE public.chat_members ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT FALSE;
