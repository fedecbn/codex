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
-- Name: referentiels; Type: SCHEMA; Schema: -; Owner: pg_user
--

CREATE SCHEMA referentiels;


ALTER SCHEMA referentiels OWNER TO pg_user;

--
-- Name: SCHEMA referentiels; Type: COMMENT; Schema: -; Owner: pg_user
--

COMMENT ON SCHEMA referentiels IS 'Lettre du Systeme Information et Geomatique';


SET search_path = referentiels, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ajustmt; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE ajustmt (
    id_ajustmt integer NOT NULL,
    cd_ajustmt character varying,
    lib_ajustmt character varying
);


ALTER TABLE referentiels.ajustmt OWNER TO pg_user;

--
-- Name: TABLE ajustmt; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE ajustmt IS 'Eval - Ajustements';


--
-- Name: COLUMN ajustmt.id_ajustmt; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN ajustmt.id_ajustmt IS 'PK';


--
-- Name: ajustmt_id_ajustmt_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE ajustmt_id_ajustmt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.ajustmt_id_ajustmt_seq OWNER TO pg_user;

--
-- Name: ajustmt_id_ajustmt_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE ajustmt_id_ajustmt_seq OWNED BY ajustmt.id_ajustmt;


--
-- Name: aoo; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE aoo (
    id_aoo integer NOT NULL,
    cd_aoo character varying,
    lib_aoo character varying
);


ALTER TABLE referentiels.aoo OWNER TO pg_user;

--
-- Name: TABLE aoo; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE aoo IS 'Zone d occupation';


--
-- Name: COLUMN aoo.id_aoo; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN aoo.id_aoo IS 'PK';


--
-- Name: aoo_id_aoo_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE aoo_id_aoo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.aoo_id_aoo_seq OWNER TO pg_user;

--
-- Name: aoo_id_aoo_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE aoo_id_aoo_seq OWNED BY aoo.id_aoo;


--
-- Name: avancement; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE avancement (
    id integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.avancement OWNER TO pg_user;

--
-- Name: cat_a; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE cat_a (
    id_cat_a integer NOT NULL,
    cd_cat_a character varying,
    lib_cat_a character varying
);


ALTER TABLE referentiels.cat_a OWNER TO pg_user;

--
-- Name: TABLE cat_a; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE cat_a IS 'Eval - Catégorie A,B,C,D,E';


--
-- Name: COLUMN cat_a.id_cat_a; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN cat_a.id_cat_a IS 'PK';


--
-- Name: cat_a_id_cat_a_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE cat_a_id_cat_a_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.cat_a_id_cat_a_seq OWNER TO pg_user;

--
-- Name: cat_a_id_cat_a_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE cat_a_id_cat_a_seq OWNED BY cat_a.id_cat_a;


--
-- Name: categorie; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE categorie (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);


ALTER TABLE referentiels.categorie OWNER TO pg_user;

--
-- Name: TABLE categorie; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE categorie IS 'Eval - Catégories';


--
-- Name: COLUMN categorie.id_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN categorie.id_cat IS 'PK';


--
-- Name: categorie_final; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE categorie_final (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);


ALTER TABLE referentiels.categorie_final OWNER TO pg_user;

--
-- Name: TABLE categorie_final; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE categorie_final IS 'Eval - Catégories';


--
-- Name: COLUMN categorie_final.id_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN categorie_final.id_cat IS 'PK';


--
-- Name: categorie_final_id_cat_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE categorie_final_id_cat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.categorie_final_id_cat_seq OWNER TO pg_user;

--
-- Name: categorie_final_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE categorie_final_id_cat_seq OWNED BY categorie_final.id_cat;


--
-- Name: categorie_id_cat_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE categorie_id_cat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.categorie_id_cat_seq OWNER TO pg_user;

--
-- Name: categorie_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE categorie_id_cat_seq OWNED BY categorie.id_cat;


--
-- Name: cbn; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE cbn (
    id_cbn smallint NOT NULL,
    cd_cbn character varying,
    lib_cbn character varying
);


ALTER TABLE referentiels.cbn OWNER TO pg_user;

--
-- Name: TABLE cbn; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE cbn IS 'CBN';


--
-- Name: COLUMN cbn.id_cbn; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN cbn.id_cbn IS 'PK';


--
-- Name: champs; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE champs (
    id integer NOT NULL,
    rubrique_champ character varying,
    nom_champ character varying,
    type character varying,
    description character varying,
    table_champ character varying,
    referentiel character varying,
    pos integer,
    description_longue character varying,
    export_display boolean DEFAULT true,
    nom_champ_synthese character varying,
    champ_interface character varying,
    modifiable boolean DEFAULT true,
    table_bd character varying
);


ALTER TABLE referentiels.champs OWNER TO postgres;

--
-- Name: champs_id_seq; Type: SEQUENCE; Schema: referentiels; Owner: postgres
--

CREATE SEQUENCE champs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.champs_id_seq OWNER TO postgres;

--
-- Name: champs_id_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE champs_id_seq OWNED BY champs.id;


--
-- Name: champs_ref; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE champs_ref (
    id integer NOT NULL,
    nom_ref character varying,
    cle character varying,
    valeur character varying,
    schema character varying,
    table_ref character varying,
    orderby character varying,
    rubrique_ref character varying
);


ALTER TABLE referentiels.champs_ref OWNER TO postgres;

--
-- Name: champs_ref_id_seq; Type: SEQUENCE; Schema: referentiels; Owner: postgres
--

CREATE SEQUENCE champs_ref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.champs_ref_id_seq OWNER TO postgres;

--
-- Name: champs_ref_id_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE champs_ref_id_seq OWNED BY champs_ref.id;


--
-- Name: chgt_cat; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE chgt_cat (
    id_chgt_cat integer NOT NULL,
    cd_chgt_cat character varying,
    lib_chgt_cat character varying
);


ALTER TABLE referentiels.chgt_cat OWNER TO pg_user;

--
-- Name: TABLE chgt_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE chgt_cat IS 'Eval - Changement de Catégorie';


--
-- Name: COLUMN chgt_cat.id_chgt_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN chgt_cat.id_chgt_cat IS 'PK';


--
-- Name: chgt_cat_id_chgt_cat_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE chgt_cat_id_chgt_cat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.chgt_cat_id_chgt_cat_seq OWNER TO pg_user;

--
-- Name: chgt_cat_id_chgt_cat_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE chgt_cat_id_chgt_cat_seq OWNED BY chgt_cat.id_chgt_cat;


--
-- Name: crit_a1; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_a1 (
    id_crit_a1 integer NOT NULL,
    cd_crit_a1 character varying,
    lib_crit_a1 character varying
);


ALTER TABLE referentiels.crit_a1 OWNER TO pg_user;

--
-- Name: TABLE crit_a1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_a1 IS 'Eval - A1';


--
-- Name: COLUMN crit_a1.id_crit_a1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_a1.id_crit_a1 IS 'PK';


--
-- Name: crit_a1_id_crit_a1_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE crit_a1_id_crit_a1_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.crit_a1_id_crit_a1_seq OWNER TO pg_user;

--
-- Name: crit_a1_id_crit_a1_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_a1_id_crit_a1_seq OWNED BY crit_a1.id_crit_a1;


--
-- Name: crit_a234; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_a234 (
    id_crit_a234 integer NOT NULL,
    cd_crit_a234 character varying,
    lib_crit_a234 character varying
);


ALTER TABLE referentiels.crit_a234 OWNER TO pg_user;

--
-- Name: TABLE crit_a234; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_a234 IS 'Eval - A2,A3,A4';


--
-- Name: COLUMN crit_a234.id_crit_a234; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_a234.id_crit_a234 IS 'PK';


--
-- Name: crit_a234_id_crit_a234_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE crit_a234_id_crit_a234_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.crit_a234_id_crit_a234_seq OWNER TO pg_user;

--
-- Name: crit_a234_id_crit_a234_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_a234_id_crit_a234_seq OWNED BY crit_a234.id_crit_a234;


--
-- Name: crit_c1; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_c1 (
    id_crit_c1 integer NOT NULL,
    cd_crit_c1 character varying,
    lib_crit_c1 character varying
);


ALTER TABLE referentiels.crit_c1 OWNER TO pg_user;

--
-- Name: TABLE crit_c1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_c1 IS 'Eval - C1';


--
-- Name: COLUMN crit_c1.id_crit_c1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_c1.id_crit_c1 IS 'PK';


--
-- Name: crit_c1_id_crit_c1_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE crit_c1_id_crit_c1_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.crit_c1_id_crit_c1_seq OWNER TO pg_user;

--
-- Name: crit_c1_id_crit_c1_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_c1_id_crit_c1_seq OWNED BY crit_c1.id_crit_c1;


--
-- Name: crit_c2; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_c2 (
    id_crit_c2 integer NOT NULL,
    cd_crit_c2 character varying,
    lib_crit_c2 character varying
);


ALTER TABLE referentiels.crit_c2 OWNER TO pg_user;

--
-- Name: TABLE crit_c2; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_c2 IS 'Eval - C2';


--
-- Name: COLUMN crit_c2.id_crit_c2; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_c2.id_crit_c2 IS 'PK';


--
-- Name: crit_c2_id_crit_c2_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE crit_c2_id_crit_c2_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.crit_c2_id_crit_c2_seq OWNER TO pg_user;

--
-- Name: crit_c2_id_crit_c2_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_c2_id_crit_c2_seq OWNED BY crit_c2.id_crit_c2;


--
-- Name: droit; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE droit (
    id integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.droit OWNER TO pg_user;

--
-- Name: etape; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE etape (
    id integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.etape OWNER TO pg_user;

--
-- Name: indigenat; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE indigenat (
    id_indi integer NOT NULL,
    cd_indi character varying,
    lib_indi character varying
);


ALTER TABLE referentiels.indigenat OWNER TO pg_user;

--
-- Name: TABLE indigenat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE indigenat IS 'Indigénat';


--
-- Name: COLUMN indigenat.id_indi; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN indigenat.id_indi IS 'PK';


--
-- Name: indigenat_id_indi_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE indigenat_id_indi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.indigenat_id_indi_seq OWNER TO pg_user;

--
-- Name: indigenat_id_indi_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE indigenat_id_indi_seq OWNED BY indigenat.id_indi;


--
-- Name: liste_rouge; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE liste_rouge (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);


ALTER TABLE referentiels.liste_rouge OWNER TO postgres;

--
-- Name: nbindiv; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE nbindiv (
    id_nbindiv integer NOT NULL,
    cd_nbindiv character varying,
    lib_nbindiv character varying
);


ALTER TABLE referentiels.nbindiv OWNER TO pg_user;

--
-- Name: TABLE nbindiv; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE nbindiv IS 'Effectifs';


--
-- Name: COLUMN nbindiv.id_nbindiv; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN nbindiv.id_nbindiv IS 'PK';


--
-- Name: nbindiv_id_nbindiv_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE nbindiv_id_nbindiv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.nbindiv_id_nbindiv_seq OWNER TO pg_user;

--
-- Name: nbindiv_id_nbindiv_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE nbindiv_id_nbindiv_seq OWNED BY nbindiv.id_nbindiv;


--
-- Name: nbloc; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE nbloc (
    id_nbloc integer NOT NULL,
    cd_nbloc character varying,
    lib_nbloc character varying
);


ALTER TABLE referentiels.nbloc OWNER TO pg_user;

--
-- Name: TABLE nbloc; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE nbloc IS 'Nb de localités';


--
-- Name: COLUMN nbloc.id_nbloc; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN nbloc.id_nbloc IS 'PK';


--
-- Name: nbloc_id_nbloc_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE nbloc_id_nbloc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.nbloc_id_nbloc_seq OWNER TO pg_user;

--
-- Name: nbloc_id_nbloc_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE nbloc_id_nbloc_seq OWNED BY nbloc.id_nbloc;


--
-- Name: raison_ajust; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE raison_ajust (
    id_raison_ajust integer NOT NULL,
    cd_raison_ajust character varying,
    lib_raison_ajust character varying
);


ALTER TABLE referentiels.raison_ajust OWNER TO pg_user;

--
-- Name: TABLE raison_ajust; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE raison_ajust IS 'Changement de Catégorie';


--
-- Name: COLUMN raison_ajust.id_raison_ajust; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN raison_ajust.id_raison_ajust IS 'PK';


--
-- Name: raison_ajust_id_raison_ajust_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE raison_ajust_id_raison_ajust_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.raison_ajust_id_raison_ajust_seq OWNER TO pg_user;

--
-- Name: raison_ajust_id_raison_ajust_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE raison_ajust_id_raison_ajust_seq OWNED BY raison_ajust.id_raison_ajust;


--
-- Name: rang; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE rang (
    id_rang integer NOT NULL,
    cd_rang character varying,
    lib_rang character varying
);


ALTER TABLE referentiels.rang OWNER TO pg_user;

--
-- Name: TABLE rang; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE rang IS 'Taxonomie - Rangs';


--
-- Name: COLUMN rang.id_rang; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN rang.id_rang IS 'PK';


--
-- Name: rang_id_rang_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE rang_id_rang_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.rang_id_rang_seq OWNER TO pg_user;

--
-- Name: rang_id_rang_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE rang_id_rang_seq OWNED BY rang.id_rang;


--
-- Name: reduc_eff; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE reduc_eff (
    id_reduc_eff integer NOT NULL,
    cd_reduc_eff character varying,
    lib_reduc_eff character varying
);


ALTER TABLE referentiels.reduc_eff OWNER TO pg_user;

--
-- Name: TABLE reduc_eff; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE reduc_eff IS 'Réduction effectif';


--
-- Name: COLUMN reduc_eff.id_reduc_eff; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN reduc_eff.id_reduc_eff IS 'PK';


--
-- Name: reduc_eff_id_reduc_eff_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE reduc_eff_id_reduc_eff_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.reduc_eff_id_reduc_eff_seq OWNER TO pg_user;

--
-- Name: reduc_eff_id_reduc_eff_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE reduc_eff_id_reduc_eff_seq OWNED BY reduc_eff.id_reduc_eff;


--
-- Name: regions; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE regions (
    id_reg integer NOT NULL,
    nom_reg character varying
);


ALTER TABLE referentiels.regions OWNER TO postgres;

--
-- Name: statut; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE statut (
    id integer NOT NULL,
    type_statut character varying,
    lib_statut character varying
);


ALTER TABLE referentiels.statut OWNER TO postgres;

--
-- Name: statut_id_seq; Type: SEQUENCE; Schema: referentiels; Owner: postgres
--

CREATE SEQUENCE statut_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.statut_id_seq OWNER TO postgres;

--
-- Name: statut_id_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE statut_id_seq OWNED BY statut.id;


--
-- Name: taxref_5; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_5 (
    cd_ref integer NOT NULL,
    nom_sci character varying,
    famille character varying,
    cd_rang character varying
);


ALTER TABLE referentiels.taxref_5 OWNER TO postgres;

--
-- Name: taxref_7; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_7 (
    cd_ref integer NOT NULL,
    nom_sci character varying,
    famille character varying,
    cd_rang character varying
);


ALTER TABLE referentiels.taxref_7 OWNER TO postgres;

--
-- Name: tendance_pop; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE tendance_pop (
    id_tendance_pop integer NOT NULL,
    cd_tendance_pop character varying,
    lib_tendance_pop character varying
);


ALTER TABLE referentiels.tendance_pop OWNER TO pg_user;

--
-- Name: TABLE tendance_pop; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE tendance_pop IS 'Eval - Tendance actuelle d évolution';


--
-- Name: COLUMN tendance_pop.id_tendance_pop; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN tendance_pop.id_tendance_pop IS 'PK';


--
-- Name: tendance_pop_id_tendance_pop_seq; Type: SEQUENCE; Schema: referentiels; Owner: pg_user
--

CREATE SEQUENCE tendance_pop_id_tendance_pop_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.tendance_pop_id_tendance_pop_seq OWNER TO pg_user;

--
-- Name: tendance_pop_id_tendance_pop_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE tendance_pop_id_tendance_pop_seq OWNED BY tendance_pop.id_tendance_pop;


--
-- Name: user_ref; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE user_ref (
    idu integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.user_ref OWNER TO postgres;

--
-- Name: user_ref_idu_seq; Type: SEQUENCE; Schema: referentiels; Owner: postgres
--

CREATE SEQUENCE user_ref_idu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE referentiels.user_ref_idu_seq OWNER TO postgres;

--
-- Name: user_ref_idu_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE user_ref_idu_seq OWNED BY user_ref.idu;


--
-- Name: id_ajustmt; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY ajustmt ALTER COLUMN id_ajustmt SET DEFAULT nextval('ajustmt_id_ajustmt_seq'::regclass);


--
-- Name: id_aoo; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY aoo ALTER COLUMN id_aoo SET DEFAULT nextval('aoo_id_aoo_seq'::regclass);


--
-- Name: id_cat_a; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY cat_a ALTER COLUMN id_cat_a SET DEFAULT nextval('cat_a_id_cat_a_seq'::regclass);


--
-- Name: id_cat; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY categorie ALTER COLUMN id_cat SET DEFAULT nextval('categorie_id_cat_seq'::regclass);


--
-- Name: id_cat; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY categorie_final ALTER COLUMN id_cat SET DEFAULT nextval('categorie_final_id_cat_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY champs ALTER COLUMN id SET DEFAULT nextval('champs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY champs_ref ALTER COLUMN id SET DEFAULT nextval('champs_ref_id_seq'::regclass);


--
-- Name: id_chgt_cat; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY chgt_cat ALTER COLUMN id_chgt_cat SET DEFAULT nextval('chgt_cat_id_chgt_cat_seq'::regclass);


--
-- Name: id_crit_a1; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_a1 ALTER COLUMN id_crit_a1 SET DEFAULT nextval('crit_a1_id_crit_a1_seq'::regclass);


--
-- Name: id_crit_a234; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_a234 ALTER COLUMN id_crit_a234 SET DEFAULT nextval('crit_a234_id_crit_a234_seq'::regclass);


--
-- Name: id_crit_c1; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_c1 ALTER COLUMN id_crit_c1 SET DEFAULT nextval('crit_c1_id_crit_c1_seq'::regclass);


--
-- Name: id_crit_c2; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_c2 ALTER COLUMN id_crit_c2 SET DEFAULT nextval('crit_c2_id_crit_c2_seq'::regclass);


--
-- Name: id_indi; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY indigenat ALTER COLUMN id_indi SET DEFAULT nextval('indigenat_id_indi_seq'::regclass);


--
-- Name: id_nbindiv; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY nbindiv ALTER COLUMN id_nbindiv SET DEFAULT nextval('nbindiv_id_nbindiv_seq'::regclass);


--
-- Name: id_nbloc; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY nbloc ALTER COLUMN id_nbloc SET DEFAULT nextval('nbloc_id_nbloc_seq'::regclass);


--
-- Name: id_raison_ajust; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY raison_ajust ALTER COLUMN id_raison_ajust SET DEFAULT nextval('raison_ajust_id_raison_ajust_seq'::regclass);


--
-- Name: id_rang; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY rang ALTER COLUMN id_rang SET DEFAULT nextval('rang_id_rang_seq'::regclass);


--
-- Name: id_reduc_eff; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY reduc_eff ALTER COLUMN id_reduc_eff SET DEFAULT nextval('reduc_eff_id_reduc_eff_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY statut ALTER COLUMN id SET DEFAULT nextval('statut_id_seq'::regclass);


--
-- Name: id_tendance_pop; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY tendance_pop ALTER COLUMN id_tendance_pop SET DEFAULT nextval('tendance_pop_id_tendance_pop_seq'::regclass);


--
-- Name: idu; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY user_ref ALTER COLUMN idu SET DEFAULT nextval('user_ref_idu_seq'::regclass);


--
-- Name: ajustmt_cd_ajustmt_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY ajustmt
    ADD CONSTRAINT ajustmt_cd_ajustmt_key UNIQUE (cd_ajustmt);


--
-- Name: ajustmt_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY ajustmt
    ADD CONSTRAINT ajustmt_pkey PRIMARY KEY (id_ajustmt);


--
-- Name: aoo_cd_aoo_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY aoo
    ADD CONSTRAINT aoo_cd_aoo_key UNIQUE (cd_aoo);


--
-- Name: aoo_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY aoo
    ADD CONSTRAINT aoo_pkey PRIMARY KEY (id_aoo);


--
-- Name: avancement_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY avancement
    ADD CONSTRAINT avancement_pkey PRIMARY KEY (id);


--
-- Name: cat_a_cd_cat_a_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cat_a
    ADD CONSTRAINT cat_a_cd_cat_a_key UNIQUE (cd_cat_a);


--
-- Name: cat_a_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cat_a
    ADD CONSTRAINT cat_a_pkey PRIMARY KEY (id_cat_a);


--
-- Name: categorie_cd_cat_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie
    ADD CONSTRAINT categorie_cd_cat_key UNIQUE (cd_cat);


--
-- Name: categorie_final_cd_cat_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie_final
    ADD CONSTRAINT categorie_final_cd_cat_key UNIQUE (cd_cat);


--
-- Name: categorie_final_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie_final
    ADD CONSTRAINT categorie_final_pkey PRIMARY KEY (id_cat);


--
-- Name: categorie_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_cat);


--
-- Name: cbn_cd_cbn_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cbn
    ADD CONSTRAINT cbn_cd_cbn_key UNIQUE (cd_cbn);


--
-- Name: champs_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY champs
    ADD CONSTRAINT champs_pkey PRIMARY KEY (id);


--
-- Name: champs_ref_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY champs_ref
    ADD CONSTRAINT champs_ref_pkey PRIMARY KEY (id);


--
-- Name: chgt_cat_cd_chgt_cat_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY chgt_cat
    ADD CONSTRAINT chgt_cat_cd_chgt_cat_key UNIQUE (cd_chgt_cat);


--
-- Name: chgt_cat_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY chgt_cat
    ADD CONSTRAINT chgt_cat_pkey PRIMARY KEY (id_chgt_cat);


--
-- Name: crit_a1_cd_crit_a1_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a1
    ADD CONSTRAINT crit_a1_cd_crit_a1_key UNIQUE (cd_crit_a1);


--
-- Name: crit_a1_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a1
    ADD CONSTRAINT crit_a1_pkey PRIMARY KEY (id_crit_a1);


--
-- Name: crit_a234_cd_crit_a234_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a234
    ADD CONSTRAINT crit_a234_cd_crit_a234_key UNIQUE (cd_crit_a234);


--
-- Name: crit_a234_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a234
    ADD CONSTRAINT crit_a234_pkey PRIMARY KEY (id_crit_a234);


--
-- Name: crit_c1_cd_crit_c1_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c1
    ADD CONSTRAINT crit_c1_cd_crit_c1_key UNIQUE (cd_crit_c1);


--
-- Name: crit_c1_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c1
    ADD CONSTRAINT crit_c1_pkey PRIMARY KEY (id_crit_c1);


--
-- Name: crit_c2_cd_crit_c2_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c2
    ADD CONSTRAINT crit_c2_cd_crit_c2_key UNIQUE (cd_crit_c2);


--
-- Name: crit_c2_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c2
    ADD CONSTRAINT crit_c2_pkey PRIMARY KEY (id_crit_c2);


--
-- Name: droit_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY droit
    ADD CONSTRAINT droit_pkey PRIMARY KEY (id);


--
-- Name: etape_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY etape
    ADD CONSTRAINT etape_pkey PRIMARY KEY (id);


--
-- Name: indigenat_cd_indi_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY indigenat
    ADD CONSTRAINT indigenat_cd_indi_key UNIQUE (cd_indi);


--
-- Name: indigenat_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY indigenat
    ADD CONSTRAINT indigenat_pkey PRIMARY KEY (id_indi);


--
-- Name: liste_rouge_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY liste_rouge
    ADD CONSTRAINT liste_rouge_pkey PRIMARY KEY (id_cat);


--
-- Name: nbindiv_cd_nbindiv_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbindiv
    ADD CONSTRAINT nbindiv_cd_nbindiv_key UNIQUE (cd_nbindiv);


--
-- Name: nbindiv_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbindiv
    ADD CONSTRAINT nbindiv_pkey PRIMARY KEY (id_nbindiv);


--
-- Name: nbloc_cd_nbloc_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbloc
    ADD CONSTRAINT nbloc_cd_nbloc_key UNIQUE (cd_nbloc);


--
-- Name: nbloc_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbloc
    ADD CONSTRAINT nbloc_pkey PRIMARY KEY (id_nbloc);


--
-- Name: pk_cbn; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cbn
    ADD CONSTRAINT pk_cbn PRIMARY KEY (id_cbn);


--
-- Name: pk_cd_ref_5; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_5
    ADD CONSTRAINT pk_cd_ref_5 PRIMARY KEY (cd_ref);


--
-- Name: pk_cd_ref_7; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_7
    ADD CONSTRAINT pk_cd_ref_7 PRIMARY KEY (cd_ref);


--
-- Name: raison_ajust_cd_raison_ajust_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY raison_ajust
    ADD CONSTRAINT raison_ajust_cd_raison_ajust_key UNIQUE (cd_raison_ajust);


--
-- Name: raison_ajust_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY raison_ajust
    ADD CONSTRAINT raison_ajust_pkey PRIMARY KEY (id_raison_ajust);


--
-- Name: rang_cd_rang_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY rang
    ADD CONSTRAINT rang_cd_rang_key UNIQUE (cd_rang);


--
-- Name: rang_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY rang
    ADD CONSTRAINT rang_pkey PRIMARY KEY (id_rang);


--
-- Name: reduc_eff_cd_reduc_eff_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY reduc_eff
    ADD CONSTRAINT reduc_eff_cd_reduc_eff_key UNIQUE (cd_reduc_eff);


--
-- Name: reduc_eff_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY reduc_eff
    ADD CONSTRAINT reduc_eff_pkey PRIMARY KEY (id_reduc_eff);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id_reg);


--
-- Name: statut_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY statut
    ADD CONSTRAINT statut_pkey PRIMARY KEY (id);


--
-- Name: tendance_pop_cd_tendance_pop_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY tendance_pop
    ADD CONSTRAINT tendance_pop_cd_tendance_pop_key UNIQUE (cd_tendance_pop);


--
-- Name: tendance_pop_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY tendance_pop
    ADD CONSTRAINT tendance_pop_pkey PRIMARY KEY (id_tendance_pop);


--
-- Name: user_ref_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_ref
    ADD CONSTRAINT user_ref_pkey PRIMARY KEY (idu);


--
-- Name: ajustmt_cd_ajustmt_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX ajustmt_cd_ajustmt_idx ON ajustmt USING btree (cd_ajustmt);


--
-- Name: aoo_cd_aoo_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX aoo_cd_aoo_idx ON aoo USING btree (cd_aoo);


--
-- Name: categorie_cd_cat_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX categorie_cd_cat_idx ON categorie USING btree (cd_cat);


--
-- Name: categorie_final_cd_cat_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX categorie_final_cd_cat_idx ON categorie_final USING btree (cd_cat);


--
-- Name: cbn_id_cbn_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cbn_id_cbn_idx ON cbn USING btree (id_cbn);


--
-- Name: cd_cat_a_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_cat_a_idx ON cat_a USING btree (cd_cat_a);


--
-- Name: cd_crit_a1_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_a1_idx ON crit_a1 USING btree (cd_crit_a1);


--
-- Name: cd_crit_a234_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_a234_idx ON crit_a234 USING btree (cd_crit_a234);


--
-- Name: cd_crit_c1_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_c1_idx ON crit_c1 USING btree (cd_crit_c1);


--
-- Name: cd_crit_c2_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_c2_idx ON crit_c2 USING btree (cd_crit_c2);


--
-- Name: cd_raison_ajust_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_raison_ajust_idx ON raison_ajust USING btree (cd_raison_ajust);


--
-- Name: cd_reduc_eff_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_reduc_eff_idx ON reduc_eff USING btree (cd_reduc_eff);


--
-- Name: cd_tendance_pop_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_tendance_pop_idx ON tendance_pop USING btree (cd_tendance_pop);


--
-- Name: chgt_cat_cd_chgt_cat_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX chgt_cat_cd_chgt_cat_idx ON chgt_cat USING btree (cd_chgt_cat);


--
-- Name: indigenat_cd_indi_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX indigenat_cd_indi_idx ON indigenat USING btree (cd_indi);


--
-- Name: nbindiv_cd_nbindiv_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX nbindiv_cd_nbindiv_idx ON nbindiv USING btree (cd_nbindiv);


--
-- Name: nbloc_cd_nbloc_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX nbloc_cd_nbloc_idx ON nbloc USING btree (cd_nbloc);


--
-- Name: rang_cd_rang_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX rang_cd_rang_idx ON rang USING btree (cd_rang);


--
-- Name: FK_rang_7; Type: FK CONSTRAINT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY taxref_7
    ADD CONSTRAINT "FK_rang_7" FOREIGN KEY (cd_rang) REFERENCES rang(cd_rang) MATCH FULL;


--
-- Name: fk_rang; Type: FK CONSTRAINT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY taxref_5
    ADD CONSTRAINT fk_rang FOREIGN KEY (cd_rang) REFERENCES rang(cd_rang) MATCH FULL;


--
-- Name: referentiels; Type: ACL; Schema: -; Owner: pg_user
--

REVOKE ALL ON SCHEMA referentiels FROM PUBLIC;
REVOKE ALL ON SCHEMA referentiels FROM pg_user;
GRANT ALL ON SCHEMA referentiels TO pg_user;


--
-- Name: ajustmt; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE ajustmt FROM PUBLIC;
REVOKE ALL ON TABLE ajustmt FROM pg_user;
GRANT ALL ON TABLE ajustmt TO pg_user;
GRANT ALL ON TABLE ajustmt TO postgres;


--
-- Name: aoo; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE aoo FROM PUBLIC;
REVOKE ALL ON TABLE aoo FROM pg_user;
GRANT ALL ON TABLE aoo TO pg_user;
GRANT ALL ON TABLE aoo TO postgres;


--
-- Name: cat_a; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE cat_a FROM PUBLIC;
REVOKE ALL ON TABLE cat_a FROM pg_user;
GRANT ALL ON TABLE cat_a TO pg_user;
GRANT ALL ON TABLE cat_a TO postgres;


--
-- Name: categorie; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE categorie FROM PUBLIC;
REVOKE ALL ON TABLE categorie FROM pg_user;
GRANT ALL ON TABLE categorie TO pg_user;
GRANT ALL ON TABLE categorie TO postgres;


--
-- Name: categorie_final; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE categorie_final FROM PUBLIC;
REVOKE ALL ON TABLE categorie_final FROM pg_user;
GRANT ALL ON TABLE categorie_final TO pg_user;
GRANT ALL ON TABLE categorie_final TO postgres;


--
-- Name: cbn; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE cbn FROM PUBLIC;
REVOKE ALL ON TABLE cbn FROM pg_user;
GRANT ALL ON TABLE cbn TO pg_user;
GRANT ALL ON TABLE cbn TO postgres;


--
-- Name: champs; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE champs FROM PUBLIC;
REVOKE ALL ON TABLE champs FROM postgres;
GRANT ALL ON TABLE champs TO postgres;
GRANT ALL ON TABLE champs TO pg_user;


--
-- Name: champs_ref; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE champs_ref FROM PUBLIC;
REVOKE ALL ON TABLE champs_ref FROM postgres;
GRANT ALL ON TABLE champs_ref TO postgres;
GRANT ALL ON TABLE champs_ref TO pg_user;


--
-- Name: chgt_cat; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE chgt_cat FROM PUBLIC;
REVOKE ALL ON TABLE chgt_cat FROM pg_user;
GRANT ALL ON TABLE chgt_cat TO pg_user;
GRANT ALL ON TABLE chgt_cat TO postgres;


--
-- Name: crit_a1; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_a1 FROM PUBLIC;
REVOKE ALL ON TABLE crit_a1 FROM pg_user;
GRANT ALL ON TABLE crit_a1 TO pg_user;
GRANT ALL ON TABLE crit_a1 TO postgres;


--
-- Name: crit_a234; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_a234 FROM PUBLIC;
REVOKE ALL ON TABLE crit_a234 FROM pg_user;
GRANT ALL ON TABLE crit_a234 TO pg_user;
GRANT ALL ON TABLE crit_a234 TO postgres;


--
-- Name: crit_c1; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_c1 FROM PUBLIC;
REVOKE ALL ON TABLE crit_c1 FROM pg_user;
GRANT ALL ON TABLE crit_c1 TO pg_user;
GRANT ALL ON TABLE crit_c1 TO postgres;


--
-- Name: crit_c2; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_c2 FROM PUBLIC;
REVOKE ALL ON TABLE crit_c2 FROM pg_user;
GRANT ALL ON TABLE crit_c2 TO pg_user;
GRANT ALL ON TABLE crit_c2 TO postgres;


--
-- Name: indigenat; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE indigenat FROM PUBLIC;
REVOKE ALL ON TABLE indigenat FROM pg_user;
GRANT ALL ON TABLE indigenat TO pg_user;
GRANT ALL ON TABLE indigenat TO postgres;


--
-- Name: liste_rouge; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE liste_rouge FROM PUBLIC;
REVOKE ALL ON TABLE liste_rouge FROM postgres;
GRANT ALL ON TABLE liste_rouge TO postgres;
GRANT ALL ON TABLE liste_rouge TO pg_user;


--
-- Name: nbindiv; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE nbindiv FROM PUBLIC;
REVOKE ALL ON TABLE nbindiv FROM pg_user;
GRANT ALL ON TABLE nbindiv TO pg_user;
GRANT ALL ON TABLE nbindiv TO postgres;


--
-- Name: nbloc; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE nbloc FROM PUBLIC;
REVOKE ALL ON TABLE nbloc FROM pg_user;
GRANT ALL ON TABLE nbloc TO pg_user;
GRANT ALL ON TABLE nbloc TO postgres;


--
-- Name: raison_ajust; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE raison_ajust FROM PUBLIC;
REVOKE ALL ON TABLE raison_ajust FROM pg_user;
GRANT ALL ON TABLE raison_ajust TO pg_user;
GRANT ALL ON TABLE raison_ajust TO postgres;


--
-- Name: rang; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE rang FROM PUBLIC;
REVOKE ALL ON TABLE rang FROM pg_user;
GRANT ALL ON TABLE rang TO pg_user;
GRANT ALL ON TABLE rang TO postgres;


--
-- Name: reduc_eff; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE reduc_eff FROM PUBLIC;
REVOKE ALL ON TABLE reduc_eff FROM pg_user;
GRANT ALL ON TABLE reduc_eff TO pg_user;
GRANT ALL ON TABLE reduc_eff TO postgres;


--
-- Name: statut; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE statut FROM PUBLIC;
REVOKE ALL ON TABLE statut FROM postgres;
GRANT ALL ON TABLE statut TO postgres;
GRANT ALL ON TABLE statut TO pg_user;


--
-- Name: tendance_pop; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE tendance_pop FROM PUBLIC;
REVOKE ALL ON TABLE tendance_pop FROM pg_user;
GRANT ALL ON TABLE tendance_pop TO pg_user;
GRANT ALL ON TABLE tendance_pop TO postgres;


--
-- Name: user_ref; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE user_ref FROM PUBLIC;
REVOKE ALL ON TABLE user_ref FROM postgres;
GRANT ALL ON TABLE user_ref TO postgres;
GRANT ALL ON TABLE user_ref TO pg_user;


--
-- PostgreSQL database dump complete
--

