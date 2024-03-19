--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

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

DROP DATABASE "playlist-app";
--
-- Name: playlist-app; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "playlist-app" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C.UTF-8';


\connect -reuse-previous=on "dbname='playlist-app'"

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
-- Name: playlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.playlists (
    id integer NOT NULL,
    name text NOT NULL,
    description character varying(100)
);


--
-- Name: playlists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.playlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: playlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.playlists_id_seq OWNED BY public.playlists.id;


--
-- Name: playlists_songs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.playlists_songs (
    id integer NOT NULL,
    playlist_id integer NOT NULL,
    song_id integer NOT NULL
);


--
-- Name: playlists_songs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.playlists_songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: playlists_songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.playlists_songs_id_seq OWNED BY public.playlists_songs.id;


--
-- Name: songs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.songs (
    id integer NOT NULL,
    title text NOT NULL,
    artist text NOT NULL
);


--
-- Name: songs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.songs_id_seq OWNED BY public.songs.id;


--
-- Name: playlists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists ALTER COLUMN id SET DEFAULT nextval('public.playlists_id_seq'::regclass);


--
-- Name: playlists_songs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists_songs ALTER COLUMN id SET DEFAULT nextval('public.playlists_songs_id_seq'::regclass);


--
-- Name: songs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.songs ALTER COLUMN id SET DEFAULT nextval('public.songs_id_seq'::regclass);


--
-- Data for Name: playlists; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.playlists (id, name, description) FROM stdin;
1	TS Pop	Pop music of Taylor Swift
2	Pop recent	Pop music in recent years
3	Hiphop	Hip hop music in recent years
4	Jay-Z	Songs of Jay-Z
\.


--
-- Data for Name: playlists_songs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.playlists_songs (id, playlist_id, song_id) FROM stdin;
1	1	1
2	2	1
3	2	2
4	3	3
5	3	4
6	4	4
\.


--
-- Data for Name: songs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.songs (id, title, artist) FROM stdin;
1	Shake if Off	Taylor Swift
2	Roar	Katy Perry
3	Monster	Kanye West
4	Takeover	Jay-Z
\.


--
-- Name: playlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.playlists_id_seq', 4, true);


--
-- Name: playlists_songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.playlists_songs_id_seq', 6, true);


--
-- Name: songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.songs_id_seq', 4, true);


--
-- Name: playlists playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_pkey PRIMARY KEY (id);


--
-- Name: playlists_songs playlists_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists_songs
    ADD CONSTRAINT playlists_songs_pkey PRIMARY KEY (id);


--
-- Name: songs songs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (id);


--
-- Name: playlists_songs playlists_songs_playlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists_songs
    ADD CONSTRAINT playlists_songs_playlist_id_fkey FOREIGN KEY (playlist_id) REFERENCES public.playlists(id);


--
-- Name: playlists_songs playlists_songs_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists_songs
    ADD CONSTRAINT playlists_songs_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id);


--
-- PostgreSQL database dump complete
--

