--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.22
-- Dumped by pg_dump version 9.2.2
-- Started on 2016-07-25 14:20:07

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 16 (class 2615 OID 219343443)
-- Name: referentiels; Type: SCHEMA; Schema: -; Owner: pg_user
--

CREATE SCHEMA referentiels;


ALTER SCHEMA referentiels OWNER TO pg_user;

--
-- TOC entry 3017 (class 0 OID 0)
-- Dependencies: 16
-- Name: SCHEMA referentiels; Type: COMMENT; Schema: -; Owner: pg_user
--

COMMENT ON SCHEMA referentiels IS 'Lettre du Systeme Information et Geomatique';


SET search_path = referentiels, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 219343517)
-- Name: ajustmt; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE ajustmt (
    id_ajustmt integer NOT NULL,
    cd_ajustmt character varying,
    lib_ajustmt character varying
);


ALTER TABLE referentiels.ajustmt OWNER TO pg_user;

--
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE ajustmt; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE ajustmt IS 'Eval - Ajustements';


--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN ajustmt.id_ajustmt; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN ajustmt.id_ajustmt IS 'PK';


--
-- TOC entry 186 (class 1259 OID 219343523)
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
-- TOC entry 3022 (class 0 OID 0)
-- Dependencies: 186
-- Name: ajustmt_id_ajustmt_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE ajustmt_id_ajustmt_seq OWNED BY ajustmt.id_ajustmt;


--
-- TOC entry 187 (class 1259 OID 219343525)
-- Name: aoo; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE aoo (
    id_aoo integer NOT NULL,
    cd_aoo character varying,
    lib_aoo character varying
);


ALTER TABLE referentiels.aoo OWNER TO pg_user;

--
-- TOC entry 3023 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE aoo; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE aoo IS 'Zone d occupation';


--
-- TOC entry 3024 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN aoo.id_aoo; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN aoo.id_aoo IS 'PK';


--
-- TOC entry 188 (class 1259 OID 219343531)
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
-- TOC entry 3026 (class 0 OID 0)
-- Dependencies: 188
-- Name: aoo_id_aoo_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE aoo_id_aoo_seq OWNED BY aoo.id_aoo;


--
-- TOC entry 293 (class 1259 OID 219602900)
-- Name: avancement; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE avancement (
    id integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.avancement OWNER TO pg_user;

--
-- TOC entry 189 (class 1259 OID 219343533)
-- Name: cat_a; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE cat_a (
    id_cat_a integer NOT NULL,
    cd_cat_a character varying,
    lib_cat_a character varying
);


ALTER TABLE referentiels.cat_a OWNER TO pg_user;

--
-- TOC entry 3028 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE cat_a; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE cat_a IS 'Eval - Catégorie A,B,C,D,E';


--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN cat_a.id_cat_a; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN cat_a.id_cat_a IS 'PK';


--
-- TOC entry 190 (class 1259 OID 219343539)
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
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 190
-- Name: cat_a_id_cat_a_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE cat_a_id_cat_a_seq OWNED BY cat_a.id_cat_a;


--
-- TOC entry 191 (class 1259 OID 219343541)
-- Name: categorie; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE categorie (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);


ALTER TABLE referentiels.categorie OWNER TO pg_user;

--
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE categorie; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE categorie IS 'Eval - Catégories';


--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN categorie.id_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN categorie.id_cat IS 'PK';


--
-- TOC entry 237 (class 1259 OID 219474252)
-- Name: categorie_final; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE categorie_final (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);


ALTER TABLE referentiels.categorie_final OWNER TO pg_user;

--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE categorie_final; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE categorie_final IS 'Eval - Catégories';


--
-- TOC entry 3036 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN categorie_final.id_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN categorie_final.id_cat IS 'PK';


--
-- TOC entry 236 (class 1259 OID 219474250)
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
-- TOC entry 3038 (class 0 OID 0)
-- Dependencies: 236
-- Name: categorie_final_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE categorie_final_id_cat_seq OWNED BY categorie_final.id_cat;


--
-- TOC entry 192 (class 1259 OID 219343555)
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
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 192
-- Name: categorie_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE categorie_id_cat_seq OWNED BY categorie.id_cat;


--
-- TOC entry 193 (class 1259 OID 219343557)
-- Name: cbn; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE cbn (
    id_cbn smallint NOT NULL,
    cd_cbn character varying,
    lib_cbn character varying
);


ALTER TABLE referentiels.cbn OWNER TO pg_user;

--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 193
-- Name: TABLE cbn; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE cbn IS 'CBN';


--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN cbn.id_cbn; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN cbn.id_cbn IS 'PK';


--
-- TOC entry 246 (class 1259 OID 219474693)
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
    table_bd character varying,
    jvs_desc_column character varying DEFAULT '{ "sWidth": "5%" }'::character varying,
    jvs_filter_column character varying DEFAULT '{ "type": "text" }'::character varying
);


ALTER TABLE referentiels.champs OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 219474691)
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
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 245
-- Name: champs_id_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE champs_id_seq OWNED BY champs.id;


--
-- TOC entry 249 (class 1259 OID 219474882)
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
    rubrique_ref character varying,
    where_champ character varying,
    where_value character varying
);


ALTER TABLE referentiels.champs_ref OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 219474880)
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
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 248
-- Name: champs_ref_id_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE champs_ref_id_seq OWNED BY champs_ref.id;


--
-- TOC entry 194 (class 1259 OID 219343563)
-- Name: chgt_cat; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE chgt_cat (
    id_chgt_cat integer NOT NULL,
    cd_chgt_cat character varying,
    lib_chgt_cat character varying
);


ALTER TABLE referentiels.chgt_cat OWNER TO pg_user;

--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 194
-- Name: TABLE chgt_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE chgt_cat IS 'Eval - Changement de Catégorie';


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 194
-- Name: COLUMN chgt_cat.id_chgt_cat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN chgt_cat.id_chgt_cat IS 'PK';


--
-- TOC entry 195 (class 1259 OID 219343569)
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
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 195
-- Name: chgt_cat_id_chgt_cat_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE chgt_cat_id_chgt_cat_seq OWNED BY chgt_cat.id_chgt_cat;


--
-- TOC entry 196 (class 1259 OID 219343571)
-- Name: crit_a1; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_a1 (
    id_crit_a1 integer NOT NULL,
    cd_crit_a1 character varying,
    lib_crit_a1 character varying
);


ALTER TABLE referentiels.crit_a1 OWNER TO pg_user;

--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE crit_a1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_a1 IS 'Eval - A1';


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN crit_a1.id_crit_a1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_a1.id_crit_a1 IS 'PK';


--
-- TOC entry 197 (class 1259 OID 219343577)
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
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 197
-- Name: crit_a1_id_crit_a1_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_a1_id_crit_a1_seq OWNED BY crit_a1.id_crit_a1;


--
-- TOC entry 198 (class 1259 OID 219343579)
-- Name: crit_a234; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_a234 (
    id_crit_a234 integer NOT NULL,
    cd_crit_a234 character varying,
    lib_crit_a234 character varying
);


ALTER TABLE referentiels.crit_a234 OWNER TO pg_user;

--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE crit_a234; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_a234 IS 'Eval - A2,A3,A4';


--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN crit_a234.id_crit_a234; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_a234.id_crit_a234 IS 'PK';


--
-- TOC entry 199 (class 1259 OID 219343585)
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
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 199
-- Name: crit_a234_id_crit_a234_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_a234_id_crit_a234_seq OWNED BY crit_a234.id_crit_a234;


--
-- TOC entry 200 (class 1259 OID 219343587)
-- Name: crit_c1; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_c1 (
    id_crit_c1 integer NOT NULL,
    cd_crit_c1 character varying,
    lib_crit_c1 character varying
);


ALTER TABLE referentiels.crit_c1 OWNER TO pg_user;

--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE crit_c1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_c1 IS 'Eval - C1';


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN crit_c1.id_crit_c1; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_c1.id_crit_c1 IS 'PK';


--
-- TOC entry 201 (class 1259 OID 219343593)
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
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 201
-- Name: crit_c1_id_crit_c1_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_c1_id_crit_c1_seq OWNED BY crit_c1.id_crit_c1;


--
-- TOC entry 202 (class 1259 OID 219343595)
-- Name: crit_c2; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE crit_c2 (
    id_crit_c2 integer NOT NULL,
    cd_crit_c2 character varying,
    lib_crit_c2 character varying
);


ALTER TABLE referentiels.crit_c2 OWNER TO pg_user;

--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE crit_c2; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE crit_c2 IS 'Eval - C2';


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN crit_c2.id_crit_c2; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN crit_c2.id_crit_c2 IS 'PK';


--
-- TOC entry 203 (class 1259 OID 219343601)
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
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 203
-- Name: crit_c2_id_crit_c2_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE crit_c2_id_crit_c2_seq OWNED BY crit_c2.id_crit_c2;


--
-- TOC entry 294 (class 1259 OID 219602916)
-- Name: droit; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE droit (
    id integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.droit OWNER TO pg_user;

--
-- TOC entry 253 (class 1259 OID 219475397)
-- Name: etape; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE etape (
    id integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.etape OWNER TO pg_user;

--
-- TOC entry 204 (class 1259 OID 219343603)
-- Name: indigenat; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE indigenat (
    id_indi integer NOT NULL,
    cd_indi character varying,
    lib_indi character varying
);


ALTER TABLE referentiels.indigenat OWNER TO pg_user;

--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE indigenat; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE indigenat IS 'Indigénat';


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 204
-- Name: COLUMN indigenat.id_indi; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN indigenat.id_indi IS 'PK';


--
-- TOC entry 205 (class 1259 OID 219343609)
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
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 205
-- Name: indigenat_id_indi_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE indigenat_id_indi_seq OWNED BY indigenat.id_indi;


--
-- TOC entry 303 (class 1259 OID 219603158)
-- Name: liste_rouge; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE liste_rouge (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);


ALTER TABLE referentiels.liste_rouge OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 219343611)
-- Name: nbindiv; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE nbindiv (
    id_nbindiv integer NOT NULL,
    cd_nbindiv character varying,
    lib_nbindiv character varying
);


ALTER TABLE referentiels.nbindiv OWNER TO pg_user;

--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE nbindiv; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE nbindiv IS 'Effectifs';


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN nbindiv.id_nbindiv; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN nbindiv.id_nbindiv IS 'PK';


--
-- TOC entry 207 (class 1259 OID 219343617)
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
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 207
-- Name: nbindiv_id_nbindiv_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE nbindiv_id_nbindiv_seq OWNED BY nbindiv.id_nbindiv;


--
-- TOC entry 208 (class 1259 OID 219343619)
-- Name: nbloc; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE nbloc (
    id_nbloc integer NOT NULL,
    cd_nbloc character varying,
    lib_nbloc character varying
);


ALTER TABLE referentiels.nbloc OWNER TO pg_user;

--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE nbloc; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE nbloc IS 'Nb de localités';


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN nbloc.id_nbloc; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN nbloc.id_nbloc IS 'PK';


--
-- TOC entry 209 (class 1259 OID 219343625)
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
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 209
-- Name: nbloc_id_nbloc_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE nbloc_id_nbloc_seq OWNED BY nbloc.id_nbloc;


--
-- TOC entry 318 (class 1259 OID 219626090)
-- Name: oblig; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE oblig (
    id integer NOT NULL,
    cd character varying,
    lib character varying
);


ALTER TABLE referentiels.oblig OWNER TO pg_user;

--
-- TOC entry 210 (class 1259 OID 219343627)
-- Name: raison_ajust; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE raison_ajust (
    id_raison_ajust integer NOT NULL,
    cd_raison_ajust character varying,
    lib_raison_ajust character varying
);


ALTER TABLE referentiels.raison_ajust OWNER TO pg_user;

--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE raison_ajust; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE raison_ajust IS 'Changement de Catégorie';


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN raison_ajust.id_raison_ajust; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN raison_ajust.id_raison_ajust IS 'PK';


--
-- TOC entry 211 (class 1259 OID 219343633)
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
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 211
-- Name: raison_ajust_id_raison_ajust_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE raison_ajust_id_raison_ajust_seq OWNED BY raison_ajust.id_raison_ajust;


--
-- TOC entry 212 (class 1259 OID 219343635)
-- Name: rang; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE rang (
    id_rang integer NOT NULL,
    cd_rang character varying,
    lib_rang character varying
);


ALTER TABLE referentiels.rang OWNER TO pg_user;

--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE rang; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE rang IS 'Taxonomie - Rangs';


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN rang.id_rang; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN rang.id_rang IS 'PK';


--
-- TOC entry 213 (class 1259 OID 219343641)
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
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 213
-- Name: rang_id_rang_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE rang_id_rang_seq OWNED BY rang.id_rang;


--
-- TOC entry 214 (class 1259 OID 219343643)
-- Name: reduc_eff; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE reduc_eff (
    id_reduc_eff integer NOT NULL,
    cd_reduc_eff character varying,
    lib_reduc_eff character varying
);


ALTER TABLE referentiels.reduc_eff OWNER TO pg_user;

--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE reduc_eff; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE reduc_eff IS 'Réduction effectif';


--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN reduc_eff.id_reduc_eff; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN reduc_eff.id_reduc_eff IS 'PK';


--
-- TOC entry 215 (class 1259 OID 219343649)
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
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 215
-- Name: reduc_eff_id_reduc_eff_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE reduc_eff_id_reduc_eff_seq OWNED BY reduc_eff.id_reduc_eff;


--
-- TOC entry 260 (class 1259 OID 219513825)
-- Name: regions; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE regions (
    id_reg integer NOT NULL,
    nom_reg character varying
);


ALTER TABLE referentiels.regions OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 219513450)
-- Name: statut; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE statut (
    id integer NOT NULL,
    type_statut character varying,
    lib_statut character varying
);


ALTER TABLE referentiels.statut OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 219513448)
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
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 255
-- Name: statut_id_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE statut_id_seq OWNED BY statut.id;


--
-- TOC entry 216 (class 1259 OID 219343651)
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
-- TOC entry 217 (class 1259 OID 219343657)
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
-- TOC entry 218 (class 1259 OID 219343663)
-- Name: tendance_pop; Type: TABLE; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE TABLE tendance_pop (
    id_tendance_pop integer NOT NULL,
    cd_tendance_pop character varying,
    lib_tendance_pop character varying
);


ALTER TABLE referentiels.tendance_pop OWNER TO pg_user;

--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE tendance_pop; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON TABLE tendance_pop IS 'Eval - Tendance actuelle d évolution';


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN tendance_pop.id_tendance_pop; Type: COMMENT; Schema: referentiels; Owner: pg_user
--

COMMENT ON COLUMN tendance_pop.id_tendance_pop IS 'PK';


--
-- TOC entry 219 (class 1259 OID 219343669)
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
-- TOC entry 3103 (class 0 OID 0)
-- Dependencies: 219
-- Name: tendance_pop_id_tendance_pop_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: pg_user
--

ALTER SEQUENCE tendance_pop_id_tendance_pop_seq OWNED BY tendance_pop.id_tendance_pop;


--
-- TOC entry 307 (class 1259 OID 219624767)
-- Name: user_ref; Type: TABLE; Schema: referentiels; Owner: postgres; Tablespace: 
--

CREATE TABLE user_ref (
    idu integer NOT NULL,
    cd integer,
    lib character varying
);


ALTER TABLE referentiels.user_ref OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 219624765)
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
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 306
-- Name: user_ref_idu_seq; Type: SEQUENCE OWNED BY; Schema: referentiels; Owner: postgres
--

ALTER SEQUENCE user_ref_idu_seq OWNED BY user_ref.idu;


--
-- TOC entry 2872 (class 2604 OID 219343677)
-- Name: id_ajustmt; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY ajustmt ALTER COLUMN id_ajustmt SET DEFAULT nextval('ajustmt_id_ajustmt_seq'::regclass);


--
-- TOC entry 2873 (class 2604 OID 219343678)
-- Name: id_aoo; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY aoo ALTER COLUMN id_aoo SET DEFAULT nextval('aoo_id_aoo_seq'::regclass);


--
-- TOC entry 2874 (class 2604 OID 219343679)
-- Name: id_cat_a; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY cat_a ALTER COLUMN id_cat_a SET DEFAULT nextval('cat_a_id_cat_a_seq'::regclass);


--
-- TOC entry 2875 (class 2604 OID 219343680)
-- Name: id_cat; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY categorie ALTER COLUMN id_cat SET DEFAULT nextval('categorie_id_cat_seq'::regclass);


--
-- TOC entry 2888 (class 2604 OID 219474255)
-- Name: id_cat; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY categorie_final ALTER COLUMN id_cat SET DEFAULT nextval('categorie_final_id_cat_seq'::regclass);


--
-- TOC entry 2889 (class 2604 OID 219474696)
-- Name: id; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY champs ALTER COLUMN id SET DEFAULT nextval('champs_id_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 219474885)
-- Name: id; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY champs_ref ALTER COLUMN id SET DEFAULT nextval('champs_ref_id_seq'::regclass);


--
-- TOC entry 2876 (class 2604 OID 219343682)
-- Name: id_chgt_cat; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY chgt_cat ALTER COLUMN id_chgt_cat SET DEFAULT nextval('chgt_cat_id_chgt_cat_seq'::regclass);


--
-- TOC entry 2877 (class 2604 OID 219343683)
-- Name: id_crit_a1; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_a1 ALTER COLUMN id_crit_a1 SET DEFAULT nextval('crit_a1_id_crit_a1_seq'::regclass);


--
-- TOC entry 2878 (class 2604 OID 219343684)
-- Name: id_crit_a234; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_a234 ALTER COLUMN id_crit_a234 SET DEFAULT nextval('crit_a234_id_crit_a234_seq'::regclass);


--
-- TOC entry 2879 (class 2604 OID 219343685)
-- Name: id_crit_c1; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_c1 ALTER COLUMN id_crit_c1 SET DEFAULT nextval('crit_c1_id_crit_c1_seq'::regclass);


--
-- TOC entry 2880 (class 2604 OID 219343686)
-- Name: id_crit_c2; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY crit_c2 ALTER COLUMN id_crit_c2 SET DEFAULT nextval('crit_c2_id_crit_c2_seq'::regclass);


--
-- TOC entry 2881 (class 2604 OID 219343687)
-- Name: id_indi; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY indigenat ALTER COLUMN id_indi SET DEFAULT nextval('indigenat_id_indi_seq'::regclass);


--
-- TOC entry 2882 (class 2604 OID 219343688)
-- Name: id_nbindiv; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY nbindiv ALTER COLUMN id_nbindiv SET DEFAULT nextval('nbindiv_id_nbindiv_seq'::regclass);


--
-- TOC entry 2883 (class 2604 OID 219343689)
-- Name: id_nbloc; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY nbloc ALTER COLUMN id_nbloc SET DEFAULT nextval('nbloc_id_nbloc_seq'::regclass);


--
-- TOC entry 2884 (class 2604 OID 219343690)
-- Name: id_raison_ajust; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY raison_ajust ALTER COLUMN id_raison_ajust SET DEFAULT nextval('raison_ajust_id_raison_ajust_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 219343691)
-- Name: id_rang; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY rang ALTER COLUMN id_rang SET DEFAULT nextval('rang_id_rang_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 219343692)
-- Name: id_reduc_eff; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY reduc_eff ALTER COLUMN id_reduc_eff SET DEFAULT nextval('reduc_eff_id_reduc_eff_seq'::regclass);


--
-- TOC entry 2895 (class 2604 OID 219513453)
-- Name: id; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY statut ALTER COLUMN id SET DEFAULT nextval('statut_id_seq'::regclass);


--
-- TOC entry 2887 (class 2604 OID 219343693)
-- Name: id_tendance_pop; Type: DEFAULT; Schema: referentiels; Owner: pg_user
--

ALTER TABLE ONLY tendance_pop ALTER COLUMN id_tendance_pop SET DEFAULT nextval('tendance_pop_id_tendance_pop_seq'::regclass);


--
-- TOC entry 2896 (class 2604 OID 219624770)
-- Name: idu; Type: DEFAULT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY user_ref ALTER COLUMN idu SET DEFAULT nextval('user_ref_idu_seq'::regclass);


--
-- TOC entry 2899 (class 2606 OID 219343715)
-- Name: ajustmt_cd_ajustmt_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY ajustmt
    ADD CONSTRAINT ajustmt_cd_ajustmt_key UNIQUE (cd_ajustmt);


--
-- TOC entry 2901 (class 2606 OID 219343717)
-- Name: ajustmt_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY ajustmt
    ADD CONSTRAINT ajustmt_pkey PRIMARY KEY (id_ajustmt);


--
-- TOC entry 2904 (class 2606 OID 219343719)
-- Name: aoo_cd_aoo_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY aoo
    ADD CONSTRAINT aoo_cd_aoo_key UNIQUE (cd_aoo);


--
-- TOC entry 2906 (class 2606 OID 219343721)
-- Name: aoo_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY aoo
    ADD CONSTRAINT aoo_pkey PRIMARY KEY (id_aoo);


--
-- TOC entry 3002 (class 2606 OID 219602907)
-- Name: avancement_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY avancement
    ADD CONSTRAINT avancement_pkey PRIMARY KEY (id);


--
-- TOC entry 2908 (class 2606 OID 219343723)
-- Name: cat_a_cd_cat_a_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cat_a
    ADD CONSTRAINT cat_a_cd_cat_a_key UNIQUE (cd_cat_a);


--
-- TOC entry 2910 (class 2606 OID 219343725)
-- Name: cat_a_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cat_a
    ADD CONSTRAINT cat_a_pkey PRIMARY KEY (id_cat_a);


--
-- TOC entry 2914 (class 2606 OID 219343727)
-- Name: categorie_cd_cat_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie
    ADD CONSTRAINT categorie_cd_cat_key UNIQUE (cd_cat);


--
-- TOC entry 2988 (class 2606 OID 219474262)
-- Name: categorie_final_cd_cat_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie_final
    ADD CONSTRAINT categorie_final_cd_cat_key UNIQUE (cd_cat);


--
-- TOC entry 2990 (class 2606 OID 219474260)
-- Name: categorie_final_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie_final
    ADD CONSTRAINT categorie_final_pkey PRIMARY KEY (id_cat);


--
-- TOC entry 2916 (class 2606 OID 219343733)
-- Name: categorie_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_cat);


--
-- TOC entry 2918 (class 2606 OID 219343735)
-- Name: cbn_cd_cbn_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cbn
    ADD CONSTRAINT cbn_cd_cbn_key UNIQUE (cd_cbn);


--
-- TOC entry 2992 (class 2606 OID 219474701)
-- Name: champs_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY champs
    ADD CONSTRAINT champs_pkey PRIMARY KEY (id);


--
-- TOC entry 2994 (class 2606 OID 219474890)
-- Name: champs_ref_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY champs_ref
    ADD CONSTRAINT champs_ref_pkey PRIMARY KEY (id);


--
-- TOC entry 2924 (class 2606 OID 219343737)
-- Name: chgt_cat_cd_chgt_cat_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY chgt_cat
    ADD CONSTRAINT chgt_cat_cd_chgt_cat_key UNIQUE (cd_chgt_cat);


--
-- TOC entry 2926 (class 2606 OID 219343739)
-- Name: chgt_cat_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY chgt_cat
    ADD CONSTRAINT chgt_cat_pkey PRIMARY KEY (id_chgt_cat);


--
-- TOC entry 2929 (class 2606 OID 219343741)
-- Name: crit_a1_cd_crit_a1_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a1
    ADD CONSTRAINT crit_a1_cd_crit_a1_key UNIQUE (cd_crit_a1);


--
-- TOC entry 2931 (class 2606 OID 219343743)
-- Name: crit_a1_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a1
    ADD CONSTRAINT crit_a1_pkey PRIMARY KEY (id_crit_a1);


--
-- TOC entry 2934 (class 2606 OID 219343745)
-- Name: crit_a234_cd_crit_a234_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a234
    ADD CONSTRAINT crit_a234_cd_crit_a234_key UNIQUE (cd_crit_a234);


--
-- TOC entry 2936 (class 2606 OID 219343747)
-- Name: crit_a234_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_a234
    ADD CONSTRAINT crit_a234_pkey PRIMARY KEY (id_crit_a234);


--
-- TOC entry 2939 (class 2606 OID 219343749)
-- Name: crit_c1_cd_crit_c1_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c1
    ADD CONSTRAINT crit_c1_cd_crit_c1_key UNIQUE (cd_crit_c1);


--
-- TOC entry 2941 (class 2606 OID 219343751)
-- Name: crit_c1_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c1
    ADD CONSTRAINT crit_c1_pkey PRIMARY KEY (id_crit_c1);


--
-- TOC entry 2944 (class 2606 OID 219343753)
-- Name: crit_c2_cd_crit_c2_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c2
    ADD CONSTRAINT crit_c2_cd_crit_c2_key UNIQUE (cd_crit_c2);


--
-- TOC entry 2946 (class 2606 OID 219343755)
-- Name: crit_c2_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY crit_c2
    ADD CONSTRAINT crit_c2_pkey PRIMARY KEY (id_crit_c2);


--
-- TOC entry 3004 (class 2606 OID 219602923)
-- Name: droit_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY droit
    ADD CONSTRAINT droit_pkey PRIMARY KEY (id);


--
-- TOC entry 2996 (class 2606 OID 219475404)
-- Name: etape_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY etape
    ADD CONSTRAINT etape_pkey PRIMARY KEY (id);


--
-- TOC entry 2949 (class 2606 OID 219343757)
-- Name: indigenat_cd_indi_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY indigenat
    ADD CONSTRAINT indigenat_cd_indi_key UNIQUE (cd_indi);


--
-- TOC entry 2951 (class 2606 OID 219343759)
-- Name: indigenat_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY indigenat
    ADD CONSTRAINT indigenat_pkey PRIMARY KEY (id_indi);


--
-- TOC entry 3006 (class 2606 OID 219603165)
-- Name: liste_rouge_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY liste_rouge
    ADD CONSTRAINT liste_rouge_pkey PRIMARY KEY (id_cat);


--
-- TOC entry 2954 (class 2606 OID 219343761)
-- Name: nbindiv_cd_nbindiv_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbindiv
    ADD CONSTRAINT nbindiv_cd_nbindiv_key UNIQUE (cd_nbindiv);


--
-- TOC entry 2956 (class 2606 OID 219343763)
-- Name: nbindiv_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbindiv
    ADD CONSTRAINT nbindiv_pkey PRIMARY KEY (id_nbindiv);


--
-- TOC entry 2959 (class 2606 OID 219343765)
-- Name: nbloc_cd_nbloc_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbloc
    ADD CONSTRAINT nbloc_cd_nbloc_key UNIQUE (cd_nbloc);


--
-- TOC entry 2961 (class 2606 OID 219343767)
-- Name: nbloc_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY nbloc
    ADD CONSTRAINT nbloc_pkey PRIMARY KEY (id_nbloc);


--
-- TOC entry 3010 (class 2606 OID 219626097)
-- Name: oblig_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY oblig
    ADD CONSTRAINT oblig_pkey PRIMARY KEY (id);


--
-- TOC entry 2921 (class 2606 OID 219343769)
-- Name: pk_cbn; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY cbn
    ADD CONSTRAINT pk_cbn PRIMARY KEY (id_cbn);


--
-- TOC entry 2978 (class 2606 OID 219343771)
-- Name: pk_cd_ref_5; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_5
    ADD CONSTRAINT pk_cd_ref_5 PRIMARY KEY (cd_ref);


--
-- TOC entry 2980 (class 2606 OID 219343773)
-- Name: pk_cd_ref_7; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_7
    ADD CONSTRAINT pk_cd_ref_7 PRIMARY KEY (cd_ref);


--
-- TOC entry 2964 (class 2606 OID 219343775)
-- Name: raison_ajust_cd_raison_ajust_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY raison_ajust
    ADD CONSTRAINT raison_ajust_cd_raison_ajust_key UNIQUE (cd_raison_ajust);


--
-- TOC entry 2966 (class 2606 OID 219343777)
-- Name: raison_ajust_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY raison_ajust
    ADD CONSTRAINT raison_ajust_pkey PRIMARY KEY (id_raison_ajust);


--
-- TOC entry 2969 (class 2606 OID 219343779)
-- Name: rang_cd_rang_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY rang
    ADD CONSTRAINT rang_cd_rang_key UNIQUE (cd_rang);


--
-- TOC entry 2971 (class 2606 OID 219343781)
-- Name: rang_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY rang
    ADD CONSTRAINT rang_pkey PRIMARY KEY (id_rang);


--
-- TOC entry 2974 (class 2606 OID 219343783)
-- Name: reduc_eff_cd_reduc_eff_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY reduc_eff
    ADD CONSTRAINT reduc_eff_cd_reduc_eff_key UNIQUE (cd_reduc_eff);


--
-- TOC entry 2976 (class 2606 OID 219343785)
-- Name: reduc_eff_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY reduc_eff
    ADD CONSTRAINT reduc_eff_pkey PRIMARY KEY (id_reduc_eff);


--
-- TOC entry 3000 (class 2606 OID 219513832)
-- Name: regions_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id_reg);


--
-- TOC entry 2998 (class 2606 OID 219513458)
-- Name: statut_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY statut
    ADD CONSTRAINT statut_pkey PRIMARY KEY (id);


--
-- TOC entry 2983 (class 2606 OID 219343787)
-- Name: tendance_pop_cd_tendance_pop_key; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY tendance_pop
    ADD CONSTRAINT tendance_pop_cd_tendance_pop_key UNIQUE (cd_tendance_pop);


--
-- TOC entry 2985 (class 2606 OID 219343789)
-- Name: tendance_pop_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY tendance_pop
    ADD CONSTRAINT tendance_pop_pkey PRIMARY KEY (id_tendance_pop);


--
-- TOC entry 3008 (class 2606 OID 219624775)
-- Name: user_ref_pkey; Type: CONSTRAINT; Schema: referentiels; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_ref
    ADD CONSTRAINT user_ref_pkey PRIMARY KEY (idu);


--
-- TOC entry 2897 (class 1259 OID 219343810)
-- Name: ajustmt_cd_ajustmt_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX ajustmt_cd_ajustmt_idx ON ajustmt USING btree (cd_ajustmt);


--
-- TOC entry 2902 (class 1259 OID 219343811)
-- Name: aoo_cd_aoo_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX aoo_cd_aoo_idx ON aoo USING btree (cd_aoo);


--
-- TOC entry 2912 (class 1259 OID 219343812)
-- Name: categorie_cd_cat_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX categorie_cd_cat_idx ON categorie USING btree (cd_cat);


--
-- TOC entry 2986 (class 1259 OID 219474263)
-- Name: categorie_final_cd_cat_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX categorie_final_cd_cat_idx ON categorie_final USING btree (cd_cat);


--
-- TOC entry 2919 (class 1259 OID 219343813)
-- Name: cbn_id_cbn_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cbn_id_cbn_idx ON cbn USING btree (id_cbn);


--
-- TOC entry 2911 (class 1259 OID 219343814)
-- Name: cd_cat_a_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_cat_a_idx ON cat_a USING btree (cd_cat_a);


--
-- TOC entry 2927 (class 1259 OID 219343816)
-- Name: cd_crit_a1_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_a1_idx ON crit_a1 USING btree (cd_crit_a1);


--
-- TOC entry 2932 (class 1259 OID 219343817)
-- Name: cd_crit_a234_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_a234_idx ON crit_a234 USING btree (cd_crit_a234);


--
-- TOC entry 2937 (class 1259 OID 219343818)
-- Name: cd_crit_c1_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_c1_idx ON crit_c1 USING btree (cd_crit_c1);


--
-- TOC entry 2942 (class 1259 OID 219343819)
-- Name: cd_crit_c2_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_crit_c2_idx ON crit_c2 USING btree (cd_crit_c2);


--
-- TOC entry 2962 (class 1259 OID 219343820)
-- Name: cd_raison_ajust_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_raison_ajust_idx ON raison_ajust USING btree (cd_raison_ajust);


--
-- TOC entry 2972 (class 1259 OID 219343821)
-- Name: cd_reduc_eff_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_reduc_eff_idx ON reduc_eff USING btree (cd_reduc_eff);


--
-- TOC entry 2981 (class 1259 OID 219343822)
-- Name: cd_tendance_pop_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX cd_tendance_pop_idx ON tendance_pop USING btree (cd_tendance_pop);


--
-- TOC entry 2922 (class 1259 OID 219343823)
-- Name: chgt_cat_cd_chgt_cat_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX chgt_cat_cd_chgt_cat_idx ON chgt_cat USING btree (cd_chgt_cat);


--
-- TOC entry 2947 (class 1259 OID 219343824)
-- Name: indigenat_cd_indi_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX indigenat_cd_indi_idx ON indigenat USING btree (cd_indi);


--
-- TOC entry 2952 (class 1259 OID 219343825)
-- Name: nbindiv_cd_nbindiv_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX nbindiv_cd_nbindiv_idx ON nbindiv USING btree (cd_nbindiv);


--
-- TOC entry 2957 (class 1259 OID 219343826)
-- Name: nbloc_cd_nbloc_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX nbloc_cd_nbloc_idx ON nbloc USING btree (cd_nbloc);


--
-- TOC entry 2967 (class 1259 OID 219343827)
-- Name: rang_cd_rang_idx; Type: INDEX; Schema: referentiels; Owner: pg_user; Tablespace: 
--

CREATE INDEX rang_cd_rang_idx ON rang USING btree (cd_rang);


--
-- TOC entry 3012 (class 2606 OID 219343948)
-- Name: FK_rang_7; Type: FK CONSTRAINT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY taxref_7
    ADD CONSTRAINT "FK_rang_7" FOREIGN KEY (cd_rang) REFERENCES rang(cd_rang) MATCH FULL;


--
-- TOC entry 3011 (class 2606 OID 219343953)
-- Name: fk_rang; Type: FK CONSTRAINT; Schema: referentiels; Owner: postgres
--

ALTER TABLE ONLY taxref_5
    ADD CONSTRAINT fk_rang FOREIGN KEY (cd_rang) REFERENCES rang(cd_rang) MATCH FULL;


--
-- TOC entry 3018 (class 0 OID 0)
-- Dependencies: 16
-- Name: referentiels; Type: ACL; Schema: -; Owner: pg_user
--

REVOKE ALL ON SCHEMA referentiels FROM PUBLIC;
REVOKE ALL ON SCHEMA referentiels FROM pg_user;
GRANT ALL ON SCHEMA referentiels TO pg_user;
GRANT USAGE ON SCHEMA referentiels TO "postgres";


--
-- TOC entry 3021 (class 0 OID 0)
-- Dependencies: 185
-- Name: ajustmt; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE ajustmt FROM PUBLIC;
REVOKE ALL ON TABLE ajustmt FROM pg_user;
GRANT ALL ON TABLE ajustmt TO pg_user;
GRANT ALL ON TABLE ajustmt TO postgres;
GRANT SELECT ON TABLE ajustmt TO "postgres";


--
-- TOC entry 3025 (class 0 OID 0)
-- Dependencies: 187
-- Name: aoo; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE aoo FROM PUBLIC;
REVOKE ALL ON TABLE aoo FROM pg_user;
GRANT ALL ON TABLE aoo TO pg_user;
GRANT ALL ON TABLE aoo TO postgres;
GRANT SELECT ON TABLE aoo TO "postgres";


--
-- TOC entry 3027 (class 0 OID 0)
-- Dependencies: 293
-- Name: avancement; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE avancement FROM PUBLIC;
REVOKE ALL ON TABLE avancement FROM pg_user;
GRANT ALL ON TABLE avancement TO pg_user;
GRANT SELECT ON TABLE avancement TO "postgres";


--
-- TOC entry 3030 (class 0 OID 0)
-- Dependencies: 189
-- Name: cat_a; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE cat_a FROM PUBLIC;
REVOKE ALL ON TABLE cat_a FROM pg_user;
GRANT ALL ON TABLE cat_a TO pg_user;
GRANT ALL ON TABLE cat_a TO postgres;
GRANT SELECT ON TABLE cat_a TO "postgres";


--
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 191
-- Name: categorie; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE categorie FROM PUBLIC;
REVOKE ALL ON TABLE categorie FROM pg_user;
GRANT ALL ON TABLE categorie TO pg_user;
GRANT ALL ON TABLE categorie TO postgres;
GRANT SELECT ON TABLE categorie TO "postgres";


--
-- TOC entry 3037 (class 0 OID 0)
-- Dependencies: 237
-- Name: categorie_final; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE categorie_final FROM PUBLIC;
REVOKE ALL ON TABLE categorie_final FROM pg_user;
GRANT ALL ON TABLE categorie_final TO pg_user;
GRANT ALL ON TABLE categorie_final TO postgres;
GRANT SELECT ON TABLE categorie_final TO "postgres";


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 193
-- Name: cbn; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE cbn FROM PUBLIC;
REVOKE ALL ON TABLE cbn FROM pg_user;
GRANT ALL ON TABLE cbn TO pg_user;
GRANT ALL ON TABLE cbn TO postgres;
GRANT SELECT ON TABLE cbn TO "postgres";


--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 246
-- Name: champs; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE champs FROM PUBLIC;
REVOKE ALL ON TABLE champs FROM postgres;
GRANT ALL ON TABLE champs TO postgres;
GRANT ALL ON TABLE champs TO pg_user;
GRANT SELECT ON TABLE champs TO "postgres";


--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 249
-- Name: champs_ref; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE champs_ref FROM PUBLIC;
REVOKE ALL ON TABLE champs_ref FROM postgres;
GRANT ALL ON TABLE champs_ref TO postgres;
GRANT ALL ON TABLE champs_ref TO pg_user;
GRANT SELECT ON TABLE champs_ref TO "postgres";


--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 194
-- Name: chgt_cat; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE chgt_cat FROM PUBLIC;
REVOKE ALL ON TABLE chgt_cat FROM pg_user;
GRANT ALL ON TABLE chgt_cat TO pg_user;
GRANT ALL ON TABLE chgt_cat TO postgres;
GRANT SELECT ON TABLE chgt_cat TO "postgres";


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 196
-- Name: crit_a1; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_a1 FROM PUBLIC;
REVOKE ALL ON TABLE crit_a1 FROM pg_user;
GRANT ALL ON TABLE crit_a1 TO pg_user;
GRANT ALL ON TABLE crit_a1 TO postgres;
GRANT SELECT ON TABLE crit_a1 TO "postgres";


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 198
-- Name: crit_a234; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_a234 FROM PUBLIC;
REVOKE ALL ON TABLE crit_a234 FROM pg_user;
GRANT ALL ON TABLE crit_a234 TO pg_user;
GRANT ALL ON TABLE crit_a234 TO postgres;
GRANT SELECT ON TABLE crit_a234 TO "postgres";


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 200
-- Name: crit_c1; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_c1 FROM PUBLIC;
REVOKE ALL ON TABLE crit_c1 FROM pg_user;
GRANT ALL ON TABLE crit_c1 TO pg_user;
GRANT ALL ON TABLE crit_c1 TO postgres;
GRANT SELECT ON TABLE crit_c1 TO "postgres";


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 202
-- Name: crit_c2; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE crit_c2 FROM PUBLIC;
REVOKE ALL ON TABLE crit_c2 FROM pg_user;
GRANT ALL ON TABLE crit_c2 TO pg_user;
GRANT ALL ON TABLE crit_c2 TO postgres;
GRANT SELECT ON TABLE crit_c2 TO "postgres";


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 294
-- Name: droit; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE droit FROM PUBLIC;
REVOKE ALL ON TABLE droit FROM pg_user;
GRANT ALL ON TABLE droit TO pg_user;
GRANT SELECT ON TABLE droit TO "postgres";


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 253
-- Name: etape; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE etape FROM PUBLIC;
REVOKE ALL ON TABLE etape FROM pg_user;
GRANT ALL ON TABLE etape TO pg_user;
GRANT SELECT ON TABLE etape TO "postgres";


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 204
-- Name: indigenat; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE indigenat FROM PUBLIC;
REVOKE ALL ON TABLE indigenat FROM pg_user;
GRANT ALL ON TABLE indigenat TO pg_user;
GRANT ALL ON TABLE indigenat TO postgres;
GRANT SELECT ON TABLE indigenat TO "postgres";


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 303
-- Name: liste_rouge; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE liste_rouge FROM PUBLIC;
REVOKE ALL ON TABLE liste_rouge FROM postgres;
GRANT ALL ON TABLE liste_rouge TO postgres;
GRANT ALL ON TABLE liste_rouge TO pg_user;
GRANT SELECT ON TABLE liste_rouge TO "postgres";


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 206
-- Name: nbindiv; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE nbindiv FROM PUBLIC;
REVOKE ALL ON TABLE nbindiv FROM pg_user;
GRANT ALL ON TABLE nbindiv TO pg_user;
GRANT ALL ON TABLE nbindiv TO postgres;
GRANT SELECT ON TABLE nbindiv TO "postgres";


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 208
-- Name: nbloc; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE nbloc FROM PUBLIC;
REVOKE ALL ON TABLE nbloc FROM pg_user;
GRANT ALL ON TABLE nbloc TO pg_user;
GRANT ALL ON TABLE nbloc TO postgres;
GRANT SELECT ON TABLE nbloc TO "postgres";


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 318
-- Name: oblig; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE oblig FROM PUBLIC;
REVOKE ALL ON TABLE oblig FROM pg_user;
GRANT ALL ON TABLE oblig TO pg_user;
GRANT SELECT ON TABLE oblig TO "postgres";


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 210
-- Name: raison_ajust; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE raison_ajust FROM PUBLIC;
REVOKE ALL ON TABLE raison_ajust FROM pg_user;
GRANT ALL ON TABLE raison_ajust TO pg_user;
GRANT ALL ON TABLE raison_ajust TO postgres;
GRANT SELECT ON TABLE raison_ajust TO "postgres";


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 212
-- Name: rang; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE rang FROM PUBLIC;
REVOKE ALL ON TABLE rang FROM pg_user;
GRANT ALL ON TABLE rang TO pg_user;
GRANT ALL ON TABLE rang TO postgres;
GRANT SELECT ON TABLE rang TO "postgres";


--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 214
-- Name: reduc_eff; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE reduc_eff FROM PUBLIC;
REVOKE ALL ON TABLE reduc_eff FROM pg_user;
GRANT ALL ON TABLE reduc_eff TO pg_user;
GRANT ALL ON TABLE reduc_eff TO postgres;
GRANT SELECT ON TABLE reduc_eff TO "postgres";


--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 260
-- Name: regions; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE regions FROM PUBLIC;
REVOKE ALL ON TABLE regions FROM postgres;
GRANT ALL ON TABLE regions TO postgres;
GRANT SELECT ON TABLE regions TO "postgres";


--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 256
-- Name: statut; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE statut FROM PUBLIC;
REVOKE ALL ON TABLE statut FROM postgres;
GRANT ALL ON TABLE statut TO postgres;
GRANT ALL ON TABLE statut TO pg_user;
GRANT SELECT ON TABLE statut TO "postgres";


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 216
-- Name: taxref_5; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE taxref_5 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_5 FROM postgres;
GRANT ALL ON TABLE taxref_5 TO postgres;
GRANT SELECT ON TABLE taxref_5 TO "postgres";


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 217
-- Name: taxref_7; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE taxref_7 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_7 FROM postgres;
GRANT ALL ON TABLE taxref_7 TO postgres;
GRANT SELECT ON TABLE taxref_7 TO "postgres";


--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 218
-- Name: tendance_pop; Type: ACL; Schema: referentiels; Owner: pg_user
--

REVOKE ALL ON TABLE tendance_pop FROM PUBLIC;
REVOKE ALL ON TABLE tendance_pop FROM pg_user;
GRANT ALL ON TABLE tendance_pop TO pg_user;
GRANT ALL ON TABLE tendance_pop TO postgres;
GRANT SELECT ON TABLE tendance_pop TO "postgres";


--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 307
-- Name: user_ref; Type: ACL; Schema: referentiels; Owner: postgres
--

REVOKE ALL ON TABLE user_ref FROM PUBLIC;
REVOKE ALL ON TABLE user_ref FROM postgres;
GRANT ALL ON TABLE user_ref TO postgres;
GRANT ALL ON TABLE user_ref TO pg_user;
GRANT SELECT ON TABLE user_ref TO "postgres";


-- Completed on 2016-07-25 14:20:12

--
-- PostgreSQL database dump complete
--

