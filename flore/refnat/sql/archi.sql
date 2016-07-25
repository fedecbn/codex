--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.22
-- Dumped by pg_dump version 9.2.2
-- Started on 2016-07-25 16:15:45

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 14 (class 2615 OID 219585377)
-- Name: refnat; Type: SCHEMA; Schema: -; Owner: pg_user
--

CREATE SCHEMA refnat;


ALTER SCHEMA refnat OWNER TO pg_user;

--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA refnat; Type: COMMENT; Schema: -; Owner: pg_user
--

COMMENT ON SCHEMA refnat IS 'standard public schema';


SET search_path = refnat, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 298 (class 1259 OID 219602962)
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
-- TOC entry 297 (class 1259 OID 219602960)
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
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 297
-- Name: discussion_id_discussion_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: pg_user
--

ALTER SEQUENCE discussion_id_discussion_seq OWNED BY discussion.id_discussion;


--
-- TOC entry 287 (class 1259 OID 219585674)
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
    pres_v2 boolean DEFAULT false,
    pres_v3 boolean DEFAULT false,
    pres_v4 boolean DEFAULT false,
    pres_v5 boolean DEFAULT false,
    pres_v6 boolean DEFAULT false,
    pres_v7 boolean DEFAULT false,
    pres_v8 boolean DEFAULT false,
    modif boolean,
    sb character varying,
    cd_sup integer,
    pres_v9 boolean DEFAULT false
);


ALTER TABLE refnat.taxons OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 219585672)
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
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 286
-- Name: taxons_uid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxons_uid_seq OWNED BY taxons.uid;


--
-- TOC entry 264 (class 1259 OID 219585378)
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
-- TOC entry 265 (class 1259 OID 219585384)
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
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 265
-- Name: taxref_changes_30_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_30_utf8_ogc_fid_seq OWNED BY taxref_changes_30_utf8.ogc_fid;


--
-- TOC entry 266 (class 1259 OID 219585386)
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
-- TOC entry 267 (class 1259 OID 219585392)
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
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 267
-- Name: taxref_changes_40_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_40_utf8_ogc_fid_seq OWNED BY taxref_changes_40_utf8.ogc_fid;


--
-- TOC entry 268 (class 1259 OID 219585394)
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
-- TOC entry 269 (class 1259 OID 219585400)
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
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 269
-- Name: taxref_changes_50_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_50_utf8_ogc_fid_seq OWNED BY taxref_changes_50_utf8.ogc_fid;


--
-- TOC entry 270 (class 1259 OID 219585402)
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
-- TOC entry 271 (class 1259 OID 219585408)
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
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 271
-- Name: taxref_changes_60_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_60_utf8_ogc_fid_seq OWNED BY taxref_changes_60_utf8.ogc_fid;


--
-- TOC entry 272 (class 1259 OID 219585410)
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
-- TOC entry 273 (class 1259 OID 219585416)
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
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 273
-- Name: taxref_changes_70_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_70_utf8_ogc_fid_seq OWNED BY taxref_changes_70_utf8.ogc_fid;


--
-- TOC entry 288 (class 1259 OID 219585710)
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
-- TOC entry 289 (class 1259 OID 219585716)
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
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 289
-- Name: taxref_changes_80_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_80_utf8_ogc_fid_seq OWNED BY taxref_changes_80_utf8.ogc_fid;


--
-- TOC entry 341 (class 1259 OID 220481362)
-- Name: taxref_changes_90_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxref_changes_90_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);


ALTER TABLE refnat.taxref_changes_90_utf8 OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 220481360)
-- Name: taxref_changes_90_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxref_changes_90_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxref_changes_90_utf8_ogc_fid_seq OWNER TO postgres;

--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 340
-- Name: taxref_changes_90_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxref_changes_90_utf8_ogc_fid_seq OWNED BY taxref_changes_90_utf8.ogc_fid;


--
-- TOC entry 274 (class 1259 OID 219585418)
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
-- TOC entry 275 (class 1259 OID 219585424)
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
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 275
-- Name: taxrefv20_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv20_utf8_ogc_fid_seq OWNED BY taxrefv20_utf8.ogc_fid;


--
-- TOC entry 276 (class 1259 OID 219585426)
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
-- TOC entry 277 (class 1259 OID 219585432)
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
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 277
-- Name: taxrefv30_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv30_utf8_ogc_fid_seq OWNED BY taxrefv30_utf8.ogc_fid;


--
-- TOC entry 278 (class 1259 OID 219585434)
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
-- TOC entry 279 (class 1259 OID 219585440)
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
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 279
-- Name: taxrefv40_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv40_utf8_ogc_fid_seq OWNED BY taxrefv40_utf8.ogc_fid;


--
-- TOC entry 280 (class 1259 OID 219585442)
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
-- TOC entry 281 (class 1259 OID 219585448)
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
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 281
-- Name: taxrefv50_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv50_utf8_ogc_fid_seq OWNED BY taxrefv50_utf8.ogc_fid;


--
-- TOC entry 282 (class 1259 OID 219585450)
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
-- TOC entry 283 (class 1259 OID 219585456)
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
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 283
-- Name: taxrefv60_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv60_utf8_ogc_fid_seq OWNED BY taxrefv60_utf8.ogc_fid;


--
-- TOC entry 284 (class 1259 OID 219585458)
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
-- TOC entry 285 (class 1259 OID 219585464)
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
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 285
-- Name: taxrefv70_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv70_utf8_ogc_fid_seq OWNED BY taxrefv70_utf8.ogc_fid;


--
-- TOC entry 290 (class 1259 OID 219585718)
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
-- TOC entry 291 (class 1259 OID 219585724)
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
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 291
-- Name: taxrefv80_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv80_utf8_ogc_fid_seq OWNED BY taxrefv80_utf8.ogc_fid;


--
-- TOC entry 339 (class 1259 OID 220481351)
-- Name: taxrefv90_utf8; Type: TABLE; Schema: refnat; Owner: postgres; Tablespace: 
--

CREATE TABLE taxrefv90_utf8 (
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
    nom_complet_html character varying,
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
    cd_sup integer
);


ALTER TABLE refnat.taxrefv90_utf8 OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 220481349)
-- Name: taxrefv90_utf8_ogc_fid_seq; Type: SEQUENCE; Schema: refnat; Owner: postgres
--

CREATE SEQUENCE taxrefv90_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refnat.taxrefv90_utf8_ogc_fid_seq OWNER TO postgres;

--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 338
-- Name: taxrefv90_utf8_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: refnat; Owner: postgres
--

ALTER SEQUENCE taxrefv90_utf8_ogc_fid_seq OWNED BY taxrefv90_utf8.ogc_fid;


--
-- TOC entry 2884 (class 2604 OID 219602965)
-- Name: id_discussion; Type: DEFAULT; Schema: refnat; Owner: pg_user
--

ALTER TABLE ONLY discussion ALTER COLUMN id_discussion SET DEFAULT nextval('discussion_id_discussion_seq'::regclass);


--
-- TOC entry 2870 (class 2604 OID 219585677)
-- Name: uid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxons ALTER COLUMN uid SET DEFAULT nextval('taxons_uid_seq'::regclass);


--
-- TOC entry 2859 (class 2604 OID 219585466)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_30_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_30_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2860 (class 2604 OID 219585467)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_40_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_40_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2861 (class 2604 OID 219585468)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_50_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_50_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2862 (class 2604 OID 219585469)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_60_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_60_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2863 (class 2604 OID 219585470)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_70_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_70_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2882 (class 2604 OID 219585726)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_80_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_80_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 220481365)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxref_changes_90_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxref_changes_90_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2864 (class 2604 OID 219585471)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv20_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv20_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2865 (class 2604 OID 219585472)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv30_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv30_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2866 (class 2604 OID 219585473)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv40_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv40_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2867 (class 2604 OID 219585474)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv50_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv50_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2868 (class 2604 OID 219585475)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv60_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv60_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2869 (class 2604 OID 219585476)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv70_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv70_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2883 (class 2604 OID 219585727)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv80_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv80_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 220481354)
-- Name: ogc_fid; Type: DEFAULT; Schema: refnat; Owner: postgres
--

ALTER TABLE ONLY taxrefv90_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('taxrefv90_utf8_ogc_fid_seq'::regclass);


--
-- TOC entry 2916 (class 2606 OID 219602970)
-- Name: id_discussion_pkey; Type: CONSTRAINT; Schema: refnat; Owner: pg_user; Tablespace: 
--

ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);


--
-- TOC entry 2910 (class 2606 OID 219585685)
-- Name: taxons_pkey; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxons
    ADD CONSTRAINT taxons_pkey PRIMARY KEY (uid);


--
-- TOC entry 2888 (class 2606 OID 219585478)
-- Name: taxref_changes_30_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_30_utf8
    ADD CONSTRAINT taxref_changes_30_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2890 (class 2606 OID 219585480)
-- Name: taxref_changes_40_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_40_utf8
    ADD CONSTRAINT taxref_changes_40_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2892 (class 2606 OID 219585482)
-- Name: taxref_changes_50_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_50_utf8
    ADD CONSTRAINT taxref_changes_50_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2894 (class 2606 OID 219585484)
-- Name: taxref_changes_60_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_60_utf8
    ADD CONSTRAINT taxref_changes_60_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2896 (class 2606 OID 219585486)
-- Name: taxref_changes_70_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_70_utf8
    ADD CONSTRAINT taxref_changes_70_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2912 (class 2606 OID 219585729)
-- Name: taxref_changes_80_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_80_utf8
    ADD CONSTRAINT taxref_changes_80_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2920 (class 2606 OID 220481370)
-- Name: taxref_changes_90_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxref_changes_90_utf8
    ADD CONSTRAINT taxref_changes_90_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2898 (class 2606 OID 219585488)
-- Name: taxrefv20_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv20_utf8
    ADD CONSTRAINT taxrefv20_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2900 (class 2606 OID 219585490)
-- Name: taxrefv30_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv30_utf8
    ADD CONSTRAINT taxrefv30_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2902 (class 2606 OID 219585492)
-- Name: taxrefv40_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv40_utf8
    ADD CONSTRAINT taxrefv40_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2904 (class 2606 OID 219585494)
-- Name: taxrefv50_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv50_utf8
    ADD CONSTRAINT taxrefv50_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2906 (class 2606 OID 219585496)
-- Name: taxrefv60_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv60_utf8
    ADD CONSTRAINT taxrefv60_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2908 (class 2606 OID 219585498)
-- Name: taxrefv70_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv70_utf8
    ADD CONSTRAINT taxrefv70_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2914 (class 2606 OID 219585731)
-- Name: taxrefv80_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv80_utf8
    ADD CONSTRAINT taxrefv80_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2918 (class 2606 OID 220481359)
-- Name: taxrefv90_utf8_pk; Type: CONSTRAINT; Schema: refnat; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxrefv90_utf8
    ADD CONSTRAINT taxrefv90_utf8_pk PRIMARY KEY (ogc_fid);


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 14
-- Name: refnat; Type: ACL; Schema: -; Owner: pg_user
--

REVOKE ALL ON SCHEMA refnat FROM PUBLIC;
REVOKE ALL ON SCHEMA refnat FROM pg_user;
GRANT ALL ON SCHEMA refnat TO pg_user;
GRANT ALL ON SCHEMA refnat TO PUBLIC;
GRANT USAGE ON SCHEMA refnat TO "postgres";


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 298
-- Name: discussion; Type: ACL; Schema: refnat; Owner: pg_user
--

REVOKE ALL ON TABLE discussion FROM PUBLIC;
REVOKE ALL ON TABLE discussion FROM pg_user;
GRANT ALL ON TABLE discussion TO pg_user;
GRANT SELECT ON TABLE discussion TO "postgres";


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 287
-- Name: taxons; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxons FROM PUBLIC;
REVOKE ALL ON TABLE taxons FROM postgres;
GRANT ALL ON TABLE taxons TO postgres;
GRANT ALL ON TABLE taxons TO pg_user;
GRANT SELECT ON TABLE taxons TO "postgres";


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 286
-- Name: taxons_uid_seq; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON SEQUENCE taxons_uid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE taxons_uid_seq FROM postgres;
GRANT ALL ON SEQUENCE taxons_uid_seq TO postgres;
GRANT ALL ON SEQUENCE taxons_uid_seq TO pg_user;


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 264
-- Name: taxref_changes_30_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxref_changes_30_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_30_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_30_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_30_utf8 TO pg_user;
GRANT SELECT ON TABLE taxref_changes_30_utf8 TO "postgres";


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 266
-- Name: taxref_changes_40_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxref_changes_40_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_40_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_40_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_40_utf8 TO pg_user;
GRANT SELECT ON TABLE taxref_changes_40_utf8 TO "postgres";


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 268
-- Name: taxref_changes_50_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxref_changes_50_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_50_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_50_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_50_utf8 TO pg_user;
GRANT SELECT ON TABLE taxref_changes_50_utf8 TO "postgres";


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 270
-- Name: taxref_changes_60_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxref_changes_60_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_60_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_60_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_60_utf8 TO pg_user;
GRANT SELECT ON TABLE taxref_changes_60_utf8 TO "postgres";


--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 272
-- Name: taxref_changes_70_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxref_changes_70_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_70_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_70_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_70_utf8 TO pg_user;
GRANT SELECT ON TABLE taxref_changes_70_utf8 TO "postgres";


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 288
-- Name: taxref_changes_80_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxref_changes_80_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_80_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_80_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_80_utf8 TO pg_user;
GRANT SELECT ON TABLE taxref_changes_80_utf8 TO "postgres";


--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 341
-- Name: taxref_changes_90_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxref_changes_90_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_90_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_90_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_90_utf8 TO pg_user;
GRANT SELECT ON TABLE taxref_changes_90_utf8 TO "postgres";


--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 274
-- Name: taxrefv20_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv20_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv20_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv20_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv20_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv20_utf8 TO "postgres";


--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 276
-- Name: taxrefv30_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv30_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv30_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv30_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv30_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv30_utf8 TO "postgres";


--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 278
-- Name: taxrefv40_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv40_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv40_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv40_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv40_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv40_utf8 TO "postgres";


--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 280
-- Name: taxrefv50_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv50_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv50_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv50_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv50_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv50_utf8 TO "postgres";


--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 282
-- Name: taxrefv60_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv60_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv60_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv60_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv60_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv60_utf8 TO "postgres";


--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 284
-- Name: taxrefv70_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv70_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv70_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv70_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv70_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv70_utf8 TO "postgres";


--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 290
-- Name: taxrefv80_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv80_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv80_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv80_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv80_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv80_utf8 TO "postgres";


--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 339
-- Name: taxrefv90_utf8; Type: ACL; Schema: refnat; Owner: postgres
--

REVOKE ALL ON TABLE taxrefv90_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv90_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv90_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv90_utf8 TO pg_user;
GRANT SELECT ON TABLE taxrefv90_utf8 TO "postgres";


-- Completed on 2016-07-25 16:15:48

--
-- PostgreSQL database dump complete
--

