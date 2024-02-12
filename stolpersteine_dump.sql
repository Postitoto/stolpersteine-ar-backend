--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-2.pgdg22.04+1)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: thotor
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO thotor;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_customfiles; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_customfiles (
    id bigint NOT NULL,
    photo_name text,
    photo text,
    audio_name text,
    stolperstein_id bigint,
    audio text,
    video character varying(100),
    video_name character varying(100)
);


ALTER TABLE public.api_customfiles OWNER TO thotor;

--
-- Name: api_customfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_customfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_customfiles_id_seq OWNER TO thotor;

--
-- Name: api_customfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_customfiles_id_seq OWNED BY public.api_customfiles.id;


--
-- Name: api_lifestation; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_lifestation (
    id bigint NOT NULL,
    coordinates text,
    name text,
    text text,
    stolperstein_id bigint
);


ALTER TABLE public.api_lifestation OWNER TO thotor;

--
-- Name: api_lifestation_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_lifestation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_lifestation_id_seq OWNER TO thotor;

--
-- Name: api_lifestation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_lifestation_id_seq OWNED BY public.api_lifestation.id;


--
-- Name: api_location; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_location (
    id bigint NOT NULL,
    coordinates text,
    name text
);


ALTER TABLE public.api_location OWNER TO thotor;

--
-- Name: api_location_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_location_id_seq OWNER TO thotor;

--
-- Name: api_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_location_id_seq OWNED BY public.api_location.id;


--
-- Name: api_location_responsible_users; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_location_responsible_users (
    id bigint NOT NULL,
    location_id bigint,
    user_id bigint
);


ALTER TABLE public.api_location_responsible_users OWNER TO thotor;

--
-- Name: api_location_responsible_users_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_location_responsible_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_location_responsible_users_id_seq OWNER TO thotor;

--
-- Name: api_location_responsible_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_location_responsible_users_id_seq OWNED BY public.api_location_responsible_users.id;


--
-- Name: api_locationreference; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_locationreference (
    id bigint NOT NULL,
    coordinates text,
    name text
);


ALTER TABLE public.api_locationreference OWNER TO thotor;

--
-- Name: api_locationreference_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_locationreference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_locationreference_id_seq OWNER TO thotor;

--
-- Name: api_locationreference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_locationreference_id_seq OWNED BY public.api_locationreference.id;


--
-- Name: api_locationreference_responsible_users; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_locationreference_responsible_users (
    id bigint NOT NULL,
    locationreference_id bigint,
    user_id bigint
);


ALTER TABLE public.api_locationreference_responsible_users OWNER TO thotor;

--
-- Name: api_locationreference_responsible_users_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_locationreference_responsible_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_locationreference_responsible_users_id_seq OWNER TO thotor;

--
-- Name: api_locationreference_responsible_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_locationreference_responsible_users_id_seq OWNED BY public.api_locationreference_responsible_users.id;


--
-- Name: api_order; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_order (
    id bigint NOT NULL,
    location_id bigint,
    stolperstein_id bigint,
    "position" bigint
);


ALTER TABLE public.api_order OWNER TO thotor;

--
-- Name: api_order_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_order_id_seq OWNER TO thotor;

--
-- Name: api_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_order_id_seq OWNED BY public.api_order.id;


--
-- Name: api_stolperstein; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_stolperstein (
    id bigint NOT NULL,
    name text,
    birthdate date,
    deathdate date,
    birthplace text,
    deathplace text,
    reason_for_persecution text,
    info_text text,
    location_id bigint,
    family_text text
);


ALTER TABLE public.api_stolperstein OWNER TO thotor;

--
-- Name: api_stolperstein_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_stolperstein_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_stolperstein_id_seq OWNER TO thotor;

--
-- Name: api_stolperstein_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_stolperstein_id_seq OWNED BY public.api_stolperstein.id;


--
-- Name: api_stolpersteinrelation; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_stolpersteinrelation (
    id bigint NOT NULL,
    text text,
    related_stolperstein_id bigint,
    stolperstein_id bigint,
    type text
);


ALTER TABLE public.api_stolpersteinrelation OWNER TO thotor;

--
-- Name: api_stolpersteinrelation_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_stolpersteinrelation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_stolpersteinrelation_id_seq OWNER TO thotor;

--
-- Name: api_stolpersteinrelation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_stolpersteinrelation_id_seq OWNED BY public.api_stolpersteinrelation.id;


--
-- Name: api_textbox; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.api_textbox (
    id bigint NOT NULL,
    title text,
    content text,
    stolperstein_id bigint
);


ALTER TABLE public.api_textbox OWNER TO thotor;

--
-- Name: api_textbox_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.api_textbox_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_textbox_id_seq OWNER TO thotor;

--
-- Name: api_textbox_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.api_textbox_id_seq OWNED BY public.api_textbox.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.auth_group (
    id bigint NOT NULL,
    name text
);


ALTER TABLE public.auth_group OWNER TO thotor;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO thotor;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id bigint,
    permission_id bigint
);


ALTER TABLE public.auth_group_permissions OWNER TO thotor;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO thotor;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.auth_permission (
    id bigint NOT NULL,
    content_type_id bigint,
    codename text,
    name text
);


ALTER TABLE public.auth_permission OWNER TO thotor;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO thotor;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.auth_user (
    id bigint NOT NULL,
    password text,
    last_login timestamp with time zone,
    is_superuser boolean,
    username text,
    last_name text,
    email text,
    is_staff boolean,
    is_active boolean,
    date_joined timestamp with time zone,
    first_name text
);


ALTER TABLE public.auth_user OWNER TO thotor;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id bigint,
    group_id bigint
);


ALTER TABLE public.auth_user_groups OWNER TO thotor;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO thotor;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO thotor;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint,
    permission_id bigint
);


ALTER TABLE public.auth_user_user_permissions OWNER TO thotor;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO thotor;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.authtoken_token (
    key text NOT NULL,
    created timestamp with time zone,
    user_id bigint
);


ALTER TABLE public.authtoken_token OWNER TO thotor;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.django_admin_log (
    id bigint NOT NULL,
    action_time timestamp with time zone,
    object_id text,
    object_repr text,
    change_message text,
    content_type_id bigint,
    user_id bigint,
    action_flag smallint
);


ALTER TABLE public.django_admin_log OWNER TO thotor;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO thotor;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.django_content_type (
    id bigint NOT NULL,
    app_label text,
    model text
);


ALTER TABLE public.django_content_type OWNER TO thotor;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO thotor;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app text,
    name text,
    applied timestamp with time zone
);


ALTER TABLE public.django_migrations OWNER TO thotor;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: thotor
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO thotor;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thotor
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: thotor
--

CREATE TABLE public.django_session (
    session_key text NOT NULL,
    session_data text,
    expire_date timestamp with time zone
);


ALTER TABLE public.django_session OWNER TO thotor;

--
-- Name: api_customfiles id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_customfiles ALTER COLUMN id SET DEFAULT nextval('public.api_customfiles_id_seq'::regclass);


--
-- Name: api_lifestation id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_lifestation ALTER COLUMN id SET DEFAULT nextval('public.api_lifestation_id_seq'::regclass);


--
-- Name: api_location id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_location ALTER COLUMN id SET DEFAULT nextval('public.api_location_id_seq'::regclass);


--
-- Name: api_location_responsible_users id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_location_responsible_users ALTER COLUMN id SET DEFAULT nextval('public.api_location_responsible_users_id_seq'::regclass);


--
-- Name: api_locationreference id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_locationreference ALTER COLUMN id SET DEFAULT nextval('public.api_locationreference_id_seq'::regclass);


--
-- Name: api_locationreference_responsible_users id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_locationreference_responsible_users ALTER COLUMN id SET DEFAULT nextval('public.api_locationreference_responsible_users_id_seq'::regclass);


--
-- Name: api_order id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_order ALTER COLUMN id SET DEFAULT nextval('public.api_order_id_seq'::regclass);


--
-- Name: api_stolperstein id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_stolperstein ALTER COLUMN id SET DEFAULT nextval('public.api_stolperstein_id_seq'::regclass);


--
-- Name: api_stolpersteinrelation id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_stolpersteinrelation ALTER COLUMN id SET DEFAULT nextval('public.api_stolpersteinrelation_id_seq'::regclass);


--
-- Name: api_textbox id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_textbox ALTER COLUMN id SET DEFAULT nextval('public.api_textbox_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: api_customfiles; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_customfiles (id, photo_name, photo, audio_name, stolperstein_id, audio, video, video_name) FROM stdin;
1	1484937917_jahan2.jpg	public/photos/2022/01/19/1484937917_jahan2_xjx9wm	Aufnahme_konv.mp3	54	public/audios/2022/01/19/Aufnahme_konv_pa07ij	\N	\N
2	chrismitschnautzer.png		\N	22			\N
15	\N		\N	98		https://res.cloudinary.com/dythpl8mo/video/upload/v1/public/videos/20231015/testvideo_jvjdae	testvideo.mp4
16	sadge.jpg	https://res.cloudinary.com/dythpl8mo/image/upload/v1/public/photos/20231016/sadge_korg6l	Aufnahme.m4a	99	https://res.cloudinary.com/dythpl8mo/video/upload/v1/public/audios/20231016/Aufnahme_ylwwtm	https://res.cloudinary.com/dythpl8mo/video/upload/v1/public/videos/20231016/720p1Min_o3qmlm	720p1Min.mp4
25	Sadge.jpg	public/photos/20231030/Sadge_wbvvfw	LOOK AT THE TOP OF HIS HEAD.mp3	109	public/audios/20231030/LOOK_AT_THE_TOP_OF_HIS_HEAD_enesjp	public/videos/20231030/VideoWithAudio_b9mwtu	VideoWithAudio.mp4
27	ArteezyAegis.jpg	public/photos/20231030/ArteezyAegis_ddujcs	IWantToPlayIGame.mp3	111	public/audios/20231030/IWantToPlayIGame_luvkek	public/videos/20231030/oc_dont_steal_zyag8t	oc_dont_steal.mp4
\.


--
-- Data for Name: api_lifestation; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_lifestation (id, coordinates, name, text, stolperstein_id) FROM stdin;
15	48.12148979388502,11.590118436142804	Munich	In the course of the strong exclusion that Jewish citizens experienced since 1933, Gustav Baldauf probably took his own life in March 1935. However, this is only a guess;	27
16	54.89688096466163,23.90927125699818	Kaunas	Ilse Jetti Löffler and her husband were deported to Kaunas on 20.11.1941 and shot there. Among the almost 1000 deportees from Munich was also Jetti Löfflers mother, the widow Bella Homburger.	28
17	48.131145819006605,11.537841930985453	Munich	In 1941, the Löffler couple then lived at Leopoldstraße 52a. The house originally belonged to a Jewish woman who lived in Wiesbaden; after the forced sale to a couple from Garmisch, the property was used as a so-called Judenhaus for Jews who had already been evicted elsewhere.	28
18	54.902671792279655,23.90927125699818	Kaunas	Alfred Löffler and his wife were deported to Kaunas on 20.11.1941 and shot there. Among the almost 1000 deportees from Munich was also the mother of Jetti Löffler, the widow Bella Homburger.	29
19	48.14220414254747,11.569152865558864	Munich	Alfred Löffler and his business partners Adele and Nathan Stern had tried to sell their store already in the course of 1938, but after the violent night of November 9, when the store had been looted and damaged, the buyer tried to push down the agreed price considerably. \r\nBut since the enactment of the racial laws, 'Jews' were no longer allowed to own land and houses and had to 'sell' and accept virtually any price.\r\nIn 1941, the Löffler couple then lived at Leopoldstraße 52a. The house originally belonged to a Jewish woman who lived in Wiesbaden; after the forced sale to a couple from Garmisch, the property was used as a so-called Judenhaus for Jews who had already been evicted elsewhere.	29
20	40.67994364242072,-73.86053463444115	New York	She was sent to New York as early as 1936, where her mother and brother would follow in 1938.	30
21	48.09043350787506,11.624633856117727	Munich	She was born and lived in Munich, until she had to emmigrate to the USA.	30
22	49.21003302816007, 5.445366378681041	Verdun	During the war Max Michels served as a commander in the Bavarian Infantry Regiment in Belgium and France. In 1916 - probably at Verdun - he was seriously wounded, returned to Bavaria as an invalid and continued to serve "behind the lines". For his exemplary service he received two Iron Crosses and a number of other medals and awards. He returned home a hero.	21
23	53.7693537936074, 15.387849863286045	Maldewin	Even the place Maldewin (area of Regenwalde, today Poland) from which he and his family came was unusual. It was not a Jewish "shtetel", but a small village that belonged to a local nobleman. Generations before, his ancestors had invited some Jewish families to live there, to carry on typical Jewish trades. His family ran the grocery store in Maldewin. Consequently, Max learned the merchant business from scratch - he was a born businessman.	21
24	52.51040699884349, 13.390953028824375	Berlin	Like almost all his siblings, he left Maldewin as a young man. He went to Berlin to work at Herman Tietz, a large department store on Leipziger Straße.	21
25	48.13908347745517, 11.562433527730398	Munich	In 1912 he decided to move to Munich. A city that at that time was a strong attraction for young, ambitious people and where at the same time a growing art scene was developing - almost as famous as Paris. Max fell in love with the city of Munich and with a young woman named Anna, who was equally ambitious and unusual as he was.	21
26	48.13908347745517, 11.562433527730398	Munich	In 1912 he decided to move to Munich. A city that at that time was a strong attraction for young, ambitious people and where at the same time a growing art scene was developing - almost as famous as Paris. Max fell in love with the city of Munich and with a young woman named Anna, who was equally ambitious and unusual as he was.\r\n\r\nAfter the war, the Michels couple put their skills and contacts to profitable use: Anna her connections to the Munich art scene and Max his business acumen. They started with an art gallery on Karolinenplatz, the Max Michels Galerie. Later they acquired the already existing Georg Stuffler Gallery, which was housed in the Park Hotel on Maximiliansplatz.	21
27	40.658868669918064, -73.94672909299594	New York	She sent her daughter Annemarie to New York as early as 1936 and followed her with her son Günther in November 1938.	26
28	40.682304638900604, -73.8835577037904	New York	Together with his mother he emigrated in 1938 to New York.	31
29	48.15924099995036, 11.550417230870645	Munich	He was born and lived in Munich before emigrating.	31
30	49.48180650079764,11.003906317055227	adsDF	DA	35
31	48.200019290590404,11.327562825922108	Olching	Batman was there aswell	99
\.


--
-- Data for Name: api_location; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_location (id, coordinates, name) FROM stdin;
10	48.16191195718601,11.576094031224786	Viktor-Scheffel-Straße 16
11	48.12207810985512,11.54377341259533	Lindwurmstraße 205
12	48.14732507362143,11.574152111898004	Türkenstraße 26
13	48.15882028503429,11.589188575635491	Seestraße 8
16	48.141522807659136,11.562543511281548	Elisenstraße 3
17	48.15722070095945,11.584816574941216	Leopoldstraße 52a
18	48.12110407053475,11.568803785485217	Englischer Garten
19	48.15944292843723,11.58476471911854	Hohenzollernstraße 4
30	47.37449322362727,11.49410476320501	API Test Location
31	48.19681988615128,11.533456742790804	TestLocationThomas
50	48.13928520018743,11.502398088553052	Laim
53	48.24857639876109,11.644709858805598	Garching
\.


--
-- Data for Name: api_location_responsible_users; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_location_responsible_users (id, location_id, user_id) FROM stdin;
6	10	1
7	11	1
8	12	1
9	13	1
12	16	1
13	17	1
14	18	1
15	19	1
26	30	5
27	31	5
45	50	5
48	53	5
\.


--
-- Data for Name: api_locationreference; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_locationreference (id, coordinates, name) FROM stdin;
\.


--
-- Data for Name: api_locationreference_responsible_users; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_locationreference_responsible_users (id, locationreference_id, user_id) FROM stdin;
\.


--
-- Data for Name: api_order; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_order (id, location_id, stolperstein_id, "position") FROM stdin;
129	17	33	0
130	17	32	1
159	10	22	0
160	10	23	1
164	16	25	0
165	16	24	1
189	13	21	0
190	13	27	1
191	13	26	2
192	13	29	3
193	13	28	4
194	13	30	5
195	13	31	6
211	30	54	0
212	30	55	1
213	30	48	2
227	53	98	0
228	53	99	1
\.


--
-- Data for Name: api_stolperstein; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_stolperstein (id, name, birthdate, deathdate, birthplace, deathplace, reason_for_persecution, info_text, location_id, family_text) FROM stdin;
20	Emil Oestreicher	\N	\N			UNKNOWN		12	
21	Max Michels	1880-01-03	1944-10-18	Maldewin	Ausschwitz	JEWISH	From stories it was heard that he was a great man in all respects: generous, big-hearted and very cheerful - at least until shortly before the last years of his life.	13	Max was born in 1880 in Maldewin, Regenwalde County in Pomerania, into a large Jewish family. He was the second oldest son, but he was the tallest in length, at 1.83 m (6 ft). \r\nIn 1914 he married his wife Anna, presumably shortly before he was drafted into World War I.
23	Julia Katharina Weiss	\N	\N			UNKNOWN		10	
24	Maria Klopfer	1788-08-23	1941-11-25	Augsburg	Kaunas	UNKNOWN		16	
25	Jakob Klopfer	1778-07-11	1939-05-25	Fischach	Dachau	UNKNOWN		16	
26	Margarete Baldauf	1894-01-12	\N	Mannheim	USA	JEWISH	The wife of Gustav Baldauf lived here, until she emmigrated to the USA.	13	In the fall of 1919 the daughter Annemarie was born and in 1923 the son Günther.\r\nHer husband, Gustav Baldauf died 1935, presumably by suicide.
27	Gustav Baldauf	1880-03-31	1935-03-15	Binswangen	Munich	JEWISH	In 1921 the engineer Gustav Baldauf bought the property at this place and had a technical office and a basketry manufacturing company on the first floor and lived here with his family.	13	Gustav Baldauf had married his wife Margarete (*1894) in Mannheim at the end of December 1918, and their daughter Annemarie was born in the fall of 1919 and their son Günther in 1923.
28	Ilse Jetti Löffler	1912-09-15	1941-11-25	Munich	Kaunas	JEWISH	Her occupation is given in the "Biographisches Gedenkbuch der Münchner Juden" as "Expedientin". This means that she was a commercial employee who took care of the orders and the shipping of goods in a company.\r\nPresumably she also took on this task in the linen store that Alfred Löffler ran together with the business partners  Adele and Nathan Stern. Presumably she had worked there as long as the business had not yet been compulsorily expropriated.	13	1939 Ilse Jetti Löffler married the 30 years older merchant Alfred Löffler.
29	Alfred Löffler	1882-03-04	1941-11-20	Munich	Kaunas	JEWISH	Alfred Löffler was the owner of a long-established textile store "Gerstle & Löffler" at Weinstraße 3; the business had about 90 employees in August 1938.	13	The merchant Alfred Löffler *1882, who had to call himself Denny, married Ilse Jetti Löfflerr, thirty years younger, in 1939.\r\nHis sister, Mina Jacoby, born 01.06.1880 Munich, was murdered on 25.11.1941 in Kaunas.\r\nHis brother Karl David Löffler, born 06.04.1883 Munich, was killed at Verdun on 16.05.1916.
30	Annemarie Baldauf	1919-11-19	\N	Munich	USA	JEWISH	Annemarie Baldauf was the daughter of Gustav and Grete Baldauf.	13	She married Robert Crystal and had one brother, Gunther.
31	Günther Baldauf	1923-05-20	\N	Munich	USA	JEWISH	Günther Baldauf was the son of Margarete and Gustav Baldauf.	13	He had one sister, Annemarie.
32	Rosa Bechhöfer	1898-07-07	1943-03-13	Bechhofen	Ausschwitz	JEWISH	Rosa Bechhöfer was born in Bechhofen, Franconia, on July 7, 1898.	17	She was the twelfth of thirteen children of the couple Sara and Gabriel Bechhöfer. Rosas parents died when she was six years old. With her younger sister Betty, Rosa grew up in an orphanage. She worked in her older sister Frieda's shoe store in Fürth as soon as she was old enough to do so.\r\n\r\nOn May 17, 1936, Rosa gave birth to her twin daughters Lotte and Susi\r\ntwin daughters Lotte and Susi. The father of her children had left her at the beginning of the pregnancy because he apparently wanted to avoid charges of "racial defilement". She received financial support during this difficult time from her sister Frieda. The twins initially remained in the clinic, but from September 1936 the Jewish children's home in Antonienstraße in Schwabing became their home.
33	Lotte Bechhöfer	\N	\N			UNKNOWN		17	
34	Susi Bechhöfer	\N	\N			UNKNOWN		17	
35	name	\N	\N			UNKNOWN		18	
36	Richard Siegrfried Walther	\N	\N			UNKNOWN		19	
48	Test	1888-07-21	\N	Paradise City		UNKNOWN	Test 1 ist der erste API Test und damit etwas ganz besonderes.	30	Test 2 hat Test 1 ganz doll lieb.
54	Test 2	1900-01-01	1942-09-10			HOMOSEXUAL		30	
55	Test 3	\N	\N			UNKNOWN		30	
111	New file test	\N	\N			UNKNOWN		53	
22	Jeanette Weiss	\N	\N			UNKNOWN		10	
57	That Guy	1900-01-18	1942-01-19	München	Paris	HOMOSEXUAL		10	
98	video test	\N	\N			UNKNOWN		53	
100	Laimer Franz	\N	\N			UNKNOWN		50	
101	App Test Stone	1900-01-01	1942-01-31	München	Dachau	POLITICAL	If you can read this our experiment was successful	31	No Family (*sad Vin Diesel noises*)
99	All Media test	1900-01-01	1942-01-31	München	Dachau	JEWISH	Do you have all the files..?	53	Sure do thank you
109	update media test	\N	\N			UNKNOWN		53	
\.


--
-- Data for Name: api_stolpersteinrelation; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_stolpersteinrelation (id, text, related_stolperstein_id, stolperstein_id, type) FROM stdin;
10	His widow Margarete continued to run the business until the end of 1935. She sent her daughter Annemarie to New York as early as 1936 and followed her with son Günther in November 1938.	26	27	FAMILY
11	A Stolperstein at the same place is dedicated to her husband Ilse Alfred Löffler	28	29	FAMILY
12	Rosa Bechhöfer and her two daughters also lived at Leopoldstraße 52a, where the Löffler couple lived from 1941 onwards, and to whom Stolpersteine are also dedicated. The house originally belonged to a Jewish woman who lived in Wiesbaden; after the forced sale to a couple from Garmisch, the property was used as a so-called Judenhaus for Jews who had already been evicted elsewhere.	32	29	NEIGHBOUR
13	Rosa Bechhöfer and her two daughters also lived at Leopoldstraße 52a, where the Löffler couple lived from 1941 onwards, and to whom Stolpersteine are also dedicated. The house originally belonged to a Jewish woman who lived in Wiesbaden; after the forced sale to a couple from Garmisch, the property was used as a so-called Judenhaus for Jews who had already been evicted elsewhere.	32	28	NEIGHBOUR
14	dA	25	35	OTHER
15		36	29	OTHER
\.


--
-- Data for Name: api_textbox; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.api_textbox (id, title, content, stolperstein_id) FROM stdin;
2	Jugend	Aufgewachsen in der Nähe von München gestaltete sich Test 2 Leben schon früh als schwierig.	54
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.auth_group (id, name) FROM stdin;
1	global_editor
2	editor
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	37
6	1	38
7	1	39
8	1	40
9	1	9
10	1	10
11	1	11
12	1	12
13	1	5
14	1	6
15	1	7
16	1	8
17	2	1
18	2	5
19	2	6
20	2	7
21	2	8
22	2	9
23	2	10
24	2	11
25	2	12
26	2	40
27	2	37
28	2	38
29	2	39
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.auth_permission (id, content_type_id, codename, name) FROM stdin;
1	1	add_location	Can add location
2	1	change_location	Can change location
3	1	delete_location	Can delete location
4	1	view_location	Can view location
5	2	add_stolperstein	Can add stolperstein
6	2	change_stolperstein	Can change stolperstein
7	2	delete_stolperstein	Can delete stolperstein
8	2	view_stolperstein	Can view stolperstein
9	3	add_lifestation	Can add life station
10	3	change_lifestation	Can change life station
11	3	delete_lifestation	Can delete life station
12	3	view_lifestation	Can view life station
13	4	add_logentry	Can add log entry
14	4	change_logentry	Can change log entry
15	4	delete_logentry	Can delete log entry
16	4	view_logentry	Can view log entry
17	5	add_permission	Can add permission
18	5	change_permission	Can change permission
19	5	delete_permission	Can delete permission
20	5	view_permission	Can view permission
21	6	add_group	Can add group
22	6	change_group	Can change group
23	6	delete_group	Can delete group
24	6	view_group	Can view group
25	7	add_user	Can add user
26	7	change_user	Can change user
27	7	delete_user	Can delete user
28	7	view_user	Can view user
29	8	add_contenttype	Can add content type
30	8	change_contenttype	Can change content type
31	8	delete_contenttype	Can delete content type
32	8	view_contenttype	Can view content type
33	9	add_session	Can add session
34	9	change_session	Can change session
35	9	delete_session	Can delete session
36	9	view_session	Can view session
37	10	add_order	Can add order
38	10	change_order	Can change order
39	10	delete_order	Can delete order
40	10	view_order	Can view order
41	11	add_stolpersteinrelation	Can add stolperstein relation
42	11	change_stolpersteinrelation	Can change stolperstein relation
43	11	delete_stolpersteinrelation	Can delete stolperstein relation
44	11	view_stolpersteinrelation	Can view stolperstein relation
45	12	add_token	Can add Token
46	12	change_token	Can change Token
47	12	delete_token	Can delete Token
48	12	view_token	Can view Token
49	13	add_tokenproxy	Can add token
50	13	change_tokenproxy	Can change token
51	13	delete_tokenproxy	Can delete token
52	13	view_tokenproxy	Can view token
53	14	add_imagefile	Can add image file
54	14	change_imagefile	Can change image file
55	14	delete_imagefile	Can delete image file
56	14	view_imagefile	Can view image file
57	15	add_locationreference	Can add location reference
58	15	change_locationreference	Can change location reference
59	15	delete_locationreference	Can delete location reference
60	15	view_locationreference	Can view location reference
61	16	add_customfiles	Can add custom files
62	16	change_customfiles	Can change custom files
63	16	delete_customfiles	Can delete custom files
64	16	view_customfiles	Can view custom files
65	17	add_textbox	Can add textbox
66	17	change_textbox	Can change textbox
67	17	delete_textbox	Can delete textbox
68	17	view_textbox	Can view textbox
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.auth_user (id, password, last_login, is_superuser, username, last_name, email, is_staff, is_active, date_joined, first_name) FROM stdin;
1	pbkdf2_sha256$260000$UvBmn6pqNAaMzHjTY5n5UJ$7KDEJlsqlLrdRF90gU3CJkJZ/nJwAs/RieYR7I1PEgA=	2021-07-29 14:34:41.645885+00	t	nico			t	t	2021-06-21 08:30:33.137751+00	
2	pbkdf2_sha256$260000$75dAmOfabTbO9OaNOJd3zd$mbPH3Ml5wXYYq3ebriuN+PocFSHQ05cflg8gLXEHNe4=	2021-06-21 10:46:01.216595+00	f	test_user			f	t	2021-06-21 09:25:23.675288+00	
3	pbkdf2_sha256$260000$tFwHE06sNAvAWVdWpkP6Fe$rBUQf+ZcClgTWf4gi6o8ley/yYDeNE8rCEezxr4SBdI=	2021-06-21 10:46:17.737289+00	f	test_editor			f	t	2021-06-21 10:15:50+00	
4	pbkdf2_sha256$260000$7tY3uRtH1fg9Ley2dpoxWR$DVHV7vJJ6t9B6TC59n/7lu/ZPFr9Wv/NG/CqOlKn5jI=	2021-06-21 11:43:06.402346+00	f	test_creator			f	t	2021-06-21 10:55:57+00	
6	pbkdf2_sha256$260000$nyfZlCpeDKyh7cmbSnfTXv$Vqi+9TZgt90Y/4DcV4trSibi0CyqlCy6NccK3DsoR1o=	2021-10-21 12:19:50.913115+00	f	regular_user			f	t	2021-10-21 12:13:00.150001+00	
7	pbkdf2_sha256$260000$maHMQjMjPytWFWAiDtn4P8$4D8GONZjAb6Z7HuJmJX+9n0cdXG5stqEyhr7qVtSgOo=	2022-03-18 12:09:25+00	f	limited_user			f	t	2022-03-18 11:56:07+00	
8	pbkdf2_sha256$260000$23tfwSzabUtvX1e0QVVKSs$CDzA+5rb31u7wPIucDi+DmG2GqlqEoC5PBro7sUbs2o=	2023-08-15 13:31:03+00	t	thomas	Torggler	ttorggler@hotmail.com	t	t	2023-08-15 12:08:39+00	Thomas
9	pbkdf2_sha256$260000$TYRL5O3MVAhQBoQqjcUnzM$k9MHjdXM4WDbJNSsN8+XjjQmHgW79sLe1I8jozdy9EM=	2023-10-10 15:27:25+00	t	thotor		ttorggler@hotmail.com	t	t	2023-10-10 15:26:24+00	
5	pbkdf2_sha256$260000$sFkMsK9ZBoby6CCm6WW0bF$tkQjrS+FbGAb8CxoykCnCmXvY0pwaCVE3Dk5D/nNSbc=	2023-10-15 16:07:24.040464+00	t	chevron		alexander.partsch@tum.de	t	t	2021-10-14 11:29:56+00	
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
1	3	1
2	4	2
3	5	1
4	5	2
5	8	1
6	8	2
7	9	1
8	9	2
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
2	7	1
3	7	2
8	7	9
9	7	10
10	7	12
17	7	37
18	7	38
19	7	40
20	7	41
21	7	42
22	7	44
23	7	53
24	7	54
25	7	56
26	7	57
27	7	58
28	7	60
29	7	61
30	7	62
31	7	64
32	7	65
33	7	66
34	7	68
35	7	4
36	7	8
37	7	5
38	7	3
40	9	1
41	9	2
42	9	3
43	9	4
44	9	5
45	9	6
46	9	7
47	9	8
48	9	9
49	9	10
50	9	11
51	9	12
52	9	13
53	9	14
54	9	15
55	9	16
56	9	17
57	9	18
58	9	19
59	9	20
60	9	21
61	9	22
62	9	23
63	9	24
64	9	25
65	9	26
66	9	27
67	9	28
68	9	29
69	9	30
70	9	31
71	9	32
72	9	33
73	9	34
74	9	35
75	9	36
76	9	37
77	9	38
78	9	39
79	9	40
80	9	41
81	9	42
82	9	43
83	9	44
84	9	45
85	9	46
86	9	47
87	9	48
88	9	49
89	9	50
90	9	51
91	9	52
92	9	53
93	9	54
94	9	55
95	9	56
96	9	57
97	9	58
98	9	59
99	9	60
100	9	61
101	9	62
102	9	63
103	9	64
104	9	65
105	9	66
106	9	67
107	9	68
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
ad3aecc272221438da59f051e62f7b415f872cc1	2021-10-19 14:32:41.289017+00	1
16a5dff60d53f8b171459b3ba74bc6c3c29c8417	2021-10-19 14:32:41.313317+00	2
bb86fad96172dbdefa118a2e48f4284c17a0e932	2021-10-19 14:32:41.326511+00	3
c30e25baca57427557193a19684f3d5b4c6e46b2	2021-10-19 14:32:41.339624+00	4
62b80b5fcd085f05581ab446b7cd51bae575a257	2021-10-19 14:32:41.352195+00	5
58ee063cc88b14989b0803a7c53548e90e341dd7	2021-10-21 12:13:00.259214+00	6
5f3f071c908c453cab5c5598533ff2f74bd96956	2022-03-18 11:56:07.854673+00	7
aac124618f7a01ee8d0fafbdb597b5127fe686cd	2023-08-15 12:08:40.316892+00	8
fb52f9b647cf14b92ffa25a52b0c668d3859b8cc	2023-10-10 15:26:24.312789+00	9
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, change_message, content_type_id, user_id, action_flag) FROM stdin;
1	2021-06-21 08:32:51.62167+00	1	global_editor	[{"added": {}}]	6	1	1
2	2021-06-21 09:25:23.849486+00	2	test_user	[{"added": {}}]	7	1	1
3	2021-06-21 10:15:19.575109+00	1	global_editor	[{"changed": {"fields": ["Permissions"]}}]	6	1	2
4	2021-06-21 10:15:51.020813+00	3	test_editor	[{"added": {}}]	7	1	1
5	2021-06-21 10:16:42.234095+00	3	test_editor	[{"changed": {"fields": ["Groups"]}}]	7	1	2
6	2021-06-21 10:55:57.279372+00	4	test_creator	[{"added": {}}]	7	1	1
7	2021-06-21 10:56:11.971317+00	4	test_creator	[{"changed": {"fields": ["User permissions"]}}]	7	1	2
8	2021-06-21 11:03:17.034916+00	2	editor	[{"added": {}}]	6	1	1
9	2021-06-21 11:03:31.460001+00	4	test_creator	[{"changed": {"fields": ["Groups", "User permissions"]}}]	7	1	2
10	2021-06-21 11:10:30.022953+00	2	editor	[{"changed": {"fields": ["Permissions"]}}]	6	1	2
11	2021-10-19 13:30:35.687026+00	5	chevron	[{"changed": {"fields": ["Groups"]}}]	7	5	2
12	2021-10-21 12:13:00.261356+00	6	regular_user	[{"added": {}}]	7	5	1
13	2021-10-21 12:18:50.859117+00	6	regular_user	[{"changed": {"fields": ["password"]}}]	7	5	2
14	2022-03-18 11:56:07.856859+00	7	limited_user	[{"added": {}}]	7	5	1
15	2022-03-18 11:58:07.479463+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
16	2022-03-18 11:58:50.507421+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
17	2022-03-18 12:08:49.397129+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
18	2022-03-18 12:10:45.11982+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
19	2022-03-18 12:14:30.521997+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
20	2022-03-18 12:16:13.807073+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
21	2022-03-18 12:23:43.275379+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
22	2022-03-18 12:25:27.083311+00	7	limited_user	[{"changed": {"fields": ["User permissions"]}}]	7	5	2
23	2023-08-15 12:08:40.458951+00	8	thomas	[{"added": {}}]	7	5	1
24	2023-08-15 12:10:20.76266+00	8	thomas	[{"changed": {"fields": ["Staff status", "Superuser status"]}}]	7	5	2
25	2023-08-15 12:12:21.167879+00	8	thomas	[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]	7	5	2
26	2023-08-15 12:23:21.477505+00	8	thomas	[{"changed": {"fields": ["User permissions"]}}]	7	8	2
27	2023-10-07 17:00:10.565946+00	8	thomas	[{"changed": {"fields": ["Groups", "User permissions"]}}]	7	5	2
28	2023-10-10 16:59:43.102297+00	9	thotor	[{"changed": {"fields": ["Groups", "User permissions"]}}]	7	9	2
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	api	location
2	api	stolperstein
3	api	lifestation
4	admin	logentry
5	auth	permission
6	auth	group
7	auth	user
8	contenttypes	contenttype
9	sessions	session
10	api	order
11	api	stolpersteinrelation
12	authtoken	token
13	authtoken	tokenproxy
14	api	imagefile
15	api	locationreference
16	api	customfiles
17	api	textbox
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-06-17 10:17:47.489732+00
2	auth	0001_initial	2021-06-17 10:17:47.522852+00
3	admin	0001_initial	2021-06-17 10:17:47.542536+00
4	admin	0002_logentry_remove_auto_add	2021-06-17 10:17:47.560353+00
5	admin	0003_logentry_add_action_flag_choices	2021-06-17 10:17:47.578986+00
6	api	0001_initial	2021-06-17 10:17:47.60185+00
7	api	0002_auto_20210617_0958	2021-06-17 10:17:47.618773+00
8	contenttypes	0002_remove_content_type_name	2021-06-17 10:17:47.660294+00
9	auth	0002_alter_permission_name_max_length	2021-06-17 10:17:47.678446+00
10	auth	0003_alter_user_email_max_length	2021-06-17 10:17:47.710027+00
11	auth	0004_alter_user_username_opts	2021-06-17 10:17:47.722933+00
12	auth	0005_alter_user_last_login_null	2021-06-17 10:17:47.740586+00
13	auth	0006_require_contenttypes_0002	2021-06-17 10:17:47.746188+00
14	auth	0007_alter_validators_add_error_messages	2021-06-17 10:17:47.75964+00
15	auth	0008_alter_user_username_max_length	2021-06-17 10:17:47.776722+00
16	auth	0009_alter_user_last_name_max_length	2021-06-17 10:17:47.796461+00
17	auth	0010_alter_group_name_max_length	2021-06-17 10:17:47.813698+00
18	auth	0011_update_proxy_permissions	2021-06-17 10:17:47.830054+00
19	auth	0012_alter_user_first_name_max_length	2021-06-17 10:17:47.855753+00
20	sessions	0001_initial	2021-06-17 10:17:47.872598+00
21	api	0003_auto_20210619_0838	2021-06-19 08:38:07.481899+00
22	api	0004_alter_order_stolperstein	2021-06-20 14:31:27.484899+00
23	api	0005_location_responsible_users	2021-06-21 09:50:47.306144+00
24	api	0006_auto_20210621_1145	2021-06-21 11:45:23.285251+00
25	api	0007_alter_stolperstein_options	2021-06-22 15:13:05.86096+00
26	api	0008_stolpersteinrelation	2021-06-23 08:47:24.880436+00
27	api	0009_auto_20210623_0902	2021-06-23 09:02:33.153956+00
28	authtoken	0001_initial	2021-10-19 14:10:12.408801+00
29	authtoken	0002_auto_20160226_1747	2021-10-19 14:10:12.440113+00
30	authtoken	0003_tokenproxy	2021-10-19 14:10:12.452266+00
31	api	0010_auto_20220113_1446	2022-01-13 14:46:23.080192+00
32	api	0011_auto_20220116_1224	2022-01-16 12:24:35.276494+00
33	api	0012_alter_customfiles_stolperstein	2022-01-16 12:25:49.886366+00
34	api	0013_alter_customfiles_stolperstein	2022-01-16 12:35:45.792558+00
35	api	0014_alter_customfiles_stolperstein	2022-01-16 12:42:01.656246+00
36	api	0015_alter_customfiles_audio	2022-01-16 13:18:43.970077+00
37	api	0016_alter_customfiles_audio	2022-01-19 12:19:01.959743+00
38	api	0017_textbox	2022-01-27 13:52:14.49663+00
39	api	0018_alter_customfiles_audio	2022-03-18 11:50:47.974719+00
40	api	0019_alter_customfiles_audio	2022-03-18 14:47:32.128339+00
41	api	0002_remove_locationreference_test	2023-10-01 12:37:28.590298+00
42	api	0003_auto_20231001_1419	2023-10-01 12:38:02.214938+00
43	api	0004_auto_20231001_1521	2023-10-01 13:22:28.388076+00
44	api	0003_auto_20231001_1529	2023-10-01 13:41:35.097122+00
45	api	0004_auto_20231001_1542	2023-10-01 13:43:37.321258+00
46	api	0005_auto_20231014_1524	2023-10-14 13:28:04.73462+00
47	api	0006_auto_20231015_1652	2023-10-15 14:53:26.650269+00
48	api	0007_auto_20231015_1753	2023-10-15 15:53:50.343477+00
49	api	0008_alter_customfiles_photo	2023-10-15 16:50:55.15689+00
50	api	0009_auto_20231015_1855	2023-10-15 16:55:46.039209+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: thotor
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
jz35kawvo9k7fjddue09tscws6yjwfmz	.eJxVjMsOwiAUBf-FtSEthcp16d5vIPcBUjWQlHZl_HfbpAvdzsw5bxVwXXJYW5zDJOqienX6ZYT8jGUX8sByr5prWeaJ9J7owzZ9qxJf16P9O8jY8rb2XYqJIjAlPIsjcIRGNgbGCyVvDHqEoR9GtgDAljoHI0bHBJY5qc8XKgU5bw:1lzHMQ:9NCTwtaogsd7AO1f54aIuyzV1V63miVcPmpG7sZW-Ao	2021-07-16 11:29:30.56005+00
42itbtya2hr30tpvmoe6jyttyn7dli95	.eJxVjMsOwiAUBf-FtSEthcp16d5vIPcBUjWQlHZl_HfbpAvdzsw5bxVwXXJYW5zDJOqienX6ZYT8jGUX8sByr5prWeaJ9J7owzZ9qxJf16P9O8jY8rb2XYqJIjAlPIsjcIRGNgbGCyVvDHqEoR9GtgDAljoHI0bHBJY5qc8XKgU5bw:1m674l:PaUXDiLIcF-27Gh_0EbwKMBL3KP11blNrSwwst9YwSA	2021-08-04 07:55:31.514663+00
9bewsrgstc2h3s942d6snc9vs9s04hc8	.eJxVjMsOwiAUBf-FtSEthcp16d5vIPcBUjWQlHZl_HfbpAvdzsw5bxVwXXJYW5zDJOqienX6ZYT8jGUX8sByr5prWeaJ9J7owzZ9qxJf16P9O8jY8rb2XYqJIjAlPIsjcIRGNgbGCyVvDHqEoR9GtgDAljoHI0bHBJY5qc8XKgU5bw:1m977R:Q4Wg-ElhwIslAdpbySaWPxaNKq2L46saNFputWU9nWY	2021-08-12 14:34:41.650422+00
ocfargdzzhbnd7to4t4k57d9f2be5bxw	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1mcnCu:7tOR8DBuXCKhefR5NC55oCTy68N5CxmBbb2FVcbZva0	2021-11-02 11:23:00.898024+00
nfvd2rukaco8n5vx74h2ztudjbmiuvfs	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1mdX3G:v-rjOfhgOu4jPOgJzY2I1VkDz2_XTWFqzssHTTYtwsM	2021-11-04 12:20:06.349031+00
bqn1yp77ck2eoyhbdsu23aizv7o15elz	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1mic41:1FB-1f3YW7s1TmuRFoIbeWSmlu8Ifa8s24SqYNV7Pcs	2021-11-18 12:41:53.884619+00
z5yzev51qphn7y50z7t0cac80ui15tu4	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1mrib8:vQ4c3WMLVPhCkggyX1VkucEoF00Ds3tZ7gKOBlYOgnk	2021-12-13 15:29:42.867371+00
e7p1yb5mk06n4570tf7gxjljpr5rjxfo	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1q01Tf:6Cij7DjVDwyVpxyvDXFF3SBsHU5TSUhx_EfIbL3DObs	2023-06-02 14:53:07.989454+00
eac2id4gep1u2o6xe3i4gfdg2hesi2hx	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1qDgWy:scH1kklfTgbk6_aAL9KF_TdwQAoj8A-vQFz6lES_5TY	2023-07-10 07:21:00.718319+00
esx9rpq1ckb8iuwd8l2qd0bkegz3fiq6	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1qPlZm:0OjfzlNldAulAlM0CMFgv4R44ML-IeQ-Y0Dco7afWJY	2023-08-12 15:09:50.705302+00
2td4clgjpbge9ibsl5r035sd9oag49oc	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1qQ7UE:kOG1iDMhxY3rLGc_14K9ElOsDxCP4Bd4HalNp_Ve0gA	2023-08-13 14:33:34.659096+00
8uo654thoyufbgkouqvbbj10zitfwl28	.eJxVjMsOwiAUBf-FtSFIbxFcuvcbyH2AVA0kpV0Z_12bdKHbMzPnpSKuS4lrT3OcRJ3VqA6_GyE_Ut2A3LHemuZWl3kivSl6p11fm6TnZXf_Dgr28q1dEkiMgxgO2RMxGZsBBQKi9wNBBju48Xhy2YJjROutweBJrMdsQL0_Eo44iA:1qVspz:RKrRXdq3BKUXvSCTKOjX4jTL0h9vOCL7J9gpkI1ibzI	2023-08-29 12:07:51.797779+00
pgj16c0gnt42fspvplyy848jc5zowhn1	.eJxVjMsOgjAQRf-la9NMmQ6gS_d8A5lHtaiBhMLK-O9CwkK395xz367ndcn9WtLcD-YurnWn301Yn2ncgT14vE9ep3GZB_G74g9afDdZel0P9-8gc8lbTRioUTuLVrUIR6otImJAEwXSSK1CqEDkRlY3GowNMDFtHAgA3ecL45A30w:1qVu8V:-OYgWqsfiWabXUPGsmjmGVCbCgbtuolQyGvY3xxgKHc	2023-08-29 13:31:03.738466+00
x6dbhkx3mq5aeslmpx71fz4kh1bjfz5v	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1qlTg7:WeHgnoWlzFq5HBOXeTA2g-Jukf533pyvvFKQzCILSLM	2023-10-11 12:30:07.873347+00
8qhfhv2zuz4m0s5g8wll99mexm4a5hp4	.eJxVjDsOwjAQBe_iGlnxb2NT0nMGa-314gBypDipEHeHSCmgfTPzXiLitta49bLEicRZBHH63RLmR2k7oDu22yzz3NZlSnJX5EG7vM5UnpfD_Tuo2Ou3tg4UW9AjGlSMDqBoKpkND14hGWvADhyQnVekPOtkA5OHPFKGZJx4fwDjgTgR:1qqEdp:LwpU-sRdr9qiOzmo0pmyIPlzTCbDWJ3IXFOOYw8xGAI	2023-10-24 15:27:25.551114+00
2lw34631j3ryumevqqsaa1cbbkcuz6gk	.eJxVjMsOgjAQRf-la9O0DFOsS_d8QzOPYlEDCYWV8d-VhIVu7znnvkyibS1pq3lJo5qLQXP63Zjkkacd6J2m22xlntZlZLsr9qDV9rPm5_Vw_w4K1fKtQSGiKKjrnAygA3jvurMG4K4VybmVJjOIjxIQuWmZIg5BkDxxcN68P_KIOE4:1qs3eG:9yUPVt6ESLSrLrES_iAqedVTe4oYBCz5qPiY3BFGqkw	2023-10-29 16:07:24.065976+00
\.


--
-- Name: api_customfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_customfiles_id_seq', 27, true);


--
-- Name: api_lifestation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_lifestation_id_seq', 31, true);


--
-- Name: api_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_location_id_seq', 53, true);


--
-- Name: api_location_responsible_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_location_responsible_users_id_seq', 48, true);


--
-- Name: api_locationreference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_locationreference_id_seq', 1, true);


--
-- Name: api_locationreference_responsible_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_locationreference_responsible_users_id_seq', 1, true);


--
-- Name: api_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_order_id_seq', 228, true);


--
-- Name: api_stolperstein_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_stolperstein_id_seq', 111, true);


--
-- Name: api_stolpersteinrelation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_stolpersteinrelation_id_seq', 15, true);


--
-- Name: api_textbox_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.api_textbox_id_seq', 2, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 29, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 68, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 8, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 9, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 107, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 28, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 17, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thotor
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 50, true);


--
-- Name: django_migrations idx_16745_django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT idx_16745_django_migrations_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions idx_16752_auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT idx_16752_auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups idx_16757_auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT idx_16757_auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions idx_16762_auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT idx_16762_auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log idx_16767_django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT idx_16767_django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: api_lifestation idx_16774_api_lifestation_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_lifestation
    ADD CONSTRAINT idx_16774_api_lifestation_pkey PRIMARY KEY (id);


--
-- Name: django_content_type idx_16781_django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT idx_16781_django_content_type_pkey PRIMARY KEY (id);


--
-- Name: auth_permission idx_16788_auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT idx_16788_auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_group idx_16795_auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT idx_16795_auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_user idx_16802_auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT idx_16802_auth_user_pkey PRIMARY KEY (id);


--
-- Name: django_session idx_16808_sqlite_autoindex_django_session_1; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT idx_16808_sqlite_autoindex_django_session_1 PRIMARY KEY (session_key);


--
-- Name: api_location idx_16814_api_location_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_location
    ADD CONSTRAINT idx_16814_api_location_pkey PRIMARY KEY (id);


--
-- Name: api_location_responsible_users idx_16821_api_location_responsible_users_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_location_responsible_users
    ADD CONSTRAINT idx_16821_api_location_responsible_users_pkey PRIMARY KEY (id);


--
-- Name: api_order idx_16826_api_order_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_order
    ADD CONSTRAINT idx_16826_api_order_pkey PRIMARY KEY (id);


--
-- Name: api_stolpersteinrelation idx_16831_api_stolpersteinrelation_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_stolpersteinrelation
    ADD CONSTRAINT idx_16831_api_stolpersteinrelation_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token idx_16837_sqlite_autoindex_authtoken_token_1; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT idx_16837_sqlite_autoindex_authtoken_token_1 PRIMARY KEY (key);


--
-- Name: api_locationreference idx_16843_api_locationreference_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_locationreference
    ADD CONSTRAINT idx_16843_api_locationreference_pkey PRIMARY KEY (id);


--
-- Name: api_locationreference_responsible_users idx_16850_api_locationreference_responsible_users_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_locationreference_responsible_users
    ADD CONSTRAINT idx_16850_api_locationreference_responsible_users_pkey PRIMARY KEY (id);


--
-- Name: api_stolperstein idx_16855_api_stolperstein_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_stolperstein
    ADD CONSTRAINT idx_16855_api_stolperstein_pkey PRIMARY KEY (id);


--
-- Name: api_textbox idx_16862_api_textbox_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_textbox
    ADD CONSTRAINT idx_16862_api_textbox_pkey PRIMARY KEY (id);


--
-- Name: api_customfiles idx_16869_api_customfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_customfiles
    ADD CONSTRAINT idx_16869_api_customfiles_pkey PRIMARY KEY (id);


--
-- Name: idx_16752_auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16752_auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: idx_16752_auth_group_permissions_group_id_permission_id_0cd325b; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16752_auth_group_permissions_group_id_permission_id_0cd325b ON public.auth_group_permissions USING btree (group_id, permission_id);


--
-- Name: idx_16752_auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16752_auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: idx_16757_auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16757_auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: idx_16757_auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16757_auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: idx_16757_auth_user_groups_user_id_group_id_94350c0c_uniq; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16757_auth_user_groups_user_id_group_id_94350c0c_uniq ON public.auth_user_groups USING btree (user_id, group_id);


--
-- Name: idx_16762_auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16762_auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: idx_16762_auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16762_auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: idx_16762_auth_user_user_permissions_user_id_permission_id_14a6; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16762_auth_user_user_permissions_user_id_permission_id_14a6 ON public.auth_user_user_permissions USING btree (user_id, permission_id);


--
-- Name: idx_16767_django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16767_django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: idx_16767_django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16767_django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: idx_16774_api_lifestation_stolperstein_id_73a6c30b; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16774_api_lifestation_stolperstein_id_73a6c30b ON public.api_lifestation USING btree (stolperstein_id);


--
-- Name: idx_16781_django_content_type_app_label_model_76bd3d3b_uniq; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16781_django_content_type_app_label_model_76bd3d3b_uniq ON public.django_content_type USING btree (app_label, model);


--
-- Name: idx_16788_auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16788_auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: idx_16788_auth_permission_content_type_id_codename_01ab375a_uni; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16788_auth_permission_content_type_id_codename_01ab375a_uni ON public.auth_permission USING btree (content_type_id, codename);


--
-- Name: idx_16795_sqlite_autoindex_auth_group_1; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16795_sqlite_autoindex_auth_group_1 ON public.auth_group USING btree (name);


--
-- Name: idx_16802_sqlite_autoindex_auth_user_1; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16802_sqlite_autoindex_auth_user_1 ON public.auth_user USING btree (username);


--
-- Name: idx_16808_django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16808_django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: idx_16814_sqlite_autoindex_api_location_1; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16814_sqlite_autoindex_api_location_1 ON public.api_location USING btree (coordinates);


--
-- Name: idx_16821_api_location_responsible_users_location_id_3bd2b6aa; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16821_api_location_responsible_users_location_id_3bd2b6aa ON public.api_location_responsible_users USING btree (location_id);


--
-- Name: idx_16821_api_location_responsible_users_location_id_user_id_aa; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16821_api_location_responsible_users_location_id_user_id_aa ON public.api_location_responsible_users USING btree (location_id, user_id);


--
-- Name: idx_16821_api_location_responsible_users_user_id_7d572e19; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16821_api_location_responsible_users_user_id_7d572e19 ON public.api_location_responsible_users USING btree (user_id);


--
-- Name: idx_16826_api_order_location_id_6288ef5a; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16826_api_order_location_id_6288ef5a ON public.api_order USING btree (location_id);


--
-- Name: idx_16826_api_order_position_location_id_6f05710a_uniq; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16826_api_order_position_location_id_6f05710a_uniq ON public.api_order USING btree ("position", location_id);


--
-- Name: idx_16826_sqlite_autoindex_api_order_1; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16826_sqlite_autoindex_api_order_1 ON public.api_order USING btree (stolperstein_id);


--
-- Name: idx_16831_api_stolpersteinrelation_related_stolperstein_id_1073; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16831_api_stolpersteinrelation_related_stolperstein_id_1073 ON public.api_stolpersteinrelation USING btree (related_stolperstein_id);


--
-- Name: idx_16831_api_stolpersteinrelation_stolperstein_id_4026887e; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16831_api_stolpersteinrelation_stolperstein_id_4026887e ON public.api_stolpersteinrelation USING btree (stolperstein_id);


--
-- Name: idx_16837_sqlite_autoindex_authtoken_token_2; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16837_sqlite_autoindex_authtoken_token_2 ON public.authtoken_token USING btree (user_id);


--
-- Name: idx_16850_api_locationreference_responsible_users_locationrefer; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16850_api_locationreference_responsible_users_locationrefer ON public.api_locationreference_responsible_users USING btree (locationreference_id);


--
-- Name: idx_16850_api_locationreference_responsible_users_user_id_9600f; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16850_api_locationreference_responsible_users_user_id_9600f ON public.api_locationreference_responsible_users USING btree (user_id);


--
-- Name: idx_16855_api_stolperstein_location_id_2bf20f30; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16855_api_stolperstein_location_id_2bf20f30 ON public.api_stolperstein USING btree (location_id);


--
-- Name: idx_16855_api_stolperstein_name_location_id_9389aeb8_uniq; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16855_api_stolperstein_name_location_id_9389aeb8_uniq ON public.api_stolperstein USING btree (name, location_id);


--
-- Name: idx_16862_api_textbox_stolperstein_id_88dbfc4a; Type: INDEX; Schema: public; Owner: thotor
--

CREATE INDEX idx_16862_api_textbox_stolperstein_id_88dbfc4a ON public.api_textbox USING btree (stolperstein_id);


--
-- Name: idx_16869_sqlite_autoindex_api_customfiles_1; Type: INDEX; Schema: public; Owner: thotor
--

CREATE UNIQUE INDEX idx_16869_sqlite_autoindex_api_customfiles_1 ON public.api_customfiles USING btree (stolperstein_id);


--
-- Name: api_customfiles api_customfiles_stolperstein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_customfiles
    ADD CONSTRAINT api_customfiles_stolperstein_id_fkey FOREIGN KEY (stolperstein_id) REFERENCES public.api_stolperstein(id);


--
-- Name: api_lifestation api_lifestation_stolperstein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_lifestation
    ADD CONSTRAINT api_lifestation_stolperstein_id_fkey FOREIGN KEY (stolperstein_id) REFERENCES public.api_stolperstein(id);


--
-- Name: api_location_responsible_users api_location_responsible_users_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_location_responsible_users
    ADD CONSTRAINT api_location_responsible_users_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.api_location(id);


--
-- Name: api_location_responsible_users api_location_responsible_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_location_responsible_users
    ADD CONSTRAINT api_location_responsible_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- Name: api_locationreference_responsible_users api_locationreference_responsible_use_locationreference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_locationreference_responsible_users
    ADD CONSTRAINT api_locationreference_responsible_use_locationreference_id_fkey FOREIGN KEY (locationreference_id) REFERENCES public.api_locationreference(id);


--
-- Name: api_locationreference_responsible_users api_locationreference_responsible_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_locationreference_responsible_users
    ADD CONSTRAINT api_locationreference_responsible_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- Name: api_order api_order_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_order
    ADD CONSTRAINT api_order_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.api_location(id);


--
-- Name: api_order api_order_stolperstein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_order
    ADD CONSTRAINT api_order_stolperstein_id_fkey FOREIGN KEY (stolperstein_id) REFERENCES public.api_stolperstein(id);


--
-- Name: api_stolperstein api_stolperstein_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_stolperstein
    ADD CONSTRAINT api_stolperstein_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.api_location(id);


--
-- Name: api_stolpersteinrelation api_stolpersteinrelation_related_stolperstein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_stolpersteinrelation
    ADD CONSTRAINT api_stolpersteinrelation_related_stolperstein_id_fkey FOREIGN KEY (related_stolperstein_id) REFERENCES public.api_stolperstein(id);


--
-- Name: api_stolpersteinrelation api_stolpersteinrelation_stolperstein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_stolpersteinrelation
    ADD CONSTRAINT api_stolpersteinrelation_stolperstein_id_fkey FOREIGN KEY (stolperstein_id) REFERENCES public.api_stolperstein(id);


--
-- Name: api_textbox api_textbox_stolperstein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.api_textbox
    ADD CONSTRAINT api_textbox_stolperstein_id_fkey FOREIGN KEY (stolperstein_id) REFERENCES public.api_stolperstein(id);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: auth_group_permissions auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: auth_permission auth_permission_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: auth_user_groups auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: auth_user_groups auth_user_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- Name: authtoken_token authtoken_token_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- Name: django_admin_log django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: django_admin_log django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thotor
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES  TO thotor;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES  TO thotor;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS  TO thotor;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO thotor;


--
-- PostgreSQL database dump complete
--

