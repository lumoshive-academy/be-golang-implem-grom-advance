--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    user_id integer,
    tour_schedule_id integer,
    booking_code character varying(50) NOT NULL,
    num_people integer NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO postgres;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: itineraries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itineraries (
    id integer NOT NULL,
    tour_id integer,
    day_number integer NOT NULL,
    title character varying(150),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.itineraries OWNER TO postgres;

--
-- Name: itineraries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.itineraries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.itineraries_id_seq OWNER TO postgres;

--
-- Name: itineraries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.itineraries_id_seq OWNED BY public.itineraries.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    continent character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    tour_id integer,
    user_id integer,
    rating integer,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: tour_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_categories (
    tour_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.tour_categories OWNER TO postgres;

--
-- Name: tour_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_images (
    id integer NOT NULL,
    tour_id integer,
    image_url text NOT NULL,
    is_main boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tour_images OWNER TO postgres;

--
-- Name: tour_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tour_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tour_images_id_seq OWNER TO postgres;

--
-- Name: tour_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tour_images_id_seq OWNED BY public.tour_images.id;


--
-- Name: tour_schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_schedules (
    id integer NOT NULL,
    tour_id integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    price_override numeric(10,2),
    quota integer DEFAULT 30,
    booked_count integer DEFAULT 0,
    status character varying(20) DEFAULT 'open'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tour_schedules OWNER TO postgres;

--
-- Name: tour_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tour_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tour_schedules_id_seq OWNER TO postgres;

--
-- Name: tour_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tour_schedules_id_seq OWNED BY public.tour_schedules.id;


--
-- Name: tours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tours (
    id integer NOT NULL,
    location_id integer,
    name character varying(150) NOT NULL,
    slug character varying(200),
    description text,
    duration_day integer,
    base_price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tours OWNER TO postgres;

--
-- Name: tours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tours_id_seq OWNER TO postgres;

--
-- Name: tours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tours_id_seq OWNED BY public.tours.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) DEFAULT 'customer'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: itineraries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itineraries ALTER COLUMN id SET DEFAULT nextval('public.itineraries_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: tour_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_images ALTER COLUMN id SET DEFAULT nextval('public.tour_images_id_seq'::regclass);


--
-- Name: tour_schedules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_schedules ALTER COLUMN id SET DEFAULT nextval('public.tour_schedules_id_seq'::regclass);


--
-- Name: tours id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tours ALTER COLUMN id SET DEFAULT nextval('public.tours_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, user_id, tour_schedule_id, booking_code, num_people, total_amount, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, created_at, updated_at, deleted_at) FROM stdin;
1	Nature	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
2	City Tour	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
3	Honeymoon	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
4	History	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
5	Snow	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
\.


--
-- Data for Name: itineraries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itineraries (id, tour_id, day_number, title, description, created_at) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, city, country, continent, created_at, updated_at, deleted_at) FROM stdin;
1	Zurich	Switzerland	Europe	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
2	Berlin	Germany	Europe	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
3	Male	Maldives	Asia	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
4	Toronto	Canada	North America	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
5	Baku	Azerbaijan	Asia	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
6	Beijing	China	Asia	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, tour_id, user_id, rating, comment, created_at, updated_at, deleted_at) FROM stdin;
1	1	1	5	Amazing view!	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
2	2	2	4	Nice but cold.	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
3	2	1	5	Loved the history.	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
4	3	1	5	Best honeymoon ever.	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
5	4	2	4	Toronto is huge!	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
6	4	1	5	Great food.	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
\.


--
-- Data for Name: tour_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_categories (tour_id, category_id) FROM stdin;
1	1
1	5
2	2
2	4
3	1
3	3
\.


--
-- Data for Name: tour_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_images (id, tour_id, image_url, is_main, created_at) FROM stdin;
1	1	https://example.com/img/switzerland.jpg	t	2026-01-19 13:34:48.849846
2	2	https://example.com/img/berlin.jpg	t	2026-01-19 13:34:48.849846
3	3	https://example.com/img/maldives.jpg	t	2026-01-19 13:34:48.849846
4	4	https://example.com/img/toronto.jpg	t	2026-01-19 13:34:48.849846
5	5	https://example.com/img/baku.jpg	t	2026-01-19 13:34:48.849846
6	6	https://example.com/img/china.jpg	t	2026-01-19 13:34:48.849846
\.


--
-- Data for Name: tour_schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_schedules (id, tour_id, start_date, end_date, price_override, quota, booked_count, status, created_at, updated_at, deleted_at) FROM stdin;
1	1	2023-09-12	2023-09-17	1100.00	120	10	open	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
2	2	2023-09-15	2023-09-18	1230.00	120	5	open	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
3	3	2023-09-12	2023-09-16	3000.00	50	45	open	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
4	4	2023-09-12	2023-09-15	2000.00	120	20	open	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
5	5	2023-09-12	2023-09-16	1440.00	120	8	open	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
6	6	2023-09-12	2023-09-17	1210.00	120	15	open	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
\.


--
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tours (id, location_id, name, slug, description, duration_day, base_price, created_at, updated_at, deleted_at) FROM stdin;
1	1	Switzerland Alpine	switzerland-alpine	Qui tempore voluptate qui quia commodi rem praesentium alias.	5	1100.00	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
2	2	Berlin City Break	berlin-city-break	Experience the history and modern vibe of Berlin.	3	1230.00	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
3	3	Maldives Paradise	maldives-paradise	Relax in the crystal clear waters of the Indian Ocean.	4	3000.00	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
4	4	Toronto Explorer	toronto-explorer	Discover the vibrant city life of Canada.	3	2000.00	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
5	5	Baku Heritage	baku-heritage	A journey through the architectural wonders of Baku.	4	1440.00	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
6	6	Chinese Great Wall	chinese-great-wall	Walk through the history of ancient China.	5	1210.00	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, role, created_at, updated_at, deleted_at) FROM stdin;
1	John Doe	john@example.com	secret123	customer	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
2	Alice Smith	alice@example.com	secret123	customer	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
3	Admin User	admin@travel.com	admin123	admin	2026-01-19 13:34:48.849846	2026-01-19 13:34:48.849846	\N
\.


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 5, true);


--
-- Name: itineraries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itineraries_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 6, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 6, true);


--
-- Name: tour_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tour_images_id_seq', 6, true);


--
-- Name: tour_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tour_schedules_id_seq', 6, true);


--
-- Name: tours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tours_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: bookings bookings_booking_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_booking_code_key UNIQUE (booking_code);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: itineraries itineraries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itineraries
    ADD CONSTRAINT itineraries_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: tour_categories tour_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_categories
    ADD CONSTRAINT tour_categories_pkey PRIMARY KEY (tour_id, category_id);


--
-- Name: tour_images tour_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_images
    ADD CONSTRAINT tour_images_pkey PRIMARY KEY (id);


--
-- Name: tour_schedules tour_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_schedules
    ADD CONSTRAINT tour_schedules_pkey PRIMARY KEY (id);


--
-- Name: tours tours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- Name: tours tours_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_slug_key UNIQUE (slug);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_tour_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_tour_schedule_id_fkey FOREIGN KEY (tour_schedule_id) REFERENCES public.tour_schedules(id);


--
-- Name: bookings bookings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: itineraries itineraries_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itineraries
    ADD CONSTRAINT itineraries_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- Name: reviews reviews_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tour_categories tour_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_categories
    ADD CONSTRAINT tour_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: tour_categories tour_categories_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_categories
    ADD CONSTRAINT tour_categories_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- Name: tour_images tour_images_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_images
    ADD CONSTRAINT tour_images_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- Name: tour_schedules tour_schedules_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_schedules
    ADD CONSTRAINT tour_schedules_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- Name: tours tours_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- PostgreSQL database dump complete
--

