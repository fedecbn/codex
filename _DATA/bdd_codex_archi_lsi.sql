--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: lsi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lsi;


ALTER SCHEMA lsi OWNER TO postgres;

SET search_path = lsi, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: coor_news_tag; Type: TABLE; Schema: lsi; Owner: postgres; Tablespace: 
--

CREATE TABLE coor_news_tag (
    id integer NOT NULL,
    id_tag integer NOT NULL
);


ALTER TABLE lsi.coor_news_tag OWNER TO postgres;

--
-- Name: news; Type: TABLE; Schema: lsi; Owner: postgres; Tablespace: 
--

CREATE TABLE news (
    id integer NOT NULL,
    abstract text,
    link text,
    id_subject integer,
    date date,
    title text,
    link_2 character varying
);


ALTER TABLE lsi.news OWNER TO postgres;

--
-- Name: news_id_news_seq; Type: SEQUENCE; Schema: lsi; Owner: postgres
--

CREATE SEQUENCE news_id_news_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lsi.news_id_news_seq OWNER TO postgres;

--
-- Name: news_id_news_seq; Type: SEQUENCE OWNED BY; Schema: lsi; Owner: postgres
--

ALTER SEQUENCE news_id_news_seq OWNED BY news.id;


--
-- Name: subject; Type: TABLE; Schema: lsi; Owner: postgres; Tablespace: 
--

CREATE TABLE subject (
    id_subject integer NOT NULL,
    libelle_subject text
);


ALTER TABLE lsi.subject OWNER TO postgres;

--
-- Name: subject_id_subject_seq; Type: SEQUENCE; Schema: lsi; Owner: postgres
--

CREATE SEQUENCE subject_id_subject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lsi.subject_id_subject_seq OWNER TO postgres;

--
-- Name: subject_id_subject_seq; Type: SEQUENCE OWNED BY; Schema: lsi; Owner: postgres
--

ALTER SEQUENCE subject_id_subject_seq OWNED BY subject.id_subject;


--
-- Name: tag; Type: TABLE; Schema: lsi; Owner: postgres; Tablespace: 
--

CREATE TABLE tag (
    id_tag integer NOT NULL,
    libelle_tag text
);


ALTER TABLE lsi.tag OWNER TO postgres;

--
-- Name: tag_id_tag_seq; Type: SEQUENCE; Schema: lsi; Owner: postgres
--

CREATE SEQUENCE tag_id_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lsi.tag_id_tag_seq OWNER TO postgres;

--
-- Name: tag_id_tag_seq; Type: SEQUENCE OWNED BY; Schema: lsi; Owner: postgres
--

ALTER SEQUENCE tag_id_tag_seq OWNED BY tag.id_tag;


--
-- Name: id; Type: DEFAULT; Schema: lsi; Owner: postgres
--

ALTER TABLE ONLY news ALTER COLUMN id SET DEFAULT nextval('news_id_news_seq'::regclass);


--
-- Name: id_subject; Type: DEFAULT; Schema: lsi; Owner: postgres
--

ALTER TABLE ONLY subject ALTER COLUMN id_subject SET DEFAULT nextval('subject_id_subject_seq'::regclass);


--
-- Name: id_tag; Type: DEFAULT; Schema: lsi; Owner: postgres
--

ALTER TABLE ONLY tag ALTER COLUMN id_tag SET DEFAULT nextval('tag_id_tag_seq'::regclass);


--
-- Name: PK_coor_news_tag; Type: CONSTRAINT; Schema: lsi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coor_news_tag
    ADD CONSTRAINT "PK_coor_news_tag" PRIMARY KEY (id, id_tag);


--
-- Name: PK_news; Type: CONSTRAINT; Schema: lsi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY news
    ADD CONSTRAINT "PK_news" PRIMARY KEY (id);


--
-- Name: PK_subject; Type: CONSTRAINT; Schema: lsi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subject
    ADD CONSTRAINT "PK_subject" PRIMARY KEY (id_subject);


--
-- Name: PK_tag; Type: CONSTRAINT; Schema: lsi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT "PK_tag" PRIMARY KEY (id_tag);


--
-- Name: FK_coor_news; Type: FK CONSTRAINT; Schema: lsi; Owner: postgres
--

ALTER TABLE ONLY coor_news_tag
    ADD CONSTRAINT "FK_coor_news" FOREIGN KEY (id) REFERENCES news(id) MATCH FULL;


--
-- Name: FK_news_subject; Type: FK CONSTRAINT; Schema: lsi; Owner: postgres
--

ALTER TABLE ONLY news
    ADD CONSTRAINT "FK_news_subject" FOREIGN KEY (id_subject) REFERENCES subject(id_subject) MATCH FULL;


--
-- Name: PK_coor_tag; Type: FK CONSTRAINT; Schema: lsi; Owner: postgres
--

ALTER TABLE ONLY coor_news_tag
    ADD CONSTRAINT "PK_coor_tag" FOREIGN KEY (id_tag) REFERENCES tag(id_tag) MATCH FULL;


--
-- PostgreSQL database dump complete
--

