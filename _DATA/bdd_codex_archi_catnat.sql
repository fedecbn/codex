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
-- Name: catnat; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA catnat;


ALTER SCHEMA catnat OWNER TO postgres;

SET search_path = catnat, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: discussion; Type: TABLE; Schema: catnat; Owner: pg_user; Tablespace: 
--

CREATE TABLE discussion (
    id_discussion integer NOT NULL,
    uid integer NOT NULL,
    id_user character varying(10) NOT NULL,
    nom character varying,
    prenom character varying,
    id_cbn smallint,
    commentaire_eval character varying,
    datetime timestamp without time zone
);


ALTER TABLE catnat.discussion OWNER TO pg_user;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE; Schema: catnat; Owner: pg_user
--

CREATE SEQUENCE discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE catnat.discussion_id_discussion_seq OWNER TO pg_user;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE OWNED BY; Schema: catnat; Owner: pg_user
--

ALTER SEQUENCE discussion_id_discussion_seq OWNED BY discussion.id_discussion;


--
-- Name: statut_nat; Type: TABLE; Schema: catnat; Owner: postgres; Tablespace: 
--

CREATE TABLE statut_nat (
    indi text,
    lr text,
    just_lr text,
    rarete text,
    endemisme boolean,
    presence character varying,
    uid integer NOT NULL,
    indi_cal character varying,
    lr_cal character varying,
    just_lr_cal character varying,
    rarete_cal character varying,
    endemisme_cal character varying,
    presence_cal character varying,
    indi_lr character varying,
    lr_lr character varying
);


ALTER TABLE catnat.statut_nat OWNER TO postgres;

--
-- Name: statut_reg; Type: TABLE; Schema: catnat; Owner: postgres; Tablespace: 
--

CREATE TABLE statut_reg (
    id_reg integer NOT NULL,
    nom_reg text NOT NULL,
    type_statut text NOT NULL,
    id_statut text NOT NULL,
    nom_statut text NOT NULL,
    uid integer NOT NULL
);


ALTER TABLE catnat.statut_reg OWNER TO postgres;

--
-- Name: taxons_nat; Type: TABLE; Schema: catnat; Owner: pg_user; Tablespace: 
--

CREATE TABLE taxons_nat (
    famille character varying,
    cd_ref integer,
    nom_sci character varying,
    cd_rang character varying,
    nom_vern character varying,
    hybride boolean,
    commentaire character varying,
    uid integer NOT NULL
);


ALTER TABLE catnat.taxons_nat OWNER TO pg_user;

--
-- Name: id_discussion; Type: DEFAULT; Schema: catnat; Owner: pg_user
--

ALTER TABLE ONLY discussion ALTER COLUMN id_discussion SET DEFAULT nextval('discussion_id_discussion_seq'::regclass);


--
-- Name: PK_coor_statut; Type: CONSTRAINT; Schema: catnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY statut_reg
    ADD CONSTRAINT "PK_coor_statut" PRIMARY KEY (uid, id_reg, type_statut);


--
-- Name: PK_coor_statut_nat; Type: CONSTRAINT; Schema: catnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY statut_nat
    ADD CONSTRAINT "PK_coor_statut_nat" PRIMARY KEY (uid);


--
-- Name: id_discussion_pkey; Type: CONSTRAINT; Schema: catnat; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);


--
-- Name: pk_taxon; Type: CONSTRAINT; Schema: catnat; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY taxons_nat
    ADD CONSTRAINT pk_taxon PRIMARY KEY (uid);


--
-- Name: taxons_cd_ref_idx; Type: INDEX; Schema: catnat; Owner: pg_user; Tablespace: 
--

CREATE INDEX taxons_cd_ref_idx ON taxons_nat USING btree (cd_ref);


--
-- PostgreSQL database dump complete
--

