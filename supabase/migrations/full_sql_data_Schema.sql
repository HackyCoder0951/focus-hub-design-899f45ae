--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg24.04+1)

-- Started on 2025-07-04 18:41:05 IST

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
SET row_security = on;

DROP DATABASE IF EXISTS postgres;
--
-- TOC entry 4540 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
SET row_security = on;

--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 4540
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 4543 (class 0 OID 0)
-- Name: postgres; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '3600';
ALTER DATABASE postgres SET "TimeZone" TO 'Asia/Kolkata';


\connect postgres

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
SET row_security = on;

--
-- TOC entry 37 (class 2615 OID 16492)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 23 (class 2615 OID 16388)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 35 (class 2615 OID 16622)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 34 (class 2615 OID 16611)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 12 (class 2615 OID 16386)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 41 (class 2615 OID 16603)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 36 (class 2615 OID 16540)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 9 (class 2615 OID 17268)
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- TOC entry 32 (class 2615 OID 16651)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 6 (class 3079 OID 16687)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4550 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 2 (class 3079 OID 16389)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4551 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 4 (class 3079 OID 16441)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4552 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 16652)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4553 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 3 (class 3079 OID 16430)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4554 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1193 (class 1247 OID 16780)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1217 (class 1247 OID 16921)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1190 (class 1247 OID 16774)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1187 (class 1247 OID 16769)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1223 (class 1247 OID 16963)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1280 (class 1247 OID 17277)
-- Name: app_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.app_role AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.app_role OWNER TO postgres;

--
-- TOC entry 1352 (class 1247 OID 22123)
-- Name: member_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.member_type_enum AS ENUM (
    'student',
    'alumni'
);


ALTER TYPE public.member_type_enum OWNER TO postgres;

--
-- TOC entry 1238 (class 1247 OID 17130)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1245 (class 1247 OID 17090)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1248 (class 1247 OID 17105)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1244 (class 1247 OID 17172)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1241 (class 1247 OID 17143)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 433 (class 1255 OID 16538)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4555 (class 0 OID 0)
-- Dependencies: 433
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 459 (class 1255 OID 16751)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 516 (class 1255 OID 16537)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4558 (class 0 OID 0)
-- Dependencies: 516
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 507 (class 1255 OID 16536)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4560 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 421 (class 1255 OID 16595)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- TOC entry 4576 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 518 (class 1255 OID 16616)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 4578 (class 0 OID 0)
-- Dependencies: 518
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 478 (class 1255 OID 16597)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- TOC entry 4580 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 420 (class 1255 OID 16607)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 464 (class 1255 OID 16608)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 463 (class 1255 OID 16618)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 4609 (class 0 OID 0)
-- Dependencies: 463
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 453 (class 1255 OID 16387)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 472 (class 1255 OID 18706)
-- Name: handle_file_deletion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_file_deletion() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.handle_file_deletion() OWNER TO postgres;

--
-- TOC entry 425 (class 1255 OID 18708)
-- Name: handle_file_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_file_update() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.handle_file_update() OWNER TO postgres;

--
-- TOC entry 465 (class 1255 OID 17490)
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
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


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- TOC entry 493 (class 1255 OID 17489)
-- Name: has_role(uuid, public.app_role); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.has_role(_user_id uuid, _role public.app_role) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
  )
$$;


ALTER FUNCTION public.has_role(_user_id uuid, _role public.app_role) OWNER TO postgres;

--
-- TOC entry 513 (class 1255 OID 18442)
-- Name: leave_group(uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.leave_group(p_chat_id uuid, p_user_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.leave_group(p_chat_id uuid, p_user_id uuid) OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 17165)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 521 (class 1255 OID 17248)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 517 (class 1255 OID 17181)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 519 (class 1255 OID 17127)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 511 (class 1255 OID 17122)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 467 (class 1255 OID 17173)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 451 (class 1255 OID 17188)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 430 (class 1255 OID 17121)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 503 (class 1255 OID 17247)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 456 (class 1255 OID 17119)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 458 (class 1255 OID 17154)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 440 (class 1255 OID 17241)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 416 (class 1255 OID 17033)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 492 (class 1255 OID 17002)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 442 (class 1255 OID 17001)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 462 (class 1255 OID 17000)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 496 (class 1255 OID 17014)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 436 (class 1255 OID 17072)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 461 (class 1255 OID 17035)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 419 (class 1255 OID 17088)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 438 (class 1255 OID 17017)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 480 (class 1255 OID 17023)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 349 (class 1259 OID 16523)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 366 (class 1259 OID 16925)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 357 (class 1259 OID 16723)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 357
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 348 (class 1259 OID 16516)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 348
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 361 (class 1259 OID 16812)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 360 (class 1259 OID 16800)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 359 (class 1259 OID 16787)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 367 (class 1259 OID 16975)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 347 (class 1259 OID 16505)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 346 (class 1259 OID 16504)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 346
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 364 (class 1259 OID 16854)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4663 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 365 (class 1259 OID 16872)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4665 (class 0 OID 0)
-- Dependencies: 365
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 350 (class 1259 OID 16531)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4667 (class 0 OID 0)
-- Dependencies: 350
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 358 (class 1259 OID 16753)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4669 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4670 (class 0 OID 0)
-- Dependencies: 358
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 363 (class 1259 OID 16839)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4672 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 362 (class 1259 OID 16830)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4674 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4675 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 345 (class 1259 OID 16493)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4677 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4678 (class 0 OID 0)
-- Dependencies: 345
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 400 (class 1259 OID 24191)
-- Name: answer_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    answer_id uuid,
    user_id uuid,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    parent_comment_id uuid
);


ALTER TABLE public.answer_comments OWNER TO postgres;

--
-- TOC entry 399 (class 1259 OID 24172)
-- Name: answer_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer_votes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    answer_id uuid,
    user_id uuid,
    vote_type smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.answer_votes OWNER TO postgres;

--
-- TOC entry 407 (class 1259 OID 24363)
-- Name: answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    question_id integer,
    user_id uuid,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.answers OWNER TO postgres;

--
-- TOC entry 406 (class 1259 OID 24362)
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answers_id_seq OWNER TO postgres;

--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 406
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- TOC entry 385 (class 1259 OID 17394)
-- Name: chat_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_members (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    chat_id uuid,
    user_id uuid,
    joined_at timestamp with time zone DEFAULT now() NOT NULL,
    is_admin boolean DEFAULT false,
    typing boolean DEFAULT false
);


ALTER TABLE public.chat_members OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 17415)
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    chat_id uuid,
    user_id uuid,
    content text,
    media_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.chat_messages OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 17384)
-- Name: chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chats (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    is_group boolean DEFAULT false NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid
);


ALTER TABLE public.chats OWNER TO postgres;

--
-- TOC entry 394 (class 1259 OID 17914)
-- Name: comment_likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_likes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    comment_id uuid,
    user_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comment_likes OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 17846)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    post_id uuid,
    user_id uuid,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    parent_id uuid
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 22168)
-- Name: content_flags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_flags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    flagged_by_user_id uuid NOT NULL,
    post_id uuid,
    comment_id uuid,
    reason text,
    created_at timestamp with time zone DEFAULT now(),
    status text DEFAULT 'pending'::text,
    CONSTRAINT only_one_content CHECK ((((post_id IS NOT NULL) AND (comment_id IS NULL)) OR ((post_id IS NULL) AND (comment_id IS NOT NULL))))
);


ALTER TABLE public.content_flags OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 17435)
-- Name: filemodels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filemodels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    file_url text NOT NULL,
    file_name text NOT NULL,
    file_type text,
    file_size integer,
    description text,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.filemodels OWNER TO postgres;

--
-- TOC entry 382 (class 1259 OID 17347)
-- Name: followers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    follower_id uuid,
    following_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.followers OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 17327)
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    post_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.likes OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 17368)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    type text NOT NULL,
    data jsonb,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 17310)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    content text NOT NULL,
    media_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    file_url text,
    image_url text,
    flag_status text DEFAULT 'normal'::text
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 17281)
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text NOT NULL,
    full_name text,
    avatar_url text,
    bio text,
    location text,
    website text,
    settings jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    member_type text DEFAULT 'student'::public.member_type_enum,
    status text DEFAULT 'active'::text,
    last_seen timestamp with time zone DEFAULT now(),
    CONSTRAINT member_type_check CHECK ((member_type = ANY (ARRAY['student'::text, 'alumni'::text])))
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- TOC entry 389 (class 1259 OID 17468)
-- Name: qanotifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qanotifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    question_id uuid,
    type text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.qanotifications OWNER TO postgres;

--
-- TOC entry 414 (class 1259 OID 24429)
-- Name: question_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_tags (
    question_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.question_tags OWNER TO postgres;

--
-- TOC entry 402 (class 1259 OID 24271)
-- Name: question_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_votes (
    id bigint NOT NULL,
    question_id uuid,
    user_id uuid,
    vote_type integer NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('ist'::text, now())
);


ALTER TABLE public.question_votes OWNER TO postgres;

--
-- TOC entry 401 (class 1259 OID 24270)
-- Name: question_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.question_votes_id_seq OWNER TO postgres;

--
-- TOC entry 4702 (class 0 OID 0)
-- Dependencies: 401
-- Name: question_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_votes_id_seq OWNED BY public.question_votes.id;


--
-- TOC entry 388 (class 1259 OID 17451)
-- Name: questionanswers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questionanswers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    question text NOT NULL,
    answer text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_answered boolean DEFAULT false NOT NULL
);


ALTER TABLE public.questionanswers OWNER TO postgres;

--
-- TOC entry 405 (class 1259 OID 24347)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    user_id uuid,
    title text NOT NULL,
    body text NOT NULL,
    tags text[],
    category text,
    best_answer_id integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- TOC entry 404 (class 1259 OID 24346)
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- TOC entry 4706 (class 0 OID 0)
-- Dependencies: 404
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- TOC entry 413 (class 1259 OID 24415)
-- Name: reputation_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reputation_events (
    id integer NOT NULL,
    user_id uuid,
    type text NOT NULL,
    value integer NOT NULL,
    related_id integer,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.reputation_events OWNER TO postgres;

--
-- TOC entry 412 (class 1259 OID 24414)
-- Name: reputation_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reputation_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reputation_events_id_seq OWNER TO postgres;

--
-- TOC entry 4709 (class 0 OID 0)
-- Dependencies: 412
-- Name: reputation_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reputation_events_id_seq OWNED BY public.reputation_events.id;


--
-- TOC entry 411 (class 1259 OID 24403)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 24402)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 4712 (class 0 OID 0)
-- Dependencies: 410
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 379 (class 1259 OID 17295)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    role public.app_role DEFAULT 'user'::public.app_role NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 409 (class 1259 OID 24384)
-- Name: votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    user_id uuid,
    target_id integer NOT NULL,
    target_type text,
    value smallint,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT votes_target_type_check CHECK ((target_type = ANY (ARRAY['question'::text, 'answer'::text]))),
    CONSTRAINT votes_value_check CHECK ((value = ANY (ARRAY[1, '-1'::integer])))
);


ALTER TABLE public.votes OWNER TO postgres;

--
-- TOC entry 408 (class 1259 OID 24383)
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.votes_id_seq OWNER TO postgres;

--
-- TOC entry 4716 (class 0 OID 0)
-- Dependencies: 408
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- TOC entry 376 (class 1259 OID 17251)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 391 (class 1259 OID 17572)
-- Name: messages_2025_07_01; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_01 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_01 OWNER TO supabase_admin;

--
-- TOC entry 392 (class 1259 OID 17583)
-- Name: messages_2025_07_02; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_02 OWNER TO supabase_admin;

--
-- TOC entry 395 (class 1259 OID 18590)
-- Name: messages_2025_07_03; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_03 OWNER TO supabase_admin;

--
-- TOC entry 396 (class 1259 OID 22111)
-- Name: messages_2025_07_04; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_04 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_04 OWNER TO supabase_admin;

--
-- TOC entry 398 (class 1259 OID 22578)
-- Name: messages_2025_07_05; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_05 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_05 OWNER TO supabase_admin;

--
-- TOC entry 403 (class 1259 OID 24310)
-- Name: messages_2025_07_06; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_06 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_06 OWNER TO supabase_admin;

--
-- TOC entry 415 (class 1259 OID 25569)
-- Name: messages_2025_07_07; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_07 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_07 OWNER TO supabase_admin;

--
-- TOC entry 368 (class 1259 OID 17018)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 373 (class 1259 OID 17107)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 372 (class 1259 OID 17106)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 351 (class 1259 OID 16544)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4729 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 353 (class 1259 OID 16586)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 352 (class 1259 OID 16559)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4731 (class 0 OID 0)
-- Dependencies: 352
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 369 (class 1259 OID 17037)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 370 (class 1259 OID 17051)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 377 (class 1259 OID 17269)
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- TOC entry 390 (class 1259 OID 17532)
-- Name: seed_files; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.seed_files (
    path text NOT NULL,
    hash text NOT NULL
);


ALTER TABLE supabase_migrations.seed_files OWNER TO postgres;

--
-- TOC entry 3750 (class 0 OID 0)
-- Name: messages_2025_07_01; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_01 FOR VALUES FROM ('2025-07-01 00:00:00') TO ('2025-07-02 00:00:00');


--
-- TOC entry 3751 (class 0 OID 0)
-- Name: messages_2025_07_02; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_02 FOR VALUES FROM ('2025-07-02 00:00:00') TO ('2025-07-03 00:00:00');


--
-- TOC entry 3752 (class 0 OID 0)
-- Name: messages_2025_07_03; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_03 FOR VALUES FROM ('2025-07-03 00:00:00') TO ('2025-07-04 00:00:00');


--
-- TOC entry 3753 (class 0 OID 0)
-- Name: messages_2025_07_04; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_04 FOR VALUES FROM ('2025-07-04 00:00:00') TO ('2025-07-05 00:00:00');


--
-- TOC entry 3754 (class 0 OID 0)
-- Name: messages_2025_07_05; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_05 FOR VALUES FROM ('2025-07-05 00:00:00') TO ('2025-07-06 00:00:00');


--
-- TOC entry 3755 (class 0 OID 0)
-- Name: messages_2025_07_06; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_06 FOR VALUES FROM ('2025-07-06 00:00:00') TO ('2025-07-07 00:00:00');


--
-- TOC entry 3756 (class 0 OID 0)
-- Name: messages_2025_07_07; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_07 FOR VALUES FROM ('2025-07-07 00:00:00') TO ('2025-07-08 00:00:00');


--
-- TOC entry 3766 (class 2604 OID 16508)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3878 (class 2604 OID 24366)
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- TOC entry 3869 (class 2604 OID 24274)
-- Name: question_votes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_votes ALTER COLUMN id SET DEFAULT nextval('public.question_votes_id_seq'::regclass);


--
-- TOC entry 3875 (class 2604 OID 24350)
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- TOC entry 3885 (class 2604 OID 24418)
-- Name: reputation_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reputation_events ALTER COLUMN id SET DEFAULT nextval('public.reputation_events_id_seq'::regclass);


--
-- TOC entry 3883 (class 2604 OID 24406)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 3881 (class 2604 OID 24387)
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- TOC entry 4475 (class 0 OID 16523)
-- Dependencies: 349
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'a241f0d2-17b5-40d1-a7ee-425cad6ad53d', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@focus.com","user_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","user_phone":""}}', '2025-06-29 19:22:07.122184+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '814402c3-6ae6-4ae3-a756-48c9b267e975', '{"action":"user_confirmation_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-29 19:44:42.068002+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ca36c950-4c41-4b24-887e-5ff90b12ae96', '{"action":"user_signedup","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"team"}', '2025-06-29 19:45:05.126174+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'afd8329f-0e3c-4cc5-88b2-55f22de5be4e', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-29 22:17:54.80811+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '1d184e9a-66c8-4b31-b934-2c655f79f82e', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-29 22:17:54.809599+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'bdb913d0-bf75-4231-b9c9-4e8c8d092c2e', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:20:11.900952+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'fdf118a4-c4e3-472e-8032-891c15f047d1', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:20:28.588863+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '5143380c-7124-45f7-a039-b5c5f83f229a', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:28:26.933431+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '703e2dc9-2441-4067-8d08-44c2100d5707', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:28:33.03927+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '582b57a7-1a3f-4986-a25f-304c22a6c4bc', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:28:36.208481+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '170e8cbd-9142-405c-ba74-1fcdf4f71b3a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:29:28.629928+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '90ab0bf2-577c-4648-a5f8-118942f4bafc', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:29:31.728314+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '19e64f8d-5342-4be4-960d-62c1f71608bb', '{"action":"user_recovery_requested","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"user"}', '2025-06-29 22:30:03.478044+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '7e4109ed-a043-4ecb-b61b-fd26471783d7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:30:50.110332+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '1209345d-fa13-401e-8bd2-ee7d6e16ebde', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:31:26.103646+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c39d36e7-c047-4998-bcdc-65dc63b13c52', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:31:31.079402+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'cf87bd93-1c57-4f49-9879-a84b92a746a4', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:40:18.729609+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '12fb8efa-9c61-4baa-948f-11deb3a47642', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 22:40:26.298697+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9d5799c6-b125-4caf-89d7-e36bc49c40e5', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 22:40:31.904669+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b43eb59c-2f51-42be-b93a-3ce93eb8fd34', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:17:55.474222+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c09f3c76-c4a9-4afd-b04c-3cc5ec3646b4', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:18:01.254257+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b2558dc6-b9d3-413b-aebd-ba9665a114b9', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:21:12.491295+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '706b030c-7fb4-4439-8e84-9b434f7534f4', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:21:17.832525+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '888df3b9-b538-4881-9a09-e42feb2f1815', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:23:35.801373+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'cf817116-ac19-4757-9171-1db5196c90e7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:23:42.407452+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd91db514-956e-4ca7-89e0-1e7d255daabd', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:30:10.393676+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'f6ac36e0-445f-44f4-ad0c-2f164be3bb80', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:30:23.465844+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c7374440-e081-43b7-8d01-5d6ef5eaff1b', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:33:16.224381+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2e6a577f-a3ef-40f4-98ee-e78c949df919', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:33:20.663808+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9d591a8a-dfee-4ee8-a0ec-03875b66e300', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:35:18.898228+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3fc31b1e-6bfe-409e-8fd4-7e9d83fbfda5', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:35:25.933742+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'bc8cf643-5dd6-4cd8-8631-503a8a23266b', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:39:22.332913+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd7c9674d-0f7d-4656-9185-58aeba002c0c', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:39:26.513907+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '98214640-a84f-4c53-8829-9a9c0523db15', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:41:41.845218+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'a40e7c74-1b18-44c4-92b4-c59be7399e24', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:41:45.980413+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6b9b84a6-3229-459e-a925-d7749806bfa3', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:50:46.324756+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b2a8ce0c-98dc-4747-be08-514083822015', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:50:50.857801+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8f931198-8026-49d8-b63b-0a3428d6f5e0', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-29 23:52:25.785186+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '649af5ce-e897-4206-8a0a-10a27b3d7c58', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-29 23:52:30.231633+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2ec080c4-0421-4832-ae0e-f456f61fc757', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:02:21.059069+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'a88da835-7264-4793-95bc-1cac544a0bf7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:02:25.012233+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ce72ce7f-c0e0-4dc5-b8ce-b9e7af378c35', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:02:46.693487+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'fbca34ec-bbe4-45b1-bcfa-49fa926393a7', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:02:50.488782+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3fc11cf5-da91-47f3-8aac-4c4982f0c050', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:03:01.271349+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'f5cf5544-5470-4dfd-a73f-0ddd86b6d407', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:03:05.410237+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6e149de9-4ea0-4703-9caf-e37c559805b5', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:07:05.267627+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '483c1b54-5c4f-4647-966f-6d43df35df69', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:07:09.58244+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'de13c7fc-3cd7-484c-a293-151dfc0b8681', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:07:29.197266+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '7bdf9945-bfbc-48f0-b81e-b9c090d86f9e', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:07:33.406766+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'fe9837f8-ed74-4b84-8ef3-f6d0b10ba2b9', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:35:11.591289+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c2f7ec2c-3819-4fc8-a40b-68d8dd8c70d1', '{"action":"user_signedup","actor_id":"d36c190e-3790-4f8a-b17d-7d4c1f550cb2","actor_name":"Kamlesh K","actor_username":"kkamlesh@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:36:15.334698+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'fd236c5b-8728-45bd-9e94-8b598fc50920', '{"action":"login","actor_id":"d36c190e-3790-4f8a-b17d-7d4c1f550cb2","actor_name":"Kamlesh K","actor_username":"kkamlesh@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:36:15.339176+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0db26f13-97bb-4f8f-a4a0-f924a4d67813', '{"action":"logout","actor_id":"d36c190e-3790-4f8a-b17d-7d4c1f550cb2","actor_name":"Kamlesh K","actor_username":"kkamlesh@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:36:18.004966+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '7c16fdea-b01e-4aba-8fde-bd532e1de03f', '{"action":"user_signedup","actor_id":"399e5ea7-4664-4c3c-81d3-b983814d106a","actor_name":"Arjun Reddy","actor_username":"reddyarjun@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:36:46.979682+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ea1c4077-599a-4b8e-9253-19d9b0f7c9d9', '{"action":"login","actor_id":"399e5ea7-4664-4c3c-81d3-b983814d106a","actor_name":"Arjun Reddy","actor_username":"reddyarjun@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:36:46.984063+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '1d58b435-62e1-4b87-8953-2607a2c16fb3', '{"action":"logout","actor_id":"399e5ea7-4664-4c3c-81d3-b983814d106a","actor_name":"Arjun Reddy","actor_username":"reddyarjun@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:36:49.069496+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9953800a-932a-4f16-927a-9083a5f6d642', '{"action":"user_signedup","actor_id":"f8adc086-3c84-4038-820d-5e1cf0d63d39","actor_name":"Arjun Kumar R","actor_username":"kumararjun@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:37:33.762954+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2522932a-1d12-4727-9d8b-ebe21c47f2df', '{"action":"login","actor_id":"f8adc086-3c84-4038-820d-5e1cf0d63d39","actor_name":"Arjun Kumar R","actor_username":"kumararjun@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:37:33.766006+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'a632c6f1-1a7e-4d8a-859e-7e0cb2d8a653', '{"action":"logout","actor_id":"f8adc086-3c84-4038-820d-5e1cf0d63d39","actor_name":"Arjun Kumar R","actor_username":"kumararjun@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:37:36.271204+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '21c82401-0189-4fa7-9a43-499bf2110858', '{"action":"user_signedup","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:38:02.263059+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9e586c3a-939d-40b8-a461-8dcbee696db0', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:38:02.266061+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '722fdb1a-fc11-4066-aea0-7d3d5f891812', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:38:04.807272+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'e9255565-8c8f-4144-81f9-0899bd382292', '{"action":"user_signedup","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:39:16.702146+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4857a8c2-4245-43ca-a170-219f06c7cb91', '{"action":"login","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:39:16.705963+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd465ff88-f0d4-424b-95c2-8ab3e5db8fa4', '{"action":"logout","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:39:19.739256+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4fdb1f76-e842-4a2d-8b9a-75e666d30f79', '{"action":"user_signedup","actor_id":"67f2070a-0399-485a-a8e1-e73241df52c0","actor_name":"Vishnu Singh","actor_username":"vishnusingh@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:39:56.97092+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2577cf00-15ec-49a8-938e-50ae6de40eda', '{"action":"login","actor_id":"67f2070a-0399-485a-a8e1-e73241df52c0","actor_name":"Vishnu Singh","actor_username":"vishnusingh@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:39:56.97403+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '487d2091-82f9-4b33-a071-b4dd05de842e', '{"action":"logout","actor_id":"67f2070a-0399-485a-a8e1-e73241df52c0","actor_name":"Vishnu Singh","actor_username":"vishnusingh@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:39:59.967588+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ac3aaac8-61f3-42cb-84eb-183156decbbb', '{"action":"user_signedup","actor_id":"68e5b8aa-c6b8-4e2d-a303-a1c10717837b","actor_name":"Vishal Reddy","actor_username":"reddyvishal@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:40:52.295348+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '19d0434b-71d1-4711-8acd-cd9fb02f652a', '{"action":"login","actor_id":"68e5b8aa-c6b8-4e2d-a303-a1c10717837b","actor_name":"Vishal Reddy","actor_username":"reddyvishal@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:40:52.299051+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '269112a6-a0b1-4f24-b60a-92e5d141aa83', '{"action":"logout","actor_id":"68e5b8aa-c6b8-4e2d-a303-a1c10717837b","actor_name":"Vishal Reddy","actor_username":"reddyvishal@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:40:55.458552+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c0f483b8-921c-4d8a-99e4-d9560d7273f8', '{"action":"user_signedup","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:41:53.901055+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ca707b55-51dd-4ab4-bf78-1603201da112', '{"action":"login","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:41:53.904345+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd78f6485-76f2-41fd-bd49-c91c91ea7669', '{"action":"logout","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:41:57.263395+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd02c6650-86c5-4c93-b60b-5fe5ba396444', '{"action":"user_signedup","actor_id":"702dc5d1-9186-4350-b20f-d3007319a327","actor_name":"Bhasker Singh","actor_username":"singhbhasker@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:44:07.089675+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3431c628-9437-452d-95f0-f07f0e9ccfb2', '{"action":"login","actor_id":"702dc5d1-9186-4350-b20f-d3007319a327","actor_name":"Bhasker Singh","actor_username":"singhbhasker@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:44:07.093498+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9576e258-4b4b-43f4-8c3f-4f4a2a0cf89f', '{"action":"logout","actor_id":"702dc5d1-9186-4350-b20f-d3007319a327","actor_name":"Bhasker Singh","actor_username":"singhbhasker@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:44:10.075737+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8f5717bf-6516-4f93-a366-9353dd3668c7', '{"action":"user_signedup","actor_id":"e657b686-9443-4cc9-800b-bc7fa4985e35","actor_name":"Parinita Reddy","actor_username":"parinita.k@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-30 00:45:00.798176+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'a4d1c191-6e5d-4ca7-92cc-6e5ac8e026ef', '{"action":"login","actor_id":"e657b686-9443-4cc9-800b-bc7fa4985e35","actor_name":"Parinita Reddy","actor_username":"parinita.k@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:45:00.801848+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '94d3c8b3-ec8d-4926-95ac-82126cc8e463', '{"action":"logout","actor_id":"e657b686-9443-4cc9-800b-bc7fa4985e35","actor_name":"Parinita Reddy","actor_username":"parinita.k@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:45:03.490673+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '39c406cb-a60c-42dd-b383-1a31f622509a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:45:08.659629+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd3a737c9-2bbb-4cc5-9f47-c979d9fce1bd', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 00:55:45.356342+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2a092e0b-ea6a-4988-aaec-9d89c253b037', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 00:56:11.419646+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8104541f-05d6-4478-80cb-f50e3cca47b9', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 01:01:10.672271+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ec6fe9d3-7f85-4167-a12b-3eb58657440f', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:01:15.351084+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '34862e54-588b-4378-92af-72086d1bb864', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 01:01:38.411633+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '489d6425-beb1-4416-8daf-7e07786068aa', '{"action":"login","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:01:54.599955+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c98c3635-4695-4857-8fa4-03060021facb', '{"action":"logout","actor_id":"ffbfa1b0-84c5-45fe-8f31-2eda223ac751","actor_name":"Priyanka KS","actor_username":"priyankaks@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 01:02:29.29485+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '40385356-2e8d-427a-8c8b-841c1be85b5d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:02:37.612564+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6e5a40a0-969f-4b41-afb9-58dd0b7a33da', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 01:17:38.107661+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8aca09f2-81e0-4763-8531-c2af9e10c130', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 02:15:53.563589+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '58834bc2-f75d-40a9-9e04-bdd4f002a7b8', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 02:15:53.564555+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8442a256-4160-4064-8256-182e185f8977', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 03:14:03.637137+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '07dda278-25ce-4528-a6dd-690144eeef9a', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 03:14:03.637937+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '74dbed75-30b0-4850-84b5-ff9f49852f91', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 04:12:26.05562+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c60ea5b1-185e-4853-a597-fbb001be2523', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 04:12:26.056423+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9921280b-c32c-4b2d-be47-cf2ce2afab5b', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 05:11:28.545677+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3cc5aaa6-3dd4-451f-a4d9-56f87c9b8944', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 05:11:28.551081+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3d5105f3-ef03-4e42-b64d-c315d4e197b6', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 05:40:12.537804+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '18c11444-b068-4dba-9d46-db2fb06d28b6', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 06:10:00.495662+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '19fd4ba8-d53c-4790-a0f7-31a6c7ee73cc', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 06:10:00.497231+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '713cd5f6-cc00-47f8-b6ea-fc3fe384e392', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 06:10:04.27473+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2fea3e89-9d01-4a94-a3d0-470bd8fd6417', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 07:48:35.705778+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3f34d630-37e9-4213-bb66-7fcd28315c1b', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 08:46:41.381524+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6a86226a-6514-4aea-91b1-7633c2a86014', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 08:46:41.38542+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '55602ffd-c91c-4730-9288-be72868a4023', '{"action":"login","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 09:10:52.543695+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd06e716e-f30e-4e42-bc4d-5c7284e13f1b', '{"action":"logout","actor_id":"719c5acf-8f3e-4064-ac1a-00c3692901ba","actor_name":"Aakash Kumar","actor_username":"aakashkumar@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 09:11:14.478271+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'be5258ff-a759-47cd-b685-cd87858abe38', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 09:44:44.81532+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '26ee0ca8-9aec-4e35-b35e-7da1743b3059', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 09:44:44.816139+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6168932c-aef6-4f66-abaa-880799deb8cc', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 10:10:46.285409+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ef9163d4-86ec-4706-a287-3c560a312a72', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 10:42:56.208346+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'cb4c4c4c-9a6a-4e6c-b11f-3dccc4f7b6f2', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 10:42:56.20983+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b5a15eb4-38f0-4bae-9ec4-0ff3796b3f4d', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 21:49:31.770203+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ae41847e-c9fa-4c3f-b7c5-d79e45a38286', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 21:49:31.779704+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '145e4bc5-ca8f-4d22-86b3-b835cb89ac97', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-30 22:12:53.601213+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'bb34ae66-de09-48c2-b5fa-22428dcb79c0', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-30 22:13:02.457488+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd2acbe08-ff7e-47cc-8eca-c5af5e503163', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 23:11:32.100937+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'deeda7db-a15c-4b5e-a8a8-0a01236f95d1', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-30 23:11:32.104247+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '662abbd8-7fc3-454c-bf6f-cdb0159c414b', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 00:03:59.593435+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ee4a67e1-74b3-4704-a5bc-fa446b6013e0', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 00:09:37.620287+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4f14b7b5-a6fc-4bfb-8545-0274c44fab7c', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 00:09:37.624187+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0e8b0fbe-61ab-4c9d-8f90-66515268fbb6', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 01:00:39.710914+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '5d4ac09b-8b2f-4b30-bc6d-8e3b1c1c5870', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 01:05:20.075557+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6ae7dd1c-d5ad-4656-9f30-0fab09e8b371', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 01:05:55.525404+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '59f48142-ed22-441c-bdb4-83f4533459e6', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 01:45:16.947637+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd74680e5-826b-4231-b180-bf46923ac214', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:31:28.410444+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '005a6e3c-b789-4e19-8820-c0a33b6e4594', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:31:34.415412+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'bccc1c1e-dc41-479f-871c-c1a22c157c6d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 20:08:24.816912+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'a68fbd35-c12b-4c41-925f-0185d6d07edf', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 20:31:12.701708+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c5c80915-d355-4ee6-8e87-ac4fa6b6f68a', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 20:31:20.300477+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'dcbb16a4-4b79-411c-b650-6ba01aa3b4a0', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:22:18.496871+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4cbff8f8-104a-4cf5-a070-8df717326ebc', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 21:29:48.021205+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9bb3cac6-1a65-42ce-a573-6aa3c9aa0589', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 21:29:48.023394+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '155cc478-e09d-45e9-ad22-370b6f52fea8', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:31:21.279897+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9ef77b64-664c-485e-9fc4-316944bbb3db', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:32:28.318123+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2dd5c958-f07e-42d5-96a7-7b18b3635f4a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:32:38.177602+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ee420ec3-e26e-451c-a417-2ba6a11297cc', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:33:32.517244+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3c5b2b19-e8cb-41d7-a8b2-582f1aed071a', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:37:36.937872+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9518bc2d-a9b0-4c23-9190-e580aeab4c1c', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:37:39.660472+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ab0698da-1b23-46e1-a287-17f967361f52', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:37:55.940866+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9077c4e0-df10-4f0e-bbd4-9586ebf2174b', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:37:59.016349+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4c819c6b-0599-4c8d-97c6-77ebe5a071b3', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:38:07.088592+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '87408ffe-1ce6-4a97-8c91-35cd3be60ae9', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:39:43.988689+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2f55fd14-19f8-4fb8-aea9-759f43b345ae', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:39:51.964857+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '1c4007ea-cf86-4fa5-9c72-80d01b495a77', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:43:33.90903+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '08bcb718-b5d4-4e78-9077-ba4498490e27', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 21:45:56.070487+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0e51f90f-f081-4735-95ef-e00b1eefe2a4', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 21:46:01.156369+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6e73ea6b-cdec-4b42-8bdd-dba652c34f75', '{"action":"token_refreshed","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 22:48:22.720829+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd072ffd5-887f-44ad-9ecd-e1a2885a9040', '{"action":"token_revoked","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-01 22:48:22.7237+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c60233fa-a1f7-43e8-afbe-d755b08c83a2', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 23:22:16.049579+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'bfa258b8-31d9-4d01-9a5e-18b1fc8f3eb9', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 23:22:23.369447+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0230f245-b82e-4787-91ed-8d2c86850e77', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 23:25:46.269836+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b7faaa0c-50dd-42a1-acef-b4b16c030f8b', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 23:25:51.549874+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'f6d8f222-15c6-44eb-8998-9847e809392f', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:04:49.112874+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '29aab70b-6cd1-46a0-84ff-f923af68a8ff', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:04:54.360128+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '896f5263-8f1b-4ebf-b887-c5f64de31d3d', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:07:59.644837+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b1301e69-3db3-46f7-a78c-dbe2fdb2932a', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:08:05.829169+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2c0e3f57-560e-4eb4-8307-860063c138d4', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:08:41.930943+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0c18b435-6a26-4abe-8e05-ec9d0af27373', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:08:48.04376+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2cb40bd2-e4f3-479c-b08f-5aaf0e61d393', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:10:50.073849+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '18755e6b-f227-4d08-a2aa-865139ad891f', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:11:03.670794+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9835652f-bff0-4a54-852e-96934c451c92', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:11:12.477978+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'e158006a-1b67-4f2c-bff2-37809fe3ff29', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:11:17.537436+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ebc053c5-d27d-4a5b-85fc-96573eec9c62', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:12:43.973886+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '80446f25-82c1-4d38-9148-96d6d99c9dc2', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:12:49.178142+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '62f77257-a494-4e8a-b2ad-adfdc78fd2de', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:14:00.150164+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '42d5428c-cacc-4980-bc3a-224960f553ca', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:14:05.174617+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '65535c9e-6983-41ed-97fc-23b125f9076f', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:14:10.40243+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0cf5c288-d97a-45a1-ab14-2ba5185851b3', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:14:20.886661+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0e41d651-d9d1-45d2-89b4-7778bfd44a2e', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:15:39.802265+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'e72ec2f5-af7f-480f-a077-dbec521db931', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:15:45.817107+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b065513b-1213-4e28-8f9f-f13095903f87', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:17:43.480487+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd8bbccb5-4f5b-4e42-874a-8b8a2a99e7cb', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:17:48.331634+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0f6117d7-9263-47a8-84b9-2da51ecd8f5f', '{"action":"user_updated_password","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:21:12.82389+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '283eb720-7735-4601-889b-8f066ca2cc3b', '{"action":"user_modified","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:21:12.825507+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '38c122d0-8e14-44ab-8c3d-d254bcc7373c', '{"action":"user_updated_password","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:22:15.410494+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '72ea3ea0-25e2-4d85-8b49-0dbf202ee731', '{"action":"user_modified","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"user"}', '2025-07-02 00:22:15.411141+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0d0032e9-07ac-4523-99e4-0d4694471e0e', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:43:35.975056+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '34e9e31e-cb1d-4bc4-a151-1f245ffee0c4', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 00:53:21.671689+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '1b495f1d-89a5-40fd-9c77-535b88eb6fe6', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 00:56:23.230466+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'fbeba7b1-0f6c-44e3-8480-eae29f3ded26', '{"action":"user_signedup","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-02 01:17:23.380314+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ec44abb9-bfa6-45c6-9176-712e492c5daf', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 01:17:23.38812+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'f495165c-d88e-4a63-8458-4ec3cf9340d7', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 01:25:23.147427+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '46e06123-3529-48db-b5cc-14802edb718b', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 01:25:31.299845+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'a11d55a5-bdf3-49da-9dbc-8846ffad1ec6', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 01:25:50.060629+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'cad50268-c369-4f11-a920-46ca2ac5f38d', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 01:25:56.254599+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'f493e8c1-e21c-4ab3-9890-6113984701d4', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-02 01:26:04.073915+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'f1476a9a-b2af-42df-9a62-c66ca7ef474e', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 11:27:51.141732+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '48ab553a-1ccc-4523-bde3-b0cff6e1d0a7', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 11:28:25.273144+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '864dad27-8221-4ae8-b5c5-15ce38ca7e97', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 22:05:16.180236+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8ec12a22-7822-463c-b07f-556997afd2c7', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 22:05:16.190302+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0493e1e9-2a54-401c-a78a-7824b4e9438d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 22:16:54.45633+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4868dea9-159d-4bcd-a90f-85e682123800', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:03:45.374284+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6f958c07-27fc-48b6-ae66-c9787f294184', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:03:45.377797+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '76971c2d-c3d9-4389-a4a4-a8d90ca24bdf', '{"action":"login","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-02 23:05:22.535983+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '49ff544f-a7e5-4bb7-af2b-2d55b93161f4', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:15:25.110588+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '5dfafe23-56ca-40b7-9875-f1913c441fd5', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-02 23:15:25.116666+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '54c851b6-6dfe-421e-9a9f-96c1c7a87688', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:01:00.159782+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b4165f95-32d6-4222-8e49-1e210e6736a4', '{"action":"logout","actor_id":"306f8931-2603-4c86-b3ab-f804c2c5be57","actor_name":"jignesh","actor_username":"jignesh.vision.17@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:01:25.939913+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '5ba0d498-5659-4690-b660-11a874de3e32', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 00:01:59.363163+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '1df15d13-07f0-416f-8cfa-06556fa7c3ac', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 00:01:59.3637+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '7a4ab5ef-edd1-46fd-b772-1c638e1d6a8d', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:02:10.817083+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6b6950e2-740f-4515-8d1e-4ad3b736e079', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:02:31.282631+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'e4845ec7-aa04-43e4-a5c0-6666a9361a1a', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:02:36.741209+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '96c5d721-4266-42ae-bf7d-cf2384bda8ab', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:07:44.948477+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c72c1051-9413-46b4-bb96-c97f57d5d1e7', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:11:50.806564+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8ee64614-ee4a-4449-a432-cbc510282e27', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:13:51.713389+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '77103473-000b-4c37-af3a-06af7052f562', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:13:53.67542+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ea46ca1f-c215-46e6-a10f-34f7eceafb9b', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:14:23.597473+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0ce7ff04-803a-44e8-b108-eae69eb8e8a6', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 00:14:23.987993+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'fc1254d9-5ef2-4ce7-ad34-5ad4a679e72b', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:14:36.750136+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'be3739ac-e5b7-416c-9003-9d1703f7ea51', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 00:24:40.115325+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c0de857f-3857-4119-9a45-d53eaec7f44b', '{"action":"token_refreshed","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:00:23.238358+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0e20eb53-94a5-4b76-b0e7-cf1e886ff53c', '{"action":"token_revoked","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:00:23.240487+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ecc97c20-c1db-4313-9d5f-ee4895efd537', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 01:01:37.71495+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8504603b-af2d-4d3a-ad54-eb4e9d89a3b9', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 01:04:52.505441+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ac8c5ab9-cbc1-4d8a-ba1b-c9281ac6b37d', '{"action":"token_refreshed","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:13:01.645456+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '5f61aa82-5b44-4105-a6ae-42bf08b8cbdc', '{"action":"token_revoked","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 01:13:01.648774+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '1e5fdeac-f26f-4857-9cb9-1711f200d01a', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 01:13:21.235939+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'eb465c4d-df4c-4cbe-ab6a-579efab6afa3', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 01:17:34.175548+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '54733244-a221-4fe4-bb52-5fd00d1cdcc4', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 01:17:41.17927+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '81ac377a-166b-4ba7-9e67-a3e61a8ba607', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 02:16:24.246617+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4e576418-916d-4215-be6d-c6d72e08f0b2', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 02:16:24.248891+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '5a7225bb-b9f2-49b9-9bd2-6484079c28dd', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 02:56:35.894045+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'f31662c5-8ed0-49ef-9043-552d5ffc5bbc', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 16:18:36.529914+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'eb5deafb-75c1-4348-9d57-00d0a6779a6c', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 16:30:20.53198+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9e2bff4c-9b3e-414a-a302-14f585f1baa5', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 16:32:58.303487+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2da0d171-139b-4e5a-b160-a66d2a7dd99e', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 16:35:54.181916+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'e5b4d12e-9de6-4269-87db-f023ad3e8161', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 18:54:50.63322+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2c96ffa0-54bb-4acb-9d24-a3d5cdbe4889', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 19:54:08.378903+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '92c75e66-ae50-449f-9b1a-7a4783352dd8', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 19:54:08.381604+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3ac6137b-cf07-4f4f-ad94-74b8e686a510', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 21:06:49.639176+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '6be9f880-3864-4960-ae75-8c202364a9f1', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 21:06:49.644373+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '0cefe841-a9a3-48c6-b790-8cf9744a0cd5', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 23:07:52.93473+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '9335700a-61ea-4fbb-adce-7c14e0a6f903', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 23:08:02.378435+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '89ce1c6d-3e34-43cc-ad6f-12ba7698dd6a', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 01:46:19.85137+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ae558788-c3a7-49e5-977a-ed832257f814', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 01:46:40.38731+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '4de319c5-2aef-4fae-aaf2-d28216534d1d', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 01:46:47.470574+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '095eea92-9cd0-4a3e-84fc-fb174e9bee0d', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 07:35:26.124254+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3fe03229-c2ee-4e55-90a9-bab816f44b6c', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 07:35:26.129794+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '2dff0d3a-76b1-44f2-a9d1-d6299c0f307e', '{"action":"user_signedup","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-04 12:25:16.870388+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd5c39889-238e-4a95-8ab9-f404eef5c93b', '{"action":"login","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 12:25:16.889814+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd18d5039-f770-4c4d-9035-946c31332802', '{"action":"logout","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 12:25:49.382767+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c5977b3f-bb6e-453d-813b-b83a12e454f9', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 14:49:49.738377+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd9150692-68ff-4014-8bff-26d1b89ca024', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 14:49:49.742763+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '56f77f83-e6ae-4ed5-96c0-0ced1940a8b2', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 14:49:57.048604+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '3bc5c5d7-c236-456a-aa0f-cc69de1da2cf', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 14:50:25.125037+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'e28446e3-4cc4-46c2-814a-4e42bdba17f3', '{"action":"logout","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 14:51:53.736648+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd953a6c9-7a63-408f-bd3b-a5a992e8888c', '{"action":"login","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 14:52:06.891697+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ee4b4b3d-fabd-4b30-a207-006d653040b1', '{"action":"logout","actor_id":"d2b3a071-141a-4c3a-8a63-53eaefa012c3","actor_username":"admin@focus.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 14:57:35.61369+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'de921466-c20b-4b16-ad7a-6b66b81cc436', '{"action":"login","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 14:57:45.151846+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'b869a65a-8e2d-4850-822b-af4d2090ef77', '{"action":"login","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 15:01:01.739641+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '8da53088-6b59-44fd-86bd-e833286e2e62', '{"action":"logout","actor_id":"d84fecf1-b3de-4a54-a2f3-2fd69740d572","actor_name":"google","actor_username":"google@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 15:01:35.154337+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'e4ad10bf-4e5e-4906-a0bb-463e5c280bc0', '{"action":"login","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 15:19:42.79348+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd232c2c2-8be8-411f-8f31-f89ad409e468', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 15:57:58.583048+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '51074b83-03af-4241-96d2-63414e5eca54', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 15:57:58.585824+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'fe082806-2edb-429f-8167-0e0f2df64b0f', '{"action":"token_refreshed","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 16:19:04.750567+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'd8018905-ceff-401a-b177-1b40ab27234e', '{"action":"token_revoked","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 16:19:04.752115+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'ff8a0c2d-4bce-47e2-a73d-76e6e892d46f', '{"action":"token_refreshed","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:17:44.726504+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '88c3dd9d-66fa-457d-81f5-e3f7873169f5', '{"action":"token_revoked","actor_id":"2ce68cde-0d58-4a03-9e4c-5e5e041eae03","actor_name":"Anjali Kulkarni","actor_username":"anjalikulkarni2424@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:17:44.729783+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', '52e6fe16-2445-4e6a-ab6c-a0720019f5fb', '{"action":"token_refreshed","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:25:14.487539+05:30', '');
INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES ('00000000-0000-0000-0000-000000000000', 'c5624512-2677-40f3-b8d6-295c88f6e85b', '{"action":"token_revoked","actor_id":"1319be79-c9ec-450f-8115-4445c9da6d98","actor_name":"Priya Kumari","actor_username":"priyakumari@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:25:14.490118+05:30', '');


--
-- TOC entry 4489 (class 0 OID 16925)
-- Dependencies: 366
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4480 (class 0 OID 16723)
-- Dependencies: 357
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('d2b3a071-141a-4c3a-8a63-53eaefa012c3', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '{"sub": "d2b3a071-141a-4c3a-8a63-53eaefa012c3", "email": "admin@focus.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-29 19:22:07.120035+05:30', '2025-06-29 19:22:07.121237+05:30', '2025-06-29 19:22:07.121237+05:30', 'f3a0b411-2f9d-4810-a5e8-75fb1541b1c3');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('306f8931-2603-4c86-b3ab-f804c2c5be57', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{"sub": "306f8931-2603-4c86-b3ab-f804c2c5be57", "email": "jignesh.vision.17@gmail.com", "full_name": "jignesh", "email_verified": true, "phone_verified": false}', 'email', '2025-06-29 19:44:42.064+05:30', '2025-06-29 19:44:42.064062+05:30', '2025-06-29 19:44:42.064062+05:30', 'c9ad5b8b-9331-4a62-a529-22364032709f');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '{"sub": "d36c190e-3790-4f8a-b17d-7d4c1f550cb2", "email": "kkamlesh@gmail.com", "full_name": "Kamlesh K", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:36:15.330935+05:30', '2025-06-30 00:36:15.330986+05:30', '2025-06-30 00:36:15.330986+05:30', 'a382845a-9c32-45a2-9f40-9e5afef0a988');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('399e5ea7-4664-4c3c-81d3-b983814d106a', '399e5ea7-4664-4c3c-81d3-b983814d106a', '{"sub": "399e5ea7-4664-4c3c-81d3-b983814d106a", "email": "reddyarjun@gmail.com", "full_name": "Arjun Reddy", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:36:46.976397+05:30', '2025-06-30 00:36:46.976445+05:30', '2025-06-30 00:36:46.976445+05:30', '8886a883-2910-4159-ae84-59595bf22cc5');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '{"sub": "f8adc086-3c84-4038-820d-5e1cf0d63d39", "email": "kumararjun@gmail.com", "full_name": "Arjun Kumar R", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:37:33.760289+05:30', '2025-06-30 00:37:33.760334+05:30', '2025-06-30 00:37:33.760334+05:30', '23f028e6-6f5d-4157-8a00-1f7f2eb55279');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('1319be79-c9ec-450f-8115-4445c9da6d98', '1319be79-c9ec-450f-8115-4445c9da6d98', '{"sub": "1319be79-c9ec-450f-8115-4445c9da6d98", "email": "priyakumari@gmail.com", "full_name": "Priya Kumari", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:38:02.26114+05:30', '2025-06-30 00:38:02.261184+05:30', '2025-06-30 00:38:02.261184+05:30', 'f48a98be-fb77-4e78-9f5b-2c29fa294644');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '{"sub": "ffbfa1b0-84c5-45fe-8f31-2eda223ac751", "email": "priyankaks@gmail.com", "full_name": "Priyanka KS", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:39:16.699203+05:30', '2025-06-30 00:39:16.699252+05:30', '2025-06-30 00:39:16.699252+05:30', 'a536474a-2b9d-4210-89d4-4bca761a01bc');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('67f2070a-0399-485a-a8e1-e73241df52c0', '67f2070a-0399-485a-a8e1-e73241df52c0', '{"sub": "67f2070a-0399-485a-a8e1-e73241df52c0", "email": "vishnusingh@gmail.com", "full_name": "Vishnu Singh", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:39:56.969004+05:30', '2025-06-30 00:39:56.96905+05:30', '2025-06-30 00:39:56.96905+05:30', '6612ed83-6985-4ce0-a52a-d7ba807cd994');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '{"sub": "68e5b8aa-c6b8-4e2d-a303-a1c10717837b", "email": "reddyvishal@gmail.com", "full_name": "Vishal Reddy", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:40:52.293512+05:30', '2025-06-30 00:40:52.293557+05:30', '2025-06-30 00:40:52.293557+05:30', '341f537e-c23b-4938-b844-e08a1cf07d89');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('719c5acf-8f3e-4064-ac1a-00c3692901ba', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '{"sub": "719c5acf-8f3e-4064-ac1a-00c3692901ba", "email": "aakashkumar@gmail.com", "full_name": "Aakash Kumar", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:41:53.89814+05:30', '2025-06-30 00:41:53.898188+05:30', '2025-06-30 00:41:53.898188+05:30', '9104fc28-eee7-4b3c-ac09-83177f4c3bbd');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('702dc5d1-9186-4350-b20f-d3007319a327', '702dc5d1-9186-4350-b20f-d3007319a327', '{"sub": "702dc5d1-9186-4350-b20f-d3007319a327", "email": "singhbhasker@gmail.com", "full_name": "Bhasker Singh", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:44:07.087333+05:30', '2025-06-30 00:44:07.087389+05:30', '2025-06-30 00:44:07.087389+05:30', '38f8aa3c-0293-4cc5-9d10-25eb2fbae500');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('e657b686-9443-4cc9-800b-bc7fa4985e35', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '{"sub": "e657b686-9443-4cc9-800b-bc7fa4985e35", "email": "parinita.k@gmail.com", "full_name": "Parinita Reddy", "email_verified": false, "phone_verified": false}', 'email', '2025-06-30 00:45:00.796201+05:30', '2025-06-30 00:45:00.796251+05:30', '2025-06-30 00:45:00.796251+05:30', 'babd6aef-8fa8-4ab9-b91a-d5e731a3b78e');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('d84fecf1-b3de-4a54-a2f3-2fd69740d572', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '{"sub": "d84fecf1-b3de-4a54-a2f3-2fd69740d572", "email": "google@gmail.com", "full_name": "google", "member_type": "student", "email_verified": false, "phone_verified": false}', 'email', '2025-07-02 01:17:23.372109+05:30', '2025-07-02 01:17:23.372169+05:30', '2025-07-02 01:17:23.372169+05:30', 'c58f2b9b-2cc0-4667-8e2f-7b20d71112d8');
INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '{"sub": "2ce68cde-0d58-4a03-9e4c-5e5e041eae03", "email": "anjalikulkarni2424@gmail.com", "full_name": "Anjali Kulkarni", "member_type": "student", "email_verified": false, "phone_verified": false}', 'email', '2025-07-04 12:25:16.855859+05:30', '2025-07-04 12:25:16.85591+05:30', '2025-07-04 12:25:16.85591+05:30', 'afd570dc-1656-400e-8eb3-26ea4eca145c');


--
-- TOC entry 4474 (class 0 OID 16516)
-- Dependencies: 348
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4484 (class 0 OID 16812)
-- Dependencies: 361
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) VALUES ('c5e9725a-c925-4987-9fd7-886c8ce01a85', '2025-07-04 14:57:45.157112+05:30', '2025-07-04 14:57:45.157112+05:30', 'password', '996045ae-05df-47a6-8067-2235bcf220d4');
INSERT INTO auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) VALUES ('4b65ff37-dfa7-4027-aa0a-1751428f1277', '2025-07-04 15:19:42.801761+05:30', '2025-07-04 15:19:42.801761+05:30', 'password', '35c10ae8-31e3-46a3-96c1-4f9e8077595c');


--
-- TOC entry 4483 (class 0 OID 16800)
-- Dependencies: 360
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4482 (class 0 OID 16787)
-- Dependencies: 359
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4490 (class 0 OID 16975)
-- Dependencies: 367
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) VALUES ('6d93915f-b35c-460c-8c39-6afb13231f33', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'recovery_token', '6c014070479329cb5cb412972867dc8e8a5d36711c01c591500d3bea', 'jignesh.vision.17@gmail.com', '2025-06-29 17:00:06.294691', '2025-06-29 17:00:06.294691');


--
-- TOC entry 4473 (class 0 OID 16505)
-- Dependencies: 347
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) VALUES ('00000000-0000-0000-0000-000000000000', 122, 'a3abfe34wyig', '1319be79-c9ec-450f-8115-4445c9da6d98', true, '2025-07-04 14:57:45.154166+05:30', '2025-07-04 15:57:58.58632+05:30', NULL, 'c5e9725a-c925-4987-9fd7-886c8ce01a85');
INSERT INTO auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) VALUES ('00000000-0000-0000-0000-000000000000', 124, 'wqkd47n5zjqw', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', true, '2025-07-04 15:19:42.797649+05:30', '2025-07-04 16:19:04.75268+05:30', NULL, '4b65ff37-dfa7-4027-aa0a-1751428f1277');
INSERT INTO auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) VALUES ('00000000-0000-0000-0000-000000000000', 126, '7akmijlgci5l', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', true, '2025-07-04 16:19:04.754746+05:30', '2025-07-04 17:17:44.730305+05:30', 'wqkd47n5zjqw', '4b65ff37-dfa7-4027-aa0a-1751428f1277');
INSERT INTO auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) VALUES ('00000000-0000-0000-0000-000000000000', 127, 'qbceuf2ldmg5', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', false, '2025-07-04 17:17:44.731623+05:30', '2025-07-04 17:17:44.731623+05:30', '7akmijlgci5l', '4b65ff37-dfa7-4027-aa0a-1751428f1277');
INSERT INTO auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) VALUES ('00000000-0000-0000-0000-000000000000', 125, '6wtvzay2aeym', '1319be79-c9ec-450f-8115-4445c9da6d98', true, '2025-07-04 15:57:58.588658+05:30', '2025-07-04 17:25:14.49062+05:30', 'a3abfe34wyig', 'c5e9725a-c925-4987-9fd7-886c8ce01a85');
INSERT INTO auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) VALUES ('00000000-0000-0000-0000-000000000000', 128, 'qqcwydsggeb7', '1319be79-c9ec-450f-8115-4445c9da6d98', false, '2025-07-04 17:25:14.491978+05:30', '2025-07-04 17:25:14.491978+05:30', '6wtvzay2aeym', 'c5e9725a-c925-4987-9fd7-886c8ce01a85');


--
-- TOC entry 4487 (class 0 OID 16854)
-- Dependencies: 364
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4488 (class 0 OID 16872)
-- Dependencies: 365
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4476 (class 0 OID 16531)
-- Dependencies: 350
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.schema_migrations (version) VALUES ('20171026211738');
INSERT INTO auth.schema_migrations (version) VALUES ('20171026211808');
INSERT INTO auth.schema_migrations (version) VALUES ('20171026211834');
INSERT INTO auth.schema_migrations (version) VALUES ('20180103212743');
INSERT INTO auth.schema_migrations (version) VALUES ('20180108183307');
INSERT INTO auth.schema_migrations (version) VALUES ('20180119214651');
INSERT INTO auth.schema_migrations (version) VALUES ('20180125194653');
INSERT INTO auth.schema_migrations (version) VALUES ('00');
INSERT INTO auth.schema_migrations (version) VALUES ('20210710035447');
INSERT INTO auth.schema_migrations (version) VALUES ('20210722035447');
INSERT INTO auth.schema_migrations (version) VALUES ('20210730183235');
INSERT INTO auth.schema_migrations (version) VALUES ('20210909172000');
INSERT INTO auth.schema_migrations (version) VALUES ('20210927181326');
INSERT INTO auth.schema_migrations (version) VALUES ('20211122151130');
INSERT INTO auth.schema_migrations (version) VALUES ('20211124214934');
INSERT INTO auth.schema_migrations (version) VALUES ('20211202183645');
INSERT INTO auth.schema_migrations (version) VALUES ('20220114185221');
INSERT INTO auth.schema_migrations (version) VALUES ('20220114185340');
INSERT INTO auth.schema_migrations (version) VALUES ('20220224000811');
INSERT INTO auth.schema_migrations (version) VALUES ('20220323170000');
INSERT INTO auth.schema_migrations (version) VALUES ('20220429102000');
INSERT INTO auth.schema_migrations (version) VALUES ('20220531120530');
INSERT INTO auth.schema_migrations (version) VALUES ('20220614074223');
INSERT INTO auth.schema_migrations (version) VALUES ('20220811173540');
INSERT INTO auth.schema_migrations (version) VALUES ('20221003041349');
INSERT INTO auth.schema_migrations (version) VALUES ('20221003041400');
INSERT INTO auth.schema_migrations (version) VALUES ('20221011041400');
INSERT INTO auth.schema_migrations (version) VALUES ('20221020193600');
INSERT INTO auth.schema_migrations (version) VALUES ('20221021073300');
INSERT INTO auth.schema_migrations (version) VALUES ('20221021082433');
INSERT INTO auth.schema_migrations (version) VALUES ('20221027105023');
INSERT INTO auth.schema_migrations (version) VALUES ('20221114143122');
INSERT INTO auth.schema_migrations (version) VALUES ('20221114143410');
INSERT INTO auth.schema_migrations (version) VALUES ('20221125140132');
INSERT INTO auth.schema_migrations (version) VALUES ('20221208132122');
INSERT INTO auth.schema_migrations (version) VALUES ('20221215195500');
INSERT INTO auth.schema_migrations (version) VALUES ('20221215195800');
INSERT INTO auth.schema_migrations (version) VALUES ('20221215195900');
INSERT INTO auth.schema_migrations (version) VALUES ('20230116124310');
INSERT INTO auth.schema_migrations (version) VALUES ('20230116124412');
INSERT INTO auth.schema_migrations (version) VALUES ('20230131181311');
INSERT INTO auth.schema_migrations (version) VALUES ('20230322519590');
INSERT INTO auth.schema_migrations (version) VALUES ('20230402418590');
INSERT INTO auth.schema_migrations (version) VALUES ('20230411005111');
INSERT INTO auth.schema_migrations (version) VALUES ('20230508135423');
INSERT INTO auth.schema_migrations (version) VALUES ('20230523124323');
INSERT INTO auth.schema_migrations (version) VALUES ('20230818113222');
INSERT INTO auth.schema_migrations (version) VALUES ('20230914180801');
INSERT INTO auth.schema_migrations (version) VALUES ('20231027141322');
INSERT INTO auth.schema_migrations (version) VALUES ('20231114161723');
INSERT INTO auth.schema_migrations (version) VALUES ('20231117164230');
INSERT INTO auth.schema_migrations (version) VALUES ('20240115144230');
INSERT INTO auth.schema_migrations (version) VALUES ('20240214120130');
INSERT INTO auth.schema_migrations (version) VALUES ('20240306115329');
INSERT INTO auth.schema_migrations (version) VALUES ('20240314092811');
INSERT INTO auth.schema_migrations (version) VALUES ('20240427152123');
INSERT INTO auth.schema_migrations (version) VALUES ('20240612123726');
INSERT INTO auth.schema_migrations (version) VALUES ('20240729123726');
INSERT INTO auth.schema_migrations (version) VALUES ('20240802193726');
INSERT INTO auth.schema_migrations (version) VALUES ('20240806073726');
INSERT INTO auth.schema_migrations (version) VALUES ('20241009103726');


--
-- TOC entry 4481 (class 0 OID 16753)
-- Dependencies: 358
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) VALUES ('4b65ff37-dfa7-4027-aa0a-1751428f1277', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '2025-07-04 15:19:42.795826+05:30', '2025-07-04 17:17:44.736487+05:30', NULL, 'aal1', NULL, '2025-07-04 11:47:44.736416', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '157.50.204.32', NULL);
INSERT INTO auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) VALUES ('c5e9725a-c925-4987-9fd7-886c8ce01a85', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-04 14:57:45.152598+05:30', '2025-07-04 17:25:14.494204+05:30', NULL, 'aal1', NULL, '2025-07-04 11:55:14.494134', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '157.48.222.117', NULL);


--
-- TOC entry 4486 (class 0 OID 16839)
-- Dependencies: 363
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4485 (class 0 OID 16830)
-- Dependencies: 362
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- TOC entry 4471 (class 0 OID 16493)
-- Dependencies: 345
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'authenticated', 'authenticated', 'priyankaks@gmail.com', '$2a$10$75VIl5wANMIyCPU1onYE.u9CruDl3AAhydNCGcRHZK3eTfnegLPSC', '2025-06-30 00:39:16.702774+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 01:01:54.600656+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "ffbfa1b0-84c5-45fe-8f31-2eda223ac751", "email": "priyankaks@gmail.com", "full_name": "Priyanka KS", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:39:16.694104+05:30', '2025-06-30 01:01:54.603053+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '67f2070a-0399-485a-a8e1-e73241df52c0', 'authenticated', 'authenticated', 'vishnusingh@gmail.com', '$2a$10$C2YBeguoY3nd6pMJpdBoI.ESQMnRBrYlPNaWAfgwKp37jOueElIAm', '2025-06-30 00:39:56.971365+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:39:56.974527+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "67f2070a-0399-485a-a8e1-e73241df52c0", "email": "vishnusingh@gmail.com", "full_name": "Vishnu Singh", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:39:56.966368+05:30', '2025-06-30 00:39:56.976875+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'authenticated', 'authenticated', 'parinita.k@gmail.com', '$2a$10$.BE1kRWyA3E6frx/1lEGsucOx4nnc3HxamoNyW/GZCq7a8ykPXxgO', '2025-06-30 00:45:00.798628+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:45:00.802295+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "e657b686-9443-4cc9-800b-bc7fa4985e35", "email": "parinita.k@gmail.com", "full_name": "Parinita Reddy", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:45:00.793755+05:30', '2025-06-30 00:45:00.804477+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'authenticated', 'authenticated', 'kkamlesh@gmail.com', '$2a$10$.ts4bniyWP0jXRKpkyDeXeVzVLMP2WUJkHDTjuuPd9BePolJUBV62', '2025-06-30 00:36:15.335363+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:36:15.339664+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "d36c190e-3790-4f8a-b17d-7d4c1f550cb2", "email": "kkamlesh@gmail.com", "full_name": "Kamlesh K", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:36:15.319896+05:30', '2025-06-30 00:36:15.347371+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'authenticated', 'authenticated', 'kumararjun@gmail.com', '$2a$10$nJ6PAU67HsEKkkb5ZU4WvO0QAOClkjaARAmoaeN74FMUOouzQgOki', '2025-06-30 00:37:33.76342+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:37:33.766503+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "f8adc086-3c84-4038-820d-5e1cf0d63d39", "email": "kumararjun@gmail.com", "full_name": "Arjun Kumar R", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:37:33.751488+05:30', '2025-06-30 00:37:33.768802+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'authenticated', 'authenticated', 'reddyarjun@gmail.com', '$2a$10$LisWRr3JLgRkxYXvC5qgw.NPuJXkbL5ud3ZgfE4dsU/ddLd0J3dZ.', '2025-06-30 00:36:46.980571+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:36:46.984526+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "399e5ea7-4664-4c3c-81d3-b983814d106a", "email": "reddyarjun@gmail.com", "full_name": "Arjun Reddy", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:36:46.97044+05:30', '2025-06-30 00:36:46.987041+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'authenticated', 'authenticated', 'jignesh.vision.17@gmail.com', '$2a$10$mkPkqFzIm0hrjKx3sbQCu.UO8jBEDLu4XGs5/hS6yuTwJIJXf.YzO', '2025-06-29 19:45:05.126854+05:30', NULL, '', '2025-06-29 19:44:42.069282+05:30', '6c014070479329cb5cb412972867dc8e8a5d36711c01c591500d3bea', '2025-06-29 22:30:03.479337+05:30', '', '', NULL, '2025-07-02 23:05:22.538687+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "306f8931-2603-4c86-b3ab-f804c2c5be57", "email": "jignesh.vision.17@gmail.com", "full_name": "jignesh", "email_verified": true, "phone_verified": false}', NULL, '2025-06-29 19:44:42.054603+05:30', '2025-07-02 23:05:22.545542+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'authenticated', 'authenticated', 'reddyvishal@gmail.com', '$2a$10$x6ltnoR7uKjbl.3wjgVkpuQtTYo/gmRHorz7qxU4dI3K5Fr5BcP0K', '2025-06-30 00:40:52.295796+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:40:52.299516+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "68e5b8aa-c6b8-4e2d-a303-a1c10717837b", "email": "reddyvishal@gmail.com", "full_name": "Vishal Reddy", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:40:52.290356+05:30', '2025-06-30 00:40:52.30102+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '702dc5d1-9186-4350-b20f-d3007319a327', 'authenticated', 'authenticated', 'singhbhasker@gmail.com', '$2a$10$tYyUax90OKIK20cfWU/qZO7vtSFsPTbmv/P7QX.4cFegVZKhW0BFW', '2025-06-30 00:44:07.090312+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 00:44:07.093961+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "702dc5d1-9186-4350-b20f-d3007319a327", "email": "singhbhasker@gmail.com", "full_name": "Bhasker Singh", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:44:07.082799+05:30', '2025-06-30 00:44:07.096198+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'authenticated', 'authenticated', 'aakashkumar@gmail.com', '$2a$10$HW/gFLhjF31xLtq24/rFiekMWphEFssdvxcKSVYFmrdIjgMl8kC6O', '2025-06-30 00:41:53.901547+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-30 09:10:52.549943+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "719c5acf-8f3e-4064-ac1a-00c3692901ba", "email": "aakashkumar@gmail.com", "full_name": "Aakash Kumar", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:41:53.892864+05:30', '2025-06-30 09:10:52.556429+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '1319be79-c9ec-450f-8115-4445c9da6d98', 'authenticated', 'authenticated', 'priyakumari@gmail.com', '$2a$10$hiPgKPsfQIm.MQTXR0pyYuIv2wVEXKGT45BlS/V1Dt7Hg01iZO0zG', '2025-06-30 00:38:02.263492+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 14:57:45.152529+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "1319be79-c9ec-450f-8115-4445c9da6d98", "email": "priyakumari@gmail.com", "full_name": "Priya Kumari", "email_verified": true, "phone_verified": false}', NULL, '2025-06-30 00:38:02.258432+05:30', '2025-07-04 17:25:14.493028+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', 'authenticated', 'authenticated', 'admin@focus.com', '$2a$10$uvGWs2Neq1qnLCgEd.HD3ujORnmzQ.OUHy6esdJteGboD.c8mwTcC', '2025-06-29 19:22:07.128156+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 14:52:06.892364+05:30', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-29 19:22:07.107025+05:30', '2025-07-04 14:52:06.895009+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', 'authenticated', 'authenticated', 'google@gmail.com', '$2a$10$ZZDl6OSQ4KY2Aw3qalhnjuMQdNJtylQpUaSUZNguN3BRZIxEdErSe', '2025-07-02 01:17:23.383397+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 15:01:01.743348+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "d84fecf1-b3de-4a54-a2f3-2fd69740d572", "email": "google@gmail.com", "full_name": "google", "member_type": "student", "email_verified": true, "phone_verified": false}', NULL, '2025-07-02 01:17:23.36005+05:30', '2025-07-04 15:01:01.748877+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'authenticated', 'authenticated', 'anjalikulkarni2424@gmail.com', '$2a$10$qEyktmxZml0iem11T2zYJuN4eo5nNZYEnwxkzpHVe1R1f.tOUAsO6', '2025-07-04 12:25:16.878681+05:30', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 15:19:42.79575+05:30', '{"provider": "email", "providers": ["email"]}', '{"sub": "2ce68cde-0d58-4a03-9e4c-5e5e041eae03", "email": "anjalikulkarni2424@gmail.com", "full_name": "Anjali Kulkarni", "member_type": "student", "email_verified": true, "phone_verified": false}', NULL, '2025-07-04 12:25:16.809465+05:30', '2025-07-04 17:17:44.733356+05:30', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- TOC entry 4519 (class 0 OID 24191)
-- Dependencies: 400
-- Data for Name: answer_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.answer_comments (id, answer_id, user_id, comment, created_at, parent_comment_id) VALUES ('d02105b0-fd61-4164-8803-4c751124af40', '96e7f650-c87d-410a-b465-6c8f954765dd', '1319be79-c9ec-450f-8115-4445c9da6d98', 'asdasd', '2025-07-03 01:39:13.562419+05:30', NULL);


--
-- TOC entry 4518 (class 0 OID 24172)
-- Dependencies: 399
-- Data for Name: answer_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.answer_votes (id, answer_id, user_id, vote_type, created_at) VALUES ('c5ace58f-e175-4134-8e43-8f5ee1df902d', '68e724f8-ac46-479c-a451-8768ca2a28ad', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-03 02:15:52.232923+05:30');
INSERT INTO public.answer_votes (id, answer_id, user_id, vote_type, created_at) VALUES ('83e5543a-e751-46c0-ba5a-1a69587439af', '96e7f650-c87d-410a-b465-6c8f954765dd', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-03 02:15:58.834927+05:30');
INSERT INTO public.answer_votes (id, answer_id, user_id, vote_type, created_at) VALUES ('00ad7a61-0853-4966-9c81-67954388f2b0', '980f18a3-4029-4c62-aa2b-48db70e8cb0e', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-03 02:16:06.522708+05:30');
INSERT INTO public.answer_votes (id, answer_id, user_id, vote_type, created_at) VALUES ('d79fe2b0-704b-4207-a618-9c1dbc4c9815', '2c9574b1-c2af-4be2-9ea8-ba4711b79497', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-03 02:42:40.674882+05:30');
INSERT INTO public.answer_votes (id, answer_id, user_id, vote_type, created_at) VALUES ('5fa965fb-4b45-450f-a495-3764c6fed8ba', 'bf77ebea-2c31-4085-8144-45848c1ce11d', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-03 02:44:00.121633+05:30');
INSERT INTO public.answer_votes (id, answer_id, user_id, vote_type, created_at) VALUES ('f70cae70-f5d2-4463-8f03-71080f988820', '9efccb6a-2f66-464c-9463-59617e4f677e', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-03 02:44:03.37988+05:30');


--
-- TOC entry 4526 (class 0 OID 24363)
-- Dependencies: 407
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4504 (class 0 OID 17394)
-- Dependencies: 385
-- Data for Name: chat_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('120b4fbb-54cd-4908-ad3f-6580a7e0b28a', 'd19f9d2f-0c27-4070-98ee-1a54475e2974', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 05:45:20.596153+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('56277bf1-9dac-411c-b459-cae50200bf81', 'd19f9d2f-0c27-4070-98ee-1a54475e2974', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 05:45:20.59885+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('512420ed-7269-43b8-82fc-7bb857e8cfff', 'd19f9d2f-0c27-4070-98ee-1a54475e2974', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 05:45:20.600913+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('5aa6942f-e6b8-408c-88a9-4631fff66275', '55d66a9c-5c63-45ce-acb9-bb0cad63f839', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 06:08:26.549919+05:30', true, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('f0a0a9ee-48bc-4435-b917-644ac86235d5', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 06:15:22.160755+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('b3b7c68a-826d-4b23-adc0-99f236bdbd10', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 06:15:22.165144+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('d8ed6a65-9b15-4737-9841-5a4cc041a9d6', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:11:06.085028+05:30', true, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('e4c226c8-aa71-46a6-90ef-95d54fc4dd36', '2bd3ced1-d6b2-464a-9425-51e9cc8456d5', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 10:11:00.931388+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('f2ada185-e1ff-466e-849f-5006ee98af81', 'c55bcaf0-5672-4564-a30c-f42debfafbfb', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '2025-07-02 01:25:09.435404+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('b5ac701a-8552-4f0f-adb6-10796d3552ea', 'c55bcaf0-5672-4564-a30c-f42debfafbfb', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-07-02 01:25:09.514316+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('4117b31f-70c5-413b-8370-bb912a57982c', '487eecf6-1203-4cb6-94a1-c512b58e3bc1', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '2025-07-02 01:25:43.434869+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('b4334cd5-3d3e-473e-97a5-ea8c64a56610', 'fb6c142f-39fd-4435-b0e6-737038e2f361', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', '2025-07-04 15:28:53.990732+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('552b9c8a-9037-441f-b445-7204f59ee641', 'fb6c142f-39fd-4435-b0e6-737038e2f361', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-04 15:28:54.315882+05:30', false, false);
INSERT INTO public.chat_members (id, chat_id, user_id, joined_at, is_admin, typing) VALUES ('ddef6945-af93-4f5a-b896-6342a8975a0c', '7d2f68f5-3774-44c4-ae1a-c670d2feec06', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 05:44:44.597505+05:30', false, false);


--
-- TOC entry 4505 (class 0 OID 17415)
-- Dependencies: 386
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chat_messages (id, chat_id, user_id, content, media_url, created_at) VALUES ('0d0e2f35-c9e2-4b41-ac94-d32302a0cbac', 'fb6c142f-39fd-4435-b0e6-737038e2f361', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'hii', NULL, '2025-07-04 15:29:05.332031+05:30');


--
-- TOC entry 4503 (class 0 OID 17384)
-- Dependencies: 384
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('7d2f68f5-3774-44c4-ae1a-c670d2feec06', false, NULL, '2025-06-30 05:44:44.443967+05:30', NULL);
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('d19f9d2f-0c27-4070-98ee-1a54475e2974', true, 'work', '2025-06-30 05:45:20.466066+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('55d66a9c-5c63-45ce-acb9-bb0cad63f839', true, 'work2', '2025-06-30 06:08:26.485131+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('2bd3ced1-d6b2-464a-9425-51e9cc8456d5', true, 'TechStaff_GroundFloor@VITC', '2025-06-30 06:15:21.985507+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('c55bcaf0-5672-4564-a30c-f42debfafbfb', false, NULL, '2025-07-02 01:25:09.309574+05:30', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('487eecf6-1203-4cb6-94a1-c512b58e3bc1', false, NULL, '2025-07-02 01:25:43.283612+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('4f5c18a1-6602-4508-8dbd-24dadff1dc29', false, NULL, '2025-07-04 15:21:33.636067+05:30', '1319be79-c9ec-450f-8115-4445c9da6d98');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('bb5287e4-a6da-45d0-b126-ffa45d12aeee', false, NULL, '2025-07-04 15:23:44.639696+05:30', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('85651690-b1d5-4160-874b-a1a40795ed93', false, NULL, '2025-07-04 15:25:06.011489+05:30', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03');
INSERT INTO public.chats (id, is_group, name, created_at, created_by) VALUES ('fb6c142f-39fd-4435-b0e6-737038e2f361', false, NULL, '2025-07-04 15:28:53.794402+05:30', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03');


--
-- TOC entry 4513 (class 0 OID 17914)
-- Dependencies: 394
-- Data for Name: comment_likes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4512 (class 0 OID 17846)
-- Dependencies: 393
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4516 (class 0 OID 22168)
-- Dependencies: 397
-- Data for Name: content_flags; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4506 (class 0 OID 17435)
-- Dependencies: 387
-- Data for Name: filemodels; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.filemodels (id, user_id, file_url, file_name, file_type, file_size, description, is_public, created_at) VALUES ('61daaecf-34d9-4c59-87ae-5a6d0c8f7db2', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252460776.pdf', 'az.pdf', 'application/pdf', 945553, 'asdasd', true, '2025-06-30 08:31:02.00573+05:30');
INSERT INTO public.filemodels (id, user_id, file_url, file_name, file_type, file_size, description, is_public, created_at) VALUES ('4e8d5633-da07-4291-8e1a-ad44ff6f0836', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252484064.txt', 'DBMS SQL DDL Contraints.txt', 'text/plain', 76, 'DBMS SQL DDL Contraints', true, '2025-06-30 08:31:24.419018+05:30');
INSERT INTO public.filemodels (id, user_id, file_url, file_name, file_type, file_size, description, is_public, created_at) VALUES ('a9dbd540-f5ba-4fd5-828a-dfd18a18afa7', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252498375.pdf', 'Create a database.pdf', 'application/pdf', 116784, 'Create a database', true, '2025-06-30 08:31:38.819265+05:30');
INSERT INTO public.filemodels (id, user_id, file_url, file_name, file_type, file_size, description, is_public, created_at) VALUES ('1bfdf310-5ce7-4fa4-9698-bbc46c879509', '1319be79-c9ec-450f-8115-4445c9da6d98', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/1319be79-c9ec-450f-8115-4445c9da6d98/1751252668699.docx', 'AK IOT 3.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 464832, 'dfsdafsf', true, '2025-06-30 08:34:30.033609+05:30');
INSERT INTO public.filemodels (id, user_id, file_url, file_name, file_type, file_size, description, is_public, created_at) VALUES ('f103e8a2-9fcb-455e-aa10-9133a3af5950', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/306f8931-2603-4c86-b3ab-f804c2c5be57/1751259604290.ppt', 'CASE Tools.ppt', 'application/vnd.ms-powerpoint', 655360, 'CASE Tools', true, '2025-06-30 10:30:05.199775+05:30');


--
-- TOC entry 4501 (class 0 OID 17347)
-- Dependencies: 382
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('8371a8ce-3405-4538-b79e-9cea4080af6e', '1319be79-c9ec-450f-8115-4445c9da6d98', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9eed9d75-d031-4f90-a692-854ffa977d3b', '1319be79-c9ec-450f-8115-4445c9da6d98', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('e053476b-504b-4590-8d58-2b51e9903440', '1319be79-c9ec-450f-8115-4445c9da6d98', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('0cee35ff-f1bf-4ec4-b7ae-dce920389945', '1319be79-c9ec-450f-8115-4445c9da6d98', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('1f77df72-cfcf-4768-b763-250bee3c2274', '1319be79-c9ec-450f-8115-4445c9da6d98', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('8ce73765-2ca2-480d-a430-54023977a7c9', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('106f4a25-8d71-4bea-8f31-f0d23c8b8d19', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9428b57e-f1de-42bc-a6ff-caccc4da58db', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('153d4d78-be61-4554-a0c7-f03f3d4e6f80', '399e5ea7-4664-4c3c-81d3-b983814d106a', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('17238e17-7005-4d78-abb7-7ff797e66805', '399e5ea7-4664-4c3c-81d3-b983814d106a', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('8061f833-ba3c-45db-91ea-daf9d298b5af', '399e5ea7-4664-4c3c-81d3-b983814d106a', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('d7da94de-826d-48b0-b23b-3d77b0c2cf46', '399e5ea7-4664-4c3c-81d3-b983814d106a', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('7856dbf8-0991-4154-9e33-67a8e6b03548', '399e5ea7-4664-4c3c-81d3-b983814d106a', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('4e136e2b-58f6-49cb-bc10-3b32ff9763d9', '399e5ea7-4664-4c3c-81d3-b983814d106a', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9d6e9c35-d523-407e-bfe2-666b02e21460', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('d37c1440-9adb-4396-b0b1-d5fbb75dc597', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('124972d7-6566-49c6-a8e0-88c140e1d17f', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('72a76e7d-1474-44cd-a991-10ced5193fda', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('31e0f20c-f418-4a2e-a13a-140fc73a5f65', '67f2070a-0399-485a-a8e1-e73241df52c0', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('18fddb1d-1d0b-408f-9964-9bb21f3e7fde', '67f2070a-0399-485a-a8e1-e73241df52c0', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('f20c08c6-430d-4b6b-b691-0d1d0914976c', '67f2070a-0399-485a-a8e1-e73241df52c0', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('297c2889-d0fc-466f-9bc2-1856fc1a01be', '67f2070a-0399-485a-a8e1-e73241df52c0', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('e29e51c6-9f0b-4c8b-93d5-f1269a711457', '67f2070a-0399-485a-a8e1-e73241df52c0', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('321e089c-0d82-48ca-812d-44e2f6e76537', '67f2070a-0399-485a-a8e1-e73241df52c0', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9e7cfde9-5d97-403c-bf90-031e5c0e906b', '67f2070a-0399-485a-a8e1-e73241df52c0', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('f7b2b928-f14d-4e95-a2b2-96f54cb1be15', '67f2070a-0399-485a-a8e1-e73241df52c0', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('b53e2943-51e9-4f47-a091-4fba7321f641', '67f2070a-0399-485a-a8e1-e73241df52c0', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('dc2b3fe1-bddf-4635-a4d6-9499bcf52bba', '67f2070a-0399-485a-a8e1-e73241df52c0', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('e6bb8472-9347-47e4-9e22-9ffadde5e10a', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('895bc379-a4de-48f5-9b81-c6195e0a0c37', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('3bef4bcc-4414-41b6-9bb0-55c66e42c6d1', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('3555f956-0975-4fa6-b123-b49a420e2d6f', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('0e29045e-475c-4771-9a52-e6acade02bc4', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('3ec586a9-edab-4e7e-b1e5-a2ceea07bab0', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('439af572-22f8-4e94-854c-cea65cdd4873', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('2d6fdd5d-f159-40e4-bda7-792d390d38fe', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('2a8a128b-646d-444f-8cd4-9932f1ffc7e7', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('4a8194d7-a7fc-4ec8-bfcd-6201f94ed0f9', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9e985328-ed10-4639-b681-5871205bdf90', '702dc5d1-9186-4350-b20f-d3007319a327', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('d4244ae4-a957-4039-8517-47bdafebc2ec', '702dc5d1-9186-4350-b20f-d3007319a327', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('4a020208-079c-46c6-8b70-0e304bcab622', '702dc5d1-9186-4350-b20f-d3007319a327', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('e7cc02cd-82dc-47de-9ec5-46297d90f505', '702dc5d1-9186-4350-b20f-d3007319a327', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9d894f3e-02ee-49e5-aaf2-7088050ec653', '702dc5d1-9186-4350-b20f-d3007319a327', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('55b970bf-e408-472f-83b4-fff20faa11d5', '702dc5d1-9186-4350-b20f-d3007319a327', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('fec4e7ef-7e1e-49a3-a2ff-fc6f1fac2ca9', '702dc5d1-9186-4350-b20f-d3007319a327', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('dab2cb8b-b3f8-4492-8058-b4265b9448cc', '702dc5d1-9186-4350-b20f-d3007319a327', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('cfc48909-62eb-45ef-8f17-812082a1808a', '702dc5d1-9186-4350-b20f-d3007319a327', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('f0862eb8-4214-4941-8d7c-ea94250aae45', '702dc5d1-9186-4350-b20f-d3007319a327', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9cacb87a-a666-425f-aa46-924322030767', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('139ef4bb-86b9-49ad-947b-9c4d21e04f40', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('cd740a11-1cbc-4b7c-91b1-b6de3219c0d2', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('653b80e9-85df-4321-9975-346455183d5f', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('60209b0c-4479-4d69-82c3-2baa38382888', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('88cf58f4-717a-453b-b956-09cbbc400da0', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('353ede2a-af03-4598-b305-1184a7854b87', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('d7b9830a-5add-4df1-b936-82eb5a14eafe', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('d7b1215d-cc52-4cfd-9050-1162dd17ae1d', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('df61cf23-9edf-46d7-a274-893684251df3', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('780abb7f-b8ff-4ed4-bcb2-9bc9d4370128', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('12a7ac61-79e8-44b5-9f2e-bbc08f9aca2b', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('1a380a74-19db-4a3d-90f9-ff195a34a1ac', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('13454605-9f27-43b5-bae2-596eb3bf5e0c', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('ba9458c0-5b61-4fb1-aced-c7f52666f761', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('b75d5b89-8d7c-4f22-908b-3cc3dbcfd699', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('31e52b53-558d-433f-a4bb-593b8f76a118', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('0b68c11b-81f5-48a5-9ccb-5e3f4f26c533', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('455a0092-9b63-4e1c-a313-7cb6d7bea6d1', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('737a2436-8fb4-4038-92a3-7a2005e8f546', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('2ab0c6f5-84ab-49a1-bfb6-236f33afc436', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('31d71b3b-ca7b-4ae1-97fe-f85adff609b9', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('ea7cbaa8-89e6-4c44-9ff1-724bcdef4239', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('d57d6a11-fb67-4f76-a010-90daea7b3972', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('d60aa3f1-c044-45b6-a272-900c8cb230bf', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('0490daed-120d-4d2e-829e-428d6e79bfb0', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('5c64eebc-47c8-4f40-81b2-89e605ace49a', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('b8998be2-866a-457c-beea-5063be136b03', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('4d64a140-0cb3-4b38-a18a-c8bdb8a94aaf', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('60cc1e2f-473f-4b52-840a-88b1c60bde24', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('50e9e417-7636-4230-aeba-faad2d62368f', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('ee93f4f6-568b-41ee-a097-67296c25ccf5', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('3dc61361-edd0-476d-94ab-90421e5b6f1a', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('70904f01-868b-44ed-98f6-bd04f4da52a7', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('451e0e20-3aca-463f-8b4e-383c529b9f06', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('c974b3af-4bac-445f-8d55-4bfe2b2e4c2a', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('9e51048c-16aa-4ba3-a9ca-64f54402c6ec', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('3413d077-ea8e-49ab-b074-bfc1cb00e77f', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('ebbc2f4f-1594-4106-a3f5-12284285f120', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('4afb36ea-a85b-4f8e-bbd9-3cb6ac6308a2', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('e25eca08-b918-4c66-9d65-35506d2572d5', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('70a1730f-750a-425a-b0d6-810c28923dea', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('680045c8-2a0d-4d29-832c-c1dd16f26dcb', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '399e5ea7-4664-4c3c-81d3-b983814d106a', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('f4e9a423-7753-4ef7-b900-d50a357afe2f', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('71d357ef-0f82-411b-89aa-165b984c59b1', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('e2f81776-b8a4-41d5-8299-8a8a1b6acb1a', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('91119b3b-bb9c-4a95-bcf0-427ab0ac0e0f', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('32970953-9063-42b6-9930-026cb3802285', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('75d3f443-85d7-4b5a-ab54-f4e158b332fb', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'e657b686-9443-4cc9-800b-bc7fa4985e35', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('5e01518d-6b07-4fdc-bd26-ecd584836c43', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', '2025-06-30 02:05:47.464329+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('213bc267-4323-4886-a401-1caacb9c6b5b', '1319be79-c9ec-450f-8115-4445c9da6d98', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-07-01 23:22:43.111856+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('514e2089-3e48-4499-86c1-27a96b830139', '1319be79-c9ec-450f-8115-4445c9da6d98', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', '2025-07-01 23:22:43.5834+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('ec172930-451a-4ea6-9f03-9ad4e2b03234', '1319be79-c9ec-450f-8115-4445c9da6d98', '702dc5d1-9186-4350-b20f-d3007319a327', '2025-07-01 23:22:44.471708+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('abc74dc9-af45-4b70-9032-698202bce898', '1319be79-c9ec-450f-8115-4445c9da6d98', '719c5acf-8f3e-4064-ac1a-00c3692901ba', '2025-07-01 23:22:45.129719+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('c1c3b562-76ce-4420-b724-5995ef7da981', '1319be79-c9ec-450f-8115-4445c9da6d98', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-07-01 23:23:04.704468+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('6c3de5fa-5b6e-4a40-ae15-7031c420702f', '306f8931-2603-4c86-b3ab-f804c2c5be57', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-01 23:26:03.259679+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('499d2291-446a-4907-aabe-343b1db7b3f1', '306f8931-2603-4c86-b3ab-f804c2c5be57', '67f2070a-0399-485a-a8e1-e73241df52c0', '2025-07-01 23:26:31.249073+05:30');
INSERT INTO public.followers (id, follower_id, following_id, created_at) VALUES ('858edcec-731e-45ef-a5e0-901a9263deca', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-03 00:23:58.541521+05:30');


--
-- TOC entry 4500 (class 0 OID 17327)
-- Dependencies: 381
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('4be967ab-4a2b-4055-9e82-3a48d3402c4f', '1319be79-c9ec-450f-8115-4445c9da6d98', '14ce1fb1-fd66-4473-9366-ac0994abcf25', '2025-06-30 22:47:45.019984+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('4b649aff-1f3c-48f2-9fde-93d7e301e50b', '1319be79-c9ec-450f-8115-4445c9da6d98', '50371b8d-1d49-4b79-80e5-91920a23e0d4', '2025-07-01 00:19:14.894357+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('9aa0e028-c46b-44c6-8470-9cfdd0e37dad', '1319be79-c9ec-450f-8115-4445c9da6d98', '2acac702-6d1b-4d64-b79c-400d4021ec6c', '2025-06-30 03:43:53.517584+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('a8d84cdf-fb68-4d61-9b08-a8620be9be2b', '306f8931-2603-4c86-b3ab-f804c2c5be57', '50371b8d-1d49-4b79-80e5-91920a23e0d4', '2025-07-01 21:46:04.56946+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('2a63e58b-e30c-4130-8c16-88e11e31e8a5', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2acac702-6d1b-4d64-b79c-400d4021ec6c', '2025-07-01 21:46:05.331157+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('245f13d4-4234-4833-ad3d-c29501693557', '306f8931-2603-4c86-b3ab-f804c2c5be57', '14ce1fb1-fd66-4473-9366-ac0994abcf25', '2025-07-01 21:46:09.375807+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('b3700cce-3ad8-42ac-bf24-76181838ee7d', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'aed30794-04f4-46ac-b5f6-b342d60feaf4', '2025-07-01 21:46:10.95814+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('121a2fad-0cb5-4e5c-b760-821b429ebb1b', '306f8931-2603-4c86-b3ab-f804c2c5be57', '49e51a7d-318c-4bfc-a249-9c0cfd2c0fb9', '2025-07-01 21:46:13.024465+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('eafebaf2-9796-481e-8769-66dadde3a0e1', '306f8931-2603-4c86-b3ab-f804c2c5be57', '203f1d5b-e06a-4c72-94ee-419452f23725', '2025-07-01 21:46:13.816159+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('5ce9c942-bc42-43e3-8d36-6ec6cdb49e28', '306f8931-2603-4c86-b3ab-f804c2c5be57', '254b0553-6242-4bec-bbbc-2c9bd6bae32e', '2025-07-01 21:52:43.862722+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('4d769fd0-fc91-469d-9813-ea3fd406d567', '306f8931-2603-4c86-b3ab-f804c2c5be57', '0a5028ff-3a17-4652-bf79-607019de68c6', '2025-07-01 21:52:47.472582+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('0b4c96f6-9cba-484f-acc5-d4b19ba8057c', '1319be79-c9ec-450f-8115-4445c9da6d98', '90c17148-db32-4238-a47b-73fae751be6b', '2025-07-03 16:20:06.689023+05:30');
INSERT INTO public.likes (id, user_id, post_id, created_at) VALUES ('993b48d2-afdb-4f1e-8aae-1016425834d1', '1319be79-c9ec-450f-8115-4445c9da6d98', '254b0553-6242-4bec-bbbc-2c9bd6bae32e', '2025-07-03 16:20:44.215108+05:30');


--
-- TOC entry 4502 (class 0 OID 17368)
-- Dependencies: 383
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4499 (class 0 OID 17310)
-- Dependencies: 380
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('0a5028ff-3a17-4652-bf79-607019de68c6', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Just completed a React Native project! The mobile app development journey has been incredible. Learning about cross-platform development and the challenges of maintaining consistent UI across iOS and Android. #ReactNative #MobileDev #CrossPlatform', NULL, '2025-01-15 16:00:00+05:30', '2025-01-15 16:00:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('92443502-0848-4155-a43d-ffe71d450077', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'Working on a full-stack application using Next.js 14 and Supabase. The new App Router and Server Components are game-changers! The developer experience is unmatched. #NextJS #Supabase #FullStack', NULL, '2025-01-12 14:45:00+05:30', '2025-01-12 14:45:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('254b0553-6242-4bec-bbbc-2c9bd6bae32e', '1319be79-c9ec-450f-8115-4445c9da6d98', 'Attended an amazing workshop on GraphQL today. The way it simplifies API development and reduces over-fetching is mind-blowing. Excited to implement it in my next project! #GraphQL #API #WebDevelopment', NULL, '2025-01-20 20:15:00+05:30', '2025-06-30 02:53:06.93+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('6318a7cd-cf82-4391-928c-ceb76291d79e', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'Just deployed my first microservices architecture on AWS. The learning curve was steep but the scalability benefits are worth it. Docker + Kubernetes + AWS ECS = powerful combination!                                            #Microservices #AWS #Docker #Kubernetes', NULL, '2025-01-18 21:50:00+05:30', '2025-07-01 22:19:45.184+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('796a742f-4de6-4516-9ed2-4bafd73c316f', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'Started learning TypeScript today. The type safety and better IDE support are incredible! No more runtime errors for simple type mistakes. #TypeScript #JavaScript #Programming', NULL, '2025-01-14 16:30:00+05:30', '2025-01-14 16:30:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('dc87fc67-e35e-4d54-8211-febdc1dde5ea', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'Built a real-time chat application using Socket.io and Node.js. The WebSocket implementation was surprisingly straightforward. Real-time features are so much fun to build! #SocketIO #NodeJS #RealTime #WebSockets', NULL, '2025-01-22 19:00:00+05:30', '2025-01-22 19:00:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('d4bb6709-0e7f-46a0-beb1-b2c7d0b16348', '67f2070a-0399-485a-a8e1-e73241df52c0', 'Exploring machine learning with Python and TensorFlow. The potential of AI in modern applications is fascinating. Working on a recommendation system for my portfolio project. #MachineLearning #Python #TensorFlow #AI', NULL, '2025-01-16 14:15:00+05:30', '2025-01-16 14:15:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('ed589834-74c1-4886-a8c6-ce8512dc13ca', '67f2070a-0399-485a-a8e1-e73241df52c0', 'Just completed a course on DevOps practices. CI/CD pipelines, automated testing, and infrastructure as code are revolutionizing how we deploy software. #DevOps #CICD #Automation #Infrastructure', NULL, '2025-01-21 20:40:00+05:30', '2025-01-21 20:40:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('27f02d85-b03d-4646-934e-3a693a2c988d', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'Working on a blockchain project using Ethereum and Solidity. Smart contracts are powerful but require careful attention to security. Learning about gas optimization and best practices. #Blockchain #Ethereum #Solidity #SmartContracts', NULL, '2025-01-13 18:00:00+05:30', '2025-01-13 18:00:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('01ce53a1-2c33-4179-94c0-94f50fceedcd', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'Just finished building a REST API with Express.js and MongoDB. The combination of Node.js backend with NoSQL database is perfect for rapid prototyping. #ExpressJS #MongoDB #RESTAPI #NodeJS', NULL, '2025-01-19 15:45:00+05:30', '2025-01-19 15:45:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('95ace707-7a91-4ead-8879-ba4991b6a881', '702dc5d1-9186-4350-b20f-d3007319a327', 'Learning about cloud computing with AWS. The scalability and cost-effectiveness of cloud services are amazing. Working on migrating a legacy application to the cloud. #AWS #CloudComputing #Migration #Scalability', NULL, '2025-01-17 19:50:00+05:30', '2025-01-17 19:50:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('203f1d5b-e06a-4c72-94ee-419452f23725', '702dc5d1-9186-4350-b20f-d3007319a327', 'Just implemented OAuth 2.0 authentication in my application. Security is crucial in modern web development. Understanding JWT tokens and secure session management. #OAuth #Security #JWT #Authentication', NULL, '2025-01-23 15:15:00+05:30', '2025-01-23 15:15:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('d29cda23-d4a8-4f06-acf0-fdc736b9040e', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'Working with Vue.js 3 and Composition API. The new reactivity system is much more intuitive than the Options API. Building a dashboard with Vue 3 and Vite. #VueJS #CompositionAPI #Vite #Frontend', NULL, '2025-01-11 21:30:00+05:30', '2025-01-11 21:30:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('49e51a7d-318c-4bfc-a249-9c0cfd2c0fb9', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'Just completed a course on database design and optimization. Understanding indexes, query optimization, and database normalization is crucial for building scalable applications. #Database #SQL #Optimization #Performance', NULL, '2025-01-24 17:00:00+05:30', '2025-01-24 17:00:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('e4b01f9e-7888-4f3f-8647-e527ff6b665c', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'Exploring Flutter for cross-platform mobile development. The hot reload feature and beautiful Material Design components make development so much faster. #Flutter #Dart #MobileDev #CrossPlatform', NULL, '2025-01-10 18:45:00+05:30', '2025-01-10 18:45:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('aed30794-04f4-46ac-b5f6-b342d60feaf4', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'Working on a project using Redis for caching. The performance improvement is incredible! Understanding when and how to use caching effectively is a game-changer. #Redis #Caching #Performance #Backend', NULL, '2025-01-25 21:15:00+05:30', '2025-01-25 21:15:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('58ba5e24-9e20-405c-832c-b21f07b9030e', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'Learning about Progressive Web Apps (PWAs). The ability to work offline and provide native app-like experience is revolutionary. Building my first PWA with service workers. #PWA #ServiceWorkers #Offline #WebApp', NULL, '2025-01-09 16:00:00+05:30', '2025-01-09 16:00:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('14ce1fb1-fd66-4473-9366-ac0994abcf25', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'Just implemented automated testing with Jest and React Testing Library. Writing tests first (TDD) has completely changed my development workflow. Quality code is maintainable code! #Testing #Jest #ReactTestingLibrary #TDD', NULL, '2025-01-26 17:30:00+05:30', '2025-01-26 17:30:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('fc43341d-77f9-4069-a9fe-dbc2bf6cb838', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'Working with Angular 17 and standalone components. The new control flow syntax and improved performance are amazing. Building a large-scale enterprise application. #Angular #StandaloneComponents #Enterprise #Frontend', NULL, '2025-01-08 20:15:00+05:30', '2025-01-08 20:15:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('2acac702-6d1b-4d64-b79c-400d4021ec6c', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'Just completed a course on system design. Understanding scalability, load balancing, and distributed systems is crucial for building robust applications. #SystemDesign #Scalability #Architecture #DistributedSystems', NULL, '2025-01-27 21:50:00+05:30', '2025-01-27 21:50:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('ce198b41-bac6-45c6-b8fd-a07eaf927f53', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'Learning about data visualization with D3.js. Creating interactive charts and graphs for data analysis. The power of SVG and CSS transforms is incredible! #DataVisualization #D3JS #SVG #Analytics', NULL, '2025-01-07 16:50:00+05:30', '2025-01-07 16:50:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('50371b8d-1d49-4b79-80e5-91920a23e0d4', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'Working on a project using WebRTC for real-time video communication. The technology behind video calls and screen sharing is fascinating. Building a simple video chat application. #WebRTC #VideoChat #RealTime #Communication', NULL, '2025-01-28 19:20:00+05:30', '2025-01-28 19:20:00+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('90c17148-db32-4238-a47b-73fae751be6b', '1319be79-c9ec-450f-8115-4445c9da6d98', 'adsadada', NULL, '2025-07-02 23:29:20.684958+05:30', '2025-07-02 23:29:20.684958+05:30', false, NULL, NULL, 'normal');
INSERT INTO public.posts (id, user_id, content, media_url, created_at, updated_at, is_deleted, file_url, image_url, flag_status) VALUES ('6bdcef31-e466-45c5-8fd2-7d3c25d9c275', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', 'jajdsfklasjdfkljaslkfjdasjdjalkdfjalskflkasjfljasdl', NULL, '2025-07-02 11:28:36.546117+05:30', '2025-07-02 11:28:36.546117+05:30', false, NULL, NULL, 'normal');


--
-- TOC entry 4497 (class 0 OID 17281)
-- Dependencies: 378
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('d36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'kkamlesh@gmail.com', 'Kamlesh K', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:36:15.319534+05:30', '2025-06-30 00:36:15.319534+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('f8adc086-3c84-4038-820d-5e1cf0d63d39', 'kumararjun@gmail.com', 'Arjun Kumar R', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:37:33.749964+05:30', '2025-06-30 00:37:33.749964+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'priyankaks@gmail.com', 'Priyanka KS', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:39:16.693123+05:30', '2025-06-30 00:39:16.693123+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('719c5acf-8f3e-4064-ac1a-00c3692901ba', 'aakashkumar@gmail.com', 'Aakash Kumar', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:41:53.892531+05:30', '2025-06-30 00:41:53.892531+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('702dc5d1-9186-4350-b20f-d3007319a327', 'singhbhasker@gmail.com', 'Bhasker Singh', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:44:07.082442+05:30', '2025-06-30 00:44:07.082442+05:30', 'student', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('306f8931-2603-4c86-b3ab-f804c2c5be57', 'jignesh.vision.17@gmail.com', 'Jignesh Ameta', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/avatars/306f8931-2603-4c86-b3ab-f804c2c5be57/1751392704971.jpg', 'Full-stack developer passionate about creating amazing user experiences.', 'San Francisco, CA', 'https://johndoe.dev', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-06-29 19:44:42.054242+05:30', '2025-06-29 19:44:42.054242+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('399e5ea7-4664-4c3c-81d3-b983814d106a', 'reddyarjun@gmail.com', 'Arjun Reddy', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:36:46.970067+05:30', '2025-06-30 00:36:46.970067+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('67f2070a-0399-485a-a8e1-e73241df52c0', 'vishnusingh@gmail.com', 'Vishnu Singh', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:39:56.966044+05:30', '2025-06-30 00:39:56.966044+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'reddyvishal@gmail.com', 'Vishal Reddy', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:40:52.290034+05:30', '2025-06-30 00:40:52.290034+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('e657b686-9443-4cc9-800b-bc7fa4985e35', 'parinita.k@gmail.com', 'Parinita Reddy', NULL, NULL, NULL, NULL, NULL, '2025-06-30 00:45:00.793431+05:30', '2025-06-30 00:45:00.793431+05:30', 'alumni', 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('d2b3a071-141a-4c3a-8a63-53eaefa012c3', 'admin@focus.com', 'Admininitrator', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/avatars/d2b3a071-141a-4c3a-8a63-53eaefa012c3/1751396238085.jpg', 'Administrator for Focus Hub', 'Rajasthan, IN', 'https://johndoe.dev', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-06-29 19:22:07.10465+05:30', '2025-06-29 19:22:07.10465+05:30', NULL, 'active', '2025-07-03 00:28:55.826567+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'anjalikulkarni2424@gmail.com', 'Anjali Kulkarni', NULL, NULL, NULL, NULL, NULL, '2025-07-04 12:25:16.807825+05:30', '2025-07-04 12:25:16.807825+05:30', 'student', 'active', '2025-07-04 15:28:36.336+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('1319be79-c9ec-450f-8115-4445c9da6d98', 'priyakumari@gmail.com', 'Priya Kumari', 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/avatars/1319be79-c9ec-450f-8115-4445c9da6d98/1751314473974.png', 'Full-stack developer passionate about creating amazing user experiences.', 'San Francisco, CA', 'https://johndoe.dev', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-06-30 00:38:02.258108+05:30', '2025-06-30 00:38:02.258108+05:30', 'alumni', 'active', '2025-07-04 16:34:00.98+05:30');
INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, location, website, settings, created_at, updated_at, member_type, status, last_seen) VALUES ('d84fecf1-b3de-4a54-a2f3-2fd69740d572', 'google@gmail.com', 'google', NULL, 'sddsfas', 'asdfadsf', 'sadfsadf', '{"privacy": {"showEmail": false, "showLocation": true, "allowMessages": true, "profilePublic": true}, "notifications": {"push": true, "email": true, "follows": false, "comments": true, "mentions": true, "messages": true}}', '2025-07-02 01:17:23.359724+05:30', '2025-07-02 01:17:23.359724+05:30', 'student', 'active', '2025-07-04 15:01:04.161+05:30');


--
-- TOC entry 4508 (class 0 OID 17468)
-- Dependencies: 389
-- Data for Name: qanotifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4533 (class 0 OID 24429)
-- Dependencies: 414
-- Data for Name: question_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4521 (class 0 OID 24271)
-- Dependencies: 402
-- Data for Name: question_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.question_votes (id, question_id, user_id, vote_type, created_at) VALUES (2, '22f54d50-abb5-455d-b340-712b6bb58a91', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-02 23:21:03.627752+05:30');
INSERT INTO public.question_votes (id, question_id, user_id, vote_type, created_at) VALUES (3, '9e1e7ae9-15f6-41df-a110-fd7b72acfb6b', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-02 23:21:06.275158+05:30');
INSERT INTO public.question_votes (id, question_id, user_id, vote_type, created_at) VALUES (4, '80ede218-2149-4fbe-aa50-bfa93f29f14e', '1319be79-c9ec-450f-8115-4445c9da6d98', 1, '2025-07-04 11:20:51.506784+05:30');


--
-- TOC entry 4507 (class 0 OID 17451)
-- Dependencies: 388
-- Data for Name: questionanswers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('2f0c4c88-8252-4f3a-983b-424785418563', '1319be79-c9ec-450f-8115-4445c9da6d98', 'What is the best way to learn React in 2025?', NULL, '2025-01-10 15:30:00+05:30', '2025-01-10 15:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('093b9db2-5287-4a0e-ae3c-094d5131c856', '1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you optimize SQL queries for large datasets?', NULL, '2025-01-10 15:35:00+05:30', '2025-01-10 15:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('84213ef5-a12e-4afd-821e-531f1d32416a', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'What is the best way to learn React in 2025?', 'Start with the official React docs and build small projects. Use hooks and functional components from the beginning.', '2025-01-10 17:30:00+05:30', '2025-01-10 17:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('a87bf9b9-a3e7-4576-874f-ca958dc4be69', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'What is the best way to learn React in 2025?', 'Join online communities and follow React updates. Practice by contributing to open source.', '2025-01-10 17:40:00+05:30', '2025-01-10 17:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('344cfd14-9fd8-4500-9ef1-a594ce9f8454', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you optimize SQL queries for large datasets?', 'Use proper indexing and avoid SELECT * in production queries.', '2025-01-10 17:50:00+05:30', '2025-01-10 17:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('5541cf89-2325-4bf3-8908-d154d3df2cee', '702dc5d1-9186-4350-b20f-d3007319a327', 'How do you optimize SQL queries for large datasets?', 'Analyze query plans and break down complex queries into smaller parts.', '2025-01-10 18:00:00+05:30', '2025-01-10 18:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('4cd26d30-055a-442c-8d10-f05457909aff', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are the benefits of using TypeScript with Node.js?', NULL, '2025-01-11 14:30:00+05:30', '2025-01-11 14:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('d4ce9805-8ebd-4d5f-ac6a-c51e374f3dd4', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'How do you implement authentication in a React app?', NULL, '2025-01-11 14:35:00+05:30', '2025-01-11 14:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('b3957b90-2839-4c83-a7a2-0fe95f5b5c0a', '1319be79-c9ec-450f-8115-4445c9da6d98', 'What are the benefits of using TypeScript with Node.js?', 'TypeScript provides static typing, which helps catch errors early and improves code maintainability.', '2025-01-11 15:30:00+05:30', '2025-01-11 15:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('f783992e-8129-4100-ac54-ad145a40cad4', '67f2070a-0399-485a-a8e1-e73241df52c0', 'What are the benefits of using TypeScript with Node.js?', 'It enhances IDE support and makes refactoring easier in large codebases.', '2025-01-11 15:40:00+05:30', '2025-01-11 15:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('f37706b1-9bc0-4095-863b-6fac55bcf487', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'How do you implement authentication in a React app?', 'Use libraries like Firebase Auth or Auth0, and manage tokens securely.', '2025-01-11 15:50:00+05:30', '2025-01-11 15:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('1331b28b-0030-4e47-8ce9-715f5d1818f4', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'How do you implement authentication in a React app?', 'Implement context for auth state and use protected routes.', '2025-01-11 16:00:00+05:30', '2025-01-11 16:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('947fda66-d8c6-4d3c-a875-c2cf7071f1bc', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'What is the difference between REST and GraphQL?', NULL, '2025-01-12 13:30:00+05:30', '2025-01-12 13:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('6fbda7c9-44f2-462a-8a86-125b0ebc65ce', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you handle state management in large React apps?', NULL, '2025-01-12 13:35:00+05:30', '2025-01-12 13:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('1230d5ef-c297-4b7d-9e00-7e5a02443242', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is the difference between REST and GraphQL?', 'REST uses multiple endpoints, while GraphQL uses a single endpoint and allows clients to specify exactly what data they need.', '2025-01-12 14:30:00+05:30', '2025-01-12 14:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('f76934ed-4307-4cf2-a268-50379350a24e', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'What is the difference between REST and GraphQL?', 'GraphQL can reduce over-fetching and under-fetching of data compared to REST.', '2025-01-12 14:40:00+05:30', '2025-01-12 14:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('3a893d71-c008-4236-a649-119c2ebf833d', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you handle state management in large React apps?', 'Use libraries like Redux or Zustand, and keep state as local as possible.', '2025-01-12 14:50:00+05:30', '2025-01-12 14:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('896943f8-9be2-4933-a5b6-5e0c5fc1a155', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you handle state management in large React apps?', 'Leverage React Context for global state and custom hooks for logic reuse.', '2025-01-12 15:00:00+05:30', '2025-01-12 15:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('ee4bf478-cce7-4345-ad31-055cf4e29d98', '67f2070a-0399-485a-a8e1-e73241df52c0', 'What are the best practices for deploying machine learning models?', NULL, '2025-01-13 16:30:00+05:30', '2025-01-13 16:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('321a2169-abed-4c79-b03a-75c9d2396911', '67f2070a-0399-485a-a8e1-e73241df52c0', 'How do you ensure data privacy in web applications?', NULL, '2025-01-13 16:35:00+05:30', '2025-01-13 16:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('da79ed4c-c72a-4efb-af16-bfd6532c16b1', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'What are the best practices for deploying machine learning models?', 'Containerize models with Docker and use CI/CD pipelines for deployment.', '2025-01-13 17:30:00+05:30', '2025-01-13 17:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('83ce83c4-ddb2-470c-b350-597cf9e836b9', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are the best practices for deploying machine learning models?', 'Monitor model performance and retrain regularly with new data.', '2025-01-13 17:40:00+05:30', '2025-01-13 17:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('a81dcf32-7e44-48f4-b762-6fc2df9a3c2e', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you ensure data privacy in web applications?', 'Implement HTTPS, encrypt sensitive data, and use secure authentication.', '2025-01-13 17:50:00+05:30', '2025-01-13 17:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('0aeda383-3cc0-4839-bdb4-b5b277fe57e8', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you ensure data privacy in web applications?', 'Follow GDPR guidelines and minimize data collection.', '2025-01-13 18:00:00+05:30', '2025-01-13 18:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('ac009776-088e-4a8d-b84b-a9ec326f76c2', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'What is a smart contract and how does it work?', NULL, '2025-01-14 18:30:00+05:30', '2025-01-14 18:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('9752a81f-115f-4127-809c-62c15fa97957', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you secure a blockchain application?', NULL, '2025-01-14 18:35:00+05:30', '2025-01-14 18:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('fd7fd669-db43-4b8f-a058-2bd41916d0cd', '702dc5d1-9186-4350-b20f-d3007319a327', 'What is a smart contract and how does it work?', 'A smart contract is a self-executing contract with the terms directly written into code on the blockchain.', '2025-01-14 19:30:00+05:30', '2025-01-14 19:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('987313b5-3e49-45e8-b928-b5e8cae8c345', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is a smart contract and how does it work?', 'It runs on the blockchain and executes automatically when conditions are met.', '2025-01-14 19:40:00+05:30', '2025-01-14 19:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('bc0600b8-5268-4ae1-9393-2f0113b753ae', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you secure a blockchain application?', 'Use secure coding practices, audit smart contracts, and keep private keys safe.', '2025-01-14 19:50:00+05:30', '2025-01-14 19:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('da35593f-d50c-4710-852d-fa793ad6a5fb', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you secure a blockchain application?', 'Implement multi-signature wallets and regular security audits.', '2025-01-14 20:00:00+05:30', '2025-01-14 20:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('0b693ae8-6e2b-4cf4-995c-a30e7d0ef00c', '702dc5d1-9186-4350-b20f-d3007319a327', 'What are the advantages of cloud computing?', NULL, '2025-01-15 20:30:00+05:30', '2025-01-15 20:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('aec58f8a-bc2c-4209-8ea1-80299e570e77', '702dc5d1-9186-4350-b20f-d3007319a327', 'How do you migrate a legacy app to the cloud?', NULL, '2025-01-15 20:35:00+05:30', '2025-01-15 20:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('ac309d35-5b97-414c-b14f-f3a607fdeeaa', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'What are the advantages of cloud computing?', 'Scalability, cost-effectiveness, and on-demand resources.', '2025-01-15 21:30:00+05:30', '2025-01-15 21:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('8f7d5f6a-5a2e-4480-bcf7-87ee6841b570', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are the advantages of cloud computing?', 'It allows businesses to focus on core activities instead of infrastructure management.', '2025-01-15 21:40:00+05:30', '2025-01-15 21:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('0ffc13b7-7dd0-475c-b800-b05da3329df8', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you migrate a legacy app to the cloud?', 'Assess dependencies, refactor code, and use cloud-native services.', '2025-01-15 21:50:00+05:30', '2025-01-15 21:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('0cdae601-51e3-47f8-936d-c8350a965f32', '1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you migrate a legacy app to the cloud?', 'Start with a lift-and-shift approach, then optimize for the cloud.', '2025-01-15 22:00:00+05:30', '2025-01-15 22:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('61133dcd-4812-411b-a3dc-390a0a303d04', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is the Composition API in Vue 3?', NULL, '2025-01-16 22:30:00+05:30', '2025-01-16 22:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('080f3ba5-a8a3-4160-9fd7-214aa7b2114a', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'How do you optimize performance in Vue apps?', NULL, '2025-01-16 22:35:00+05:30', '2025-01-16 22:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('7bbcc7bd-fae7-451b-a164-c0675ec9d339', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'What is the Composition API in Vue 3?', 'It allows you to organize code by logical concern, not by lifecycle method.', '2025-01-16 23:30:00+05:30', '2025-01-16 23:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('266f9e3d-2812-4dcb-b99b-e1008c494be2', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'What is the Composition API in Vue 3?', 'It provides better code reuse and TypeScript support.', '2025-01-16 23:40:00+05:30', '2025-01-16 23:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('bfd38e54-9ef1-4e14-92e6-c168e019ff56', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'How do you optimize performance in Vue apps?', 'Use lazy loading, code splitting, and keep component state local.', '2025-01-16 23:50:00+05:30', '2025-01-16 23:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('1637a29d-16ad-4643-b3af-e00ca9cf5613', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'How do you optimize performance in Vue apps?', 'Profile your app and avoid unnecessary re-renders.', '2025-01-17 00:00:00+05:30', '2025-01-17 00:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('d9f3adbb-8d13-4b05-9b4c-1096630123d2', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'What is Redis and why is it used?', NULL, '2025-01-18 00:30:00+05:30', '2025-01-18 00:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('33c3ad7a-2754-4072-8463-42c3a21ca892', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you implement caching in web applications?', NULL, '2025-01-18 00:35:00+05:30', '2025-01-18 00:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('2c9574b1-c2af-4be2-9ea8-ba4711b79497', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'What is Redis and why is it used?', 'Redis is an in-memory data store used for caching and fast data access.', '2025-01-18 01:30:00+05:30', '2025-01-18 01:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('30fda7be-977b-4821-9d4e-f91ae787f86b', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is Redis and why is it used?', 'It supports data structures like strings, hashes, and lists, and is often used for session storage.', '2025-01-18 01:40:00+05:30', '2025-01-18 01:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('88bc92e5-ff67-4f79-82d9-66dd692fb922', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you implement caching in web applications?', 'Use HTTP cache headers and in-memory stores like Redis or Memcached.', '2025-01-18 01:50:00+05:30', '2025-01-18 01:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('af158469-a852-409e-af30-e8613a25a559', '1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you implement caching in web applications?', 'Cache database query results and static assets for faster load times.', '2025-01-18 02:00:00+05:30', '2025-01-18 02:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('de3874ff-95a0-4c3b-a1ba-5068ac6b5476', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'What are Progressive Web Apps (PWAs)?', NULL, '2025-01-19 02:30:00+05:30', '2025-01-19 02:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('8ad271a1-167b-4c9b-86bc-9df7d407c099', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'How do you implement offline support in web apps?', NULL, '2025-01-19 02:35:00+05:30', '2025-01-19 02:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('9afb6326-ee92-43ac-bf24-f347ab14134d', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'What are Progressive Web Apps (PWAs)?', 'PWAs are web apps that use modern web capabilities to deliver an app-like experience.', '2025-01-19 03:30:00+05:30', '2025-01-19 03:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('7b956ea4-2654-4db7-a223-f282f3ab571d', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'What are Progressive Web Apps (PWAs)?', 'They can work offline, be installed on devices, and send push notifications.', '2025-01-19 03:40:00+05:30', '2025-01-19 03:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('e0160fe0-e140-4d4f-9d1a-ac73a9976ac3', '67f2070a-0399-485a-a8e1-e73241df52c0', 'How do you implement offline support in web apps?', 'Use service workers to cache assets and API responses.', '2025-01-19 03:50:00+05:30', '2025-01-19 03:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('dbdbedc2-7671-4a9a-8b65-bfa7dd008143', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'How do you implement offline support in web apps?', 'Store data locally and sync when online.', '2025-01-19 04:00:00+05:30', '2025-01-19 04:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('8b1502e3-5166-46b0-9a10-c4418d3ede0e', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'What is system design and why is it important?', NULL, '2025-01-20 04:30:00+05:30', '2025-01-20 04:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('8d5e33b4-89f5-40bf-9bf5-41cd89a3d672', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'How do you scale a web application?', NULL, '2025-01-20 04:35:00+05:30', '2025-01-20 04:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('3a2dab8c-256a-4e90-81ed-2d1e7feb8df2', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'What is system design and why is it important?', 'System design is the process of defining the architecture and components of a system to meet requirements.', '2025-01-20 05:30:00+05:30', '2025-01-20 05:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('5b69e387-6235-4985-b232-5a2d5670f149', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'What is system design and why is it important?', 'It ensures scalability, reliability, and maintainability of applications.', '2025-01-20 05:40:00+05:30', '2025-01-20 05:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('071bc621-e414-45f9-910b-d48c1fa98fd1', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'How do you scale a web application?', 'Use load balancers, caching, and database sharding.', '2025-01-20 05:50:00+05:30', '2025-01-20 05:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('bd04b766-77d6-47ab-a222-9fe612a08669', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'How do you scale a web application?', 'Deploy across multiple servers and use CDN for static assets.', '2025-01-20 06:00:00+05:30', '2025-01-20 06:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('ffa32e8a-3332-4032-bc72-b8fea7827c18', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'What is data visualization and why is it important?', NULL, '2025-01-20 13:30:00+05:30', '2025-01-20 13:30:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('9e1e7ae9-15f6-41df-a110-fd7b72acfb6b', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'How do you implement real-time features in web apps?', NULL, '2025-01-20 13:35:00+05:30', '2025-01-20 13:35:00+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('bf77ebea-2c31-4085-8144-45848c1ce11d', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'What is data visualization and why is it important?', 'Data visualization helps communicate information clearly and efficiently using charts and graphs.', '2025-01-20 14:30:00+05:30', '2025-01-20 14:30:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('9efccb6a-2f66-464c-9463-59617e4f677e', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'What is data visualization and why is it important?', 'It enables quick insights and better decision-making from data.', '2025-01-20 14:40:00+05:30', '2025-01-20 14:40:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('68e724f8-ac46-479c-a451-8768ca2a28ad', '1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you implement real-time features in web apps?', 'Use WebSockets or libraries like Socket.io for real-time communication.', '2025-01-20 14:50:00+05:30', '2025-01-20 14:50:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('96e7f650-c87d-410a-b465-6c8f954765dd', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'How do you implement real-time features in web apps?', 'Leverage server-sent events or third-party services like Pusher.', '2025-01-20 15:00:00+05:30', '2025-01-20 15:00:00+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('22f54d50-abb5-455d-b340-712b6bb58a91', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', 'asdasdasd', NULL, '2025-07-03 01:14:15.468264+05:30', '2025-07-03 01:14:15.468264+05:30', false);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('980f18a3-4029-4c62-aa2b-48db70e8cb0e', '1319be79-c9ec-450f-8115-4445c9da6d98', 'How do you implement real-time features in web apps?', 'yes we can use those features', '2025-07-03 01:20:49.372408+05:30', '2025-07-03 01:20:49.372408+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('82bfa2cd-e4e0-45e9-b9af-7722e91db040', '1319be79-c9ec-450f-8115-4445c9da6d98', 'asadsasdasdasd', 'adasdasd', '2025-07-03 20:25:36.370499+05:30', '2025-07-03 20:25:36.370499+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('3724dee3-4e2e-489c-bba8-4c40f220e5cb', '1319be79-c9ec-450f-8115-4445c9da6d98', 'asadsasdasdasd', 'asdasd', '2025-07-03 20:25:49.068582+05:30', '2025-07-03 20:25:49.068582+05:30', true);
INSERT INTO public.questionanswers (id, user_id, question, answer, created_at, updated_at, is_answered) VALUES ('80ede218-2149-4fbe-aa50-bfa93f29f14e', '1319be79-c9ec-450f-8115-4445c9da6d98', 'adaasdadas', NULL, '2025-07-04 01:54:43.002685+05:30', '2025-07-04 01:54:43.002685+05:30', false);


--
-- TOC entry 4524 (class 0 OID 24347)
-- Dependencies: 405
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4532 (class 0 OID 24415)
-- Dependencies: 413
-- Data for Name: reputation_events; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4530 (class 0 OID 24403)
-- Dependencies: 411
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4498 (class 0 OID 17295)
-- Dependencies: 379
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('56ee8e8d-288d-4555-8a80-e4b5850081c4', '306f8931-2603-4c86-b3ab-f804c2c5be57', 'user', '2025-06-29 19:44:42.054242+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('86c5aace-2d33-49a4-9829-84216ad78008', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', 'admin', '2025-06-29 19:22:07.10465+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('638ca293-9e5b-4b6d-9182-f7f6d7b99730', 'd36c190e-3790-4f8a-b17d-7d4c1f550cb2', 'user', '2025-06-30 00:36:15.319534+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('12818ef4-1ec3-44a7-8eb2-e54090aac45d', '399e5ea7-4664-4c3c-81d3-b983814d106a', 'user', '2025-06-30 00:36:46.970067+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('261dee2b-af45-4e22-ab06-caf505744980', 'f8adc086-3c84-4038-820d-5e1cf0d63d39', 'user', '2025-06-30 00:37:33.749964+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('9e46a0da-8768-4fb3-8a68-1bec53362b91', '1319be79-c9ec-450f-8115-4445c9da6d98', 'user', '2025-06-30 00:38:02.258108+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('e1efd277-d580-447b-8d95-00db9876dc89', 'ffbfa1b0-84c5-45fe-8f31-2eda223ac751', 'user', '2025-06-30 00:39:16.693123+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('d7077193-c839-48e0-8ef2-dbbae5844535', '67f2070a-0399-485a-a8e1-e73241df52c0', 'user', '2025-06-30 00:39:56.966044+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('bf979a25-18b6-48fd-b642-d1d6e2aad4da', '68e5b8aa-c6b8-4e2d-a303-a1c10717837b', 'user', '2025-06-30 00:40:52.290034+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('409e3f6b-d0b8-4878-b77e-f444b97eb02f', '719c5acf-8f3e-4064-ac1a-00c3692901ba', 'user', '2025-06-30 00:41:53.892531+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('df95470d-e082-45d2-920c-de1274ba0ce6', '702dc5d1-9186-4350-b20f-d3007319a327', 'user', '2025-06-30 00:44:07.082442+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('dc26863e-59c6-4048-bcd7-9820f106a031', 'e657b686-9443-4cc9-800b-bc7fa4985e35', 'user', '2025-06-30 00:45:00.793431+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('7a187625-6788-4077-b5a1-2a5505911f81', 'd84fecf1-b3de-4a54-a2f3-2fd69740d572', 'user', '2025-07-02 01:17:23.359724+05:30');
INSERT INTO public.user_roles (id, user_id, role, created_at) VALUES ('e13f8138-95af-4797-8856-f63d817f49e8', '2ce68cde-0d58-4a03-9e4c-5e5e041eae03', 'user', '2025-07-04 12:25:16.807825+05:30');


--
-- TOC entry 4528 (class 0 OID 24384)
-- Dependencies: 409
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4510 (class 0 OID 17572)
-- Dependencies: 391
-- Data for Name: messages_2025_07_01; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

-- load via partition root realtime.messages



--
-- TOC entry 4511 (class 0 OID 17583)
-- Dependencies: 392
-- Data for Name: messages_2025_07_02; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

-- load via partition root realtime.messages



--
-- TOC entry 4514 (class 0 OID 18590)
-- Dependencies: 395
-- Data for Name: messages_2025_07_03; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

-- load via partition root realtime.messages



--
-- TOC entry 4515 (class 0 OID 22111)
-- Dependencies: 396
-- Data for Name: messages_2025_07_04; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

-- load via partition root realtime.messages



--
-- TOC entry 4517 (class 0 OID 22578)
-- Dependencies: 398
-- Data for Name: messages_2025_07_05; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

-- load via partition root realtime.messages



--
-- TOC entry 4522 (class 0 OID 24310)
-- Dependencies: 403
-- Data for Name: messages_2025_07_06; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

-- load via partition root realtime.messages



--
-- TOC entry 4534 (class 0 OID 25569)
-- Dependencies: 415
-- Data for Name: messages_2025_07_07; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

-- load via partition root realtime.messages



--
-- TOC entry 4491 (class 0 OID 17018)
-- Dependencies: 368
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116024918, '2025-06-29 13:26:48');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116045059, '2025-06-29 13:26:49');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116050929, '2025-06-29 13:26:49');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116051442, '2025-06-29 13:26:50');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116212300, '2025-06-29 13:26:51');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116213355, '2025-06-29 13:26:51');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116213934, '2025-06-29 13:26:52');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211116214523, '2025-06-29 13:26:53');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211122062447, '2025-06-29 13:26:54');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211124070109, '2025-06-29 13:26:54');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211202204204, '2025-06-29 13:26:55');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211202204605, '2025-06-29 13:26:55');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211210212804, '2025-06-29 13:26:57');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20211228014915, '2025-06-29 13:26:58');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220107221237, '2025-06-29 13:26:59');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220228202821, '2025-06-29 13:26:59');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220312004840, '2025-06-29 13:27:00');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220603231003, '2025-06-29 13:27:01');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220603232444, '2025-06-29 13:27:01');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220615214548, '2025-06-29 13:27:02');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220712093339, '2025-06-29 13:27:03');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220908172859, '2025-06-29 13:27:03');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20220916233421, '2025-06-29 13:27:04');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20230119133233, '2025-06-29 13:27:05');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20230128025114, '2025-06-29 13:27:05');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20230128025212, '2025-06-29 13:27:06');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20230227211149, '2025-06-29 13:27:07');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20230228184745, '2025-06-29 13:27:07');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20230308225145, '2025-06-29 13:27:08');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20230328144023, '2025-06-29 13:27:08');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20231018144023, '2025-06-29 13:27:09');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20231204144023, '2025-06-29 13:27:10');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20231204144024, '2025-06-29 13:27:11');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20231204144025, '2025-06-29 13:27:11');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240108234812, '2025-06-29 13:27:12');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240109165339, '2025-06-29 13:27:13');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240227174441, '2025-06-29 13:27:14');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240311171622, '2025-06-29 13:27:15');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240321100241, '2025-06-29 13:27:16');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240401105812, '2025-06-29 13:27:18');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240418121054, '2025-06-29 13:27:18');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240523004032, '2025-06-29 13:27:21');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240618124746, '2025-06-29 13:27:21');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240801235015, '2025-06-29 13:27:22');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240805133720, '2025-06-29 13:27:22');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240827160934, '2025-06-29 13:27:23');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240919163303, '2025-06-29 13:27:24');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20240919163305, '2025-06-29 13:27:25');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241019105805, '2025-06-29 13:27:25');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241030150047, '2025-06-29 13:27:27');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241108114728, '2025-06-29 13:27:28');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241121104152, '2025-06-29 13:27:29');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241130184212, '2025-06-29 13:27:30');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241220035512, '2025-06-29 13:27:30');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241220123912, '2025-06-29 13:27:31');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20241224161212, '2025-06-29 13:27:32');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20250107150512, '2025-06-29 13:27:32');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20250110162412, '2025-06-29 13:27:33');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20250123174212, '2025-06-29 13:27:33');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20250128220012, '2025-06-29 13:27:34');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20250506224012, '2025-06-29 13:27:34');
INSERT INTO realtime.schema_migrations (version, inserted_at) VALUES (20250523164012, '2025-06-29 13:27:35');


--
-- TOC entry 4495 (class 0 OID 17107)
-- Dependencies: 373
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--



--
-- TOC entry 4477 (class 0 OID 16544)
-- Dependencies: 351
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) VALUES ('uploads', 'uploads', NULL, '2025-06-30 08:22:25.466068+05:30', '2025-06-30 08:22:25.466068+05:30', true, false, 52428800, '{image/*,video/*,application/pdf,text/*,application/json,application/javascript,text/javascript,text/css,text/html,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/zip,application/x-rar-compressed,application/x-7z-compressed}', NULL);
INSERT INTO storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) VALUES ('chat_uploads', 'chat_uploads', NULL, '2025-06-30 09:16:37.876924+05:30', '2025-06-30 09:16:37.876924+05:30', true, false, NULL, NULL, NULL);
INSERT INTO storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) VALUES ('post-media', 'post-media', NULL, '2025-06-30 22:22:05.673833+05:30', '2025-06-30 22:22:05.673833+05:30', true, false, 52428800, '{image/*,video/*,application/pdf,text/*,application/json,application/javascript,text/javascript,text/css,text/html,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/zip,application/x-rar-compressed,application/x-7z-compressed}', NULL);
INSERT INTO storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) VALUES ('avatars', 'avatars', NULL, '2025-07-01 01:32:29.261192+05:30', '2025-07-01 01:32:29.261192+05:30', true, false, NULL, NULL, NULL);


--
-- TOC entry 4479 (class 0 OID 16586)
-- Dependencies: 353
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (0, 'create-migrations-table', 'e18db593bcde2aca2a408c4d1100f6abba2195df', '2025-06-29 13:26:46.730469');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (1, 'initialmigration', '6ab16121fbaa08bbd11b712d05f358f9b555d777', '2025-06-29 13:26:46.742292');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (2, 'storage-schema', '5c7968fd083fcea04050c1b7f6253c9771b99011', '2025-06-29 13:26:46.747141');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (3, 'pathtoken-column', '2cb1b0004b817b29d5b0a971af16bafeede4b70d', '2025-06-29 13:26:46.774257');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (4, 'add-migrations-rls', '427c5b63fe1c5937495d9c635c263ee7a5905058', '2025-06-29 13:26:46.787717');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (5, 'add-size-functions', '79e081a1455b63666c1294a440f8ad4b1e6a7f84', '2025-06-29 13:26:46.795942');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (6, 'change-column-name-in-get-size', 'f93f62afdf6613ee5e7e815b30d02dc990201044', '2025-06-29 13:26:46.802919');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (7, 'add-rls-to-buckets', 'e7e7f86adbc51049f341dfe8d30256c1abca17aa', '2025-06-29 13:26:46.808449');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (8, 'add-public-to-buckets', 'fd670db39ed65f9d08b01db09d6202503ca2bab3', '2025-06-29 13:26:46.813473');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (9, 'fix-search-function', '3a0af29f42e35a4d101c259ed955b67e1bee6825', '2025-06-29 13:26:46.819114');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (10, 'search-files-search-function', '68dc14822daad0ffac3746a502234f486182ef6e', '2025-06-29 13:26:46.826331');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (11, 'add-trigger-to-auto-update-updated_at-column', '7425bdb14366d1739fa8a18c83100636d74dcaa2', '2025-06-29 13:26:46.832655');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (12, 'add-automatic-avif-detection-flag', '8e92e1266eb29518b6a4c5313ab8f29dd0d08df9', '2025-06-29 13:26:46.843769');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (13, 'add-bucket-custom-limits', 'cce962054138135cd9a8c4bcd531598684b25e7d', '2025-06-29 13:26:46.849584');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (14, 'use-bytes-for-max-size', '941c41b346f9802b411f06f30e972ad4744dad27', '2025-06-29 13:26:46.859962');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (15, 'add-can-insert-object-function', '934146bc38ead475f4ef4b555c524ee5d66799e5', '2025-06-29 13:26:46.883008');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (16, 'add-version', '76debf38d3fd07dcfc747ca49096457d95b1221b', '2025-06-29 13:26:46.893205');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (17, 'drop-owner-foreign-key', 'f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101', '2025-06-29 13:26:46.904115');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (18, 'add_owner_id_column_deprecate_owner', 'e7a511b379110b08e2f214be852c35414749fe66', '2025-06-29 13:26:46.913055');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (19, 'alter-default-value-objects-id', '02e5e22a78626187e00d173dc45f58fa66a4f043', '2025-06-29 13:26:46.923518');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (20, 'list-objects-with-delimiter', 'cd694ae708e51ba82bf012bba00caf4f3b6393b7', '2025-06-29 13:26:46.928968');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (21, 's3-multipart-uploads', '8c804d4a566c40cd1e4cc5b3725a664a9303657f', '2025-06-29 13:26:46.937133');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (22, 's3-multipart-uploads-big-ints', '9737dc258d2397953c9953d9b86920b8be0cdb73', '2025-06-29 13:26:46.949877');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (23, 'optimize-search-function', '9d7e604cddc4b56a5422dc68c9313f4a1b6f132c', '2025-06-29 13:26:46.961058');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (24, 'operation-function', '8312e37c2bf9e76bbe841aa5fda889206d2bf8aa', '2025-06-29 13:26:46.96613');
INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES (25, 'custom-metadata', 'd974c6057c3db1c1f847afa0e291e6165693b990', '2025-06-29 13:26:46.971765');


--
-- TOC entry 4478 (class 0 OID 16559)
-- Dependencies: 352
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('4d001b65-55c3-4f16-8e81-2b127c23d24d', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252460776.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:31:01.781732+05:30', '2025-06-30 08:31:01.781732+05:30', '2025-06-30 08:31:01.781732+05:30', '{"eTag": "\"3aa7f2d699fc69f02038b6cb2f21f799\"", "size": 945553, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:01:02.000Z", "contentLength": 945553, "httpStatusCode": 200}', '66d5a0b6-d29d-4c28-a13f-2df52f7a05d7', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('a4943c8c-c718-4e7a-9756-1fe9875f2383', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252484064.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:31:24.264709+05:30', '2025-06-30 08:31:24.264709+05:30', '2025-06-30 08:31:24.264709+05:30', '{"eTag": "\"7afac1314237726d34a237074da15028\"", "size": 76, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:01:25.000Z", "contentLength": 76, "httpStatusCode": 200}', 'af7238c7-b9ed-4d5b-9b02-fe2b58c8aaf4', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('0defa8d2-7472-4598-9c16-87362437f1fa', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252498375.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:31:38.695604+05:30', '2025-06-30 08:31:38.695604+05:30', '2025-06-30 08:31:38.695604+05:30', '{"eTag": "\"d4adc91f0f080d823dcac2d8cef4096e\"", "size": 116784, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:01:39.000Z", "contentLength": 116784, "httpStatusCode": 200}', '1c6f8b4d-37f5-4a4f-b1cb-a4fa827999c6', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('b57ce865-1a73-4910-b3e0-ae5c6b8ba550', 'uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751252668699.docx', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 08:34:29.776191+05:30', '2025-06-30 08:34:29.776191+05:30', '2025-06-30 08:34:29.776191+05:30', '{"eTag": "\"dbcd92a40298ea9eccbb555d21bb264b\"", "size": 464832, "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:04:30.000Z", "contentLength": 464832, "httpStatusCode": 200}', '90d41818-80e0-4230-81a0-ee4c07e7050f', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('97c63826-33a9-4e1e-a1dc-cdcb5912bd1d', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255260329.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:17:40.506815+05:30', '2025-06-30 09:17:40.506815+05:30', '2025-06-30 09:17:40.506815+05:30', '{"eTag": "\"85f0b391b57d568989f63ec7a7b40ea2\"", "size": 161, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:47:41.000Z", "contentLength": 161, "httpStatusCode": 200}', '8e2b84da-09fd-468a-9d4d-b828c76bbd23', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('f24cd78f-5034-4334-9a94-d95042c5c29a', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255273524.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:17:53.943729+05:30', '2025-06-30 09:17:53.943729+05:30', '2025-06-30 09:17:53.943729+05:30', '{"eTag": "\"d713fa3aa6b2df3805bb057d2e6c9c62\"", "size": 1353, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:47:54.000Z", "contentLength": 1353, "httpStatusCode": 200}', 'bd1cca6b-df26-4c61-ac41-eede5667e74d', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('70118885-ae57-4c38-9933-0942bceb835f', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255585945.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:23:06.112278+05:30', '2025-06-30 09:23:06.112278+05:30', '2025-06-30 09:23:06.112278+05:30', '{"eTag": "\"85f0b391b57d568989f63ec7a7b40ea2\"", "size": 161, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:53:07.000Z", "contentLength": 161, "httpStatusCode": 200}', 'cb6e782f-53cf-4a8b-bf2c-358db79262e4', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('0e951365-9589-4c00-a8e0-7c72f734c0e1', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255607083.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:23:27.549051+05:30', '2025-06-30 09:23:27.549051+05:30', '2025-06-30 09:23:27.549051+05:30', '{"eTag": "\"d4adc91f0f080d823dcac2d8cef4096e\"", "size": 116784, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:53:28.000Z", "contentLength": 116784, "httpStatusCode": 200}', '8ab882e0-2ba1-41e3-ab32-3fc4c58fec7d', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('5b24fe91-f4a8-4362-9eb5-c931bf7fff77', 'chat_uploads', '1319be79-c9ec-450f-8115-4445c9da6d98/1751255725946.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 09:25:26.408893+05:30', '2025-06-30 09:25:26.408893+05:30', '2025-06-30 09:25:26.408893+05:30', '{"eTag": "\"d4adc91f0f080d823dcac2d8cef4096e\"", "size": 116784, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T03:55:27.000Z", "contentLength": 116784, "httpStatusCode": 200}', 'af560ebc-c80b-4439-b53c-b5df3ea5d68e', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('05d7924f-3a6e-4247-a5c1-743f49cacf8f', 'chat_uploads', '306f8931-2603-4c86-b3ab-f804c2c5be57/1751258502805.docx', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 10:11:43.108388+05:30', '2025-06-30 10:11:43.108388+05:30', '2025-06-30 10:11:43.108388+05:30', '{"eTag": "\"4e7bed5ad6c55ff9197f6f532d5ee62d\"", "size": 7812, "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T04:41:44.000Z", "contentLength": 7812, "httpStatusCode": 200}', 'd9539557-60a1-4c68-a99c-e7c9d788d1e2', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('6aafb191-14f0-4b8c-885b-674e4a26f908', 'uploads', '306f8931-2603-4c86-b3ab-f804c2c5be57/1751259604290.ppt', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-06-30 10:30:05.009499+05:30', '2025-06-30 10:30:05.009499+05:30', '2025-06-30 10:30:05.009499+05:30', '{"eTag": "\"2fa78246729c52275dbf9c02d4014b0f\"", "size": 655360, "mimetype": "application/vnd.ms-powerpoint", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T05:00:05.000Z", "contentLength": 655360, "httpStatusCode": 200}', '15c6b870-c161-42ca-a929-5a00747984b4', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('f06affd9-9dce-40dd-8751-8ee15b16a4f5', 'post-media', 'images/1751303080391_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:34:40.629017+05:30', '2025-06-30 22:34:40.629017+05:30', '2025-06-30 22:34:40.629017+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:04:41.000Z", "contentLength": 23556, "httpStatusCode": 200}', 'f2ec08af-4cbc-442a-8429-bc1a9bff3ed7', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('5d2fb771-2110-4f1e-ab99-e45fd4f8a0c4', 'post-media', 'images/1751303159229_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:35:59.392255+05:30', '2025-06-30 22:35:59.392255+05:30', '2025-06-30 22:35:59.392255+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:06:00.000Z", "contentLength": 23556, "httpStatusCode": 200}', '17bcb8af-1c79-4c93-89ac-055318fb1920', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('b63c7531-f218-4c75-926f-2dc4d38849d1', 'post-media', 'images/1751303202437_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:36:42.623354+05:30', '2025-06-30 22:36:42.623354+05:30', '2025-06-30 22:36:42.623354+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:06:43.000Z", "contentLength": 23556, "httpStatusCode": 200}', '92bb1115-a902-4165-b6c3-66b391e01849', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('432d2740-9be2-4b52-891f-38e1d7647d77', 'post-media', 'files/1751303373319_Project Synopsis Focus.txt', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:39:33.479865+05:30', '2025-06-30 22:39:33.479865+05:30', '2025-06-30 22:39:33.479865+05:30', '{"eTag": "\"a564ce3266779c775197d558ce00fadb\"", "size": 2617, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:09:34.000Z", "contentLength": 2617, "httpStatusCode": 200}', '2562b305-0d76-41bf-b3b5-7b497a109e2c', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('d2cbc240-2d6b-4400-9b84-b5c527dc4922', 'post-media', 'images/1751303562868_logo.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:42:43.052077+05:30', '2025-06-30 22:42:43.052077+05:30', '2025-06-30 22:42:43.052077+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:12:43.000Z", "contentLength": 23556, "httpStatusCode": 200}', 'bfff4b69-09fc-442e-a046-81afb4f8105c', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('cccfe837-d054-4e74-9617-9d200d7b4850', 'post-media', 'files/1751303932281_SQL Notes Handwritten.pdf', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-06-30 22:48:56.631173+05:30', '2025-06-30 22:48:56.631173+05:30', '2025-06-30 22:48:56.631173+05:30', '{"eTag": "\"525effffe0814fd3c6be38db81c6496a-4\"", "size": 17309207, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T17:18:57.000Z", "contentLength": 17309207, "httpStatusCode": 200}', '080a66a6-bd27-436b-b71b-f27888477a56', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('66eafe16-ed97-4019-8784-72d3f7ee735d', 'avatars', '1319be79-c9ec-450f-8115-4445c9da6d98/1751314473974.png', '1319be79-c9ec-450f-8115-4445c9da6d98', '2025-07-01 01:44:34.192376+05:30', '2025-07-01 01:44:34.192376+05:30', '2025-07-01 01:44:34.192376+05:30', '{"eTag": "\"7a28141fba155361a4107b68881a9940\"", "size": 23556, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-30T20:14:35.000Z", "contentLength": 23556, "httpStatusCode": 200}', '5d0aa7f8-7cc7-41e7-9038-88b06e350ac5', '1319be79-c9ec-450f-8115-4445c9da6d98', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('b598e5c6-ea4b-4c0e-a76f-fe7638455ade', 'avatars', '306f8931-2603-4c86-b3ab-f804c2c5be57/1751392704971.jpg', '306f8931-2603-4c86-b3ab-f804c2c5be57', '2025-07-01 23:28:25.521113+05:30', '2025-07-01 23:28:25.521113+05:30', '2025-07-01 23:28:25.521113+05:30', '{"eTag": "\"b171370f080c1e7b1cc488b1e84dd867\"", "size": 15473, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-01T17:58:26.000Z", "contentLength": 15473, "httpStatusCode": 200}', 'c99d8563-9629-465b-954e-699a0545f336', '306f8931-2603-4c86-b3ab-f804c2c5be57', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('b5420ed2-c56f-4008-9ae2-17447c3e26e0', 'avatars', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3/1751395218540.jpg', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '2025-07-02 00:10:19.24502+05:30', '2025-07-02 00:10:19.24502+05:30', '2025-07-02 00:10:19.24502+05:30', '{"eTag": "\"82d62aecee2f5a9bef0ee1fd27c00a9e\"", "size": 52890, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-01T18:40:20.000Z", "contentLength": 52890, "httpStatusCode": 200}', '6d08469b-895e-4d9e-b4a5-34ae4c1d75a4', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '{}');
INSERT INTO storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) VALUES ('56a1300c-0efe-42d2-bb8c-3377e555f7c8', 'avatars', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3/1751396238085.jpg', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '2025-07-02 00:27:18.347546+05:30', '2025-07-02 00:27:18.347546+05:30', '2025-07-02 00:27:18.347546+05:30', '{"eTag": "\"82d62aecee2f5a9bef0ee1fd27c00a9e\"", "size": 52890, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-01T18:57:19.000Z", "contentLength": 52890, "httpStatusCode": 200}', '32d2598c-6dac-4778-b873-dd1c6ae5bdaa', 'd2b3a071-141a-4c3a-8a63-53eaefa012c3', '{}');


--
-- TOC entry 4492 (class 0 OID 17037)
-- Dependencies: 369
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- TOC entry 4493 (class 0 OID 17051)
-- Dependencies: 370
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- TOC entry 4496 (class 0 OID 17269)
-- Dependencies: 377
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

INSERT INTO supabase_migrations.schema_migrations (version, statements, name) VALUES ('20250629133651', '{"-- =====================================================
-- COMPLETE FOCUS HUB DATABASE SCHEMA
-- =====================================================

-- USERS: handled by Supabase Auth (auth.users)

-- 1. APP ROLES ENUM
CREATE TYPE public.app_role AS ENUM (''admin'', ''user'')","-- 2. PROFILES (Enhanced version with all fields)
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  location TEXT,
  website TEXT,
  settings JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
)","-- 3. USER ROLES
CREATE TABLE IF NOT EXISTS public.user_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  role app_role NOT NULL DEFAULT ''user'',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (user_id, role)
)","-- 4. POSTS
CREATE TABLE IF NOT EXISTS public.posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  media_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE
)","CREATE INDEX IF NOT EXISTS idx_posts_user_id ON public.posts(user_id)","-- 5. LIKES
CREATE TABLE IF NOT EXISTS public.likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  post_id UUID REFERENCES public.posts(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, post_id)
)","CREATE INDEX IF NOT EXISTS idx_likes_post_id ON public.likes(post_id)","-- 6. FOLLOWERS
CREATE TABLE IF NOT EXISTS public.followers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  follower_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  following_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(follower_id, following_id)
)","CREATE INDEX IF NOT EXISTS idx_followers_follower_id ON public.followers(follower_id)","CREATE INDEX IF NOT EXISTS idx_followers_following_id ON public.followers(following_id)","-- 7. NOTIFICATIONS
CREATE TABLE IF NOT EXISTS public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  data JSONB,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
)","CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON public.notifications(user_id)","-- 8. CHATS
CREATE TABLE IF NOT EXISTS public.chats (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  is_group BOOLEAN NOT NULL DEFAULT FALSE,
  name TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
)","-- 9. CHAT_MEMBERS
CREATE TABLE IF NOT EXISTS public.chat_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_id UUID REFERENCES public.chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(chat_id, user_id)
)","CREATE INDEX IF NOT EXISTS idx_chat_members_chat_id ON public.chat_members(chat_id)","CREATE INDEX IF NOT EXISTS idx_chat_members_user_id ON public.chat_members(user_id)","-- 10. CHAT_MESSAGES
CREATE TABLE IF NOT EXISTS public.chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_id UUID REFERENCES public.chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  content TEXT,
  media_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
)","CREATE INDEX IF NOT EXISTS idx_chat_messages_chat_id ON public.chat_messages(chat_id)","-- 11. FILEMODELS
CREATE TABLE IF NOT EXISTS public.filemodels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  file_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_type TEXT,
  file_size INTEGER,
  description TEXT,
  is_public BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
)","CREATE INDEX IF NOT EXISTS idx_filemodels_user_id ON public.filemodels(user_id)","-- 12. QUESTIONANSWERS
CREATE TABLE IF NOT EXISTS public.questionanswers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  answer TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  is_answered BOOLEAN NOT NULL DEFAULT FALSE
)","CREATE INDEX IF NOT EXISTS idx_questionanswers_user_id ON public.questionanswers(user_id)","-- 13. QANOTIFICATIONS
CREATE TABLE IF NOT EXISTS public.qanotifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  question_id UUID REFERENCES public.questionanswers(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
)","CREATE INDEX IF NOT EXISTS idx_qanotifications_user_id ON public.qanotifications(user_id)","-- =====================================================
-- FUNCTIONS
-- =====================================================

-- Security definer function to check roles
CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role app_role)
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
  )
$$","-- Function to handle new user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = ''''
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data ->> ''full_name''
  );
  
  -- Assign default user role
  INSERT INTO public.user_roles (user_id, role)
  VALUES (new.id, ''user'');
  
  RETURN new;
END;
$$","-- =====================================================
-- TRIGGERS
-- =====================================================

-- Trigger to create profile and role on user signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user()","-- =====================================================
-- ROW LEVEL SECURITY (RLS)
-- =====================================================

-- PROFILES
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view their own profile\" ON public.profiles FOR SELECT USING (auth.uid() = id)","CREATE POLICY \"Users can update their own profile\" ON public.profiles FOR UPDATE USING (auth.uid() = id)","CREATE POLICY \"Users can insert their own profile\" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id)","-- USER ROLES
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view their own roles\" ON public.user_roles FOR SELECT USING (auth.uid() = user_id)","CREATE POLICY \"Admins can view all roles\" ON public.user_roles FOR SELECT USING (public.has_role(auth.uid(), ''admin''))","CREATE POLICY \"Admins can insert roles\" ON public.user_roles FOR INSERT WITH CHECK (public.has_role(auth.uid(), ''admin''))","CREATE POLICY \"Admins can update roles\" ON public.user_roles FOR UPDATE USING (public.has_role(auth.uid(), ''admin''))","-- POSTS
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view posts\" ON public.posts FOR SELECT USING (true)","CREATE POLICY \"Users can insert posts\" ON public.posts FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can update their own posts\" ON public.posts FOR UPDATE USING (auth.uid() = user_id)","CREATE POLICY \"Users can delete their own posts\" ON public.posts FOR DELETE USING (auth.uid() = user_id)","-- LIKES
ALTER TABLE public.likes ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can like posts\" ON public.likes FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can view likes\" ON public.likes FOR SELECT USING (true)","CREATE POLICY \"Users can delete their own likes\" ON public.likes FOR DELETE USING (auth.uid() = user_id)","-- FOLLOWERS
ALTER TABLE public.followers ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can follow/unfollow\" ON public.followers FOR INSERT WITH CHECK (auth.uid() = follower_id)","CREATE POLICY \"Users can view followers\" ON public.followers FOR SELECT USING (true)","CREATE POLICY \"Users can delete their own follows\" ON public.followers FOR DELETE USING (auth.uid() = follower_id)","-- NOTIFICATIONS
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view their notifications\" ON public.notifications FOR SELECT USING (auth.uid() = user_id)","CREATE POLICY \"Users can insert notifications\" ON public.notifications FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can update their notifications\" ON public.notifications FOR UPDATE USING (auth.uid() = user_id)","-- CHATS
ALTER TABLE public.chats ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view chats\" ON public.chats FOR SELECT USING (true)","CREATE POLICY \"Users can insert chats\" ON public.chats FOR INSERT WITH CHECK (true)","-- CHAT_MEMBERS
ALTER TABLE public.chat_members ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view chat members\" ON public.chat_members FOR SELECT USING (true)","CREATE POLICY \"Users can insert chat members\" ON public.chat_members FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can delete themselves from chat\" ON public.chat_members FOR DELETE USING (auth.uid() = user_id)","-- CHAT_MESSAGES
ALTER TABLE public.chat_messages ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view chat messages\" ON public.chat_messages FOR SELECT USING (true)","CREATE POLICY \"Users can insert chat messages\" ON public.chat_messages FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can delete their own messages\" ON public.chat_messages FOR DELETE USING (auth.uid() = user_id)","-- FILEMODELS
ALTER TABLE public.filemodels ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view public files\" ON public.filemodels FOR SELECT USING (is_public OR auth.uid() = user_id)","CREATE POLICY \"Users can insert files\" ON public.filemodels FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can update their own files\" ON public.filemodels FOR UPDATE USING (auth.uid() = user_id)","CREATE POLICY \"Users can delete their own files\" ON public.filemodels FOR DELETE USING (auth.uid() = user_id)","-- QUESTIONANSWERS
ALTER TABLE public.questionanswers ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view questions\" ON public.questionanswers FOR SELECT USING (true)","CREATE POLICY \"Users can insert questions\" ON public.questionanswers FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can update their own questions\" ON public.questionanswers FOR UPDATE USING (auth.uid() = user_id)","CREATE POLICY \"Users can delete their own questions\" ON public.questionanswers FOR DELETE USING (auth.uid() = user_id)","-- QANOTIFICATIONS
ALTER TABLE public.qanotifications ENABLE ROW LEVEL SECURITY","CREATE POLICY \"Users can view their Q&A notifications\" ON public.qanotifications FOR SELECT USING (auth.uid() = user_id)","CREATE POLICY \"Users can insert Q&A notifications\" ON public.qanotifications FOR INSERT WITH CHECK (auth.uid() = user_id)","CREATE POLICY \"Users can update their Q&A notifications\" ON public.qanotifications FOR UPDATE USING (auth.uid() = user_id)"}', 'focus_hub');
INSERT INTO supabase_migrations.schema_migrations (version, statements, name) VALUES ('20250629202043', '{"-- Q&A DATA: 2 questions per user, each answered by 2 other users
-- Each INSERT for a question has answer=NULL, is_answered=FALSE
-- Each answer row has answer=..., is_answered=TRUE

-- Priya Kumari (1319be79-c9ec-450f-8115-4445c9da6d98)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''What is the best way to learn React in 2025?'', NULL, FALSE, ''2025-01-10 10:00:00+00'', ''2025-01-10 10:00:00+00''),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''How do you optimize SQL queries for large datasets?'', NULL, FALSE, ''2025-01-10 10:05:00+00'', ''2025-01-10 10:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''What is the best way to learn React in 2025?'', ''Start with the official React docs and build small projects. Use hooks and functional components from the beginning.'', TRUE, ''2025-01-10 12:00:00+00'', ''2025-01-10 12:00:00+00''),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''What is the best way to learn React in 2025?'', ''Join online communities and follow React updates. Practice by contributing to open source.'', TRUE, ''2025-01-10 12:10:00+00'', ''2025-01-10 12:10:00+00''),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''How do you optimize SQL queries for large datasets?'', ''Use proper indexing and avoid SELECT * in production queries.'', TRUE, ''2025-01-10 12:20:00+00'', ''2025-01-10 12:20:00+00''),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''How do you optimize SQL queries for large datasets?'', ''Analyze query plans and break down complex queries into smaller parts.'', TRUE, ''2025-01-10 12:30:00+00'', ''2025-01-10 12:30:00+00'')","-- Jignesh Ameta (306f8931-2603-4c86-b3ab-f804c2c5be57)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''What are the benefits of using TypeScript with Node.js?'', NULL, FALSE, ''2025-01-11 09:00:00+00'', ''2025-01-11 09:00:00+00''),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''How do you implement authentication in a React app?'', NULL, FALSE, ''2025-01-11 09:05:00+00'', ''2025-01-11 09:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''What are the benefits of using TypeScript with Node.js?'', ''TypeScript provides static typing, which helps catch errors early and improves code maintainability.'', TRUE, ''2025-01-11 10:00:00+00'', ''2025-01-11 10:00:00+00''),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''What are the benefits of using TypeScript with Node.js?'', ''It enhances IDE support and makes refactoring easier in large codebases.'', TRUE, ''2025-01-11 10:10:00+00'', ''2025-01-11 10:10:00+00''),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''How do you implement authentication in a React app?'', ''Use libraries like Firebase Auth or Auth0, and manage tokens securely.'', TRUE, ''2025-01-11 10:20:00+00'', ''2025-01-11 10:20:00+00''),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''How do you implement authentication in a React app?'', ''Implement context for auth state and use protected routes.'', TRUE, ''2025-01-11 10:30:00+00'', ''2025-01-11 10:30:00+00'')","-- Arjun Reddy (399e5ea7-4664-4c3c-81d3-b983814d106a)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''What is the difference between REST and GraphQL?'', NULL, FALSE, ''2025-01-12 08:00:00+00'', ''2025-01-12 08:00:00+00''),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''How do you handle state management in large React apps?'', NULL, FALSE, ''2025-01-12 08:05:00+00'', ''2025-01-12 08:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''What is the difference between REST and GraphQL?'', ''REST uses multiple endpoints, while GraphQL uses a single endpoint and allows clients to specify exactly what data they need.'', TRUE, ''2025-01-12 09:00:00+00'', ''2025-01-12 09:00:00+00''),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''What is the difference between REST and GraphQL?'', ''GraphQL can reduce over-fetching and under-fetching of data compared to REST.'', TRUE, ''2025-01-12 09:10:00+00'', ''2025-01-12 09:10:00+00''),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''How do you handle state management in large React apps?'', ''Use libraries like Redux or Zustand, and keep state as local as possible.'', TRUE, ''2025-01-12 09:20:00+00'', ''2025-01-12 09:20:00+00''),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''How do you handle state management in large React apps?'', ''Leverage React Context for global state and custom hooks for logic reuse.'', TRUE, ''2025-01-12 09:30:00+00'', ''2025-01-12 09:30:00+00'')","-- Vishnu Singh (67f2070a-0399-485a-a8e1-e73241df52c0)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''What are the best practices for deploying machine learning models?'', NULL, FALSE, ''2025-01-13 11:00:00+00'', ''2025-01-13 11:00:00+00''),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''How do you ensure data privacy in web applications?'', NULL, FALSE, ''2025-01-13 11:05:00+00'', ''2025-01-13 11:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''What are the best practices for deploying machine learning models?'', ''Containerize models with Docker and use CI/CD pipelines for deployment.'', TRUE, ''2025-01-13 12:00:00+00'', ''2025-01-13 12:00:00+00''),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''What are the best practices for deploying machine learning models?'', ''Monitor model performance and retrain regularly with new data.'', TRUE, ''2025-01-13 12:10:00+00'', ''2025-01-13 12:10:00+00''),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''How do you ensure data privacy in web applications?'', ''Implement HTTPS, encrypt sensitive data, and use secure authentication.'', TRUE, ''2025-01-13 12:20:00+00'', ''2025-01-13 12:20:00+00''),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''How do you ensure data privacy in web applications?'', ''Follow GDPR guidelines and minimize data collection.'', TRUE, ''2025-01-13 12:30:00+00'', ''2025-01-13 12:30:00+00'')","-- Vishal Reddy (68e5b8aa-c6b8-4e2d-a303-a1c10717837b)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''What is a smart contract and how does it work?'', NULL, FALSE, ''2025-01-14 13:00:00+00'', ''2025-01-14 13:00:00+00''),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''How do you secure a blockchain application?'', NULL, FALSE, ''2025-01-14 13:05:00+00'', ''2025-01-14 13:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''What is a smart contract and how does it work?'', ''A smart contract is a self-executing contract with the terms directly written into code on the blockchain.'', TRUE, ''2025-01-14 14:00:00+00'', ''2025-01-14 14:00:00+00''),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''What is a smart contract and how does it work?'', ''It runs on the blockchain and executes automatically when conditions are met.'', TRUE, ''2025-01-14 14:10:00+00'', ''2025-01-14 14:10:00+00''),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''How do you secure a blockchain application?'', ''Use secure coding practices, audit smart contracts, and keep private keys safe.'', TRUE, ''2025-01-14 14:20:00+00'', ''2025-01-14 14:20:00+00''),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''How do you secure a blockchain application?'', ''Implement multi-signature wallets and regular security audits.'', TRUE, ''2025-01-14 14:30:00+00'', ''2025-01-14 14:30:00+00'')","-- Bhasker Singh (702dc5d1-9186-4350-b20f-d3007319a327)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''What are the advantages of cloud computing?'', NULL, FALSE, ''2025-01-15 15:00:00+00'', ''2025-01-15 15:00:00+00''),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''How do you migrate a legacy app to the cloud?'', NULL, FALSE, ''2025-01-15 15:05:00+00'', ''2025-01-15 15:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''What are the advantages of cloud computing?'', ''Scalability, cost-effectiveness, and on-demand resources.'', TRUE, ''2025-01-15 16:00:00+00'', ''2025-01-15 16:00:00+00''),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''What are the advantages of cloud computing?'', ''It allows businesses to focus on core activities instead of infrastructure management.'', TRUE, ''2025-01-15 16:10:00+00'', ''2025-01-15 16:10:00+00''),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''How do you migrate a legacy app to the cloud?'', ''Assess dependencies, refactor code, and use cloud-native services.'', TRUE, ''2025-01-15 16:20:00+00'', ''2025-01-15 16:20:00+00''),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''How do you migrate a legacy app to the cloud?'', ''Start with a lift-and-shift approach, then optimize for the cloud.'', TRUE, ''2025-01-15 16:30:00+00'', ''2025-01-15 16:30:00+00'')","-- Aakash Kumar (719c5acf-8f3e-4064-ac1a-00c3692901ba)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''What is the Composition API in Vue 3?'', NULL, FALSE, ''2025-01-16 17:00:00+00'', ''2025-01-16 17:00:00+00''),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''How do you optimize performance in Vue apps?'', NULL, FALSE, ''2025-01-16 17:05:00+00'', ''2025-01-16 17:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''What is the Composition API in Vue 3?'', ''It allows you to organize code by logical concern, not by lifecycle method.'', TRUE, ''2025-01-16 18:00:00+00'', ''2025-01-16 18:00:00+00''),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''What is the Composition API in Vue 3?'', ''It provides better code reuse and TypeScript support.'', TRUE, ''2025-01-16 18:10:00+00'', ''2025-01-16 18:10:00+00''),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''How do you optimize performance in Vue apps?'', ''Use lazy loading, code splitting, and keep component state local.'', TRUE, ''2025-01-16 18:20:00+00'', ''2025-01-16 18:20:00+00''),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''How do you optimize performance in Vue apps?'', ''Profile your app and avoid unnecessary re-renders.'', TRUE, ''2025-01-16 18:30:00+00'', ''2025-01-16 18:30:00+00'')","-- Kamlesh K (d36c190e-3790-4f8a-b17d-7d4c1f550cb2)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''What is Redis and why is it used?'', NULL, FALSE, ''2025-01-17 19:00:00+00'', ''2025-01-17 19:00:00+00''),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''How do you implement caching in web applications?'', NULL, FALSE, ''2025-01-17 19:05:00+00'', ''2025-01-17 19:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''What is Redis and why is it used?'', ''Redis is an in-memory data store used for caching and fast data access.'', TRUE, ''2025-01-17 20:00:00+00'', ''2025-01-17 20:00:00+00''),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''What is Redis and why is it used?'', ''It supports data structures like strings, hashes, and lists, and is often used for session storage.'', TRUE, ''2025-01-17 20:10:00+00'', ''2025-01-17 20:10:00+00''),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''How do you implement caching in web applications?'', ''Use HTTP cache headers and in-memory stores like Redis or Memcached.'', TRUE, ''2025-01-17 20:20:00+00'', ''2025-01-17 20:20:00+00''),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''How do you implement caching in web applications?'', ''Cache database query results and static assets for faster load times.'', TRUE, ''2025-01-17 20:30:00+00'', ''2025-01-17 20:30:00+00'')","-- Parinita Reddy (e657b686-9443-4cc9-800b-bc7fa4985e35)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''What are Progressive Web Apps (PWAs)?'', NULL, FALSE, ''2025-01-18 21:00:00+00'', ''2025-01-18 21:00:00+00''),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''How do you implement offline support in web apps?'', NULL, FALSE, ''2025-01-18 21:05:00+00'', ''2025-01-18 21:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''What are Progressive Web Apps (PWAs)?'', ''PWAs are web apps that use modern web capabilities to deliver an app-like experience.'', TRUE, ''2025-01-18 22:00:00+00'', ''2025-01-18 22:00:00+00''),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''What are Progressive Web Apps (PWAs)?'', ''They can work offline, be installed on devices, and send push notifications.'', TRUE, ''2025-01-18 22:10:00+00'', ''2025-01-18 22:10:00+00''),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''How do you implement offline support in web apps?'', ''Use service workers to cache assets and API responses.'', TRUE, ''2025-01-18 22:20:00+00'', ''2025-01-18 22:20:00+00''),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''How do you implement offline support in web apps?'', ''Store data locally and sync when online.'', TRUE, ''2025-01-18 22:30:00+00'', ''2025-01-18 22:30:00+00'')","-- Arjun Kumar R (f8adc086-3c84-4038-820d-5e1cf0d63d39)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''What is system design and why is it important?'', NULL, FALSE, ''2025-01-19 23:00:00+00'', ''2025-01-19 23:00:00+00''),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''How do you scale a web application?'', NULL, FALSE, ''2025-01-19 23:05:00+00'', ''2025-01-19 23:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''What is system design and why is it important?'', ''System design is the process of defining the architecture and components of a system to meet requirements.'', TRUE, ''2025-01-20 00:00:00+00'', ''2025-01-20 00:00:00+00''),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''What is system design and why is it important?'', ''It ensures scalability, reliability, and maintainability of applications.'', TRUE, ''2025-01-20 00:10:00+00'', ''2025-01-20 00:10:00+00''),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''How do you scale a web application?'', ''Use load balancers, caching, and database sharding.'', TRUE, ''2025-01-20 00:20:00+00'', ''2025-01-20 00:20:00+00''),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''How do you scale a web application?'', ''Deploy across multiple servers and use CDN for static assets.'', TRUE, ''2025-01-20 00:30:00+00'', ''2025-01-20 00:30:00+00'')","-- Priyanka KS (ffbfa1b0-84c5-45fe-8f31-2eda223ac751)
INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''What is data visualization and why is it important?'', NULL, FALSE, ''2025-01-20 08:00:00+00'', ''2025-01-20 08:00:00+00''),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''How do you implement real-time features in web apps?'', NULL, FALSE, ''2025-01-20 08:05:00+00'', ''2025-01-20 08:05:00+00'')","INSERT INTO public.questionanswers (user_id, question, answer, is_answered, created_at, updated_at) VALUES
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''What is data visualization and why is it important?'', ''Data visualization helps communicate information clearly and efficiently using charts and graphs.'', TRUE, ''2025-01-20 09:00:00+00'', ''2025-01-20 09:00:00+00''),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''What is data visualization and why is it important?'', ''It enables quick insights and better decision-making from data.'', TRUE, ''2025-01-20 09:10:00+00'', ''2025-01-20 09:10:00+00''),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''How do you implement real-time features in web apps?'', ''Use WebSockets or libraries like Socket.io for real-time communication.'', TRUE, ''2025-01-20 09:20:00+00'', ''2025-01-20 09:20:00+00''),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''How do you implement real-time features in web apps?'', ''Leverage server-sent events or third-party services like Pusher.'', TRUE, ''2025-01-20 09:30:00+00'', ''2025-01-20 09:30:00+00'')"}', 'qna_data');
INSERT INTO supabase_migrations.schema_migrations (version, statements, name) VALUES ('20250629202129', '{"-- =====================================================
-- POSTS DATA - 2 POSTS PER USER
-- =====================================================

-- Posts for Priya Kumari (1319be79-c9ec-450f-8115-4445c9da6d98)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''Just completed a React Native project! The mobile app development journey has been incredible. Learning about cross-platform development and the challenges of maintaining consistent UI across iOS and Android. #ReactNative #MobileDev #CrossPlatform'', NULL, ''2025-01-15 10:30:00+00'', ''2025-01-15 10:30:00+00'', FALSE),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''Attended an amazing workshop on GraphQL today. The way it simplifies API development and reduces over-fetching is mind-blowing. Excited to implement it in my next project! #GraphQL #API #WebDevelopment'', NULL, ''2025-01-20 14:45:00+00'', ''2025-01-20 14:45:00+00'', FALSE)","-- Posts for Jignesh Ameta (306f8931-2603-4c86-b3ab-f804c2c5be57)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''Working on a full-stack application using Next.js 14 and Supabase. The new App Router and Server Components are game-changers! The developer experience is unmatched. #NextJS #Supabase #FullStack'', NULL, ''2025-01-12 09:15:00+00'', ''2025-01-12 09:15:00+00'', FALSE),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''Just deployed my first microservices architecture on AWS. The learning curve was steep but the scalability benefits are worth it. Docker + Kubernetes + AWS ECS = powerful combination! #Microservices #AWS #Docker #Kubernetes'', NULL, ''2025-01-18 16:20:00+00'', ''2025-01-18 16:20:00+00'', FALSE)","-- Posts for Arjun Reddy (399e5ea7-4664-4c3c-81d3-b983814d106a)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''Started learning TypeScript today. The type safety and better IDE support are incredible! No more runtime errors for simple type mistakes. #TypeScript #JavaScript #Programming'', NULL, ''2025-01-14 11:00:00+00'', ''2025-01-14 11:00:00+00'', FALSE),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''Built a real-time chat application using Socket.io and Node.js. The WebSocket implementation was surprisingly straightforward. Real-time features are so much fun to build! #SocketIO #NodeJS #RealTime #WebSockets'', NULL, ''2025-01-22 13:30:00+00'', ''2025-01-22 13:30:00+00'', FALSE)","-- Posts for Vishnu Singh (67f2070a-0399-485a-a8e1-e73241df52c0)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''Exploring machine learning with Python and TensorFlow. The potential of AI in modern applications is fascinating. Working on a recommendation system for my portfolio project. #MachineLearning #Python #TensorFlow #AI'', NULL, ''2025-01-16 08:45:00+00'', ''2025-01-16 08:45:00+00'', FALSE),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''Just completed a course on DevOps practices. CI/CD pipelines, automated testing, and infrastructure as code are revolutionizing how we deploy software. #DevOps #CICD #Automation #Infrastructure'', NULL, ''2025-01-21 15:10:00+00'', ''2025-01-21 15:10:00+00'', FALSE)","-- Posts for Vishal Reddy (68e5b8aa-c6b8-4e2d-a303-a1c10717837b)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''Working on a blockchain project using Ethereum and Solidity. Smart contracts are powerful but require careful attention to security. Learning about gas optimization and best practices. #Blockchain #Ethereum #Solidity #SmartContracts'', NULL, ''2025-01-13 12:30:00+00'', ''2025-01-13 12:30:00+00'', FALSE),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''Just finished building a REST API with Express.js and MongoDB. The combination of Node.js backend with NoSQL database is perfect for rapid prototyping. #ExpressJS #MongoDB #RESTAPI #NodeJS'', NULL, ''2025-01-19 10:15:00+00'', ''2025-01-19 10:15:00+00'', FALSE)","-- Posts for Bhasker Singh (702dc5d1-9186-4350-b20f-d3007319a327)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''Learning about cloud computing with AWS. The scalability and cost-effectiveness of cloud services are amazing. Working on migrating a legacy application to the cloud. #AWS #CloudComputing #Migration #Scalability'', NULL, ''2025-01-17 14:20:00+00'', ''2025-01-17 14:20:00+00'', FALSE),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''Just implemented OAuth 2.0 authentication in my application. Security is crucial in modern web development. Understanding JWT tokens and secure session management. #OAuth #Security #JWT #Authentication'', NULL, ''2025-01-23 09:45:00+00'', ''2025-01-23 09:45:00+00'', FALSE)","-- Posts for Aakash Kumar (719c5acf-8f3e-4064-ac1a-00c3692901ba)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''Working with Vue.js 3 and Composition API. The new reactivity system is much more intuitive than the Options API. Building a dashboard with Vue 3 and Vite. #VueJS #CompositionAPI #Vite #Frontend'', NULL, ''2025-01-11 16:00:00+00'', ''2025-01-11 16:00:00+00'', FALSE),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''Just completed a course on database design and optimization. Understanding indexes, query optimization, and database normalization is crucial for building scalable applications. #Database #SQL #Optimization #Performance'', NULL, ''2025-01-24 11:30:00+00'', ''2025-01-24 11:30:00+00'', FALSE)","-- Posts for Kamlesh K (d36c190e-3790-4f8a-b17d-7d4c1f550cb2)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''Exploring Flutter for cross-platform mobile development. The hot reload feature and beautiful Material Design components make development so much faster. #Flutter #Dart #MobileDev #CrossPlatform'', NULL, ''2025-01-10 13:15:00+00'', ''2025-01-10 13:15:00+00'', FALSE),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''Working on a project using Redis for caching. The performance improvement is incredible! Understanding when and how to use caching effectively is a game-changer. #Redis #Caching #Performance #Backend'', NULL, ''2025-01-25 15:45:00+00'', ''2025-01-25 15:45:00+00'', FALSE)","-- Posts for Parinita Reddy (e657b686-9443-4cc9-800b-bc7fa4985e35)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''Learning about Progressive Web Apps (PWAs). The ability to work offline and provide native app-like experience is revolutionary. Building my first PWA with service workers. #PWA #ServiceWorkers #Offline #WebApp'', NULL, ''2025-01-09 10:30:00+00'', ''2025-01-09 10:30:00+00'', FALSE),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''Just implemented automated testing with Jest and React Testing Library. Writing tests first (TDD) has completely changed my development workflow. Quality code is maintainable code! #Testing #Jest #ReactTestingLibrary #TDD'', NULL, ''2025-01-26 12:00:00+00'', ''2025-01-26 12:00:00+00'', FALSE)","-- Posts for Arjun Kumar R (f8adc086-3c84-4038-820d-5e1cf0d63d39)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''Working with Angular 17 and standalone components. The new control flow syntax and improved performance are amazing. Building a large-scale enterprise application. #Angular #StandaloneComponents #Enterprise #Frontend'', NULL, ''2025-01-08 14:45:00+00'', ''2025-01-08 14:45:00+00'', FALSE),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''Just completed a course on system design. Understanding scalability, load balancing, and distributed systems is crucial for building robust applications. #SystemDesign #Scalability #Architecture #DistributedSystems'', NULL, ''2025-01-27 16:20:00+00'', ''2025-01-27 16:20:00+00'', FALSE)","-- Posts for Priyanka KS (ffbfa1b0-84c5-45fe-8f31-2eda223ac751)
INSERT INTO public.posts (user_id, content, media_url, created_at, updated_at, is_deleted) VALUES
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''Learning about data visualization with D3.js. Creating interactive charts and graphs for data analysis. The power of SVG and CSS transforms is incredible! #DataVisualization #D3JS #SVG #Analytics'', NULL, ''2025-01-07 11:20:00+00'', ''2025-01-07 11:20:00+00'', FALSE),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''Working on a project using WebRTC for real-time video communication. The technology behind video calls and screen sharing is fascinating. Building a simple video chat application. #WebRTC #VideoChat #RealTime #Communication'', NULL, ''2025-01-28 13:50:00+00'', ''2025-01-28 13:50:00+00'', FALSE)"}', 'posts_data');
INSERT INTO supabase_migrations.schema_migrations (version, statements, name) VALUES ('20250629202945', '{"-- All users follow each other (except themselves)
INSERT INTO public.followers (follower_id, following_id, created_at) VALUES
-- Priya Kumari
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''1319be79-c9ec-450f-8115-4445c9da6d98'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Jignesh Ameta
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''306f8931-2603-4c86-b3ab-f804c2c5be57'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Arjun Reddy
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''399e5ea7-4664-4c3c-81d3-b983814d106a'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Vishnu Singh
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''67f2070a-0399-485a-a8e1-e73241df52c0'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Vishal Reddy
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Bhasker Singh
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''702dc5d1-9186-4350-b20f-d3007319a327'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Aakash Kumar
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''719c5acf-8f3e-4064-ac1a-00c3692901ba'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Kamlesh K
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Parinita Reddy
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now()),
(''e657b686-9443-4cc9-800b-bc7fa4985e35'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Arjun Kumar R
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''f8adc086-3c84-4038-820d-5e1cf0d63d39'', ''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', now()),
-- Priyanka KS
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''1319be79-c9ec-450f-8115-4445c9da6d98'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''306f8931-2603-4c86-b3ab-f804c2c5be57'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''399e5ea7-4664-4c3c-81d3-b983814d106a'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''67f2070a-0399-485a-a8e1-e73241df52c0'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''68e5b8aa-c6b8-4e2d-a303-a1c10717837b'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''702dc5d1-9186-4350-b20f-d3007319a327'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''719c5acf-8f3e-4064-ac1a-00c3692901ba'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''d36c190e-3790-4f8a-b17d-7d4c1f550cb2'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''e657b686-9443-4cc9-800b-bc7fa4985e35'', now()),
(''ffbfa1b0-84c5-45fe-8f31-2eda223ac751'', ''f8adc086-3c84-4038-820d-5e1cf0d63d39'', now())"}', 'followers_data');
INSERT INTO supabase_migrations.schema_migrations (version, statements, name) VALUES ('20250630000000', '{"create or replace function leave_group(p_chat_id uuid, p_user_id uuid)
returns void as $$
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
$$ language plpgsql security definer"}', 'leave_group_function');
INSERT INTO supabase_migrations.schema_migrations (version, statements, name) VALUES ('20250630024042', '{"-- =====================================================
-- STORAGE BUCKET CREATION
-- =====================================================

-- Create the uploads storage bucket
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  ''uploads'',
  ''uploads'',
  true,
  52428800, -- 50MB limit
  ARRAY[
    ''image/*'',
    ''video/*'',
    ''application/pdf'',
    ''text/*'',
    ''application/json'',
    ''application/javascript'',
    ''text/javascript'',
    ''text/css'',
    ''text/html'',
    ''application/msword'',
    ''application/vnd.openxmlformats-officedocument.wordprocessingml.document'',
    ''application/vnd.ms-excel'',
    ''application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'',
    ''application/vnd.ms-powerpoint'',
    ''application/vnd.openxmlformats-officedocument.presentationml.presentation'',
    ''application/zip'',
    ''application/x-rar-compressed'',
    ''application/x-7z-compressed''
  ]
) ON CONFLICT (id) DO NOTHING","-- =====================================================
-- STORAGE POLICIES
-- =====================================================

-- Allow authenticated users to upload files
CREATE POLICY \"Allow authenticated uploads\" ON storage.objects
FOR INSERT WITH CHECK (
  bucket_id = ''uploads'' AND 
  auth.role() = ''authenticated''
)","-- Allow users to view their own files and public files
CREATE POLICY \"Allow file viewing\" ON storage.objects
FOR SELECT USING (
  bucket_id = ''uploads'' AND (
    auth.uid()::text = (storage.foldername(name))[1] OR
    EXISTS (
      SELECT 1 FROM public.filemodels 
      WHERE file_url LIKE ''%'' || name || ''%'' 
      AND is_public = true
    )
  )
)","-- Allow users to update their own files
CREATE POLICY \"Allow file updates\" ON storage.objects
FOR UPDATE USING (
  bucket_id = ''uploads'' AND 
  auth.uid()::text = (storage.foldername(name))[1]
)","-- Allow users to delete their own files
CREATE POLICY \"Allow file deletion\" ON storage.objects
FOR DELETE USING (
  bucket_id = ''uploads'' AND 
  auth.uid()::text = (storage.foldername(name))[1]
)","-- =====================================================
-- FILEMODELS RLS POLICIES
-- =====================================================

-- Enable RLS on filemodels table
ALTER TABLE public.filemodels ENABLE ROW LEVEL SECURITY","-- Allow users to view their own files and public files
CREATE POLICY \"Users can view own and public files\" ON public.filemodels
FOR SELECT USING (
  auth.uid() = user_id OR is_public = true
)","-- Allow users to insert their own files
CREATE POLICY \"Users can insert own files\" ON public.filemodels
FOR INSERT WITH CHECK (
  auth.uid() = user_id
)","-- Allow users to update their own files
CREATE POLICY \"Users can update own files\" ON public.filemodels
FOR UPDATE USING (
  auth.uid() = user_id
)","-- Allow users to delete their own files
CREATE POLICY \"Users can delete own files\" ON public.filemodels
FOR DELETE USING (
  auth.uid() = user_id
)","-- =====================================================
-- FUNCTIONS FOR FILE OPERATIONS
-- =====================================================

-- Function to delete file from storage when filemodel is deleted
CREATE OR REPLACE FUNCTION public.handle_file_deletion()
RETURNS TRIGGER AS $$
BEGIN
  -- Extract filename from file_url
  DECLARE
    file_path TEXT;
  BEGIN
    -- Extract the path from the file_url (remove domain and bucket prefix)
    file_path := REPLACE(OLD.file_url, ''https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/'', '''');
    
    -- Delete from storage
    DELETE FROM storage.objects 
    WHERE bucket_id = ''uploads'' 
    AND name = file_path;
    
    RETURN OLD;
  EXCEPTION
    WHEN OTHERS THEN
      -- Log error but don''t fail the deletion
      RAISE WARNING ''Failed to delete file from storage: %'', SQLERRM;
      RETURN OLD;
  END;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER","-- Trigger to automatically delete storage files when filemodel is deleted
CREATE TRIGGER file_deletion_trigger
  AFTER DELETE ON public.filemodels
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_file_deletion()","-- Function to update file in storage when filemodel is updated
CREATE OR REPLACE FUNCTION public.handle_file_update()
RETURNS TRIGGER AS $$
BEGIN
  -- If file_url changed, delete old file from storage
  IF OLD.file_url != NEW.file_url THEN
    DECLARE
      old_file_path TEXT;
    BEGIN
      -- Extract the path from the old file_url
      old_file_path := REPLACE(OLD.file_url, ''https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/'', '''');
      
      -- Delete old file from storage
      DELETE FROM storage.objects 
      WHERE bucket_id = ''uploads'' 
      AND name = old_file_path;
    EXCEPTION
      WHEN OTHERS THEN
        -- Log error but don''t fail the update
        RAISE WARNING ''Failed to delete old file from storage: %'', SQLERRM;
    END;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER","-- Trigger to handle file updates
CREATE TRIGGER file_update_trigger
  AFTER UPDATE ON public.filemodels
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_file_update()","-- =====================================================
-- INDEXES FOR BETTER PERFORMANCE
-- =====================================================

-- Index for file search by name and description
CREATE INDEX IF NOT EXISTS idx_filemodels_search 
ON public.filemodels USING gin(to_tsvector(''english'', file_name || '' '' || COALESCE(description, '''')))","-- Index for public files
CREATE INDEX IF NOT EXISTS idx_filemodels_public 
ON public.filemodels(is_public) WHERE is_public = true","-- Index for user files
CREATE INDEX IF NOT EXISTS idx_filemodels_user_created 
ON public.filemodels(user_id, created_at DESC)"}', 'storage_and_file_policies');


--
-- TOC entry 4509 (class 0 OID 17532)
-- Dependencies: 390
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--



--
-- TOC entry 3749 (class 0 OID 16656)
-- Dependencies: 354
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--



--
-- TOC entry 4737 (class 0 OID 0)
-- Dependencies: 346
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 128, true);


--
-- TOC entry 4738 (class 0 OID 0)
-- Dependencies: 406
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answers_id_seq', 1, false);


--
-- TOC entry 4739 (class 0 OID 0)
-- Dependencies: 401
-- Name: question_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_votes_id_seq', 4, true);


--
-- TOC entry 4740 (class 0 OID 0)
-- Dependencies: 404
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 1, false);


--
-- TOC entry 4741 (class 0 OID 0)
-- Dependencies: 412
-- Name: reputation_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reputation_events_id_seq', 1, false);


--
-- TOC entry 4742 (class 0 OID 0)
-- Dependencies: 410
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- TOC entry 4743 (class 0 OID 0)
-- Dependencies: 408
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.votes_id_seq', 1, false);


--
-- TOC entry 4744 (class 0 OID 0)
-- Dependencies: 372
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1323, true);


--
-- TOC entry 3970 (class 2606 OID 16825)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3928 (class 2606 OID 16529)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3992 (class 2606 OID 16931)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3949 (class 2606 OID 16949)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3951 (class 2606 OID 16959)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3926 (class 2606 OID 16522)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3972 (class 2606 OID 16818)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3968 (class 2606 OID 16806)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3960 (class 2606 OID 16999)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 3962 (class 2606 OID 16793)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 3996 (class 2606 OID 16984)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3920 (class 2606 OID 16512)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3923 (class 2606 OID 16736)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3981 (class 2606 OID 16865)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 3983 (class 2606 OID 16863)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3988 (class 2606 OID 16879)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3931 (class 2606 OID 16535)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3955 (class 2606 OID 16757)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3978 (class 2606 OID 16846)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3974 (class 2606 OID 16837)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3913 (class 2606 OID 16919)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3915 (class 2606 OID 16499)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4086 (class 2606 OID 24199)
-- Name: answer_comments answer_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comments
    ADD CONSTRAINT answer_comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4082 (class 2606 OID 24180)
-- Name: answer_votes answer_votes_answer_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_votes
    ADD CONSTRAINT answer_votes_answer_id_user_id_key UNIQUE (answer_id, user_id);


--
-- TOC entry 4084 (class 2606 OID 24178)
-- Name: answer_votes answer_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_votes
    ADD CONSTRAINT answer_votes_pkey PRIMARY KEY (id);


--
-- TOC entry 4096 (class 2606 OID 24372)
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- TOC entry 4041 (class 2606 OID 17402)
-- Name: chat_members chat_members_chat_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT chat_members_chat_id_user_id_key UNIQUE (chat_id, user_id);


--
-- TOC entry 4043 (class 2606 OID 17400)
-- Name: chat_members chat_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT chat_members_pkey PRIMARY KEY (id);


--
-- TOC entry 4047 (class 2606 OID 17423)
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- TOC entry 4039 (class 2606 OID 17393)
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- TOC entry 4070 (class 2606 OID 17922)
-- Name: comment_likes comment_likes_comment_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_comment_id_user_id_key UNIQUE (comment_id, user_id);


--
-- TOC entry 4072 (class 2606 OID 17920)
-- Name: comment_likes comment_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_pkey PRIMARY KEY (id);


--
-- TOC entry 4068 (class 2606 OID 17854)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4078 (class 2606 OID 22176)
-- Name: content_flags content_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_flags
    ADD CONSTRAINT content_flags_pkey PRIMARY KEY (id);


--
-- TOC entry 4050 (class 2606 OID 17444)
-- Name: filemodels filemodels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filemodels
    ADD CONSTRAINT filemodels_pkey PRIMARY KEY (id);


--
-- TOC entry 4030 (class 2606 OID 17355)
-- Name: followers followers_follower_id_following_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_follower_id_following_id_key UNIQUE (follower_id, following_id);


--
-- TOC entry 4032 (class 2606 OID 17353)
-- Name: followers followers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_pkey PRIMARY KEY (id);


--
-- TOC entry 4026 (class 2606 OID 17333)
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- TOC entry 4028 (class 2606 OID 17335)
-- Name: likes likes_user_id_post_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_post_id_key UNIQUE (user_id, post_id);


--
-- TOC entry 4037 (class 2606 OID 17377)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4023 (class 2606 OID 17320)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 4016 (class 2606 OID 17289)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4060 (class 2606 OID 17477)
-- Name: qanotifications qanotifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qanotifications
    ADD CONSTRAINT qanotifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4108 (class 2606 OID 24433)
-- Name: question_tags question_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tags
    ADD CONSTRAINT question_tags_pkey PRIMARY KEY (question_id, tag_id);


--
-- TOC entry 4088 (class 2606 OID 24277)
-- Name: question_votes question_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_votes
    ADD CONSTRAINT question_votes_pkey PRIMARY KEY (id);


--
-- TOC entry 4090 (class 2606 OID 24279)
-- Name: question_votes question_votes_question_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_votes
    ADD CONSTRAINT question_votes_question_id_user_id_key UNIQUE (question_id, user_id);


--
-- TOC entry 4057 (class 2606 OID 17461)
-- Name: questionanswers questionanswers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questionanswers
    ADD CONSTRAINT questionanswers_pkey PRIMARY KEY (id);


--
-- TOC entry 4094 (class 2606 OID 24356)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4106 (class 2606 OID 24423)
-- Name: reputation_events reputation_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reputation_events
    ADD CONSTRAINT reputation_events_pkey PRIMARY KEY (id);


--
-- TOC entry 4102 (class 2606 OID 24413)
-- Name: tags tags_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- TOC entry 4104 (class 2606 OID 24411)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4018 (class 2606 OID 17302)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4020 (class 2606 OID 17304)
-- Name: user_roles user_roles_user_id_role_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_role_key UNIQUE (user_id, role);


--
-- TOC entry 4098 (class 2606 OID 24394)
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- TOC entry 4100 (class 2606 OID 24396)
-- Name: votes votes_user_id_target_id_target_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_target_id_target_type_key UNIQUE (user_id, target_id, target_type);


--
-- TOC entry 4012 (class 2606 OID 17265)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4064 (class 2606 OID 17580)
-- Name: messages_2025_07_01 messages_2025_07_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_01
    ADD CONSTRAINT messages_2025_07_01_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4066 (class 2606 OID 17591)
-- Name: messages_2025_07_02 messages_2025_07_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_02
    ADD CONSTRAINT messages_2025_07_02_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4074 (class 2606 OID 18598)
-- Name: messages_2025_07_03 messages_2025_07_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_03
    ADD CONSTRAINT messages_2025_07_03_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4076 (class 2606 OID 22119)
-- Name: messages_2025_07_04 messages_2025_07_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_04
    ADD CONSTRAINT messages_2025_07_04_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4080 (class 2606 OID 22586)
-- Name: messages_2025_07_05 messages_2025_07_05_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_05
    ADD CONSTRAINT messages_2025_07_05_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4092 (class 2606 OID 24318)
-- Name: messages_2025_07_06 messages_2025_07_06_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_06
    ADD CONSTRAINT messages_2025_07_06_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4110 (class 2606 OID 25577)
-- Name: messages_2025_07_07 messages_2025_07_07_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_07
    ADD CONSTRAINT messages_2025_07_07_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4009 (class 2606 OID 17115)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 4001 (class 2606 OID 17022)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3934 (class 2606 OID 16552)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 3941 (class 2606 OID 16593)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3943 (class 2606 OID 16591)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3939 (class 2606 OID 16569)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 4006 (class 2606 OID 17060)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 4004 (class 2606 OID 17045)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 4014 (class 2606 OID 17275)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4062 (class 2606 OID 17538)
-- Name: seed_files seed_files_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.seed_files
    ADD CONSTRAINT seed_files_pkey PRIMARY KEY (path);


--
-- TOC entry 3929 (class 1259 OID 16530)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3903 (class 1259 OID 16746)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3904 (class 1259 OID 16748)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3905 (class 1259 OID 16749)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3958 (class 1259 OID 16827)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 3990 (class 1259 OID 16935)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3947 (class 1259 OID 16915)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4745 (class 0 OID 0)
-- Dependencies: 3947
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3952 (class 1259 OID 16743)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 3993 (class 1259 OID 16932)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 3994 (class 1259 OID 16933)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3966 (class 1259 OID 16938)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3963 (class 1259 OID 16799)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3964 (class 1259 OID 16944)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 3997 (class 1259 OID 16991)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 3998 (class 1259 OID 16990)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 3999 (class 1259 OID 16992)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3906 (class 1259 OID 16750)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3907 (class 1259 OID 16747)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3916 (class 1259 OID 16513)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3917 (class 1259 OID 16514)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3918 (class 1259 OID 16742)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3921 (class 1259 OID 16829)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3924 (class 1259 OID 16934)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 3984 (class 1259 OID 16871)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 3985 (class 1259 OID 16936)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 3986 (class 1259 OID 16886)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 3989 (class 1259 OID 16885)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3953 (class 1259 OID 16937)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3956 (class 1259 OID 16828)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 3976 (class 1259 OID 16853)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 3979 (class 1259 OID 16852)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 3975 (class 1259 OID 16838)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 3965 (class 1259 OID 16997)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 3957 (class 1259 OID 16826)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3908 (class 1259 OID 16906)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4746 (class 0 OID 0)
-- Dependencies: 3908
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3909 (class 1259 OID 16744)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3910 (class 1259 OID 16503)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3911 (class 1259 OID 16961)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 4044 (class 1259 OID 17413)
-- Name: idx_chat_members_chat_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chat_members_chat_id ON public.chat_members USING btree (chat_id);


--
-- TOC entry 4045 (class 1259 OID 17414)
-- Name: idx_chat_members_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chat_members_user_id ON public.chat_members USING btree (user_id);


--
-- TOC entry 4048 (class 1259 OID 17434)
-- Name: idx_chat_messages_chat_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chat_messages_chat_id ON public.chat_messages USING btree (chat_id);


--
-- TOC entry 4051 (class 1259 OID 18711)
-- Name: idx_filemodels_public; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_filemodels_public ON public.filemodels USING btree (is_public) WHERE (is_public = true);


--
-- TOC entry 4052 (class 1259 OID 18710)
-- Name: idx_filemodels_search; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_filemodels_search ON public.filemodels USING gin (to_tsvector('english'::regconfig, ((file_name || ' '::text) || COALESCE(description, ''::text))));


--
-- TOC entry 4053 (class 1259 OID 18712)
-- Name: idx_filemodels_user_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_filemodels_user_created ON public.filemodels USING btree (user_id, created_at DESC);


--
-- TOC entry 4054 (class 1259 OID 17450)
-- Name: idx_filemodels_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_filemodels_user_id ON public.filemodels USING btree (user_id);


--
-- TOC entry 4033 (class 1259 OID 17366)
-- Name: idx_followers_follower_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_followers_follower_id ON public.followers USING btree (follower_id);


--
-- TOC entry 4034 (class 1259 OID 17367)
-- Name: idx_followers_following_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_followers_following_id ON public.followers USING btree (following_id);


--
-- TOC entry 4024 (class 1259 OID 17346)
-- Name: idx_likes_post_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_likes_post_id ON public.likes USING btree (post_id);


--
-- TOC entry 4035 (class 1259 OID 17383)
-- Name: idx_notifications_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notifications_user_id ON public.notifications USING btree (user_id);


--
-- TOC entry 4021 (class 1259 OID 17326)
-- Name: idx_posts_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_posts_user_id ON public.posts USING btree (user_id);


--
-- TOC entry 4058 (class 1259 OID 17488)
-- Name: idx_qanotifications_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qanotifications_user_id ON public.qanotifications USING btree (user_id);


--
-- TOC entry 4055 (class 1259 OID 17467)
-- Name: idx_questionanswers_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_questionanswers_user_id ON public.questionanswers USING btree (user_id);


--
-- TOC entry 4007 (class 1259 OID 17266)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 4010 (class 1259 OID 17164)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 3932 (class 1259 OID 16558)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3935 (class 1259 OID 16580)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 4002 (class 1259 OID 17071)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3936 (class 1259 OID 17036)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3937 (class 1259 OID 16581)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 4111 (class 0 OID 0)
-- Name: messages_2025_07_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_01_pkey;


--
-- TOC entry 4112 (class 0 OID 0)
-- Name: messages_2025_07_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_02_pkey;


--
-- TOC entry 4113 (class 0 OID 0)
-- Name: messages_2025_07_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_03_pkey;


--
-- TOC entry 4114 (class 0 OID 0)
-- Name: messages_2025_07_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_04_pkey;


--
-- TOC entry 4115 (class 0 OID 0)
-- Name: messages_2025_07_05_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_05_pkey;


--
-- TOC entry 4116 (class 0 OID 0)
-- Name: messages_2025_07_06_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_06_pkey;


--
-- TOC entry 4117 (class 0 OID 0)
-- Name: messages_2025_07_07_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_07_pkey;


--
-- TOC entry 4171 (class 2620 OID 17491)
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- TOC entry 4174 (class 2620 OID 18707)
-- Name: filemodels file_deletion_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER file_deletion_trigger AFTER DELETE ON public.filemodels FOR EACH ROW EXECUTE FUNCTION public.handle_file_deletion();


--
-- TOC entry 4175 (class 2620 OID 18709)
-- Name: filemodels file_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER file_update_trigger AFTER UPDATE ON public.filemodels FOR EACH ROW EXECUTE FUNCTION public.handle_file_update();


--
-- TOC entry 4173 (class 2620 OID 17120)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4172 (class 2620 OID 17024)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4120 (class 2606 OID 16730)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4124 (class 2606 OID 16819)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4123 (class 2606 OID 16807)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4122 (class 2606 OID 16794)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4129 (class 2606 OID 16985)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4118 (class 2606 OID 16763)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4126 (class 2606 OID 16866)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4127 (class 2606 OID 16939)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4128 (class 2606 OID 16880)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4121 (class 2606 OID 16758)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4125 (class 2606 OID 16847)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4159 (class 2606 OID 24200)
-- Name: answer_comments answer_comments_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comments
    ADD CONSTRAINT answer_comments_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.questionanswers(id) ON DELETE CASCADE;


--
-- TOC entry 4160 (class 2606 OID 24321)
-- Name: answer_comments answer_comments_parent_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comments
    ADD CONSTRAINT answer_comments_parent_comment_id_fkey FOREIGN KEY (parent_comment_id) REFERENCES public.answer_comments(id) ON DELETE CASCADE;


--
-- TOC entry 4161 (class 2606 OID 24205)
-- Name: answer_comments answer_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comments
    ADD CONSTRAINT answer_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4157 (class 2606 OID 24181)
-- Name: answer_votes answer_votes_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_votes
    ADD CONSTRAINT answer_votes_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.questionanswers(id) ON DELETE CASCADE;


--
-- TOC entry 4158 (class 2606 OID 24186)
-- Name: answer_votes answer_votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_votes
    ADD CONSTRAINT answer_votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4165 (class 2606 OID 24373)
-- Name: answers answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- TOC entry 4166 (class 2606 OID 24378)
-- Name: answers answers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4141 (class 2606 OID 17403)
-- Name: chat_members chat_members_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT chat_members_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(id) ON DELETE CASCADE;


--
-- TOC entry 4142 (class 2606 OID 17408)
-- Name: chat_members chat_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT chat_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4143 (class 2606 OID 17424)
-- Name: chat_messages chat_messages_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(id) ON DELETE CASCADE;


--
-- TOC entry 4144 (class 2606 OID 17429)
-- Name: chat_messages chat_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4152 (class 2606 OID 17923)
-- Name: comment_likes comment_likes_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- TOC entry 4153 (class 2606 OID 17928)
-- Name: comment_likes comment_likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4149 (class 2606 OID 18046)
-- Name: comments comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- TOC entry 4150 (class 2606 OID 17855)
-- Name: comments comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 4151 (class 2606 OID 17860)
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4154 (class 2606 OID 22187)
-- Name: content_flags content_flags_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_flags
    ADD CONSTRAINT content_flags_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(id);


--
-- TOC entry 4155 (class 2606 OID 22177)
-- Name: content_flags content_flags_flagged_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_flags
    ADD CONSTRAINT content_flags_flagged_by_user_id_fkey FOREIGN KEY (flagged_by_user_id) REFERENCES public.profiles(id);


--
-- TOC entry 4156 (class 2606 OID 23846)
-- Name: content_flags content_flags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_flags
    ADD CONSTRAINT content_flags_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 4145 (class 2606 OID 17445)
-- Name: filemodels filemodels_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filemodels
    ADD CONSTRAINT filemodels_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4138 (class 2606 OID 17356)
-- Name: followers followers_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4139 (class 2606 OID 17361)
-- Name: followers followers_following_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_following_id_fkey FOREIGN KEY (following_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4136 (class 2606 OID 17341)
-- Name: likes likes_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 4137 (class 2606 OID 17336)
-- Name: likes likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4140 (class 2606 OID 17378)
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4135 (class 2606 OID 17321)
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4133 (class 2606 OID 17290)
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4147 (class 2606 OID 17483)
-- Name: qanotifications qanotifications_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qanotifications
    ADD CONSTRAINT qanotifications_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questionanswers(id) ON DELETE CASCADE;


--
-- TOC entry 4148 (class 2606 OID 17478)
-- Name: qanotifications qanotifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qanotifications
    ADD CONSTRAINT qanotifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4169 (class 2606 OID 24434)
-- Name: question_tags question_tags_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tags
    ADD CONSTRAINT question_tags_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- TOC entry 4170 (class 2606 OID 24439)
-- Name: question_tags question_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tags
    ADD CONSTRAINT question_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- TOC entry 4162 (class 2606 OID 24280)
-- Name: question_votes question_votes_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_votes
    ADD CONSTRAINT question_votes_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questionanswers(id) ON DELETE CASCADE;


--
-- TOC entry 4163 (class 2606 OID 24285)
-- Name: question_votes question_votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_votes
    ADD CONSTRAINT question_votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4146 (class 2606 OID 17462)
-- Name: questionanswers questionanswers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questionanswers
    ADD CONSTRAINT questionanswers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4164 (class 2606 OID 24357)
-- Name: questions questions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4168 (class 2606 OID 24424)
-- Name: reputation_events reputation_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reputation_events
    ADD CONSTRAINT reputation_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4134 (class 2606 OID 17305)
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4167 (class 2606 OID 24397)
-- Name: votes votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4119 (class 2606 OID 16570)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4130 (class 2606 OID 17046)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4131 (class 2606 OID 17066)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4132 (class 2606 OID 17061)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4327 (class 0 OID 16523)
-- Dependencies: 349
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4341 (class 0 OID 16925)
-- Dependencies: 366
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4332 (class 0 OID 16723)
-- Dependencies: 357
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4326 (class 0 OID 16516)
-- Dependencies: 348
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4336 (class 0 OID 16812)
-- Dependencies: 361
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4335 (class 0 OID 16800)
-- Dependencies: 360
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4334 (class 0 OID 16787)
-- Dependencies: 359
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4342 (class 0 OID 16975)
-- Dependencies: 367
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4325 (class 0 OID 16505)
-- Dependencies: 347
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4339 (class 0 OID 16854)
-- Dependencies: 364
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4340 (class 0 OID 16872)
-- Dependencies: 365
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4328 (class 0 OID 16531)
-- Dependencies: 350
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4333 (class 0 OID 16753)
-- Dependencies: 358
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4338 (class 0 OID 16839)
-- Dependencies: 363
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4337 (class 0 OID 16830)
-- Dependencies: 362
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4324 (class 0 OID 16493)
-- Dependencies: 345
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4435 (class 3256 OID 23980)
-- Name: content_flags Admins can delete any flag; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete any flag" ON public.content_flags FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = 'admin'::public.app_role)))));


--
-- TOC entry 4366 (class 3256 OID 17497)
-- Name: user_roles Admins can insert roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can insert roles" ON public.user_roles FOR INSERT WITH CHECK (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- TOC entry 4418 (class 3256 OID 18815)
-- Name: chat_members Admins can remove members; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can remove members" ON public.chat_members FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.chat_members cm
  WHERE ((cm.chat_id = chat_members.chat_id) AND (cm.user_id = auth.uid()) AND (cm.is_admin = true)))));


--
-- TOC entry 4420 (class 3256 OID 18858)
-- Name: chat_members Admins can update admin status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update admin status" ON public.chat_members FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.chat_members cm
  WHERE ((cm.chat_id = chat_members.chat_id) AND (cm.user_id = auth.uid()) AND (cm.is_admin = true)))));


--
-- TOC entry 4436 (class 3256 OID 23958)
-- Name: content_flags Admins can update any flag; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update any flag" ON public.content_flags FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = 'admin'::public.app_role)))));


--
-- TOC entry 4437 (class 3256 OID 24002)
-- Name: profiles Admins can update any profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update any profile" ON public.profiles FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = 'admin'::public.app_role)))));


--
-- TOC entry 4419 (class 3256 OID 18836)
-- Name: chats Admins can update group info; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update group info" ON public.chats FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.chat_members
  WHERE ((chat_members.chat_id = chats.id) AND (chat_members.user_id = auth.uid()) AND (chat_members.is_admin = true)))));


--
-- TOC entry 4367 (class 3256 OID 17498)
-- Name: user_roles Admins can update roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update roles" ON public.user_roles FOR UPDATE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- TOC entry 4434 (class 3256 OID 23936)
-- Name: content_flags Admins can view all flags; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all flags" ON public.content_flags FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = 'admin'::public.app_role)))));


--
-- TOC entry 4365 (class 3256 OID 17496)
-- Name: user_roles Admins can view all roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all roles" ON public.user_roles FOR SELECT USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- TOC entry 4432 (class 3256 OID 23892)
-- Name: content_flags All users can view all flags; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "All users can view all flags" ON public.content_flags FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4431 (class 3256 OID 23774)
-- Name: user_roles Allow all users to read admin roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow all users to read admin roles" ON public.user_roles FOR SELECT USING (true);


--
-- TOC entry 4438 (class 3256 OID 24090)
-- Name: profiles Allow users to update their own last_seen; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow users to update their own last_seen" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 4439 (class 3256 OID 24091)
-- Name: chat_members Allow users to update their own typing status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow users to update their own typing status" ON public.chat_members FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4404 (class 3256 OID 18374)
-- Name: chat_members Anyone can add any user to chat; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can add any user to chat" ON public.chat_members FOR INSERT WITH CHECK (true);


--
-- TOC entry 4425 (class 3256 OID 20168)
-- Name: posts Authenticated users can delete own posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can delete own posts" ON public.posts FOR DELETE USING (((auth.role() = 'authenticated'::text) AND (user_id = auth.uid())));


--
-- TOC entry 4423 (class 3256 OID 20166)
-- Name: posts Authenticated users can insert posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can insert posts" ON public.posts FOR INSERT WITH CHECK (((auth.role() = 'authenticated'::text) AND (user_id = auth.uid())));


--
-- TOC entry 4424 (class 3256 OID 20167)
-- Name: posts Authenticated users can update own posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can update own posts" ON public.posts FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND (user_id = auth.uid())));


--
-- TOC entry 4413 (class 3256 OID 20121)
-- Name: posts Authenticated users can view posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can view posts" ON public.posts FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4388 (class 3256 OID 17818)
-- Name: profiles Public can view all profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can view all profiles" ON public.profiles FOR SELECT USING (true);


--
-- TOC entry 4412 (class 3256 OID 18705)
-- Name: filemodels Users can delete own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own files" ON public.filemodels FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4392 (class 3256 OID 17891)
-- Name: comments Users can delete their own comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own comments" ON public.comments FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4379 (class 3256 OID 17523)
-- Name: filemodels Users can delete their own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own files" ON public.filemodels FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4373 (class 3256 OID 17508)
-- Name: followers Users can delete their own follows; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own follows" ON public.followers FOR DELETE USING ((auth.uid() = follower_id));


--
-- TOC entry 4370 (class 3256 OID 17505)
-- Name: likes Users can delete their own likes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own likes" ON public.likes FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4403 (class 3256 OID 18351)
-- Name: chat_messages Users can delete their own messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own messages" ON public.chat_messages FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4384 (class 3256 OID 17527)
-- Name: questionanswers Users can delete their own questions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own questions" ON public.questionanswers FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4400 (class 3256 OID 18348)
-- Name: chat_members Users can delete themselves from chat; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete themselves from chat" ON public.chat_members FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4433 (class 3256 OID 23914)
-- Name: content_flags Users can flag posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can flag posts" ON public.content_flags FOR INSERT WITH CHECK ((auth.uid() = flagged_by_user_id));


--
-- TOC entry 4371 (class 3256 OID 17506)
-- Name: followers Users can follow/unfollow; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can follow/unfollow" ON public.followers FOR INSERT WITH CHECK ((auth.uid() = follower_id));


--
-- TOC entry 4386 (class 3256 OID 17529)
-- Name: qanotifications Users can insert Q&A notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert Q&A notifications" ON public.qanotifications FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4402 (class 3256 OID 18350)
-- Name: chat_messages Users can insert chat messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert chat messages" ON public.chat_messages FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4398 (class 3256 OID 18345)
-- Name: chats Users can insert chats; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert chats" ON public.chats FOR INSERT WITH CHECK (true);


--
-- TOC entry 4377 (class 3256 OID 17521)
-- Name: filemodels Users can insert files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert files" ON public.filemodels FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4381 (class 3256 OID 17510)
-- Name: notifications Users can insert notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert notifications" ON public.notifications FOR INSERT WITH CHECK (true);


--
-- TOC entry 4410 (class 3256 OID 18703)
-- Name: filemodels Users can insert own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert own files" ON public.filemodels FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4382 (class 3256 OID 17525)
-- Name: questionanswers Users can insert questions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert questions" ON public.questionanswers FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4389 (class 3256 OID 17888)
-- Name: comments Users can insert their own comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own comments" ON public.comments FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4363 (class 3256 OID 17494)
-- Name: profiles Users can insert their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- TOC entry 4368 (class 3256 OID 17503)
-- Name: likes Users can like posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can like posts" ON public.likes FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4393 (class 3256 OID 17956)
-- Name: comment_likes Users can like/unlike comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can like/unlike comments" ON public.comment_likes FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4394 (class 3256 OID 17957)
-- Name: comment_likes Users can unlike their own comment like; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can unlike their own comment like" ON public.comment_likes FOR DELETE USING ((auth.uid() = user_id));


--
-- TOC entry 4411 (class 3256 OID 18704)
-- Name: filemodels Users can update own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own files" ON public.filemodels FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4387 (class 3256 OID 17530)
-- Name: qanotifications Users can update their Q&A notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their Q&A notifications" ON public.qanotifications FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4375 (class 3256 OID 17511)
-- Name: notifications Users can update their notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their notifications" ON public.notifications FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4391 (class 3256 OID 17890)
-- Name: comments Users can update their own comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own comments" ON public.comments FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4378 (class 3256 OID 17522)
-- Name: filemodels Users can update their own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own files" ON public.filemodels FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4362 (class 3256 OID 17493)
-- Name: profiles Users can update their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 4383 (class 3256 OID 17526)
-- Name: questionanswers Users can update their own questions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own questions" ON public.questionanswers FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4395 (class 3256 OID 17958)
-- Name: comment_likes Users can view all comment likes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view all comment likes" ON public.comment_likes FOR SELECT USING (true);


--
-- TOC entry 4390 (class 3256 OID 17889)
-- Name: comments Users can view all comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view all comments" ON public.comments FOR SELECT USING (true);


--
-- TOC entry 4399 (class 3256 OID 18346)
-- Name: chat_members Users can view chat members; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view chat members" ON public.chat_members FOR SELECT USING (true);


--
-- TOC entry 4401 (class 3256 OID 18349)
-- Name: chat_messages Users can view chat messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view chat messages" ON public.chat_messages FOR SELECT USING (true);


--
-- TOC entry 4397 (class 3256 OID 18344)
-- Name: chats Users can view chats; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view chats" ON public.chats FOR SELECT USING (true);


--
-- TOC entry 4372 (class 3256 OID 17507)
-- Name: followers Users can view followers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view followers" ON public.followers FOR SELECT USING (true);


--
-- TOC entry 4369 (class 3256 OID 17504)
-- Name: likes Users can view likes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view likes" ON public.likes FOR SELECT USING (true);


--
-- TOC entry 4409 (class 3256 OID 18702)
-- Name: filemodels Users can view own and public files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own and public files" ON public.filemodels FOR SELECT USING (((auth.uid() = user_id) OR (is_public = true)));


--
-- TOC entry 4376 (class 3256 OID 17520)
-- Name: filemodels Users can view public files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view public files" ON public.filemodels FOR SELECT USING ((is_public OR (auth.uid() = user_id)));


--
-- TOC entry 4380 (class 3256 OID 17524)
-- Name: questionanswers Users can view questions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view questions" ON public.questionanswers FOR SELECT USING (true);


--
-- TOC entry 4385 (class 3256 OID 17528)
-- Name: qanotifications Users can view their Q&A notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their Q&A notifications" ON public.qanotifications FOR SELECT USING ((auth.uid() = user_id));


--
-- TOC entry 4374 (class 3256 OID 17509)
-- Name: notifications Users can view their notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their notifications" ON public.notifications FOR SELECT USING ((auth.uid() = user_id));


--
-- TOC entry 4361 (class 3256 OID 17492)
-- Name: profiles Users can view their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- TOC entry 4364 (class 3256 OID 17495)
-- Name: user_roles Users can view their own roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own roles" ON public.user_roles FOR SELECT USING ((auth.uid() = user_id));


--
-- TOC entry 4353 (class 0 OID 17394)
-- Dependencies: 385
-- Name: chat_members; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_members ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4354 (class 0 OID 17415)
-- Dependencies: 386
-- Name: chat_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4352 (class 0 OID 17384)
-- Dependencies: 384
-- Name: chats; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.chats ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4359 (class 0 OID 17914)
-- Dependencies: 394
-- Name: comment_likes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.comment_likes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4358 (class 0 OID 17846)
-- Dependencies: 393
-- Name: comments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4360 (class 0 OID 22168)
-- Dependencies: 397
-- Name: content_flags; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.content_flags ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4355 (class 0 OID 17435)
-- Dependencies: 387
-- Name: filemodels; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.filemodels ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4350 (class 0 OID 17347)
-- Dependencies: 382
-- Name: followers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.followers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4349 (class 0 OID 17327)
-- Dependencies: 381
-- Name: likes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.likes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4351 (class 0 OID 17368)
-- Dependencies: 383
-- Name: notifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4348 (class 0 OID 17310)
-- Dependencies: 380
-- Name: posts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4346 (class 0 OID 17281)
-- Dependencies: 378
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4357 (class 0 OID 17468)
-- Dependencies: 389
-- Name: qanotifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.qanotifications ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4356 (class 0 OID 17451)
-- Dependencies: 388
-- Name: questionanswers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.questionanswers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4347 (class 0 OID 17295)
-- Dependencies: 379
-- Name: user_roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4345 (class 0 OID 17251)
-- Dependencies: 376
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4414 (class 3256 OID 18780)
-- Name: objects Allow authenticated uploads; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated uploads" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'uploads'::text) AND (auth.role() = 'authenticated'::text)));


--
-- TOC entry 4396 (class 3256 OID 18902)
-- Name: objects Allow chat uploads for authenticated users; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow chat uploads for authenticated users" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'chat_uploads'::text) AND (auth.role() = 'authenticated'::text)));


--
-- TOC entry 4417 (class 3256 OID 18783)
-- Name: objects Allow file deletion; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow file deletion" ON storage.objects FOR DELETE USING (((bucket_id = 'uploads'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- TOC entry 4416 (class 3256 OID 18782)
-- Name: objects Allow file updates; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow file updates" ON storage.objects FOR UPDATE USING (((bucket_id = 'uploads'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- TOC entry 4415 (class 3256 OID 18781)
-- Name: objects Allow file viewing; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow file viewing" ON storage.objects FOR SELECT USING (((bucket_id = 'uploads'::text) AND (((auth.uid())::text = (storage.foldername(name))[1]) OR (EXISTS ( SELECT 1
   FROM public.filemodels
  WHERE ((filemodels.file_url ~~ (('%'::text || objects.name) || '%'::text)) AND (filemodels.is_public = true)))))));


--
-- TOC entry 4406 (class 3256 OID 18903)
-- Name: objects Allow read access to chat uploads; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow read access to chat uploads" ON storage.objects FOR SELECT USING ((bucket_id = 'chat_uploads'::text));


--
-- TOC entry 4405 (class 3256 OID 18904)
-- Name: objects Allow users to delete their own chat uploads; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow users to delete their own chat uploads" ON storage.objects FOR DELETE USING (((bucket_id = 'chat_uploads'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- TOC entry 4426 (class 3256 OID 20892)
-- Name: objects Anyone can view avatars; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Anyone can view avatars" ON storage.objects FOR SELECT USING ((bucket_id = 'avatars'::text));


--
-- TOC entry 4422 (class 3256 OID 20144)
-- Name: objects Authenticated users can delete their own files in post-media; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Authenticated users can delete their own files in post-media" ON storage.objects FOR DELETE USING (((bucket_id = 'post-media'::text) AND (auth.role() = 'authenticated'::text) AND (owner = auth.uid())));


--
-- TOC entry 4408 (class 3256 OID 20143)
-- Name: objects Authenticated users can update their own files in post-media; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Authenticated users can update their own files in post-media" ON storage.objects FOR UPDATE USING (((bucket_id = 'post-media'::text) AND (auth.role() = 'authenticated'::text) AND (owner = auth.uid())));


--
-- TOC entry 4407 (class 3256 OID 20142)
-- Name: objects Authenticated users can upload to post-media; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Authenticated users can upload to post-media" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'post-media'::text) AND (auth.role() = 'authenticated'::text)));


--
-- TOC entry 4421 (class 3256 OID 20052)
-- Name: objects Public read access to post-media; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Public read access to post-media" ON storage.objects FOR SELECT USING ((bucket_id = 'post-media'::text));


--
-- TOC entry 4430 (class 3256 OID 20982)
-- Name: objects Users can delete their own avatar; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can delete their own avatar" ON storage.objects FOR DELETE TO authenticated USING (((bucket_id = 'avatars'::text) AND (split_part(name, '/'::text, 1) = (auth.uid())::text)));


--
-- TOC entry 4428 (class 3256 OID 20936)
-- Name: objects Users can read their own avatar; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can read their own avatar" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'avatars'::text) AND (split_part(name, '/'::text, 1) = (auth.uid())::text)));


--
-- TOC entry 4429 (class 3256 OID 20958)
-- Name: objects Users can update their own avatar; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can update their own avatar" ON storage.objects FOR UPDATE TO authenticated USING (((bucket_id = 'avatars'::text) AND (split_part(name, '/'::text, 1) = (auth.uid())::text)));


--
-- TOC entry 4427 (class 3256 OID 20914)
-- Name: objects Users can upload their own avatar; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can upload their own avatar" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'avatars'::text) AND (split_part(name, '/'::text, 1) = (auth.uid())::text)));


--
-- TOC entry 4329 (class 0 OID 16544)
-- Dependencies: 351
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4331 (class 0 OID 16586)
-- Dependencies: 353
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4330 (class 0 OID 16559)
-- Dependencies: 352
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4343 (class 0 OID 17037)
-- Dependencies: 369
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4344 (class 0 OID 17051)
-- Dependencies: 370
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4440 (class 6104 OID 16426)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4441 (class 6104 OID 17594)
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- TOC entry 4452 (class 6106 OID 20784)
-- Name: supabase_realtime chat_members; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.chat_members;


--
-- TOC entry 4464 (class 6106 OID 20838)
-- Name: supabase_realtime_messages_publication chat_members; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.chat_members;


--
-- TOC entry 4449 (class 6106 OID 20781)
-- Name: supabase_realtime chat_messages; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.chat_messages;


--
-- TOC entry 4469 (class 6106 OID 20843)
-- Name: supabase_realtime_messages_publication chat_messages; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.chat_messages;


--
-- TOC entry 4445 (class 6106 OID 20777)
-- Name: supabase_realtime chats; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.chats;


--
-- TOC entry 4467 (class 6106 OID 20841)
-- Name: supabase_realtime_messages_publication chats; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.chats;


--
-- TOC entry 4453 (class 6106 OID 20785)
-- Name: supabase_realtime comment_likes; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.comment_likes;


--
-- TOC entry 4468 (class 6106 OID 20842)
-- Name: supabase_realtime_messages_publication comment_likes; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.comment_likes;


--
-- TOC entry 4448 (class 6106 OID 20780)
-- Name: supabase_realtime comments; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.comments;


--
-- TOC entry 4458 (class 6106 OID 20832)
-- Name: supabase_realtime_messages_publication comments; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.comments;


--
-- TOC entry 4454 (class 6106 OID 20786)
-- Name: supabase_realtime filemodels; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.filemodels;


--
-- TOC entry 4463 (class 6106 OID 20837)
-- Name: supabase_realtime_messages_publication filemodels; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.filemodels;


--
-- TOC entry 4444 (class 6106 OID 20776)
-- Name: supabase_realtime followers; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.followers;


--
-- TOC entry 4457 (class 6106 OID 20831)
-- Name: supabase_realtime_messages_publication followers; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.followers;


--
-- TOC entry 4455 (class 6106 OID 20787)
-- Name: supabase_realtime likes; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.likes;


--
-- TOC entry 4462 (class 6106 OID 20836)
-- Name: supabase_realtime_messages_publication likes; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.likes;


--
-- TOC entry 4451 (class 6106 OID 20783)
-- Name: supabase_realtime notifications; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.notifications;


--
-- TOC entry 4466 (class 6106 OID 20840)
-- Name: supabase_realtime_messages_publication notifications; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.notifications;


--
-- TOC entry 4443 (class 6106 OID 20775)
-- Name: supabase_realtime posts; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.posts;


--
-- TOC entry 4456 (class 6106 OID 20830)
-- Name: supabase_realtime_messages_publication posts; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.posts;


--
-- TOC entry 4447 (class 6106 OID 20779)
-- Name: supabase_realtime profiles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.profiles;


--
-- TOC entry 4461 (class 6106 OID 20835)
-- Name: supabase_realtime_messages_publication profiles; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.profiles;


--
-- TOC entry 4442 (class 6106 OID 20774)
-- Name: supabase_realtime qanotifications; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.qanotifications;


--
-- TOC entry 4465 (class 6106 OID 20839)
-- Name: supabase_realtime_messages_publication qanotifications; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.qanotifications;


--
-- TOC entry 4446 (class 6106 OID 20778)
-- Name: supabase_realtime questionanswers; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.questionanswers;


--
-- TOC entry 4460 (class 6106 OID 20834)
-- Name: supabase_realtime_messages_publication questionanswers; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.questionanswers;


--
-- TOC entry 4450 (class 6106 OID 20782)
-- Name: supabase_realtime user_roles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.user_roles;


--
-- TOC entry 4459 (class 6106 OID 20833)
-- Name: supabase_realtime_messages_publication user_roles; Type: PUBLICATION TABLE; Schema: public; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY public.user_roles;


--
-- TOC entry 4470 (class 6106 OID 20844)
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 4540
-- Name: DATABASE postgres; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE postgres TO dashboard_user;


--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 37
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 41
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4548 (class 0 OID 0)
-- Dependencies: 36
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4549 (class 0 OID 0)
-- Dependencies: 32
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4556 (class 0 OID 0)
-- Dependencies: 433
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4557 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4559 (class 0 OID 0)
-- Dependencies: 516
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4561 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4562 (class 0 OID 0)
-- Dependencies: 510
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4563 (class 0 OID 0)
-- Dependencies: 449
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4564 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4565 (class 0 OID 0)
-- Dependencies: 457
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4566 (class 0 OID 0)
-- Dependencies: 522
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4567 (class 0 OID 0)
-- Dependencies: 466
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4568 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4569 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4570 (class 0 OID 0)
-- Dependencies: 525
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4571 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4572 (class 0 OID 0)
-- Dependencies: 429
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4573 (class 0 OID 0)
-- Dependencies: 448
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4574 (class 0 OID 0)
-- Dependencies: 428
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4575 (class 0 OID 0)
-- Dependencies: 474
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4577 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4579 (class 0 OID 0)
-- Dependencies: 518
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4581 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4582 (class 0 OID 0)
-- Dependencies: 495
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4583 (class 0 OID 0)
-- Dependencies: 479
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4584 (class 0 OID 0)
-- Dependencies: 487
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4585 (class 0 OID 0)
-- Dependencies: 520
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4586 (class 0 OID 0)
-- Dependencies: 482
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- TOC entry 4587 (class 0 OID 0)
-- Dependencies: 485
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4588 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4589 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4590 (class 0 OID 0)
-- Dependencies: 500
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4591 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4592 (class 0 OID 0)
-- Dependencies: 497
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4593 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4594 (class 0 OID 0)
-- Dependencies: 514
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4595 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4596 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4597 (class 0 OID 0)
-- Dependencies: 498
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4598 (class 0 OID 0)
-- Dependencies: 443
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4599 (class 0 OID 0)
-- Dependencies: 460
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4600 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4601 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4602 (class 0 OID 0)
-- Dependencies: 502
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4603 (class 0 OID 0)
-- Dependencies: 483
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4604 (class 0 OID 0)
-- Dependencies: 524
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4605 (class 0 OID 0)
-- Dependencies: 422
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4606 (class 0 OID 0)
-- Dependencies: 432
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4607 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4608 (class 0 OID 0)
-- Dependencies: 464
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4610 (class 0 OID 0)
-- Dependencies: 463
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4611 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4612 (class 0 OID 0)
-- Dependencies: 476
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4613 (class 0 OID 0)
-- Dependencies: 455
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4614 (class 0 OID 0)
-- Dependencies: 491
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4615 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4616 (class 0 OID 0)
-- Dependencies: 481
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4617 (class 0 OID 0)
-- Dependencies: 505
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4618 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4619 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4620 (class 0 OID 0)
-- Dependencies: 469
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4621 (class 0 OID 0)
-- Dependencies: 490
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4622 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 4623 (class 0 OID 0)
-- Dependencies: 472
-- Name: FUNCTION handle_file_deletion(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_file_deletion() TO anon;
GRANT ALL ON FUNCTION public.handle_file_deletion() TO authenticated;
GRANT ALL ON FUNCTION public.handle_file_deletion() TO service_role;


--
-- TOC entry 4624 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION handle_file_update(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_file_update() TO anon;
GRANT ALL ON FUNCTION public.handle_file_update() TO authenticated;
GRANT ALL ON FUNCTION public.handle_file_update() TO service_role;


--
-- TOC entry 4625 (class 0 OID 0)
-- Dependencies: 465
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- TOC entry 4626 (class 0 OID 0)
-- Dependencies: 493
-- Name: FUNCTION has_role(_user_id uuid, _role public.app_role); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.has_role(_user_id uuid, _role public.app_role) TO anon;
GRANT ALL ON FUNCTION public.has_role(_user_id uuid, _role public.app_role) TO authenticated;
GRANT ALL ON FUNCTION public.has_role(_user_id uuid, _role public.app_role) TO service_role;


--
-- TOC entry 4627 (class 0 OID 0)
-- Dependencies: 513
-- Name: FUNCTION leave_group(p_chat_id uuid, p_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.leave_group(p_chat_id uuid, p_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.leave_group(p_chat_id uuid, p_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.leave_group(p_chat_id uuid, p_user_id uuid) TO service_role;


--
-- TOC entry 4628 (class 0 OID 0)
-- Dependencies: 489
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4629 (class 0 OID 0)
-- Dependencies: 521
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4630 (class 0 OID 0)
-- Dependencies: 517
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4631 (class 0 OID 0)
-- Dependencies: 519
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 511
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 467
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 430
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 503
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 494
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 501
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 348
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 367
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4662 (class 0 OID 0)
-- Dependencies: 346
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4664 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4666 (class 0 OID 0)
-- Dependencies: 365
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4668 (class 0 OID 0)
-- Dependencies: 350
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4671 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4673 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4676 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4679 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4680 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 400
-- Name: TABLE answer_comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.answer_comments TO anon;
GRANT ALL ON TABLE public.answer_comments TO authenticated;
GRANT ALL ON TABLE public.answer_comments TO service_role;


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 399
-- Name: TABLE answer_votes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.answer_votes TO anon;
GRANT ALL ON TABLE public.answer_votes TO authenticated;
GRANT ALL ON TABLE public.answer_votes TO service_role;


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 407
-- Name: TABLE answers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.answers TO anon;
GRANT ALL ON TABLE public.answers TO authenticated;
GRANT ALL ON TABLE public.answers TO service_role;


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 406
-- Name: SEQUENCE answers_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.answers_id_seq TO anon;
GRANT ALL ON SEQUENCE public.answers_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.answers_id_seq TO service_role;


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 385
-- Name: TABLE chat_members; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.chat_members TO anon;
GRANT ALL ON TABLE public.chat_members TO authenticated;
GRANT ALL ON TABLE public.chat_members TO service_role;


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 386
-- Name: TABLE chat_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.chat_messages TO anon;
GRANT ALL ON TABLE public.chat_messages TO authenticated;
GRANT ALL ON TABLE public.chat_messages TO service_role;


--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 384
-- Name: TABLE chats; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.chats TO anon;
GRANT ALL ON TABLE public.chats TO authenticated;
GRANT ALL ON TABLE public.chats TO service_role;


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 394
-- Name: TABLE comment_likes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.comment_likes TO anon;
GRANT ALL ON TABLE public.comment_likes TO authenticated;
GRANT ALL ON TABLE public.comment_likes TO service_role;


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 393
-- Name: TABLE comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.comments TO anon;
GRANT ALL ON TABLE public.comments TO authenticated;
GRANT ALL ON TABLE public.comments TO service_role;


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 397
-- Name: TABLE content_flags; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.content_flags TO anon;
GRANT ALL ON TABLE public.content_flags TO authenticated;
GRANT ALL ON TABLE public.content_flags TO service_role;


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 387
-- Name: TABLE filemodels; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.filemodels TO anon;
GRANT ALL ON TABLE public.filemodels TO authenticated;
GRANT ALL ON TABLE public.filemodels TO service_role;


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 382
-- Name: TABLE followers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.followers TO anon;
GRANT ALL ON TABLE public.followers TO authenticated;
GRANT ALL ON TABLE public.followers TO service_role;


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 381
-- Name: TABLE likes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.likes TO anon;
GRANT ALL ON TABLE public.likes TO authenticated;
GRANT ALL ON TABLE public.likes TO service_role;


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 383
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.notifications TO anon;
GRANT ALL ON TABLE public.notifications TO authenticated;
GRANT ALL ON TABLE public.notifications TO service_role;


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 380
-- Name: TABLE posts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.posts TO anon;
GRANT ALL ON TABLE public.posts TO authenticated;
GRANT ALL ON TABLE public.posts TO service_role;


--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 378
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- TOC entry 4699 (class 0 OID 0)
-- Dependencies: 389
-- Name: TABLE qanotifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.qanotifications TO anon;
GRANT ALL ON TABLE public.qanotifications TO authenticated;
GRANT ALL ON TABLE public.qanotifications TO service_role;


--
-- TOC entry 4700 (class 0 OID 0)
-- Dependencies: 414
-- Name: TABLE question_tags; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.question_tags TO anon;
GRANT ALL ON TABLE public.question_tags TO authenticated;
GRANT ALL ON TABLE public.question_tags TO service_role;


--
-- TOC entry 4701 (class 0 OID 0)
-- Dependencies: 402
-- Name: TABLE question_votes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.question_votes TO anon;
GRANT ALL ON TABLE public.question_votes TO authenticated;
GRANT ALL ON TABLE public.question_votes TO service_role;


--
-- TOC entry 4703 (class 0 OID 0)
-- Dependencies: 401
-- Name: SEQUENCE question_votes_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.question_votes_id_seq TO anon;
GRANT ALL ON SEQUENCE public.question_votes_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.question_votes_id_seq TO service_role;


--
-- TOC entry 4704 (class 0 OID 0)
-- Dependencies: 388
-- Name: TABLE questionanswers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.questionanswers TO anon;
GRANT ALL ON TABLE public.questionanswers TO authenticated;
GRANT ALL ON TABLE public.questionanswers TO service_role;


--
-- TOC entry 4705 (class 0 OID 0)
-- Dependencies: 405
-- Name: TABLE questions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.questions TO anon;
GRANT ALL ON TABLE public.questions TO authenticated;
GRANT ALL ON TABLE public.questions TO service_role;


--
-- TOC entry 4707 (class 0 OID 0)
-- Dependencies: 404
-- Name: SEQUENCE questions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.questions_id_seq TO anon;
GRANT ALL ON SEQUENCE public.questions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.questions_id_seq TO service_role;


--
-- TOC entry 4708 (class 0 OID 0)
-- Dependencies: 413
-- Name: TABLE reputation_events; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reputation_events TO anon;
GRANT ALL ON TABLE public.reputation_events TO authenticated;
GRANT ALL ON TABLE public.reputation_events TO service_role;


--
-- TOC entry 4710 (class 0 OID 0)
-- Dependencies: 412
-- Name: SEQUENCE reputation_events_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.reputation_events_id_seq TO anon;
GRANT ALL ON SEQUENCE public.reputation_events_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.reputation_events_id_seq TO service_role;


--
-- TOC entry 4711 (class 0 OID 0)
-- Dependencies: 411
-- Name: TABLE tags; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tags TO anon;
GRANT ALL ON TABLE public.tags TO authenticated;
GRANT ALL ON TABLE public.tags TO service_role;


--
-- TOC entry 4713 (class 0 OID 0)
-- Dependencies: 410
-- Name: SEQUENCE tags_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tags_id_seq TO anon;
GRANT ALL ON SEQUENCE public.tags_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.tags_id_seq TO service_role;


--
-- TOC entry 4714 (class 0 OID 0)
-- Dependencies: 379
-- Name: TABLE user_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_roles TO anon;
GRANT ALL ON TABLE public.user_roles TO authenticated;
GRANT ALL ON TABLE public.user_roles TO service_role;


--
-- TOC entry 4715 (class 0 OID 0)
-- Dependencies: 409
-- Name: TABLE votes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.votes TO anon;
GRANT ALL ON TABLE public.votes TO authenticated;
GRANT ALL ON TABLE public.votes TO service_role;


--
-- TOC entry 4717 (class 0 OID 0)
-- Dependencies: 408
-- Name: SEQUENCE votes_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.votes_id_seq TO anon;
GRANT ALL ON SEQUENCE public.votes_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.votes_id_seq TO service_role;


--
-- TOC entry 4718 (class 0 OID 0)
-- Dependencies: 376
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4719 (class 0 OID 0)
-- Dependencies: 391
-- Name: TABLE messages_2025_07_01; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_01 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_01 TO dashboard_user;


--
-- TOC entry 4720 (class 0 OID 0)
-- Dependencies: 392
-- Name: TABLE messages_2025_07_02; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_02 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_02 TO dashboard_user;


--
-- TOC entry 4721 (class 0 OID 0)
-- Dependencies: 395
-- Name: TABLE messages_2025_07_03; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_03 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_03 TO dashboard_user;


--
-- TOC entry 4722 (class 0 OID 0)
-- Dependencies: 396
-- Name: TABLE messages_2025_07_04; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_04 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_04 TO dashboard_user;


--
-- TOC entry 4723 (class 0 OID 0)
-- Dependencies: 398
-- Name: TABLE messages_2025_07_05; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_05 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_05 TO dashboard_user;


--
-- TOC entry 4724 (class 0 OID 0)
-- Dependencies: 403
-- Name: TABLE messages_2025_07_06; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_06 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_06 TO dashboard_user;


--
-- TOC entry 4725 (class 0 OID 0)
-- Dependencies: 415
-- Name: TABLE messages_2025_07_07; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_07 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_07 TO dashboard_user;


--
-- TOC entry 4726 (class 0 OID 0)
-- Dependencies: 368
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4727 (class 0 OID 0)
-- Dependencies: 373
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4728 (class 0 OID 0)
-- Dependencies: 372
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4730 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- TOC entry 4732 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- TOC entry 4733 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4734 (class 0 OID 0)
-- Dependencies: 370
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4735 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 4736 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2562 (class 826 OID 16601)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2563 (class 826 OID 16602)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2561 (class 826 OID 16600)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2572 (class 826 OID 16680)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2571 (class 826 OID 16679)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2570 (class 826 OID 16678)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2575 (class 826 OID 16635)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2574 (class 826 OID 16634)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2573 (class 826 OID 16633)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2567 (class 826 OID 16615)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2569 (class 826 OID 16614)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2568 (class 826 OID 16613)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2554 (class 826 OID 16488)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2555 (class 826 OID 16489)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2553 (class 826 OID 16487)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2557 (class 826 OID 16491)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2552 (class 826 OID 16486)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2556 (class 826 OID 16490)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2565 (class 826 OID 16605)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2566 (class 826 OID 16606)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2564 (class 826 OID 16604)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2560 (class 826 OID 16543)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2559 (class 826 OID 16542)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2558 (class 826 OID 16541)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 3742 (class 3466 OID 16619)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 3747 (class 3466 OID 16698)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 3741 (class 3466 OID 16617)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 3748 (class 3466 OID 16701)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 3743 (class 3466 OID 16620)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 3744 (class 3466 OID 16621)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2025-07-04 18:41:29 IST

--
-- PostgreSQL database dump complete
--

