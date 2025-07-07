SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', 'a241f0d2-17b5-40d1-a7ee-425cad6ad53d', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@focus.com","user_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","user_phone":""}}', '2025-06-29 19:22:07.122184+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '814402c3-6ae6-4ae3-a756-48c9b267e975', '{"action":"user_confirmation_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-29 19:44:42.068002+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ca36c950-4c41-4b24-887e-5ff90b12ae96', '{"action":"user_signedup","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"team"}', '2025-06-29 19:45:05.126174+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'afd8329f-0e3c-4cc5-88b2-55f22de5be4e', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-29 22:17:54.80811+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1d184e9a-66c8-4b31-b934-2c655f79f82e', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-29 22:17:54.809599+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'bdb913d0-bf75-4231-b9c9-4e8c8d092c2e', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:20:11.900952+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fdf118a4-c4e3-472e-8032-891c15f047d1', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:20:28.588863+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5143380c-7124-45f7-a039-b5c5f83f229a', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:28:26.933431+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '703e2dc9-2441-4067-8d08-44c2100d5707', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:28:33.03927+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '582b57a7-1a3f-4986-a25f-304c22a6c4bc', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:28:36.208481+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '170e8cbd-9142-405c-ba74-1fcdf4f71b3a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:29:28.629928+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '90ab0bf2-577c-4648-a5f8-118942f4bafc', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:29:31.728314+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '19e64f8d-5342-4be4-960d-62c1f71608bb', '{"action":"user_recovery_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-06-29 22:30:03.478044+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7e4109ed-a043-4ecb-b61b-fd26471783d7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:30:50.110332+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1209345d-fa13-401e-8bd2-ee7d6e16ebde', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:31:26.103646+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c39d36e7-c047-4998-bcdc-65dc63b13c52', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:31:31.079402+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'cf87bd93-1c57-4f49-9879-a84b92a746a4', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:40:18.729609+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '12fb8efa-9c61-4baa-948f-11deb3a47642', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:40:26.298697+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9d5799c6-b125-4caf-89d7-e36bc49c40e5', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:40:31.904669+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b43eb59c-2f51-42be-b93a-3ce93eb8fd34', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:17:55.474222+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c09f3c76-c4a9-4afd-b04c-3cc5ec3646b4', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:18:01.254257+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b2558dc6-b9d3-413b-aebd-ba9665a114b9', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:21:12.491295+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '706b030c-7fb4-4439-8e84-9b434f7534f4', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:21:17.832525+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '888df3b9-b538-4881-9a09-e42feb2f1815', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:23:35.801373+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'cf817116-ac19-4757-9171-1db5196c90e7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:23:42.407452+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd91db514-956e-4ca7-89e0-1e7d255daabd', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:30:10.393676+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f6ac36e0-445f-44f4-ad0c-2f164be3bb80', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:30:23.465844+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c7374440-e081-43b7-8d01-5d6ef5eaff1b', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:33:16.224381+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2e6a577f-a3ef-40f4-98ee-e78c949df919', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:33:20.663808+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9d591a8a-dfee-4ee8-a0ec-03875b66e300', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:35:18.898228+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3fc31b1e-6bfe-409e-8fd4-7e9d83fbfda5', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:35:25.933742+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'bc8cf643-5dd6-4cd8-8631-503a8a23266b', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:39:22.332913+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd7c9674d-0f7d-4656-9185-58aeba002c0c', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:39:26.513907+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '98214640-a84f-4c53-8829-9a9c0523db15', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:41:41.845218+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'a40e7c74-1b18-44c4-92b4-c59be7399e24', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:41:45.980413+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6b9b84a6-3229-459e-a925-d7749806bfa3', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:50:46.324756+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b2a8ce0c-98dc-4747-be08-514083822015', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:50:50.857801+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8f931198-8026-49d8-b63b-0a3428d6f5e0', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:52:25.785186+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '649af5ce-e897-4206-8a0a-10a27b3d7c58', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:52:30.231633+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2ec080c4-0421-4832-ae0e-f456f61fc757', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:02:21.059069+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'a88da835-7264-4793-95bc-1cac544a0bf7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:02:25.012233+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ce72ce7f-c0e0-4dc5-b8ce-b9e7af378c35', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:02:46.693487+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fbca34ec-bbe4-45b1-bcfa-49fa926393a7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:02:50.488782+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3fc11cf5-da91-47f3-8aac-4c4982f0c050', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:03:01.271349+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f5cf5544-5470-4dfd-a73f-0ddd86b6d407', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:03:05.410237+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6e149de9-4ea0-4703-9caf-e37c559805b5', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:07:05.267627+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '483c1b54-5c4f-4647-966f-6d43df35df69', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:07:09.58244+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'de13c7fc-3cd7-484c-a293-151dfc0b8681', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:07:29.197266+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7bdf9945-bfbc-48f0-b81e-b9c090d86f9e', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:07:33.406766+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fe9837f8-ed74-4b84-8ef3-f6d0b10ba2b9', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:35:11.591289+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c2f7ec2c-3819-4fc8-a40b-68d8dd8c70d1', '{"action":"user_signedup","actor_id":"d36c190e-3790-4f8a-b17d-7d4c1f550cb2","actor_name":"Kamlesh K","actor_username":"kkamlesh@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:36:15.334698+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fd236c5b-8728-45bd-9e94-8b598fc50920', '{"action":"login","actor_id":"d36c190e-3790-4f8a-b17d-7d4c1f550cb2","actor_name":"Kamlesh K","actor_username":"kkamlesh@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:36:15.339176+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0db26f13-97bb-4f8f-a4a0-f924a4d67813', '{"action":"logout","actor_id":"d36c190e-3790-4f8a-b17d-7d4c1f550cb2","actor_name":"Kamlesh K","actor_username":"kkamlesh@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:36:18.004966+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7c16fdea-b01e-4aba-8fde-bd532e1de03f', '{"action":"user_signedup","actor_id":"399e5ea7-4664-4c3c-81d3-b983814d106a","actor_name":"Arjun Reddy","actor_username":"reddyarjun@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:36:46.979682+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ea1c4077-599a-4b8e-9253-19d9b0f7c9d9', '{"action":"login","actor_id":"399e5ea7-4664-4c3c-81d3-b983814d106a","actor_name":"Arjun Reddy","actor_username":"reddyarjun@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:36:46.984063+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1d58b435-62e1-4b87-8953-2607a2c16fb3', '{"action":"logout","actor_id":"399e5ea7-4664-4c3c-81d3-b983814d106a","actor_name":"Arjun Reddy","actor_username":"reddyarjun@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:36:49.069496+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9953800a-932a-4f16-927a-9083a5f6d642', '{"action":"user_signedup","actor_id":"f8adc086-3c84-4038-820d-5e1cf0d63d39","actor_name":"Arjun Kumar R","actor_username":"kumararjun@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:37:33.762954+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2522932a-1d12-4727-9d8b-ebe21c47f2df', '{"action":"login","actor_id":"f8adc086-3c84-4038-820d-5e1cf0d63d39","actor_name":"Arjun Kumar R","actor_username":"kumararjun@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:37:33.766006+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'a632c6f1-1a7e-4d8a-859e-7e0cb2d8a653', '{"action":"logout","actor_id":"f8adc086-3c84-4038-820d-5e1cf0d63d39","actor_name":"Arjun Kumar R","actor_username":"kumararjun@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:37:36.271204+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '21c82401-0189-4fa7-9a43-499bf2110858', '{"action":"user_signedup","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:38:02.263059+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9e586c3a-939d-40b8-a461-8dcbee696db0', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:38:02.266061+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '722fdb1a-fc11-4066-aea0-7d3d5f891812', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:38:04.807272+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e9255565-8c8f-4144-81f9-0899bd382292', '{"action":"user_signedup","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:39:16.702146+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4857a8c2-4245-43ca-a170-219f06c7cb91', '{"action":"login","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:39:16.705963+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd465ff88-f0d4-424b-95c2-8ab3e5db8fa4', '{"action":"logout","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:39:19.739256+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4fdb1f76-e842-4a2d-8b9a-75e666d30f79', '{"action":"user_signedup","actor_id":"67f2070a-0399-485a-a8e1-e73241df52c0","actor_name":"Vishnu Singh","actor_username":"vishnusingh@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:39:56.97092+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2577cf00-15ec-49a8-938e-50ae6de40eda', '{"action":"login","actor_id":"67f2070a-0399-485a-a8e1-e73241df52c0","actor_name":"Vishnu Singh","actor_username":"vishnusingh@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:39:56.97403+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '487d2091-82f9-4b33-a071-b4dd05de842e', '{"action":"logout","actor_id":"67f2070a-0399-485a-a8e1-e73241df52c0","actor_name":"Vishnu Singh","actor_username":"vishnusingh@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:39:59.967588+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ac3aaac8-61f3-42cb-84eb-183156decbbb', '{"action":"user_signedup","actor_id":"68e5b8aa-c6b8-4e2d-a303-a1c10717837b","actor_name":"Vishal Reddy","actor_username":"reddyvishal@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:40:52.295348+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '19d0434b-71d1-4711-8acd-cd9fb02f652a', '{"action":"login","actor_id":"68e5b8aa-c6b8-4e2d-a303-a1c10717837b","actor_name":"Vishal Reddy","actor_username":"reddyvishal@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:40:52.299051+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '269112a6-a0b1-4f24-b60a-92e5d141aa83', '{"action":"logout","actor_id":"68e5b8aa-c6b8-4e2d-a303-a1c10717837b","actor_name":"Vishal Reddy","actor_username":"reddyvishal@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:40:55.458552+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c0f483b8-921c-4d8a-99e4-d9560d7273f8', '{"action":"user_signedup","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:41:53.901055+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ca707b55-51dd-4ab4-bf78-1603201da112', '{"action":"login","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:41:53.904345+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd78f6485-76f2-41fd-bd49-c91c91ea7669', '{"action":"logout","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:41:57.263395+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd02c6650-86c5-4c93-b60b-5fe5ba396444', '{"action":"user_signedup","actor_id":"702dc5d1-9186-4350-b20f-d3007319a327","actor_name":"Bhasker Singh","actor_username":"singhbhasker@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:44:07.089675+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3431c628-9437-452d-95f0-f07f0e9ccfb2', '{"action":"login","actor_id":"702dc5d1-9186-4350-b20f-d3007319a327","actor_name":"Bhasker Singh","actor_username":"singhbhasker@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:44:07.093498+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9576e258-4b4b-43f4-8c3f-4f4a2a0cf89f', '{"action":"logout","actor_id":"702dc5d1-9186-4350-b20f-d3007319a327","actor_name":"Bhasker Singh","actor_username":"singhbhasker@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:44:10.075737+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8f5717bf-6516-4f93-a366-9353dd3668c7', '{"action":"user_signedup","actor_id":"e657b686-9443-4cc9-800b-bc7fa4985e35","actor_name":"Parinita Reddy","actor_username":"parinita.k@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:45:00.798176+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'a4d1c191-6e5d-4ca7-92cc-6e5ac8e026ef', '{"action":"login","actor_id":"e657b686-9443-4cc9-800b-bc7fa4985e35","actor_name":"Parinita Reddy","actor_username":"parinita.k@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:45:00.801848+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '94d3c8b3-ec8d-4926-95ac-82126cc8e463', '{"action":"logout","actor_id":"e657b686-9443-4cc9-800b-bc7fa4985e35","actor_name":"Parinita Reddy","actor_username":"parinita.k@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:45:03.490673+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '39c406cb-a60c-42dd-b383-1a31f622509a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:45:08.659629+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd3a737c9-2bbb-4cc5-9f47-c979d9fce1bd', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:55:45.356342+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2a092e0b-ea6a-4988-aaec-9d89c253b037', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:56:11.419646+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8104541f-05d6-4478-80cb-f50e3cca47b9', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 01:01:10.672271+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ec6fe9d3-7f85-4167-a12b-3eb58657440f', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:01:15.351084+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '34862e54-588b-4378-92af-72086d1bb864', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 01:01:38.411633+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '489d6425-beb1-4416-8daf-7e07786068aa', '{"action":"login","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:01:54.599955+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c98c3635-4695-4857-8fa4-03060021facb', '{"action":"logout","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 01:02:29.29485+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '40385356-2e8d-427a-8c8b-841c1be85b5d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:02:37.612564+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6e5a40a0-969f-4b41-afb9-58dd0b7a33da', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:17:38.107661+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8aca09f2-81e0-4763-8531-c2af9e10c130', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 02:15:53.563589+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '58834bc2-f75d-40a9-9e04-bdd4f002a7b8', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 02:15:53.564555+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8442a256-4160-4064-8256-182e185f8977', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 03:14:03.637137+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '07dda278-25ce-4528-a6dd-690144eeef9a', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 03:14:03.637937+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '74dbed75-30b0-4850-84b5-ff9f49852f91', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 04:12:26.05562+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c60ea5b1-185e-4853-a597-fbb001be2523', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 04:12:26.056423+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9921280b-c32c-4b2d-be47-cf2ce2afab5b', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 05:11:28.545677+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3cc5aaa6-3dd4-451f-a4d9-56f87c9b8944', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 05:11:28.551081+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3d5105f3-ef03-4e42-b64d-c315d4e197b6', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 05:40:12.537804+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '18c11444-b068-4dba-9d46-db2fb06d28b6', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 06:10:00.495662+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '19fd4ba8-d53c-4790-a0f7-31a6c7ee73cc', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 06:10:00.497231+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '713cd5f6-cc00-47f8-b6ea-fc3fe384e392', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 06:10:04.27473+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2fea3e89-9d01-4a94-a3d0-470bd8fd6417', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 07:48:35.705778+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3f34d630-37e9-4213-bb66-7fcd28315c1b', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 08:46:41.381524+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6a86226a-6514-4aea-91b1-7633c2a86014', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 08:46:41.38542+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '55602ffd-c91c-4730-9288-be72868a4023', '{"action":"login","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 09:10:52.543695+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd06e716e-f30e-4e42-bc4d-5c7284e13f1b', '{"action":"logout","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 09:11:14.478271+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'be5258ff-a759-47cd-b685-cd87858abe38', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 09:44:44.81532+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '26ee0ca8-9aec-4e35-b35e-7da1743b3059', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 09:44:44.816139+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6168932c-aef6-4f66-abaa-880799deb8cc', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 10:10:46.285409+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ef9163d4-86ec-4706-a287-3c560a312a72', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 10:42:56.208346+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'cb4c4c4c-9a6a-4e6c-b11f-3dccc4f7b6f2', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 10:42:56.20983+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b5a15eb4-38f0-4bae-9ec4-0ff3796b3f4d', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 21:49:31.770203+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ae41847e-c9fa-4c3f-b7c5-d79e45a38286', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 21:49:31.779704+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '145e4bc5-ca8f-4d22-86b3-b835cb89ac97', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 22:12:53.601213+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'bb34ae66-de09-48c2-b5fa-22428dcb79c0', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 22:13:02.457488+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd2acbe08-ff7e-47cc-8eca-c5af5e503163', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 23:11:32.100937+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'deeda7db-a15c-4b5e-a8a8-0a01236f95d1', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 23:11:32.104247+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '662abbd8-7fc3-454c-bf6f-cdb0159c414b', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 00:03:59.593435+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ee4a67e1-74b3-4704-a5bc-fa446b6013e0', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 00:09:37.620287+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4f14b7b5-a6fc-4bfb-8545-0274c44fab7c', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 00:09:37.624187+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0e8b0fbe-61ab-4c9d-8f90-66515268fbb6', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 01:00:39.710914+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5d4ac09b-8b2f-4b30-bc6d-8e3b1c1c5870', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 01:05:20.075557+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6ae7dd1c-d5ad-4656-9f30-0fab09e8b371', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 01:05:55.525404+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '59f48142-ed22-441c-bdb4-83f4533459e6', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 01:45:16.947637+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd74680e5-826b-4231-b180-bf46923ac214', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:31:28.410444+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '005a6e3c-b789-4e19-8820-c0a33b6e4594', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:31:34.415412+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'bccc1c1e-dc41-479f-871c-c1a22c157c6d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 20:08:24.816912+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'a68fbd35-c12b-4c41-925f-0185d6d07edf', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 20:31:12.701708+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c5c80915-d355-4ee6-8e87-ac4fa6b6f68a', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 20:31:20.300477+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'dcbb16a4-4b79-411c-b650-6ba01aa3b4a0', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:22:18.496871+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4cbff8f8-104a-4cf5-a070-8df717326ebc', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 21:29:48.021205+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9bb3cac6-1a65-42ce-a573-6aa3c9aa0589', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 21:29:48.023394+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '155cc478-e09d-45e9-ad22-370b6f52fea8', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:31:21.279897+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9ef77b64-664c-485e-9fc4-316944bbb3db', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:32:28.318123+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2dd5c958-f07e-42d5-96a7-7b18b3635f4a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:32:38.177602+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ee420ec3-e26e-451c-a417-2ba6a11297cc', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:33:32.517244+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3c5b2b19-e8cb-41d7-a8b2-582f1aed071a', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:37:36.937872+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9518bc2d-a9b0-4c23-9190-e580aeab4c1c', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:37:39.660472+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ab0698da-1b23-46e1-a287-17f967361f52', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:37:55.940866+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9077c4e0-df10-4f0e-bbd4-9586ebf2174b', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:37:59.016349+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4c819c6b-0599-4c8d-97c6-77ebe5a071b3', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:38:07.088592+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '87408ffe-1ce6-4a97-8c91-35cd3be60ae9', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:39:43.988689+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2f55fd14-19f8-4fb8-aea9-759f43b345ae', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:39:51.964857+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1c4007ea-cf86-4fa5-9c72-80d01b495a77', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:43:33.90903+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '08bcb718-b5d4-4e78-9077-ba4498490e27', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:45:56.070487+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0e51f90f-f081-4735-95ef-e00b1eefe2a4', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:46:01.156369+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6e73ea6b-cdec-4b42-8bdd-dba652c34f75', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 22:48:22.720829+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd072ffd5-887f-44ad-9ecd-e1a2885a9040', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 22:48:22.7237+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c60233fa-a1f7-43e8-afbe-d755b08c83a2', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 23:22:16.049579+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'bfa258b8-31d9-4d01-9a5e-18b1fc8f3eb9', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 23:22:23.369447+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0230f245-b82e-4787-91ed-8d2c86850e77', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 23:25:46.269836+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b7faaa0c-50dd-42a1-acef-b4b16c030f8b', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 23:25:51.549874+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f6d8f222-15c6-44eb-8998-9847e809392f', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:04:49.112874+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '29aab70b-6cd1-46a0-84ff-f923af68a8ff', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:04:54.360128+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '896f5263-8f1b-4ebf-b887-c5f64de31d3d', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:07:59.644837+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b1301e69-3db3-46f7-a78c-dbe2fdb2932a', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:08:05.829169+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2c0e3f57-560e-4eb4-8307-860063c138d4', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:08:41.930943+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0c18b435-6a26-4abe-8e05-ec9d0af27373', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:08:48.04376+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2cb40bd2-e4f3-479c-b08f-5aaf0e61d393', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:10:50.073849+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '18755e6b-f227-4d08-a2aa-865139ad891f', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:11:03.670794+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9835652f-bff0-4a54-852e-96934c451c92', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:11:12.477978+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e158006a-1b67-4f2c-bff2-37809fe3ff29', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:11:17.537436+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ebc053c5-d27d-4a5b-85fc-96573eec9c62', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:12:43.973886+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '80446f25-82c1-4d38-9148-96d6d99c9dc2', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:12:49.178142+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '62f77257-a494-4e8a-b2ad-adfdc78fd2de', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:14:00.150164+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '42d5428c-cacc-4980-bc3a-224960f553ca', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:14:05.174617+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '65535c9e-6983-41ed-97fc-23b125f9076f', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:14:10.40243+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0cf5c288-d97a-45a1-ab14-2ba5185851b3', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:14:20.886661+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0e41d651-d9d1-45d2-89b4-7778bfd44a2e', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:15:39.802265+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e72ec2f5-af7f-480f-a077-dbec521db931', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:15:45.817107+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b065513b-1213-4e28-8f9f-f13095903f87', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:17:43.480487+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd8bbccb5-4f5b-4e42-874a-8b8a2a99e7cb', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:17:48.331634+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0f6117d7-9263-47a8-84b9-2da51ecd8f5f', '{"action":"user_updated_password","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:21:12.82389+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '283eb720-7735-4601-889b-8f066ca2cc3b', '{"action":"user_modified","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:21:12.825507+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '38c122d0-8e14-44ab-8c3d-d254bcc7373c', '{"action":"user_updated_password","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:22:15.410494+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '72ea3ea0-25e2-4d85-8b49-0dbf202ee731', '{"action":"user_modified","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:22:15.411141+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0d0032e9-07ac-4523-99e4-0d4694471e0e', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:43:35.975056+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '34e9e31e-cb1d-4bc4-a151-1f245ffee0c4', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:53:21.671689+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1b495f1d-89a5-40fd-9c77-535b88eb6fe6', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:56:23.230466+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fbeba7b1-0f6c-44e3-8480-eae29f3ded26', '{"action":"user_signedup","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-02 01:17:23.380314+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ec44abb9-bfa6-45c6-9176-712e492c5daf', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 01:17:23.38812+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f495165c-d88e-4a63-8458-4ec3cf9340d7', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 01:25:23.147427+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '46e06123-3529-48db-b5cc-14802edb718b', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 01:25:31.299845+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'a11d55a5-bdf3-49da-9dbc-8846ffad1ec6', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 01:25:50.060629+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'cad50268-c369-4f11-a920-46ca2ac5f38d', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 01:25:56.254599+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f493e8c1-e21c-4ab3-9890-6113984701d4', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 01:26:04.073915+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f1476a9a-b2af-42df-9a62-c66ca7ef474e', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 11:27:51.141732+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '48ab553a-1ccc-4523-bde3-b0cff6e1d0a7', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 11:28:25.273144+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '864dad27-8221-4ae8-b5c5-15ce38ca7e97', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 22:05:16.180236+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8ec12a22-7822-463c-b07f-556997afd2c7', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 22:05:16.190302+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0493e1e9-2a54-401c-a78a-7824b4e9438d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 22:16:54.45633+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4868dea9-159d-4bcd-a90f-85e682123800', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:03:45.374284+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6f958c07-27fc-48b6-ae66-c9787f294184', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:03:45.377797+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '76971c2d-c3d9-4389-a4a4-a8d90ca24bdf', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 23:05:22.535983+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '49ff544f-a7e5-4bb7-af2b-2d55b93161f4', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:15:25.110588+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5dfafe23-56ca-40b7-9875-f1913c441fd5', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:15:25.116666+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '54c851b6-6dfe-421e-9a9f-96c1c7a87688', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:01:00.159782+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b4165f95-32d6-4222-8e49-1e210e6736a4', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:01:25.939913+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5ba0d498-5659-4690-b660-11a874de3e32', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 00:01:59.363163+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1df15d13-07f0-416f-8cfa-06556fa7c3ac', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 00:01:59.3637+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7a4ab5ef-edd1-46fd-b772-1c638e1d6a8d', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:02:10.817083+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6b6950e2-740f-4515-8d1e-4ad3b736e079', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:02:31.282631+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e4845ec7-aa04-43e4-a5c0-6666a9361a1a', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:02:36.741209+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '96c5d721-4266-42ae-bf7d-cf2384bda8ab', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:07:44.948477+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c72c1051-9413-46b4-bb96-c97f57d5d1e7', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:11:50.806564+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8ee64614-ee4a-4449-a432-cbc510282e27', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:13:51.713389+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '77103473-000b-4c37-af3a-06af7052f562', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:13:53.67542+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ea46ca1f-c215-46e6-a10f-34f7eceafb9b', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:14:23.597473+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0ce7ff04-803a-44e8-b108-eae69eb8e8a6', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:14:23.987993+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fc1254d9-5ef2-4ce7-ad34-5ad4a679e72b', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:14:36.750136+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'be3739ac-e5b7-416c-9003-9d1703f7ea51', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:24:40.115325+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c0de857f-3857-4119-9a45-d53eaec7f44b', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:00:23.238358+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0e20eb53-94a5-4b76-b0e7-cf1e886ff53c', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:00:23.240487+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ecc97c20-c1db-4313-9d5f-ee4895efd537', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 01:01:37.71495+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8504603b-af2d-4d3a-ad54-eb4e9d89a3b9', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 01:04:52.505441+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ac8c5ab9-cbc1-4d8a-ba1b-c9281ac6b37d', '{"action":"token_refreshed","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:13:01.645456+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5f61aa82-5b44-4105-a6ae-42bf08b8cbdc', '{"action":"token_revoked","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:13:01.648774+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1e5fdeac-f26f-4857-9cb9-1711f200d01a', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 01:13:21.235939+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'eb465c4d-df4c-4cbe-ab6a-579efab6afa3', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 01:17:34.175548+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '54733244-a221-4fe4-bb52-5fd00d1cdcc4', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 01:17:41.17927+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '81ac377a-166b-4ba7-9e67-a3e61a8ba607', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 02:16:24.246617+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4e576418-916d-4215-be6d-c6d72e08f0b2', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 02:16:24.248891+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5a7225bb-b9f2-49b9-9bd2-6484079c28dd', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 02:56:35.894045+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f31662c5-8ed0-49ef-9043-552d5ffc5bbc', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 16:18:36.529914+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'eb5deafb-75c1-4348-9d57-00d0a6779a6c', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 16:30:20.53198+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9e2bff4c-9b3e-414a-a302-14f585f1baa5', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 16:32:58.303487+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2da0d171-139b-4e5a-b160-a66d2a7dd99e', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 16:35:54.181916+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e5b4d12e-9de6-4269-87db-f023ad3e8161', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 18:54:50.63322+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2c96ffa0-54bb-4acb-9d24-a3d5cdbe4889', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 19:54:08.378903+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '92c75e66-ae50-449f-9b1a-7a4783352dd8', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 19:54:08.381604+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3ac6137b-cf07-4f4f-ad94-74b8e686a510', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 21:06:49.639176+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6be9f880-3864-4960-ae75-8c202364a9f1', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 21:06:49.644373+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0cefe841-a9a3-48c6-b790-8cf9744a0cd5', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 23:07:52.93473+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '9335700a-61ea-4fbb-adce-7c14e0a6f903', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 23:08:02.378435+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '89ce1c6d-3e34-43cc-ad6f-12ba7698dd6a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 01:46:19.85137+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ae558788-c3a7-49e5-977a-ed832257f814', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 01:46:40.38731+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4de319c5-2aef-4fae-aaf2-d28216534d1d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 01:46:47.470574+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '095eea92-9cd0-4a3e-84fc-fb174e9bee0d', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 07:35:26.124254+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3fe03229-c2ee-4e55-90a9-bab816f44b6c', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 07:35:26.129794+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '2dff0d3a-76b1-44f2-a9d1-d6299c0f307e', '{"action":"user_signedup","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-04 12:25:16.870388+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd5c39889-238e-4a95-8ab9-f404eef5c93b', '{"action":"login","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 12:25:16.889814+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd18d5039-f770-4c4d-9035-946c31332802', '{"action":"logout","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 12:25:49.382767+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c5977b3f-bb6e-453d-813b-b83a12e454f9', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 14:49:49.738377+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd9150692-68ff-4014-8bff-26d1b89ca024', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 14:49:49.742763+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '56f77f83-e6ae-4ed5-96c0-0ced1940a8b2', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 14:49:57.048604+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3bc5c5d7-c236-456a-aa0f-cc69de1da2cf', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 14:50:25.125037+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e28446e3-4cc4-46c2-814a-4e42bdba17f3', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 14:51:53.736648+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd953a6c9-7a63-408f-bd3b-a5a992e8888c', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 14:52:06.891697+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ee4b4b3d-fabd-4b30-a207-006d653040b1', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 14:57:35.61369+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'de921466-c20b-4b16-ad7a-6b66b81cc436', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 14:57:45.151846+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b869a65a-8e2d-4850-822b-af4d2090ef77', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 15:01:01.739641+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8da53088-6b59-44fd-86bd-e833286e2e62', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 15:01:35.154337+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e4ad10bf-4e5e-4906-a0bb-463e5c280bc0', '{"action":"login","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 15:19:42.79348+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd232c2c2-8be8-411f-8f31-f89ad409e468', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 15:57:58.583048+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '51074b83-03af-4241-96d2-63414e5eca54', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 15:57:58.585824+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fe082806-2edb-429f-8167-0e0f2df64b0f', '{"action":"token_refreshed","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 16:19:04.750567+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd8018905-ceff-401a-b177-1b40ab27234e', '{"action":"token_revoked","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 16:19:04.752115+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ff8a0c2d-4bce-47e2-a73d-76e6e892d46f', '{"action":"token_refreshed","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:17:44.726504+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '88c3dd9d-66fa-457d-81f5-e3f7873169f5', '{"action":"token_revoked","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:17:44.729783+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '52e6fe16-2445-4e6a-ab6c-a0720019f5fb', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:25:14.487539+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c5624512-2677-40f3-b8d6-295c88f6e85b', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:25:14.490118+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '74e32280-75e9-40fb-aca6-01a5178da60a', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 19:22:21.757506+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd485b243-1c98-489d-9f3e-a602659b41b2', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 19:22:21.760228+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e1fef8a5-a5cd-4bbb-a835-bcc57af77639', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 23:49:48.445902+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c50d3cff-38ab-4dfc-a56a-5380ce67b35d', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 23:49:48.45546+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ec1b6685-3009-453e-950c-b26bf130bb9f', '{"action":"token_refreshed","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 00:16:41.659078+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7d744865-e00f-4b45-973c-6f652fc0a23e', '{"action":"token_revoked","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 00:16:41.661176+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7af5bbaf-1828-44ab-a0ed-970c665dabfa', '{"action":"logout","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-05 00:28:36.162892+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '79555afc-ee71-4ce8-97e2-5774c9da10f5', '{"action":"login","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-05 00:28:41.271331+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1c7b3ddd-3866-4c35-bc5c-50c86a8b5ea6', '{"action":"logout","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-05 00:29:10.555147+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5d9bb68f-b58f-4549-8417-d88485ca2299', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 00:48:01.622039+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b97431a0-a5fc-4c77-aa56-c6bbfc3ec516', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 00:48:01.623551+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4d7204d0-e3ec-44d1-8bff-e9544a6c4438', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 09:08:30.320539+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '45359c1e-253c-44d9-86c2-15415ea76fdc', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 09:08:30.325978+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c4f7519a-0251-4112-be07-d154eb4c8acf', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 14:54:01.906972+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3f4f718c-0d81-4d66-b744-1ba269e77380', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 14:54:01.921649+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '56fefcba-f700-4b43-9503-e7af3e3f9556', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-05 14:54:36.458149+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5f58917f-b5ea-4fd6-9a10-1463436ff63e', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-05 14:54:46.179518+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'cf43a78a-2f4f-4e84-ba66-b8802b98ac6d', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 16:03:43.652728+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5c448a43-5dcb-4f41-a1fa-f222f3bc6891', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 16:03:43.655198+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '23083cc3-f38d-4ca7-80e0-9af087802b9c', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-05 16:03:49.118948+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '48c39259-663a-4378-ae3d-9ca7ddff1633', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-05 16:20:11.075925+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0f8f8dfd-3194-470f-9363-5f3c3100e739', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 23:08:32.134813+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3f9cc6d5-d761-450b-8b10-0df08f53718b', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 23:08:32.143097+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '49a54ac9-ff47-4c3c-a24e-9ddb0df4a375', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 01:26:49.688664+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '8010a60b-2776-4fd2-9d2a-e49ba2682664', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 01:26:49.696763+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c757d358-977f-44a5-8b7b-2be2d796a077', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 03:09:35.805444+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '41deeb83-ed75-4552-8916-3b598c76e00d', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 03:09:35.810149+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '94318fa6-23e0-4bca-9d49-f0622dc73b0f', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 04:09:21.331545+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'fbc119fe-2ccc-44eb-9bdd-9a0bfbd0fac4', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 04:09:21.335484+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e4a624b3-f9d4-4200-af6d-83512d4f4ccd', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-06 04:54:19.32067+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '50c7d13b-d35c-485c-8eb4-7beace368ed9', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-06 04:54:26.322283+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'cafc5214-2563-411e-8259-68c68383352b', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 10:57:57.928447+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '1d327972-b3d5-405b-aa90-dc111674f142', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 10:57:57.931212+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '26e6fb2e-3261-493c-a934-eed372d784bd', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 11:56:49.487552+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'dc3039fd-9fe2-46cc-8772-fefc6cdfa3e7', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 11:56:49.493612+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd82ac53e-e287-44ef-b9a8-c872b4faf3b8', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 16:52:35.53271+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '6fd1288f-15d9-4147-bff3-3ec45ba83e18', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 16:52:35.54242+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '19457c3c-0aa6-4a38-b9ad-db86a1549d76', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-06 17:30:39.369098+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0041c2a3-bf05-418c-8b63-404b77758d49', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-06 17:30:57.157304+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ce5372b7-8cdb-4bbf-8398-10b4424cbbe4', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 20:38:29.762264+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5b85d587-73ff-488e-9302-1aa91f0e0975', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 20:38:29.763732+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7a2de442-bd2b-4884-acb4-73c5f4186641', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 21:37:11.123037+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '46c9073b-0a1b-48c8-8bf1-8b846ef6951b', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 21:37:11.130381+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f4de3ed2-5efd-4bc9-b3fa-0d5ea45f6b61', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 23:01:43.105044+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b61a73f8-5a98-4525-9132-8889bd37d525', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-06 23:01:43.110689+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ca6be4d2-98d5-42c1-92ce-dc2771466567', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-06 23:26:58.014131+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '57400cdf-e9d6-4276-8f0f-ac22f3d95eaa', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-06 23:27:05.722991+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '3435a995-159e-46ce-8e96-ccbbd9e85900', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-06 23:32:38.309698+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'd8add39f-9051-46c3-82dd-0ccb6a1ca4af', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-06 23:33:03.997211+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ab69f05d-5fa8-47a1-9003-594144340e89', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:26:38.439488+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'b7e904c5-6f15-435b-a94c-94670867fb81', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-07 00:26:43.220581+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '4ebd548c-a157-41d6-b749-63abd68ab0e0', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:26:46.899381+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'cc10dfce-e4aa-471b-8e55-36135c298937', '{"action":"user_recovery_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:28:52.321903+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'c473117b-e5ad-4d96-b712-4ddb6464722c', '{"action":"user_recovery_requested","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:30:24.333082+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '34dee6ff-d87e-44e8-9e2f-fef1412c1a44', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:30:40.013132+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'f29936ca-31ac-4e47-943d-e68f5d900d3e', '{"action":"login","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:30:49.570008+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0ca605c6-a23f-45c9-8151-972d2c0db496', '{"action":"user_recovery_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:32:45.987757+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'a6f48b08-2050-415c-b8b8-1a4ce548726b', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:32:58.424001+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'ce384840-fcb8-419e-904c-4279ee434055', '{"action":"user_recovery_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:36:49.826865+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '94a4a0de-a5b8-4cfc-9b68-94018539e7be', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:36:59.582789+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'e5f6c61d-305b-4f2b-b951-0592bfad2fec', '{"action":"user_recovery_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:39:48.451934+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '38dd2771-98da-449f-95d5-b6303439c5a9', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:39:58.053029+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '610f900b-30e5-4780-a0bd-acb4abe43ec6', '{"action":"user_updated_password","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:40:32.342382+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '06ad82ae-ab3a-495c-afb9-43ce9acc85dc', '{"action":"user_modified","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:40:32.343023+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'dd040b1b-01bd-4658-b526-d4f0a95b506d', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 00:40:36.173148+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '003f9d1a-d4ab-45e3-938d-4e20884f142f', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-07 00:40:47.101083+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5cc01c5c-f1e6-487d-858c-720625eb938e', '{"action":"user_recovery_requested","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-07-07 00:44:18.533134+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'bd210134-7412-4e0f-a8dd-80ac4db6b1c4', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 01:39:31.060244+05:30', ''),
	('00000000-0000-0000-0000-000000000000', 'bfb55fa9-9e29-4b15-935b-58687d3361c4', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 01:39:31.066303+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '763b5496-4bfb-425f-be9b-c2592bdd1c64', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 11:52:02.200752+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0f1e7a31-cdca-4300-93db-9d508ccd13cd', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 11:52:02.208212+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '23f13c5c-40c1-4a86-9270-a425f1291662', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 20:21:33.51815+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '84a904b6-9c00-4a70-9927-6c50ccffee17', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 20:21:33.528133+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '5b29b41f-4845-4477-8e3e-cb1ff7d1526e', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 21:20:17.979025+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '7d545066-05fa-42e1-92ca-14c98b9576af', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-07 21:20:17.980695+05:30', ''),
	('00000000-0000-0000-0000-000000000000', '0c291f16-08e6-40b4-af9b-2b1e283aab7d', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-07 21:21:20.729743+05:30', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'authenticated', 'authenticated', 'priyankaks@gmail.com', '$2a$10$75VIl5wANMIyCPU1onYE.u9CruDl3AAhydNCGcRHZK3eTfnegLPSC', '2025-06-30 00:39:16.702774+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 01:01:54.600656+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "ffbfa1b0-84c5-45fe-8f31-2eda223ac751", "email": "priyankaks@gmail.com", "full_name": "Priyanka KS", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:39:16.694104+05:30', '2025-06-30 01:01:54.603053+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '67f2070a-0399-485a-a8e1-e73241df52c0', 'authenticated', 'authenticated', 'vishnusingh@gmail.com', '$2a$10$C2YBeguoY3nd6pMJpdBoI.ESQMnRBrYlPNaWAfgwKp37jOueElIAm', '2025-06-30 00:39:56.971365+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:39:56.974527+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "67f2070a-0399-485a-a8e1-e73241df52c0", "email": "vishnusingh@gmail.com", "full_name": "Vishnu Singh", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:39:56.966368+05:30', '2025-06-30 00:39:56.976875+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'authenticated', 'authenticated', 'parinita.k@gmail.com', '$2a$10$.BE1kRWyA3E6frx/1lEGsucOx4nnc3HxamoNyW/GZCq7a8ykPXxgO', '2025-06-30 00:45:00.798628+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:45:00.802295+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "e657b686-9443-4cc9-800b-bc7fa4985e35", "email": "parinita.k@gmail.com", "full_name": "Parinita Reddy", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:45:00.793755+05:30', '2025-06-30 00:45:00.804477+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'authenticated', 'authenticated', 'kkamlesh@gmail.com', '$2a$10$.ts4bniyWP0jXRKpkyDeXeVzVLMP2WUJkHDTjuuPd9BePolJUBV62', '2025-06-30 00:36:15.335363+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:36:15.339664+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "d36c190e-3790-4f8a-b17d-7d4c1f550cb2", "email": "kkamlesh@gmail.com", "full_name": "Kamlesh K", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:36:15.319896+05:30', '2025-06-30 00:36:15.347371+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'authenticated', 'authenticated', 'kumararjun@gmail.com', '$2a$10$nJ6PAU67HsEKkkb5ZU4WvO0QAOClkjaARAmoaeN74FMUOouzQgOki', '2025-06-30 00:37:33.76342+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:37:33.766503+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "f8adc086-3c84-4038-820d-5e1cf0d63d39", "email": "kumararjun@gmail.com", "full_name": "Arjun Kumar R", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:37:33.751488+05:30', '2025-06-30 00:37:33.768802+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'authenticated', 'authenticated', 'reddyarjun@gmail.com', '$2a$10$LisWRr3JLgRkxYXvC5qgw.NPuJXkbL5ud3ZgfE4dsU/ddLd0J3dZ.', '2025-06-30 00:36:46.980571+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:36:46.984526+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "399e5ea7-4664-4c3c-81d3-b983814d106a", "email": "reddyarjun@gmail.com", "full_name": "Arjun Reddy", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:36:46.97044+05:30', '2025-06-30 00:36:46.987041+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'authenticated', 'authenticated', 'reddyvishal@gmail.com', '$2a$10$x6ltnoR7uKjbl.3wjgVkpuQtTYo/gmRHorz7qxU4dI3K5Fr5BcP0K', '2025-06-30 00:40:52.295796+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:40:52.299516+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "68e5b8aa-c6b8-4e2d-a303-a1c10717837b", "email": "reddyvishal@gmail.com", "full_name": "Vishal Reddy", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:40:52.290356+05:30', '2025-06-30 00:40:52.30102+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '702dc5d1-9186-4350-b20f-d3007319a327', 'authenticated', 'authenticated', 'singhbhasker@gmail.com', '$2a$10$tYyUax90OKIK20cfWU/qZO7vtSFsPTbmv/P7QX.4cFegVZKhW0BFW', '2025-06-30 00:44:07.090312+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:44:07.093961+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "702dc5d1-9186-4350-b20f-d3007319a327", "email": "singhbhasker@gmail.com", "full_name": "Bhasker Singh", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:44:07.082799+05:30', '2025-06-30 00:44:07.096198+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'authenticated', 'authenticated', 'aakashkumar@gmail.com', '$2a$10$HW/gFLhjF31xLtq24/rFiekMWphEFssdvxcKSVYFmrdIjgMl8kC6O', '2025-06-30 00:41:53.901547+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 09:10:52.549943+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "719c5acf-8f3e-4064-ac1a-00c3692901ba", "email": "aakashkumar@gmail.com", "full_name": "Aakash Kumar", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:41:53.892864+05:30', '2025-06-30 09:10:52.556429+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', 'authenticated', 'authenticated', 'admin@focus.com', '$2a$10$uvGWs2Neq1qnLCgEd.HD3ujORnmzQ.OUHy6esdJteGboD.c8mwTcC', '2025-06-29 19:22:07.128156+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 14:52:06.892364+05:30', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-29 19:22:07.107025+05:30', '2025-07-04 14:52:06.895009+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '1319be79-c9ec-450f-8115-4445c9da6d98', 'authenticated', 'authenticated', 'priyakumari@gmail.com', '$2a$10$hiPgKPsfQIm.MQTXR0pyYuIv2wVEXKGT45BlS/V1Dt7Hg01iZO0zG', '2025-06-30 00:38:02.263492+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-06 23:33:03.998618+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "1319be79-c9ec-450f-8115-4445c9da6d98", "email": "priyakumari@gmail.com", "full_name": "Priya Kumari", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:38:02.258432+05:30', '2025-07-06 23:33:04.004301+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'authenticated', 'authenticated', 'jignesh.vision.17@gmail.com', '$2a$10$WxfRhE20DWIp7z.RzgIH8uCZm90rtNBaUKrnLdNxuUQfal2BcRTdW', '2025-06-29 19:45:05.126854+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-07 00:40:47.101799+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "306f8931-2603-4c86-b3ab-f804c2c5be57", "email": "jignesh.vision.17@gmail.com", "full_name": "jignesh", "email_verified": true, "phone_verified": false}', NULL, '2025-06-29 19:44:42.054603+05:30', '2025-07-07 21:20:17.984794+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'authenticated', 'authenticated', 'anjalikulkarni2424@gmail.com', '$2a$10$qEyktmxZml0iem11T2zYJuN4eo5nNZYEnwxkzpHVe1R1f.tOUAsO6', '2025-07-04 12:25:16.878681+05:30', NULL, '', NULL, 'd7599aca4c36cfc756c84bf14e2ad23d579ab5bf295ce5d857258115', '2025-07-07 00:44:18.536957+05:30', '', '', NULL, '2025-07-07 00:30:49.57171+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "2ce68cde-0d58-4a03-9e4c-5e5e041eae03", "email": "anjalikulkarni2424@gmail.com", "full_name": "Anjali Kulkarni", "member_type": "student", "email_verified": true, "phone_verified": false}', NULL, '2025-07-04 12:25:16.809465+05:30', '2025-07-07 00:44:21.272731+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', 'authenticated', 'authenticated', 'google@gmail.com', '$2a$10$ZZDl6OSQ4KY2Aw3qalhnjuMQdNJtylQpUaSUZNguN3BRZIxEdErSe', '2025-07-02 01:17:23.383397+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 15:01:01.743348+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "d84fecf1-b3de-4a54-a2f3-2fd69740d572", "email": "google@gmail.com", "full_name": "google", "member_type": "student", "email_verified": true, "phone_verified": false}', NULL, '2025-07-02 01:17:23.36005+05:30', '2025-07-04 15:01:01.748877+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('d2b3a071-141a-4c3a-8a63-53eaefa012c3', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '{"sub": "d2b3a071-141a-4c3a-8a63-53eaefa012c3", "email": "admin@focus.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-29 19:22:07.120035+05:30', '2025-06-29 19:22:07.121237+05:30', '2025-06-29 19:22:07.121237+05:30', 'f3a0b411-2f9d-4810-a5e8-75fb1541b1c3'),
	('306f8931-2603-4c86-b3ab-f804c2c5be57', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{"sub": "306f8931-2603-4c86-b3ab-f804c2c5be57", "email": "jignesh.vision.17@gmail.com", "full_name": "jignesh", "email_verified": true, "phone_verified": false}', 'email', '2025-06-29 19:44:42.064+05:30', '2025-06-29 19:44:42.064062+05:30', '2025-06-29 19:44:42.064062+05:30', 'c9ad5b8b-9331-4a62-a529-22364032709f'),
	('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '{"sub": "d36c190e-3790-4f8a-b17d-7d4c1f550cb2", "email": "kkamlesh@gmail.com", "full_name": "Kamlesh K", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:36:15.330935+05:30', '2025-06-30 00:36:15.330986+05:30', '2025-06-30 00:36:15.330986+05:30', 'a382845a-9c32-45a2-9f40-9e5afef0a988'),
	('399e5ea7-4664-4c3c-81d3-b983814d106a', '399e5ea7-4664-4c3c-81d3-b983814d106a', '{"sub": "399e5ea7-4664-4c3c-81d3-b983814d106a", "email": "reddyarjun@gmail.com", "full_name": "Arjun Reddy", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:36:46.976397+05:30', '2025-06-30 00:36:46.976445+05:30', '2025-06-30 00:36:46.976445+05:30', '8886a883-2910-4159-ae84-59595bf22cc5'),
	('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '{"sub": "f8adc086-3c84-4038-820d-5e1cf0d63d39", "email": "kumararjun@gmail.com", "full_name": "Arjun Kumar R", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:37:33.760289+05:30', '2025-06-30 00:37:33.760334+05:30', '2025-06-30 00:37:33.760334+05:30', '23f028e6-6f5d-4157-8a00-1f7f2eb55279'),
	('1319be79-c9ec-450f-8115-4445c9da6d98', '1319be79-c9ec-450f-8115-4445c9da6d98', '{"sub": "1319be79-c9ec-450f-8115-4445c9da6d98", "email": "priyakumari@gmail.com", "full_name": "Priya Kumari", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:38:02.26114+05:30', '2025-06-30 00:38:02.261184+05:30', '2025-06-30 00:38:02.261184+05:30', 'f48a98be-fb77-4e78-9f5b-2c29fa294644'),
	('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '{"sub": "ffbfa1b0-84c5-45fe-8f31-2eda223ac751", "email": "priyankaks@gmail.com", "full_name": "Priyanka KS", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:39:16.699203+05:30', '2025-06-30 00:39:16.699252+05:30', '2025-06-30 00:39:16.699252+05:30', 'a536474a-2b9d-4210-89d4-4bca761a01bc'),
	('67f2070a-0399-485a-a8e1-e73241df52c0', '67f2070a-0399-485a-a8e1-e73241df52c0', '{"sub": "67f2070a-0399-485a-a8e1-e73241df52c0", "email": "vishnusingh@gmail.com", "full_name": "Vishnu Singh", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:39:56.969004+05:30', '2025-06-30 00:39:56.96905+05:30', '2025-06-30 00:39:56.96905+05:30', '6612ed83-6985-4ce0-a52a-d7ba807cd994'),
	('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '{"sub": "68e5b8aa-c6b8-4e2d-a303-a1c10717837b", "email": "reddyvishal@gmail.com", "full_name": "Vishal Reddy", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:40:52.293512+05:30', '2025-06-30 00:40:52.293557+05:30', '2025-06-30 00:40:52.293557+05:30', '341f537e-c23b-4938-b844-e08a1cf07d89'),
	('719c5acf-8f3e-4064-ac1a-00c3692901ba', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '{"sub": "719c5acf-8f3e-4064-ac1a-00c3692901ba", "email": "aakashkumar@gmail.com", "full_name": "Aakash Kumar", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:41:53.89814+05:30', '2025-06-30 00:41:53.898188+05:30', '2025-06-30 00:41:53.898188+05:30', '9104fc28-eee7-4b3c-ac09-83177f4c3bbd'),
	('702dc5d1-9186-4350-b20f-d3007319a327', '702dc5d1-9186-4350-b20f-d3007319a327', '{"sub": "702dc5d1-9186-4350-b20f-d3007319a327", "email": "singhbhasker@gmail.com", "full_name": "Bhasker Singh", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:44:07.087333+05:30', '2025-06-30 00:44:07.087389+05:30', '2025-06-30 00:44:07.087389+05:30', '38f8aa3c-0293-4cc5-9d10-25eb2fbae500'),
	('e657b686-9443-4cc9-800b-bc7fa4985e35', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '{"sub": "e657b686-9443-4cc9-800b-bc7fa4985e35", "email": "parinita.k@gmail.com", "full_name": "Parinita Reddy", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:45:00.796201+05:30', '2025-06-30 00:45:00.796251+05:30', '2025-06-30 00:45:00.796251+05:30', 'babd6aef-8fa8-4ab9-b91a-d5e731a3b78e'),
	('d84fecf1-b3de-4a54-a2f3-2fd69740d572', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '{"sub": "d84fecf1-b3de-4a54-a2f3-2fd69740d572", "email": "google@gmail.com", "full_name": "google", "member_type": "student", "email_verified": false, "phone_verified": false}', 'email', '2025-07-02 01:17:23.372109+05:30', '2025-07-02 01:17:23.372169+05:30', '2025-07-02 01:17:23.372169+05:30', 'c58f2b9b-2cc0-4667-8e2f-7b20d71112d8'),
	('2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '{"sub": "2ce68cde-0d58-4a03-9e4c-5e5e041eae03", "email": "anjalikulkarni2424@gmail.com", "full_name": "Anjali Kulkarni", "member_type": "student", "email_verified": false, "phone_verified": false}', 'email', '2025-07-04 12:25:16.855859+05:30', '2025-07-04 12:25:16.85591+05:30', '2025-07-04 12:25:16.85591+05:30', 'afd570dc-1656-400e-8eb3-26ea4eca145c');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag") VALUES
	('4f8e039c-fd53-4ae6-ac0e-9fa474f0fcb9', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '2025-07-07 00:30:49.571782+05:30', '2025-07-07 00:30:49.571782+05:30', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '49.37.177.66', NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('4f8e039c-fd53-4ae6-ac0e-9fa474f0fcb9', '2025-07-07 00:30:49.573558+05:30', '2025-07-07 00:30:49.573558+05:30', 'otp', 'd7ddf44b-6800-409c-b316-058d3b7fb650');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") VALUES
	('e083c6e2-fc66-4c60-8091-4a8da63b0c81', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'recovery_token', 'd7599aca4c36cfc756c84bf14e2ad23d579ab5bf295ce5d857258115', 'anjalikulkarni2424@gmail.com', '2025-07-06 19:14:21.276155', '2025-07-06 19:14:21.276155');


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 155, '32uhmbdmbpce', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', false, '2025-07-07 00:30:49.572467+05:30', '2025-07-07 00:30:49.572467+05:30', NULL, '4f8e039c-fd53-4ae6-ac0e-9fa474f0fcb9');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profiles" ("id", "email", "full_name", "avatar_url", "bio", "location", "website", "settings", "created_at", "updated_at", "member_type", "status", "last_seen") VALUES
	('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'kkamlesh@gmail.com', 'Kamlesh K', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:36:15.319534+05:30', '2025-06-30 00:36:15.319534+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'kumararjun@gmail.com', 'Arjun Kumar R', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:37:33.749964+05:30', '2025-06-30 00:37:33.749964+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'priyankaks@gmail.com', 'Priyanka KS', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:39:16.693123+05:30', '2025-06-30 00:39:16.693123+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'aakashkumar@gmail.com', 'Aakash Kumar', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:41:53.892531+05:30', '2025-06-30 00:41:53.892531+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('702dc5d1-9186-4350-b20f-d3007319a327', 'singhbhasker@gmail.com', 'Bhasker Singh', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:44:07.082442+05:30', '2025-06-30 00:44:07.082442+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('306f8931-2603-4c86-b3ab-f804c2c5be57', 'jignesh.vision.17@gmail.com', 'Jignesh Ameta', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/avatars/306f8931-2603-4c86-b3ab-f804c2c5be57/1751392704971.jpg', 'Full-stack developer passionate about creating amazing user experiences.', 'San Francisco, CA', 'https://johndoe.dev', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-06-29 19:44:42.054242+05:30', '2025-06-29 19:44:42.054242+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('399e5ea7-4664-4c3c-81d3-b983814d106a', 'reddyarjun@gmail.com', 'Arjun Reddy', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:36:46.970067+05:30', '2025-06-30 00:36:46.970067+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('67f2070a-0399-485a-a8e1-e73241df52c0', 'vishnusingh@gmail.com', 'Vishnu Singh', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:39:56.966044+05:30', '2025-06-30 00:39:56.966044+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'reddyvishal@gmail.com', 'Vishal Reddy', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:40:52.290034+05:30', '2025-06-30 00:40:52.290034+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('e657b686-9443-4cc9-800b-bc7fa4985e35', 'parinita.k@gmail.com', 'Parinita Reddy', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:45:00.793431+05:30', '2025-06-30 00:45:00.793431+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30'),
	('d2b3a071-141a-4c3a-8a63-53eaefa012c3', 'admin@focus.com', 'Admininitrator', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/avatars/d2b3a071-141a-4c3a-8a63-53eaefa012c3/1751396238085.jpg', 'Administrator for Focus Hub', 'Rajasthan, IN', 'https://johndoe.dev', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-06-29 19:22:07.10465+05:30', '2025-06-29 19:22:07.10465+05:30', NULL, 'active', '2025-07-03 00:28:55.826567+05:30'),
	('2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'anjalikulkarni2424@gmail.com', 'Anjali Kulkarni', NULL, NULL, NULL, NULL, NULL, '2025-07-04 12:25:16.807825+05:30', '2025-07-04 12:25:16.807825+05:30', 'student', 'active', '2025-07-04 15:28:36.336+05:30'),
	('1319be79-c9ec-450f-8115-4445c9da6d98', 'priyakumari@gmail.com', 'Priya Kumari', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/avatars/1319be79-c9ec-450f-8115-4445c9da6d98/1751314473974.png', 'Full-stack developer passionate about creating amazing user experiences.', 'San Francisco, CA', 'https://johndoe.dev', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-06-30 00:38:02.258108+05:30', '2025-06-30 00:38:02.258108+05:30', 'alumni', 'active', '2025-07-06 17:52:04.617+05:30'),
	('d84fecf1-b3de-4a54-a2f3-2fd69740d572', 'google@gmail.com', 'google', NULL, 'sddsfas', 'asdfadsf', 'sadfsadf', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-07-02 01:17:23.359724+05:30', '2025-07-02 01:17:23.359724+05:30', 'student', 'active', '2025-07-04 15:01:04.161+05:30');


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."questions" ("id", "user_id", "title", "body", "category", "status", "best_answer_id", "view_count", "created_at", "updated_at") VALUES
	('d7275962-7f89-4c14-8e4a-ef7ab80ed662', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'What is a closure in JavaScript?', 'Can someone explain closures with an example?', 'JavaScript', 'open', NULL, 1, '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30'),
	('2080eb1f-bf4d-4d19-9589-bcc026859069', '1319be79-c9ec-450f-8115-4445c9da6d98', 'How do I use React hooks?', 'I am new to React and want to understand hooks.', 'React', 'open', NULL, 2, '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30');


--
-- Data for Name: ai_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."ai_answers" ("id", "question_id", "answer_text", "model_used", "tokens_used", "processing_time_ms", "user_feedback_rating", "generation_attempts", "created_at", "user_id", "generated_by") VALUES
	('3d019b52-f713-4d01-a358-e1f3d7622efb', 'd7275962-7f89-4c14-8e4a-ef7ab80ed662', '**What is a closure in JavaScript?**

A closure is a function that has access to its own scope and the scope of its outer functions, allowing it to "remember" and use variables and functions from its outer scopes even when the outer functions have returned.

**Example:**

Consider the following code:
```
function outer() {
  let x = 10;

  function inner() {
    console.log(x); // outputs 10
  }

  return inner;
}

const innerFunc = outer();
innerFunc(); // outputs 10
```
In this example, `inner` is a closure because it has access to the `x` variable from its outer scope, even after `outer` has returned. When we call `innerFunc`, it logs the value of `x` to the console, demonstrating the closure''s ability to retain access to its outer scope''s variables.

This concept is useful for creating reusable and modular code, as well as for implementing private variables and functions in JavaScript.', 'llama3-8b-8192', 284, 671, 1, 1, '2025-07-06 23:57:21.038063+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98', 'groq'),
	('ae7250d6-a52c-4a7c-94df-f1209529a26e', '2080eb1f-bf4d-4d19-9589-bcc026859069', 'React Hooks are a game-changer for managing state and side effects in functional components. Here''s a concise guide to get you started:

**What are React Hooks?**

Hooks allow you to "hook into" React state and lifecycle methods from functional components. They provide a way to use state and other React features without writing a class component.

**Basic Hooks**

1. **useState**: Manages state in functional components. Syntax: `const [state, setState] = useState(initialState)`.
2. **useEffect**: Handles side effects like API calls, timeouts, or setting timers. Syntax: `useEffect(effectFunction, dependencies)`.
3. **useContext**: Connects to context APIs. Syntax: `const context = useContext(ContextAPI)`.

**How to use Hooks**

1. Import the hook: `import { useState, useEffect } from ''react''`.
2. Use the hook in your functional component: `const [count, setCount] = useState(0);`
3. Update state or trigger an effect: `setCount(count + 1);` or `useEffect(() => { // code here });`

**Best Practices**

1. Use hooks in the top-level of your functional component.
2. Avoid using hooks inside loops or conditional statements.
3. Use the `useEffect` hook with care, as it can cause performance issues if not managed correctly.

Start with a simple `useState` example and gradually move on to more complex use cases. Practice', 'llama3-8b-8192', 384, 1189, NULL, 1, '2025-07-07 01:40:18.147197+05:30', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'groq'),
	('ca141a4c-3f2c-4d44-9b55-baf38c9c562d', '2080eb1f-bf4d-4d19-9589-bcc026859069', 'React Hooks are a game-changer for managing state and side effects in functional components. Here''s a concise guide to get you started:

**What are React Hooks?**

React Hooks are a way to "hook into" React state and life cycles from functional components. They allow you to use state and other React features without writing a class component.

**Common React Hooks:**

1. `useState`: Manages state variables.
2. `useEffect`: Handles side effects, such as API calls or DOM updates.
3. `useContext`: Accesses React Context APIs.
4. `useReducer`: Manages state with a reducer function.
5. `useCallback`: Memoizes a function to prevent unnecessary re-renders.
6. `useMemo`: Memoizes a value to prevent unnecessary re-computations.
7. `useRef`: Creates a reference to a DOM node or a value.

**Basic Usage:**

1. Import the hook: `import { useState } from ''react'';`
2. Call the hook: `const [count, setCount] = useState(0);`
3. Use the hook: `setCount(count + 1);`

**Best Practices:**

1. Use hooks at the top level of your functional component.
2. Avoid using hooks inside loops or conditional statements.
3. Use hooks sparingly to avoid complexity.

Start with `useState` and `useEffect` to get a feel for hooks. Practice, and you''ll become', 'llama3-8b-8192', 384, 685, NULL, 1, '2025-07-07 01:40:40.662683+05:30', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'groq'),
	('9e7e5ac5-4796-4c33-a228-9130c4eb76da', '2080eb1f-bf4d-4d19-9589-bcc026859069', 'React Hooks are a game-changer in React development, allowing you to use state and other React features without writing a class component. Here''s a concise guide to get you started:

**What are React Hooks?**

React Hooks are functions that "hook into" React state and lifecycle methods, allowing you to use them in functional components.

**Basic Hooks:**

1. **useState**: Returns the current state value and a function to update it.
2. **useEffect**: Runs a function after rendering, similar to a component''s lifecycle method.
3. **useContext**: Accesses context (shared state) in a functional component.

**How to use React Hooks:**

1. Import the hook you want to use (e.g., `import { useState } from ''react'';`).
2. Call the hook in your functional component (e.g., `const [count, setCount] = useState(0);`).
3. Use the returned values (e.g., `setCount(count + 1)`).

**Example:**

```jsx
import { useState } from ''react'';

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

Start with `useState` and `useEffect` to get familiar with hooks. Practice and', 'llama3-8b-8192', 384, 691, NULL, 1, '2025-07-07 01:40:42.914564+05:30', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'groq'),
	('0cd0f284-a1cf-424c-8955-2124d11c3b57', '2080eb1f-bf4d-4d19-9589-bcc026859069', 'React Hooks are a game-changer for managing state and side effects in functional components. Here''s a concise guide to get you started:

**What are React Hooks?**
Hooks are functions that allow you to "hook into" React state and lifecycle methods from functional components.

**When to use Hooks?**
Use Hooks when:

1. You need to use state or props in a functional component.
2. You need to manage side effects (e.g., fetching data, setting timers).
3. You want to reuse stateful logic between functional components.

**Basic Hooks:**

1. `useState`: Handles state updates in functional components.
```jsx
import { useState } from ''react'';
function Counter() {
  const [count, setCount] = useState(0);
  return <p>Count: {count}</p>;
}
```
2. `useEffect`: Manages side effects (e.g., fetching data, setting timers).
```jsx
import { useEffect } from ''react'';
function FetchData() {
  useEffect(() => {
    fetch(''https://api.example.com/data'')
      .then(response => response.json())
      .then(data => console.log(data));
  }, []); // Run once when component mounts
}
```
**Best Practices:**

1. Use Hooks only in functional components.
2. Use Hooks in the order they''re declared (e.g., `useState` before `useEffect`).
3. Use the `[]` dependency array in `', 'llama3-8b-8192', 384, 924, NULL, 1, '2025-07-07 01:40:45.846365+05:30', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'groq');


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."answers" ("id", "question_id", "user_id", "body", "is_accepted", "created_at", "updated_at") VALUES
	('2428d72d-2e27-42cb-9d3d-f377a5f2bc3d', 'd7275962-7f89-4c14-8e4a-ef7ab80ed662', '1319be79-c9ec-450f-8115-4445c9da6d98', 'A closure is a function that remembers its outer variables.', false, '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30'),
	('09d41955-4423-4d79-b9c2-b47e3e710023', '2080eb1f-bf4d-4d19-9589-bcc026859069', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'You can use useState and useEffect for state and side effects.', true, '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30'),
	('dff6fa8a-1908-4769-9ddc-8759da6efb7d', '2080eb1f-bf4d-4d19-9589-bcc026859069', '1319be79-c9ec-450f-8115-4445c9da6d98', 'sdadasd', false, '2025-07-06 23:08:56.901964+05:30', '2025-07-06 23:08:56.901964+05:30');


--
-- Data for Name: answer_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."answer_comments" ("id", "answer_id", "user_id", "parent_comment_id", "body", "created_at", "updated_at") VALUES
	('f162dc04-9532-429e-95b8-1cfc0d9fb3d3', '09d41955-4423-4d79-b9c2-b47e3e710023', '1319be79-c9ec-450f-8115-4445c9da6d98', NULL, 'Thanks, that helped!', '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30'),
	('3bb431d8-243f-4524-a85d-b492828403f6', '09d41955-4423-4d79-b9c2-b47e3e710023', '1319be79-c9ec-450f-8115-4445c9da6d98', NULL, 'sasdas', '2025-07-06 21:45:50.836359+05:30', '2025-07-06 21:45:50.836359+05:30');


--
-- Data for Name: answer_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."answer_notifications" ("id", "answer_id", "user_id", "notification_type", "message", "is_read", "related_id", "created_at") VALUES
	('f42ee2f6-8ed5-4089-88e8-73a7ea8bca94', '09d41955-4423-4d79-b9c2-b47e3e710023', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'vote', 'Someone upvoted your answer', false, '753e5ef3-9311-42a7-8e8d-3f349b5d3a8e', '2025-07-06 21:03:51.039532+05:30'),
	('40f13d4e-72df-49c8-8c66-cc7588d2fbb7', '09d41955-4423-4d79-b9c2-b47e3e710023', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'comment', 'Someone commented on your answer', false, 'f162dc04-9532-429e-95b8-1cfc0d9fb3d3', '2025-07-06 21:03:51.039532+05:30'),
	('89327252-03a0-4485-9cb5-5078a9f30a57', '09d41955-4423-4d79-b9c2-b47e3e710023', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'comment', 'Someone commented on your answer.', false, NULL, '2025-07-06 21:03:51.039532+05:30'),
	('29174aef-9601-4c77-b473-c6bdb9684576', '09d41955-4423-4d79-b9c2-b47e3e710023', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'comment', 'Someone commented on your answer', false, '3bb431d8-243f-4524-a85d-b492828403f6', '2025-07-06 21:45:50.836359+05:30');


--
-- Data for Name: answer_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."answer_tags" ("id", "answer_id", "tag_name", "created_at") VALUES
	('c0a13749-091c-47f9-8767-4e551fe86043', '09d41955-4423-4d79-b9c2-b47e3e710023', 'react', '2025-07-06 21:03:51.039532+05:30');


--
-- Data for Name: answer_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."answer_votes" ("id", "answer_id", "user_id", "vote_value", "created_at", "updated_at") VALUES
	('753e5ef3-9311-42a7-8e8d-3f349b5d3a8e', '09d41955-4423-4d79-b9c2-b47e3e710023', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30');


--
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."chats" ("id", "is_group", "name", "created_at", "created_by") VALUES
	('7d2f68f5-3774-44c4-ae1a-c670d2feec06', false, NULL, '2025-06-30 05:44:44.443967+05:30', NULL),
	('d19f9d2f-0c27-4070-98ee-1a54475e2974', true, 'work', '2025-06-30 05:45:20.466066+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98'),
	('55d66a9c-5c63-45ce-acb9-bb0cad63f839', true, 'work2', '2025-06-30 06:08:26.485131+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98'),
	('2bd3ced1-d6b2-464a-9425-51e9cc8456d5', true, 'TechStaff_GroundFloor@VITC', '2025-06-30 06:15:21.985507+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98'),
	('c55bcaf0-5672-4564-a30c-f42debfafbfb', false, NULL, '2025-07-02 01:25:09.309574+05:30', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572'),
	('487eecf6-1203-4cb6-94a1-c512b58e3bc1', false, NULL, '2025-07-02 01:25:43.283612+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98'),
	('4f5c18a1-6602-4508-8dbd-24dadff1dc29', false, NULL, '2025-07-04 15:21:33.636067+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98'),
	('bb5287e4-a6da-45d0-b126-ffa45d12aeee', false, NULL, '2025-07-04 15:23:44.639696+05:30', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03'),
	('85651690-b1d5-4160-874b-a1a40795ed93', false, NULL, '2025-07-04 15:25:06.011489+05:30', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03'),
	('fb6c142f-39fd-4435-b0e6-737038e2f361', false, NULL, '2025-07-04 15:28:53.794402+05:30', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03');


--
-- Data for Name: chat_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."chat_members" ("id", "chat_id", "user_id", "joined_at", "is_admin", "typing") VALUES
	('120b4fbb-54cd-4908-ad3f-6580a7e0b28a', 'd19f9d2f-0c27-4070-98ee-1a54475e2974', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 05:45:20.596153+05:30', false, false),
	('56277bf1-9dac-411c-b459-cae50200bf81', 'd19f9d2f-0c27-4070-98ee-1a54475e2974', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 05:45:20.59885+05:30', false, false),
	('512420ed-7269-43b8-82fc-7bb857e8cfff', 'd19f9d2f-0c27-4070-98ee-1a54475e2974', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 05:45:20.600913+05:30', false, false),
	('5aa6942f-e6b8-408c-88a9-4631fff66275', '55d66a9c-5c63-45ce-acb9-bb0cad63f839', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 06:08:26.549919+05:30', true, false),
	('f0a0a9ee-48bc-4435-b917-644ac86235d5', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 06:15:22.160755+05:30', false, false),
	('b3b7c68a-826d-4b23-adc0-99f236bdbd10', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 06:15:22.165144+05:30', false, false),
	('d8ed6a65-9b15-4737-9841-5a4cc041a9d6', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:11:06.085028+05:30', true, false),
	('e4c226c8-aa71-46a6-90ef-95d54fc4dd36', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 10:11:00.931388+05:30', false, false),
	('f2ada185-e1ff-466e-849f-5006ee98af81', 'c55bcaf0-5672-4564-a30c-f42debfafbfb', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '2025-07-02 01:25:09.435404+05:30', false, false),
	('b5ac701a-8552-4f0f-adb6-10796d3552ea', 'c55bcaf0-5672-4564-a30c-f42debfafbfb', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-07-02 01:25:09.514316+05:30', false, false),
	('4117b31f-70c5-413b-8370-bb912a57982c', '487eecf6-1203-4cb6-94a1-c512b58e3bc1', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '2025-07-02 01:25:43.434869+05:30', false, false),
	('b4334cd5-3d3e-473e-97a5-ea8c64a56610', 'fb6c142f-39fd-4435-b0e6-737038e2f361', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '2025-07-04 15:28:53.990732+05:30', false, false),
	('552b9c8a-9037-441f-b445-7204f59ee641', 'fb6c142f-39fd-4435-b0e6-737038e2f361', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-04 15:28:54.315882+05:30', false, false),
	('ddef6945-af93-4f5a-b896-6342a8975a0c', '7d2f68f5-3774-44c4-ae1a-c670d2feec06', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 05:44:44.597505+05:30', false, false);


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."chat_messages" ("id", "chat_id", "user_id", "content", "media_url", "created_at") VALUES
	('0d0e2f35-c9e2-4b41-ac94-d32302a0cbac', 'fb6c142f-39fd-4435-b0e6-737038e2f361', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'hii', NULL, '2025-07-04 15:29:05.332031+05:30');


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."posts" ("id", "user_id", "content", "media_url", "created_at", "updated_at", "is_deleted", "file_url", "image_url", "flag_status") VALUES
	('0a5028ff-3a17-4652-bf79-607019de68c6', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Just completed a React Native project! The mobile app development journey has been incredible. Learning about cross-platform development and the challenges of maintaining consistent UI across iOS and Android. #ReactNative #MobileDev #CrossPlatform', NULL, '2025-01-15 16:00:00+05:30', '2025-01-15 16:00:00+05:30', false, NULL, NULL, 'normal'),
	('92443502-0848-4155-a43d-ffe71d450077', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'Working on a full-stack application using Next.js 14 and Supabase. The new App Router and Server Components are game-changers! The developer experience is unmatched. #NextJS #Supabase #FullStack', NULL, '2025-01-12 14:45:00+05:30', '2025-01-12 14:45:00+05:30', false, NULL, NULL, 'normal'),
	('254b0553-6242-4bec-bbbc-2c9bd6bae32e', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Attended an amazing workshop on GraphQL today. The way it simplifies API development and reduces over-fetching is mind-blowing. Excited to implement it in my next project! #GraphQL #API #WebDevelopment', NULL, '2025-01-20 20:15:00+05:30', '2025-06-30 02:53:06.93+05:30', false, NULL, NULL, 'normal'),
	('6318a7cd-cf82-4391-928c-ceb76291d79e', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'Just deployed my first microservices architecture on AWS. The learning curve was steep but the scalability benefits are worth it. Docker + Kubernetes + AWS ECS = powerful combination!                                            #Microservices #AWS #Docker #Kubernetes', NULL, '2025-01-18 21:50:00+05:30', '2025-07-01 22:19:45.184+05:30', false, NULL, NULL, 'normal'),
	('796a742f-4de6-4516-9ed2-4bafd73c316f', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'Started learning TypeScript today. The type safety and better IDE support are incredible! No more runtime errors for simple type mistakes. #TypeScript #JavaScript #Programming', NULL, '2025-01-14 16:30:00+05:30', '2025-01-14 16:30:00+05:30', false, NULL, NULL, 'normal'),
	('dc87fc67-e35e-4d54-8211-febdc1dde5ea', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'Built a real-time chat application using Socket.io and Node.js. The WebSocket implementation was surprisingly straightforward. Real-time features are so much fun to build! #SocketIO #NodeJS #RealTime #WebSockets', NULL, '2025-01-22 19:00:00+05:30', '2025-01-22 19:00:00+05:30', false, NULL, NULL, 'normal'),
	('d4bb6709-0e7f-46a0-beb1-b2c7d0b16348', '67f2070a-0399-485a-a8e1-e73241df52c0', 'Exploring machine learning with Python and TensorFlow. The potential of AI in modern applications is fascinating. Working on a recommendation system for my portfolio project. #MachineLearning #Python #TensorFlow #AI', NULL, '2025-01-16 14:15:00+05:30', '2025-01-16 14:15:00+05:30', false, NULL, NULL, 'normal'),
	('ed589834-74c1-4886-a8c6-ce8512dc13ca', '67f2070a-0399-485a-a8e1-e73241df52c0', 'Just completed a course on DevOps practices. CI/CD pipelines, automated testing, and infrastructure as code are revolutionizing how we deploy software. #DevOps #CICD #Automation #Infrastructure', NULL, '2025-01-21 20:40:00+05:30', '2025-01-21 20:40:00+05:30', false, NULL, NULL, 'normal'),
	('27f02d85-b03d-4646-934e-3a693a2c988d', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'Working on a blockchain project using Ethereum and Solidity. Smart contracts are powerful but require careful attention to security. Learning about gas optimization and best practices. #Blockchain #Ethereum #Solidity #SmartContracts', NULL, '2025-01-13 18:00:00+05:30', '2025-01-13 18:00:00+05:30', false, NULL, NULL, 'normal'),
	('01ce53a1-2c33-4179-94c0-94f50fceedcd', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'Just finished building a REST API with Express.js and MongoDB. The combination of Node.js backend with NoSQL database is perfect for rapid prototyping. #ExpressJS #MongoDB #RESTAPI #NodeJS', NULL, '2025-01-19 15:45:00+05:30', '2025-01-19 15:45:00+05:30', false, NULL, NULL, 'normal'),
	('95ace707-7a91-4ead-8879-ba4991b6a881', '702dc5d1-9186-4350-b20f-d3007319a327', 'Learning about cloud computing with AWS. The scalability and cost-effectiveness of cloud services are amazing. Working on migrating a legacy application to the cloud. #AWS #CloudComputing #Migration #Scalability', NULL, '2025-01-17 19:50:00+05:30', '2025-01-17 19:50:00+05:30', false, NULL, NULL, 'normal'),
	('203f1d5b-e06a-4c72-94ee-419452f23725', '702dc5d1-9186-4350-b20f-d3007319a327', 'Just implemented OAuth 2.0 authentication in my application. Security is crucial in modern web development. Understanding JWT tokens and secure session management. #OAuth #Security #JWT #Authentication', NULL, '2025-01-23 15:15:00+05:30', '2025-01-23 15:15:00+05:30', false, NULL, NULL, 'normal'),
	('d29cda23-d4a8-4f06-acf0-fdc736b9040e', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'Working with Vue.js 3 and Composition API. The new reactivity system is much more intuitive than the Options API. Building a dashboard with Vue 3 and Vite. #VueJS #CompositionAPI #Vite #Frontend', NULL, '2025-01-11 21:30:00+05:30', '2025-01-11 21:30:00+05:30', false, NULL, NULL, 'normal'),
	('49e51a7d-318c-4bfc-a249-9c0cfd2c0fb9', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'Just completed a course on database design and optimization. Understanding indexes, query optimization, and database normalization is crucial for building scalable applications. #Database #SQL #Optimization #Performance', NULL, '2025-01-24 17:00:00+05:30', '2025-01-24 17:00:00+05:30', false, NULL, NULL, 'normal'),
	('e4b01f9e-7888-4f3f-8647-e527ff6b665c', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'Exploring Flutter for cross-platform mobile development. The hot reload feature and beautiful Material Design components make development so much faster. #Flutter #Dart #MobileDev #CrossPlatform', NULL, '2025-01-10 18:45:00+05:30', '2025-01-10 18:45:00+05:30', false, NULL, NULL, 'normal'),
	('aed30794-04f4-46ac-b5f6-b342d60feaf4', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'Working on a project using Redis for caching. The performance improvement is incredible! Understanding when and how to use caching effectively is a game-changer. #Redis #Caching #Performance #Backend', NULL, '2025-01-25 21:15:00+05:30', '2025-01-25 21:15:00+05:30', false, NULL, NULL, 'normal'),
	('58ba5e24-9e20-405c-832c-b21f07b9030e', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'Learning about Progressive Web Apps (PWAs). The ability to work offline and provide native app-like experience is revolutionary. Building my first PWA with service workers. #PWA #ServiceWorkers #Offline #WebApp', NULL, '2025-01-09 16:00:00+05:30', '2025-01-09 16:00:00+05:30', false, NULL, NULL, 'normal'),
	('14ce1fb1-fd66-4473-9366-ac0994abcf25', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'Just implemented automated testing with Jest and React Testing Library. Writing tests first (TDD) has completely changed my development workflow. Quality code is maintainable code! #Testing #Jest #ReactTestingLibrary #TDD', NULL, '2025-01-26 17:30:00+05:30', '2025-01-26 17:30:00+05:30', false, NULL, NULL, 'normal'),
	('fc43341d-77f9-4069-a9fe-dbc2bf6cb838', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'Working with Angular 17 and standalone components. The new control flow syntax and improved performance are amazing. Building a large-scale enterprise application. #Angular #StandaloneComponents #Enterprise #Frontend', NULL, '2025-01-08 20:15:00+05:30', '2025-01-08 20:15:00+05:30', false, NULL, NULL, 'normal'),
	('2acac702-6d1b-4d64-b79c-400d4021ec6c', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'Just completed a course on system design. Understanding scalability, load balancing, and distributed systems is crucial for building robust applications. #SystemDesign #Scalability #Architecture #DistributedSystems', NULL, '2025-01-27 21:50:00+05:30', '2025-01-27 21:50:00+05:30', false, NULL, NULL, 'normal'),
	('ce198b41-bac6-45c6-b8fd-a07eaf927f53', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'Learning about data visualization with D3.js. Creating interactive charts and graphs for data analysis. The power of SVG and CSS transforms is incredible! #DataVisualization #D3JS #SVG #Analytics', NULL, '2025-01-07 16:50:00+05:30', '2025-01-07 16:50:00+05:30', false, NULL, NULL, 'normal'),
	('50371b8d-1d49-4b79-80e5-91920a23e0d4', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'Working on a project using WebRTC for real-time video communication. The technology behind video calls and screen sharing is fascinating. Building a simple video chat application. #WebRTC #VideoChat #RealTime #Communication', NULL, '2025-01-28 19:20:00+05:30', '2025-01-28 19:20:00+05:30', false, NULL, NULL, 'normal'),
	('90c17148-db32-4238-a47b-73fae751be6b', '1319be79-c9ec-450f-8115-4445c9da6d98', 'adsadada', NULL, '2025-07-02 23:29:20.684958+05:30', '2025-07-02 23:29:20.684958+05:30', false, NULL, NULL, 'normal'),
	('6bdcef31-e466-45c5-8fd2-7d3c25d9c275', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', 'jajdsfklasjdfkljaslkfjdasjdjalkdfjalskflkasjfljasdl', NULL, '2025-07-02 11:28:36.546117+05:30', '2025-07-02 11:28:36.546117+05:30', false, NULL, NULL, 'normal');


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: comment_likes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: content_flags; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: filemodels; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."filemodels" ("id", "user_id", "file_url", "file_name", "file_type", "file_size", "description", "is_public", "created_at") VALUES
	('61daaecf-34d9-4c59-87ae-5a6d0c8f7db2', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252460776.pdf', 'az.pdf', 'application/pdf', 945553, 'asdasd', true, '2025-06-30 08:31:02.00573+05:30'),
	('4e8d5633-da07-4291-8e1a-ad44ff6f0836', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252484064.txt', 'DBMS SQL DDL Contraints.txt', 'text/plain', 76, 'DBMS SQL DDL Contraints', true, '2025-06-30 08:31:24.419018+05:30'),
	('a9dbd540-f5ba-4fd5-828a-dfd18a18afa7', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252498375.pdf', 'Create a database.pdf', 'application/pdf', 116784, 'Create a database', true, '2025-06-30 08:31:38.819265+05:30'),
	('1bfdf310-5ce7-4fa4-9698-bbc46c879509', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252668699.docx', 'AK IOT 3.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 464832, 'dfsdafsf', true, '2025-06-30 08:34:30.033609+05:30'),
	('f103e8a2-9fcb-455e-aa10-9133a3af5950', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/306f8931-2603-4c86-b3ab-f804c2c5be57/1751259604290.ppt', 'CASE Tools.ppt', 'application/vnd.ms-powerpoint', 655360, 'CASE Tools', true, '2025-06-30 10:30:05.199775+05:30');


--
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."followers" ("id", "follower_id", "following_id", "created_at") VALUES
	('8371a8ce-3405-4538-b79e-9cea4080af6e', '1319be79-c9ec-450f-8115-4445c9da6d98', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('9eed9d75-d031-4f90-a692-854ffa977d3b', '1319be79-c9ec-450f-8115-4445c9da6d98', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('e053476b-504b-4590-8d58-2b51e9903440', '1319be79-c9ec-450f-8115-4445c9da6d98', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('0cee35ff-f1bf-4ec4-b7ae-dce920389945', '1319be79-c9ec-450f-8115-4445c9da6d98', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('1f77df72-cfcf-4768-b763-250bee3c2274', '1319be79-c9ec-450f-8115-4445c9da6d98', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('8ce73765-2ca2-480d-a430-54023977a7c9', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('106f4a25-8d71-4bea-8f31-f0d23c8b8d19', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('9428b57e-f1de-42bc-a6ff-caccc4da58db', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('153d4d78-be61-4554-a0c7-f03f3d4e6f80', '399e5ea7-4664-4c3c-81d3-b983814d106a', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('17238e17-7005-4d78-abb7-7ff797e66805', '399e5ea7-4664-4c3c-81d3-b983814d106a', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('8061f833-ba3c-45db-91ea-daf9d298b5af', '399e5ea7-4664-4c3c-81d3-b983814d106a', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('d7da94de-826d-48b0-b23b-3d77b0c2cf46', '399e5ea7-4664-4c3c-81d3-b983814d106a', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('7856dbf8-0991-4154-9e33-67a8e6b03548', '399e5ea7-4664-4c3c-81d3-b983814d106a', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('4e136e2b-58f6-49cb-bc10-3b32ff9763d9', '399e5ea7-4664-4c3c-81d3-b983814d106a', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('9d6e9c35-d523-407e-bfe2-666b02e21460', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('d37c1440-9adb-4396-b0b1-d5fbb75dc597', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('124972d7-6566-49c6-a8e0-88c140e1d17f', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('72a76e7d-1474-44cd-a991-10ced5193fda', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('31e0f20c-f418-4a2e-a13a-140fc73a5f65', '67f2070a-0399-485a-a8e1-e73241df52c0', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('18fddb1d-1d0b-408f-9964-9bb21f3e7fde', '67f2070a-0399-485a-a8e1-e73241df52c0', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('f20c08c6-430d-4b6b-b691-0d1d0914976c', '67f2070a-0399-485a-a8e1-e73241df52c0', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('297c2889-d0fc-466f-9bc2-1856fc1a01be', '67f2070a-0399-485a-a8e1-e73241df52c0', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('e29e51c6-9f0b-4c8b-93d5-f1269a711457', '67f2070a-0399-485a-a8e1-e73241df52c0', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('321e089c-0d82-48ca-812d-44e2f6e76537', '67f2070a-0399-485a-a8e1-e73241df52c0', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('9e7cfde9-5d97-403c-bf90-031e5c0e906b', '67f2070a-0399-485a-a8e1-e73241df52c0', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('f7b2b928-f14d-4e95-a2b2-96f54cb1be15', '67f2070a-0399-485a-a8e1-e73241df52c0', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('b53e2943-51e9-4f47-a091-4fba7321f641', '67f2070a-0399-485a-a8e1-e73241df52c0', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('dc2b3fe1-bddf-4635-a4d6-9499bcf52bba', '67f2070a-0399-485a-a8e1-e73241df52c0', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('e6bb8472-9347-47e4-9e22-9ffadde5e10a', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('895bc379-a4de-48f5-9b81-c6195e0a0c37', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('3bef4bcc-4414-41b6-9bb0-55c66e42c6d1', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('3555f956-0975-4fa6-b123-b49a420e2d6f', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('0e29045e-475c-4771-9a52-e6acade02bc4', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('3ec586a9-edab-4e7e-b1e5-a2ceea07bab0', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('439af572-22f8-4e94-854c-cea65cdd4873', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('2d6fdd5d-f159-40e4-bda7-792d390d38fe', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('2a8a128b-646d-444f-8cd4-9932f1ffc7e7', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('4a8194d7-a7fc-4ec8-bfcd-6201f94ed0f9', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('9e985328-ed10-4639-b681-5871205bdf90', '702dc5d1-9186-4350-b20f-d3007319a327', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('d4244ae4-a957-4039-8517-47bdafebc2ec', '702dc5d1-9186-4350-b20f-d3007319a327', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('4a020208-079c-46c6-8b70-0e304bcab622', '702dc5d1-9186-4350-b20f-d3007319a327', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('e7cc02cd-82dc-47de-9ec5-46297d90f505', '702dc5d1-9186-4350-b20f-d3007319a327', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('9d894f3e-02ee-49e5-aaf2-7088050ec653', '702dc5d1-9186-4350-b20f-d3007319a327', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('55b970bf-e408-472f-83b4-fff20faa11d5', '702dc5d1-9186-4350-b20f-d3007319a327', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('fec4e7ef-7e1e-49a3-a2ff-fc6f1fac2ca9', '702dc5d1-9186-4350-b20f-d3007319a327', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('dab2cb8b-b3f8-4492-8058-b4265b9448cc', '702dc5d1-9186-4350-b20f-d3007319a327', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('cfc48909-62eb-45ef-8f17-812082a1808a', '702dc5d1-9186-4350-b20f-d3007319a327', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('f0862eb8-4214-4941-8d7c-ea94250aae45', '702dc5d1-9186-4350-b20f-d3007319a327', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('9cacb87a-a666-425f-aa46-924322030767', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('139ef4bb-86b9-49ad-947b-9c4d21e04f40', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('cd740a11-1cbc-4b7c-91b1-b6de3219c0d2', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('653b80e9-85df-4321-9975-346455183d5f', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('60209b0c-4479-4d69-82c3-2baa38382888', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('88cf58f4-717a-453b-b956-09cbbc400da0', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('353ede2a-af03-4598-b305-1184a7854b87', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('d7b9830a-5add-4df1-b936-82eb5a14eafe', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('d7b1215d-cc52-4cfd-9050-1162dd17ae1d', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('df61cf23-9edf-46d7-a274-893684251df3', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('780abb7f-b8ff-4ed4-bcb2-9bc9d4370128', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('12a7ac61-79e8-44b5-9f2e-bbc08f9aca2b', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('1a380a74-19db-4a3d-90f9-ff195a34a1ac', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('13454605-9f27-43b5-bae2-596eb3bf5e0c', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('ba9458c0-5b61-4fb1-aced-c7f52666f761', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('b75d5b89-8d7c-4f22-908b-3cc3dbcfd699', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('31e52b53-558d-433f-a4bb-593b8f76a118', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('0b68c11b-81f5-48a5-9ccb-5e3f4f26c533', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('455a0092-9b63-4e1c-a313-7cb6d7bea6d1', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('737a2436-8fb4-4038-92a3-7a2005e8f546', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('2ab0c6f5-84ab-49a1-bfb6-236f33afc436', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('31d71b3b-ca7b-4ae1-97fe-f85adff609b9', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('ea7cbaa8-89e6-4c44-9ff1-724bcdef4239', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('d57d6a11-fb67-4f76-a010-90daea7b3972', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('d60aa3f1-c044-45b6-a272-900c8cb230bf', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('0490daed-120d-4d2e-829e-428d6e79bfb0', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('5c64eebc-47c8-4f40-81b2-89e605ace49a', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('b8998be2-866a-457c-beea-5063be136b03', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('4d64a140-0cb3-4b38-a18a-c8bdb8a94aaf', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('60cc1e2f-473f-4b52-840a-88b1c60bde24', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('50e9e417-7636-4230-aeba-faad2d62368f', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('ee93f4f6-568b-41ee-a097-67296c25ccf5', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('3dc61361-edd0-476d-94ab-90421e5b6f1a', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('70904f01-868b-44ed-98f6-bd04f4da52a7', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('451e0e20-3aca-463f-8b4e-383c529b9f06', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('c974b3af-4bac-445f-8d55-4bfe2b2e4c2a', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('9e51048c-16aa-4ba3-a9ca-64f54402c6ec', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('3413d077-ea8e-49ab-b074-bfc1cb00e77f', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('ebbc2f4f-1594-4106-a3f5-12284285f120', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('4afb36ea-a85b-4f8e-bbd9-3cb6ac6308a2', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30'),
	('e25eca08-b918-4c66-9d65-35506d2572d5', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30'),
	('70a1730f-750a-425a-b0d6-810c28923dea', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30'),
	('680045c8-2a0d-4d29-832c-c1dd16f26dcb', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30'),
	('f4e9a423-7753-4ef7-b900-d50a357afe2f', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30'),
	('71d357ef-0f82-411b-89aa-165b984c59b1', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30'),
	('e2f81776-b8a4-41d5-8299-8a8a1b6acb1a', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30'),
	('91119b3b-bb9c-4a95-bcf0-427ab0ac0e0f', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30'),
	('32970953-9063-42b6-9930-026cb3802285', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30'),
	('75d3f443-85d7-4b5a-ab54-f4e158b332fb', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30'),
	('5e01518d-6b07-4fdc-bd26-ecd584836c43', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30'),
	('213bc267-4323-4886-a401-1caacb9c6b5b', '1319be79-c9ec-450f-8115-4445c9da6d98', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-07-01 23:22:43.111856+05:30'),
	('514e2089-3e48-4499-86c1-27a96b830139', '1319be79-c9ec-450f-8115-4445c9da6d98', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-07-01 23:22:43.5834+05:30'),
	('ec172930-451a-4ea6-9f03-9ad4e2b03234', '1319be79-c9ec-450f-8115-4445c9da6d98', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-07-01 23:22:44.471708+05:30'),
	('abc74dc9-af45-4b70-9032-698202bce898', '1319be79-c9ec-450f-8115-4445c9da6d98', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-07-01 23:22:45.129719+05:30'),
	('c1c3b562-76ce-4420-b724-5995ef7da981', '1319be79-c9ec-450f-8115-4445c9da6d98', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-07-01 23:23:04.704468+05:30'),
	('6c3de5fa-5b6e-4a40-ae15-7031c420702f', '306f8931-2603-4c86-b3ab-f804c2c5be57', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-01 23:26:03.259679+05:30'),
	('499d2291-446a-4907-aabe-343b1db7b3f1', '306f8931-2603-4c86-b3ab-f804c2c5be57', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-07-01 23:26:31.249073+05:30'),
	('858edcec-731e-45ef-a5e0-901a9263deca', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-03 00:23:58.541521+05:30');


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."likes" ("id", "user_id", "post_id", "created_at") VALUES
	('4be967ab-4a2b-4055-9e82-3a48d3402c4f', '1319be79-c9ec-450f-8115-4445c9da6d98', '14ce1fb1-fd66-4473-9366-ac0994abcf25', '2025-06-30 22:47:45.019984+05:30'),
	('4b649aff-1f3c-48f2-9fde-93d7e301e50b', '1319be79-c9ec-450f-8115-4445c9da6d98', '50371b8d-1d49-4b79-80e5-91920a23e0d4', '2025-07-01 00:19:14.894357+05:30'),
	('9aa0e028-c46b-44c6-8470-9cfdd0e37dad', '1319be79-c9ec-450f-8115-4445c9da6d98', '2acac702-6d1b-4d64-b79c-400d4021ec6c', '2025-06-30 03:43:53.517584+05:30'),
	('a8d84cdf-fb68-4d61-9b08-a8620be9be2b', '306f8931-2603-4c86-b3ab-f804c2c5be57', '50371b8d-1d49-4b79-80e5-91920a23e0d4', '2025-07-01 21:46:04.56946+05:30'),
	('2a63e58b-e30c-4130-8c16-88e11e31e8a5', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2acac702-6d1b-4d64-b79c-400d4021ec6c', '2025-07-01 21:46:05.331157+05:30'),
	('245f13d4-4234-4833-ad3d-c29501693557', '306f8931-2603-4c86-b3ab-f804c2c5be57', '14ce1fb1-fd66-4473-9366-ac0994abcf25', '2025-07-01 21:46:09.375807+05:30'),
	('b3700cce-3ad8-42ac-bf24-76181838ee7d', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'aed30794-04f4-46ac-b5f6-b342d60feaf4', '2025-07-01 21:46:10.95814+05:30'),
	('121a2fad-0cb5-4e5c-b760-821b429ebb1b', '306f8931-2603-4c86-b3ab-f804c2c5be57', '49e51a7d-318c-4bfc-a249-9c0cfd2c0fb9', '2025-07-01 21:46:13.024465+05:30'),
	('eafebaf2-9796-481e-8769-66dadde3a0e1', '306f8931-2603-4c86-b3ab-f804c2c5be57', '203f1d5b-e06a-4c72-94ee-419452f23725', '2025-07-01 21:46:13.816159+05:30'),
	('5ce9c942-bc42-43e3-8d36-6ec6cdb49e28', '306f8931-2603-4c86-b3ab-f804c2c5be57', '254b0553-6242-4bec-bbbc-2c9bd6bae32e', '2025-07-01 21:52:43.862722+05:30'),
	('4d769fd0-fc91-469d-9813-ea3fd406d567', '306f8931-2603-4c86-b3ab-f804c2c5be57', '0a5028ff-3a17-4652-bf79-607019de68c6', '2025-07-01 21:52:47.472582+05:30'),
	('0b4c96f6-9cba-484f-acc5-d4b19ba8057c', '1319be79-c9ec-450f-8115-4445c9da6d98', '90c17148-db32-4238-a47b-73fae751be6b', '2025-07-03 16:20:06.689023+05:30'),
	('993b48d2-afdb-4f1e-8aae-1016425834d1', '1319be79-c9ec-450f-8115-4445c9da6d98', '254b0553-6242-4bec-bbbc-2c9bd6bae32e', '2025-07-03 16:20:44.215108+05:30'),
	('e5cdebdf-045d-49cd-9071-e108ab1d91cb', '306f8931-2603-4c86-b3ab-f804c2c5be57', '90c17148-db32-4238-a47b-73fae751be6b', '2025-07-05 14:54:51.006064+05:30');


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: question_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."question_notifications" ("id", "question_id", "user_id", "notification_type", "message", "is_read", "related_id", "created_at") VALUES
	('74bdcb2d-d0ac-4a38-9ee8-bda3723e8398', '2080eb1f-bf4d-4d19-9589-bcc026859069', '1319be79-c9ec-450f-8115-4445c9da6d98', 'answer', 'Someone answered your question: How do I use React hooks?...', false, '09d41955-4423-4d79-b9c2-b47e3e710023', '2025-07-06 21:03:51.039532+05:30'),
	('240ca9f7-3434-410e-b30c-9ea956b00639', 'd7275962-7f89-4c14-8e4a-ef7ab80ed662', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'answer', 'Someone answered your question: What is a closure in JavaScript?...', false, '2428d72d-2e27-42cb-9d3d-f377a5f2bc3d', '2025-07-06 21:03:51.039532+05:30'),
	('1b592d78-d9ac-4f1a-a960-75732f4d7c44', '2080eb1f-bf4d-4d19-9589-bcc026859069', '1319be79-c9ec-450f-8115-4445c9da6d98', 'vote', 'Someone upvoted your question', false, '676c7a69-e9df-4a14-a07c-4d5ce562f371', '2025-07-06 21:03:51.039532+05:30'),
	('b6ea4bb3-856e-40be-b006-2074a9b5b5f3', 'd7275962-7f89-4c14-8e4a-ef7ab80ed662', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'vote', 'Someone upvoted your question', false, 'ec566ae0-bf89-4317-a897-502f4d1dc1cf', '2025-07-06 21:03:51.039532+05:30'),
	('6c6cbb9b-4f14-494c-8498-ac415d4f4474', '2080eb1f-bf4d-4d19-9589-bcc026859069', '1319be79-c9ec-450f-8115-4445c9da6d98', 'answer', 'Your question has a new answer!', false, NULL, '2025-07-06 21:03:51.039532+05:30'),
	('2424c410-1deb-47aa-9f30-49e9d4960935', 'd7275962-7f89-4c14-8e4a-ef7ab80ed662', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'answer', 'Someone answered your question: What is a closure in JavaScript?...', false, 'ab7fefe1-8e7a-4b53-a1ac-f74b29126267', '2025-07-06 21:24:36.904087+05:30');


--
-- Data for Name: question_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."question_tags" ("id", "question_id", "tag_name", "created_at") VALUES
	('6c6fc339-334e-4907-aa82-42d866570790', '2080eb1f-bf4d-4d19-9589-bcc026859069', 'react', '2025-07-06 21:03:51.039532+05:30'),
	('bcb47988-9ee9-4fa3-8c84-753111e36402', 'd7275962-7f89-4c14-8e4a-ef7ab80ed662', 'javascript', '2025-07-06 21:03:51.039532+05:30');


--
-- Data for Name: question_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."question_votes" ("id", "question_id", "user_id", "vote_value", "created_at", "updated_at") VALUES
	('676c7a69-e9df-4a14-a07c-4d5ce562f371', '2080eb1f-bf4d-4d19-9589-bcc026859069', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 1, '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30'),
	('ec566ae0-bf89-4317-a897-502f4d1dc1cf', 'd7275962-7f89-4c14-8e4a-ef7ab80ed662', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-06 21:03:51.039532+05:30', '2025-07-06 21:03:51.039532+05:30'),
	('d044b4ea-7909-455d-96e9-3d4c100d51d5', '2080eb1f-bf4d-4d19-9589-bcc026859069', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-06 21:21:11.388048+05:30', '2025-07-06 21:21:11.388048+05:30');


--
-- Data for Name: reputation_events; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."user_roles" ("id", "user_id", "role", "created_at") VALUES
	('56ee8e8d-288d-4555-8a80-e4b5850081c4', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'user', '2025-06-29 19:44:42.054242+05:30'),
	('86c5aace-2d33-49a4-9829-84216ad78008', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', 'admin', '2025-06-29 19:22:07.10465+05:30'),
	('638ca293-9e5b-4b6d-9182-f7f6d7b99730', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'user', '2025-06-30 00:36:15.319534+05:30'),
	('12818ef4-1ec3-44a7-8eb2-e54090aac45d', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'user', '2025-06-30 00:36:46.970067+05:30'),
	('261dee2b-af45-4e22-ab06-caf505744980', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'user', '2025-06-30 00:37:33.749964+05:30'),
	('9e46a0da-8768-4fb3-8a68-1bec53362b91', '1319be79-c9ec-450f-8115-4445c9da6d98', 'user', '2025-06-30 00:38:02.258108+05:30'),
	('e1efd277-d580-447b-8d95-00db9876dc89', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'user', '2025-06-30 00:39:16.693123+05:30'),
	('d7077193-c839-48e0-8ef2-dbbae5844535', '67f2070a-0399-485a-a8e1-e73241df52c0', 'user', '2025-06-30 00:39:56.966044+05:30'),
	('bf979a25-18b6-48fd-b642-d1d6e2aad4da', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'user', '2025-06-30 00:40:52.290034+05:30'),
	('409e3f6b-d0b8-4878-b77e-f444b97eb02f', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'user', '2025-06-30 00:41:53.892531+05:30'),
	('df95470d-e082-45d2-920c-de1274ba0ce6', '702dc5d1-9186-4350-b20f-d3007319a327', 'user', '2025-06-30 00:44:07.082442+05:30'),
	('dc26863e-59c6-4048-bcd7-9820f106a031', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'user', '2025-06-30 00:45:00.793431+05:30'),
	('7a187625-6788-4077-b5a1-2a5505911f81', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', 'user', '2025-07-02 01:17:23.359724+05:30'),
	('e13f8138-95af-4797-8856-f63d817f49e8', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'user', '2025-07-04 12:25:16.807825+05:30');


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id") VALUES
	('uploads', 'uploads', NULL, '2025-06-30 08:22:25.466068+05:30', '2025-06-30 08:22:25.466068+05:30', true, false, 52428800, '{image/*,video/*,application/pdf,text/*,application/json,application/javascript,text/javascript,text/css,text/html,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/zip,application/x-rar-compressed,application/x-7z-compressed}', NULL),
	('chat_uploads', 'chat_uploads', NULL, '2025-06-30 09:16:37.876924+05:30', '2025-06-30 09:16:37.876924+05:30', true, false, NULL, NULL, NULL),
	('post-media', 'post-media', NULL, '2025-06-30 22:22:05.673833+05:30', '2025-06-30 22:22:05.673833+05:30', true, false, 52428800, '{image/*,video/*,application/pdf,text/*,application/json,application/javascript,text/javascript,text/css,text/html,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/zip,application/x-rar-compressed,application/x-7z-compressed}', NULL),
	('avatars', 'avatars', NULL, '2025-07-01 01:32:29.261192+05:30', '2025-07-01 01:32:29.261192+05:30', true, false, NULL, NULL, NULL);


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") VALUES
	('4d001b65-55c3-4f16-8e81-2b127c23d24d', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252460776.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:31:01.781732+05:30', '2025-06-30 08:31:01.781732+05:30', '2025-06-30 08:31:01.781732+05:30', '{"eTag": "\"3aa7f2d699fc69f02038b6cb2f21f799\"", "size": 945553, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:01:02.000Z", "contentLength": 945553, "httpStatusCode": 200}', '66d5a0b6-d29d-4c28-a13f-2df52f7a05d7', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('a4943c8c-c718-4e7a-9756-1fe9875f2383', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252484064.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:31:24.264709+05:30', '2025-06-30 08:31:24.264709+05:30', '2025-06-30 08:31:24.264709+05:30', '{"eTag": "\"7afac1314237726d34a237074da15028\"", "size": 76, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:01:25.000Z", "contentLength": 76, "httpStatusCode": 200}', 'af7238c7-b9ed-4d5b-9b02-fe2b58c8aaf4', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('0defa8d2-7472-4598-9c16-87362437f1fa', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252498375.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:31:38.695604+05:30', '2025-06-30 08:31:38.695604+05:30', '2025-06-30 08:31:38.695604+05:30', '{"eTag": "\"d4adc91f0f080d823dcac2d8cef4096e\"", "size": 116784, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:01:39.000Z", "contentLength": 116784, "httpStatusCode": 200}', '1c6f8b4d-37f5-4a4f-b1cb-a4fa827999c6', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('b57ce865-1a73-4910-b3e0-ae5c6b8ba550', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252668699.docx', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:34:29.776191+05:30', '2025-06-30 08:34:29.776191+05:30', '2025-06-30 08:34:29.776191+05:30', '{"eTag": "\"dbcd92a40298ea9eccbb555d21bb264b\"", "size": 464832, "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:04:30.000Z", "contentLength": 464832, "httpStatusCode": 200}', '90d41818-80e0-4230-81a0-ee4c07e7050f', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('97c63826-33a9-4e1e-a1dc-cdcb5912bd1d', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255260329.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:17:40.506815+05:30', '2025-06-30 09:17:40.506815+05:30', '2025-06-30 09:17:40.506815+05:30', '{"eTag": "\"85f0b391b57d568989f63ec7a7b40ea2\"", "size": 161, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:47:41.000Z", "contentLength": 161, "httpStatusCode": 200}', '8e2b84da-09fd-468a-9d4d-b828c76bbd23', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('f24cd78f-5034-4334-9a94-d95042c5c29a', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255273524.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:17:53.943729+05:30', '2025-06-30 09:17:53.943729+05:30', '2025-06-30 09:17:53.943729+05:30', '{"eTag": "\"d713fa3aa6b2df3805bb057d2e6c9c62\"", "size": 1353, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:47:54.000Z", "contentLength": 1353, "httpStatusCode": 200}', 'bd1cca6b-df26-4c61-ac41-eede5667e74d', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('70118885-ae57-4c38-9933-0942bceb835f', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255585945.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:23:06.112278+05:30', '2025-06-30 09:23:06.112278+05:30', '2025-06-30 09:23:06.112278+05:30', '{"eTag": "\"85f0b391b57d568989f63ec7a7b40ea2\"", "size": 161, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:53:07.000Z", "contentLength": 161, "httpStatusCode": 200}', 'cb6e782f-53cf-4a8b-bf2c-358db79262e4', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('0e951365-9589-4c00-a8e0-7c72f734c0e1', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255607083.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:23:27.549051+05:30', '2025-06-30 09:23:27.549051+05:30', '2025-06-30 09:23:27.549051+05:30', '{"eTag": "\"d4adc91f0f080d823dcac2d8cef4096e\"", "size": 116784, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:53:28.000Z", "contentLength": 116784, "httpStatusCode": 200}', '8ab882e0-2ba1-41e3-ab32-3fc4c58fec7d', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('5b24fe91-f4a8-4362-9eb5-c931bf7fff77', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255725946.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:25:26.408893+05:30', '2025-06-30 09:25:26.408893+05:30', '2025-06-30 09:25:26.408893+05:30', '{"eTag": "\"d4adc91f0f080d823dcac2d8cef4096e\"", "size": 116784, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:55:27.000Z", "contentLength": 116784, "httpStatusCode": 200}', 'af560ebc-c80b-4439-b53c-b5df3ea5d68e', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('05d7924f-3a6e-4247-a5c1-743f49cacf8f', 'chat_uploads', '306f8931-2603-4c86-b3ab-f804c2c5be57/1751258502805.docx', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 10:11:43.108388+05:30', '2025-06-30 10:11:43.108388+05:30', '2025-06-30 10:11:43.108388+05:30', '{"eTag": "\"4e7bed5ad6c55ff9197f6f532d5ee62d\"", "size": 7812, "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T04:41:44.000Z", "contentLength": 7812, "httpStatusCode": 200}', 'd9539557-60a1-4c68-a99c-e7c9d788d1e2', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{}'),
	('6aafb191-14f0-4b8c-885b-674e4a26f908', 'uploads', '306f8931-2603-4c86-b3ab-f804c2c5be57/1751259604290.ppt', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 10:30:05.009499+05:30', '2025-06-30 10:30:05.009499+05:30', '2025-06-30 10:30:05.009499+05:30', '{"eTag": "\"2fa78246729c52275dbf9c02d4014b0f\"", "size": 655360, "mimetype": "application/vnd.ms-powerpoint", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T05:00:05.000Z", "contentLength": 655360, "httpStatusCode": 200}', '15c6b870-c161-42ca-a929-5a00747984b4', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{}'),
	('f06affd9-9dce-40dd-8751-8ee15b16a4f5', 'post-media', 'images/1751303080391_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:34:40.629017+05:30', '2025-06-30 22:34:40.629017+05:30', '2025-06-30 22:34:40.629017+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:04:41.000Z", "contentLength": 23556, "httpStatusCode": 200}', 'f2ec08af-4cbc-442a-8429-bc1a9bff3ed7', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('5d2fb771-2110-4f1e-ab99-e45fd4f8a0c4', 'post-media', 'images/1751303159229_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:35:59.392255+05:30', '2025-06-30 22:35:59.392255+05:30', '2025-06-30 22:35:59.392255+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:06:00.000Z", "contentLength": 23556, "httpStatusCode": 200}', '17bcb8af-1c79-4c93-89ac-055318fb1920', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('b63c7531-f218-4c75-926f-2dc4d38849d1', 'post-media', 'images/1751303202437_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:36:42.623354+05:30', '2025-06-30 22:36:42.623354+05:30', '2025-06-30 22:36:42.623354+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:06:43.000Z", "contentLength": 23556, "httpStatusCode": 200}', '92bb1115-a902-4165-b6c3-66b391e01849', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('432d2740-9be2-4b52-891f-38e1d7647d77', 'post-media', 'files/1751303373319_Project Synopsis Focus.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:39:33.479865+05:30', '2025-06-30 22:39:33.479865+05:30', '2025-06-30 22:39:33.479865+05:30', '{"eTag": "\"a564ce3266779c775197d558ce00fadb\"", "size": 2617, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:09:34.000Z", "contentLength": 2617, "httpStatusCode": 200}', '2562b305-0d76-41bf-b3b5-7b497a109e2c', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('d2cbc240-2d6b-4400-9b84-b5c527dc4922', 'post-media', 'images/1751303562868_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:42:43.052077+05:30', '2025-06-30 22:42:43.052077+05:30', '2025-06-30 22:42:43.052077+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:12:43.000Z", "contentLength": 23556, "httpStatusCode": 200}', 'bfff4b69-09fc-442e-a046-81afb4f8105c', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('cccfe837-d054-4e74-9617-9d200d7b4850', 'post-media', 'files/1751303932281_SQL Notes Handwritten.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:48:56.631173+05:30', '2025-06-30 22:48:56.631173+05:30', '2025-06-30 22:48:56.631173+05:30', '{"eTag": "\"525effffe0814fd3c6be38db81c6496a-4\"", "size": 17309207, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:18:57.000Z", "contentLength": 17309207, "httpStatusCode": 200}', '080a66a6-bd27-436b-b71b-f27888477a56', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('66eafe16-ed97-4019-8784-72d3f7ee735d', 'avatars', '1319be79-c9ec-450f-8115-4445c9da6d98/1751314473974.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-01 01:44:34.192376+05:30', '2025-07-01 01:44:34.192376+05:30', '2025-07-01 01:44:34.192376+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T20:14:35.000Z", "contentLength": 23556, "httpStatusCode": 200}', '5d0aa7f8-7cc7-41e7-9038-88b06e350ac5', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}'),
	('b598e5c6-ea4b-4c0e-a76f-fe7638455ade', 'avatars', '306f8931-2603-4c86-b3ab-f804c2c5be57/1751392704971.jpg', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-07-01 23:28:25.521113+05:30', '2025-07-01 23:28:25.521113+05:30', '2025-07-01 23:28:25.521113+05:30', '{"eTag": "\"b171370f080c1e7b1cc488b1e84dd867\"", "size": 15473, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-01T17:58:26.000Z", "contentLength": 15473, "httpStatusCode": 200}', 'c99d8563-9629-465b-954e-699a0545f336', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{}'),
	('b5420ed2-c56f-4008-9ae2-17447c3e26e0', 'avatars', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3/1751395218540.jpg', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '2025-07-02 00:10:19.24502+05:30', '2025-07-02 00:10:19.24502+05:30', '2025-07-02 00:10:19.24502+05:30', '{"eTag": "\"82d62aecee2f5a9bef0ee1fd27c00a9e\"", "size": 52890, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-01T18:40:20.000Z", "contentLength": 52890, "httpStatusCode": 200}', '6d08469b-895e-4d9e-b4a5-34ae4c1d75a4', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '{}'),
	('56a1300c-0efe-42d2-bb8c-3377e555f7c8', 'avatars', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3/1751396238085.jpg', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '2025-07-02 00:27:18.347546+05:30', '2025-07-02 00:27:18.347546+05:30', '2025-07-02 00:27:18.347546+05:30', '{"eTag": "\"82d62aecee2f5a9bef0ee1fd27c00a9e\"", "size": 52890, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-01T18:57:19.000Z", "contentLength": 52890, "httpStatusCode": 200}', '32d2598c-6dac-4778-b873-dd1c6ae5bdaa', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '{}');


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 163, true);


--
-- Name: reputation_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."reputation_events_id_seq"', 1, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."tags_id_seq"', 1, false);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."votes_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

RESET ALL;
