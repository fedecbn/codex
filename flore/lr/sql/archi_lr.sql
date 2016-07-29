--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: lr; Type: SCHEMA; Schema: -; Owner: user_codex
--

CREATE SCHEMA lr;


ALTER SCHEMA lr OWNER TO user_codex;

--
-- Name: SCHEMA lr; Type: COMMENT; Schema: -; Owner: user_codex
--

COMMENT ON SCHEMA lr IS 'Liste Rouge';


SET search_path = lr, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: chorologie; Type: TABLE; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE TABLE chorologie (
    aoo1 integer,
    aoo4 integer,
    aoo_precis integer,
    id_aoo integer,
    nbloc_precis integer,
    id_nbloc integer,
    fragmt_sev boolean,
    declin_cont_ii boolean,
    declin_cont_iv boolean,
    fluct_extrem_ii boolean,
    fluct_extrem_iv boolean,
    nbm5_post1990_est integer,
    nbm5_post1990 integer,
    nbm5_post2000 integer,
    nbm5_total integer,
    nbcommune integer,
    nbindiv_precis integer,
    id_nbindiv integer,
    pop_transfront boolean,
    immigration boolean,
    reduc_eff_precis real,
    id_reduc_eff integer,
    declin_cont_i boolean,
    declin_cont_v boolean,
    declin_cont_iii boolean,
    id_tendance_pop integer,
    fluct_extrem_v boolean,
    fluct_extrem_iii boolean,
    uid integer NOT NULL
);


ALTER TABLE lr.chorologie OWNER TO user_codex;

--
-- Name: TABLE chorologie; Type: COMMENT; Schema: lr; Owner: user_codex
--

COMMENT ON TABLE chorologie IS 'Taxons chorologie';


--
-- Name: discussion; Type: TABLE; Schema: lr; Owner: user_codex; Tablespace: 
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


ALTER TABLE lr.discussion OWNER TO user_codex;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE; Schema: lr; Owner: user_codex
--

CREATE SEQUENCE discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lr.discussion_id_discussion_seq OWNER TO user_codex;

--
-- Name: discussion_id_discussion_seq; Type: SEQUENCE OWNED BY; Schema: lr; Owner: user_codex
--

ALTER SEQUENCE discussion_id_discussion_seq OWNED BY discussion.id_discussion;


--
-- Name: evaluation; Type: TABLE; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE TABLE evaluation (
    etape smallint DEFAULT 0,
    cat_a integer,
    just_a character varying,
    cat_a1 integer,
    crit_a1 integer,
    cat_a234 integer,
    crit_a2 integer,
    crit_a3 integer,
    crit_a4 integer,
    cat_b integer,
    just_b character varying,
    cat_c integer,
    just_c character varying,
    cat_c1 integer,
    crit_c1 integer,
    cat_c2 integer,
    crit_c2 integer,
    cat_d integer,
    just_d character varying,
    cat_d1 integer,
    crit_d1 character varying,
    cat_d2 integer,
    crit_d2 text,
    menace boolean,
    cat_e integer,
    just_e character varying,
    cat_ini integer,
    just_ini character varying,
    cat_fin integer,
    just_fin character varying,
    cat_preced integer,
    just_preced character varying,
    cat_euro integer,
    just_euro character varying,
    notes text,
    commentaire text,
    cat_synt_reg integer,
    just_synt_reg character varying,
    cd_ajustmt integer,
    nb_reg_presence integer,
    nb_reg_evalue integer,
    id_raison_ajust integer,
    uid integer NOT NULL,
    commentaire_eval text,
    avancement smallint DEFAULT 1,
    version integer DEFAULT 1
);


ALTER TABLE lr.evaluation OWNER TO user_codex;

--
-- Name: TABLE evaluation; Type: COMMENT; Schema: lr; Owner: user_codex
--

COMMENT ON TABLE evaluation IS 'Taxons évaluation';


--
-- Name: presence_tag; Type: TABLE; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE TABLE presence_tag (
    uid integer NOT NULL,
    typ_geo character varying NOT NULL,
    cd_geo character varying NOT NULL
);


ALTER TABLE lr.presence_tag OWNER TO user_codex;

--
-- Name: taxons; Type: TABLE; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE TABLE taxons (
    famille character varying,
    cd_ref integer,
    nom_sci character varying,
    nom_vern character varying,
    endemisme boolean,
    limite_aire boolean,
    aire_disjointe boolean,
    sous_obs boolean,
    hybride boolean,
    id_indi integer,
    id_rang integer,
    uid integer NOT NULL,
    indi_cal character varying
);


ALTER TABLE lr.taxons OWNER TO user_codex;

--
-- Name: TABLE taxons; Type: COMMENT; Schema: lr; Owner: user_codex
--

COMMENT ON TABLE taxons IS 'Taxons liste rouge';


--
-- Name: COLUMN taxons.indi_cal; Type: COMMENT; Schema: lr; Owner: user_codex
--

COMMENT ON COLUMN taxons.indi_cal IS 'indigénat calculé';


--
-- Name: validation; Type: TABLE; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE TABLE validation (
    id integer NOT NULL,
    uid integer,
    version_val integer,
    id_user character varying,
    validation character varying,
    val_com character varying,
    dat_val timestamp without time zone,
    etape_val smallint
);


ALTER TABLE lr.validation OWNER TO user_codex;

--
-- Name: validation_globale; Type: TABLE; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE TABLE validation_globale (
    uid integer NOT NULL,
    nbval integer,
    nbvalcbn integer,
    listval character varying,
    listvalcbn character varying,
    nbinval integer,
    nbinvalcbn integer,
    listinval character varying,
    listinvalcbn character varying,
    nbpot integer,
    nbpotcbn integer,
    listpot character varying,
    listpotcbn character varying
);


ALTER TABLE lr.validation_globale OWNER TO user_codex;

--
-- Name: validation_id_seq; Type: SEQUENCE; Schema: lr; Owner: user_codex
--

CREATE SEQUENCE validation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lr.validation_id_seq OWNER TO user_codex;

--
-- Name: validation_id_seq; Type: SEQUENCE OWNED BY; Schema: lr; Owner: user_codex
--

ALTER SEQUENCE validation_id_seq OWNED BY validation.id;


--
-- Name: id_discussion; Type: DEFAULT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY discussion ALTER COLUMN id_discussion SET DEFAULT nextval('discussion_id_discussion_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY validation ALTER COLUMN id SET DEFAULT nextval('validation_id_seq'::regclass);


--
-- Name: id_discussion_pkey; Type: CONSTRAINT; Schema: lr; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);


--
-- Name: pk_chorologie; Type: CONSTRAINT; Schema: lr; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY chorologie
    ADD CONSTRAINT pk_chorologie PRIMARY KEY (uid);


--
-- Name: pk_evaluation; Type: CONSTRAINT; Schema: lr; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT pk_evaluation PRIMARY KEY (uid);


--
-- Name: pk_taxon; Type: CONSTRAINT; Schema: lr; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY taxons
    ADD CONSTRAINT pk_taxon PRIMARY KEY (uid);


--
-- Name: presence_tag_pk; Type: CONSTRAINT; Schema: lr; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY presence_tag
    ADD CONSTRAINT presence_tag_pk PRIMARY KEY (uid, typ_geo, cd_geo);


--
-- Name: val_pk; Type: CONSTRAINT; Schema: lr; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY validation
    ADD CONSTRAINT val_pk PRIMARY KEY (id);


--
-- Name: validation_globale_pk; Type: CONSTRAINT; Schema: lr; Owner: user_codex; Tablespace: 
--

ALTER TABLE ONLY validation_globale
    ADD CONSTRAINT validation_globale_pk PRIMARY KEY (uid);


--
-- Name: evaluation_etape_idx; Type: INDEX; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE INDEX evaluation_etape_idx ON evaluation USING btree (etape);


--
-- Name: taxons_cd_ref_idx; Type: INDEX; Schema: lr; Owner: user_codex; Tablespace: 
--

CREATE INDEX taxons_cd_ref_idx ON taxons USING btree (cd_ref);


--
-- Name: FK_indi; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY taxons
    ADD CONSTRAINT "FK_indi" FOREIGN KEY (id_indi) REFERENCES referentiels.indigenat(id_indi) MATCH FULL;


--
-- Name: FK_nbindiv; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY chorologie
    ADD CONSTRAINT "FK_nbindiv" FOREIGN KEY (id_nbindiv) REFERENCES referentiels.nbindiv(id_nbindiv) MATCH FULL;


--
-- Name: FK_nbloc; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY chorologie
    ADD CONSTRAINT "FK_nbloc" FOREIGN KEY (id_nbloc) REFERENCES referentiels.nbloc(id_nbloc) MATCH FULL;


--
-- Name: FK_rang; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY taxons
    ADD CONSTRAINT "FK_rang" FOREIGN KEY (id_rang) REFERENCES referentiels.rang(id_rang) MATCH FULL;


--
-- Name: ajtm; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT ajtm FOREIGN KEY (cd_ajustmt) REFERENCES referentiels.ajustmt(id_ajustmt) MATCH FULL;


--
-- Name: cat1; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cat1 FOREIGN KEY (cat_a1) REFERENCES referentiels.categorie(id_cat) MATCH FULL;


--
-- Name: cat234; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cat234 FOREIGN KEY (cat_a234) REFERENCES referentiels.categorie(id_cat) MATCH FULL;


--
-- Name: cata; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cata FOREIGN KEY (cat_a) REFERENCES referentiels.categorie(id_cat) MATCH FULL;


--
-- Name: catb; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catb FOREIGN KEY (cat_b) REFERENCES referentiels.categorie(id_cat) MATCH FULL;


--
-- Name: catd; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catd FOREIGN KEY (cat_d) REFERENCES referentiels.categorie(id_cat) MATCH FULL;


--
-- Name: cate; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cate FOREIGN KEY (cat_e) REFERENCES referentiels.categorie(id_cat) MATCH FULL;


--
-- Name: cateuro; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cateuro FOREIGN KEY (cat_euro) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;


--
-- Name: catfin; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catfin FOREIGN KEY (cat_fin) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;


--
-- Name: catini; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catini FOREIGN KEY (cat_ini) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;


--
-- Name: catpreced; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catpreced FOREIGN KEY (cat_preced) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;


--
-- Name: crita1; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita1 FOREIGN KEY (crit_a1) REFERENCES referentiels.crit_a1(id_crit_a1) MATCH FULL;


--
-- Name: crita2; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita2 FOREIGN KEY (crit_a2) REFERENCES referentiels.crit_a234(id_crit_a234) MATCH FULL;


--
-- Name: crita3; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita3 FOREIGN KEY (crit_a3) REFERENCES referentiels.crit_a234(id_crit_a234) MATCH FULL;


--
-- Name: crita4; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita4 FOREIGN KEY (crit_a4) REFERENCES referentiels.crit_a234(id_crit_a234) MATCH FULL;


--
-- Name: critc1; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT critc1 FOREIGN KEY (crit_c1) REFERENCES referentiels.crit_c1(id_crit_c1) MATCH FULL;


--
-- Name: critc2; Type: FK CONSTRAINT; Schema: lr; Owner: user_codex
--

ALTER TABLE ONLY evaluation
    ADD CONSTRAINT critc2 FOREIGN KEY (crit_c2) REFERENCES referentiels.crit_c2(id_crit_c2) MATCH FULL;


--
-- Name: lr; Type: ACL; Schema: -; Owner: user_codex
--

REVOKE ALL ON SCHEMA lr FROM PUBLIC;
REVOKE ALL ON SCHEMA lr FROM user_codex;
GRANT ALL ON SCHEMA lr TO user_codex;


--
-- Name: chorologie; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON TABLE chorologie FROM PUBLIC;
REVOKE ALL ON TABLE chorologie FROM user_codex;
GRANT ALL ON TABLE chorologie TO user_codex;


--
-- Name: discussion; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON TABLE discussion FROM PUBLIC;
REVOKE ALL ON TABLE discussion FROM user_codex;
GRANT ALL ON TABLE discussion TO user_codex;


--
-- Name: evaluation; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON TABLE evaluation FROM PUBLIC;
REVOKE ALL ON TABLE evaluation FROM user_codex;
GRANT ALL ON TABLE evaluation TO user_codex;


--
-- Name: presence_tag; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON TABLE presence_tag FROM PUBLIC;
REVOKE ALL ON TABLE presence_tag FROM user_codex;
GRANT ALL ON TABLE presence_tag TO user_codex;


--
-- Name: taxons; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON TABLE taxons FROM PUBLIC;
REVOKE ALL ON TABLE taxons FROM user_codex;
GRANT ALL ON TABLE taxons TO user_codex;


--
-- Name: validation; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON TABLE validation FROM PUBLIC;
REVOKE ALL ON TABLE validation FROM user_codex;
GRANT ALL ON TABLE validation TO user_codex;


--
-- Name: validation_globale; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON TABLE validation_globale FROM PUBLIC;
REVOKE ALL ON TABLE validation_globale FROM user_codex;
GRANT ALL ON TABLE validation_globale TO user_codex;


--
-- Name: validation_id_seq; Type: ACL; Schema: lr; Owner: user_codex
--

REVOKE ALL ON SEQUENCE validation_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE validation_id_seq FROM user_codex;
GRANT ALL ON SEQUENCE validation_id_seq TO user_codex;


--
-- PostgreSQL database dump complete
--

