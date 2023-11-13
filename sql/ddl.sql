-- Table: public.technology

CREATE TABLE IF NOT EXISTS public.technology
(
    id serial NOT NULL,
    name character varying(255)[] NOT NULL,
    icon text,
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.technology
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public.technology
    IS 'It holds all the technologies that are listed in page contents page';


-- Table: public.user

CREATE TABLE IF NOT EXISTS public."user"
(
    id integer NOT NULL DEFAULT nextval('user_id_seq'::regclass),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone,
    is_active boolean DEFAULT true,
    name character varying(255)[] COLLATE pg_catalog."default",
    picture text COLLATE pg_catalog."default",
    bio text COLLATE pg_catalog."default",
    city character varying(255)[] COLLATE pg_catalog."default",
    website text COLLATE pg_catalog."default",
    CONSTRAINT user_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."user"
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public."user"
    IS 'It holds all the information related to an user';


-- Table: public.user_technology

CREATE TABLE IF NOT EXISTS public.user_technology
(
    id serial NOT NULL,
    user_id serial,
    technology_id serial,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (technology_id)
        REFERENCES public.technology (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.user_technology
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public.user_technology
    IS 'Links users and the technologies they chose';


-- Table: public.platform

CREATE TABLE IF NOT EXISTS public.platform
(
    id integer NOT NULL DEFAULT nextval('platform_id_seq'::regclass),
    name character varying(255)[] COLLATE pg_catalog."default" NOT NULL,
    icon text COLLATE pg_catalog."default",
    is_active boolean DEFAULT true,
    homepage_url text COLLATE pg_catalog."default",
    CONSTRAINT platform_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.platform
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public.platform
    IS 'It holds details of all the platforms that we support';


-- Table: public.social_account

CREATE TABLE IF NOT EXISTS public.social_account
(
    id integer NOT NULL DEFAULT nextval('social_account_id_seq'::regclass),
    user_id integer NOT NULL DEFAULT nextval('social_account_user_id_seq'::regclass),
    platform_id integer NOT NULL DEFAULT nextval('social_account_platform_id_seq'::regclass),
    platform_account_id character varying(255)[] COLLATE pg_catalog."default" NOT NULL,
    is_active boolean,
    CONSTRAINT social_account_pkey PRIMARY KEY (id),
    CONSTRAINT social_account_platform_id_fkey FOREIGN KEY (platform_id)
        REFERENCES public.platform (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT social_account_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.social_account
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public.social_account
    IS 'It holds details of all the social accounts details that users linked';


-- Table: public.card

CREATE TABLE IF NOT EXISTS public.card
(
    id integer NOT NULL DEFAULT nextval('card_id_seq'::regclass),
    platform_id integer NOT NULL DEFAULT nextval('card_platform_id_seq'::regclass),
    is_active boolean,
    CONSTRAINT card_pkey PRIMARY KEY (id),
    CONSTRAINT card_platform_id_fkey FOREIGN KEY (platform_id)
        REFERENCES public.platform (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.card
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public.card
    IS 'It holds all possible cards that we allow our users to display in their page';


-- Table: public.page

CREATE TABLE IF NOT EXISTS public.page
(
    id integer NOT NULL DEFAULT nextval('page_id_seq'::regclass),
    user_id integer NOT NULL DEFAULT nextval('page_user_id_seq'::regclass),
    inspired_by integer NOT NULL DEFAULT nextval('page_inspired_by_seq'::regclass),
    views numeric DEFAULT 0,
    likes numeric DEFAULT 0,
    CONSTRAINT page_pkey PRIMARY KEY (id),
    CONSTRAINT page_inspired_by_fkey FOREIGN KEY (inspired_by)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT page_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.page
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public.page
    IS 'It holds all the information related to an user''s page';


-- Table: public.user_card

CREATE TABLE IF NOT EXISTS public.user_card
(
    id integer NOT NULL DEFAULT nextval('user_card_id_seq'::regclass),
    user_id integer NOT NULL DEFAULT nextval('user_card_user_id_seq'::regclass),
    card_id integer NOT NULL DEFAULT nextval('user_card_card_id_seq'::regclass),
    is_active boolean DEFAULT true,
    CONSTRAINT user_card_pkey PRIMARY KEY (id),
    CONSTRAINT user_card_card_id_fkey FOREIGN KEY (card_id)
        REFERENCES public.card (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_card_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_card
    OWNER to "devprofilepage-backend";

COMMENT ON TABLE public.user_card
    IS 'It links user with cards that they selected';