--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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
-- Name: dvds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dvds (
    title character varying NOT NULL,
    genre character varying NOT NULL,
    num_copies integer NOT NULL,
    id integer NOT NULL,
    added_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.dvds OWNER TO postgres;

--
-- Name: DVDs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DVDs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DVDs_id_seq" OWNER TO postgres;

--
-- Name: DVDs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DVDs_id_seq" OWNED BY public.dvds.id;


--
-- Name: dvds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dvds ALTER COLUMN id SET DEFAULT nextval('public."DVDs_id_seq"'::regclass);


--
-- Data for Name: dvds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dvds (title, genre, num_copies, id, added_at) FROM stdin;
Home Alone	Comedy	2	1	2023-03-21 14:43:15.3936+02
Scream	Horror	1	3	2023-03-21 14:43:15.3936+02
The Shawshank Redemption\t	Drama\n	5	6	2023-03-21 14:46:24.040773+02
The Godfather	Drama	4	7	2023-03-21 14:48:32.699618+02
The Matrix	Science Fiction	8	8	2023-03-21 14:48:32.699618+02
Forrest Gump	Drama	3	9	2023-03-21 14:48:32.699618+02
Titanic	Romance	5	10	2023-03-21 14:48:32.699618+02
Jurassic Park	Science Fiction	4	11	2023-03-21 14:50:06.854632+02
Star Wars: A New Hope\t	Science Fiction	2	12	2023-03-21 14:50:06.854632+02
Pulp Fiction	Crime	11	5	2023-03-21 14:43:15.3936+02
The Last of Us	Adventure	19	15	2023-03-22 19:28:34.387118+02
\.


--
-- Name: DVDs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."DVDs_id_seq"', 15, true);


--
-- Name: dvds DVDs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dvds
    ADD CONSTRAINT "DVDs_pkey" PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

