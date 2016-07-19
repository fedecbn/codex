--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.22
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-07-19 14:49:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = syntaxa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 355 (class 1259 OID 220101772)
-- Name: liste_geo; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE liste_geo (
    id_territoire text NOT NULL,
    code_type_territoire text,
    code_territoire text,
    libelle_territoire text,
    id_tri integer NOT NULL
);


ALTER TABLE liste_geo OWNER TO postgres;

--
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE liste_geo; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE liste_geo IS 'Table listant les territoires géographiques de référence pour la chorologie';


--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 355
-- Name: COLUMN liste_geo.id_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.id_territoire IS 'identifiant unique du territoire';


--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 355
-- Name: COLUMN liste_geo.code_type_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.code_type_territoire IS 'code du type de territoire (RA:région agricole, DEP: département, REG: région)';


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 355
-- Name: COLUMN liste_geo.code_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.code_territoire IS 'Code du territoire dans son référentiel d''origine (ex: insee pour les départements)';


--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 355
-- Name: COLUMN liste_geo.libelle_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.libelle_territoire IS 'Libellé du territoire dans son référentiel d''origine (ex: insee pour les départements)';


--
-- TOC entry 427 (class 1259 OID 220103589)
-- Name: liste_geo_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE liste_geo_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE liste_geo_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 427
-- Name: liste_geo_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE liste_geo_id_tri_seq OWNED BY liste_geo.id_tri;


--
-- TOC entry 356 (class 1259 OID 220101781)
-- Name: referentiel_taxo; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE referentiel_taxo (
    id_rattachement_referentiel text NOT NULL,
    code_referentiel text,
    version_referentiel text,
    cd_ref_referentiel text,
    cd_nom_referentiel text,
    nom_complet_taxon_referentiel text
);


ALTER TABLE referentiel_taxo OWNER TO postgres;

--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 356
-- Name: TABLE referentiel_taxo; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE referentiel_taxo IS 'Table listant les taxons dans les différents référentiels taxonomiques';


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 356
-- Name: COLUMN referentiel_taxo.id_rattachement_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.id_rattachement_referentiel IS 'identifiant unique du taxon dans un référentiel donné';


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 356
-- Name: COLUMN referentiel_taxo.code_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.code_referentiel IS 'nom codifié du référentiel';


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 356
-- Name: COLUMN referentiel_taxo.version_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.version_referentiel IS 'version du référentiel';


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 356
-- Name: COLUMN referentiel_taxo.cd_ref_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.cd_ref_referentiel IS 'cd_ref dans le référentiel';


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 356
-- Name: COLUMN referentiel_taxo.cd_nom_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.cd_nom_referentiel IS 'cd_nom dans le référentiel';


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 356
-- Name: COLUMN referentiel_taxo.nom_complet_taxon_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.nom_complet_taxon_referentiel IS 'nom complet du taxon dans le référentiel';


--
-- TOC entry 377 (class 1259 OID 220101913)
-- Name: st_ref_action_suivi; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_action_suivi (
    "codeActionSuivi" text NOT NULL,
    "libActionSuivi" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_action_suivi OWNER TO postgres;

--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 377
-- Name: TABLE st_ref_action_suivi; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_action_suivi IS 'Référentiel des types de suivi de données';


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 377
-- Name: COLUMN st_ref_action_suivi."codeActionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi."codeActionSuivi" IS 'Codification du type de suivi';


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 377
-- Name: COLUMN st_ref_action_suivi."libActionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi."libActionSuivi" IS 'Libellé du type de suivi';


--
-- TOC entry 376 (class 1259 OID 220101911)
-- Name: st_ref_action_suivi_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_action_suivi_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_action_suivi_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 376
-- Name: st_ref_action_suivi_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_action_suivi_id_tri_seq OWNED BY st_ref_action_suivi.id_tri;


--
-- TOC entry 362 (class 1259 OID 220101818)
-- Name: st_ref_categorie_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_categorie_seriegeoserie (
    "codeCategorieSerieGeoserie" text NOT NULL,
    "libCategorieSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_categorie_seriegeoserie OWNER TO postgres;

--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE st_ref_categorie_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_categorie_seriegeoserie IS 'Référentiel des catégorie de série et de géoséries';


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN st_ref_categorie_seriegeoserie."codeCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie."codeCategorieSerieGeoserie" IS 'code de la catégorie de série et de géoséries';


--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN st_ref_categorie_seriegeoserie."libCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie."libCategorieSerieGeoserie" IS 'libelle de la catégorie de série et de géoséries';


--
-- TOC entry 361 (class 1259 OID 220101816)
-- Name: st_ref_categorie_seriegeoserie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_categorie_seriegeoserie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_categorie_seriegeoserie_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 361
-- Name: st_ref_categorie_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_categorie_seriegeoserie_id_tri_seq OWNED BY st_ref_categorie_seriegeoserie.id_tri;


--
-- TOC entry 419 (class 1259 OID 220102191)
-- Name: st_ref_continentalite; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_continentalite (
    "indCont" text NOT NULL,
    "libCont" text,
    "libLongCont" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_continentalite OWNER TO postgres;

--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 419
-- Name: TABLE st_ref_continentalite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_continentalite IS 'Référentiel de la continentalité selon Landolt';


--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN st_ref_continentalite."indCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."indCont" IS 'Indice de la continentalite selon Landolt';


--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN st_ref_continentalite."libCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."libCont" IS 'libellé court de la Continentalité selon Landolt';


--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN st_ref_continentalite."libLongCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."libLongCont" IS 'libellé long de continentalité selon Landolt';


--
-- TOC entry 418 (class 1259 OID 220102189)
-- Name: st_ref_continentalite_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_continentalite_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_continentalite_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 418
-- Name: st_ref_continentalite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_continentalite_id_tri_seq OWNED BY st_ref_continentalite.id_tri;


--
-- TOC entry 409 (class 1259 OID 220102136)
-- Name: st_ref_critique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_critique (
    "idCritique" text NOT NULL,
    "libCritique" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_critique OWNER TO postgres;

--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 409
-- Name: TABLE st_ref_critique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_critique IS 'Référentiel de la criticité des syntaxons';


--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 409
-- Name: COLUMN st_ref_critique."idCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique."idCritique" IS 'valeurs que prend le caractère critique (oui/non)';


--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 409
-- Name: COLUMN st_ref_critique."libCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique."libCritique" IS 'libellé du caractère critique le syntaxon est critique, le syntaxon n''est pas critique';


--
-- TOC entry 408 (class 1259 OID 220102134)
-- Name: st_ref_critique_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_critique_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_critique_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 408
-- Name: st_ref_critique_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_critique_id_tri_seq OWNED BY st_ref_critique.id_tri;


--
-- TOC entry 392 (class 1259 OID 220102027)
-- Name: st_ref_etage_bioclim; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_etage_bioclim (
    "codeEtageBioclim" text NOT NULL,
    "libEtageBioclim" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_etage_bioclim OWNER TO postgres;

--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 392
-- Name: TABLE st_ref_etage_bioclim; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_etage_bioclim IS 'Référentiel des étages bioclimatiques';


--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 392
-- Name: COLUMN st_ref_etage_bioclim."codeEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim."codeEtageBioclim" IS 'code de l''étage bioclimatique';


--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 392
-- Name: COLUMN st_ref_etage_bioclim."libEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim."libEtageBioclim" IS 'libellé de l''étage bioclimatique';


--
-- TOC entry 391 (class 1259 OID 220102025)
-- Name: st_ref_etage_bioclim_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_etage_bioclim_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_etage_bioclim_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 391
-- Name: st_ref_etage_bioclim_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_etage_bioclim_id_tri_seq OWNED BY st_ref_etage_bioclim.id_tri;


--
-- TOC entry 445 (class 1259 OID 220481413)
-- Name: st_ref_etage_veg; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_etage_veg (
    "codeEtageVeg" text NOT NULL,
    "libEtageVeg" text,
    "libLongEtageVeg" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_etage_veg OWNER TO postgres;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 445
-- Name: TABLE st_ref_etage_veg; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_etage_veg IS 'Référentiel des étages de végétation proposé par le réseau';


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 445
-- Name: COLUMN st_ref_etage_veg."codeEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."codeEtageVeg" IS 'code de l''étage de végétation';


--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 445
-- Name: COLUMN st_ref_etage_veg."libEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."libEtageVeg" IS 'libellé de l''étage de végétation';


--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 445
-- Name: COLUMN st_ref_etage_veg."libLongEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."libLongEtageVeg" IS 'libellé long de l''étage de végétation';


--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 445
-- Name: COLUMN st_ref_etage_veg.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 444 (class 1259 OID 220481411)
-- Name: st_ref_etage_veg_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_etage_veg_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_etage_veg_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 444
-- Name: st_ref_etage_veg_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_etage_veg_id_tri_seq OWNED BY st_ref_etage_veg.id_tri;


--
-- TOC entry 424 (class 1259 OID 220102232)
-- Name: st_ref_eunis; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_eunis (
    "codeEUNIS" text NOT NULL,
    "libEUNIS" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_eunis OWNER TO postgres;

--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 424
-- Name: TABLE st_ref_eunis; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_eunis IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats de la directive habitat (N2000)';


--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN st_ref_eunis."codeEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis."codeEUNIS" IS 'code de l''habitat EUNIS concerné par la correspondance';


--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN st_ref_eunis."libEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis."libEUNIS" IS 'libellé de l''habitat EUNIS concerné par la correspondance';


--
-- TOC entry 423 (class 1259 OID 220102230)
-- Name: st_ref_eunis_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_eunis_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_eunis_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 423
-- Name: st_ref_eunis_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_eunis_id_tri_seq OWNED BY st_ref_eunis.id_tri;


--
-- TOC entry 402 (class 1259 OID 220102090)
-- Name: st_ref_exposition; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_exposition (
    "idExposition" text NOT NULL,
    "libExposition" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_exposition OWNER TO postgres;

--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 402
-- Name: TABLE st_ref_exposition; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_exposition IS 'Référentiel des valeurs d''exposition';


--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 402
-- Name: COLUMN st_ref_exposition."idExposition"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition."idExposition" IS 'identifiant de l''exposition de la végétation';


--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 402
-- Name: COLUMN st_ref_exposition."libExposition"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition."libExposition" IS 'libellé de l''exposition de la végétation';


--
-- TOC entry 401 (class 1259 OID 220102088)
-- Name: st_ref_exposition_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_exposition_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_exposition_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 401
-- Name: st_ref_exposition_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_exposition_id_tri_seq OWNED BY st_ref_exposition.id_tri;


--
-- TOC entry 383 (class 1259 OID 220101957)
-- Name: st_ref_geomorpho; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_geomorpho (
    "idGeomorphologie" text,
    "libGeomorphologie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_geomorpho OWNER TO postgres;

--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 383
-- Name: TABLE st_ref_geomorpho; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_geomorpho IS 'Référentiel géomorphologique';


--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 383
-- Name: COLUMN st_ref_geomorpho."idGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."idGeomorphologie" IS 'identifiant du taxon géomorphologique';


--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 383
-- Name: COLUMN st_ref_geomorpho."libGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."libGeomorphologie" IS 'libellé de la géomorphologie';


--
-- TOC entry 382 (class 1259 OID 220101955)
-- Name: st_ref_geomorpho_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_geomorpho_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_geomorpho_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 382
-- Name: st_ref_geomorpho_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_geomorpho_id_tri_seq OWNED BY st_ref_geomorpho.id_tri;


--
-- TOC entry 388 (class 1259 OID 220101989)
-- Name: st_ref_hic; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_hic (
    "codeHIC" text NOT NULL,
    "libHIC" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_hic OWNER TO postgres;

--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 388
-- Name: TABLE st_ref_hic; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_hic IS 'Référentiel des habitats de la directive habitat (N2000)';


--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 388
-- Name: COLUMN st_ref_hic."codeHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_hic."codeHIC" IS 'code de l''habitat Natura 2000';


--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 388
-- Name: COLUMN st_ref_hic."libHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_hic."libHIC" IS 'libellé de l''habitat Natura 2000';


--
-- TOC entry 387 (class 1259 OID 220101987)
-- Name: st_ref_hic_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_hic_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_hic_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 387
-- Name: st_ref_hic_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_hic_id_tri_seq OWNED BY st_ref_hic.id_tri;


--
-- TOC entry 396 (class 1259 OID 220102057)
-- Name: st_ref_humidite; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_humidite (
    "indHum" text NOT NULL,
    "libHum" text,
    "libLongHum" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_humidite OWNER TO postgres;

--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 396
-- Name: TABLE st_ref_humidite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_humidite IS 'Référentiel de l''indice d''humidité édaphique selon Ellenberg et Julve (moisture)';


--
-- TOC entry 2989 (class 0 OID 0)
-- Dependencies: 396
-- Name: COLUMN st_ref_humidite."indHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."indHum" IS 'Indice de l''Humidité selon Ellenberg et Julve';


--
-- TOC entry 2990 (class 0 OID 0)
-- Dependencies: 396
-- Name: COLUMN st_ref_humidite."libHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."libHum" IS 'libellé court de l''Humidité selon Ellenberg et Julve';


--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 396
-- Name: COLUMN st_ref_humidite."libLongHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."libLongHum" IS 'libellé long de l''Humidité selon Ellenberg et Julve';


--
-- TOC entry 395 (class 1259 OID 220102055)
-- Name: st_ref_humidite_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_humidite_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_humidite_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 395
-- Name: st_ref_humidite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_humidite_id_tri_seq OWNED BY st_ref_humidite.id_tri;


--
-- TOC entry 415 (class 1259 OID 220102169)
-- Name: st_ref_lumiere; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_lumiere (
    "indLum" text NOT NULL,
    "libLum" text,
    "libLongLum" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_lumiere OWNER TO postgres;

--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 415
-- Name: TABLE st_ref_lumiere; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_lumiere IS 'Référentiel des indices d''affinité de la végétation à la lumière selon Landolt';


--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 415
-- Name: COLUMN st_ref_lumiere."indLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."indLum" IS 'Indice d''affinité à la lumière selon Landolt';


--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 415
-- Name: COLUMN st_ref_lumiere."libLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."libLum" IS 'libellé court d''affinité à la lumière selon Landolt';


--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 415
-- Name: COLUMN st_ref_lumiere."libLongLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."libLongLum" IS 'libellé long  d''affinité à la lumière selon Landolt';


--
-- TOC entry 414 (class 1259 OID 220102167)
-- Name: st_ref_lumiere_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_lumiere_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_lumiere_id_tri_seq OWNER TO postgres;

--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 414
-- Name: st_ref_lumiere_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_lumiere_id_tri_seq OWNED BY st_ref_lumiere.id_tri;


--
-- TOC entry 417 (class 1259 OID 220102180)
-- Name: st_ref_neige; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_neige (
    "idNeige" text NOT NULL,
    "libNeige" text,
    "libLongNeige" text,
    "exempleNeige" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_neige OWNER TO postgres;

--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 417
-- Name: TABLE st_ref_neige; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_neige IS 'Référentiel de l''affinité de la végétation à la neige';


--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 417
-- Name: COLUMN st_ref_neige."idNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."idNeige" IS 'identifiant (code) qui indique l''affinité de la végétation à la neige';


--
-- TOC entry 3002 (class 0 OID 0)
-- Dependencies: 417
-- Name: COLUMN st_ref_neige."libNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."libNeige" IS 'libellé qui indique l''affinité de la végétation à la neige';


--
-- TOC entry 3003 (class 0 OID 0)
-- Dependencies: 417
-- Name: COLUMN st_ref_neige."libLongNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."libLongNeige" IS 'libellé long qui indique l''affinité de la végétation à la neige';


--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 417
-- Name: COLUMN st_ref_neige."exempleNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."exempleNeige" IS 'exemple de végétation pour ce critère d''affinité à la neige';


--
-- TOC entry 416 (class 1259 OID 220102178)
-- Name: st_ref_neige_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_neige_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_neige_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 416
-- Name: st_ref_neige_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_neige_id_tri_seq OWNED BY st_ref_neige.id_tri;


--
-- TOC entry 394 (class 1259 OID 220102046)
-- Name: st_ref_periode; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_periode (
    "codePeriode" text NOT NULL,
    "libPeriode" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_periode OWNER TO postgres;

--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 394
-- Name: TABLE st_ref_periode; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_periode IS 'Table qui référence les périodes optimales de végétation (liste de début et fin de chaque saison)';


--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 394
-- Name: COLUMN st_ref_periode."codePeriode"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_periode."codePeriode" IS 'code de la période';


--
-- TOC entry 3009 (class 0 OID 0)
-- Dependencies: 394
-- Name: COLUMN st_ref_periode."libPeriode"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_periode."libPeriode" IS 'libellé de la période';


--
-- TOC entry 393 (class 1259 OID 220102044)
-- Name: st_ref_periode_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_periode_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_periode_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 393
-- Name: st_ref_periode_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_periode_id_tri_seq OWNED BY st_ref_periode.id_tri;


--
-- TOC entry 386 (class 1259 OID 220101972)
-- Name: st_ref_pvf; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_pvf (
    "idRattachementPVF" oid NOT NULL,
    "codeReferentiel" text,
    "versionReferentiel" text,
    "identifiantSyntaxonRetenu" text,
    "rangSyntaxonRetenu" text,
    "nomSyntaxonRetenu" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_pvf OWNER TO postgres;

--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 386
-- Name: TABLE st_ref_pvf; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_pvf IS 'Typologie du PVF (PVF1 et PVF2)';


--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 386
-- Name: COLUMN st_ref_pvf."idRattachementPVF"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."idRattachementPVF" IS 'code du syntaxon dans l''un des référentiels pvf (1 ou 2)';


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 386
-- Name: COLUMN st_ref_pvf."codeReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."codeReferentiel" IS 'code du référentiel (ici PVF)';


--
-- TOC entry 3015 (class 0 OID 0)
-- Dependencies: 386
-- Name: COLUMN st_ref_pvf."versionReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."versionReferentiel" IS 'version du référentiel';


--
-- TOC entry 3016 (class 0 OID 0)
-- Dependencies: 386
-- Name: COLUMN st_ref_pvf."identifiantSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."identifiantSyntaxonRetenu" IS 'identifiant du syntaxon retenu dans le référentiel choisi (CD_SYNTAXON dans le PVF)';


--
-- TOC entry 3017 (class 0 OID 0)
-- Dependencies: 386
-- Name: COLUMN st_ref_pvf."rangSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."rangSyntaxonRetenu" IS 'rang du syntaxon retenu dans le référentiel choisi (niveau dans le PVF)';


--
-- TOC entry 3018 (class 0 OID 0)
-- Dependencies: 386
-- Name: COLUMN st_ref_pvf."nomSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."nomSyntaxonRetenu" IS 'nom du syntaxon retenu dans le référentiel choisi (LB_SYNTAXON dans le PVF)';


--
-- TOC entry 385 (class 1259 OID 220101970)
-- Name: st_ref_pvf_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_pvf_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_pvf_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 385
-- Name: st_ref_pvf_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_pvf_id_tri_seq OWNED BY st_ref_pvf.id_tri;


--
-- TOC entry 366 (class 1259 OID 220101840)
-- Name: st_ref_rang_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_rang_seriegeoserie (
    "codeRangSerieGeoserie" text NOT NULL,
    "libRangSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_rang_seriegeoserie OWNER TO postgres;

--
-- TOC entry 3021 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE st_ref_rang_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rang_seriegeoserie IS 'Référentiel des rangs de série et de géoséries (ce référentiel n''est pas encore normé par la Société phytosociologique de France- SPF)';


--
-- TOC entry 3022 (class 0 OID 0)
-- Dependencies: 366
-- Name: COLUMN st_ref_rang_seriegeoserie."codeRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_seriegeoserie."codeRangSerieGeoserie" IS 'code du grand de série et de géoséries';


--
-- TOC entry 3023 (class 0 OID 0)
-- Dependencies: 366
-- Name: COLUMN st_ref_rang_seriegeoserie."libRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_seriegeoserie."libRangSerieGeoserie" IS 'libelle du rang de série et de géoséries';


--
-- TOC entry 365 (class 1259 OID 220101838)
-- Name: st_ref_rang_seriegeoserie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_rang_seriegeoserie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_rang_seriegeoserie_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3025 (class 0 OID 0)
-- Dependencies: 365
-- Name: st_ref_rang_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rang_seriegeoserie_id_tri_seq OWNED BY st_ref_rang_seriegeoserie.id_tri;


--
-- TOC entry 364 (class 1259 OID 220101829)
-- Name: st_ref_rang_syntaxon; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_rang_syntaxon (
    "codeRangSyntaxon" text NOT NULL,
    "libRangSyntaxon" text,
    "niveauRangSyntaxon" text,
    "suffixeRangSyntaxon" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_rang_syntaxon OWNER TO postgres;

--
-- TOC entry 3026 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE st_ref_rang_syntaxon; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rang_syntaxon IS 'Référentiel des rangs de syntaxons';


--
-- TOC entry 3027 (class 0 OID 0)
-- Dependencies: 364
-- Name: COLUMN st_ref_rang_syntaxon."codeRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."codeRangSyntaxon" IS 'code du rang de syntaxon';


--
-- TOC entry 3028 (class 0 OID 0)
-- Dependencies: 364
-- Name: COLUMN st_ref_rang_syntaxon."libRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."libRangSyntaxon" IS 'libelle du rang de syntaxon';


--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 364
-- Name: COLUMN st_ref_rang_syntaxon."niveauRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."niveauRangSyntaxon" IS 'niveau du rang de syntaxon';


--
-- TOC entry 3030 (class 0 OID 0)
-- Dependencies: 364
-- Name: COLUMN st_ref_rang_syntaxon."suffixeRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."suffixeRangSyntaxon" IS 'suffixe correspondant au rang du syntaxon';


--
-- TOC entry 363 (class 1259 OID 220101827)
-- Name: st_ref_rang_syntaxon_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_rang_syntaxon_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_rang_syntaxon_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 363
-- Name: st_ref_rang_syntaxon_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rang_syntaxon_id_tri_seq OWNED BY st_ref_rang_syntaxon.id_tri;


--
-- TOC entry 398 (class 1259 OID 220102068)
-- Name: st_ref_reaction; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_reaction (
    "indReaction" text NOT NULL,
    "libReaction" text,
    "libLongReaction" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_reaction OWNER TO postgres;

--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 398
-- Name: TABLE st_ref_reaction; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_reaction IS 'Référentiel de l''indice de pH selon Landolt (réaction)';


--
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 398
-- Name: COLUMN st_ref_reaction."indReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."indReaction" IS 'Indice de la réaction selon Landolt';


--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 398
-- Name: COLUMN st_ref_reaction."libReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."libReaction" IS 'libellé court dela réaction selon Landolt';


--
-- TOC entry 3036 (class 0 OID 0)
-- Dependencies: 398
-- Name: COLUMN st_ref_reaction."libLongReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."libLongReaction" IS 'libellé long de l''Humidité selon Landolt';


--
-- TOC entry 397 (class 1259 OID 220102066)
-- Name: st_ref_reaction_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_reaction_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_reaction_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3038 (class 0 OID 0)
-- Dependencies: 397
-- Name: st_ref_reaction_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_reaction_id_tri_seq OWNED BY st_ref_reaction.id_tri;


--
-- TOC entry 422 (class 1259 OID 220102213)
-- Name: st_ref_rivasmartinez_ombroclimat; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_rivasmartinez_ombroclimat (
    "idOmbroclimat" text NOT NULL,
    "libOmbroclimat" text,
    "libLongOmbroclimat" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_rivasmartinez_ombroclimat OWNER TO postgres;

--
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 422
-- Name: TABLE st_ref_rivasmartinez_ombroclimat; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rivasmartinez_ombroclimat IS 'Référentiel des ombro-climats d''après Rivas-Martinez';


--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 422
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."idOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."idOmbroclimat" IS 'code de l''ombroclimat d''après Rivas-Martinez';


--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 422
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."libOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."libOmbroclimat" IS 'libellé court de l''ombroclimat selon Rivas Martinez';


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 422
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."libLongOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."libLongOmbroclimat" IS 'libellé long de l''ombroclimat selon Rivas-Martinez';


--
-- TOC entry 428 (class 1259 OID 220104532)
-- Name: st_ref_rivasmartinez_ombroclimat_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_rivasmartinez_ombroclimat_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_rivasmartinez_ombroclimat_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 428
-- Name: st_ref_rivasmartinez_ombroclimat_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rivasmartinez_ombroclimat_id_tri_seq OWNED BY st_ref_rivasmartinez_ombroclimat.id_tri;


--
-- TOC entry 421 (class 1259 OID 220102202)
-- Name: st_ref_salinite; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_salinite (
    "indSali" text NOT NULL,
    "libSali" text,
    "libLongSali" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_salinite OWNER TO postgres;

--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 421
-- Name: TABLE st_ref_salinite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_salinite IS 'Référentiel de l''affinité à la salinité selon Ellenberg et Julve';


--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 421
-- Name: COLUMN st_ref_salinite."indSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."indSali" IS 'Indice de l''affinité à la salinite selon Ellenberg et Julve';


--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 421
-- Name: COLUMN st_ref_salinite."libSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."libSali" IS 'libellé court de l''affinité à la salinite selon Ellenberg et Julve';


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 421
-- Name: COLUMN st_ref_salinite."libLongSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."libLongSali" IS 'libellé long de l''affinité à la salinite selon Ellenberg et Julve';


--
-- TOC entry 420 (class 1259 OID 220102200)
-- Name: st_ref_salinite_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_salinite_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_salinite_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 420
-- Name: st_ref_salinite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_salinite_id_tri_seq OWNED BY st_ref_salinite.id_tri;


--
-- TOC entry 379 (class 1259 OID 220101932)
-- Name: st_ref_statut_chorologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_statut_chorologie (
    "idStatutChorologie" text NOT NULL,
    "libStatutChrologie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_statut_chorologie OWNER TO postgres;

--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 379
-- Name: TABLE st_ref_statut_chorologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_statut_chorologie IS 'Référentiel qui contient les valeurs que peuvent prendre les statuts de chorologie';


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN st_ref_statut_chorologie."idStatutChorologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_statut_chorologie."idStatutChorologie" IS 'Code du statut de chorologie';


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN st_ref_statut_chorologie."libStatutChrologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_statut_chorologie."libStatutChrologie" IS 'libellé du statut de chorologie';


--
-- TOC entry 378 (class 1259 OID 220101930)
-- Name: st_ref_statut_chorologie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_statut_chorologie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_statut_chorologie_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 378
-- Name: st_ref_statut_chorologie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_statut_chorologie_id_tri_seq OWNED BY st_ref_statut_chorologie.id_tri;


--
-- TOC entry 413 (class 1259 OID 220102158)
-- Name: st_ref_temperature; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_temperature (
    "indTemp" text NOT NULL,
    "libTemp" text,
    "libLongTemp" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_temperature OWNER TO postgres;

--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 413
-- Name: TABLE st_ref_temperature; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_temperature IS 'Référentiel des indices de température selon Landolt';


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN st_ref_temperature."indTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."indTemp" IS 'Indice de la température selon Landolt';


--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN st_ref_temperature."libTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."libTemp" IS 'libellé court de la température selon Landolt';


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN st_ref_temperature."libLongTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."libLongTemp" IS 'libellé long de température selon Landolt';


--
-- TOC entry 412 (class 1259 OID 220102156)
-- Name: st_ref_temperature_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_temperature_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_temperature_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 412
-- Name: st_ref_temperature_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_temperature_id_tri_seq OWNED BY st_ref_temperature.id_tri;


--
-- TOC entry 372 (class 1259 OID 220101878)
-- Name: st_ref_tete_serie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_tete_serie (
    "codeTeteSerie" text NOT NULL,
    "libTeteSerie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_tete_serie OWNER TO postgres;

--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 372
-- Name: TABLE st_ref_tete_serie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_tete_serie IS 'Référentiel des stades de la série (ou géosérie)';


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_ref_tete_serie."codeTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_tete_serie."codeTeteSerie" IS 'Indique si ce stade représente la tête de série ou non';


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_ref_tete_serie."libTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_tete_serie."libTeteSerie" IS 'Décrit le type de stade (tête de série ou stade intermediaire)';


--
-- TOC entry 371 (class 1259 OID 220101876)
-- Name: st_ref_tete_serie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_tete_serie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_tete_serie_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 371
-- Name: st_ref_tete_serie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_tete_serie_id_tri_seq OWNED BY st_ref_tete_serie.id_tri;


--
-- TOC entry 400 (class 1259 OID 220102079)
-- Name: st_ref_trophie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_trophie (
    "indTrophie" text NOT NULL,
    "libTrophie" text,
    "libLongTrophie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_trophie OWNER TO postgres;

--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 400
-- Name: TABLE st_ref_trophie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_trophie IS 'Référentiel de la trophie selon Landolt';


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 400
-- Name: COLUMN st_ref_trophie."indTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."indTrophie" IS 'Indice de la trophie selon Landolt';


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 400
-- Name: COLUMN st_ref_trophie."libTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."libTrophie" IS 'libellé court dela trophie selon Landolt';


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 400
-- Name: COLUMN st_ref_trophie."libLongTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."libLongTrophie" IS 'libellé long de trophie selon Landolt';


--
-- TOC entry 399 (class 1259 OID 220102077)
-- Name: st_ref_trophie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_trophie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_trophie_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 399
-- Name: st_ref_trophie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_trophie_id_tri_seq OWNED BY st_ref_trophie.id_tri;


--
-- TOC entry 368 (class 1259 OID 220101851)
-- Name: st_ref_type_facies; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_facies (
    "codeFacies" text NOT NULL,
    "libFacies" text,
    "libLongFacies" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_type_facies OWNER TO postgres;

--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 368
-- Name: TABLE st_ref_type_facies; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_facies IS 'Référentiel des types de faciès';


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 368
-- Name: COLUMN st_ref_type_facies."codeFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."codeFacies" IS 'code du type de faciès';


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 368
-- Name: COLUMN st_ref_type_facies."libFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."libFacies" IS 'libelle du type de faciès';


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 368
-- Name: COLUMN st_ref_type_facies."libLongFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."libLongFacies" IS 'libelle long du type de faciès';


--
-- TOC entry 367 (class 1259 OID 220101849)
-- Name: st_ref_type_facies_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_facies_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_type_facies_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 367
-- Name: st_ref_type_facies_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_facies_id_tri_seq OWNED BY st_ref_type_facies.id_tri;


--
-- TOC entry 411 (class 1259 OID 220102147)
-- Name: st_ref_type_physionomique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_physionomique (
    "idTypePhysio" text NOT NULL,
    "libTypePhysio" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_type_physionomique OWNER TO postgres;

--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 411
-- Name: TABLE st_ref_type_physionomique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_physionomique IS 'Référentiel des types physionomiques';


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN st_ref_type_physionomique."idTypePhysio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_physionomique."idTypePhysio" IS 'identifiant du type physionomique';


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN st_ref_type_physionomique."libTypePhysio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_physionomique."libTypePhysio" IS 'libellé du type physionomique';


--
-- TOC entry 410 (class 1259 OID 220102145)
-- Name: st_ref_type_physionomique_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_physionomique_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_type_physionomique_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 410
-- Name: st_ref_type_physionomique_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_physionomique_id_tri_seq OWNED BY st_ref_type_physionomique.id_tri;


--
-- TOC entry 360 (class 1259 OID 220101807)
-- Name: st_ref_type_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_seriegeoserie (
    "codeTypeSerieGeoserie" text NOT NULL,
    "libTypeSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_type_seriegeoserie OWNER TO postgres;

--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE st_ref_type_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_seriegeoserie IS 'Référentiel des types de série et de géoséries';


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 360
-- Name: COLUMN st_ref_type_seriegeoserie."codeTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie."codeTypeSerieGeoserie" IS 'code du type de série et de géoséries';


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 360
-- Name: COLUMN st_ref_type_seriegeoserie."libTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie."libTypeSerieGeoserie" IS 'libelle du type de série et de géoséries';


--
-- TOC entry 359 (class 1259 OID 220101805)
-- Name: st_ref_type_seriegeoserie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_seriegeoserie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_type_seriegeoserie_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 359
-- Name: st_ref_type_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_seriegeoserie_id_tri_seq OWNED BY st_ref_type_seriegeoserie.id_tri;


--
-- TOC entry 404 (class 1259 OID 220102101)
-- Name: st_ref_type_synonymie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_synonymie (
    "idTypeSyn" text NOT NULL,
    "libTypSyn" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_type_synonymie OWNER TO postgres;

--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 404
-- Name: TABLE st_ref_type_synonymie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_synonymie IS 'Référentiel des types de synonymie';


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 404
-- Name: COLUMN st_ref_type_synonymie."idTypeSyn"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_synonymie."idTypeSyn" IS 'identifiant du type de synonymie';


--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 404
-- Name: COLUMN st_ref_type_synonymie."libTypSyn"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_synonymie."libTypSyn" IS 'libellé du type de synonymie';


--
-- TOC entry 403 (class 1259 OID 220102099)
-- Name: st_ref_type_synonymie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_synonymie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_ref_type_synonymie_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 403
-- Name: st_ref_type_synonymie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_synonymie_id_tri_seq OWNED BY st_ref_type_synonymie.id_tri;


--
-- TOC entry 2721 (class 2604 OID 220103591)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY liste_geo ALTER COLUMN id_tri SET DEFAULT nextval('liste_geo_id_tri_seq'::regclass);


--
-- TOC entry 2728 (class 2604 OID 220101916)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_action_suivi ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_action_suivi_id_tri_seq'::regclass);


--
-- TOC entry 2723 (class 2604 OID 220101821)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_categorie_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_categorie_seriegeoserie_id_tri_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 220102194)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_continentalite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_continentalite_id_tri_seq'::regclass);


--
-- TOC entry 2740 (class 2604 OID 220102139)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_critique ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_critique_id_tri_seq'::regclass);


--
-- TOC entry 2733 (class 2604 OID 220102030)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_etage_bioclim ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_etage_bioclim_id_tri_seq'::regclass);


--
-- TOC entry 2749 (class 2604 OID 220481416)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_etage_veg ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_etage_veg_id_tri_seq'::regclass);


--
-- TOC entry 2748 (class 2604 OID 220102235)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_eunis ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_eunis_id_tri_seq'::regclass);


--
-- TOC entry 2738 (class 2604 OID 220102093)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_exposition ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_exposition_id_tri_seq'::regclass);


--
-- TOC entry 2730 (class 2604 OID 220101960)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_geomorpho ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_geomorpho_id_tri_seq'::regclass);


--
-- TOC entry 2732 (class 2604 OID 220101992)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_hic ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_hic_id_tri_seq'::regclass);


--
-- TOC entry 2735 (class 2604 OID 220102060)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_humidite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_humidite_id_tri_seq'::regclass);


--
-- TOC entry 2743 (class 2604 OID 220102172)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_lumiere ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_lumiere_id_tri_seq'::regclass);


--
-- TOC entry 2744 (class 2604 OID 220102183)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_neige ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_neige_id_tri_seq'::regclass);


--
-- TOC entry 2734 (class 2604 OID 220102049)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_periode ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_periode_id_tri_seq'::regclass);


--
-- TOC entry 2731 (class 2604 OID 220101975)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_pvf ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_pvf_id_tri_seq'::regclass);


--
-- TOC entry 2725 (class 2604 OID 220101843)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rang_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rang_seriegeoserie_id_tri_seq'::regclass);


--
-- TOC entry 2724 (class 2604 OID 220101832)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rang_syntaxon ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rang_syntaxon_id_tri_seq'::regclass);


--
-- TOC entry 2736 (class 2604 OID 220102071)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_reaction ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_reaction_id_tri_seq'::regclass);


--
-- TOC entry 2747 (class 2604 OID 220104534)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rivasmartinez_ombroclimat ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rivasmartinez_ombroclimat_id_tri_seq'::regclass);


--
-- TOC entry 2746 (class 2604 OID 220102205)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_salinite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_salinite_id_tri_seq'::regclass);


--
-- TOC entry 2729 (class 2604 OID 220101935)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_statut_chorologie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_statut_chorologie_id_tri_seq'::regclass);


--
-- TOC entry 2742 (class 2604 OID 220102161)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_temperature ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_temperature_id_tri_seq'::regclass);


--
-- TOC entry 2727 (class 2604 OID 220101881)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_tete_serie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_tete_serie_id_tri_seq'::regclass);


--
-- TOC entry 2737 (class 2604 OID 220102082)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_trophie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_trophie_id_tri_seq'::regclass);


--
-- TOC entry 2726 (class 2604 OID 220101854)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_facies ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_facies_id_tri_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 220102150)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_physionomique ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_physionomique_id_tri_seq'::regclass);


--
-- TOC entry 2722 (class 2604 OID 220101810)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_seriegeoserie_id_tri_seq'::regclass);


--
-- TOC entry 2739 (class 2604 OID 220102104)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_synonymie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_synonymie_id_tri_seq'::regclass);


--
-- TOC entry 2751 (class 2606 OID 220101779)
-- Name: PK_liste_geo; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY liste_geo
    ADD CONSTRAINT "PK_liste_geo" PRIMARY KEY (id_territoire);


--
-- TOC entry 2754 (class 2606 OID 220101788)
-- Name: PK_referentiel; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY referentiel_taxo
    ADD CONSTRAINT "PK_referentiel" PRIMARY KEY (id_rattachement_referentiel);


--
-- TOC entry 2768 (class 2606 OID 220101921)
-- Name: codeActionSuivi_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_action_suivi
    ADD CONSTRAINT "codeActionSuivi_pkey" PRIMARY KEY ("codeActionSuivi");


--
-- TOC entry 2758 (class 2606 OID 220101826)
-- Name: codeCategorieSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_categorie_seriegeoserie
    ADD CONSTRAINT "codeCategorieSerieGeoserie_pkey" PRIMARY KEY ("codeCategorieSerieGeoserie");


--
-- TOC entry 2813 (class 2606 OID 220102240)
-- Name: codeEUNIS_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_eunis
    ADD CONSTRAINT "codeEUNIS_pkey" PRIMARY KEY ("codeEUNIS");


--
-- TOC entry 2777 (class 2606 OID 220102035)
-- Name: codeEtageBioclim_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_etage_bioclim
    ADD CONSTRAINT "codeEtageBioclim_pkey" PRIMARY KEY ("codeEtageBioclim");


--
-- TOC entry 2815 (class 2606 OID 220481421)
-- Name: codeEtageVeg_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_etage_veg
    ADD CONSTRAINT "codeEtageVeg_pkey" PRIMARY KEY ("codeEtageVeg");


--
-- TOC entry 2764 (class 2606 OID 220101859)
-- Name: codeFacis_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_facies
    ADD CONSTRAINT "codeFacis_pkey" PRIMARY KEY ("codeFacies");


--
-- TOC entry 2775 (class 2606 OID 220101997)
-- Name: codeHIC_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_hic
    ADD CONSTRAINT "codeHIC_pkey" PRIMARY KEY ("codeHIC");


--
-- TOC entry 2762 (class 2606 OID 220101848)
-- Name: codeRangSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rang_seriegeoserie
    ADD CONSTRAINT "codeRangSerieGeoserie_pkey" PRIMARY KEY ("codeRangSerieGeoserie");


--
-- TOC entry 2760 (class 2606 OID 220101837)
-- Name: codeRangSyntaxon_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rang_syntaxon
    ADD CONSTRAINT "codeRangSyntaxon_pkey" PRIMARY KEY ("codeRangSyntaxon");


--
-- TOC entry 2766 (class 2606 OID 220101886)
-- Name: codeTeteSerie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_tete_serie
    ADD CONSTRAINT "codeTeteSerie_pkey" PRIMARY KEY ("codeTeteSerie");


--
-- TOC entry 2756 (class 2606 OID 220101815)
-- Name: codeTypeSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_seriegeoserie
    ADD CONSTRAINT "codeTypeSerieGeoserie_pkey" PRIMARY KEY ("codeTypeSerieGeoserie");


--
-- TOC entry 2792 (class 2606 OID 220102144)
-- Name: idCritique_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_critique
    ADD CONSTRAINT "idCritique_pkey" PRIMARY KEY ("idCritique");


--
-- TOC entry 2788 (class 2606 OID 220102098)
-- Name: idExposition_fkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_exposition
    ADD CONSTRAINT "idExposition_fkey" PRIMARY KEY ("idExposition");


--
-- TOC entry 2810 (class 2606 OID 220102221)
-- Name: idOmbroClimat_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rivasmartinez_ombroclimat
    ADD CONSTRAINT "idOmbroClimat_pkey" PRIMARY KEY ("idOmbroclimat");


--
-- TOC entry 2773 (class 2606 OID 220101980)
-- Name: idRattachementPVF; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_pvf
    ADD CONSTRAINT "idRattachementPVF" PRIMARY KEY ("idRattachementPVF");


--
-- TOC entry 2770 (class 2606 OID 220101940)
-- Name: idStatutchorologie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_statut_chorologie
    ADD CONSTRAINT "idStatutchorologie_pkey" PRIMARY KEY ("idStatutChorologie");


--
-- TOC entry 2795 (class 2606 OID 220102155)
-- Name: idTypePhysio_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_physionomique
    ADD CONSTRAINT "idTypePhysio_pkey" PRIMARY KEY ("idTypePhysio");


--
-- TOC entry 2790 (class 2606 OID 220102109)
-- Name: idTypeSyn; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_synonymie
    ADD CONSTRAINT "idTypeSyn" PRIMARY KEY ("idTypeSyn");


--
-- TOC entry 2804 (class 2606 OID 220102199)
-- Name: indCont_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_continentalite
    ADD CONSTRAINT "indCont_pkey" PRIMARY KEY ("indCont");


--
-- TOC entry 2781 (class 2606 OID 220102065)
-- Name: indHum_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_humidite
    ADD CONSTRAINT "indHum_pkey" PRIMARY KEY ("indHum");


--
-- TOC entry 2800 (class 2606 OID 220102177)
-- Name: indLum_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_lumiere
    ADD CONSTRAINT "indLum_pkey" PRIMARY KEY ("indLum");


--
-- TOC entry 2783 (class 2606 OID 220102076)
-- Name: indReac_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_reaction
    ADD CONSTRAINT "indReac_pkey" PRIMARY KEY ("indReaction");


--
-- TOC entry 2807 (class 2606 OID 220102210)
-- Name: indSali_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_salinite
    ADD CONSTRAINT "indSali_pkey" PRIMARY KEY ("indSali");


--
-- TOC entry 2797 (class 2606 OID 220102166)
-- Name: indTemperaturee_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_temperature
    ADD CONSTRAINT "indTemperaturee_pkey" PRIMARY KEY ("indTemp");


--
-- TOC entry 2785 (class 2606 OID 220102087)
-- Name: indTrophie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_trophie
    ADD CONSTRAINT "indTrophie_pkey" PRIMARY KEY ("indTrophie");


--
-- TOC entry 2779 (class 2606 OID 220102054)
-- Name: libPeriode; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_periode
    ADD CONSTRAINT "libPeriode" PRIMARY KEY ("codePeriode");


--
-- TOC entry 2802 (class 2606 OID 220102188)
-- Name: neige_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_neige
    ADD CONSTRAINT neige_pkey PRIMARY KEY ("idNeige");


--
-- TOC entry 2752 (class 1259 OID 220102447)
-- Name: id_territoire_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX id_territoire_uniq ON liste_geo USING btree (id_territoire);


--
-- TOC entry 2793 (class 1259 OID 220102382)
-- Name: idcritique_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idcritique_uniq ON st_ref_critique USING btree ("idCritique");


--
-- TOC entry 2771 (class 1259 OID 220102483)
-- Name: idgeomorphologie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idgeomorphologie_uniq ON st_ref_geomorpho USING btree ("idGeomorphologie");


--
-- TOC entry 2811 (class 1259 OID 220102426)
-- Name: idombroclimat_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idombroclimat_uniq ON st_ref_rivasmartinez_ombroclimat USING btree ("idOmbroclimat");


--
-- TOC entry 2805 (class 1259 OID 220102414)
-- Name: indcont_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indcont_uniq ON st_ref_continentalite USING btree ("indCont");


--
-- TOC entry 2808 (class 1259 OID 220102420)
-- Name: indsali_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indsali_uniq ON st_ref_salinite USING btree ("indSali");


--
-- TOC entry 2798 (class 1259 OID 220102398)
-- Name: indtemp_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indtemp_uniq ON st_ref_temperature USING btree ("indTemp");


--
-- TOC entry 2786 (class 1259 OID 220102371)
-- Name: indtrophie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indtrophie_uniq ON st_ref_trophie USING btree ("indTrophie");


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 355
-- Name: liste_geo; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE liste_geo FROM PUBLIC;
REVOKE ALL ON TABLE liste_geo FROM postgres;
GRANT ALL ON TABLE liste_geo TO postgres;
GRANT ALL ON TABLE liste_geo TO pg_user;


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 356
-- Name: referentiel_taxo; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE referentiel_taxo FROM PUBLIC;
REVOKE ALL ON TABLE referentiel_taxo FROM postgres;
GRANT ALL ON TABLE referentiel_taxo TO postgres;
GRANT ALL ON TABLE referentiel_taxo TO pg_user;


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 377
-- Name: st_ref_action_suivi; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_action_suivi FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_action_suivi FROM postgres;
GRANT ALL ON TABLE st_ref_action_suivi TO postgres;
GRANT ALL ON TABLE st_ref_action_suivi TO pg_user;


--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 362
-- Name: st_ref_categorie_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_categorie_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_categorie_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_categorie_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_categorie_seriegeoserie TO pg_user;


--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 419
-- Name: st_ref_continentalite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_continentalite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_continentalite FROM postgres;
GRANT ALL ON TABLE st_ref_continentalite TO postgres;
GRANT ALL ON TABLE st_ref_continentalite TO pg_user;


--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 409
-- Name: st_ref_critique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_critique FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_critique FROM postgres;
GRANT ALL ON TABLE st_ref_critique TO postgres;
GRANT ALL ON TABLE st_ref_critique TO pg_user;


--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 392
-- Name: st_ref_etage_bioclim; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_etage_bioclim FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_etage_bioclim FROM postgres;
GRANT ALL ON TABLE st_ref_etage_bioclim TO postgres;
GRANT ALL ON TABLE st_ref_etage_bioclim TO pg_user;


--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 424
-- Name: st_ref_eunis; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_eunis FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_eunis FROM postgres;
GRANT ALL ON TABLE st_ref_eunis TO postgres;
GRANT ALL ON TABLE st_ref_eunis TO pg_user;


--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 402
-- Name: st_ref_exposition; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_exposition FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_exposition FROM postgres;
GRANT ALL ON TABLE st_ref_exposition TO postgres;
GRANT ALL ON TABLE st_ref_exposition TO pg_user;


--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 383
-- Name: st_ref_geomorpho; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_geomorpho FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_geomorpho FROM postgres;
GRANT ALL ON TABLE st_ref_geomorpho TO postgres;
GRANT ALL ON TABLE st_ref_geomorpho TO pg_user;


--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 388
-- Name: st_ref_hic; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_hic FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_hic FROM postgres;
GRANT ALL ON TABLE st_ref_hic TO postgres;
GRANT ALL ON TABLE st_ref_hic TO pg_user;


--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 396
-- Name: st_ref_humidite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_humidite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_humidite FROM postgres;
GRANT ALL ON TABLE st_ref_humidite TO postgres;
GRANT ALL ON TABLE st_ref_humidite TO pg_user;


--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 415
-- Name: st_ref_lumiere; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_lumiere FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_lumiere FROM postgres;
GRANT ALL ON TABLE st_ref_lumiere TO postgres;
GRANT ALL ON TABLE st_ref_lumiere TO pg_user;


--
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 417
-- Name: st_ref_neige; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_neige FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_neige FROM postgres;
GRANT ALL ON TABLE st_ref_neige TO postgres;
GRANT ALL ON TABLE st_ref_neige TO pg_user;


--
-- TOC entry 3010 (class 0 OID 0)
-- Dependencies: 394
-- Name: st_ref_periode; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_periode FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_periode FROM postgres;
GRANT ALL ON TABLE st_ref_periode TO postgres;
GRANT ALL ON TABLE st_ref_periode TO pg_user;


--
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 386
-- Name: st_ref_pvf; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_pvf FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_pvf FROM postgres;
GRANT ALL ON TABLE st_ref_pvf TO postgres;
GRANT ALL ON TABLE st_ref_pvf TO pg_user;


--
-- TOC entry 3024 (class 0 OID 0)
-- Dependencies: 366
-- Name: st_ref_rang_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rang_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rang_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_rang_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_rang_seriegeoserie TO pg_user;


--
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 364
-- Name: st_ref_rang_syntaxon; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rang_syntaxon FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rang_syntaxon FROM postgres;
GRANT ALL ON TABLE st_ref_rang_syntaxon TO postgres;
GRANT ALL ON TABLE st_ref_rang_syntaxon TO pg_user;


--
-- TOC entry 3037 (class 0 OID 0)
-- Dependencies: 398
-- Name: st_ref_reaction; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_reaction FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_reaction FROM postgres;
GRANT ALL ON TABLE st_ref_reaction TO postgres;
GRANT ALL ON TABLE st_ref_reaction TO pg_user;


--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 422
-- Name: st_ref_rivasmartinez_ombroclimat; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rivasmartinez_ombroclimat FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rivasmartinez_ombroclimat FROM postgres;
GRANT ALL ON TABLE st_ref_rivasmartinez_ombroclimat TO postgres;
GRANT ALL ON TABLE st_ref_rivasmartinez_ombroclimat TO pg_user;


--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 421
-- Name: st_ref_salinite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_salinite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_salinite FROM postgres;
GRANT ALL ON TABLE st_ref_salinite TO postgres;
GRANT ALL ON TABLE st_ref_salinite TO pg_user;


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 379
-- Name: st_ref_statut_chorologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_statut_chorologie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_statut_chorologie FROM postgres;
GRANT ALL ON TABLE st_ref_statut_chorologie TO postgres;
GRANT ALL ON TABLE st_ref_statut_chorologie TO pg_user;


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 413
-- Name: st_ref_temperature; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_temperature FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_temperature FROM postgres;
GRANT ALL ON TABLE st_ref_temperature TO postgres;
GRANT ALL ON TABLE st_ref_temperature TO pg_user;


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 372
-- Name: st_ref_tete_serie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_tete_serie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_tete_serie FROM postgres;
GRANT ALL ON TABLE st_ref_tete_serie TO postgres;
GRANT ALL ON TABLE st_ref_tete_serie TO pg_user;


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 400
-- Name: st_ref_trophie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_trophie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_trophie FROM postgres;
GRANT ALL ON TABLE st_ref_trophie TO postgres;
GRANT ALL ON TABLE st_ref_trophie TO pg_user;


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 368
-- Name: st_ref_type_facies; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_facies FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_facies FROM postgres;
GRANT ALL ON TABLE st_ref_type_facies TO postgres;
GRANT ALL ON TABLE st_ref_type_facies TO pg_user;


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 411
-- Name: st_ref_type_physionomique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_physionomique FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_physionomique FROM postgres;
GRANT ALL ON TABLE st_ref_type_physionomique TO postgres;
GRANT ALL ON TABLE st_ref_type_physionomique TO pg_user;


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 360
-- Name: st_ref_type_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_type_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_type_seriegeoserie TO pg_user;


--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 404
-- Name: st_ref_type_synonymie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_synonymie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_synonymie FROM postgres;
GRANT ALL ON TABLE st_ref_type_synonymie TO postgres;
GRANT ALL ON TABLE st_ref_type_synonymie TO pg_user;


-- Completed on 2016-07-19 14:50:14

--
-- PostgreSQL database dump complete
--

