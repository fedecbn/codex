


delete from applications.droit where rubrique='syntaxa';


--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-07-19 16:22:57

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = applications, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 411 (class 1259 OID 34503)
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


ALTER TABLE droit OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 34501)
-- Name: droit_id_droit_seq; Type: SEQUENCE; Schema: applications; Owner: postgres
--

CREATE SEQUENCE droit_id_droit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE droit_id_droit_seq OWNER TO postgres;

--
-- TOC entry 2881 (class 0 OID 0)
-- Dependencies: 410
-- Name: droit_id_droit_seq; Type: SEQUENCE OWNED BY; Schema: applications; Owner: postgres
--

ALTER SEQUENCE droit_id_droit_seq OWNED BY droit.id_droit;


--
-- TOC entry 192 (class 1259 OID 18619)
-- Name: utilisateur; Type: TABLE; Schema: applications; Owner: user_codex; Tablespace: 
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
    niveau_syntaxa smallint DEFAULT 0,
    ref_syntaxa boolean DEFAULT false,
    niveau_hub smallint DEFAULT 0,
    ref_hub boolean DEFAULT false
);


ALTER TABLE utilisateur OWNER TO user_codex;

--
-- TOC entry 2882 (class 0 OID 0)
-- Dependencies: 192
-- Name: TABLE utilisateur; Type: COMMENT; Schema: applications; Owner: user_codex
--

COMMENT ON TABLE utilisateur IS 'Utilisateurs';


--
-- TOC entry 2883 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN utilisateur.id_user; Type: COMMENT; Schema: applications; Owner: user_codex
--

COMMENT ON COLUMN utilisateur.id_user IS 'PK';


--
-- TOC entry 409 (class 1259 OID 34485)
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


ALTER TABLE utilisateur_role OWNER TO postgres;

--
-- TOC entry 2754 (class 2604 OID 34506)
-- Name: id_droit; Type: DEFAULT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY droit ALTER COLUMN id_droit SET DEFAULT nextval('droit_id_droit_seq'::regclass);


--
-- TOC entry 2875 (class 0 OID 34503)
-- Dependencies: 411
-- Data for Name: droit; Type: TABLE DATA; Schema: applications; Owner: postgres
--

INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lr', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lr', NULL, 'submit', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lr', NULL, 'del', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lr', NULL, 'liste', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lr', NULL, 'commun.inc', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'eee', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'eee', NULL, 'submit', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'eee', NULL, 'del', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'eee', NULL, 'liste', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'eee', NULL, 'commun.inc', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'catnat', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'catnat', NULL, 'submit', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'catnat', NULL, 'del', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'catnat', NULL, 'liste', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'catnat', NULL, 'commun.inc', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'refnat', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'refnat', NULL, 'submit', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'refnat', NULL, 'del', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'refnat', NULL, 'liste', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'refnat', NULL, 'commun.inc', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lsi', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lsi', NULL, 'submit', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lsi', NULL, 'del', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lsi', NULL, 'liste', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lsi', NULL, 'commun.inc', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'syntaxa', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'syntaxa', NULL, 'submit', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'syntaxa', NULL, 'del', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'syntaxa', NULL, 'liste', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'syntaxa', NULL, 'commun.inc', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'syntaxa', 'syntaxa', 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'home', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'module_admin', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'bugs', NULL, 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'home', NULL, 'install', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', NULL, 'affichage_rubrique', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', NULL, 'affichage_rubrique', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', NULL, 'affichage_rubrique', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', NULL, 'affichage_rubrique', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', NULL, 'affichage_rubrique', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'module_admin', 'affichage_rubrique', 'index', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'to-refnat', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'maj-from-taxa-button', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'valid', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'valid', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'valid', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'valid', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'valid', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'valid', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'to-refnat', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'import', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'import_taxon', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'export', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'bilan', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'verif', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'diff', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'push', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'pull', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'clear', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'del', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'log', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'edit_fiche', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'del_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'save_fiche', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'export_fiche', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'mdp-button', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'msg-button', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'view_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'edit_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'del_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'save_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'export_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'add_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'retour_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'edit_fiche', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'del_fiche', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'save_fiche', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'export_fiche', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'add_fiche', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'new-tab', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'taxref', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'refnat', 'droit', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'statuts', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'catnat', 'droit', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'valid', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'droit', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'droit', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'news', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lsi', 'droit', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'meta', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'data', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'taxa', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'droit', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'bilan', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'hub', 'droit', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'text', 'affichage', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'user', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'suivi', 'affichage', 'evaluateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'module_admin', 'log', 'affichage', 'administrateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'tab-new', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'bugs', 'tab-ok', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'refnat', NULL, 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'catnat', NULL, 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'eee', NULL, 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lr', NULL, 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'lsi', NULL, 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'fsd', NULL, 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'hub', NULL, 'form', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd1', 'bugs', 'id_page', 'affichage_rubrique', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'to-refnat', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'to-refnat', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'eee', 'eee_reg', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'fsd', 'fsd', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'affichage', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'clore_version_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'open_version_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'lr', 'lr', 'clore_etape_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'view_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'edit_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'del_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'validate_fiche', 'validateur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'save_fiche', 'participant');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'export_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'retour_fiche', 'lecteur');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', 'syntaxa', 'add_fiche', 'gestionnaire');
INSERT INTO droit ( typ_droit, rubrique, onglet, objet, role) VALUES ( 'd2', 'syntaxa', NULL, 'affichage_rubrique', 'lecteur');



--
-- TOC entry 2886 (class 0 OID 0)
-- Dependencies: 410
-- Name: droit_id_droit_seq; Type: SEQUENCE SET; Schema: applications; Owner: postgres
--

SELECT pg_catalog.setval('droit_id_droit_seq', 221, true);


--
-- TOC entry 2872 (class 0 OID 18619)
-- Dependencies: 192
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: applications; Owner: user_codex
--

INSERT INTO utilisateur (id_user, id_cbn, nom, prenom, pw, tel_bur, tel_port, tel_int, email, web, niveau_lr, descr, last_login, niveau_eee, niveau_lsi, niveau_catnat, niveau_refnat, login, ref_lr, ref_eee, ref_lsi, ref_catnat, ref_refnat, niveau_syntaxa, ref_syntaxa, niveau_hub, ref_hub) VALUES ('ADMI1', 16, 'admin', 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, 255, NULL, NULL, 255, 255, 255, 255, 'admin', true, true, true, true, true, 255, true, NULL, NULL);


--
-- TOC entry 2873 (class 0 OID 34485)
-- Dependencies: 409
-- Data for Name: utilisateur_role; Type: TABLE DATA; Schema: applications; Owner: postgres
--

INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'syntaxa', false, true, true, true, true, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ANJU3', 'syntaxa', false, true, true, true, true, false, true, false);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('THMI', 'syntaxa', false, true, true, true, true, false, true, false);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'eee', false, true, true, true, true, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'catnat', false, true, true, true, true, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'bugs', false, true, false, false, false, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'home', false, true, true, true, true, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'lr', false, true, true, true, true, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'module_admin', false, true, true, true, true, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'lsi', false, true, true, true, true, true, true, true);
INSERT INTO utilisateur_role (id_user, rubrique, no_acces, lecteur, participant, evaluateur, gestionnaire, validateur, administrateur, referent) VALUES ('ADMI1', 'refnat', false, true, true, true, true, true, true, true);


--
-- TOC entry 2762 (class 2606 OID 34511)
-- Name: droit_pk; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY droit
    ADD CONSTRAINT droit_pk PRIMARY KEY (id_droit);


--
-- TOC entry 2760 (class 2606 OID 34500)
-- Name: user_role_pk; Type: CONSTRAINT; Schema: applications; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utilisateur_role
    ADD CONSTRAINT user_role_pk PRIMARY KEY (id_user, rubrique);


--
-- TOC entry 2758 (class 2606 OID 18891)
-- Name: utilisateur_pkey; Type: CONSTRAINT; Schema: applications; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_user);


--
-- TOC entry 2755 (class 1259 OID 18999)
-- Name: utilisateur_id_user_idx; Type: INDEX; Schema: applications; Owner: user_codex; Tablespace: 
--

CREATE INDEX utilisateur_id_user_idx ON utilisateur USING btree (id_user);


--
-- TOC entry 2756 (class 1259 OID 19000)
-- Name: utilisateur_nom_idx; Type: INDEX; Schema: applications; Owner: user_codex; Tablespace: 
--

CREATE INDEX utilisateur_nom_idx ON utilisateur USING btree (nom);


--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 411
-- Name: droit; Type: ACL; Schema: applications; Owner: postgres
--

REVOKE ALL ON TABLE droit FROM PUBLIC;
REVOKE ALL ON TABLE droit FROM postgres;
GRANT ALL ON TABLE droit TO postgres;
GRANT ALL ON TABLE droit TO user_codex;


--
-- TOC entry 2884 (class 0 OID 0)
-- Dependencies: 192
-- Name: utilisateur; Type: ACL; Schema: applications; Owner: user_codex
--

REVOKE ALL ON TABLE utilisateur FROM PUBLIC;
REVOKE ALL ON TABLE utilisateur FROM user_codex;
GRANT ALL ON TABLE utilisateur TO user_codex;


--
-- TOC entry 2885 (class 0 OID 0)
-- Dependencies: 409
-- Name: utilisateur_role; Type: ACL; Schema: applications; Owner: postgres
--

REVOKE ALL ON TABLE utilisateur_role FROM PUBLIC;
REVOKE ALL ON TABLE utilisateur_role FROM postgres;
GRANT ALL ON TABLE utilisateur_role TO postgres;
GRANT ALL ON TABLE utilisateur_role TO user_codex;


-- Completed on 2016-07-19 16:22:57

--
-- PostgreSQL database dump complete
--

