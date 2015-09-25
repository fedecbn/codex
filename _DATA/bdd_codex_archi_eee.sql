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
-- Name: eee; Type: SCHEMA; Schema: -; Owner: pg_user
--

CREATE SCHEMA eee;


ALTER SCHEMA eee OWNER TO pg_user;

SET search_path = eee, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: argument; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE argument (
    ida integer NOT NULL,
    contenu character varying,
    uid integer NOT NULL
);


ALTER TABLE eee.argument OWNER TO pg_user;

--
-- Name: discussion; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
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


ALTER TABLE eee.discussion OWNER TO pg_user;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE; Schema: eee; Owner: pg_user
--

CREATE SEQUENCE discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eee.discussion_id_discussion_seq OWNER TO pg_user;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE OWNED BY; Schema: eee; Owner: pg_user
--

ALTER SEQUENCE discussion_id_discussion_seq OWNED BY discussion.id_discussion;


--
-- Name: evaluation; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE evaluation (
    ind_a integer,
    ind_b integer,
    ind_c integer,
    ind_tot integer,
    eval_tot character varying,
    fiab_tot numeric,
    zone character varying,
    liste_eval character varying,
    carac_emerg character varying,
    carac_avere character varying,
    eval_expert character varying,
    uid integer NOT NULL,
    CONSTRAINT ck_zone CHECK (((zone)::text = ANY (ARRAY[('gl'::character varying)::text, ('za'::character varying)::text, ('zc'::character varying)::text, ('zm'::character varying)::text]))),
    CONSTRAINT statut CHECK (((((liste_eval)::text = ANY (ARRAY[('pcpl'::character varying)::text, ('annexe'::character varying)::text, NULL::text])) AND ((carac_emerg)::text = ANY (ARRAY[('emerg'::character varying)::text, ('non_emerg'::character varying)::text, NULL::text]))) AND ((carac_avere)::text = ANY (ARRAY[('avere_local'::character varying)::text, ('avere_ailleurs'::character varying)::text, ('non_avere'::character varying)::text, NULL::text]))))
);


ALTER TABLE eee.evaluation OWNER TO pg_user;

--
-- Name: liste_argument; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE liste_argument (
    ida integer NOT NULL,
    libelle character varying
);


ALTER TABLE eee.liste_argument OWNER TO pg_user;

--
-- Name: liste_argument_ida_seq; Type: SEQUENCE; Schema: eee; Owner: pg_user
--

CREATE SEQUENCE liste_argument_ida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eee.liste_argument_ida_seq OWNER TO pg_user;

--
-- Name: liste_argument_ida_seq; Type: SEQUENCE OWNED BY; Schema: eee; Owner: pg_user
--

ALTER SEQUENCE liste_argument_ida_seq OWNED BY liste_argument.ida;


--
-- Name: liste_reponse; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE liste_reponse (
    idq integer NOT NULL,
    code_question character varying,
    libelle_question character varying,
    libelle_reponse character varying,
    libelle_court_reponse character varying,
    indicateur integer,
    code_eval character varying,
    coor_ids integer
);


ALTER TABLE eee.liste_reponse OWNER TO pg_user;

--
-- Name: liste_reponse_idq_seq; Type: SEQUENCE; Schema: eee; Owner: pg_user
--

CREATE SEQUENCE liste_reponse_idq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eee.liste_reponse_idq_seq OWNER TO pg_user;

--
-- Name: liste_reponse_idq_seq; Type: SEQUENCE OWNED BY; Schema: eee; Owner: pg_user
--

ALTER SEQUENCE liste_reponse_idq_seq OWNED BY liste_reponse.idq;


--
-- Name: liste_source; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE liste_source (
    ids integer NOT NULL,
    libelle character varying
);


ALTER TABLE eee.liste_source OWNER TO pg_user;

--
-- Name: liste_source_ids_seq; Type: SEQUENCE; Schema: eee; Owner: pg_user
--

CREATE SEQUENCE liste_source_ids_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eee.liste_source_ids_seq OWNER TO pg_user;

--
-- Name: liste_source_ids_seq; Type: SEQUENCE OWNED BY; Schema: eee; Owner: pg_user
--

ALTER SEQUENCE liste_source_ids_seq OWNED BY liste_source.ids;


--
-- Name: pays; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE pays (
    idp integer NOT NULL,
    continent character varying,
    pays character varying,
    zone character varying,
    region_biogeo character varying,
    x_min numeric,
    x_max numeric,
    y_min numeric,
    y_max numeric,
    CONSTRAINT ck_pays CHECK (((region_biogeo)::text = ANY (ARRAY[('za'::character varying)::text, ('zc'::character varying)::text, ('zm'::character varying)::text])))
);


ALTER TABLE eee.pays OWNER TO pg_user;

--
-- Name: pays_idp_seq; Type: SEQUENCE; Schema: eee; Owner: pg_user
--

CREATE SEQUENCE pays_idp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eee.pays_idp_seq OWNER TO pg_user;

--
-- Name: pays_idp_seq; Type: SEQUENCE OWNED BY; Schema: eee; Owner: pg_user
--

ALTER SEQUENCE pays_idp_seq OWNED BY pays.idp;


--
-- Name: region; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE region (
    idr integer NOT NULL,
    insee_reg integer,
    cbn character varying,
    region character varying,
    region_biogeo character varying,
    CONSTRAINT ck_region CHECK (((region_biogeo)::text = ANY (ARRAY[('za'::character varying)::text, ('zc'::character varying)::text, ('zm'::character varying)::text])))
);


ALTER TABLE eee.region OWNER TO pg_user;

--
-- Name: reponse; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE reponse (
    idq integer NOT NULL,
    zone character varying NOT NULL,
    uid integer NOT NULL,
    CONSTRAINT ck_zone_reponse CHECK (((zone)::text = ANY (ARRAY[('gl'::character varying)::text, ('za'::character varying)::text, ('zc'::character varying)::text, ('zm'::character varying)::text])))
);


ALTER TABLE eee.reponse OWNER TO pg_user;

--
-- Name: source; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE source (
    ids integer NOT NULL,
    contenu character varying,
    fiabilite integer,
    uid integer NOT NULL
);


ALTER TABLE eee.source OWNER TO pg_user;

--
-- Name: statut_inter; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE statut_inter (
    idp integer NOT NULL,
    statut character varying NOT NULL,
    uid integer NOT NULL,
    CONSTRAINT ck_statut_inter CHECK (((statut)::text = ANY (ARRAY[('pres'::character varying)::text, ('indig'::character varying)::text, ('invav'::character varying)::text])))
);


ALTER TABLE eee.statut_inter OWNER TO pg_user;

--
-- Name: statut_natio; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE statut_natio (
    idr integer NOT NULL,
    statut character varying NOT NULL,
    uid integer NOT NULL,
    CONSTRAINT ck_statut_nation CHECK (((statut)::text = ANY (ARRAY[('pres'::character varying)::text, ('indig'::character varying)::text, ('invav'::character varying)::text])))
);


ALTER TABLE eee.statut_natio OWNER TO pg_user;

--
-- Name: taxons; Type: TABLE; Schema: eee; Owner: pg_user; Tablespace: 
--

CREATE TABLE taxons (
    cd_ref integer,
    nom_sci character varying,
    lib_rang character varying,
    nom_verna character varying,
    cd_nom integer,
    commentaire character varying,
    gbif_url character varying,
    uid integer NOT NULL
);


ALTER TABLE eee.taxons OWNER TO pg_user;

--
-- Name: id_discussion; Type: DEFAULT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY discussion ALTER COLUMN id_discussion SET DEFAULT nextval('discussion_id_discussion_seq'::regclass);


--
-- Name: ida; Type: DEFAULT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY liste_argument ALTER COLUMN ida SET DEFAULT nextval('liste_argument_ida_seq'::regclass);


--
-- Name: idq; Type: DEFAULT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY liste_reponse ALTER COLUMN idq SET DEFAULT nextval('liste_reponse_idq_seq'::regclass);


--
-- Name: ids; Type: DEFAULT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY liste_source ALTER COLUMN ids SET DEFAULT nextval('liste_source_ids_seq'::regclass);


--
-- Name: idp; Type: DEFAULT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY pays ALTER COLUMN idp SET DEFAULT nextval('pays_idp_seq'::regclass);


--
-- Name: PK_argument; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY argument
    ADD CONSTRAINT "PK_argument" PRIMARY KEY (uid, ida);


--
-- Name: PK_eval; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT "PK_eval" PRIMARY KEY (uid);


--
-- Name: PK_liste_argument; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY liste_argument
    ADD CONSTRAINT "PK_liste_argument" PRIMARY KEY (ida);


--
-- Name: PK_liste_source; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY liste_source
    ADD CONSTRAINT "PK_liste_source" PRIMARY KEY (ids);


--
-- Name: PK_pays; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY pays
    ADD CONSTRAINT "PK_pays" PRIMARY KEY (idp);


--
-- Name: PK_question; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY liste_reponse
    ADD CONSTRAINT "PK_question" PRIMARY KEY (idq);


--
-- Name: PK_region; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT "PK_region" PRIMARY KEY (idr);


--
-- Name: PK_reponse; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY reponse
    ADD CONSTRAINT "PK_reponse" PRIMARY KEY (uid, idq, zone);


--
-- Name: PK_source; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY source
    ADD CONSTRAINT "PK_source" PRIMARY KEY (uid, ids);


--
-- Name: PK_statut_inter; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY statut_inter
    ADD CONSTRAINT "PK_statut_inter" PRIMARY KEY (uid, idp, statut);


--
-- Name: PK_statut_natio; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY statut_natio
    ADD CONSTRAINT "PK_statut_natio" PRIMARY KEY (uid, idr, statut);


--
-- Name: PK_taxons; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY taxons
    ADD CONSTRAINT "PK_taxons" PRIMARY KEY (uid);


--
-- Name: id_discussion_pkey; Type: CONSTRAINT; Schema: eee; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);


--
-- Name: FK_argument_liste; Type: FK CONSTRAINT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY argument
    ADD CONSTRAINT "FK_argument_liste" FOREIGN KEY (ida) REFERENCES liste_argument(ida) MATCH FULL;


--
-- Name: FK_idq_liste_reponse; Type: FK CONSTRAINT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY reponse
    ADD CONSTRAINT "FK_idq_liste_reponse" FOREIGN KEY (idq) REFERENCES liste_reponse(idq) MATCH FULL;


--
-- Name: FK_sources_liste; Type: FK CONSTRAINT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY source
    ADD CONSTRAINT "FK_sources_liste" FOREIGN KEY (ids) REFERENCES liste_source(ids) MATCH FULL;


--
-- Name: FK_statut_inter_pays; Type: FK CONSTRAINT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY statut_inter
    ADD CONSTRAINT "FK_statut_inter_pays" FOREIGN KEY (idp) REFERENCES pays(idp) MATCH FULL;


--
-- Name: FK_statut_natio_region; Type: FK CONSTRAINT; Schema: eee; Owner: pg_user
--

ALTER TABLE ONLY statut_natio
    ADD CONSTRAINT "FK_statut_natio_region" FOREIGN KEY (idr) REFERENCES region(idr) MATCH FULL;


--
-- PostgreSQL database dump complete
--

