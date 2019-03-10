--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases
--

DROP DATABASE alastair;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md53175bce1d3201d16594cebf9d7eb3f9d';






--
-- Database creation
--

CREATE DATABASE alastair WITH TEMPLATE = template0 OWNER = postgres;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect alastair

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: approval_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE approval_state AS ENUM (
    'accepted',
    'rejected',
    'requesting'
);


ALTER TYPE approval_state OWNER TO postgres;

--
-- Name: permission_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE permission_type AS ENUM (
    'user',
    'body',
    'role'
);


ALTER TYPE permission_type OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE admins (
    id integer NOT NULL,
    user_id character varying(255),
    active boolean,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: currencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE currencies (
    id integer NOT NULL,
    name character varying(255),
    display_code character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE currencies OWNER TO postgres;

--
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE currencies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE currencies_id_seq OWNER TO postgres;

--
-- Name: currencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE currencies_id_seq OWNED BY currencies.id;


--
-- Name: event_editors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE event_editors (
    id integer NOT NULL,
    event_id integer,
    user_id character varying(255)
);


ALTER TABLE event_editors OWNER TO postgres;

--
-- Name: event_editors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE event_editors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_editors_id_seq OWNER TO postgres;

--
-- Name: event_editors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE event_editors_id_seq OWNED BY event_editors.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events (
    id integer NOT NULL,
    name character varying(255),
    shop_id integer
);


ALTER TABLE events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: ingredient_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ingredient_requests (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    requested_by character varying(255),
    admin_message character varying(255),
    request_message character varying(255),
    default_measurement_id integer,
    approval_state approval_state,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ingredient_requests OWNER TO postgres;

--
-- Name: ingredient_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ingredient_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ingredient_requests_id_seq OWNER TO postgres;

--
-- Name: ingredient_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ingredient_requests_id_seq OWNED BY ingredient_requests.id;


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ingredients (
    id integer NOT NULL,
    name character varying(255),
    description text,
    default_measurement_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ingredients OWNER TO postgres;

--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ingredients_id_seq OWNER TO postgres;

--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ingredients_id_seq OWNED BY ingredients.id;


--
-- Name: meals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE meals (
    id integer NOT NULL,
    name character varying(255),
    "time" time without time zone,
    date date,
    event_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE meals OWNER TO postgres;

--
-- Name: meals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE meals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE meals_id_seq OWNER TO postgres;

--
-- Name: meals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE meals_id_seq OWNED BY meals.id;


--
-- Name: meals_recipes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE meals_recipes (
    id integer NOT NULL,
    person_count integer,
    meal_id integer,
    recipe_id integer
);


ALTER TABLE meals_recipes OWNER TO postgres;

--
-- Name: meals_recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE meals_recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE meals_recipes_id_seq OWNER TO postgres;

--
-- Name: meals_recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE meals_recipes_id_seq OWNED BY meals_recipes.id;


--
-- Name: measurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE measurements (
    id integer NOT NULL,
    name character varying(255),
    plural_name character varying(255),
    display_code character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE measurements OWNER TO postgres;

--
-- Name: measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE measurements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE measurements_id_seq OWNER TO postgres;

--
-- Name: measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE measurements_id_seq OWNED BY measurements.id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE recipes (
    id integer NOT NULL,
    name character varying(255),
    description text,
    person_count integer,
    instructions text,
    published boolean,
    created_by character varying(255),
    version integer,
    root_version_id integer,
    avg_review double precision,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE recipes OWNER TO postgres;

--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recipes_id_seq OWNER TO postgres;

--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE recipes_id_seq OWNED BY recipes.id;


--
-- Name: recipes_ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE recipes_ingredients (
    id integer NOT NULL,
    quantity double precision,
    comment character varying(255),
    recipe_id integer,
    ingredient_id integer
);


ALTER TABLE recipes_ingredients OWNER TO postgres;

--
-- Name: recipes_ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE recipes_ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recipes_ingredients_id_seq OWNER TO postgres;

--
-- Name: recipes_ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE recipes_ingredients_id_seq OWNED BY recipes_ingredients.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reviews (
    id integer NOT NULL,
    rating integer,
    review text,
    recipe_id integer,
    user_id character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reviews_id_seq OWNED BY reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: shop_admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE shop_admins (
    id integer NOT NULL,
    user_id character varying(255),
    shop_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE shop_admins OWNER TO postgres;

--
-- Name: shop_admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE shop_admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop_admins_id_seq OWNER TO postgres;

--
-- Name: shop_admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE shop_admins_id_seq OWNED BY shop_admins.id;


--
-- Name: shopping_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE shopping_items (
    id integer NOT NULL,
    name character varying(255),
    comment character varying(255),
    buying_quantity double precision,
    flexible_amount boolean,
    price double precision,
    mapped_ingredient_id integer,
    shop_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE shopping_items OWNER TO postgres;

--
-- Name: shopping_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE shopping_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shopping_items_id_seq OWNER TO postgres;

--
-- Name: shopping_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE shopping_items_id_seq OWNED BY shopping_items.id;


--
-- Name: shopping_list_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE shopping_list_notes (
    id integer NOT NULL,
    event_id integer,
    ingredient_id integer,
    ticked boolean,
    bought double precision,
    shopping_item_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE shopping_list_notes OWNER TO postgres;

--
-- Name: shopping_list_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE shopping_list_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shopping_list_notes_id_seq OWNER TO postgres;

--
-- Name: shopping_list_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE shopping_list_notes_id_seq OWNED BY shopping_list_notes.id;


--
-- Name: shops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE shops (
    id integer NOT NULL,
    name character varying(255),
    location character varying(255),
    currency_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE shops OWNER TO postgres;

--
-- Name: shops_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE shops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shops_id_seq OWNER TO postgres;

--
-- Name: shops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE shops_id_seq OWNED BY shops.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: currencies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY currencies ALTER COLUMN id SET DEFAULT nextval('currencies_id_seq'::regclass);


--
-- Name: event_editors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_editors ALTER COLUMN id SET DEFAULT nextval('event_editors_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: ingredient_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingredient_requests ALTER COLUMN id SET DEFAULT nextval('ingredient_requests_id_seq'::regclass);


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingredients ALTER COLUMN id SET DEFAULT nextval('ingredients_id_seq'::regclass);


--
-- Name: meals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meals ALTER COLUMN id SET DEFAULT nextval('meals_id_seq'::regclass);


--
-- Name: meals_recipes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meals_recipes ALTER COLUMN id SET DEFAULT nextval('meals_recipes_id_seq'::regclass);


--
-- Name: measurements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY measurements ALTER COLUMN id SET DEFAULT nextval('measurements_id_seq'::regclass);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipes ALTER COLUMN id SET DEFAULT nextval('recipes_id_seq'::regclass);


--
-- Name: recipes_ingredients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipes_ingredients ALTER COLUMN id SET DEFAULT nextval('recipes_ingredients_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reviews ALTER COLUMN id SET DEFAULT nextval('reviews_id_seq'::regclass);


--
-- Name: shop_admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shop_admins ALTER COLUMN id SET DEFAULT nextval('shop_admins_id_seq'::regclass);


--
-- Name: shopping_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_items ALTER COLUMN id SET DEFAULT nextval('shopping_items_id_seq'::regclass);


--
-- Name: shopping_list_notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_list_notes ALTER COLUMN id SET DEFAULT nextval('shopping_list_notes_id_seq'::regclass);


--
-- Name: shops id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shops ALTER COLUMN id SET DEFAULT nextval('shops_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY admins (id, user_id, active, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY currencies (id, name, display_code, inserted_at, updated_at) FROM stdin;
1	Romanian Lei	lei	2018-06-28 11:53:48.918969	2018-06-28 11:53:48.930559
2	Hungarian forint	Ft	2018-06-28 11:53:48.961584	2018-06-28 11:53:48.961592
3	US Dollar	$	2018-06-28 11:53:48.973692	2018-06-28 11:53:48.973702
4	Swiss Franc	Fr	2018-06-28 11:53:48.992409	2018-06-28 11:53:48.992418
5	Bulgarian lev	лв	2018-06-28 11:53:49.010629	2018-06-28 11:53:49.010637
6	British Pound	£	2018-06-28 11:53:49.028889	2018-06-28 11:53:49.028895
7	Ukrainian hryvnia	₴	2018-06-28 11:53:49.047348	2018-06-28 11:53:49.047354
8	Turkish lira	₺	2018-06-28 11:53:49.066033	2018-06-28 11:53:49.066039
9	Russian ruble	₽	2018-06-28 11:53:49.093791	2018-06-28 11:53:49.093798
10	Moldovan leu	L	2018-06-28 11:53:49.11101	2018-06-28 11:53:49.111017
11	Czech koruna	Kč	2018-06-28 11:53:49.123673	2018-06-28 11:53:49.123682
12	Polish złoty	zł	2018-06-28 11:53:49.140478	2018-06-28 11:53:49.140486
13	Danish krone	kr	2018-06-28 11:53:49.157609	2018-06-28 11:53:49.157615
14	Croatian kuna	kn	2018-06-28 11:53:49.174532	2018-06-28 11:53:49.174537
15	Serbian dinar	din.	2018-06-28 11:53:49.191747	2018-06-28 11:53:49.191753
16	Swedish krona	kr	2018-06-28 11:53:49.233553	2018-06-28 11:53:49.233564
17	Euro	€	2018-06-28 11:53:49.267345	2018-06-28 11:53:49.267353
\.


--
-- Data for Name: event_editors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY event_editors (id, event_id, user_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
10	10	1
11	11	1
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY events (id, name, shop_id) FROM stdin;
2	\N	\N
3	\N	\N
4	event name	\N
5	event name 2	\N
1	SU: Beercome a Changemaker	1
6	test	\N
7	test 2	\N
8	test 3	\N
9	test-4	\N
10	Test 4	\N
11	Test	\N
\.


--
-- Data for Name: ingredient_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ingredient_requests (id, name, description, requested_by, admin_message, request_message, default_measurement_id, approval_state, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ingredients (id, name, description, default_measurement_id, inserted_at, updated_at) FROM stdin;
1	Almond Extract	\N	3	2018-06-28 11:53:49.357896	2018-06-28 11:53:49.357905
2	Almond Milk	\N	1	2018-06-28 11:53:49.372972	2018-06-28 11:53:49.372982
3	Almonds	\N	3	2018-06-28 11:53:49.385484	2018-06-28 11:53:49.385493
4	Ancho Chillies	\N	5	2018-06-28 11:53:49.399338	2018-06-28 11:53:49.399348
5	Anchovy Fillet	\N	3	2018-06-28 11:53:49.41139	2018-06-28 11:53:49.411398
6	Apple Cider Vinegar	\N	1	2018-06-28 11:53:49.420451	2018-06-28 11:53:49.420461
8	Apricot	\N	3	2018-06-28 11:53:49.439575	2018-06-28 11:53:49.439588
9	Apricot Jam	\N	3	2018-06-28 11:53:49.476577	2018-06-28 11:53:49.476592
10	Asparagus	\N	3	2018-06-28 11:53:49.568565	2018-06-28 11:53:49.568576
11	Aubergine	\N	5	2018-06-28 11:53:49.610678	2018-06-28 11:53:49.610689
12	Avocado	\N	5	2018-06-28 11:53:50.137124	2018-06-28 11:53:50.137132
15	Baby Squid		3	2018-06-28 11:53:51.240511	2018-06-28 11:53:51.240546
16	Bacon	\N	3	2018-06-28 11:53:51.362984	2018-06-28 11:53:51.362992
17	Baguette	\N	3	2018-06-28 11:53:51.481767	2018-06-28 11:53:51.481777
18	Baked Beans	\N	3	2018-06-28 11:53:51.60051	2018-06-28 11:53:51.600537
19	Baking Powder	\N	3	2018-06-28 11:53:51.652092	2018-06-28 11:53:51.652098
20	Balsamic Vinegar	\N	1	2018-06-28 11:53:51.703817	2018-06-28 11:53:51.703825
21	Banana	\N	3	2018-06-28 11:53:51.753238	2018-06-28 11:53:51.753245
22	Barbeque Sauce	\N	1	2018-06-28 11:53:51.814163	2018-06-28 11:53:51.81417
23	Basil	\N	3	2018-06-28 11:53:51.907869	2018-06-28 11:53:51.9079
24	Basil Leaves	\N	5	2018-06-28 11:53:52.020398	2018-06-28 11:53:52.020406
25	Basmati Rice	\N	3	2018-06-28 11:53:52.166316	2018-06-28 11:53:52.166323
27	Bay Leaves	\N	5	2018-06-28 11:53:52.318551	2018-06-28 11:53:52.318582
28	Beef	\N	3	2018-06-28 11:53:52.330886	2018-06-28 11:53:52.330893
29	Beef Brisket	\N	3	2018-06-28 11:53:52.342899	2018-06-28 11:53:52.342919
30	Beef Fillet	\N	3	2018-06-28 11:53:52.379935	2018-06-28 11:53:52.379943
31	Beef Gravy	\N	3	2018-06-28 11:53:52.426552	2018-06-28 11:53:52.426559
32	Beef Kidney	\N	3	2018-06-28 11:53:52.466638	2018-06-28 11:53:52.466647
33	Beef Shin	\N	3	2018-06-28 11:53:52.507467	2018-06-28 11:53:52.507477
34	Beef Stock	\N	3	2018-06-28 11:53:52.60356	2018-06-28 11:53:52.603568
35	Bicarbonate Of Soda	\N	3	2018-06-28 11:53:52.614066	2018-06-28 11:53:52.614082
36	Biryani Masala	\N	3	2018-06-28 11:53:52.627096	2018-06-28 11:53:52.627104
37	Black Olives	\N	3	2018-06-28 11:53:52.637783	2018-06-28 11:53:52.637791
39	Black Pudding	\N	3	2018-06-28 11:53:52.661684	2018-06-28 11:53:52.66169
40	Black Treacle	\N	3	2018-06-28 11:53:52.673492	2018-06-28 11:53:52.673499
41	Blackberries	\N	3	2018-06-28 11:53:52.683054	2018-06-28 11:53:52.68306
42	Blue Food Colouring	\N	3	2018-06-28 11:53:52.694577	2018-06-28 11:53:52.694584
43	Blueberries	\N	3	2018-06-28 11:53:52.701106	2018-06-28 11:53:52.701113
44	Borlotti Beans	\N	3	2018-06-28 11:53:52.711795	2018-06-28 11:53:52.7118
45	Bouquet Garni	\N	3	2018-06-28 11:53:52.736731	2018-06-28 11:53:52.736736
46	Bowtie Pasta	\N	3	2018-06-28 11:53:52.74449	2018-06-28 11:53:52.744495
49	Brandy	\N	1	2018-06-28 11:53:52.774636	2018-06-28 11:53:52.774642
50	Bread	\N	3	2018-06-28 11:53:52.78596	2018-06-28 11:53:52.785965
51	Breadcrumbs	\N	3	2018-06-28 11:53:52.794129	2018-06-28 11:53:52.794135
52	Brie	\N	3	2018-06-28 11:53:52.804596	2018-06-28 11:53:52.804602
54	Broccoli	\N	3	2018-06-28 11:53:52.836009	2018-06-28 11:53:52.836014
55	Brown Lentils	\N	3	2018-06-28 11:53:52.844543	2018-06-28 11:53:52.844549
56	Brown Rice	\N	3	2018-06-28 11:53:52.854651	2018-06-28 11:53:52.854658
57	Brown Sugar	\N	3	2018-06-28 11:53:52.863173	2018-06-28 11:53:52.863178
58	Brussels Sprouts	\N	3	2018-06-28 11:53:52.871875	2018-06-28 11:53:52.871885
59	Butter	\N	3	2018-06-28 11:53:52.88391	2018-06-28 11:53:52.883915
60	Butter Beans	\N	3	2018-06-28 11:53:52.892165	2018-06-28 11:53:52.89217
61	Butternut Squash	\N	3	2018-06-28 11:53:52.900878	2018-06-28 11:53:52.900884
62	Cabbage	\N	3	2018-06-28 11:53:52.908994	2018-06-28 11:53:52.909
63	Cacao	\N	3	2018-06-28 11:53:52.917503	2018-06-28 11:53:52.917509
64	Cajun	\N	3	2018-06-28 11:53:52.931462	2018-06-28 11:53:52.931469
65	Canned Tomatoes	\N	3	2018-06-28 11:53:52.942913	2018-06-28 11:53:52.942921
66	Cannellini Beans	\N	3	2018-06-28 11:53:52.953867	2018-06-28 11:53:52.953872
67	Canola Oil	\N	1	2018-06-28 11:53:52.965116	2018-06-28 11:53:52.965122
68	Capers	\N	3	2018-06-28 11:53:52.973656	2018-06-28 11:53:52.973663
69	Caramel	\N	3	2018-06-28 11:53:52.98229	2018-06-28 11:53:52.982295
70	Caramel Sauce	\N	1	2018-06-28 11:53:52.990693	2018-06-28 11:53:52.9907
71	Cardamom	\N	3	2018-06-28 11:53:53.001364	2018-06-28 11:53:53.001377
72	Carrots	\N	3	2018-06-28 11:53:53.009043	2018-06-28 11:53:53.009056
74	Cashews	\N	3	2018-06-28 11:53:53.02868	2018-06-28 11:53:53.028689
76	Cayenne Pepper	\N	3	2018-06-28 11:53:53.051291	2018-06-28 11:53:53.051296
77	Celeriac	\N	3	2018-06-28 11:53:53.061246	2018-06-28 11:53:53.061252
78	Celery	\N	3	2018-06-28 11:53:53.071837	2018-06-28 11:53:53.071844
79	Celery Salt	\N	3	2018-06-28 11:53:53.092172	2018-06-28 11:53:53.09218
80	Challots	\N	3	2018-06-28 11:53:53.099676	2018-06-28 11:53:53.099774
82	Cheddar Cheese	\N	3	2018-06-28 11:53:53.116585	2018-06-28 11:53:53.116598
83	Cheese	\N	3	2018-06-28 11:53:53.125214	2018-06-28 11:53:53.125221
84	Cheese Curds	\N	3	2018-06-28 11:53:53.133538	2018-06-28 11:53:53.133544
85	Cherry	\N	3	2018-06-28 11:53:53.147814	2018-06-28 11:53:53.147822
86	Cherry Tomatoes	\N	3	2018-06-28 11:53:53.15877	2018-06-28 11:53:53.158775
87	Chestnut Mushroom	\N	3	2018-06-28 11:53:53.167295	2018-06-28 11:53:53.167303
88	Chestnuts	\N	3	2018-06-28 11:53:53.175757	2018-06-28 11:53:53.175764
89	Chicken	\N	3	2018-06-28 11:53:53.18434	2018-06-28 11:53:53.184347
90	Chicken Breast	\N	3	2018-06-28 11:53:53.192968	2018-06-28 11:53:53.192973
92	Chicken Legs	\N	3	2018-06-28 11:53:53.210126	2018-06-28 11:53:53.210134
93	Chicken Stock	\N	3	2018-06-28 11:53:53.218535	2018-06-28 11:53:53.218541
94	Chicken Stock Cube	\N	3	2018-06-28 11:53:53.22606	2018-06-28 11:53:53.226066
95	Chicken Thighs	\N	3	2018-06-28 11:53:53.234451	2018-06-28 11:53:53.234458
96	Chickpeas	\N	3	2018-06-28 11:53:53.243318	2018-06-28 11:53:53.243324
97	Chili Powder	\N	3	2018-06-28 11:53:53.251929	2018-06-28 11:53:53.251934
99	Chilli	\N	3	2018-06-28 11:53:53.273117	2018-06-28 11:53:53.273124
100	Chilli Powder	\N	3	2018-06-28 11:53:53.2865	2018-06-28 11:53:53.286508
101	Chinese Broccoli	\N	3	2018-06-28 11:53:53.296896	2018-06-28 11:53:53.296901
102	Chives	\N	3	2018-06-28 11:53:53.308384	2018-06-28 11:53:53.308389
103	Chocolate Chips	\N	3	2018-06-28 11:53:53.316923	2018-06-28 11:53:53.316928
105	Chopped Parsley	\N	3	2018-06-28 11:53:53.343018	2018-06-28 11:53:53.343024
107	Chorizo	\N	3	2018-06-28 11:53:53.36037	2018-06-28 11:53:53.360381
48	Apples	\N	3	2018-06-28 11:53:52.765414	2018-07-07 19:16:07.564365
108	Christmas Pudding	\N	3	2018-06-28 11:53:53.368736	2018-06-28 11:53:53.368744
118	Colby Jack Cheese	\N	3	2018-06-28 11:53:53.457806	2018-06-28 11:53:53.457812
128	Couscous	\N	3	2018-06-28 11:53:53.558629	2018-06-28 11:53:53.558634
138	Curry Powder	\N	3	2018-06-28 11:53:53.643924	2018-06-28 11:53:53.643929
158	Duck	\N	3	2018-06-28 11:53:53.82674	2018-06-28 11:53:53.826746
168	Extra Virgin Olive Oil	\N	1	2018-06-28 11:53:53.916441	2018-06-28 11:53:53.916447
178	Fish Sauce	\N	1	2018-06-28 11:53:54.018118	2018-06-28 11:53:54.018126
188	Fresh Basil	\N	3	2018-06-28 11:53:54.103941	2018-06-28 11:53:54.103948
198	Garlic Clove	\N	5	2018-06-28 11:53:54.192444	2018-06-28 11:53:54.19245
208	Goats Cheese	\N	3	2018-06-28 11:53:54.286036	2018-06-28 11:53:54.286043
218	Green Pepper	\N	3	2018-06-28 11:53:54.373241	2018-06-28 11:53:54.373247
228	Haricot Beans	\N	3	2018-06-28 11:53:54.466202	2018-06-28 11:53:54.466208
248	Lamb	\N	3	2018-06-28 11:53:55.102513	2018-06-28 11:53:55.102521
258	Lemon Juice	\N	1	2018-06-28 11:53:56.11199	2018-06-28 11:53:56.111996
268	Madras Paste	\N	3	2018-06-28 11:53:56.213145	2018-06-28 11:53:56.21315
278	Milk Chocolate	\N	3	2018-06-28 11:53:56.321056	2018-06-28 11:53:56.321063
288	Monterey Jack Cheese	\N	3	2018-06-28 11:53:56.414938	2018-06-28 11:53:56.414944
298	Nutmeg	\N	3	2018-06-28 11:53:56.509166	2018-06-28 11:53:56.509171
308	Oregano	\N	3	2018-06-28 11:53:56.604767	2018-06-28 11:53:56.604773
318	Parmesan Cheese	\N	3	2018-06-28 11:53:56.693981	2018-06-28 11:53:56.693987
328	Pears	\N	3	2018-06-28 11:53:56.785861	2018-06-28 11:53:56.785867
338	Pitted Black Olives	\N	3	2018-06-28 11:53:56.884337	2018-06-28 11:53:56.884342
348	Puff Pastry	\N	3	2018-06-28 11:53:56.968802	2018-06-28 11:53:56.968808
358	Red Food Colouring	\N	3	2018-06-28 11:53:57.058907	2018-06-28 11:53:57.058916
368	Rice	\N	3	2018-06-28 11:53:57.149517	2018-06-28 11:53:57.149524
378	Rosemary	\N	3	2018-06-28 11:53:57.238038	2018-06-28 11:53:57.238057
388	Sausages	\N	3	2018-06-28 11:53:57.332352	2018-06-28 11:53:57.332358
398	Shortcrust Pastry	\N	3	2018-06-28 11:53:57.472207	2018-06-28 11:53:57.472213
408	Soya Milk	\N	1	2018-06-28 11:53:57.586328	2018-06-28 11:53:57.586335
418	Sugar Snap Peas	\N	3	2018-06-28 11:53:57.69882	2018-06-28 11:53:57.698829
428	Thai Green Curry Paste	\N	3	2018-06-28 11:53:57.790254	2018-06-28 11:53:57.790259
438	Tomato Sauce	\N	1	2018-06-28 11:53:57.883345	2018-06-28 11:53:57.88335
448	Turnips	\N	3	2018-06-28 11:53:57.976871	2018-06-28 11:53:57.976878
468	White Fish	\N	3	2018-06-28 11:53:58.155295	2018-06-28 11:53:58.155302
478	Worcestershire Sauce	\N	1	2018-06-28 11:53:58.331743	2018-06-28 11:53:58.331749
109	Cilantro	\N	3	2018-06-28 11:53:53.377511	2018-06-28 11:53:53.377516
119	Cold Water	\N	1	2018-06-28 11:53:53.466528	2018-06-28 11:53:53.466536
129	Cream	\N	1	2018-06-28 11:53:53.567139	2018-06-28 11:53:53.567144
139	Custard	\N	3	2018-06-28 11:53:53.652481	2018-06-28 11:53:53.652488
149	Digestive Biscuits	\N	3	2018-06-28 11:53:53.742216	2018-06-28 11:53:53.742222
159	Duck Fat	\N	3	2018-06-28 11:53:53.835284	2018-06-28 11:53:53.835289
169	Fajita Seasoning	\N	3	2018-06-28 11:53:53.924998	2018-06-28 11:53:53.925005
179	Fish Stock		3	2018-06-28 11:53:54.026558	2018-06-28 11:53:54.026565
189	Fresh Thyme	\N	3	2018-06-28 11:53:54.116107	2018-06-28 11:53:54.116113
199	Garlic Powder	\N	3	2018-06-28 11:53:54.200957	2018-06-28 11:53:54.201044
209	Golden Syrup	\N	1	2018-06-28 11:53:54.294604	2018-06-28 11:53:54.294611
219	Green Red Lentils	\N	3	2018-06-28 11:53:54.381625	2018-06-28 11:53:54.381631
229	Harissa Spice	\N	3	2018-06-28 11:53:54.474684	2018-06-28 11:53:54.47469
239	Italian Seasoning	\N	3	2018-06-28 11:53:54.560062	2018-06-28 11:53:54.560068
249	Lamb Kidney	\N	3	2018-06-28 11:53:55.342244	2018-06-28 11:53:55.342252
259	Lemon Zest	\N	3	2018-06-28 11:53:56.123224	2018-06-28 11:53:56.12323
269	Malt Vinegar	Vinegar is a liquid consisting of about 5–20% acetic acid (CH3COOH), water, and other trace chemicals, which may include flavorings. The acetic acid is produced by the fermentation of ethanol by acetic acid bacteria. Vinegar is now mainly used as a cooking ingredient, or in pickling. As the most easily manufactured mild acid, it has historically had a great variety of industrial, medical, and domestic uses, some of which (such as its use as a general household cleaner) are still commonly practiced today.\r\n\r\nCommercial vinegar is produced either by a fast or a slow fermentation process. In general, slow methods are used in traditional vinegars where fermentation proceeds slowly over the course of a few months or up to a year. The longer fermentation period allows for the accumulation of a non-toxic slime composed of acetic acid bacteria. Fast methods add mother of vinegar (bacterial culture) to the source liquid before adding air to oxygenate and promote the fastest fermentation. In fast production processes, vinegar may be produced between 20 hours to three days.	1	2018-06-28 11:53:56.224324	2018-06-28 11:53:56.224331
279	Minced Beef	\N	3	2018-06-28 11:53:56.331886	2018-06-28 11:53:56.331891
289	Mozzarella	\N	3	2018-06-28 11:53:56.423268	2018-06-28 11:53:56.423272
299	Oatmeal	\N	3	2018-06-28 11:53:56.525593	2018-06-28 11:53:56.525602
309	Oxtail	Oxtail (occasionally spelled ox tail or ox-tail) is the culinary name for the tail of cattle. Formerly, it referred only to the tail of an ox or steer, a bullock (a castrated male).[citation needed] An oxtail typically weighs 2 to 4 lbs. (1–1.8 kg) and is skinned and cut into short lengths for sale.\r\n\r\nOxtail is a bony, gelatin-rich meat, which is usually slow-cooked as a stew[1] or braised. It is a traditional stock base for a soup. Traditional preparations involve slow cooking, so some modern recipes take a shortcut using a pressure cooker. Oxtail is the main ingredient of the Italian dish coda alla vaccinara (a classic of Roman cuisine). It is a popular flavour for powder, instant and premade canned soups in the United Kingdom and Ireland. Oxtails are also one of the popular bases for Russian aspic appetizer dishes (холодец or студень), along with pig trotters or ears or cow "knees", but are the preferred ingredients among Russian Jews because they can be Kosher.\r\n\r\nVersions of oxtail soup are popular traditional dishes in South America, West Africa, China, Spain [2] and Indonesia. In Chinese cuisine, it's usually made into a soup called 牛尾汤 (niúwěi tāng, "oxtail soup"). In Korean cuisine, a soup made with oxtail is called kkori gomtang (see gomguk). It is a thick soup seasoned with salt and eaten with a bowl of rice. It can be used as a stock for making tteokguk (rice cake soup). Stewed oxtail with butter bean or as main dish (with rice) is popular in Jamaica, Trinidad, and other West Indian cultures. Oxtail is also very popular in South Africa where it is often cooked in a traditional skillet called a potjie, which is a three-legged cast iron pot placed over an open fire. Oxtail is also eaten in other southern parts of Africa like Zimbabwe and served with sadza and greens. In the United States, oxtail is a mainstay in African American and West Indian households. In Cuban cuisine, a stew can be made from oxtail called rabo encendido. In the Philippines, it is prepared in a peanut based stew called Kare-kare. In Iran, Oxtail is slow-cooked and served as a substitute for shank in a main dish called Baghla-Poli-Mahicheh which is prepared with rice, shank (or oxtail) and a mixture of herbs including dill, coriander, parsley and garlic.\r\n\r\nIn the United States, oxtail has the meat-cutting classification NAMP 1791.	3	2018-06-28 11:53:56.616586	2018-06-28 11:53:56.616591
319	Parmigiano-reggiano	\N	3	2018-06-28 11:53:56.70247	2018-06-28 11:53:56.702476
329	Peas	\N	3	2018-06-28 11:53:56.79432	2018-06-28 11:53:56.794324
339	Plain Chocolate	\N	3	2018-06-28 11:53:56.890048	2018-06-28 11:53:56.890054
349	Pumpkin	\N	3	2018-06-28 11:53:56.977475	2018-06-28 11:53:56.977482
359	Red Onions	\N	3	2018-06-28 11:53:57.067239	2018-06-28 11:53:57.067247
369	Rice Noodles	\N	3	2018-06-28 11:53:57.15807	2018-06-28 11:53:57.158076
379	Rosemary	\N	3	2018-06-28 11:53:57.246605	2018-06-28 11:53:57.246612
389	Scallions	Scallions (green onion, spring onion and salad onion) are vegetables of various Allium onion species. Scallions have a milder taste than most onions. Their close relatives include the garlic, shallot, leek, chive, and Chinese onion.\r\n\r\nAlthough the bulbs of many Allium species are used as food, the defining characteristic of scallion species is that they lack a fully developed bulb. In common with all Allium species, scallions have hollow, tubular green leaves, growing directly from the bulb. These leaves are used as a vegetable; they are eaten either raw or cooked. The leaves are often chopped into other dishes, in the manner of onions or garlic. Also known as scallions or green onions, spring onions are in fact very young onions, harvested before the bulb has had a chance to swell.	3	2018-06-28 11:53:57.341068	2018-06-28 11:53:57.341074
399	Shredded Mexican Cheese	\N	3	2018-06-28 11:53:57.480593	2018-06-28 11:53:57.480599
409	Spaghetti	\N	3	2018-06-28 11:53:57.595439	2018-06-28 11:53:57.595446
419	Sultanas	\N	3	2018-06-28 11:53:57.709461	2018-06-28 11:53:57.709468
429	Thai Red Curry Paste	\N	3	2018-06-28 11:53:57.79865	2018-06-28 11:53:57.798655
439	Tomatoes	\N	3	2018-06-28 11:53:57.891845	2018-06-28 11:53:57.89185
449	Udon Noodles	\N	3	2018-06-28 11:53:57.985322	2018-06-28 11:53:57.985329
459	Vinaigrette Dressing	\N	1	2018-06-28 11:53:58.078426	2018-06-28 11:53:58.078432
469	White Fish Fillets	\N	3	2018-06-28 11:53:58.163482	2018-06-28 11:53:58.163488
479	Yeast	\N	3	2018-06-28 11:53:58.340407	2018-06-28 11:53:58.340412
110	Cinnamon	\N	3	2018-06-28 11:53:53.38595	2018-06-28 11:53:53.385956
120	Condensed Milk	\N	1	2018-06-28 11:53:53.474908	2018-06-28 11:53:53.474913
130	Cream Cheese	\N	3	2018-06-28 11:53:53.575587	2018-06-28 11:53:53.575592
140	Custard Powder	\N	3	2018-06-28 11:53:53.661024	2018-06-28 11:53:53.661031
150	Dijon Mustard	\N	3	2018-06-28 11:53:53.750495	2018-06-28 11:53:53.7505
160	Duck Legs	\N	3	2018-06-28 11:53:53.843737	2018-06-28 11:53:53.843743
170	Farfalle	\N	3	2018-06-28 11:53:53.933479	2018-06-28 11:53:53.933484
180	Flaked Almonds	\N	3	2018-06-28 11:53:54.035	2018-06-28 11:53:54.035007
190	Freshly Chopped Parsley	\N	3	2018-06-28 11:53:54.124871	2018-06-28 11:53:54.124877
200	Garlic Sauce	\N	1	2018-06-28 11:53:54.213913	2018-06-28 11:53:54.213918
210	Goose Fat	\N	3	2018-06-28 11:53:54.303162	2018-06-28 11:53:54.303168
220	Green Salsa	\N	1	2018-06-28 11:53:54.389928	2018-06-28 11:53:54.389934
230	Hazlenuts	\N	3	2018-06-28 11:53:54.483239	2018-06-28 11:53:54.483246
240	Jalapeno	\N	3	2018-06-28 11:53:54.568646	2018-06-28 11:53:54.568652
250	Lamb Leg	\N	3	2018-06-28 11:53:55.466009	2018-06-28 11:53:55.466018
260	Lemons	\N	3	2018-06-28 11:53:56.13335	2018-06-28 11:53:56.133356
270	Maple Syrup	\N	1	2018-06-28 11:53:56.232252	2018-06-28 11:53:56.232259
280	Minced Garlic	\N	3	2018-06-28 11:53:56.340553	2018-06-28 11:53:56.34056
290	Mozzarella Balls	\N	3	2018-06-28 11:53:56.431935	2018-06-28 11:53:56.431941
300	Oats	\N	3	2018-06-28 11:53:56.53418	2018-06-28 11:53:56.534185
310	Oyster Sauce	\N	1	2018-06-28 11:53:56.625079	2018-06-28 11:53:56.625085
320	Parsley	\N	3	2018-06-28 11:53:56.711016	2018-06-28 11:53:56.711022
330	Pecan Nuts	\N	3	2018-06-28 11:53:56.806376	2018-06-28 11:53:56.806383
340	Plain Flour	\N	3	2018-06-28 11:53:56.898375	2018-06-28 11:53:56.89838
350	Raisins	\N	3	2018-06-28 11:53:56.985943	2018-06-28 11:53:56.985949
360	Red Pepper	\N	3	2018-06-28 11:53:57.080013	2018-06-28 11:53:57.080021
370	Rice Stick Noodles	\N	3	2018-06-28 11:53:57.166636	2018-06-28 11:53:57.166642
380	Saffron	\N	3	2018-06-28 11:53:57.255108	2018-06-28 11:53:57.255115
390	Scotch Bonnet	Scotch bonnet, also known as bonney peppers, or Caribbean red peppers, is a variety of chili pepper named for its resemblance to a tam o' shanter hat. Also called ata rodo by Yoruba speakers of Nigeria, it is found mainly in the Caribbean islands; it is also found in Guyana (where it is called the ball-of-fire pepper), the Maldives Islands (where it is called githeyo mirus), Panama (where it is called aji chombo) and West Africa. Most Scotch bonnets have a heat rating of 100,000–350,000 Scoville units. For comparison, most jalapeño peppers have a heat rating of 2,500 to 8,000 on the Scoville scale. However, completely sweet varieties of Scotch bonnet are grown on some of the Caribbean islands, called cachucha peppers.\r\n\r\nThese peppers are used to flavour many different dishes and cuisines worldwide and are often used in hot sauces and condiments. The Scotch bonnet has a sweeter flavour and stouter shape, distinct from its habanero relative with which it is often confused, and gives jerk dishes (pork/chicken) and other Caribbean dishes their unique flavour. Scotch bonnets are mostly used in West African, Antiguan, Kittitian/Nevisian, Anguilan, Dominican, St. Lucian, St Vincentian, Grenadian, Trinidadian, Jamaican, Barbadian, Guyanese, Surinamese, Haitian and Cayman cuisines and pepper sauces, though they often show up in other Caribbean recipes. It is also used in Costa Rica and Panama for Caribbean-styled recipes such as rice and beans, Rondón, saus, beef patties, and Ceviche.\r\n\r\nFresh, ripe Scotch bonnets can change from green to yellow to scarlet red, however many other breeds of this pepper can ripen to orange, yellow, peach, or even a chocolate brown.	1	2018-06-28 11:53:57.353646	2018-06-28 11:53:57.353652
400	Shredded Monterey Jack Cheese	\N	3	2018-06-28 11:53:57.489282	2018-06-28 11:53:57.489288
410	Spinach	\N	3	2018-06-28 11:53:57.608283	2018-06-28 11:53:57.608291
420	Sun-Dried Tomatoes	\N	3	2018-06-28 11:53:57.721169	2018-06-28 11:53:57.721175
430	Thyme	\N	3	2018-06-28 11:53:57.807199	2018-06-28 11:53:57.807205
440	Toor Dal	\N	3	2018-06-28 11:53:57.90006	2018-06-28 11:53:57.900065
450	Unsalted Butter	\N	3	2018-06-28 11:53:57.993896	2018-06-28 11:53:57.993902
460	Vine Leaves	\N	3	2018-06-28 11:53:58.088059	2018-06-28 11:53:58.088064
470	White Flour	\N	3	2018-06-28 11:53:58.171966	2018-06-28 11:53:58.171971
480	Yellow Food Colouring	\N	3	2018-06-28 11:53:58.365716	2018-06-28 11:53:58.365722
111	Cinnamon Stick	\N	3	2018-06-28 11:53:53.394402	2018-06-28 11:53:53.394409
121	Coriander	\N	3	2018-06-28 11:53:53.485179	2018-06-28 11:53:53.485184
131	Creme Fraiche	\N	3	2018-06-28 11:53:53.584113	2018-06-28 11:53:53.584118
151	Dill	\N	3	2018-06-28 11:53:53.758971	2018-06-28 11:53:53.758977
171	Fennel	\N	3	2018-06-28 11:53:53.942075	2018-06-28 11:53:53.94208
181	Flax Eggs	\N	5	2018-06-28 11:53:54.043707	2018-06-28 11:53:54.043716
191	Fries	\N	3	2018-06-28 11:53:54.133357	2018-06-28 11:53:54.133363
201	Gelatine Leafs	\N	3	2018-06-28 11:53:54.226302	2018-06-28 11:53:54.226309
211	Gouda Cheese	\N	3	2018-06-28 11:53:54.312119	2018-06-28 11:53:54.312124
221	Ground Almonds	\N	3	2018-06-28 11:53:54.398803	2018-06-28 11:53:54.398808
231	Heavy Cream	\N	1	2018-06-28 11:53:54.491866	2018-06-28 11:53:54.491874
241	Jasmine Rice	\N	3	2018-06-28 11:53:54.577398	2018-06-28 11:53:54.577404
251	Lamb Loin Chops	\N	3	2018-06-28 11:53:55.53838	2018-06-28 11:53:55.538389
261	Lentils	\N	3	2018-06-28 11:53:56.14107	2018-06-28 11:53:56.141076
271	Marjoram	\N	3	2018-06-28 11:53:56.240636	2018-06-28 11:53:56.240643
281	Minced Pork	\N	3	2018-06-28 11:53:56.348925	2018-06-28 11:53:56.348932
301	Oil	\N	1	2018-06-28 11:53:56.5429	2018-06-28 11:53:56.542906
321	Passata	\N	3	2018-06-28 11:53:56.723834	2018-06-28 11:53:56.723862
331	Pecorino	\N	3	2018-06-28 11:53:56.815092	2018-06-28 11:53:56.815098
351	Rapeseed Oil	\N	1	2018-06-28 11:53:56.994546	2018-06-28 11:53:56.994553
361	Red Pepper Flakes	\N	3	2018-06-28 11:53:57.088299	2018-06-28 11:53:57.088305
371	Rice Vermicelli	\N	3	2018-06-28 11:53:57.175224	2018-06-28 11:53:57.175229
381	Sage	\N	3	2018-06-28 11:53:57.263492	2018-06-28 11:53:57.263498
391	Sea Salt	\N	3	2018-06-28 11:53:57.36653	2018-06-28 11:53:57.366538
401	Sichuan Pepper	Sichuan pepper, Sichuan peppercorn, or Szechuan pepper, is a commonly used spice in Chinese cuisine. It is derived from at least two species of the global genus Zanthoxylum, including Z. simulans and Z. bungeanum. The genus Zanthoxylum belongs in the rue or citrus family, and, despite its name, is not closely related to either black pepper nor the chili pepper.\r\n\r\nThe husk or hull (pericarp) around the seeds may be used whole, especially in Sichuan cuisine, and the finely ground powder is one of the ingredients for five-spice powder. It is also used in traditional Chinese medicine. The pericarp is most often used, but the leaves of various species are also used in some regions of China.\r\n\r\nAnother species of Zanthoxylum native to China, Z. schinifolium, called xiāng jiāo zi (香椒子, "aromatic peppercorn") or qīng huā jiāo (青花椒, "green flower pepper"), is used as a spice in Hebei.\r\n\r\nWhile the exact flavour and composition of different species from the genus Zanthoxylum vary, most share the same essential characteristics. So while the terms "Sichuan pepper" and sanshō may refer specifically to Z. simulans and Z. piperitum, respectively, the two are commonly used interchangeably.\r\n\r\nRelated species are used in the cuisines of Tibet, Bhutan, Nepal, Thailand, and India (the Konkani and Uttarakhandi people) and Toba Batak peoples. In Bhutan, this pepper is known as thingye and is used liberally in preparation of soups, gruels, and phaag sha paa (pork slices).[citation needed] In Nepal, timur is used in the popular foods momo, thukpa, chow mein, chicken chilli, and other meat dishes. It is also widely used in homemade pickles. People take timur as a medicine for stomach or digestion problems, in a preparation with cloves of garlic and mountain salt with warm water.	3	2018-06-28 11:53:57.497756	2018-06-28 11:53:57.497764
411	Spring Onions	\N	3	2018-06-28 11:53:57.621337	2018-06-28 11:53:57.621348
421	Sunflower Oil	\N	1	2018-06-28 11:53:57.729856	2018-06-28 11:53:57.729862
431	Tiger Prawns	\N	3	2018-06-28 11:53:57.815857	2018-06-28 11:53:57.815862
441	Tortillas	\N	3	2018-06-28 11:53:57.917084	2018-06-28 11:53:57.91709
451	Vanilla	\N	3	2018-06-28 11:53:58.002418	2018-06-28 11:53:58.002424
471	White Vinegar	\N	1	2018-06-28 11:53:58.180589	2018-06-28 11:53:58.180596
481	Yellow Pepper	\N	3	2018-06-28 11:53:58.39097	2018-06-28 11:53:58.390976
161	Egg Plants	\N	5	2018-06-28 11:53:53.852447	2018-07-01 10:36:14.214714
112	Clams	\N	3	2018-06-28 11:53:53.403053	2018-06-28 11:53:53.40306
122	Coriander Leaves	\N	3	2018-06-28 11:53:53.496469	2018-06-28 11:53:53.496477
132	Crusty Bread	\N	3	2018-06-28 11:53:53.592636	2018-06-28 11:53:53.592641
152	Doner Meat	\N	3	2018-06-28 11:53:53.767536	2018-06-28 11:53:53.767542
162	Egg Rolls	\N	3	2018-06-28 11:53:53.860921	2018-06-28 11:53:53.860926
182	Flour	\N	3	2018-06-28 11:53:54.052055	2018-06-28 11:53:54.052061
192	Fromage Frais	\N	3	2018-06-28 11:53:54.141814	2018-06-28 11:53:54.141822
202	Ghee	\N	3	2018-06-28 11:53:54.234684	2018-06-28 11:53:54.234689
212	Granulated Sugar	\N	3	2018-06-28 11:53:54.320467	2018-06-28 11:53:54.320473
222	Ground Beef	\N	3	2018-06-28 11:53:54.407196	2018-06-28 11:53:54.407201
232	Honey	\N	3	2018-06-28 11:53:54.500258	2018-06-28 11:53:54.500263
242	Jerusalem Artichokes	\N	3	2018-06-28 11:53:54.585819	2018-06-28 11:53:54.585825
252	Lamb Mince	\N	3	2018-06-28 11:53:55.663757	2018-06-28 11:53:55.663766
262	Lettuce	\N	3	2018-06-28 11:53:56.149764	2018-06-28 11:53:56.149769
272	Marzipan	\N	3	2018-06-28 11:53:56.252826	2018-06-28 11:53:56.252832
282	Miniature Marshmallows	\N	3	2018-06-28 11:53:56.360551	2018-06-28 11:53:56.360566
292	Mushrooms	\N	3	2018-06-28 11:53:56.449831	2018-06-28 11:53:56.44984
302	Olive Oil	\N	1	2018-06-28 11:53:56.553452	2018-06-28 11:53:56.553458
312	Paella Rice	Paella[a] is a Valencian rice dish that has ancient roots but its modern form originated in the mid-19th century in the area around Albufera lagoon on the east coast of Spain, adjacent to the city of Valencia. Many non-Spaniards view paella as Spain's national dish, but most Spaniards consider it to be a regional Valencian dish. Valencians, in turn, regard paella as one of their identifying symbols.\r\n\r\nTypes of paella include Valencian paella, vegetable paella (Spanish: paella de verduras), seafood paella (Spanish: paella de mariscos), and mixed paella (Spanish: paella mixta), among many others. Valencian paella is believed to be the original recipe and consists of white rice, green beans (bajoqueta and tavella), meat (chicken, duck and rabbit), white beans (garrofón), snails, and seasoning such as saffron and rosemary. Another very common but seasonal ingredient is artichokes. Seafood paella replaces meat with seafood and omits beans and green vegetables. Mixed paella is a free-style combination of meat from land animals, seafood, vegetables, and sometimes beans. Most paella chefs use bomba rice due to it being less likely to overcook, but Valencians tend to use a slightly stickier (and thus more susceptible to overcooking) variety known as Senia. All types of paellas use olive oil.	3	2018-06-28 11:53:56.642397	2018-06-28 11:53:56.642403
322	Peaches	\N	3	2018-06-28 11:53:56.732533	2018-06-28 11:53:56.732541
332	Penne Rigate	\N	3	2018-06-28 11:53:56.823885	2018-06-28 11:53:56.82389
342	Pork	\N	3	2018-06-28 11:53:56.915604	2018-06-28 11:53:56.915609
352	Raspberries	\N	3	2018-06-28 11:53:57.003133	2018-06-28 11:53:57.003139
362	Red Snapper	The northern red snapper (Lutjanus campechanus) is a species of snapper native to the western Atlantic Ocean including the Gulf of Mexico, where it inhabits environments associated with reefs. This species is commercially important and is also sought-after as a game fish.\r\n\r\nThe northern red snapper's body is very similar in shape to other snappers, such as the mangrove snapper, mutton snapper, lane snapper, and dog snapper. All feature a sloped profile, medium-to-large scales, a spiny dorsal fin, and a laterally compressed body. Northern red snapper have short, sharp, needle-like teeth, but they lack the prominent upper canine teeth found on the mutton, dog, and mangrove snappers. This snapper reaches maturity at a length of about 39 cm (15 in). The common adult length is 60 cm (24 in), but may reach 100 cm (39 in). The maximum published weight is 38 kg (84 lb), and the oldest reported age is 100+ years. Coloration of the northern red snapper is light red, with more intense pigment on the back. It has 10 dorsal spines, 14 soft dorsal rays, three anal spines and eight to 9 anal soft rays. Juvenile fish (shorter than 30–35 cm) can also have a dark spot on their sides, below the anterior soft dorsal rays, which fades with age.	3	2018-06-28 11:53:57.098399	2018-06-28 11:53:57.098406
372	Rice Vinegar	Rice vinegar is a vinegar made from fermented rice in China, Japan, Korea, and Vietnam.\r\n\r\nChinese rice vinegars are stronger than Japanese ones, and range in colour from clear to various shades of red, brown and black and are therefore known as rice wine vinegar. Chinese and especially Japanese vinegars are less acidic than the distilled Western vinegars which, for that reason, are not appropriate substitutes for rice vinegars. The majority of the Asian rice vinegar types are also more mild and sweet than vinegars typically used in the Western world, with black vinegars as a notable exception. Chinese rice vinegars are made from huangjiu, a type of rice wine.	1	2018-06-28 11:53:57.183626	2018-06-28 11:53:57.183632
382	Sake	\N	3	2018-06-28 11:53:57.271784	2018-06-28 11:53:57.271789
392	Self-raising Flour	\N	3	2018-06-28 11:53:57.400015	2018-06-28 11:53:57.400039
402	Single Cream	\N	3	2018-06-28 11:53:57.506468	2018-06-28 11:53:57.506475
412	Squid		3	2018-06-28 11:53:57.638605	2018-06-28 11:53:57.638614
422	Sweetcorn	\N	3	2018-06-28 11:53:57.738387	2018-06-28 11:53:57.738395
432	Tinned Tomatos	\N	3	2018-06-28 11:53:57.824346	2018-06-28 11:53:57.824352
442	Treacle	\N	3	2018-06-28 11:53:57.925443	2018-06-28 11:53:57.92545
452	Vanilla Extract	\N	3	2018-06-28 11:53:58.011013	2018-06-28 11:53:58.011019
462	Vinegar	\N	1	2018-06-28 11:53:58.104745	2018-06-28 11:53:58.104751
472	White Wine	\N	1	2018-06-28 11:53:58.196957	2018-06-28 11:53:58.196963
482	Yogurt	\N	3	2018-06-28 11:53:58.416117	2018-06-28 11:53:58.416123
113	Clotted Cream	\N	1	2018-06-28 11:53:53.411476	2018-06-28 11:53:53.411483
123	Coriander Seeds	\N	3	2018-06-28 11:53:53.508936	2018-06-28 11:53:53.508942
133	Cubed Feta Cheese	\N	3	2018-06-28 11:53:53.601201	2018-06-28 11:53:53.601208
143	Dark Chocolate	\N	3	2018-06-28 11:53:53.687158	2018-06-28 11:53:53.687164
153	Double Cream	\N	1	2018-06-28 11:53:53.780122	2018-06-28 11:53:53.780129
163	Egg White	\N	5	2018-06-28 11:53:53.869331	2018-06-28 11:53:53.869336
183	Flour Tortilla	\N	3	2018-06-28 11:53:54.060663	2018-06-28 11:53:54.060669
193	Frozen Peas	\N	3	2018-06-28 11:53:54.150606	2018-06-28 11:53:54.150614
203	Ginger	\N	3	2018-06-28 11:53:54.243135	2018-06-28 11:53:54.24314
223	Ground Cumin	\N	3	2018-06-28 11:53:54.415569	2018-06-28 11:53:54.415574
233	Horseradish	\N	3	2018-06-28 11:53:54.509015	2018-06-28 11:53:54.509023
243	Kale	\N	3	2018-06-28 11:53:54.594174	2018-06-28 11:53:54.594183
253	Lamb Shoulder	\N	3	2018-06-28 11:53:55.839141	2018-06-28 11:53:55.83915
273	Mascarpone	\N	3	2018-06-28 11:53:56.261226	2018-06-28 11:53:56.261231
283	Mint	\N	3	2018-06-28 11:53:56.369269	2018-06-28 11:53:56.369276
293	Mussels	\N	3	2018-06-28 11:53:56.459085	2018-06-28 11:53:56.45909
313	Paneer	\N	3	2018-06-28 11:53:56.650894	2018-06-28 11:53:56.6509
323	Peanut Brittle	\N	3	2018-06-28 11:53:56.742938	2018-06-28 11:53:56.742945
333	Pepper	\N	3	2018-06-28 11:53:56.833338	2018-06-28 11:53:56.833344
343	Potato Starch	\N	3	2018-06-28 11:53:56.924192	2018-06-28 11:53:56.924205
353	Raspberry Jam	\N	3	2018-06-28 11:53:57.011532	2018-06-28 11:53:57.011538
363	Red Wine	\N	1	2018-06-28 11:53:57.107211	2018-06-28 11:53:57.107219
373	Ricotta	\N	3	2018-06-28 11:53:57.19531	2018-06-28 11:53:57.195317
383	Salmon	\N	3	2018-06-28 11:53:57.280262	2018-06-28 11:53:57.280267
393	Semi-skimmed Milk	\N	1	2018-06-28 11:53:57.425489	2018-06-28 11:53:57.425496
413	Star Anise	\N	3	2018-06-28 11:53:57.648096	2018-06-28 11:53:57.648104
423	Tabasco Sauce	\N	1	2018-06-28 11:53:57.746895	2018-06-28 11:53:57.746901
433	Toffee Popcorn	\N	3	2018-06-28 11:53:57.832992	2018-06-28 11:53:57.832999
443	Truffle Oil	\N	1	2018-06-28 11:53:57.934116	2018-06-28 11:53:57.934122
453	Veal	\N	3	2018-06-28 11:53:58.019392	2018-06-28 11:53:58.019399
463	Walnuts	\N	3	2018-06-28 11:53:58.113338	2018-06-28 11:53:58.113347
473	Whole Milk	\N	1	2018-06-28 11:53:58.222387	2018-06-28 11:53:58.222394
483	Zucchini	\N	5	2018-06-28 11:53:58.428729	2018-07-01 10:36:03.87761
124	Corn Flour		3	2018-06-28 11:53:53.519697	2018-06-28 11:53:53.519702
134	Cucumber	\N	3	2018-06-28 11:53:53.609693	2018-06-28 11:53:53.6097
154	Dried Apricots	\N	3	2018-06-28 11:53:53.788647	2018-06-28 11:53:53.788655
164	Egg Yolks	\N	5	2018-06-28 11:53:53.877967	2018-06-28 11:53:53.877974
174	Fennel Seeds	\N	3	2018-06-28 11:53:53.971953	2018-06-28 11:53:53.971958
194	Fruit Mix	\N	3	2018-06-28 11:53:54.159087	2018-06-28 11:53:54.159093
204	Ginger Cordial	\N	3	2018-06-28 11:53:54.251791	2018-06-28 11:53:54.251796
224	Ground Ginger	\N	3	2018-06-28 11:53:54.423876	2018-06-28 11:53:54.423882
234	Hot Beef Stock	\N	3	2018-06-28 11:53:54.517269	2018-06-28 11:53:54.517275
244	Khus Khus	\N	3	2018-06-28 11:53:54.602779	2018-06-28 11:53:54.602785
254	Lasagne Sheets	\N	3	2018-06-28 11:53:55.906085	2018-06-28 11:53:55.906096
264	Lime	\N	3	2018-06-28 11:53:56.167472	2018-06-28 11:53:56.167898
274	Massaman Curry Paste	\N	3	2018-06-28 11:53:56.282352	2018-06-28 11:53:56.28236
284	Mirin	\N	3	2018-06-28 11:53:56.377669	2018-06-28 11:53:56.377675
294	Mustard	\N	3	2018-06-28 11:53:56.469019	2018-06-28 11:53:56.469024
304	Onion Salt	\N	3	2018-06-28 11:53:56.570614	2018-06-28 11:53:56.570619
324	Peanut Butter	\N	3	2018-06-28 11:53:56.751542	2018-06-28 11:53:56.751548
334	Pilchards	\N	3	2018-06-28 11:53:56.840342	2018-06-28 11:53:56.840347
344	Potatoes	\N	3	2018-06-28 11:53:56.932779	2018-06-28 11:53:56.932786
354	Raw King Prawns	\N	3	2018-06-28 11:53:57.020066	2018-06-28 11:53:57.020076
364	Red Wine Jelly	\N	3	2018-06-28 11:53:57.115435	2018-06-28 11:53:57.115443
374	Rigatoni	\N	3	2018-06-28 11:53:57.204316	2018-06-28 11:53:57.204321
384	Salsa	\N	1	2018-06-28 11:53:57.288634	2018-06-28 11:53:57.28864
394	Sesame Seed	\N	3	2018-06-28 11:53:57.437831	2018-06-28 11:53:57.43784
404	Smoked Paprika	\N	3	2018-06-28 11:53:57.543037	2018-06-28 11:53:57.543044
414	Stilton Cheese	\N	3	2018-06-28 11:53:57.660545	2018-06-28 11:53:57.660553
424	Tagliatelle	\N	3	2018-06-28 11:53:57.75596	2018-06-28 11:53:57.755965
434	Tofu	Tofu, also known as bean curd, is a food cultivated by coagulating soy milk and then pressing the resulting curds into soft white blocks. It is a component in East Asian and Southeast Asian cuisines. Tofu can be soft, firm, or extra firm. Tofu has a subtle flavor and can be used in savory and sweet dishes. It is often seasoned or marinated to suit the dish.\r\n\r\nTofu has a low calorie count and relatively large amounts of protein. It is high in iron, and it can have a high calcium or magnesium content, depending on the coagulants used in manufacturing (e.g. calcium chloride, calcium sulfate, magnesium sulfate).	3	2018-06-28 11:53:57.841373	2018-06-28 11:53:57.841378
444	Tuna	\N	3	2018-06-28 11:53:57.942582	2018-06-28 11:53:57.942588
454	Vegan Butter	\N	3	2018-06-28 11:53:58.028105	2018-06-28 11:53:58.028111
464	Water	\N	1	2018-06-28 11:53:58.121708	2018-06-28 11:53:58.121714
474	Whole Wheat	\N	3	2018-06-28 11:53:58.247156	2018-06-28 11:53:58.247162
115	Cocoa	\N	3	2018-06-28 11:53:53.428743	2018-06-28 11:53:53.42875
125	Corn Tortillas	\N	3	2018-06-28 11:53:53.527943	2018-06-28 11:53:53.527949
135	Cumin	\N	3	2018-06-28 11:53:53.618039	2018-06-28 11:53:53.618044
155	Dried Fruit	\N	3	2018-06-28 11:53:53.801093	2018-06-28 11:53:53.801099
165	Eggs	\N	5	2018-06-28 11:53:53.887112	2018-06-28 11:53:53.887119
175	Fenugreek	\N	3	2018-06-28 11:53:53.980353	2018-06-28 11:53:53.980358
205	Ginger Garlic Paste	\N	3	2018-06-28 11:53:54.260439	2018-06-28 11:53:54.260446
215	Green Beans	\N	3	2018-06-28 11:53:54.350492	2018-06-28 11:53:54.350499
225	Gruyère	\N	3	2018-06-28 11:53:54.432464	2018-06-28 11:53:54.43247
235	Hotsauce	\N	1	2018-06-28 11:53:54.525778	2018-06-28 11:53:54.525783
245	Kidney Beans	\N	3	2018-06-28 11:53:54.611419	2018-06-28 11:53:54.611433
255	Lean Minced Beef	\N	3	2018-06-28 11:53:55.980801	2018-06-28 11:53:55.980827
265	Linguine Pasta	\N	3	2018-06-28 11:53:56.17951	2018-06-28 11:53:56.179515
285	Mixed Grain	\N	3	2018-06-28 11:53:56.387045	2018-06-28 11:53:56.38705
295	Mustard Powder	\N	3	2018-06-28 11:53:56.478896	2018-06-28 11:53:56.478902
305	Onions	\N	3	2018-06-28 11:53:56.579253	2018-06-28 11:53:56.579259
315	Paprika	\N	3	2018-06-28 11:53:56.668117	2018-06-28 11:53:56.668122
325	Peanut Cookies	\N	3	2018-06-28 11:53:56.760132	2018-06-28 11:53:56.760137
335	Pine Nuts	\N	3	2018-06-28 11:53:56.852305	2018-06-28 11:53:56.852313
345	Prawns	\N	3	2018-06-28 11:53:56.941163	2018-06-28 11:53:56.94117
355	Red Chile Flakes	\N	3	2018-06-28 11:53:57.028744	2018-06-28 11:53:57.028752
365	Red Wine Vinegar	\N	1	2018-06-28 11:53:57.12405	2018-06-28 11:53:57.124057
375	Roasted Vegetables	\N	3	2018-06-28 11:53:57.212412	2018-06-28 11:53:57.212419
385	Salt	\N	3	2018-06-28 11:53:57.297123	2018-06-28 11:53:57.297128
395	Sesame Seed Oil	\N	1	2018-06-28 11:53:57.446361	2018-06-28 11:53:57.446367
405	Smoky Paprika	\N	3	2018-06-28 11:53:57.552254	2018-06-28 11:53:57.552263
415	Stout	\N	1	2018-06-28 11:53:57.671607	2018-06-28 11:53:57.671616
425	Tahini	\N	3	2018-06-28 11:53:57.764457	2018-06-28 11:53:57.764464
435	Tomato	\N	3	2018-06-28 11:53:57.846746	2018-06-28 11:53:57.846753
445	Turkey Mince	\N	3	2018-06-28 11:53:57.951087	2018-06-28 11:53:57.951194
455	Vegetable Oil	\N	1	2018-06-28 11:53:58.037448	2018-06-28 11:53:58.037455
465	Water Chestnut	Eleocharis dulcis, the Chinese water chestnut or water chestnut, is a grass-like sedge native to Asia (China, Japan, India, Philippines, etc.), Australia, tropical Africa, and various islands of the Pacific and Indian Oceans. It is grown in many countries for its edible corms.\r\n\r\nThe water chestnut is not a nut at all, but an aquatic vegetable that grows in marshes, under water, in the mud. It has stem-like, tubular green leaves that grow to about 1.5 m. The water caltrop, which also is referred to by the same name, is unrelated and often confused with the water chestnut.\r\n\r\nThe small, rounded corms have a crisp, white flesh and may be eaten raw, slightly boiled, or grilled, and often are pickled or tinned. They are a popular ingredient in Chinese dishes. In China, they are most often eaten raw, sometimes sweetened. They also may be ground into a flour form used for making water chestnut cake, which is common as part of dim sum cuisine. They are unusual among vegetables for remaining crisp even after being cooked or canned, because their cell walls are cross-linked and strengthened by certain phenolic compounds, such as oligomers of ferulic acid. This property is shared by other vegetables that remain crisp in this manner, including the tiger nut and lotus root. The corms contain the antibiotic agent puchiin, which is stable to high temperature. Apart from the edible corms, the leaves can be used for cattlefeed, mulch or compost.\r\n\r\nThe corms are rich in carbohydrates (about 90% by dry weight), especially starch (about 60% by dry weight), and are also a good source of dietary fiber, riboflavin, vitamin B6, potassium, copper, and manganese.\r\n\r\nIf eaten uncooked, the surface of the plants may transmit fasciolopsiasis.	3	2018-06-28 11:53:58.129968	2018-06-28 11:53:58.129974
475	Wholegrain Bread	\N	3	2018-06-28 11:53:58.263967	2018-06-28 11:53:58.263993
275	Dates	\N	3	2018-06-28 11:53:56.291003	2018-07-05 15:19:56.355329
116	Coconut Cream	\N	1	2018-06-28 11:53:53.437262	2018-06-28 11:53:53.437267
126	Cornstarch	\N	3	2018-06-28 11:53:53.53832	2018-06-28 11:53:53.538325
136	Cumin Seeds	\N	3	2018-06-28 11:53:53.626957	2018-06-28 11:53:53.626963
146	Dark Soy Sauce	\N	1	2018-06-28 11:53:53.712802	2018-06-28 11:53:53.712806
156	Dried Oregano	\N	3	2018-06-28 11:53:53.809544	2018-06-28 11:53:53.809551
166	Enchilada Sauce	\N	1	2018-06-28 11:53:53.895488	2018-06-28 11:53:53.895494
196	Garam Masala	\N	3	2018-06-28 11:53:54.175676	2018-06-28 11:53:54.175681
206	Ginger Paste	\N	3	2018-06-28 11:53:54.268809	2018-06-28 11:53:54.268816
216	Green Chilli	\N	3	2018-06-28 11:53:54.356056	2018-06-28 11:53:54.356063
226	Ham	\N	3	2018-06-28 11:53:54.440902	2018-06-28 11:53:54.44091
236	Ice Cream	\N	3	2018-06-28 11:53:54.534661	2018-06-28 11:53:54.534668
246	King Prawns	\N	3	2018-06-28 11:53:54.678077	2018-06-28 11:53:54.678086
256	Leek	\N	3	2018-06-28 11:53:56.069109	2018-06-28 11:53:56.069117
266	Macaroni	\N	3	2018-06-28 11:53:56.191166	2018-06-28 11:53:56.191171
276	Meringue Nests	\N	3	2018-06-28 11:53:56.304025	2018-06-28 11:53:56.304031
286	Mixed Peel	\N	3	2018-06-28 11:53:56.395658	2018-06-28 11:53:56.395663
296	Mustard Seeds	\N	3	2018-06-28 11:53:56.490834	2018-06-28 11:53:56.49084
306	Orange	\N	3	2018-06-28 11:53:56.587623	2018-06-28 11:53:56.587629
316	Parma Ham	\N	3	2018-06-28 11:53:56.676796	2018-06-28 11:53:56.676803
326	Peanut Oil	\N	1	2018-06-28 11:53:56.76861	2018-06-28 11:53:56.768618
336	Pink Food Colouring	\N	3	2018-06-28 11:53:56.862261	2018-06-28 11:53:56.862268
346	Pretzels	\N	3	2018-06-28 11:53:56.94994	2018-06-28 11:53:56.949947
356	Red Chilli	\N	3	2018-06-28 11:53:57.037212	2018-06-28 11:53:57.037219
366	Redcurrants	\N	3	2018-06-28 11:53:57.132565	2018-06-28 11:53:57.132571
376	Rocket	\N	3	2018-06-28 11:53:57.22131	2018-06-28 11:53:57.221316
386	Salt Cod	\N	3	2018-06-28 11:53:57.305691	2018-06-28 11:53:57.305697
396	Shallots	\N	3	2018-06-28 11:53:57.4548	2018-06-28 11:53:57.454806
406	Sour Cream	\N	3	2018-06-28 11:53:57.564099	2018-06-28 11:53:57.564107
416	Strawberries	\N	3	2018-06-28 11:53:57.680731	2018-06-28 11:53:57.680781
426	Tarragon Leaves	\N	3	2018-06-28 11:53:57.773169	2018-06-28 11:53:57.773176
436	Tomato Ketchup	\N	3	2018-06-28 11:53:57.85945	2018-06-28 11:53:57.859455
446	Turmeric	\N	3	2018-06-28 11:53:57.959741	2018-06-28 11:53:57.959746
466	White Chocolate	\N	3	2018-06-28 11:53:58.138431	2018-06-28 11:53:58.138437
476	Wild Mushrooms	\N	3	2018-06-28 11:53:58.28988	2018-06-28 11:53:58.289888
456	Vegetable Stock	\N	1	2018-06-28 11:53:58.045908	2018-07-01 10:13:48.439942
117	Coconut Milk	\N	1	2018-06-28 11:53:53.445742	2018-06-28 11:53:53.445749
127	Courgettes	\N	3	2018-06-28 11:53:53.550112	2018-06-28 11:53:53.550118
137	Currants	\N	3	2018-06-28 11:53:53.635681	2018-06-28 11:53:53.635689
157	Dry White Wine	\N	1	2018-06-28 11:53:53.818085	2018-06-28 11:53:53.818091
167	English Mustard	\N	1	2018-06-28 11:53:53.904052	2018-06-28 11:53:53.904059
177	Feta	\N	3	2018-06-28 11:53:54.005648	2018-06-28 11:53:54.005655
187	French Lentils	\N	3	2018-06-28 11:53:54.094936	2018-06-28 11:53:54.094942
197	Garlic	\N	3	2018-06-28 11:53:54.184277	2018-06-28 11:53:54.184283
207	Glace Cherry	\N	3	2018-06-28 11:53:54.277381	2018-06-28 11:53:54.277387
217	Green Olives	\N	3	2018-06-28 11:53:54.364494	2018-06-28 11:53:54.364499
227	Hard Taco Shells	\N	3	2018-06-28 11:53:54.457838	2018-06-28 11:53:54.457846
247	Kosher Salt	\N	3	2018-06-28 11:53:54.836141	2018-06-28 11:53:54.836148
257	Lemon	\N	3	2018-06-28 11:53:56.103302	2018-06-28 11:53:56.103311
267	Mackerel	\N	3	2018-06-28 11:53:56.199931	2018-06-28 11:53:56.199936
277	Milk	\N	1	2018-06-28 11:53:56.312418	2018-06-28 11:53:56.312423
287	Monkfish	\N	3	2018-06-28 11:53:56.404285	2018-06-28 11:53:56.40429
297	Naan Bread	\N	3	2018-06-28 11:53:56.500484	2018-06-28 11:53:56.50049
307	Orange Zest	\N	3	2018-06-28 11:53:56.596511	2018-06-28 11:53:56.596536
317	Parmesan	\N	3	2018-06-28 11:53:56.685322	2018-06-28 11:53:56.685327
327	Peanuts	\N	3	2018-06-28 11:53:56.777033	2018-06-28 11:53:56.777038
337	Pinto Beans	\N	3	2018-06-28 11:53:56.873459	2018-06-28 11:53:56.873477
347	Prosciutto	\N	3	2018-06-28 11:53:56.958351	2018-06-28 11:53:56.958357
357	Red Chilli Powder	\N	3	2018-06-28 11:53:57.045821	2018-06-28 11:53:57.045827
367	Refried Beans	\N	3	2018-06-28 11:53:57.14114	2018-06-28 11:53:57.141146
377	Rolled Oats	\N	3	2018-06-28 11:53:57.229335	2018-06-28 11:53:57.229342
387	Salted Butter	\N	3	2018-06-28 11:53:57.323946	2018-06-28 11:53:57.323952
397	Shiitake Mushrooms	\N	3	2018-06-28 11:53:57.463741	2018-06-28 11:53:57.463747
407	Soy Sauce	\N	1	2018-06-28 11:53:57.573254	2018-06-28 11:53:57.573263
427	Thai Fish Sauce	\N	1	2018-06-28 11:53:57.781799	2018-06-28 11:53:57.781807
437	Tomato Puree	\N	3	2018-06-28 11:53:57.871337	2018-06-28 11:53:57.871342
447	Turmeric Powder	\N	3	2018-06-28 11:53:57.968013	2018-06-28 11:53:57.968019
457	Vegetable Stock Cube	\N	3	2018-06-28 11:53:58.054586	2018-06-28 11:53:58.054592
467	White Chocolate Chips	\N	3	2018-06-28 11:53:58.146819	2018-06-28 11:53:58.146826
477	Wonton Skin	Won ton skin. Paper-thin squares of dough made from flour, water, eggs and salt used to make won tons, egg rolls and gyoza.	3	2018-06-28 11:53:58.315193	2018-06-28 11:53:58.3152
484	Coconut Oil	\N	3	2018-07-01 10:14:22.051473	2018-07-01 10:14:22.051483
485	Curcuma	\N	3	2018-07-01 10:17:17.313718	2018-07-01 10:17:17.313726
486	Bell pepper	\N	5	2018-07-01 10:35:54.381144	2018-07-01 10:35:54.381153
487	Red Pesto	\N	3	2018-07-01 10:40:10.724157	2018-07-01 10:40:10.724166
488	Green Pesto	\N	3	2018-07-01 10:40:17.911288	2018-07-01 10:40:17.911296
489	Aluminium foil	\N	5	2018-07-01 10:45:01.425181	2018-07-01 10:45:01.425189
490	Paper towels	One piece is one roll	5	2018-07-03 16:33:25.197759	2018-07-03 16:33:25.197768
491	Salad	\N	3	2018-07-03 16:38:44.829136	2018-07-03 16:38:44.829143
492	Coffee powder	\N	3	2018-07-03 16:47:55.857412	2018-07-03 16:47:55.857422
493	Coffee filters	\N	5	2018-07-03 16:48:07.575882	2018-07-03 16:48:07.57589
494	Black tea	\N	3	2018-07-03 16:49:30.363336	2018-07-03 16:49:30.363345
495	Tea	\N	3	2018-07-03 16:49:44.029703	2018-07-03 16:49:44.02971
496	Fruit Tea	\N	3	2018-07-03 16:50:01.072868	2018-07-03 16:50:01.072875
497	Marmalade	\N	3	2018-07-03 16:51:46.109119	2018-07-03 16:51:46.109145
498	Nutella	\N	3	2018-07-03 16:51:56.471055	2018-07-03 16:51:56.471063
499	Joghurt	\N	3	2018-07-03 16:55:07.531013	2018-07-03 16:55:07.531021
500	Curd	\N	3	2018-07-03 16:56:28.480222	2018-07-03 16:56:28.48023
501	Salami	\N	3	2018-07-03 16:59:22.091861	2018-07-03 16:59:22.09187
502	Haloumi Cheese	\N	3	2018-07-03 17:00:17.529716	2018-07-03 17:00:17.529726
503	Steak	\N	3	2018-07-03 17:02:34.023304	2018-07-03 17:02:34.023314
504	Sugar	\N	3	2018-07-03 17:05:12.819915	2018-07-03 17:05:12.819924
505	Tomatoe paste	\N	3	2018-07-03 17:07:26.901499	2018-07-03 17:07:26.901507
506	Paprika paste	\N	3	2018-07-03 17:07:33.969778	2018-07-03 17:07:33.969786
507	Cereals	\N	3	2018-07-03 17:10:35.18691	2018-07-03 17:10:35.186918
508	Muesli	\N	3	2018-07-03 17:11:17.66071	2018-07-03 17:11:17.660718
509	Liquid soap	\N	1	2018-07-03 17:15:36.021286	2018-07-03 17:15:36.021296
510	Beer	\N	1	2018-07-03 17:17:58.222478	2018-07-03 17:17:58.222487
511	Apple juice	\N	1	2018-07-03 17:20:11.746527	2018-07-03 17:20:11.746537
512	Orange juice	\N	1	2018-07-03 17:20:25.005926	2018-07-03 17:20:25.005934
513	Tortilla Wrap	\N	3	2018-07-03 17:26:50.669947	2018-07-03 17:26:50.669957
514	Toast	\N	3	2018-07-03 17:30:07.77303	2018-07-03 17:30:07.773038
515	Mayonnaise	\N	3	2018-07-05 15:08:13.937639	2018-07-05 15:08:13.937647
516	Pasta	\N	3	2018-07-05 15:17:19.309587	2018-07-05 15:17:19.309595
517	Meat Cold Cuts	Assortion of Salami, Mortadella, Ham and other slices of meat	3	2018-07-06 09:47:22.396652	2018-07-06 09:47:22.396661
518	Melon	\N	3	2018-07-06 09:51:24.09779	2018-07-06 09:51:24.097799
519	Kohlrabi	\N	3	2018-07-06 09:52:37.823194	2018-07-06 09:52:37.823202
520	Cereal Bars	\N	3	2018-07-07 09:32:05.861388	2018-07-07 09:32:05.861397
521	Sweet Potatoes	\N	3	2018-07-07 10:06:35.446372	2018-07-07 10:06:35.446382
\.


--
-- Data for Name: meals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY meals (id, name, "time", date, event_id, inserted_at, updated_at) FROM stdin;
2	Welcome dinner	20:00:00	2018-08-14	1	2018-06-30 09:26:32.881446	2018-06-30 09:26:32.881453
9	Breakfast	08:00:00	2018-08-15	1	2018-07-07 09:05:56.845274	2018-07-07 09:05:56.845281
10	Breakfast	08:00:00	2018-08-16	1	2018-07-07 09:06:42.700997	2018-07-07 09:06:42.701006
11	Breakfast	08:00:00	2018-08-18	1	2018-07-07 09:07:52.174316	2018-07-07 09:21:24.384189
12	Fance Breakfast with Takeaway for hike	08:00:00	2018-08-17	1	2018-07-07 09:21:13.099649	2018-07-07 14:23:39.041456
3	Provided lunch (cooking @charlottes?)	14:00:00	2018-08-15	1	2018-06-30 09:26:52.123696	2018-07-07 14:25:27.53139
5	Provided dinner	20:00:00	2018-08-17	1	2018-06-30 09:28:07.618355	2018-07-07 14:25:33.508626
4	BBQ at Elbe	20:00:00	2018-08-16	1	2018-06-30 09:27:14.047481	2018-07-07 14:25:42.234951
\.


--
-- Data for Name: meals_recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY meals_recipes (id, person_count, meal_id, recipe_id) FROM stdin;
1	4	4	5
9	30	9	15
10	30	10	15
11	30	11	15
17	26	4	19
18	25	3	20
19	25	2	21
13	45	12	15
21	30	12	11
22	5	2	25
23	5	3	27
24	25	5	23
25	5	5	24
\.


--
-- Data for Name: measurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY measurements (id, name, plural_name, display_code, inserted_at, updated_at) FROM stdin;
1	Milliliter	Milliliters	ml	2018-06-28 11:53:49.2818	2018-06-28 11:53:49.281807
2	Liter	Liters	l	2018-06-28 11:53:49.294255	2018-06-28 11:53:49.294269
3	Gram	Grams	g	2018-06-28 11:53:49.305624	2018-06-28 11:53:49.305634
4	Kilogram	Kilograms	kg	2018-06-28 11:53:49.314797	2018-06-28 11:53:49.314805
5	Piece	Pieces	pc	2018-06-28 11:53:49.325468	2018-06-28 11:53:49.325478
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY recipes (id, name, description, person_count, instructions, published, created_by, version, root_version_id, avg_review, inserted_at, updated_at) FROM stdin;
1	Spinach Soup with Roasted Tofu	Vegan, super-delicious and easy tofu soup, https://www.eat-vegan.rocks/en/spinach-soup-roasted-tofu/	4	1. Cut tofu into small pieces\n2. Heat coconut oil in the pan, roast tofu with curry paste briefly and then remove\n3. Chop spinach (if you didn't buy chopped one) and the parsley, clean and chop mushrooms into halves or quarters\n4. Sauté spinach in a pan with some oil for ~5 minutes, stirring occasionally and finally remove\n5. Melt coconut oil in a pot and add flour all at once whisking vigorously. Stir occasionally until the roux gets light brownish\n6 Deglaze roux with vegetable broth and add all ingredients, simmer for 5 minutes	t	21	0	1	\N	2018-07-01 10:13:06.99696	2018-07-01 10:18:19.814812
11	Waffles	Simple waffles	4	Mix all ingredients (add one vanilla sugar) and start baking :)	t	22	0	11	\N	2018-07-05 20:36:37.843899	2018-07-07 08:52:46.435177
8	Pasta with Tomato-Vegetable sauce	The super simple recipe, spiced up with some extras	4	Boil pasta, be aware that you need a lot of water if you cook for many people. After boiling, add some oil when no italian is watching.\n\nDice onions, tomatoes, garlic and dates. In a pan, fry first the onions, then add dates, cashews and garlic. At last add the tomatoes and add as much vegetable stock and water as you think is necessary. Add tomato paste. Leave to simmer and season with salt, pepper, parsley, oregano, balsamic and sugar	f	21	0	8	\N	2018-07-05 15:31:14.378994	2018-07-05 15:44:05.341651
17	Cheese Soup omnivor	Omnivor version of the dish established in A-Dresden by Ingo	35	Chop the leek, onions and broccoli. Fry the minced meat in a pot. Fry the vegetables separately, putting first the onions, then broccoli, then leek, and add them to the big pot with the meat when done. Before adding the vegetable stock, fry the curry powder a bit too. Add vegetable stock, mushrooms and cream cheese and season with salt and pepper. Leave everything to simmer, the longer the better, but at least 30 minutes. 10 minutes before serving put the baguettes into the oven to have them ready in time.	f	22	0	17	\N	2018-07-07 09:58:26.905725	2018-07-07 18:58:18.432721
12	Breakfast a-la-Dresden	The proven recipe, copied from DY2.	80	Put everything on the table before waking up people, so you have maximum mourning efficiency! Chop fruits into parts, otherwise they won't get eaten.	f	21	0	12	\N	2018-07-06 09:54:22.393056	2018-07-06 10:06:01.033025
14	Breakfast a-la-Dresden	The proven recipe, copied from DY2.	80	Put everything on the table before waking up people, so you have maximum mourning efficiency! Chop fruits into parts, otherwise they won't get eaten.	f	21	2	12	\N	2018-07-06 10:15:18.854747	2018-07-06 11:42:54.423764
15	Breakfast a-la-Dresden	The proven recipe, copied from DY2.	80	Put everything on the table before waking up people, so you have maximum mourning efficiency! Chop fruits into parts, otherwise they won't get eaten.	f	21	3	12	\N	2018-07-06 11:42:54.42427	2018-07-07 19:18:14.073901
5	BBQ-Feta with Vegetables	Wrapped feta with vegetables in aluminium foil to feed vegetarians during BBQs	3	Feta usually comes as a block, slice it along the long side into two thin halves. Chop the vegetables. Take a big slice of aluminium foil, put one drop of oil into the middle, put the feta on top, then stack as many vegetables on it. Put one spoon of pesto and close the aluminium foil into a bag with the feta on the bottom. If you used cheap aluminium foil, add another layer as security.\nPut them on the BBQ, they need quite some time until they are done (15-20 minutes on a hot BBQ) so add them early.\n\nYou can use any kind of vegetables that you have as a leftover.	t	21	3	2	\N	2018-07-01 10:46:40.209562	2018-07-01 10:46:40.209567
20	Chicken Wraps	Chicken wraps with selfmade sauce	4	Preheat the oven. Wash and dry the chicken breast, fry it on strong heat for 3 minutes on each side. Wrap in in aluminium foil and put it into the oven for 15 Minutes on medium heat.\n\nFor the sauce, mix Joghurt, Mayonnaise, Mustard, Salt and Pepper in a big bowl, add chopped spring onions and chopped garlic and leave for 15 minutes.\n\nTake the chicken breast from the oven and pull or slice it into small pieces and season with salt and pepper. Chop the salad. Wrap everything into Tortilla Wraps.	t	22	0	20	\N	2018-07-07 10:36:57.855908	2018-07-07 10:37:06.118787
7	Wraps with brokkoli and mushrooms	Filled with vegetables, nuts and a nice dressing to it	4	Chop Walnuts into small pieces and roast in a pan (no oil needed, careful to not burn them). Put them aside.\n\nChop onions into rings, zucchini and brokkoli into pieces, mushrooms into rings. Heat oil in a pan and fry Onions with Brokkoli for 3-4 minutes. Add mushrooms and zucchini and fry another 3-4 minutes. Season with salt, pepper and paprika. Remove from the fire and add Nuts.\n\nTo create the dressing chop chives into small rings, mix with mayonnaise and lemon juice. Season with salt and pepper. Roll the wraps with the vegetable mix and the dressing inside.	f	21	0	7	\N	2018-07-05 15:14:44.215871	2018-07-07 19:01:39.593987
16	Lunchbox	A Lunchbox with one toast, good for a hike	1	Make the sandwiches, chop the vegetables, put everything into bags. For vegetarians use double amount of cheese instead of meat cold cuts.	f	22	0	16	\N	2018-07-07 09:34:17.18201	2018-07-07 19:19:06.681883
10	Waffles	\N	4	Mix all the ingredients and start backing :)	f	22	0	10	\N	2018-07-05 20:27:34.346102	2018-07-05 20:27:34.38305
13	Breakfast a-la-Dresden	The proven recipe, copied from DY2.	80	Put everything on the table before waking up people, so you have maximum mourning efficiency! Chop fruits into parts, otherwise they won't get eaten.	f	21	1	12	\N	2018-07-06 10:06:01.033549	2018-07-06 10:15:18.854089
23	Cheese Soup omnivor	Omnivor version of the dish established in A-Dresden by Ingo	35	Chop the leek, onions and broccoli. Fry the minced meat in a pot. Fry the vegetables separately, putting first the onions, then broccoli, then leek, and add them to the big pot with the meat when done. Before adding the vegetable stock, fry the curry powder a bit too. Add vegetable stock, mushrooms and cream cheese and season with salt and pepper. Leave everything to simmer, the longer the better, but at least 30 minutes. 10 minutes before serving put the baguettes into the oven to have them ready in time.	t	22	1	17	\N	2018-07-07 18:58:18.433341	2018-07-07 18:58:18.433347
9	Pasta with Tomato-Vegetable sauce	The super simple recipe, spiced up with some extras. Vegan.	4	Boil pasta, be aware that you need a lot of water if you cook for many people. After boiling, add some oil when no italian is watching.\n\nDice onions, tomatoes, garlic and dates. In a pan, fry first the onions, then add dates, cashews and garlic. At last add the tomatoes and add as much vegetable stock and water as you think is necessary. Add tomato paste. Leave to simmer and season with salt, pepper, parsley, oregano, balsamic and sugar	f	21	1	8	\N	2018-07-05 15:44:05.342168	2018-07-07 13:18:11.015476
6	Pumpkin Soup	Ideal in autumn and winter when pumpkins are cheap	4	Peel and chop the pumpkin, onions, carrots and potatoes. Trash or dry the pumpkin seeds for use in another recipe. Fry first the onions and carrots with enough oil in a pot, add pumpkin and potatoes shortly after. After a while add curry to fry too. When the vegetables start burning to the bottom of the pot, add vegetable broth and coconut milk, latest after 10 minutes. The longer they fry the nicer it will be and the less long you have to cook them afterwards. Cook until everything is soft, might take 20 minutes. Then blend everything with a stick blender and season with salt and pepper.	f	21	0	6	\N	2018-07-05 14:48:37.154879	2018-07-07 19:00:32.25752
19	Steaks, bought	Just to be able to plan BBQs	1	Take Steak, put on BBQ, wait, take off, eat.	t	22	0	19	\N	2018-07-07 10:12:42.34614	2018-07-07 10:12:54.191766
22	Pasta with Tomato-Vegetable sauce	The super simple recipe, spiced up with some extras. Vegan.	4	Boil pasta, be aware that you need a lot of water if you cook for many people. After boiling, add some oil when no italian is watching.\n\nDice onions, tomatoes, garlic and dates. In a pan, fry first the onions, then add dates, cashews and garlic. At last add the tomatoes and add as much vegetable stock and water as you think is necessary. Add tomato paste. Leave to simmer and season with salt, pepper, parsley, oregano, balsamic and sugar	f	21	2	8	\N	2018-07-07 13:18:11.016049	2018-07-07 19:00:02.62214
21	Pasta with Sauce Bolognese	Easy and little spectacular recipe for pasta with bolognese sauce	2	Heat olive oil in a pot and roast the minced beef. Add onions and garlic and roast them as well. Then add tomato paste. Now add water and broth and wait for several minutes. After that add all missing ingredients and let it simmer for 20 minutes.	t	22	0	21	\N	2018-07-07 11:16:14.625224	2018-07-07 13:28:01.214746
18	Cheese soup vegetarian	Vegetarian version of an amazing pre-EN dish	35	Chop the leek, onions, broccoli and sweet potato. Fry the sweet potatoes for 2 minutes, then add onions, broccoli and leek. Before adding the vegetable stock, fry the curry powder a bit. Add vegetable stock, cream cheese and mushrooms and season with salt and pepper. Leave everything to simmer, the longer the better, but at least 30 minutes. 10 minutes before serving put the baguettes into the oven to have them ready in time.	f	22	0	18	\N	2018-07-07 10:09:05.590079	2018-07-07 18:58:39.411544
24	Cheese soup vegetarian	Vegetarian version of an amazing pre-EN dish	35	Chop the leek, onions, broccoli and sweet potato. Fry the sweet potatoes for 2 minutes, then add onions, broccoli and leek. Before adding the vegetable stock, fry the curry powder a bit. Add vegetable stock, cream cheese and mushrooms and season with salt and pepper. Leave everything to simmer, the longer the better, but at least 30 minutes. 10 minutes before serving put the baguettes into the oven to have them ready in time.	t	22	1	18	\N	2018-07-07 18:58:39.41207	2018-07-07 18:58:39.412074
25	Pasta with Tomato-Vegetable sauce	The super simple recipe, spiced up with some extras. Vegan.	4	Boil pasta, be aware that you need a lot of water if you cook for many people. After boiling, add some oil when no italian is watching.\n\nDice onions, tomatoes, garlic and dates. In a pan, fry first the onions, then add dates, cashews and garlic. At last add the tomatoes and add as much vegetable stock and water as you think is necessary. Add tomato paste. Leave to simmer and season with salt, pepper, parsley, oregano, balsamic and sugar	t	21	3	8	\N	2018-07-07 19:00:02.622696	2018-07-07 19:00:02.622701
26	Pumpkin Soup	Ideal in autumn and winter when pumpkins are cheap	4	Peel and chop the pumpkin, onions, carrots and potatoes. Trash or dry the pumpkin seeds for use in another recipe. Fry first the onions and carrots with enough oil in a pot, add pumpkin and potatoes shortly after. After a while add curry to fry too. When the vegetables start burning to the bottom of the pot, add vegetable broth and coconut milk, latest after 10 minutes. The longer they fry the nicer it will be and the less long you have to cook them afterwards. Cook until everything is soft, might take 20 minutes. Then blend everything with a stick blender and season with salt and pepper.	t	21	1	6	\N	2018-07-07 19:00:32.258105	2018-07-07 19:00:32.25811
27	Wraps with brokkoli and mushrooms	Filled with vegetables, nuts and a nice dressing to it	4	Chop Walnuts into small pieces and roast in a pan (no oil needed, careful to not burn them). Put them aside.\n\nChop onions into rings, zucchini and brokkoli into pieces, mushrooms into rings. Heat oil in a pan and fry Onions with Brokkoli for 3-4 minutes. Add mushrooms and zucchini and fry another 3-4 minutes. Season with salt, pepper and paprika. Remove from the fire and add Nuts.\n\nTo create the dressing chop chives into small rings, mix with mayonnaise and lemon juice. Season with salt and pepper. Roll the wraps with the vegetable mix and the dressing inside.	t	21	1	7	\N	2018-07-07 19:01:39.594613	2018-07-07 19:01:39.594619
28	Breakfast a-la-Dresden	The proven recipe, copied from DY2.	80	Put everything on the table before waking up people, so you have maximum mourning efficiency! Chop fruits into parts, otherwise they won't get eaten.	t	21	4	12	\N	2018-07-07 19:18:14.074471	2018-07-07 19:18:14.074476
29	Lunchbox	A Lunchbox with one toast, good for a hike	1	Make the sandwiches, chop the vegetables, put everything into bags. For vegetarians use double amount of cheese instead of meat cold cuts.	t	22	1	16	\N	2018-07-07 19:19:06.682464	2018-07-07 19:19:06.682468
\.


--
-- Data for Name: recipes_ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY recipes_ingredients (id, quantity, comment, recipe_id, ingredient_id) FROM stdin;
98	200	\N	7	54
99	150	\N	7	483
17	1	\N	1	485
18	1	\N	1	385
20	20	\N	1	182
21	50	\N	1	320
22	35	If too expensive use normal oil	1	484
23	200	Preferably smoked	1	434
24	5	\N	1	429
25	500	Can be deep frozen	1	410
26	250	Whatever type you want	1	292
27	2000	\N	1	456
101	100	Without mantle	7	463
102	150	Chanterelles are nice	7	292
103	75	\N	7	515
104	15	\N	7	102
105	5	\N	7	258
106	200	One or two per person	7	513
107	1	\N	7	385
108	1	\N	7	333
109	1	\N	7	315
110	10	\N	7	302
393	3500	\N	18	256
394	3500	Canned or deep-fried champignons are cheapest	18	292
126	500	\N	8	516
127	500	Fresh, best use cherry tomatoes	8	435
128	100	\N	8	275
129	50	\N	8	74
130	15	0.5 cloves per person	8	197
131	250	\N	8	456
132	50	\N	8	505
60	70	\N	5	488
61	1	\N	5	486
63	1	\N	5	483
64	1	\N	5	161
65	250	A thick block will make 3 bags, a thin one 2	5	177
66	0.00100000000000000002	ca 0.5m per person	5	489
134	10	\N	8	320
135	1	\N	8	156
136	1	\N	8	385
137	1	\N	8	333
138	5	\N	8	20
139	15	\N	8	302
140	10	\N	8	504
141	500	\N	9	516
76	1500	Weight references pumpkin before removing seeds, usually 1/3 loss.	6	349
77	200	\N	6	117
78	300	\N	6	456
79	500	\N	6	344
80	250	\N	6	72
82	1	\N	6	385
83	1	\N	6	333
84	15	\N	6	138
142	500	Fresh, best use cherry tomatoes	9	435
143	100	\N	9	275
144	50	\N	9	74
145	15	0.5 cloves per person	9	197
146	250	\N	9	456
147	50	\N	9	505
149	10	\N	9	320
150	1	\N	9	156
151	1	\N	9	385
152	1	\N	9	333
153	5	\N	9	20
154	15	\N	9	302
155	10	\N	9	504
156	4	\N	10	165
157	200	\N	10	59
158	170	\N	10	504
396	1750	\N	18	54
397	2000	\N	18	521
398	2800	With herbs	18	130
399	2100	Without herbs	18	130
400	5000	\N	18	456
401	30	\N	18	138
402	1750	\N	18	17
403	50	\N	18	301
404	10	\N	18	385
405	30	\N	18	333
439	420	\N	22	516
440	500	Fresh, best use cherry tomatoes	22	435
441	100	\N	22	275
442	50	\N	22	74
186	13000	In whatever form...	12	50
187	1000	\N	12	517
188	1000	\N	12	83
189	1500	\N	12	59
190	1500	\N	12	130
191	800	\N	12	497
192	800	\N	12	498
194	3000	\N	12	21
195	2000	\N	12	306
196	2000	\N	12	518
197	1500	\N	12	72
198	1000	\N	12	134
199	1500	\N	12	435
200	1000	\N	12	519
201	1500	\N	12	486
202	500	\N	12	232
443	15	0.5 cloves per person	22	197
444	250	\N	22	456
445	50	\N	22	505
447	10	\N	22	320
448	1	\N	22	156
449	1	\N	22	385
450	1	\N	22	333
451	5	\N	22	20
452	15	\N	22	302
453	10	\N	22	504
474	250	\N	21	279
475	1	\N	21	198
476	75	\N	21	72
477	70	\N	21	305
478	350	\N	21	65
479	20	\N	21	505
480	15	\N	21	504
481	15	\N	21	308
482	50	\N	21	188
483	220	\N	21	516
510	420	\N	25	516
511	500	Fresh, best use cherry tomatoes	25	435
512	100	\N	25	275
513	50	\N	25	74
514	15	0.5 cloves per person	25	197
515	250	\N	25	456
516	50	\N	25	505
517	10	\N	25	320
518	1	\N	25	156
519	1	\N	25	385
520	1	\N	25	333
521	5	\N	25	20
522	15	\N	25	302
523	10	\N	25	504
524	150	\N	25	305
534	200	\N	27	54
535	150	\N	27	483
536	100	Without mantle	27	463
203	600	\N	12	492
204	1.26000000000000001	\N	12	277
205	250	\N	12	495
206	2000	\N	12	508
207	13000	In whatever form...	13	50
208	1000	\N	13	517
209	1000	\N	13	83
210	1500	\N	13	59
211	1500	\N	13	130
212	800	\N	13	497
213	800	\N	13	498
215	3000	\N	13	21
216	2000	\N	13	306
217	2000	\N	13	518
218	1500	\N	13	72
219	1000	\N	13	134
220	1500	\N	13	435
221	1000	\N	13	519
222	1500	\N	13	486
223	500	\N	13	232
224	600	\N	13	492
225	1200	\N	13	277
226	250	\N	13	495
227	2000	\N	13	508
228	13000	In whatever form...	14	50
229	1000	\N	14	517
230	1000	\N	14	83
231	1500	\N	14	59
232	1500	\N	14	130
233	800	\N	14	497
234	800	\N	14	498
236	3000	\N	14	21
237	2000	\N	14	306
238	2000	\N	14	518
239	1500	\N	14	72
240	1000	\N	14	134
241	1500	\N	14	435
242	1000	\N	14	519
243	6	\N	14	486
244	500	\N	14	232
245	600	\N	14	492
246	1200	\N	14	277
247	250	\N	14	495
248	2000	\N	14	508
249	8000	In whatever form...	15	50
250	1000	\N	15	517
251	1000	\N	15	83
252	1500	\N	15	59
253	1500	\N	15	130
254	800	\N	15	497
255	800	\N	15	498
257	3000	\N	15	21
258	2000	\N	15	306
259	2000	\N	15	518
260	1500	\N	15	72
261	1000	\N	15	134
262	1500	\N	15	435
263	1000	\N	15	519
264	6	\N	15	486
265	500	\N	15	232
266	600	\N	15	492
267	1200	\N	15	277
268	250	\N	15	495
269	2000	\N	15	508
380	3500	\N	17	256
284	4	\N	11	165
285	125	\N	11	59
286	250	\N	11	182
287	250	\N	11	277
288	2	\N	11	385
289	2	\N	11	19
290	10	\N	11	452
381	3500	Canned or deep-fried champignons are cheapest	17	292
383	1750	\N	17	54
384	2000	\N	17	281
385	2800	With herbs	17	130
386	2100	Without herbs	17	130
387	5000	\N	17	456
388	30	\N	17	138
389	1750	\N	17	17
390	50	\N	17	301
391	10	\N	17	385
392	30	\N	17	333
409	200	\N	19	503
410	50	White bread, preferably	19	50
411	10	\N	19	436
421	500	\N	20	90
422	150	\N	20	411
423	300	\N	20	491
424	200	Unsure if enough	20	513
425	15	\N	20	197
426	10	\N	20	301
427	200	\N	20	482
428	200	Or salad creams, miracel whip	20	515
429	50	\N	20	294
331	50	2 slices per person	16	514
332	50	\N	16	520
333	3	\N	16	59
334	15	\N	16	491
335	20	\N	16	517
336	40	\N	16	435
337	50	\N	16	134
338	50	\N	16	519
339	50	\N	16	72
340	20	\N	16	83
484	3500	\N	23	256
485	3500	Canned or deep-fried champignons are cheapest	23	292
486	1750	\N	23	54
487	2000	\N	23	281
488	2800	With herbs	23	130
489	2100	Without herbs	23	130
490	5000	\N	23	456
491	30	\N	23	138
492	1750	\N	23	17
493	50	\N	23	301
494	10	\N	23	385
495	30	\N	23	333
496	700	\N	23	305
497	3500	\N	24	256
498	3500	Canned or deep-fried champignons are cheapest	24	292
499	1750	\N	24	54
500	2000	\N	24	521
501	2800	With herbs	24	130
502	2100	Without herbs	24	130
503	5000	\N	24	456
504	30	\N	24	138
505	1750	\N	24	17
506	50	\N	24	301
507	10	\N	24	385
508	30	\N	24	333
509	700	\N	24	305
525	1500	Weight references pumpkin before removing seeds, usually 1/3 loss.	26	349
526	200	\N	26	117
527	300	\N	26	456
528	500	\N	26	344
529	250	\N	26	72
530	1	\N	26	385
531	1	\N	26	333
532	15	\N	26	138
533	200	\N	26	305
537	150	Chanterelles are nice	27	292
538	75	\N	27	515
539	15	\N	27	102
540	5	\N	27	258
541	200	One or two per person	27	513
542	1	\N	27	385
543	1	\N	27	333
544	1	\N	27	315
545	10	\N	27	302
546	125	\N	27	305
547	8000	In whatever form...	28	50
548	1000	\N	28	517
549	1000	\N	28	83
550	1500	\N	28	59
551	1500	\N	28	130
552	800	\N	28	497
553	800	\N	28	498
554	3000	\N	28	21
555	2000	\N	28	306
556	2000	\N	28	518
557	1500	\N	28	72
558	1000	\N	28	134
559	1500	\N	28	435
560	1000	\N	28	519
561	6	\N	28	486
562	500	\N	28	232
563	600	\N	28	492
564	1200	\N	28	277
565	250	\N	28	495
566	2000	\N	28	508
567	3000	\N	28	48
568	50	2 slices per person	29	514
569	50	\N	29	520
570	3	\N	29	59
571	15	\N	29	491
572	20	\N	29	517
573	40	\N	29	435
574	50	\N	29	134
575	50	\N	29	519
576	50	\N	29	72
577	20	\N	29	83
578	100	\N	29	48
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reviews (id, rating, review, recipe_id, user_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version, inserted_at) FROM stdin;
1	2018-06-28 11:53:44.504844
10	2018-06-28 11:53:45.188158
11	2018-06-28 11:53:45.934089
20	2018-06-28 11:53:46.275054
30	2018-06-28 11:53:46.385069
40	2018-06-28 11:53:46.526363
70	2018-06-28 11:53:46.661215
80	2018-06-28 11:53:46.787767
90	2018-06-28 11:53:46.992626
100	2018-06-28 11:53:47.121062
110	2018-06-28 11:53:47.201952
115	2018-06-28 11:53:47.277086
116	2018-06-28 11:53:47.491425
120	2018-06-28 11:53:47.630277
130	2018-06-28 11:53:47.717406
140	2018-06-28 11:53:47.841145
150	2018-06-28 11:53:47.963782
\.


--
-- Data for Name: shop_admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY shop_admins (id, user_id, shop_id, inserted_at, updated_at) FROM stdin;
1	22	1	2018-07-03 16:25:27.307264	2018-07-03 16:25:27.307271
\.


--
-- Data for Name: shopping_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY shopping_items (id, name, comment, buying_quantity, flexible_amount, price, mapped_ingredient_id, shop_id, inserted_at, updated_at) FROM stdin;
2	Karotten/Möhren	\N	1000	f	1.19999999999999996	72	1	2018-07-03 16:39:27.919203	2018-07-03 16:39:27.91921
3	Eisbergsalat	\N	250	f	0.689999999999999947	491	1	2018-07-03 16:39:36.70206	2018-07-03 16:39:36.702068
5	Potatoes	\N	2.5	f	2.99000000000000021	344	1	2018-07-03 16:40:49.066446	2018-07-03 16:40:49.066454
7	10 Eier aus Bodenhaltung	\N	10	f	1.3899999999999999	165	1	2018-07-03 16:42:07.074494	2018-07-03 16:42:07.074501
8	10 Eier aus Freilandhaltung	\N	10	f	1.68999999999999995	165	1	2018-07-03 16:42:44.508448	2018-07-03 16:42:44.508457
10	Fenchel	\N	1000	t	2.79000000000000004	171	1	2018-07-03 16:43:32.668895	2018-07-03 16:43:32.668904
11	Gurken	\N	200	f	0.589999999999999969	134	1	2018-07-03 16:44:14.576124	2018-07-03 16:44:14.576133
12	Rapsöl	\N	1000	f	0.989999999999999991	301	1	2018-07-03 16:45:00.125343	2018-07-03 16:45:00.125353
13	Spanisches Olivenöl	\N	100	f	3.99000000000000021	168	1	2018-07-03 16:45:22.941501	2018-07-03 16:45:22.941508
14	Carat Curry	\N	45	f	0.689999999999999947	138	1	2018-07-03 16:45:59.731584	2018-07-03 16:45:59.731592
16	Carat Basilikum	\N	15	f	0.689999999999999947	23	1	2018-07-03 16:46:28.904472	2018-07-03 16:46:28.904481
17	Carat Oregano	\N	15	f	0.689999999999999947	156	1	2018-07-03 16:46:56.593875	2018-07-03 16:46:56.593883
18	Röstkaffee Extra	\N	500	f	2.99000000000000021	492	1	2018-07-03 16:48:22.994519	2018-07-03 16:48:22.994527
19	Kaffee-Filter feinporig	\N	100	f	0.450000000000000011	493	1	2018-07-03 16:48:42.631627	2018-07-03 16:48:42.631635
20	Choco Drink	\N	800	f	2.29000000000000004	63	1	2018-07-03 16:49:14.452193	2018-07-03 16:49:14.452201
21	Früchtetee Hagebutte	\N	87.5	f	0.75	496	1	2018-07-03 16:50:52.982928	2018-07-03 16:50:52.982938
22	Feinster Schwarztee, Captains Tea	\N	87.5	f	0.75	494	1	2018-07-03 16:50:55.474963	2018-07-03 16:50:55.474972
23	Nusetti duo	\N	750	f	1.98999999999999999	498	1	2018-07-03 16:52:20.197252	2018-07-03 16:52:20.19726
24	Blütenhonig	\N	500	f	2.49000000000000021	232	1	2018-07-03 16:52:50.904267	2018-07-03 16:52:50.904294
25	Konfitüre Extra	Different tastes (strawberry, apricot, etc.)	450	f	0.989999999999999991	497	1	2018-07-03 16:53:15.804414	2018-07-03 16:53:15.804439
26	Pflanzenmagarine	\N	500	f	0.75	59	1	2018-07-03 16:53:43.459868	2018-07-03 16:53:43.459876
27	H-Milch Gutes Land	\N	1000	f	0.780000000000000027	277	1	2018-07-03 16:54:22.575511	2018-07-03 16:54:22.57552
28	Sahnejoghurt mit Frucht	\N	150	f	0.349999999999999978	482	1	2018-07-03 16:55:27.123393	2018-07-03 16:55:27.123401
29	Naturjoghurt mild	\N	500	f	0.589999999999999969	499	1	2018-07-03 16:55:29.849462	2018-07-03 16:55:29.849472
30	Schlagsahne	\N	200	f	0.650000000000000022	129	1	2018-07-03 16:56:19.278707	2018-07-03 16:56:19.278715
31	Speisequark mager	\N	500	f	0.849999999999999978	500	1	2018-07-03 16:56:58.191884	2018-07-03 16:56:58.191892
32	Käseaufschnitt	\N	250	f	1.59000000000000008	83	1	2018-07-03 16:57:22.691634	2018-07-03 16:57:22.691642
33	Gouda in Scheiben	\N	400	f	2.29000000000000004	83	1	2018-07-03 16:57:49.048149	2018-07-03 16:57:49.048157
34	Gouda am Stück	\N	400	f	2.14999999999999991	211	1	2018-07-03 16:58:28.404256	2018-07-03 16:58:28.404264
35	Gutes Land Hirtenkäse	\N	250	f	1.09000000000000008	177	1	2018-07-03 16:59:07.337187	2018-07-03 16:59:07.337195
36	Salami	\N	200	f	1.09000000000000008	501	1	2018-07-03 16:59:50.740635	2018-07-03 16:59:50.740645
37	Grill und Pfannenkäse	\N	200	f	2.18999999999999995	502	1	2018-07-03 17:00:50.967146	2018-07-03 17:00:50.967154
38	Schinkenwurst	\N	200	f	0.849999999999999978	388	1	2018-07-03 17:00:54.130029	2018-07-03 17:00:54.130037
39	Rinderhackfleisch	\N	400	f	3.68999999999999995	281	1	2018-07-03 17:01:32.362936	2018-07-03 17:01:32.362945
40	Schweinehackfleisch	\N	500	f	1.98999999999999999	281	1	2018-07-03 17:02:17.881934	2018-07-03 17:02:17.881942
41	Hähnchenbrustfilet	\N	600	f	3.58999999999999986	90	1	2018-07-03 17:02:35.791827	2018-07-03 17:02:35.791835
42	Schweinenackensteaks	\N	600	f	2.99000000000000021	503	1	2018-07-03 17:03:07.899051	2018-07-03 17:03:07.899059
43	Kokosmilch	\N	400	f	1.18999999999999995	117	1	2018-07-03 17:04:20.406757	2018-07-03 17:04:20.406765
44	Tomatenketchup	\N	500	f	0.790000000000000036	436	1	2018-07-03 17:05:29.699035	2018-07-03 17:05:29.699043
45	Zeitzer Zucker	\N	1000	f	0.650000000000000022	504	1	2018-07-03 17:07:16.196805	2018-07-03 17:07:16.196814
46	Spaghetti	\N	500	f	0.390000000000000013	409	1	2018-07-03 17:07:54.268314	2018-07-03 17:07:54.268322
47	Weizenmehl 405	\N	1000	f	0.349999999999999978	182	1	2018-07-03 17:08:16.009134	2018-07-03 17:08:16.009141
48	Pennen Rigate	\N	500	f	0.390000000000000013	332	1	2018-07-03 17:08:16.543555	2018-07-03 17:08:16.543564
49	Tomatenmark	\N	200	f	1.14999999999999991	505	1	2018-07-03 17:08:54.317745	2018-07-03 17:08:54.317752
51	Tomatenmark	\N	200	f	0.489999999999999991	505	1	2018-07-03 17:09:24.603645	2018-07-03 17:09:24.603653
52	Parboiled Reis	\N	1000	f	0.890000000000000013	368	1	2018-07-03 17:10:15.997774	2018-07-03 17:10:15.997782
53	Tafelsalz	\N	500	f	0.170000000000000012	385	1	2018-07-03 17:10:44.175246	2018-07-03 17:10:44.175256
54	Corn flakes	\N	500	f	0.989999999999999991	507	1	2018-07-03 17:11:02.448117	2018-07-03 17:11:02.448125
55	Müsli Kornmühle	\N	600	f	1.68999999999999995	508	1	2018-07-03 17:11:41.304304	2018-07-03 17:11:41.304312
56	Pesto Mondo Italiano	\N	190	f	1.18999999999999995	488	1	2018-07-03 17:12:39.258062	2018-07-03 17:12:39.258069
57	Sonnenmais Dose	\N	285	f	0.489999999999999991	422	1	2018-07-03 17:13:54.330595	2018-07-03 17:13:54.330603
58	Kidneybohnen	\N	255	f	0.390000000000000013	245	1	2018-07-03 17:14:12.799016	2018-07-03 17:14:12.799024
59	Champignons im Glas, 2. Wahl	\N	315	f	1.35000000000000009	292	1	2018-07-03 17:14:42.625746	2018-07-03 17:14:42.625754
60	Favora Küchenrolle	\N	4	f	1.44999999999999996	490	1	2018-07-03 17:16:41.302124	2018-07-03 17:16:41.302132
61	Spülmittel	\N	500	f	0.849999999999999978	509	1	2018-07-03 17:17:15.855171	2018-07-03 17:17:15.855179
62	Kiste Sternburger	\N	10000	f	7.79999999999999982	510	1	2018-07-03 17:18:31.093895	2018-07-03 17:18:31.093903
63	Vitalitasia Mineralwasser	\N	1500	f	0.190000000000000002	464	1	2018-07-03 17:19:03.155591	2018-07-03 17:19:03.1556
64	Apfelsaft	\N	1000	f	0.989999999999999991	511	1	2018-07-03 17:21:12.677134	2018-07-03 17:21:12.677144
65	Hohes C	\N	1500	f	2.49000000000000021	512	1	2018-07-03 17:21:18.639823	2018-07-03 17:21:18.639831
66	Apfelsaft	\N	1500	f	1.18999999999999995	511	1	2018-07-03 17:22:01.57938	2018-07-03 17:22:01.579405
67	Fruchtstern Orangen Nektar	\N	1500	f	0.849999999999999978	512	1	2018-07-03 17:22:28.247575	2018-07-03 17:22:28.247582
68	Tafelwein	\N	1.5	f	2.18999999999999995	472	1	2018-07-03 17:26:04.483204	2018-07-03 17:26:04.483212
69	Wrap	6 pieces	380	f	0.989999999999999991	513	1	2018-07-03 17:27:26.27441	2018-07-03 17:27:26.27442
70	Pfirsiche	\N	1000	t	1.68999999999999995	322	1	2018-07-03 17:27:52.695037	2018-07-03 17:27:52.695045
71	Vollkorn Toast	\N	500	f	0.550000000000000044	514	1	2018-07-03 17:30:41.956304	2018-07-03 17:30:41.956313
72	Butter Toast	\N	500	f	0.589999999999999969	514	1	2018-07-03 17:31:12.367492	2018-07-03 17:31:12.3675
73	Brot in Scheiben Bauernmild	\N	500	f	1.29000000000000004	50	1	2018-07-03 17:32:07.794627	2018-07-03 17:32:07.794635
74	Roggen Vollkornbrot	\N	500	f	0.989999999999999991	50	1	2018-07-03 17:32:36.944468	2018-07-03 17:32:36.944476
76	Paprika Mix	\N	3	f	1.3899999999999999	486	1	2018-07-06 10:17:44.372925	2018-07-06 10:17:44.372934
77	Penne Rigate	\N	500	f	0.390000000000000013	516	1	2018-07-06 10:19:14.772308	2018-07-06 10:19:14.772315
78	Salami	\N	200	f	1.09000000000000008	517	1	2018-07-06 10:23:36.651555	2018-07-06 10:23:36.651562
79	Schinkenwurst	\N	200	f	0.849999999999999978	517	1	2018-07-06 10:24:12.072027	2018-07-06 10:24:12.072035
97	Zwiebeln	\N	1500	f	1.68999999999999995	305	1	2018-07-07 19:03:57.466652	2018-07-07 19:03:57.46666
80	Wassermelone	\N	1000	t	0.790000000000000036	518	1	2018-07-07 17:49:45.933767	2018-07-07 17:49:45.933775
83	Auberginen	\N	1	f	0.589999999999999969	161	1	2018-07-07 17:52:43.396919	2018-07-07 17:52:43.396942
81	Bananen	\N	1000	t	1.09000000000000008	21	1	2018-07-07 17:50:14.027763	2018-07-07 17:50:14.027771
90	Miracel Whip	\N	500	f	1.59000000000000008	515	1	2018-07-07 17:59:34.17136	2018-07-07 17:59:34.171368
92	Knorr Kräuterbouillon	144g Ergibt 7,2 Liter	7200	f	1.59000000000000008	456	1	2018-07-07 18:02:26.774129	2018-07-07 18:02:26.774139
82	Pfirsiche	\N	1000	t	1.68999999999999995	322	1	2018-07-07 17:51:00.889291	2018-07-07 17:51:00.889299
89	Bautzner Senf 1kg Pack	\N	1000	f	1.29000000000000004	294	1	2018-07-07 17:59:08.534782	2018-07-07 17:59:08.53479
84	Rispentomaten lose	\N	1000	t	1.09000000000000008	435	1	2018-07-07 17:54:15.591128	2018-07-07 17:54:15.591137
88	Natives Olivenöl	\N	750	f	3.99000000000000021	302	1	2018-07-07 17:57:46.379241	2018-07-07 17:57:46.379249
91	Kräuterbaguette	\N	175	f	0.589999999999999969	17	1	2018-07-07 18:00:27.120917	2018-07-07 18:00:27.120925
85	Schmelzkäse Kräuter	\N	200	f	0.890000000000000013	130	1	2018-07-07 17:55:36.812082	2018-07-07 17:55:36.81209
86	Schmelzkäse Sahne	\N	200	f	0.890000000000000013	130	1	2018-07-07 17:55:56.517455	2018-07-07 17:55:56.517465
93	Porree	\N	1000	t	1.68999999999999995	256	1	2018-07-07 18:03:05.548488	2018-07-07 18:03:05.548497
94	Brokkoli	\N	1000	t	1.48999999999999999	54	1	2018-07-07 18:03:53.393786	2018-07-07 18:03:53.393794
95	Kohlrabi	\N	250	f	0.550000000000000044	519	1	2018-07-07 18:09:27.036319	2018-07-07 18:09:27.036328
96	Rinderhackfleisch	\N	400	f	3.68999999999999995	279	1	2018-07-07 18:54:36.740259	2018-07-07 18:54:36.740268
87	Hengstenberg Aceto de Balsamico	\N	500	f	2.68999999999999995	20	1	2018-07-07 17:57:02.041017	2018-07-07 17:57:02.041042
\.


--
-- Data for Name: shopping_list_notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY shopping_list_notes (id, event_id, ingredient_id, ticked, bought, shopping_item_id, inserted_at, updated_at) FROM stdin;
1	1	90	f	\N	\N	2018-07-07 13:30:12.025967	2018-07-07 13:30:12.796813
2	1	83	f	\N	\N	2018-07-07 13:49:49.775887	2018-07-07 13:49:50.393928
\.


--
-- Data for Name: shops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY shops (id, name, location, currency_id, inserted_at, updated_at) FROM stdin;
1	Netto Dresden	Schnorrstraße Dresden	17	2018-07-03 16:25:27.277047	2018-07-03 16:25:27.277055
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('admins_id_seq', 1, false);


--
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('currencies_id_seq', 17, true);


--
-- Name: event_editors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('event_editors_id_seq', 11, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('events_id_seq', 11, true);


--
-- Name: ingredient_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ingredient_requests_id_seq', 1, false);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ingredients_id_seq', 521, true);


--
-- Name: meals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('meals_id_seq', 12, true);


--
-- Name: meals_recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('meals_recipes_id_seq', 25, true);


--
-- Name: measurements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('measurements_id_seq', 5, true);


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('recipes_id_seq', 29, true);


--
-- Name: recipes_ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('recipes_ingredients_id_seq', 578, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reviews_id_seq', 1, false);


--
-- Name: shop_admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('shop_admins_id_seq', 1, true);


--
-- Name: shopping_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('shopping_items_id_seq', 97, true);


--
-- Name: shopping_list_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('shopping_list_notes_id_seq', 2, true);


--
-- Name: shops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('shops_id_seq', 1, true);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (id);


--
-- Name: event_editors event_editors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_editors
    ADD CONSTRAINT event_editors_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: ingredient_requests ingredient_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingredient_requests
    ADD CONSTRAINT ingredient_requests_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: meals meals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (id);


--
-- Name: meals_recipes meals_recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meals_recipes
    ADD CONSTRAINT meals_recipes_pkey PRIMARY KEY (id);


--
-- Name: measurements measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (id);


--
-- Name: recipes_ingredients recipes_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipes_ingredients
    ADD CONSTRAINT recipes_ingredients_pkey PRIMARY KEY (id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shop_admins shop_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shop_admins
    ADD CONSTRAINT shop_admins_pkey PRIMARY KEY (id);


--
-- Name: shopping_items shopping_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_items
    ADD CONSTRAINT shopping_items_pkey PRIMARY KEY (id);


--
-- Name: shopping_list_notes shopping_list_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_list_notes
    ADD CONSTRAINT shopping_list_notes_pkey PRIMARY KEY (id);


--
-- Name: shops shops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shops
    ADD CONSTRAINT shops_pkey PRIMARY KEY (id);


--
-- Name: admins_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX admins_user_id_index ON admins USING btree (user_id);


--
-- Name: events_shop_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX events_shop_id_index ON events USING btree (shop_id);


--
-- Name: ingredient_requests_default_measurement_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingredient_requests_default_measurement_id_index ON ingredient_requests USING btree (default_measurement_id);


--
-- Name: ingredients_default_measurement_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingredients_default_measurement_id_index ON ingredients USING btree (default_measurement_id);


--
-- Name: meals_recipes_meal_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meals_recipes_meal_id_index ON meals_recipes USING btree (meal_id);


--
-- Name: meals_recipes_recipe_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meals_recipes_recipe_id_index ON meals_recipes USING btree (recipe_id);


--
-- Name: recipes_ingredients_ingredient_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recipes_ingredients_ingredient_id_index ON recipes_ingredients USING btree (ingredient_id);


--
-- Name: recipes_ingredients_recipe_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recipes_ingredients_recipe_id_index ON recipes_ingredients USING btree (recipe_id);


--
-- Name: reviews_recipe_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reviews_recipe_id_index ON reviews USING btree (recipe_id);


--
-- Name: shop_admins_shop_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX shop_admins_shop_id_index ON shop_admins USING btree (shop_id);


--
-- Name: shop_admins_shop_id_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX shop_admins_shop_id_user_id_index ON shop_admins USING btree (shop_id, user_id);


--
-- Name: shopping_items_mapped_ingredient_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX shopping_items_mapped_ingredient_id_index ON shopping_items USING btree (mapped_ingredient_id);


--
-- Name: shopping_items_shop_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX shopping_items_shop_id_index ON shopping_items USING btree (shop_id);


--
-- Name: shopping_list_notes_ingredient_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX shopping_list_notes_ingredient_id_index ON shopping_list_notes USING btree (ingredient_id);


--
-- Name: shopping_list_notes_shopping_item_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX shopping_list_notes_shopping_item_id_index ON shopping_list_notes USING btree (shopping_item_id);


--
-- Name: shops_currency_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX shops_currency_id_index ON shops USING btree (currency_id);


--
-- Name: event_editors event_editors_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_editors
    ADD CONSTRAINT event_editors_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE;


--
-- Name: events events_shop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_shop_id_fkey FOREIGN KEY (shop_id) REFERENCES shops(id) ON DELETE SET NULL;


--
-- Name: ingredient_requests ingredient_requests_default_measurement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingredient_requests
    ADD CONSTRAINT ingredient_requests_default_measurement_id_fkey FOREIGN KEY (default_measurement_id) REFERENCES measurements(id);


--
-- Name: ingredients ingredients_default_measurement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingredients
    ADD CONSTRAINT ingredients_default_measurement_id_fkey FOREIGN KEY (default_measurement_id) REFERENCES measurements(id);


--
-- Name: meals meals_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meals
    ADD CONSTRAINT meals_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE;


--
-- Name: meals_recipes meals_recipes_meal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meals_recipes
    ADD CONSTRAINT meals_recipes_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES meals(id) ON DELETE CASCADE;


--
-- Name: meals_recipes meals_recipes_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meals_recipes
    ADD CONSTRAINT meals_recipes_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE;


--
-- Name: recipes_ingredients recipes_ingredients_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipes_ingredients
    ADD CONSTRAINT recipes_ingredients_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE;


--
-- Name: recipes_ingredients recipes_ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipes_ingredients
    ADD CONSTRAINT recipes_ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE;


--
-- Name: shop_admins shop_admins_shop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shop_admins
    ADD CONSTRAINT shop_admins_shop_id_fkey FOREIGN KEY (shop_id) REFERENCES shops(id) ON DELETE CASCADE;


--
-- Name: shopping_items shopping_items_mapped_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_items
    ADD CONSTRAINT shopping_items_mapped_ingredient_id_fkey FOREIGN KEY (mapped_ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE;


--
-- Name: shopping_items shopping_items_shop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_items
    ADD CONSTRAINT shopping_items_shop_id_fkey FOREIGN KEY (shop_id) REFERENCES shops(id) ON DELETE CASCADE;


--
-- Name: shopping_list_notes shopping_list_notes_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_list_notes
    ADD CONSTRAINT shopping_list_notes_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE;


--
-- Name: shopping_list_notes shopping_list_notes_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_list_notes
    ADD CONSTRAINT shopping_list_notes_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE;


--
-- Name: shopping_list_notes shopping_list_notes_shopping_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shopping_list_notes
    ADD CONSTRAINT shopping_list_notes_shopping_item_id_fkey FOREIGN KEY (shopping_item_id) REFERENCES shopping_items(id) ON DELETE SET NULL;


--
-- Name: shops shops_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shops
    ADD CONSTRAINT shops_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES currencies(id);


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

