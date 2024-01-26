--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5 (Ubuntu 15.5-0ubuntu0.23.10.1)
-- Dumped by pg_dump version 15.5 (Ubuntu 15.5-0ubuntu0.23.10.1)

-- Started on 2024-01-27 00:12:23 IST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS "devprofilepage-backend";
--
-- TOC entry 3475 (class 1262 OID 16389)
-- Name: devprofilepage-backend; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "devprofilepage-backend" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_IN';


ALTER DATABASE "devprofilepage-backend" OWNER TO postgres;

\connect -reuse-previous=on "dbname='devprofilepage-backend'"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16465)
-- Name: card; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public.card (
    id integer NOT NULL,
    platform_id integer NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE public.card OWNER TO "devprofilepage-backend";

--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE card; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public.card IS 'It holds all possible cards that we allow our users to display in their page';


--
-- TOC entry 228 (class 1259 OID 16463)
-- Name: card_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.card_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 228
-- Name: card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.card_id_seq OWNED BY public.card.id;


--
-- TOC entry 229 (class 1259 OID 16464)
-- Name: card_platform_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.card_platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.card_platform_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 229
-- Name: card_platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.card_platform_id_seq OWNED BY public.card.platform_id;


--
-- TOC entry 234 (class 1259 OID 16480)
-- Name: page; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public.page (
    id integer NOT NULL,
    user_id integer NOT NULL,
    inspired_by integer NOT NULL,
    views numeric DEFAULT 0,
    likes numeric DEFAULT 0,
    name character varying(255),
    picture text,
    bio text,
    website character varying(255),
    city character varying(255)
);


ALTER TABLE public.page OWNER TO "devprofilepage-backend";

--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE page; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public.page IS 'It holds all the information related to an user''s page';


--
-- TOC entry 238 (class 1259 OID 16505)
-- Name: page_card; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public.page_card (
    id integer NOT NULL,
    page_id integer NOT NULL,
    card_id integer NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE public.page_card OWNER TO "devprofilepage-backend";

--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE page_card; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public.page_card IS 'It links user with cards that they selected';


--
-- TOC entry 231 (class 1259 OID 16477)
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 231
-- Name: page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;


--
-- TOC entry 233 (class 1259 OID 16479)
-- Name: page_inspired_by_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.page_inspired_by_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_inspired_by_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 233
-- Name: page_inspired_by_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.page_inspired_by_seq OWNED BY public.page.inspired_by;


--
-- TOC entry 221 (class 1259 OID 16412)
-- Name: page_technology; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public.page_technology (
    id integer NOT NULL,
    page_id integer NOT NULL,
    technology_id integer NOT NULL
);


ALTER TABLE public.page_technology OWNER TO "devprofilepage-backend";

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE page_technology; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public.page_technology IS 'Links users and the technologies they chose';


--
-- TOC entry 232 (class 1259 OID 16478)
-- Name: page_user_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.page_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_user_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 232
-- Name: page_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.page_user_id_seq OWNED BY public.page.user_id;


--
-- TOC entry 223 (class 1259 OID 16431)
-- Name: platform; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public.platform (
    id integer NOT NULL,
    icon text,
    is_active boolean DEFAULT true,
    homepage_url text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.platform OWNER TO "devprofilepage-backend";

--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE platform; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public.platform IS 'It holds details of all the platforms that we support';


--
-- TOC entry 222 (class 1259 OID 16430)
-- Name: platform_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.platform_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 222
-- Name: platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.platform_id_seq OWNED BY public.platform.id;


--
-- TOC entry 227 (class 1259 OID 16443)
-- Name: social_account; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public.social_account (
    id integer NOT NULL,
    user_id integer NOT NULL,
    platform_id integer NOT NULL,
    is_active boolean DEFAULT true,
    platform_account_id character varying(255) NOT NULL,
    name character varying(255),
    bio text,
    picture text,
    website character varying(255),
    city character varying(255)
);


ALTER TABLE public.social_account OWNER TO "devprofilepage-backend";

--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE social_account; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public.social_account IS 'It holds details of all the social accounts details that users linked';


--
-- TOC entry 224 (class 1259 OID 16440)
-- Name: social_account_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.social_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_account_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 224
-- Name: social_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.social_account_id_seq OWNED BY public.social_account.id;


--
-- TOC entry 226 (class 1259 OID 16442)
-- Name: social_account_platform_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.social_account_platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_account_platform_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 226
-- Name: social_account_platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.social_account_platform_id_seq OWNED BY public.social_account.platform_id;


--
-- TOC entry 225 (class 1259 OID 16441)
-- Name: social_account_user_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.social_account_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_account_user_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 225
-- Name: social_account_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.social_account_user_id_seq OWNED BY public.social_account.user_id;


--
-- TOC entry 215 (class 1259 OID 16391)
-- Name: technology; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public.technology (
    id integer NOT NULL,
    icon text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.technology OWNER TO "devprofilepage-backend";

--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE technology; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public.technology IS 'It holds all the technologies that are listed in page contents page';


--
-- TOC entry 214 (class 1259 OID 16390)
-- Name: technology_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.technology_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technology_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 214
-- Name: technology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.technology_id_seq OWNED BY public.technology.id;


--
-- TOC entry 217 (class 1259 OID 16400)
-- Name: user; Type: TABLE; Schema: public; Owner: devprofilepage-backend
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    is_active boolean DEFAULT true,
    picture text,
    bio text,
    website text,
    name character varying(255),
    city character varying(255)
);


ALTER TABLE public."user" OWNER TO "devprofilepage-backend";

--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE "user"; Type: COMMENT; Schema: public; Owner: devprofilepage-backend
--

COMMENT ON TABLE public."user" IS 'It holds all the information related to an user';


--
-- TOC entry 237 (class 1259 OID 16504)
-- Name: user_card_card_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.user_card_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_card_card_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 237
-- Name: user_card_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.user_card_card_id_seq OWNED BY public.page_card.card_id;


--
-- TOC entry 235 (class 1259 OID 16502)
-- Name: user_card_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.user_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_card_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 235
-- Name: user_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.user_card_id_seq OWNED BY public.page_card.id;


--
-- TOC entry 236 (class 1259 OID 16503)
-- Name: user_card_user_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.user_card_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_card_user_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 236
-- Name: user_card_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.user_card_user_id_seq OWNED BY public.page_card.page_id;


--
-- TOC entry 216 (class 1259 OID 16399)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 216
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 218 (class 1259 OID 16409)
-- Name: user_technology_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.user_technology_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_technology_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_technology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.user_technology_id_seq OWNED BY public.page_technology.id;


--
-- TOC entry 220 (class 1259 OID 16411)
-- Name: user_technology_technology_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.user_technology_technology_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_technology_technology_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_technology_technology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.user_technology_technology_id_seq OWNED BY public.page_technology.technology_id;


--
-- TOC entry 219 (class 1259 OID 16410)
-- Name: user_technology_user_id_seq; Type: SEQUENCE; Schema: public; Owner: devprofilepage-backend
--

CREATE SEQUENCE public.user_technology_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_technology_user_id_seq OWNER TO "devprofilepage-backend";

--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_technology_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devprofilepage-backend
--

ALTER SEQUENCE public.user_technology_user_id_seq OWNED BY public.page_technology.page_id;


--
-- TOC entry 3291 (class 2604 OID 16468)
-- Name: card id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.card ALTER COLUMN id SET DEFAULT nextval('public.card_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 16469)
-- Name: card platform_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.card ALTER COLUMN platform_id SET DEFAULT nextval('public.card_platform_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 16483)
-- Name: page id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);


--
-- TOC entry 3295 (class 2604 OID 16484)
-- Name: page user_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page ALTER COLUMN user_id SET DEFAULT nextval('public.page_user_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 16485)
-- Name: page inspired_by; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page ALTER COLUMN inspired_by SET DEFAULT nextval('public.page_inspired_by_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 16508)
-- Name: page_card id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_card ALTER COLUMN id SET DEFAULT nextval('public.user_card_id_seq'::regclass);


--
-- TOC entry 3300 (class 2604 OID 16509)
-- Name: page_card page_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_card ALTER COLUMN page_id SET DEFAULT nextval('public.user_card_user_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16510)
-- Name: page_card card_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_card ALTER COLUMN card_id SET DEFAULT nextval('public.user_card_card_id_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 16415)
-- Name: page_technology id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_technology ALTER COLUMN id SET DEFAULT nextval('public.user_technology_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 16416)
-- Name: page_technology page_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_technology ALTER COLUMN page_id SET DEFAULT nextval('public.user_technology_user_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 16417)
-- Name: page_technology technology_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_technology ALTER COLUMN technology_id SET DEFAULT nextval('public.user_technology_technology_id_seq'::regclass);


--
-- TOC entry 3285 (class 2604 OID 16434)
-- Name: platform id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.platform ALTER COLUMN id SET DEFAULT nextval('public.platform_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 16446)
-- Name: social_account id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.social_account ALTER COLUMN id SET DEFAULT nextval('public.social_account_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 16447)
-- Name: social_account user_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.social_account ALTER COLUMN user_id SET DEFAULT nextval('public.social_account_user_id_seq'::regclass);


--
-- TOC entry 3289 (class 2604 OID 16448)
-- Name: social_account platform_id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.social_account ALTER COLUMN platform_id SET DEFAULT nextval('public.social_account_platform_id_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 16394)
-- Name: technology id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.technology ALTER COLUMN id SET DEFAULT nextval('public.technology_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 16403)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3314 (class 2606 OID 16471)
-- Name: card card_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 16491)
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- TOC entry 3308 (class 2606 OID 16544)
-- Name: page_technology page_technology_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_technology
    ADD CONSTRAINT page_technology_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 16439)
-- Name: platform platform_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 16452)
-- Name: social_account social_account_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.social_account
    ADD CONSTRAINT social_account_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 16398)
-- Name: technology technology_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.technology
    ADD CONSTRAINT technology_pkey PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 16513)
-- Name: page_card user_card_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_card
    ADD CONSTRAINT user_card_pkey PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 16408)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 16472)
-- Name: card card_platform_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_platform_id_fkey FOREIGN KEY (platform_id) REFERENCES public.platform(id);


--
-- TOC entry 3326 (class 2606 OID 16545)
-- Name: page_card page_card_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_card
    ADD CONSTRAINT page_card_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.page(id) NOT VALID;


--
-- TOC entry 3324 (class 2606 OID 16497)
-- Name: page page_inspired_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_inspired_by_fkey FOREIGN KEY (inspired_by) REFERENCES public."user"(id);


--
-- TOC entry 3319 (class 2606 OID 16538)
-- Name: page_technology page_technology_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_technology
    ADD CONSTRAINT page_technology_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.page(id) NOT VALID;


--
-- TOC entry 3325 (class 2606 OID 16492)
-- Name: page page_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 3321 (class 2606 OID 16458)
-- Name: social_account social_account_platform_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.social_account
    ADD CONSTRAINT social_account_platform_id_fkey FOREIGN KEY (platform_id) REFERENCES public.platform(id);


--
-- TOC entry 3322 (class 2606 OID 16453)
-- Name: social_account social_account_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.social_account
    ADD CONSTRAINT social_account_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 3327 (class 2606 OID 16519)
-- Name: page_card user_card_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_card
    ADD CONSTRAINT user_card_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.card(id);


--
-- TOC entry 3320 (class 2606 OID 16425)
-- Name: page_technology user_technology_technology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devprofilepage-backend
--

ALTER TABLE ONLY public.page_technology
    ADD CONSTRAINT user_technology_technology_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technology(id);


-- Completed on 2024-01-27 00:12:23 IST

--
-- PostgreSQL database dump complete
--

