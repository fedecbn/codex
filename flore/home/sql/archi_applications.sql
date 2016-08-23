--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.22
-- Dumped by pg_dump version 9.2.2
-- Started on 2016-07-21 14:23:20

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 219343441)
-- Name: applications; Type: SCHEMA; Schema: -; Owner: pg_user
--

CREATE SCHEMA applications;


ALTER SCHEMA applications OWNER TO pg_user;

--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA applications; Type: COMMENT; Schema: -; Owner: pg_user
--

COMMENT ON SCHEMA applications IS 'Applications';


SET search_path = applications, pg_catalog;

--
-- TOC entry 467 (class 1255 OID 219474820)
-- Name: maj_liste_taxon(); Type: FUNCTION; Schema: applications; Owner: postgres
--

CREATE FUNCTION maj_liste_taxon() RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
TRUNCATE applications.liste_taxon;
INSERT INTO applications.liste_taxon
    SELECT uid, 'eval_eee', nom_sci, cd_ref FROM eee.taxons;
INSERT INTO applications.liste_taxon
    SELECT uid, 'eval_lr', nom_sci, cd_ref FROM liste_rouge.taxons;
end
$$;


ALTER FUNCTION applications.maj_liste_taxon() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 171 (class 1259 OID 219343444)
-- Name: bug; Type: TABLE; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE TABLE bug (
    id_bug integer NOT NULL,
    id_user character varying(10) NOT NULL,
    date_bug timestamp without time zone,
    id_rubrique smallint,
    descr text,
    cat smallint,
    statut smallint DEFAULT 0,
    statut_descr text
);


ALTER TABLE applications.bug OWNER TO pg_user;

--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE bug; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON TABLE bug IS 'Buge et remarques';


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN bug.id_bug; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON COLUMN bug.id_bug IS 'PK';


--
-- TOC entry 172 (class 1259 OID 219343451)
-- Name: bug_id_bug_seq; Type: SEQUENCE; Schema: applications; Owner: pg_user
--

CREATE SEQUENCE bug_id_bug_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications.bug_id_bug_seq OWNER TO pg_user;

--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 172
-- Name: bug_id_bug_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: pg_user
--

ALTER SEQUENCE bug_id_bug_seq OWNED BY bug.id_bug;


--
-- TOC entry 332 (class 1259 OID 220479508)
-- Name: droit; Type: TABLE; Schema: applications; Owner: postgres; Tablespace: 
--

CREATE TABLE droit (
    id_droit integer NOT NULL,
    typ_droit character varying NOT NULL,
    rubrique character varying NOT NULL,
    onglet character varying,
    objet character varying,
    role character varying NOT NULL
);


ALTER TABLE applications.droit OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 220479506)
-- Name: droit_id_droit_seq; Type: SEQUENCE; Schema: applications; Owner: postgres
--

CREATE SEQUENCE droit_id_droit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications.droit_id_droit_seq OWNER TO postgres;

--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 331
-- Name: droit_id_droit_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: postgres
--

ALTER SEQUENCE droit_id_droit_seq OWNED BY droit.id_droit;


--
-- TOC entry 247 (class 1259 OID 219474802)
-- Name: liste_taxon; Type: TABLE; Schema: applications; Owner: postgres; Tablespace: 
--

CREATE TABLE liste_taxon (
    uid integer NOT NULL,
    rubrique_taxon character varying NOT NULL,
    nom_scien character varying,
    cd_ref integer
);


ALTER TABLE applications.liste_taxon OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 219343453)
-- Name: log; Type: TABLE; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE TABLE log (
    id_log integer NOT NULL,
    event smallint DEFAULT 0 NOT NULL,
    id_user character varying(10) NOT NULL,
    ip character varying,
    descr1 text,
    descr2 text,
    tables character varying,
    datetime_event timestamp without time zone
);


ALTER TABLE applications.log OWNER TO pg_user;

--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE log; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON TABLE log IS 'Logs';


--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN log.id_log; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON COLUMN log.id_log IS 'PK';


--
-- TOC entry 174 (class 1259 OID 219343460)
-- Name: log_id_log_seq; Type: SEQUENCE; Schema: applications; Owner: pg_user
--

CREATE SEQUENCE log_id_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications.log_id_log_seq OWNER TO pg_user;

--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 174
-- Name: log_id_log_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: pg_user
--

ALTER SEQUENCE log_id_log_seq OWNED BY log.id_log;


--
-- TOC entry 333 (class 1259 OID 220479517)
-- Name: onglet; Type: TABLE; Schema: applications; Owner: postgres; Tablespace: 
--

CREATE TABLE onglet (
    id_rubrique character varying NOT NULL,
    rubrique character varying,
    onglet character varying NOT NULL,
    nom character varying,
    ss_titre character varying,
    pos integer
);


ALTER TABLE applications.onglet OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 219343462)
-- Name: pres; Type: TABLE; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE TABLE pres (
    id_pres integer NOT NULL,
    id_module character varying(20) NOT NULL,
    page character varying(20) NOT NULL,
    titre character varying,
    pres text,
    lang smallint DEFAULT 0
);


ALTER TABLE applications.pres OWNER TO pg_user;

--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE pres; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON TABLE pres IS 'Textes de présentation';


--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN pres.id_pres; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON COLUMN pres.id_pres IS 'PK';


--
-- TOC entry 176 (class 1259 OID 219343469)
-- Name: pres_id_pres_seq; Type: SEQUENCE; Schema: applications; Owner: pg_user
--

CREATE SEQUENCE pres_id_pres_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications.pres_id_pres_seq OWNER TO pg_user;

--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 176
-- Name: pres_id_pres_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: pg_user
--

ALTER SEQUENCE pres_id_pres_seq OWNED BY pres.id_pres;


--
-- TOC entry 177 (class 1259 OID 219343471)
-- Name: rubrique; Type: TABLE; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE TABLE rubrique (
    id_rubrique integer NOT NULL,
    id_module character varying(20) NOT NULL,
    pos smallint DEFAULT 0 NOT NULL,
    icone character varying,
    titre character varying,
    descr character varying,
    niveau smallint DEFAULT 0 NOT NULL,
    link character varying NOT NULL,
    lang smallint DEFAULT 0,
    typ character varying DEFAULT 'list'::character varying
);


ALTER TABLE applications.rubrique OWNER TO pg_user;

--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE rubrique; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON TABLE rubrique IS 'Rubriques';


--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN rubrique.id_rubrique; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON COLUMN rubrique.id_rubrique IS 'PK';


--
-- TOC entry 178 (class 1259 OID 219343480)
-- Name: rubrique_id_rubrique_seq; Type: SEQUENCE; Schema: applications; Owner: pg_user
--

CREATE SEQUENCE rubrique_id_rubrique_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications.rubrique_id_rubrique_seq OWNER TO pg_user;

--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 178
-- Name: rubrique_id_rubrique_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: pg_user
--

ALTER SEQUENCE rubrique_id_rubrique_seq OWNED BY rubrique.id_rubrique;


--
-- TOC entry 179 (class 1259 OID 219343482)
-- Name: suivi; Type: TABLE; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE TABLE suivi (
    id_suivi integer NOT NULL,
    etape smallint DEFAULT 0 NOT NULL,
    id_user character varying(10) NOT NULL,
    tables character varying NOT NULL,
    champ character varying NOT NULL,
    valeur_1 character varying,
    valeur_2 character varying,
    datetime timestamp without time zone,
    rubrique character varying,
    methode character varying,
    type_modif character varying,
    libelle_1 character varying,
    libelle_2 character varying,
    uid character varying
);


ALTER TABLE applications.suivi OWNER TO pg_user;

--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE suivi; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON TABLE suivi IS 'Suivi des modifications';


--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN suivi.id_suivi; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON COLUMN suivi.id_suivi IS 'PK';


--
-- TOC entry 180 (class 1259 OID 219343489)
-- Name: suivi_id_suivi_seq; Type: SEQUENCE; Schema: applications; Owner: pg_user
--

CREATE SEQUENCE suivi_id_suivi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications.suivi_id_suivi_seq OWNER TO pg_user;

--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 180
-- Name: suivi_id_suivi_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: pg_user
--

ALTER SEQUENCE suivi_id_suivi_seq OWNED BY suivi.id_suivi;


--
-- TOC entry 263 (class 1259 OID 219518879)
-- Name: taxons; Type: TABLE; Schema: applications; Owner: postgres; Tablespace: 
--

CREATE TABLE taxons (
    uid integer NOT NULL,
    cd_ref integer,
    nom character varying,
    liste_rouge boolean DEFAULT true,
    catnat boolean DEFAULT true,
    eee boolean DEFAULT true,
    refnat boolean DEFAULT true,
    famille character varying,
    cd_rang character varying,
    hybride boolean,
    nom_verna character varying
);


ALTER TABLE applications.taxons OWNER TO postgres;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE taxons; Type: COMMENT; Schema: applications; Owner: postgres
--

COMMENT ON TABLE taxons IS 'Vérifier l''obsolescence de cete table (à supprimer?)
Remplacé par la table refnat.taxons';


--
-- TOC entry 262 (class 1259 OID 219518877)
-- Name: taxons_uid_seq; Type: SEQUENCE; Schema: applications; Owner: postgres
--

CREATE SEQUENCE taxons_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications.taxons_uid_seq OWNER TO postgres;

--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 262
-- Name: taxons_uid_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: postgres
--

ALTER SEQUENCE taxons_uid_seq OWNED BY taxons.uid;


--
-- TOC entry 329 (class 1259 OID 220101617)
-- Name: update_bdd; Type: TABLE; Schema: applications; Owner: postgres; Tablespace: 
--

CREATE TABLE update_bdd (
    id character varying NOT NULL,
    commit character varying,
    date date,
    descr character varying
);


ALTER TABLE applications.update_bdd OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 219343491)
-- Name: utilisateur; Type: TABLE; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE TABLE utilisateur (
    id_user character varying(10) NOT NULL,
    id_cbn smallint,
    nom character varying,
    prenom character varying,
    pw character varying(50) NOT NULL,
    tel_bur character varying,
    tel_port character varying,
    tel_int character varying,
    email character varying(255) DEFAULT NULL::character varying,
    web character varying,
    niveau_lr smallint DEFAULT 0,
    descr text,
    last_login timestamp without time zone,
    niveau_eee smallint DEFAULT 0,
    niveau_lsi smallint,
    niveau_catnat smallint,
    niveau_refnat smallint,
    login character varying,
    ref_lr boolean DEFAULT false,
    ref_eee boolean DEFAULT false,
    ref_lsi boolean DEFAULT false,
    ref_catnat boolean DEFAULT false,
    ref_refnat boolean DEFAULT false,
    niveau_fsd smallint DEFAULT 0,
    ref_fsd boolean DEFAULT false,
    niveau_hub smallint DEFAULT 0,
    ref_hub boolean DEFAULT false,
    niveau_syntaxa smallint,
    ref_syntaxa boolean
);


ALTER TABLE applications.utilisateur OWNER TO pg_user;

--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE utilisateur; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON TABLE utilisateur IS 'Utilisateurs';


--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN utilisateur.id_user; Type: COMMENT; Schema: applications; Owner: pg_user
--

COMMENT ON COLUMN utilisateur.id_user IS 'PK';


--
-- TOC entry 330 (class 1259 OID 220479490)
-- Name: utilisateur_role; Type: TABLE; Schema: applications; Owner: postgres; Tablespace: 
--

CREATE TABLE utilisateur_role (
    id_user character varying NOT NULL,
    rubrique character varying NOT NULL,
    no_acces boolean DEFAULT false,
    lecteur boolean DEFAULT false,
    participant boolean DEFAULT false,
    evaluateur boolean DEFAULT false,
    gestionnaire boolean DEFAULT false,
    validateur boolean DEFAULT false,
    administrateur boolean DEFAULT false,
    referent boolean DEFAULT false
);


ALTER TABLE applications.utilisateur_role OWNER TO postgres;

--
-- TOC entry 2855 (class 2604 OID 219343671)
-- Name: id_bug; Type: DEFAULT; Schema: applications; Owner: pg_user
--

ALTER TABLE ONLY bug ALTER COLUMN id_bug SET DEFAULT nextval('bug_id_bug_seq'::regclass);


--
-- TOC entry 2892 (class 2604 OID 220479511)
-- Name: id_droit; Type: DEFAULT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY droit ALTER COLUMN id_droit SET DEFAULT nextval('droit_id_droit_seq'::regclass);


--
-- TOC entry 2857 (class 2604 OID 219343672)
-- Name: id_log; Type: DEFAULT; Schema: applications; Owner: pg_user
--

ALTER TABLE ONLY log ALTER COLUMN id_log SET DEFAULT nextval('log_id_log_seq'::regclass);


--
-- TOC entry 2859 (class 2604 OID 219343673)
-- Name: id_pres; Type: DEFAULT; Schema: applications; Owner: pg_user
--

ALTER TABLE ONLY pres ALTER COLUMN id_pres SET DEFAULT nextval('pres_id_pres_seq'::regclass);


--
-- TOC entry 2863 (class 2604 OID 219343674)
-- Name: id_rubrique; Type: DEFAULT; Schema: applications; Owner: pg_user
--

ALTER TABLE ONLY rubrique ALTER COLUMN id_rubrique SET DEFAULT nextval('rubrique_id_rubrique_seq'::regclass);


--
-- TOC entry 2866 (class 2604 OID 219343675)
-- Name: id_suivi; Type: DEFAULT; Schema: applications; Owner: pg_user
--

ALTER TABLE ONLY suivi ALTER COLUMN id_suivi SET DEFAULT nextval('suivi_id_suivi_seq'::regclass);


--
-- TOC entry 2879 (class 2604 OID 219518882)
-- Name: uid; Type: DEFAULT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY taxons ALTER COLUMN uid SET DEFAULT nextval('taxons_uid_seq'::regclass);


--
-- TOC entry 2895 (class 2606 OID 219343695)
-- Name: bug_pkey; Type: CONSTRAINT; Schema: applications; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY bug
    ADD CONSTRAINT bug_pkey PRIMARY KEY (id_bug);


--
-- TOC entry 2929 (class 2606 OID 220479516)
-- Name: droit_pk; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY droit
    ADD CONSTRAINT droit_pk PRIMARY KEY (id_droit);


--
-- TOC entry 2921 (class 2606 OID 219474809)
-- Name: liste_taxon_pkey; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY liste_taxon
    ADD CONSTRAINT liste_taxon_pkey PRIMARY KEY (uid, rubrique_taxon);


--
-- TOC entry 2901 (class 2606 OID 219343697)
-- Name: log_pkey; Type: CONSTRAINT; Schema: applications; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id_log);


--
-- TOC entry 2906 (class 2606 OID 219343699)
-- Name: pres_pkey; Type: CONSTRAINT; Schema: applications; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY pres
    ADD CONSTRAINT pres_pkey PRIMARY KEY (id_pres);


--
-- TOC entry 2911 (class 2606 OID 219343701)
-- Name: rubrique_pkey; Type: CONSTRAINT; Schema: applications; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY rubrique
    ADD CONSTRAINT rubrique_pkey PRIMARY KEY (id_rubrique);


--
-- TOC entry 2915 (class 2606 OID 219343703)
-- Name: suivi_pkey; Type: CONSTRAINT; Schema: applications; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY suivi
    ADD CONSTRAINT suivi_pkey PRIMARY KEY (id_suivi);


--
-- TOC entry 2923 (class 2606 OID 219518891)
-- Name: taxons_pkey; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxons
    ADD CONSTRAINT taxons_pkey PRIMARY KEY (uid);


--
-- TOC entry 2925 (class 2606 OID 220101624)
-- Name: updt_pk; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY update_bdd
    ADD CONSTRAINT updt_pk PRIMARY KEY (id);


--
-- TOC entry 2927 (class 2606 OID 220479505)
-- Name: user_role_pk; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utilisateur_role
    ADD CONSTRAINT user_role_pk PRIMARY KEY (id_user, rubrique);


--
-- TOC entry 2931 (class 2606 OID 220479524)
-- Name: utilisateur_droit_pk; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY onglet
    ADD CONSTRAINT utilisateur_droit_pk PRIMARY KEY (id_rubrique, onglet);


--
-- TOC entry 2919 (class 2606 OID 219343707)
-- Name: utilisateur_pkey; Type: CONSTRAINT; Schema: applications; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_user);


--
-- TOC entry 2893 (class 1259 OID 219343790)
-- Name: bug_id_bug_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX bug_id_bug_idx ON bug USING btree (id_bug);


--
-- TOC entry 2896 (class 1259 OID 219343791)
-- Name: bug_statut_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX bug_statut_idx ON bug USING btree (statut);


--
-- TOC entry 2897 (class 1259 OID 219343792)
-- Name: log_event_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX log_event_idx ON log USING btree (event);


--
-- TOC entry 2898 (class 1259 OID 219343793)
-- Name: log_id_log_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX log_id_log_idx ON log USING btree (id_log);


--
-- TOC entry 2899 (class 1259 OID 219343794)
-- Name: log_id_user_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX log_id_user_idx ON log USING btree (id_user);


--
-- TOC entry 2902 (class 1259 OID 219343795)
-- Name: pres_id_module_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX pres_id_module_idx ON pres USING btree (id_module);


--
-- TOC entry 2903 (class 1259 OID 219343796)
-- Name: pres_id_pres_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX pres_id_pres_idx ON pres USING btree (id_pres);


--
-- TOC entry 2904 (class 1259 OID 219343797)
-- Name: pres_lang_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX pres_lang_idx ON pres USING btree (lang);


--
-- TOC entry 2907 (class 1259 OID 219343798)
-- Name: rubrique_id_module_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX rubrique_id_module_idx ON rubrique USING btree (id_module);


--
-- TOC entry 2908 (class 1259 OID 219343799)
-- Name: rubrique_id_rubrique_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX rubrique_id_rubrique_idx ON rubrique USING btree (id_rubrique);


--
-- TOC entry 2909 (class 1259 OID 219343800)
-- Name: rubrique_lang_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX rubrique_lang_idx ON rubrique USING btree (lang);


--
-- TOC entry 2912 (class 1259 OID 219343801)
-- Name: suivi_id_suivi_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX suivi_id_suivi_idx ON suivi USING btree (id_suivi);


--
-- TOC entry 2913 (class 1259 OID 219343802)
-- Name: suivi_id_user_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX suivi_id_user_idx ON suivi USING btree (id_user);


--
-- TOC entry 2916 (class 1259 OID 219343803)
-- Name: utilisateur_id_user_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX utilisateur_id_user_idx ON utilisateur USING btree (id_user);


--
-- TOC entry 2917 (class 1259 OID 219343804)
-- Name: utilisateur_nom_idx; Type: INDEX; Schema: applications; Owner: pg_user; Tablespace: 
--

CREATE INDEX utilisateur_nom_idx ON utilisateur USING btree (nom);


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 6
-- Name: applications; Type: ACL; Schema: -; Owner: pg_user
--

REVOKE ALL ON SCHEMA applications FROM PUBLIC;
REVOKE ALL ON SCHEMA applications FROM pg_user;
GRANT ALL ON SCHEMA applications TO pg_user;


--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 171
-- Name: bug; Type: ACL; Schema: applications; Owner: pg_user
--

REVOKE ALL ON TABLE bug FROM PUBLIC;
REVOKE ALL ON TABLE bug FROM pg_user;
GRANT ALL ON TABLE bug TO pg_user;
GRANT ALL ON TABLE bug TO postgres;


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 332
-- Name: droit; Type: ACL; Schema: applications; Owner: postgres
--

REVOKE ALL ON TABLE droit FROM PUBLIC;
REVOKE ALL ON TABLE droit FROM postgres;
GRANT ALL ON TABLE droit TO postgres;
GRANT ALL ON TABLE droit TO pg_user;


--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 247
-- Name: liste_taxon; Type: ACL; Schema: applications; Owner: postgres
--

REVOKE ALL ON TABLE liste_taxon FROM PUBLIC;
REVOKE ALL ON TABLE liste_taxon FROM postgres;
GRANT ALL ON TABLE liste_taxon TO postgres;
GRANT ALL ON TABLE liste_taxon TO pg_user;


--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 173
-- Name: log; Type: ACL; Schema: applications; Owner: pg_user
--

REVOKE ALL ON TABLE log FROM PUBLIC;
REVOKE ALL ON TABLE log FROM pg_user;
GRANT ALL ON TABLE log TO pg_user;
GRANT ALL ON TABLE log TO postgres;


--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 333
-- Name: onglet; Type: ACL; Schema: applications; Owner: postgres
--

REVOKE ALL ON TABLE onglet FROM PUBLIC;
REVOKE ALL ON TABLE onglet FROM postgres;
GRANT ALL ON TABLE onglet TO postgres;
GRANT ALL ON TABLE onglet TO pg_user;


--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 175
-- Name: pres; Type: ACL; Schema: applications; Owner: pg_user
--

REVOKE ALL ON TABLE pres FROM PUBLIC;
REVOKE ALL ON TABLE pres FROM pg_user;
GRANT ALL ON TABLE pres TO pg_user;
GRANT ALL ON TABLE pres TO postgres;


--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 177
-- Name: rubrique; Type: ACL; Schema: applications; Owner: pg_user
--

REVOKE ALL ON TABLE rubrique FROM PUBLIC;
REVOKE ALL ON TABLE rubrique FROM pg_user;
GRANT ALL ON TABLE rubrique TO pg_user;
GRANT ALL ON TABLE rubrique TO postgres;


--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 179
-- Name: suivi; Type: ACL; Schema: applications; Owner: pg_user
--

REVOKE ALL ON TABLE suivi FROM PUBLIC;
REVOKE ALL ON TABLE suivi FROM pg_user;
GRANT ALL ON TABLE suivi TO pg_user;
GRANT ALL ON TABLE suivi TO postgres;


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 263
-- Name: taxons; Type: ACL; Schema: applications; Owner: postgres
--

REVOKE ALL ON TABLE taxons FROM PUBLIC;
REVOKE ALL ON TABLE taxons FROM postgres;
GRANT ALL ON TABLE taxons TO postgres;
GRANT ALL ON TABLE taxons TO pg_user;


--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 181
-- Name: utilisateur; Type: ACL; Schema: applications; Owner: pg_user
--

REVOKE ALL ON TABLE utilisateur FROM PUBLIC;
REVOKE ALL ON TABLE utilisateur FROM pg_user;
GRANT ALL ON TABLE utilisateur TO pg_user;
GRANT ALL ON TABLE utilisateur TO postgres;


--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 330
-- Name: utilisateur_role; Type: ACL; Schema: applications; Owner: postgres
--

REVOKE ALL ON TABLE utilisateur_role FROM PUBLIC;
REVOKE ALL ON TABLE utilisateur_role FROM postgres;
GRANT ALL ON TABLE utilisateur_role TO postgres;
GRANT ALL ON TABLE utilisateur_role TO pg_user;


-- Completed on 2016-07-21 14:23:22

--
-- PostgreSQL database dump complete
--

