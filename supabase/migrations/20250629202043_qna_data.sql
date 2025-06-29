-- Q&A DATA: 2 questions per user, each answered by 2 other users
-- Each INSERT for a question has answer=NULL, is_answered=FALSE
-- Each answer row has answer=..., is_answered=TRUE

-- Priya Kumari (1319be79-c9ec-450f-8115-4445c9da6d98)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('1319be79-c9ec-450f-8115-4445c9da6d98', 'What is the best way to learn React in 2025?', NULL, FALSE, '2025-01-10 10:00:00+00', '2025-01-10 10:00:00+00'),
('1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you optimize SQL queries for large datasets?', NULL, FALSE, '2025-01-10 10:05:00+00', '2025-01-10 10:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'What is the best way to learn React in 2025?', 'Start with the official React docs and build small projects. Use hooks and functional components from the beginning.', TRUE, '2025-01-10 12:00:00+00', '2025-01-10 12:00:00+00'),
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'What is the best way to learn React in 2025?', 'Join online communities and follow React updates. Practice by contributing to open source.', TRUE, '2025-01-10 12:10:00+00', '2025-01-10 12:10:00+00'),
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you optimize SQL queries for large datasets?', 'Use proper indexing and avoid SELECT * in production queries.', TRUE, '2025-01-10 12:20:00+00', '2025-01-10 12:20:00+00'),
('702dc5d1-9186-4350-b20f-d3007319a327', 'How do you optimize SQL queries for large datasets?', 'Analyze query plans and break down complex queries into smaller parts.', TRUE, '2025-01-10 12:30:00+00', '2025-01-10 12:30:00+00');

-- Jignesh Ameta (306f8931-2603-4c86-b3ab-f804c2c5be57)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are the benefits of using TypeScript with Node.js?', NULL, FALSE, '2025-01-11 09:00:00+00', '2025-01-11 09:00:00+00'),
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'How do you implement authentication in a React app?', NULL, FALSE, '2025-01-11 09:05:00+00', '2025-01-11 09:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('1319be79-c9ec-450f-8115-4445c9da6d98', 'What are the benefits of using TypeScript with Node.js?', 'TypeScript provides static typing, which helps catch errors early and improves code maintainability.', TRUE, '2025-01-11 10:00:00+00', '2025-01-11 10:00:00+00'),
('67f2070a-0399-485a-a8e1-e73241df52c0', 'What are the benefits of using TypeScript with Node.js?', 'It enhances IDE support and makes refactoring easier in large codebases.', TRUE, '2025-01-11 10:10:00+00', '2025-01-11 10:10:00+00'),
('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'How do you implement authentication in a React app?', 'Use libraries like Firebase Auth or Auth0, and manage tokens securely.', TRUE, '2025-01-11 10:20:00+00', '2025-01-11 10:20:00+00'),
('e657b686-9443-4cc9-800b-bc7fa4985e35', 'How do you implement authentication in a React app?', 'Implement context for auth state and use protected routes.', TRUE, '2025-01-11 10:30:00+00', '2025-01-11 10:30:00+00');

-- Arjun Reddy (399e5ea7-4664-4c3c-81d3-b983814d106a)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'What is the difference between REST and GraphQL?', NULL, FALSE, '2025-01-12 08:00:00+00', '2025-01-12 08:00:00+00'),
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you handle state management in large React apps?', NULL, FALSE, '2025-01-12 08:05:00+00', '2025-01-12 08:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is the difference between REST and GraphQL?', 'REST uses multiple endpoints, while GraphQL uses a single endpoint and allows clients to specify exactly what data they need.', TRUE, '2025-01-12 09:00:00+00', '2025-01-12 09:00:00+00'),
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'What is the difference between REST and GraphQL?', 'GraphQL can reduce over-fetching and under-fetching of data compared to REST.', TRUE, '2025-01-12 09:10:00+00', '2025-01-12 09:10:00+00'),
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you handle state management in large React apps?', 'Use libraries like Redux or Zustand, and keep state as local as possible.', TRUE, '2025-01-12 09:20:00+00', '2025-01-12 09:20:00+00'),
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you handle state management in large React apps?', 'Leverage React Context for global state and custom hooks for logic reuse.', TRUE, '2025-01-12 09:30:00+00', '2025-01-12 09:30:00+00');

-- Vishnu Singh (67f2070a-0399-485a-a8e1-e73241df52c0)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('67f2070a-0399-485a-a8e1-e73241df52c0', 'What are the best practices for deploying machine learning models?', NULL, FALSE, '2025-01-13 11:00:00+00', '2025-01-13 11:00:00+00'),
('67f2070a-0399-485a-a8e1-e73241df52c0', 'How do you ensure data privacy in web applications?', NULL, FALSE, '2025-01-13 11:05:00+00', '2025-01-13 11:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('e657b686-9443-4cc9-800b-bc7fa4985e35', 'What are the best practices for deploying machine learning models?', 'Containerize models with Docker and use CI/CD pipelines for deployment.', TRUE, '2025-01-13 12:00:00+00', '2025-01-13 12:00:00+00'),
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are the best practices for deploying machine learning models?', 'Monitor model performance and retrain regularly with new data.', TRUE, '2025-01-13 12:10:00+00', '2025-01-13 12:10:00+00'),
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you ensure data privacy in web applications?', 'Implement HTTPS, encrypt sensitive data, and use secure authentication.', TRUE, '2025-01-13 12:20:00+00', '2025-01-13 12:20:00+00'),
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you ensure data privacy in web applications?', 'Follow GDPR guidelines and minimize data collection.', TRUE, '2025-01-13 12:30:00+00', '2025-01-13 12:30:00+00');

-- Vishal Reddy (68e5b8aa-c6b8-4e2d-a303-a1c10717837b)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'What is a smart contract and how does it work?', NULL, FALSE, '2025-01-14 13:00:00+00', '2025-01-14 13:00:00+00'),
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you secure a blockchain application?', NULL, FALSE, '2025-01-14 13:05:00+00', '2025-01-14 13:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('702dc5d1-9186-4350-b20f-d3007319a327', 'What is a smart contract and how does it work?', 'A smart contract is a self-executing contract with the terms directly written into code on the blockchain.', TRUE, '2025-01-14 14:00:00+00', '2025-01-14 14:00:00+00'),
('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is a smart contract and how does it work?', 'It runs on the blockchain and executes automatically when conditions are met.', TRUE, '2025-01-14 14:10:00+00', '2025-01-14 14:10:00+00'),
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you secure a blockchain application?', 'Use secure coding practices, audit smart contracts, and keep private keys safe.', TRUE, '2025-01-14 14:20:00+00', '2025-01-14 14:20:00+00'),
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you secure a blockchain application?', 'Implement multi-signature wallets and regular security audits.', TRUE, '2025-01-14 14:30:00+00', '2025-01-14 14:30:00+00');

-- Bhasker Singh (702dc5d1-9186-4350-b20f-d3007319a327)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('702dc5d1-9186-4350-b20f-d3007319a327', 'What are the advantages of cloud computing?', NULL, FALSE, '2025-01-15 15:00:00+00', '2025-01-15 15:00:00+00'),
('702dc5d1-9186-4350-b20f-d3007319a327', 'How do you migrate a legacy app to the cloud?', NULL, FALSE, '2025-01-15 15:05:00+00', '2025-01-15 15:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'What are the advantages of cloud computing?', 'Scalability, cost-effectiveness, and on-demand resources.', TRUE, '2025-01-15 16:00:00+00', '2025-01-15 16:00:00+00'),
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are the advantages of cloud computing?', 'It allows businesses to focus on core activities instead of infrastructure management.', TRUE, '2025-01-15 16:10:00+00', '2025-01-15 16:10:00+00'),
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you migrate a legacy app to the cloud?', 'Assess dependencies, refactor code, and use cloud-native services.', TRUE, '2025-01-15 16:20:00+00', '2025-01-15 16:20:00+00'),
('1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you migrate a legacy app to the cloud?', 'Start with a lift-and-shift approach, then optimize for the cloud.', TRUE, '2025-01-15 16:30:00+00', '2025-01-15 16:30:00+00');

-- Aakash Kumar (719c5acf-8f3e-4064-ac1a-00c3692901ba)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is the Composition API in Vue 3?', NULL, FALSE, '2025-01-16 17:00:00+00', '2025-01-16 17:00:00+00'),
('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'How do you optimize performance in Vue apps?', NULL, FALSE, '2025-01-16 17:05:00+00', '2025-01-16 17:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'What is the Composition API in Vue 3?', 'It allows you to organize code by logical concern, not by lifecycle method.', TRUE, '2025-01-16 18:00:00+00', '2025-01-16 18:00:00+00'),
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'What is the Composition API in Vue 3?', 'It provides better code reuse and TypeScript support.', TRUE, '2025-01-16 18:10:00+00', '2025-01-16 18:10:00+00'),
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'How do you optimize performance in Vue apps?', 'Use lazy loading, code splitting, and keep component state local.', TRUE, '2025-01-16 18:20:00+00', '2025-01-16 18:20:00+00'),
('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'How do you optimize performance in Vue apps?', 'Profile your app and avoid unnecessary re-renders.', TRUE, '2025-01-16 18:30:00+00', '2025-01-16 18:30:00+00');

-- Kamlesh K (d36c190e-3790-4f8a-b17d-7d4c1f550cb2)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'What is Redis and why is it used?', NULL, FALSE, '2025-01-17 19:00:00+00', '2025-01-17 19:00:00+00'),
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you implement caching in web applications?', NULL, FALSE, '2025-01-17 19:05:00+00', '2025-01-17 19:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'What is Redis and why is it used?', 'Redis is an in-memory data store used for caching and fast data access.', TRUE, '2025-01-17 20:00:00+00', '2025-01-17 20:00:00+00'),
('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is Redis and why is it used?', 'It supports data structures like strings, hashes, and lists, and is often used for session storage.', TRUE, '2025-01-17 20:10:00+00', '2025-01-17 20:10:00+00'),
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you implement caching in web applications?', 'Use HTTP cache headers and in-memory stores like Redis or Memcached.', TRUE, '2025-01-17 20:20:00+00', '2025-01-17 20:20:00+00'),
('1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you implement caching in web applications?', 'Cache database query results and static assets for faster load times.', TRUE, '2025-01-17 20:30:00+00', '2025-01-17 20:30:00+00');

-- Parinita Reddy (e657b686-9443-4cc9-800b-bc7fa4985e35)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('e657b686-9443-4cc9-800b-bc7fa4985e35', 'What are Progressive Web Apps (PWAs)?', NULL, FALSE, '2025-01-18 21:00:00+00', '2025-01-18 21:00:00+00'),
('e657b686-9443-4cc9-800b-bc7fa4985e35', 'How do you implement offline support in web apps?', NULL, FALSE, '2025-01-18 21:05:00+00', '2025-01-18 21:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'What are Progressive Web Apps (PWAs)?', 'PWAs are web apps that use modern web capabilities to deliver an app-like experience.', TRUE, '2025-01-18 22:00:00+00', '2025-01-18 22:00:00+00'),
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are Progressive Web Apps (PWAs)?', 'They can work offline, be installed on devices, and send push notifications.', TRUE, '2025-01-18 22:10:00+00', '2025-01-18 22:10:00+00'),
('67f2070a-0399-485a-a8e1-e73241df52c0', 'How do you implement offline support in web apps?', 'Use service workers to cache assets and API responses.', TRUE, '2025-01-18 22:20:00+00', '2025-01-18 22:20:00+00'),
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you implement offline support in web apps?', 'Store data locally and sync when online.', TRUE, '2025-01-18 22:30:00+00', '2025-01-18 22:30:00+00');

-- Arjun Kumar R (f8adc086-3c84-4038-820d-5e1cf0d63d39)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'What is system design and why is it important?', NULL, FALSE, '2025-01-19 23:00:00+00', '2025-01-19 23:00:00+00'),
('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'How do you scale a web application?', NULL, FALSE, '2025-01-19 23:05:00+00', '2025-01-19 23:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'What is system design and why is it important?', 'System design is the process of defining the architecture and components of a system to meet requirements.', TRUE, '2025-01-20 00:00:00+00', '2025-01-20 00:00:00+00'),
('e657b686-9443-4cc9-800b-bc7fa4985e35', 'What is system design and why is it important?', 'It ensures scalability, reliability, and maintainability of applications.', TRUE, '2025-01-20 00:10:00+00', '2025-01-20 00:10:00+00'),
('306f8931-2603-4c86-b3ab-f804c2c5be57', 'How do you scale a web application?', 'Use load balancers, caching, and database sharding.', TRUE, '2025-01-20 00:20:00+00', '2025-01-20 00:20:00+00'),
('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you scale a web application?', 'Deploy across multiple servers and use CDN for static assets.', TRUE, '2025-01-20 00:30:00+00', '2025-01-20 00:30:00+00');

-- Priyanka KS (ffbfa1b0-84c5-45fe-8f31-2eda223ac751)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'What is data visualization and why is it important?', NULL, FALSE, '2025-01-20 08:00:00+00', '2025-01-20 08:00:00+00'),
('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you implement real-time features in web apps?', NULL, FALSE, '2025-01-20 08:05:00+00', '2025-01-20 08:05:00+00');
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is data visualization and why is it important?', 'Data visualization helps communicate information clearly and efficiently using charts and graphs.', TRUE, '2025-01-20 09:00:00+00', '2025-01-20 09:00:00+00'),
('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'What is data visualization and why is it important?', 'It enables quick insights and better decision-making from data.', TRUE, '2025-01-20 09:10:00+00', '2025-01-20 09:10:00+00'),
('1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you implement real-time features in web apps?', 'Use WebSockets or libraries like Socket.io for real-time communication.', TRUE, '2025-01-20 09:20:00+00', '2025-01-20 09:20:00+00'),
('399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you implement real-time features in web apps?', 'Leverage server-sent events or third-party services like Pusher.', TRUE, '2025-01-20 09:30:00+00', '2025-01-20 09:30:00+00'); 