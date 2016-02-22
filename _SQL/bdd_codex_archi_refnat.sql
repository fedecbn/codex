--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: refnat; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA refnat;


ALTER SCHEMA refnat OWNER TO postgres;

--
-- Name: SCHEMA refnat; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA refnat IS 'standard public schema';


SET search_path = refnat, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: discussion; Type: TABLE; Schema: refnat; Owner: pg_user; Tablespace: 
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


ALTER TABLE refnat.discussion OWNER TO pg_user;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE; Schema: refnat; Owner: pg_user
--

CREATE SEQUENCE discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.discussion_id_discussion_seq OWNER TO pg_user;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: pg_user
--

ALTER SEQUENCE discussion_id_discussion_seq OWNED BY discussion.id_discussion;


--
-- Name: taxons; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxons (
    uid integer NOT NULL,
    cd_nom integer,
    cd_ref integer,
    cd_taxsup integer,
    rang character varying,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    group1_inpn character varying,
    group2_inpn character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    nom_complet_html character varying,
    nom_valide character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    habitat integer,
    fr character varying,
    gf character varying,
    mar character varying,
    gua character varying,
    sm character varying,
    spm character varying,
    may character varying,
    epa character varying,
    reu character varying,
    taaf character varying,
    pf character varying,
    nc character varying,
    wf character varying,
    cli character varying,
    url character varying,
    hybride boolean,
    lr boolean DEFAULT false,
    catnat boolean DEFAULT false,
    eee boolean DEFAULT false,
    pres_v2 boolean,
    pres_v3 boolean,
    pres_v4 boolean,
    pres_v5 boolean,
    pres_v6 boolean,
    pres_v7 boolean,
    pres_v8 boolean,
    modif boolean,
    sb character varying
);


ALTER TABLE refnat.taxons OWNER TO postgres;

--
-- Name: taxons_uid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxons_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxons_uid_seq OWNER TO postgres;

--
-- Name: taxons_uid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxons_uid_seq OWNED BY taxons.uid;


--
-- Name: taxref_changes_30_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_changes_30_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);


ALTER TABLE refnat.taxref_changes_30_utf8 OWNER TO postgres;

--
-- Name: taxref_changes_30_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxref_changes_30_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxref_changes_30_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxref_changes_30_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_30_utf8_ogc_fid_seq OWNED BY taxref_changes_30_utf8.ogc_fid;


--
-- Name: taxref_changes_40_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_changes_40_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);


ALTER TABLE refnat.taxref_changes_40_utf8 OWNER TO postgres;

--
-- Name: taxref_changes_40_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxref_changes_40_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxref_changes_40_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxref_changes_40_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_40_utf8_ogc_fid_seq OWNED BY taxref_changes_40_utf8.ogc_fid;


--
-- Name: taxref_changes_50_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_changes_50_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);


ALTER TABLE refnat.taxref_changes_50_utf8 OWNER TO postgres;

--
-- Name: taxref_changes_50_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxref_changes_50_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxref_changes_50_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxref_changes_50_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_50_utf8_ogc_fid_seq OWNED BY taxref_changes_50_utf8.ogc_fid;


--
-- Name: taxref_changes_60_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_changes_60_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);


ALTER TABLE refnat.taxref_changes_60_utf8 OWNER TO postgres;

--
-- Name: taxref_changes_60_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxref_changes_60_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxref_changes_60_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxref_changes_60_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_60_utf8_ogc_fid_seq OWNED BY taxref_changes_60_utf8.ogc_fid;


--
-- Name: taxref_changes_70_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_changes_70_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);


ALTER TABLE refnat.taxref_changes_70_utf8 OWNER TO postgres;

--
-- Name: taxref_changes_70_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxref_changes_70_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxref_changes_70_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxref_changes_70_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_70_utf8_ogc_fid_seq OWNED BY taxref_changes_70_utf8.ogc_fid;


--
-- Name: taxref_changes_80_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_changes_80_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);


ALTER TABLE refnat.taxref_changes_80_utf8 OWNER TO postgres;

--
-- Name: taxref_changes_80_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxref_changes_80_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxref_changes_80_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxref_changes_80_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_80_utf8_ogc_fid_seq OWNED BY taxref_changes_80_utf8.ogc_fid;


--
-- Name: taxrefv20_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv20_utf8 (
    ogc_fid integer NOT NULL,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    cd_nom character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    cd_ref character varying,
    nom_valide character varying,
    rang character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    fr character varying,
    mar character varying,
    gua character varying,
    smsb character varying,
    gf character varying,
    spm character varying,
    reu character varying,
    may character varying,
    taaf character varying
);


ALTER TABLE refnat.taxrefv20_utf8 OWNER TO postgres;

--
-- Name: taxrefv20_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv20_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv20_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxrefv20_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv20_utf8_ogc_fid_seq OWNED BY taxrefv20_utf8.ogc_fid;


--
-- Name: taxrefv30_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv30_utf8 (
    ogc_fid integer NOT NULL,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    cd_nom character varying,
    cd_taxsup character varying,
    cd_ref character varying,
    rang character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    habitat character varying,
    fr character varying,
    gf character varying,
    mar character varying,
    gua character varying,
    smsb character varying,
    spm character varying,
    may character varying,
    epa character varying,
    reu character varying,
    taaf character varying,
    nc character varying,
    wf character varying,
    pf character varying,
    cli character varying,
    nom_valide character varying
);


ALTER TABLE refnat.taxrefv30_utf8 OWNER TO postgres;

--
-- Name: taxrefv30_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv30_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv30_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxrefv30_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv30_utf8_ogc_fid_seq OWNED BY taxrefv30_utf8.ogc_fid;


--
-- Name: taxrefv40_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv40_utf8 (
    ogc_fid integer NOT NULL,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    cd_nom character varying,
    cd_taxsup character varying,
    cd_ref character varying,
    rang character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    nom_valide character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    habitat character varying,
    fr character varying,
    gf character varying,
    mar character varying,
    gua character varying,
    sm character varying,
    sb character varying,
    spm character varying,
    may character varying,
    epa character varying,
    reu character varying,
    taaf character varying,
    pf character varying,
    nc character varying,
    wf character varying,
    cli character varying,
    aphia_id character varying
);


ALTER TABLE refnat.taxrefv40_utf8 OWNER TO postgres;

--
-- Name: taxrefv40_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv40_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv40_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxrefv40_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv40_utf8_ogc_fid_seq OWNED BY taxrefv40_utf8.ogc_fid;


--
-- Name: taxrefv50_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv50_utf8 (
    ogc_fid integer NOT NULL,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    cd_nom character varying,
    cd_taxsup character varying,
    cd_ref character varying,
    rang character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    nom_valide character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    habitat character varying,
    fr character varying,
    gf character varying,
    mar character varying,
    gua character varying,
    sm character varying,
    sb character varying,
    spm character varying,
    may character varying,
    epa character varying,
    reu character varying,
    taaf character varying,
    pf character varying,
    nc character varying,
    wf character varying,
    cli character varying,
    url character varying
);


ALTER TABLE refnat.taxrefv50_utf8 OWNER TO postgres;

--
-- Name: taxrefv50_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv50_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv50_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxrefv50_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv50_utf8_ogc_fid_seq OWNED BY taxrefv50_utf8.ogc_fid;


--
-- Name: taxrefv60_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv60_utf8 (
    ogc_fid integer NOT NULL,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    cd_nom character varying,
    cd_taxsup character varying,
    cd_ref character varying,
    rang character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    nom_valide character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    habitat character varying,
    fr character varying,
    gf character varying,
    mar character varying,
    gua character varying,
    sm character varying,
    sb character varying,
    spm character varying,
    may character varying,
    epa character varying,
    reu character varying,
    taaf character varying,
    pf character varying,
    nc character varying,
    wf character varying,
    cli character varying,
    url character varying
);


ALTER TABLE refnat.taxrefv60_utf8 OWNER TO postgres;

--
-- Name: taxrefv60_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv60_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv60_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxrefv60_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv60_utf8_ogc_fid_seq OWNED BY taxrefv60_utf8.ogc_fid;


--
-- Name: taxrefv70_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv70_utf8 (
    ogc_fid integer NOT NULL,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    group1_inpn character varying,
    group2_inpn character varying,
    cd_nom character varying,
    cd_taxsup character varying,
    cd_ref character varying,
    rang character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    nom_valide character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    habitat character varying,
    fr character varying,
    gf character varying,
    mar character varying,
    gua character varying,
    sm character varying,
    sb character varying,
    spm character varying,
    may character varying,
    epa character varying,
    reu character varying,
    taaf character varying,
    pf character varying,
    nc character varying,
    wf character varying,
    cli character varying,
    url character varying
);


ALTER TABLE refnat.taxrefv70_utf8 OWNER TO postgres;

--
-- Name: taxrefv70_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv70_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv70_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxrefv70_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv70_utf8_ogc_fid_seq OWNED BY taxrefv70_utf8.ogc_fid;


--
-- Name: taxrefv80_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv80_utf8 (
    ogc_fid integer NOT NULL,
    regne character varying,
    phylum character varying,
    classe character varying,
    ordre character varying,
    famille character varying,
    group1_inpn character varying,
    group2_inpn character varying,
    cd_nom character varying,
    cd_taxsup character varying,
    cd_ref character varying,
    rang character varying,
    lb_nom character varying,
    lb_auteur character varying,
    nom_complet character varying,
    nom_valide character varying,
    nom_vern character varying,
    nom_vern_eng character varying,
    habitat character varying,
    fr character varying,
    gf character varying,
    mar character varying,
    gua character varying,
    sm character varying,
    sb character varying,
    spm character varying,
    may character varying,
    epa character varying,
    reu character varying,
    taaf character varying,
    pf character varying,
    nc character varying,
    wf character varying,
    cli character varying,
    url character varying,
    nom_complet_html character varying
);


ALTER TABLE refnat.taxrefv80_utf8 OWNER TO postgres;

--
-- Name: taxrefv80_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv80_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv80_utf8_ogc_fid_seq OWNER TO postgres;

--
-- Name: taxrefv80_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv80_utf8_ogc_fid_seq OWNED BY taxrefv80_utf8.ogc_fid;


--
-- Name: id_discussion; Type: DEFAULT; Schema: refnat; Owner: pg_user
--

ALTER TABLE ONLY discussion ALTER COLUMN id_discussion SET DEFAULT nextval('discussion_id_discussion_seq'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxons ALTER COLUMN uid SET DEFAULT nextval('taxons_uid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_30_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_30_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_40_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_40_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_50_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_50_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_60_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_60_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_70_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_70_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_80_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_80_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv20_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv20_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv30_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv30_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv40_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv40_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv50_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv50_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv60_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv60_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv70_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv70_utf8_ogc_fid_seq'::regclass);


--
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv80_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv80_utf8_ogc_fid_seq'::regclass);


--
-- Name: id_discussion_pkey; Type: CONSTRAINT; Schema: refnat; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);


--
-- Name: taxons_pkey; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxons
    ADD CONSTRAINT taxons_pkey PRIMARY KEY (uid);


--
-- Name: taxref_changes_30_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_30_utf8
    ADD CONSTRAINT taxref_changes_30_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxref_changes_40_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_40_utf8
    ADD CONSTRAINT taxref_changes_40_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxref_changes_50_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_50_utf8
    ADD CONSTRAINT taxref_changes_50_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxref_changes_60_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_60_utf8
    ADD CONSTRAINT taxref_changes_60_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxref_changes_70_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_70_utf8
    ADD CONSTRAINT taxref_changes_70_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxref_changes_80_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_80_utf8
    ADD CONSTRAINT taxref_changes_80_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxrefv20_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv20_utf8
    ADD CONSTRAINT taxrefv20_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxrefv30_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv30_utf8
    ADD CONSTRAINT taxrefv30_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxrefv40_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv40_utf8
    ADD CONSTRAINT taxrefv40_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxrefv50_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv50_utf8
    ADD CONSTRAINT taxrefv50_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxrefv60_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv60_utf8
    ADD CONSTRAINT taxrefv60_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxrefv70_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv70_utf8
    ADD CONSTRAINT taxrefv70_utf8_pk PRIMARY KEY (ogc_fid);


--
-- Name: taxrefv80_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv80_utf8
    ADD CONSTRAINT taxrefv80_utf8_pk PRIMARY KEY (ogc_fid);


--
-- PostgreSQL database dump complete
--

