ALTER DATABASE codex OWNER TO postgres;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP ROLE IF EXISTS codex_admin;

CREATE ROLE codex_admin LOGIN
  PASSWORD 'codex_admin'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;


CREATE SCHEMA applications;
ALTER SCHEMA applications OWNER TO codex_admin;

CREATE SCHEMA catnat;
ALTER SCHEMA catnat OWNER TO codex_admin;

CREATE SCHEMA defaut;
ALTER SCHEMA defaut OWNER TO codex_admin;

CREATE SCHEMA eee;
ALTER SCHEMA eee OWNER TO codex_admin;

CREATE SCHEMA liste_rouge;
ALTER SCHEMA liste_rouge OWNER TO codex_admin;

CREATE SCHEMA lsi;
ALTER SCHEMA lsi OWNER TO codex_admin;

ALTER SCHEMA public OWNER TO codex_admin;

CREATE SCHEMA referentiels;
ALTER SCHEMA referentiels OWNER TO codex_admin;

CREATE SCHEMA refnat;
ALTER SCHEMA refnat OWNER TO codex_admin;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


SET search_path = applications, pg_catalog;
CREATE FUNCTION maj_liste_taxon() RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
TRUNCATE applications.liste_taxon
INSERT INTO applications.liste_taxon
    SELECT uid, 'eval_eee', nom_sci, cd_ref FROM eee.taxons
INSERT INTO applications.liste_taxon
    SELECT uid, 'eval_lr', nom_sci, cd_ref FROM liste_rouge.taxons
end
$$;
ALTER FUNCTION applications.maj_liste_taxon() OWNER TO postgres;
SET default_tablespace = '';
SET default_with_oids = false;

CREATE TABLE applications.bug (
    id_bug integer NOT NULL,
    id_user character varying(10) NOT NULL,
    date_bug timestamp without time zone,
    id_rubrique smallint,
    descr text,
    cat smallint,
    statut smallint DEFAULT 0,
    statut_descr text
);
ALTER TABLE applications.bug OWNER TO codex_admin;

CREATE TABLE applications.log (
    id_log integer NOT NULL,
    event smallint DEFAULT 0 NOT NULL,
    id_user character varying(10) NOT NULL,
    ip character varying,
    descr1 text,
    descr2 text,
    tables character varying,
    datetime_event timestamp without time zone
);
ALTER TABLE applications.log OWNER TO codex_admin;

CREATE TABLE applications.pres (
    id_pres integer NOT NULL,
    id_module character varying(20) NOT NULL,
    page character varying(20) NOT NULL,
    titre character varying,
    pres text,
    lang smallint DEFAULT 0
);
ALTER TABLE applications.pres OWNER TO codex_admin;


CREATE TABLE applications.rubrique (
    id_rubrique integer NOT NULL,
    id_module character varying(20) NOT NULL,
    pos smallint DEFAULT 0 NOT NULL,
    icone character varying,
    titre character varying,
    descr character varying,
    niveau smallint DEFAULT 0 NOT NULL,
    link character varying NOT NULL,
    lang smallint DEFAULT 0
);
ALTER TABLE applications.rubrique OWNER TO codex_admin;


CREATE TABLE applications.suivi (
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
    uid integer
);
ALTER TABLE applications.suivi OWNER TO codex_admin;

CREATE TABLE applications.taxons (
    uid integer NOT NULL,
    cd_ref integer,
    nom character varying,
    liste_rouge boolean DEFAULT false,
    catnat boolean DEFAULT false,
    eee boolean DEFAULT false,
    refnat boolean DEFAULT false,
    defaut boolean DEFAULT false,
    famille character varying,
    cd_rang character varying,
    hybride boolean,
    nom_verna character varying
);
ALTER TABLE applications.taxons OWNER TO postgres;

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
    login character varying
);
ALTER TABLE applications.utilisateur OWNER TO codex_admin;



INSERT INTO applications.utilisateur(
            id_user, login, pw, niveau_lr, niveau_eee, niveau_lsi, niveau_catnat, niveau_refnat)
    VALUES ('admin','admin','admin',255,255,255,255,255);

CREATE TABLE catnat.discussion (
    id_discussion integer NOT NULL,
    uid integer NOT NULL,
    id_user character varying(10) NOT NULL,
    nom character varying,
    prenom character varying,
    id_cbn smallint,
    commentaire_eval character varying,
    datetime timestamp without time zone
);
ALTER TABLE catnat.discussion OWNER TO codex_admin;

CREATE TABLE catnat.statut_nat (
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

CREATE TABLE catnat.statut_reg (
    id_reg integer NOT NULL,
    nom_reg text NOT NULL,
    type_statut text NOT NULL,
    id_statut text NOT NULL,
    nom_statut text NOT NULL,
    uid integer NOT NULL
);
ALTER TABLE catnat.statut_reg OWNER TO postgres;

CREATE TABLE catnat.taxons_nat (
    famille character varying,
    cd_ref integer,
    nom_sci character varying,
    cd_rang character varying,
    nom_vern character varying,
    hybride boolean,
    commentaire character varying,
    uid integer NOT NULL
);
ALTER TABLE catnat.taxons_nat OWNER TO codex_admin;

CREATE TABLE defaut.base (
    uid integer NOT NULL,
    info_text character varying,
    info_real real,
    info_int integer,
    info_bool boolean
);
ALTER TABLE defaut.base OWNER TO codex_admin;

CREATE TABLE eee.argument (
    ida integer NOT NULL,
    contenu character varying,
    uid integer NOT NULL
);
ALTER TABLE eee.argument OWNER TO codex_admin;

CREATE TABLE eee.discussion (
    id_discussion integer NOT NULL,
    uid integer NOT NULL,
    id_user character varying(10) NOT NULL,
    nom character varying,
    prenom character varying,
    id_cbn smallint,
    commentaire_eval character varying,
    datetime timestamp without time zone
);
ALTER TABLE eee.discussion OWNER TO codex_admin;

CREATE TABLE eee.evaluation (
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
ALTER TABLE eee.evaluation OWNER TO codex_admin;

CREATE TABLE eee.liste_argument (
    ida integer NOT NULL,
    libelle character varying
);
ALTER TABLE eee.liste_argument OWNER TO codex_admin;

CREATE TABLE eee.liste_reponse (
    idq integer NOT NULL,
    code_question character varying,
    libelle_question character varying,
    libelle_reponse character varying,
    libelle_court_reponse character varying,
    indicateur integer,
    code_eval character varying,
    coor_ids integer
);
ALTER TABLE eee.liste_reponse OWNER TO codex_admin;

CREATE TABLE eee.liste_source (
    ids integer NOT NULL,
    libelle character varying
);
ALTER TABLE eee.liste_source OWNER TO codex_admin;

CREATE TABLE eee.pays (
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
ALTER TABLE eee.pays OWNER TO codex_admin;

CREATE TABLE eee.region (
    idr integer NOT NULL,
    insee_reg integer,
    cbn character varying,
    region character varying,
    region_biogeo character varying,
    CONSTRAINT ck_region CHECK (((region_biogeo)::text = ANY (ARRAY[('za'::character varying)::text, ('zc'::character varying)::text, ('zm'::character varying)::text])))
);
ALTER TABLE eee.region OWNER TO codex_admin;

CREATE TABLE eee.reponse (
    idq integer NOT NULL,
    zone character varying NOT NULL,
    uid integer NOT NULL,
    CONSTRAINT ck_zone_reponse CHECK (((zone)::text = ANY (ARRAY[('gl'::character varying)::text, ('za'::character varying)::text, ('zc'::character varying)::text, ('zm'::character varying)::text])))
);
ALTER TABLE eee.reponse OWNER TO codex_admin;

CREATE TABLE eee.source (
    ids integer NOT NULL,
    contenu character varying,
    fiabilite integer,
    uid integer NOT NULL
);
ALTER TABLE eee.source OWNER TO codex_admin;

CREATE TABLE eee.statut_inter (
    idp integer NOT NULL,
    statut character varying NOT NULL,
    uid integer NOT NULL,
    CONSTRAINT ck_statut_inter CHECK (((statut)::text = ANY (ARRAY[('pres'::character varying)::text, ('indig'::character varying)::text, ('invav'::character varying)::text])))
);
ALTER TABLE eee.statut_inter OWNER TO codex_admin;

CREATE TABLE eee.statut_natio (
    idr integer NOT NULL,
    statut character varying NOT NULL,
    uid integer NOT NULL,
    CONSTRAINT ck_statut_nation CHECK (((statut)::text = ANY (ARRAY[('pres'::character varying)::text, ('indig'::character varying)::text, ('invav'::character varying)::text])))
);
ALTER TABLE eee.statut_natio OWNER TO codex_admin;

CREATE TABLE eee.taxons (
    cd_ref integer,
    nom_sci character varying,
    lib_rang character varying,
    nom_verna character varying,
    cd_nom integer,
    commentaire character varying,
    gbif_url character varying,
    uid integer NOT NULL
);
ALTER TABLE eee.taxons OWNER TO codex_admin;

CREATE TABLE liste_rouge.chorologie (
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
ALTER TABLE liste_rouge.chorologie OWNER TO codex_admin;


CREATE TABLE liste_rouge.discussion (
    id_discussion integer NOT NULL,
    uid integer NOT NULL,
    id_user character varying(10) NOT NULL,
    nom character varying,
    prenom character varying,
    id_cbn smallint,
    commentaire_eval character varying,
    datetime timestamp without time zone
);
ALTER TABLE liste_rouge.discussion OWNER TO codex_admin;

CREATE TABLE liste_rouge.evaluation (
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
    avancement smallint DEFAULT 1
);
ALTER TABLE liste_rouge.evaluation OWNER TO codex_admin;


CREATE TABLE liste_rouge.taxons (
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
    uid integer NOT NULL
);
ALTER TABLE liste_rouge.taxons OWNER TO codex_admin;


CREATE TABLE lsi.coor_news_tag (
    id integer NOT NULL,
    id_tag integer NOT NULL
);
ALTER TABLE lsi.coor_news_tag OWNER TO postgres;

CREATE TABLE lsi.news (
    id integer NOT NULL,
    abstract text,
    link text,
    id_subject integer,
    date date,
    title text,
    link_2 character varying
);
ALTER TABLE lsi.news OWNER TO postgres;

CREATE TABLE lsi.subject (
    id_subject integer NOT NULL,
    libelle_subject text
);
ALTER TABLE lsi.subject OWNER TO postgres;

CREATE TABLE lsi.tag (
    id_tag integer NOT NULL,
    libelle_tag text
);
ALTER TABLE lsi.tag OWNER TO postgres;

CREATE TABLE referentiels.ajustmt (
    id_ajustmt integer NOT NULL,
    cd_ajustmt character varying,
    lib_ajustmt character varying
);
ALTER TABLE referentiels.ajustmt OWNER TO codex_admin;

CREATE TABLE referentiels.aoo (
    id_aoo integer NOT NULL,
    cd_aoo character varying,
    lib_aoo character varying
);
ALTER TABLE referentiels.aoo OWNER TO codex_admin;


CREATE TABLE referentiels.avancement (
    id integer NOT NULL,
    cd integer,
    lib character varying
);
ALTER TABLE referentiels.avancement OWNER TO codex_admin;

CREATE TABLE referentiels.cat_a (
    id_cat_a integer NOT NULL,
    cd_cat_a character varying,
    lib_cat_a character varying
);
ALTER TABLE referentiels.cat_a OWNER TO codex_admin;


CREATE TABLE referentiels.categorie (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);
ALTER TABLE referentiels.categorie OWNER TO codex_admin;


CREATE TABLE referentiels.categorie_final (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);
ALTER TABLE referentiels.categorie_final OWNER TO codex_admin;


CREATE TABLE referentiels.cbn (
    id_cbn smallint NOT NULL,
    cd_cbn character varying,
    lib_cbn character varying
);
ALTER TABLE referentiels.cbn OWNER TO codex_admin;

CREATE TABLE referentiels.champs (
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

CREATE TABLE referentiels.champs_ref (
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

CREATE TABLE referentiels.chgt_cat (
    id_chgt_cat integer NOT NULL,
    cd_chgt_cat character varying,
    lib_chgt_cat character varying
);
ALTER TABLE referentiels.chgt_cat OWNER TO codex_admin;

CREATE TABLE referentiels.crit_a1 (
    id_crit_a1 integer NOT NULL,
    cd_crit_a1 character varying,
    lib_crit_a1 character varying
);
ALTER TABLE referentiels.crit_a1 OWNER TO codex_admin;

CREATE TABLE referentiels.crit_a234 (
    id_crit_a234 integer NOT NULL,
    cd_crit_a234 character varying,
    lib_crit_a234 character varying
);
ALTER TABLE referentiels.crit_a234 OWNER TO codex_admin;

CREATE TABLE referentiels.crit_c1 (
    id_crit_c1 integer NOT NULL,
    cd_crit_c1 character varying,
    lib_crit_c1 character varying
);
ALTER TABLE referentiels.crit_c1 OWNER TO codex_admin;


CREATE TABLE referentiels.crit_c2 (
    id_crit_c2 integer NOT NULL,
    cd_crit_c2 character varying,
    lib_crit_c2 character varying
);
ALTER TABLE referentiels.crit_c2 OWNER TO codex_admin;


CREATE TABLE referentiels.droit (
    id integer NOT NULL,
    cd integer,
    lib character varying
);
ALTER TABLE referentiels.droit OWNER TO codex_admin;

CREATE TABLE referentiels.etape (
    id integer NOT NULL,
    cd integer,
    lib character varying
);
ALTER TABLE referentiels.etape OWNER TO codex_admin;

CREATE TABLE referentiels.indigenat (
    id_indi integer NOT NULL,
    cd_indi character varying,
    lib_indi character varying
);
ALTER TABLE referentiels.indigenat OWNER TO codex_admin;

CREATE TABLE referentiels.liste_rouge (
    id_cat integer NOT NULL,
    cd_cat character varying,
    lib_cat character varying
);
ALTER TABLE referentiels.liste_rouge OWNER TO postgres;

CREATE TABLE referentiels.nbindiv (
    id_nbindiv integer NOT NULL,
    cd_nbindiv character varying,
    lib_nbindiv character varying
);
ALTER TABLE referentiels.nbindiv OWNER TO codex_admin;


CREATE TABLE referentiels.nbloc (
    id_nbloc integer NOT NULL,
    cd_nbloc character varying,
    lib_nbloc character varying
);
ALTER TABLE referentiels.nbloc OWNER TO codex_admin;

CREATE TABLE referentiels.raison_ajust (
    id_raison_ajust integer NOT NULL,
    cd_raison_ajust character varying,
    lib_raison_ajust character varying
);
ALTER TABLE referentiels.raison_ajust OWNER TO codex_admin;

CREATE TABLE referentiels.rang (
    id_rang integer NOT NULL,
    cd_rang character varying,
    lib_rang character varying
);
ALTER TABLE referentiels.rang OWNER TO codex_admin;

CREATE TABLE referentiels.reduc_eff (
    id_reduc_eff integer NOT NULL,
    cd_reduc_eff character varying,
    lib_reduc_eff character varying
);
ALTER TABLE referentiels.reduc_eff OWNER TO codex_admin;


CREATE TABLE referentiels.regions (
    id_reg integer NOT NULL,
    nom_reg character varying
);
ALTER TABLE referentiels.regions OWNER TO codex_admin;
CREATE TABLE statut (
    id integer NOT NULL,
    type_statut character varying,
    lib_statut character varying
);

CREATE TABLE referentiels.statut
(
  id serial NOT NULL,
  type_statut character varying,
  lib_statut character varying
);
ALTER TABLE referentiels.statut OWNER TO codex_admin;

CREATE TABLE referentiels.taxref_5 (
    cd_ref integer NOT NULL,
    nom_sci character varying,
    famille character varying,
    cd_rang character varying
);
ALTER TABLE referentiels.taxref_5 OWNER TO codex_admin;

CREATE TABLE referentiels.taxref_7 (
    cd_ref integer NOT NULL,
    nom_sci character varying,
    famille character varying,
    cd_rang character varying
);
ALTER TABLE referentiels.taxref_7 OWNER TO codex_admin;

CREATE TABLE referentiels.tendance_pop (
    id_tendance_pop integer NOT NULL,
    cd_tendance_pop character varying,
    lib_tendance_pop character varying
);
ALTER TABLE referentiels.tendance_pop OWNER TO codex_admin;



CREATE TABLE referentiels.user_ref (
    idu integer NOT NULL,
    cd integer,
    lib character varying
);
ALTER TABLE referentiels.user_ref OWNER TO postgres;

SET search_path = refnat, pg_catalog;
CREATE TABLE refnat.discussion (
    id_discussion integer NOT NULL,
    uid integer NOT NULL,
    id_user character varying(10) NOT NULL,
    nom character varying,
    prenom character varying,
    id_cbn smallint,
    commentaire_eval character varying,
    datetime timestamp without time zone
);
ALTER TABLE refnat.discussion OWNER TO codex_admin;

CREATE TABLE refnat.taxons (
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
    liste_rouge boolean DEFAULT false,
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
ALTER TABLE refnat.taxons OWNER TO codex_admin;

CREATE TABLE refnat.taxref_changes_30_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);
ALTER TABLE refnat.taxref_changes_30_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxref_changes_40_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);
ALTER TABLE refnat.taxref_changes_40_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxref_changes_50_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);
ALTER TABLE refnat.taxref_changes_50_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxref_changes_60_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);
ALTER TABLE refnat.taxref_changes_60_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxref_changes_70_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);
ALTER TABLE refnat.taxref_changes_70_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxref_changes_80_utf8 (
    ogc_fid integer NOT NULL,
    cd_nom character varying,
    num_version_init character varying,
    num_version_final character varying,
    champ character varying,
    valeur_init character varying,
    valeur_final character varying,
    type_change character varying
);
ALTER TABLE refnat.taxref_changes_80_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxrefv20_utf8 (
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
ALTER TABLE refnat.taxrefv20_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxrefv30_utf8 (
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
ALTER TABLE refnat.taxrefv30_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxrefv40_utf8 (
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
ALTER TABLE refnat.taxrefv40_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxrefv50_utf8 (
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
ALTER TABLE refnat.taxrefv50_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxrefv60_utf8 (
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
ALTER TABLE refnat.taxrefv60_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxrefv70_utf8 (
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
ALTER TABLE refnat.taxrefv70_utf8 OWNER TO codex_admin;

CREATE TABLE refnat.taxrefv80_utf8 (
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
ALTER TABLE refnat.taxrefv80_utf8 OWNER TO codex_admin;


ALTER TABLE ONLY applications.bug
    ADD CONSTRAINT bug_pkey PRIMARY KEY (id_bug);
ALTER TABLE ONLY applications.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id_log);
ALTER TABLE ONLY applications.pres
    ADD CONSTRAINT pres_pkey PRIMARY KEY (id_pres);
ALTER TABLE ONLY applications.rubrique
    ADD CONSTRAINT rubrique_pkey PRIMARY KEY (id_rubrique);
ALTER TABLE ONLY applications.suivi
    ADD CONSTRAINT suivi_pkey PRIMARY KEY (id_suivi);
ALTER TABLE ONLY applications.taxons
    ADD CONSTRAINT taxons_pkey PRIMARY KEY (uid);
ALTER TABLE ONLY applications.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_user);

SET search_path = catnat, pg_catalog;
ALTER TABLE ONLY statut_reg
    ADD CONSTRAINT "PK_coor_statut" PRIMARY KEY (uid, id_reg, type_statut);
ALTER TABLE ONLY statut_nat
    ADD CONSTRAINT "PK_coor_statut_nat" PRIMARY KEY (uid);
ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);
ALTER TABLE ONLY taxons_nat
    ADD CONSTRAINT pk_taxon PRIMARY KEY (uid);

SET search_path = defaut, pg_catalog;
ALTER TABLE ONLY base
    ADD CONSTRAINT base_pkey PRIMARY KEY (uid);
	
SET search_path = eee, pg_catalog;
ALTER TABLE ONLY argument
    ADD CONSTRAINT "PK_argument" PRIMARY KEY (uid, ida);
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT "PK_eval" PRIMARY KEY (uid);
ALTER TABLE ONLY liste_argument
    ADD CONSTRAINT "PK_liste_argument" PRIMARY KEY (ida);
ALTER TABLE ONLY liste_source
    ADD CONSTRAINT "PK_liste_source" PRIMARY KEY (ids);
ALTER TABLE ONLY pays
    ADD CONSTRAINT "PK_pays" PRIMARY KEY (idp);
ALTER TABLE ONLY liste_reponse
    ADD CONSTRAINT "PK_question" PRIMARY KEY (idq);
ALTER TABLE ONLY region
    ADD CONSTRAINT "PK_region" PRIMARY KEY (idr);
ALTER TABLE ONLY reponse
    ADD CONSTRAINT "PK_reponse" PRIMARY KEY (uid, idq, zone);
ALTER TABLE ONLY source
    ADD CONSTRAINT "PK_source" PRIMARY KEY (uid, ids);
ALTER TABLE ONLY statut_inter
    ADD CONSTRAINT "PK_statut_inter" PRIMARY KEY (uid, idp, statut);
ALTER TABLE ONLY statut_natio
    ADD CONSTRAINT "PK_statut_natio" PRIMARY KEY (uid, idr, statut);
ALTER TABLE ONLY taxons
    ADD CONSTRAINT "PK_taxons" PRIMARY KEY (uid);
ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);
	
SET search_path = liste_rouge, pg_catalog;
ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);
ALTER TABLE ONLY chorologie
    ADD CONSTRAINT pk_chorologie PRIMARY KEY (uid);
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT pk_evaluation PRIMARY KEY (uid);
ALTER TABLE ONLY taxons
    ADD CONSTRAINT pk_taxon PRIMARY KEY (uid);
	
SET search_path = lsi, pg_catalog;
ALTER TABLE ONLY coor_news_tag
    ADD CONSTRAINT "PK_coor_news_tag" PRIMARY KEY (id, id_tag);
ALTER TABLE ONLY news
    ADD CONSTRAINT "PK_news" PRIMARY KEY (id);
ALTER TABLE ONLY subject
    ADD CONSTRAINT "PK_subject" PRIMARY KEY (id_subject);
ALTER TABLE ONLY tag
    ADD CONSTRAINT "PK_tag" PRIMARY KEY (id_tag);

SET search_path = referentiels, pg_catalog;
ALTER TABLE ONLY ajustmt
    ADD CONSTRAINT ajustmt_cd_ajustmt_key UNIQUE (cd_ajustmt);
ALTER TABLE ONLY ajustmt
    ADD CONSTRAINT ajustmt_pkey PRIMARY KEY (id_ajustmt);
ALTER TABLE ONLY aoo
    ADD CONSTRAINT aoo_cd_aoo_key UNIQUE (cd_aoo);
ALTER TABLE ONLY aoo
    ADD CONSTRAINT aoo_pkey PRIMARY KEY (id_aoo);
ALTER TABLE ONLY avancement
    ADD CONSTRAINT avancement_pkey PRIMARY KEY (id);
ALTER TABLE ONLY cat_a
    ADD CONSTRAINT cat_a_cd_cat_a_key UNIQUE (cd_cat_a);
ALTER TABLE ONLY cat_a
    ADD CONSTRAINT cat_a_pkey PRIMARY KEY (id_cat_a);
ALTER TABLE ONLY categorie
    ADD CONSTRAINT categorie_cd_cat_key UNIQUE (cd_cat);
ALTER TABLE ONLY categorie_final
    ADD CONSTRAINT categorie_final_cd_cat_key UNIQUE (cd_cat);
ALTER TABLE ONLY categorie_final
    ADD CONSTRAINT categorie_final_pkey PRIMARY KEY (id_cat);
ALTER TABLE ONLY categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_cat);
ALTER TABLE ONLY cbn
    ADD CONSTRAINT cbn_cd_cbn_key UNIQUE (cd_cbn);
ALTER TABLE ONLY champs
    ADD CONSTRAINT champs_pkey PRIMARY KEY (id);
ALTER TABLE ONLY champs_ref
    ADD CONSTRAINT champs_ref_pkey PRIMARY KEY (id);
ALTER TABLE ONLY chgt_cat
    ADD CONSTRAINT chgt_cat_cd_chgt_cat_key UNIQUE (cd_chgt_cat);
ALTER TABLE ONLY chgt_cat
    ADD CONSTRAINT chgt_cat_pkey PRIMARY KEY (id_chgt_cat);
ALTER TABLE ONLY crit_a1
    ADD CONSTRAINT crit_a1_cd_crit_a1_key UNIQUE (cd_crit_a1);
ALTER TABLE ONLY crit_a1
    ADD CONSTRAINT crit_a1_pkey PRIMARY KEY (id_crit_a1);
ALTER TABLE ONLY crit_a234
    ADD CONSTRAINT crit_a234_cd_crit_a234_key UNIQUE (cd_crit_a234);
ALTER TABLE ONLY crit_a234
    ADD CONSTRAINT crit_a234_pkey PRIMARY KEY (id_crit_a234);
ALTER TABLE ONLY crit_c1
    ADD CONSTRAINT crit_c1_cd_crit_c1_key UNIQUE (cd_crit_c1);
ALTER TABLE ONLY crit_c1
    ADD CONSTRAINT crit_c1_pkey PRIMARY KEY (id_crit_c1);
ALTER TABLE ONLY crit_c2
    ADD CONSTRAINT crit_c2_cd_crit_c2_key UNIQUE (cd_crit_c2);
ALTER TABLE ONLY crit_c2
    ADD CONSTRAINT crit_c2_pkey PRIMARY KEY (id_crit_c2);
ALTER TABLE ONLY droit
    ADD CONSTRAINT droit_pkey PRIMARY KEY (id);
ALTER TABLE ONLY etape
    ADD CONSTRAINT etape_pkey PRIMARY KEY (id);
ALTER TABLE ONLY indigenat
    ADD CONSTRAINT indigenat_cd_indi_key UNIQUE (cd_indi);
ALTER TABLE ONLY indigenat
    ADD CONSTRAINT indigenat_pkey PRIMARY KEY (id_indi);
ALTER TABLE ONLY liste_rouge
    ADD CONSTRAINT liste_rouge_pkey PRIMARY KEY (id_cat);
ALTER TABLE ONLY nbindiv
    ADD CONSTRAINT nbindiv_cd_nbindiv_key UNIQUE (cd_nbindiv);
ALTER TABLE ONLY nbindiv
    ADD CONSTRAINT nbindiv_pkey PRIMARY KEY (id_nbindiv);
ALTER TABLE ONLY nbloc
    ADD CONSTRAINT nbloc_cd_nbloc_key UNIQUE (cd_nbloc);
ALTER TABLE ONLY nbloc
    ADD CONSTRAINT nbloc_pkey PRIMARY KEY (id_nbloc);
ALTER TABLE ONLY cbn
    ADD CONSTRAINT pk_cbn PRIMARY KEY (id_cbn);
ALTER TABLE ONLY taxref_5
    ADD CONSTRAINT pk_cd_ref_5 PRIMARY KEY (cd_ref);
ALTER TABLE ONLY taxref_7
    ADD CONSTRAINT pk_cd_ref_7 PRIMARY KEY (cd_ref);
ALTER TABLE ONLY raison_ajust
    ADD CONSTRAINT raison_ajust_cd_raison_ajust_key UNIQUE (cd_raison_ajust);
ALTER TABLE ONLY raison_ajust
    ADD CONSTRAINT raison_ajust_pkey PRIMARY KEY (id_raison_ajust);
ALTER TABLE ONLY rang
    ADD CONSTRAINT rang_cd_rang_key UNIQUE (cd_rang);
ALTER TABLE ONLY rang
    ADD CONSTRAINT rang_pkey PRIMARY KEY (id_rang);
ALTER TABLE ONLY reduc_eff
    ADD CONSTRAINT reduc_eff_cd_reduc_eff_key UNIQUE (cd_reduc_eff);
ALTER TABLE ONLY reduc_eff
    ADD CONSTRAINT reduc_eff_pkey PRIMARY KEY (id_reduc_eff);
ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id_reg);
ALTER TABLE ONLY statut
    ADD CONSTRAINT statut_pkey PRIMARY KEY (id);
ALTER TABLE ONLY tendance_pop
    ADD CONSTRAINT tendance_pop_cd_tendance_pop_key UNIQUE (cd_tendance_pop);
ALTER TABLE ONLY tendance_pop
    ADD CONSTRAINT tendance_pop_pkey PRIMARY KEY (id_tendance_pop);
ALTER TABLE ONLY user_ref
    ADD CONSTRAINT user_ref_pkey PRIMARY KEY (idu);
	
SET search_path = refnat, pg_catalog;
ALTER TABLE ONLY discussion
    ADD CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion);
ALTER TABLE ONLY taxons
    ADD CONSTRAINT taxons_pkey PRIMARY KEY (uid);
ALTER TABLE ONLY taxref_changes_30_utf8
    ADD CONSTRAINT taxref_changes_30_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxref_changes_40_utf8
    ADD CONSTRAINT taxref_changes_40_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxref_changes_50_utf8
    ADD CONSTRAINT taxref_changes_50_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxref_changes_60_utf8
    ADD CONSTRAINT taxref_changes_60_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxref_changes_70_utf8
    ADD CONSTRAINT taxref_changes_70_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxref_changes_80_utf8
    ADD CONSTRAINT taxref_changes_80_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxrefv20_utf8
    ADD CONSTRAINT taxrefv20_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxrefv30_utf8
    ADD CONSTRAINT taxrefv30_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxrefv40_utf8
    ADD CONSTRAINT taxrefv40_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxrefv50_utf8
    ADD CONSTRAINT taxrefv50_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxrefv60_utf8
    ADD CONSTRAINT taxrefv60_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxrefv70_utf8
    ADD CONSTRAINT taxrefv70_utf8_pk PRIMARY KEY (ogc_fid);
ALTER TABLE ONLY taxrefv80_utf8
    ADD CONSTRAINT taxrefv80_utf8_pk PRIMARY KEY (ogc_fid);

SET search_path = applications, pg_catalog;
CREATE INDEX bug_id_bug_idx ON bug USING btree (id_bug);
CREATE INDEX bug_statut_idx ON bug USING btree (statut);
CREATE INDEX log_event_idx ON log USING btree (event);
CREATE INDEX log_id_log_idx ON log USING btree (id_log);
CREATE INDEX log_id_user_idx ON log USING btree (id_user);
CREATE INDEX pres_id_module_idx ON pres USING btree (id_module);
CREATE INDEX pres_id_pres_idx ON pres USING btree (id_pres);
CREATE INDEX pres_lang_idx ON pres USING btree (lang);
CREATE INDEX rubrique_id_module_idx ON rubrique USING btree (id_module);
CREATE INDEX rubrique_id_rubrique_idx ON rubrique USING btree (id_rubrique);
CREATE INDEX rubrique_lang_idx ON rubrique USING btree (lang);
CREATE INDEX suivi_id_suivi_idx ON suivi USING btree (id_suivi);
CREATE INDEX suivi_id_user_idx ON suivi USING btree (id_user);
CREATE INDEX utilisateur_id_user_idx ON utilisateur USING btree (id_user);
CREATE INDEX utilisateur_nom_idx ON utilisateur USING btree (nom);

SET search_path = catnat, pg_catalog;
CREATE INDEX taxons_cd_ref_idx ON taxons_nat USING btree (cd_ref);

SET search_path = liste_rouge, pg_catalog;
CREATE INDEX evaluation_etape_idx ON evaluation USING btree (etape);
CREATE INDEX taxons_cd_ref_idx ON taxons USING btree (cd_ref);

SET search_path = referentiels, pg_catalog;
CREATE INDEX ajustmt_cd_ajustmt_idx ON ajustmt USING btree (cd_ajustmt);
CREATE INDEX aoo_cd_aoo_idx ON aoo USING btree (cd_aoo);
CREATE INDEX categorie_cd_cat_idx ON categorie USING btree (cd_cat);
CREATE INDEX categorie_final_cd_cat_idx ON categorie_final USING btree (cd_cat);
CREATE INDEX cbn_id_cbn_idx ON cbn USING btree (id_cbn);
CREATE INDEX cd_cat_a_idx ON cat_a USING btree (cd_cat_a);
CREATE INDEX cd_crit_a1_idx ON crit_a1 USING btree (cd_crit_a1);
CREATE INDEX cd_crit_a234_idx ON crit_a234 USING btree (cd_crit_a234);
CREATE INDEX cd_crit_c1_idx ON crit_c1 USING btree (cd_crit_c1);
CREATE INDEX cd_crit_c2_idx ON crit_c2 USING btree (cd_crit_c2);
CREATE INDEX cd_raison_ajust_idx ON raison_ajust USING btree (cd_raison_ajust);
CREATE INDEX cd_reduc_eff_idx ON reduc_eff USING btree (cd_reduc_eff);
CREATE INDEX cd_tendance_pop_idx ON tendance_pop USING btree (cd_tendance_pop);
CREATE INDEX chgt_cat_cd_chgt_cat_idx ON chgt_cat USING btree (cd_chgt_cat);
CREATE INDEX indigenat_cd_indi_idx ON indigenat USING btree (cd_indi);
CREATE INDEX nbindiv_cd_nbindiv_idx ON nbindiv USING btree (cd_nbindiv);
CREATE INDEX nbloc_cd_nbloc_idx ON nbloc USING btree (cd_nbloc);
CREATE INDEX rang_cd_rang_idx ON rang USING btree (cd_rang);

SET search_path = eee, pg_catalog;
ALTER TABLE ONLY argument
    ADD CONSTRAINT "FK_argument_liste" FOREIGN KEY (ida) REFERENCES liste_argument(ida) MATCH FULL;
ALTER TABLE ONLY reponse
    ADD CONSTRAINT "FK_idq_liste_reponse" FOREIGN KEY (idq) REFERENCES liste_reponse(idq) MATCH FULL;
ALTER TABLE ONLY source
    ADD CONSTRAINT "FK_sources_liste" FOREIGN KEY (ids) REFERENCES liste_source(ids) MATCH FULL;
ALTER TABLE ONLY statut_inter
    ADD CONSTRAINT "FK_statut_inter_pays" FOREIGN KEY (idp) REFERENCES pays(idp) MATCH FULL;
ALTER TABLE ONLY statut_natio
    ADD CONSTRAINT "FK_statut_natio_region" FOREIGN KEY (idr) REFERENCES region(idr) MATCH FULL;

SET search_path = liste_rouge, pg_catalog;
ALTER TABLE ONLY taxons
    ADD CONSTRAINT "FK_indi" FOREIGN KEY (id_indi) REFERENCES referentiels.indigenat(id_indi) MATCH FULL;
ALTER TABLE ONLY chorologie
    ADD CONSTRAINT "FK_nbindiv" FOREIGN KEY (id_nbindiv) REFERENCES referentiels.nbindiv(id_nbindiv) MATCH FULL;
ALTER TABLE ONLY chorologie
    ADD CONSTRAINT "FK_nbloc" FOREIGN KEY (id_nbloc) REFERENCES referentiels.nbloc(id_nbloc) MATCH FULL;
ALTER TABLE ONLY taxons
    ADD CONSTRAINT "FK_rang" FOREIGN KEY (id_rang) REFERENCES referentiels.rang(id_rang) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT ajtm FOREIGN KEY (cd_ajustmt) REFERENCES referentiels.ajustmt(id_ajustmt) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cat1 FOREIGN KEY (cat_a1) REFERENCES referentiels.categorie(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cat234 FOREIGN KEY (cat_a234) REFERENCES referentiels.categorie(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cata FOREIGN KEY (cat_a) REFERENCES referentiels.categorie(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catb FOREIGN KEY (cat_b) REFERENCES referentiels.categorie(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catd FOREIGN KEY (cat_d) REFERENCES referentiels.categorie(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cate FOREIGN KEY (cat_e) REFERENCES referentiels.categorie(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT cateuro FOREIGN KEY (cat_euro) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catfin FOREIGN KEY (cat_fin) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catini FOREIGN KEY (cat_ini) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT catpreced FOREIGN KEY (cat_preced) REFERENCES referentiels.categorie_final(id_cat) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita1 FOREIGN KEY (crit_a1) REFERENCES referentiels.crit_a1(id_crit_a1) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita2 FOREIGN KEY (crit_a2) REFERENCES referentiels.crit_a234(id_crit_a234) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita3 FOREIGN KEY (crit_a3) REFERENCES referentiels.crit_a234(id_crit_a234) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT crita4 FOREIGN KEY (crit_a4) REFERENCES referentiels.crit_a234(id_crit_a234) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT critc1 FOREIGN KEY (crit_c1) REFERENCES referentiels.crit_c1(id_crit_c1) MATCH FULL;
ALTER TABLE ONLY evaluation
    ADD CONSTRAINT critc2 FOREIGN KEY (crit_c2) REFERENCES referentiels.crit_c2(id_crit_c2) MATCH FULL;
	
SET search_path = lsi, pg_catalog;
ALTER TABLE ONLY coor_news_tag
    ADD CONSTRAINT "FK_coor_news" FOREIGN KEY (id) REFERENCES news(id) MATCH FULL;
ALTER TABLE ONLY news
    ADD CONSTRAINT "FK_news_subject" FOREIGN KEY (id_subject) REFERENCES subject(id_subject) MATCH FULL;
ALTER TABLE ONLY coor_news_tag
    ADD CONSTRAINT "PK_coor_tag" FOREIGN KEY (id_tag) REFERENCES tag(id_tag) MATCH FULL;
	
SET search_path = referentiels, pg_catalog;
ALTER TABLE ONLY taxref_7
    ADD CONSTRAINT "FK_rang_7" FOREIGN KEY (cd_rang) REFERENCES rang(cd_rang) MATCH FULL;
ALTER TABLE ONLY taxref_5
    ADD CONSTRAINT fk_rang FOREIGN KEY (cd_rang) REFERENCES rang(cd_rang) MATCH FULL;

REVOKE ALL ON SCHEMA applications FROM PUBLIC;
REVOKE ALL ON SCHEMA applications FROM codex_admin;
GRANT ALL ON SCHEMA applications TO codex_admin;

REVOKE ALL ON SCHEMA catnat FROM PUBLIC;
REVOKE ALL ON SCHEMA catnat FROM postgres;
GRANT ALL ON SCHEMA catnat TO postgres;
GRANT ALL ON SCHEMA catnat TO codex_admin;

REVOKE ALL ON SCHEMA liste_rouge FROM PUBLIC;
REVOKE ALL ON SCHEMA liste_rouge FROM codex_admin;
GRANT ALL ON SCHEMA liste_rouge TO codex_admin;

REVOKE ALL ON SCHEMA lsi FROM PUBLIC;
REVOKE ALL ON SCHEMA lsi FROM postgres;
GRANT ALL ON SCHEMA lsi TO postgres;
GRANT ALL ON SCHEMA lsi TO PUBLIC;
GRANT ALL ON SCHEMA lsi TO codex_admin;

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;

REVOKE ALL ON SCHEMA referentiels FROM PUBLIC;
REVOKE ALL ON SCHEMA referentiels FROM codex_admin;
GRANT ALL ON SCHEMA referentiels TO codex_admin;

REVOKE ALL ON SCHEMA refnat FROM PUBLIC;
REVOKE ALL ON SCHEMA refnat FROM postgres;
GRANT ALL ON SCHEMA refnat TO postgres;
GRANT ALL ON SCHEMA refnat TO PUBLIC;

SET search_path = applications, pg_catalog;
REVOKE ALL ON TABLE bug FROM PUBLIC;
REVOKE ALL ON TABLE bug FROM codex_admin;
GRANT ALL ON TABLE bug TO codex_admin;
GRANT ALL ON TABLE bug TO postgres;

REVOKE ALL ON TABLE log FROM PUBLIC;
REVOKE ALL ON TABLE log FROM codex_admin;
GRANT ALL ON TABLE log TO codex_admin;
GRANT ALL ON TABLE log TO postgres;

REVOKE ALL ON TABLE pres FROM PUBLIC;
REVOKE ALL ON TABLE pres FROM codex_admin;
GRANT ALL ON TABLE pres TO codex_admin;
GRANT ALL ON TABLE pres TO postgres;

REVOKE ALL ON TABLE rubrique FROM PUBLIC;
REVOKE ALL ON TABLE rubrique FROM codex_admin;
GRANT ALL ON TABLE rubrique TO codex_admin;
GRANT ALL ON TABLE rubrique TO postgres;

REVOKE ALL ON TABLE suivi FROM PUBLIC;
REVOKE ALL ON TABLE suivi FROM codex_admin;
GRANT ALL ON TABLE suivi TO codex_admin;
GRANT ALL ON TABLE suivi TO postgres;

REVOKE ALL ON TABLE taxons FROM PUBLIC;
REVOKE ALL ON TABLE taxons FROM postgres;
GRANT ALL ON TABLE taxons TO postgres;
GRANT ALL ON TABLE taxons TO codex_admin;

REVOKE ALL ON TABLE utilisateur FROM PUBLIC;
REVOKE ALL ON TABLE utilisateur FROM codex_admin;
GRANT ALL ON TABLE utilisateur TO codex_admin;
GRANT ALL ON TABLE utilisateur TO postgres;

SET search_path = catnat, pg_catalog;
REVOKE ALL ON TABLE statut_nat FROM PUBLIC;
REVOKE ALL ON TABLE statut_nat FROM postgres;
GRANT ALL ON TABLE statut_nat TO postgres;
GRANT ALL ON TABLE statut_nat TO codex_admin;

REVOKE ALL ON TABLE statut_reg FROM PUBLIC;
REVOKE ALL ON TABLE statut_reg FROM postgres;
GRANT ALL ON TABLE statut_reg TO postgres;
GRANT ALL ON TABLE statut_reg TO codex_admin;

REVOKE ALL ON TABLE taxons_nat FROM PUBLIC;
REVOKE ALL ON TABLE taxons_nat FROM codex_admin;
GRANT ALL ON TABLE taxons_nat TO codex_admin;
GRANT ALL ON TABLE taxons_nat TO postgres;

SET search_path = liste_rouge, pg_catalog;
REVOKE ALL ON TABLE chorologie FROM PUBLIC;
REVOKE ALL ON TABLE chorologie FROM codex_admin;
GRANT ALL ON TABLE chorologie TO codex_admin;
GRANT ALL ON TABLE chorologie TO postgres;

REVOKE ALL ON TABLE evaluation FROM PUBLIC;
REVOKE ALL ON TABLE evaluation FROM codex_admin;
GRANT ALL ON TABLE evaluation TO codex_admin;
GRANT ALL ON TABLE evaluation TO postgres;

REVOKE ALL ON TABLE taxons FROM PUBLIC;
REVOKE ALL ON TABLE taxons FROM codex_admin;
GRANT ALL ON TABLE taxons TO codex_admin;
GRANT ALL ON TABLE taxons TO postgres;

SET search_path = lsi, pg_catalog;
REVOKE ALL ON TABLE coor_news_tag FROM PUBLIC;
REVOKE ALL ON TABLE coor_news_tag FROM postgres;
GRANT ALL ON TABLE coor_news_tag TO postgres;
GRANT ALL ON TABLE coor_news_tag TO codex_admin;

REVOKE ALL ON TABLE news FROM PUBLIC;
REVOKE ALL ON TABLE news FROM postgres;
GRANT ALL ON TABLE news TO postgres;
GRANT ALL ON TABLE news TO codex_admin;

REVOKE ALL ON TABLE subject FROM PUBLIC;
REVOKE ALL ON TABLE subject FROM postgres;
GRANT ALL ON TABLE subject TO postgres;
GRANT ALL ON TABLE subject TO codex_admin;

REVOKE ALL ON TABLE tag FROM PUBLIC;
REVOKE ALL ON TABLE tag FROM postgres;
GRANT ALL ON TABLE tag TO postgres;
GRANT ALL ON TABLE tag TO codex_admin;

SET search_path = referentiels, pg_catalog;
REVOKE ALL ON TABLE ajustmt FROM PUBLIC;
REVOKE ALL ON TABLE ajustmt FROM codex_admin;
GRANT ALL ON TABLE ajustmt TO codex_admin;
GRANT ALL ON TABLE ajustmt TO postgres;

REVOKE ALL ON TABLE aoo FROM PUBLIC;
REVOKE ALL ON TABLE aoo FROM codex_admin;
GRANT ALL ON TABLE aoo TO codex_admin;
GRANT ALL ON TABLE aoo TO postgres;

REVOKE ALL ON TABLE cat_a FROM PUBLIC;
REVOKE ALL ON TABLE cat_a FROM codex_admin;
GRANT ALL ON TABLE cat_a TO codex_admin;
GRANT ALL ON TABLE cat_a TO postgres;

REVOKE ALL ON TABLE categorie FROM PUBLIC;
REVOKE ALL ON TABLE categorie FROM codex_admin;
GRANT ALL ON TABLE categorie TO codex_admin;
GRANT ALL ON TABLE categorie TO postgres;

REVOKE ALL ON TABLE categorie_final FROM PUBLIC;
REVOKE ALL ON TABLE categorie_final FROM codex_admin;
GRANT ALL ON TABLE categorie_final TO codex_admin;
GRANT ALL ON TABLE categorie_final TO postgres;

REVOKE ALL ON TABLE cbn FROM PUBLIC;
REVOKE ALL ON TABLE cbn FROM codex_admin;
GRANT ALL ON TABLE cbn TO codex_admin;
GRANT ALL ON TABLE cbn TO postgres;

REVOKE ALL ON TABLE champs FROM PUBLIC;
REVOKE ALL ON TABLE champs FROM postgres;
GRANT ALL ON TABLE champs TO postgres;
GRANT ALL ON TABLE champs TO codex_admin;

REVOKE ALL ON TABLE champs_ref FROM PUBLIC;
REVOKE ALL ON TABLE champs_ref FROM postgres;
GRANT ALL ON TABLE champs_ref TO postgres;
GRANT ALL ON TABLE champs_ref TO codex_admin;

REVOKE ALL ON TABLE chgt_cat FROM PUBLIC;
REVOKE ALL ON TABLE chgt_cat FROM codex_admin;
GRANT ALL ON TABLE chgt_cat TO codex_admin;
GRANT ALL ON TABLE chgt_cat TO postgres;

REVOKE ALL ON TABLE crit_a1 FROM PUBLIC;
REVOKE ALL ON TABLE crit_a1 FROM codex_admin;
GRANT ALL ON TABLE crit_a1 TO codex_admin;
GRANT ALL ON TABLE crit_a1 TO postgres;

REVOKE ALL ON TABLE crit_a234 FROM PUBLIC;
REVOKE ALL ON TABLE crit_a234 FROM codex_admin;
GRANT ALL ON TABLE crit_a234 TO codex_admin;
GRANT ALL ON TABLE crit_a234 TO postgres;

REVOKE ALL ON TABLE crit_c1 FROM PUBLIC;
REVOKE ALL ON TABLE crit_c1 FROM codex_admin;
GRANT ALL ON TABLE crit_c1 TO codex_admin;
GRANT ALL ON TABLE crit_c1 TO postgres;

REVOKE ALL ON TABLE crit_c2 FROM PUBLIC;
REVOKE ALL ON TABLE crit_c2 FROM codex_admin;
GRANT ALL ON TABLE crit_c2 TO codex_admin;
GRANT ALL ON TABLE crit_c2 TO postgres;


REVOKE ALL ON TABLE indigenat FROM PUBLIC;
REVOKE ALL ON TABLE indigenat FROM codex_admin;
GRANT ALL ON TABLE indigenat TO codex_admin;
GRANT ALL ON TABLE indigenat TO postgres;

REVOKE ALL ON TABLE liste_rouge FROM PUBLIC;
REVOKE ALL ON TABLE liste_rouge FROM postgres;
GRANT ALL ON TABLE liste_rouge TO postgres;
GRANT ALL ON TABLE liste_rouge TO codex_admin;

REVOKE ALL ON TABLE nbindiv FROM PUBLIC;
REVOKE ALL ON TABLE nbindiv FROM codex_admin;
GRANT ALL ON TABLE nbindiv TO codex_admin;
GRANT ALL ON TABLE nbindiv TO postgres;

REVOKE ALL ON TABLE nbloc FROM PUBLIC;
REVOKE ALL ON TABLE nbloc FROM codex_admin;
GRANT ALL ON TABLE nbloc TO codex_admin;
GRANT ALL ON TABLE nbloc TO postgres;

REVOKE ALL ON TABLE raison_ajust FROM PUBLIC;
REVOKE ALL ON TABLE raison_ajust FROM codex_admin;
GRANT ALL ON TABLE raison_ajust TO codex_admin;
GRANT ALL ON TABLE raison_ajust TO postgres;

REVOKE ALL ON TABLE rang FROM PUBLIC;
REVOKE ALL ON TABLE rang FROM codex_admin;
GRANT ALL ON TABLE rang TO codex_admin;
GRANT ALL ON TABLE rang TO postgres;

REVOKE ALL ON TABLE reduc_eff FROM PUBLIC;
REVOKE ALL ON TABLE reduc_eff FROM codex_admin;
GRANT ALL ON TABLE reduc_eff TO codex_admin;
GRANT ALL ON TABLE reduc_eff TO postgres;

REVOKE ALL ON TABLE statut FROM PUBLIC;
REVOKE ALL ON TABLE statut FROM postgres;
GRANT ALL ON TABLE statut TO postgres;
GRANT ALL ON TABLE statut TO codex_admin;

REVOKE ALL ON TABLE tendance_pop FROM PUBLIC;
REVOKE ALL ON TABLE tendance_pop FROM codex_admin;
GRANT ALL ON TABLE tendance_pop TO codex_admin;
GRANT ALL ON TABLE tendance_pop TO postgres;

REVOKE ALL ON TABLE user_ref FROM PUBLIC;
REVOKE ALL ON TABLE user_ref FROM postgres;
GRANT ALL ON TABLE user_ref TO postgres;
GRANT ALL ON TABLE user_ref TO codex_admin;

SET search_path = refnat, pg_catalog;
REVOKE ALL ON TABLE taxons FROM PUBLIC;
REVOKE ALL ON TABLE taxons FROM postgres;
GRANT ALL ON TABLE taxons TO postgres;
GRANT ALL ON TABLE taxons TO codex_admin;

REVOKE ALL ON TABLE taxref_changes_30_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_30_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_30_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_30_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxref_changes_40_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_40_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_40_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_40_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxref_changes_50_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_50_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_50_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_50_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxref_changes_60_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_60_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_60_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_60_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxref_changes_70_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_70_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_70_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_70_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxref_changes_80_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxref_changes_80_utf8 FROM postgres;
GRANT ALL ON TABLE taxref_changes_80_utf8 TO postgres;
GRANT ALL ON TABLE taxref_changes_80_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxrefv20_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv20_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv20_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv20_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxrefv30_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv30_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv30_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv30_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxrefv40_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv40_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv40_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv40_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxrefv50_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv50_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv50_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv50_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxrefv60_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv60_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv60_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv60_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxrefv70_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv70_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv70_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv70_utf8 TO codex_admin;

REVOKE ALL ON TABLE taxrefv80_utf8 FROM PUBLIC;
REVOKE ALL ON TABLE taxrefv80_utf8 FROM postgres;
GRANT ALL ON TABLE taxrefv80_utf8 TO postgres;
GRANT ALL ON TABLE taxrefv80_utf8 TO codex_admin;

INSERT INTO referentiels.ajustmt VALUES (0, '0', '');
INSERT INTO referentiels.ajustmt VALUES (2, '-2', '(+2)');
INSERT INTO referentiels.ajustmt VALUES (1, '-1', '(+1)');
INSERT INTO referentiels.ajustmt VALUES (-2, '2', '(-2)');
INSERT INTO referentiels.ajustmt VALUES (-1, '1', '(-1)');

INSERT INTO referentiels.aoo VALUES (0, '', NULL);
INSERT INTO referentiels.aoo VALUES (1, '0', NULL);
INSERT INTO referentiels.aoo VALUES (2, '< 10', NULL);
INSERT INTO referentiels.aoo VALUES (3, '< 20', NULL);
INSERT INTO referentiels.aoo VALUES (4, '< 30', NULL);
INSERT INTO referentiels.aoo VALUES (5, '< 500', NULL);
INSERT INTO referentiels.aoo VALUES (6, '< 2 000', NULL);
INSERT INTO referentiels.aoo VALUES (7, '< 3 000', NULL);
INSERT INTO referentiels.aoo VALUES (8, '≥ 3 000', NULL);
INSERT INTO referentiels.aoo VALUES (9, 'Inconnu', NULL);

INSERT INTO referentiels.avancement VALUES (0, 0, NULL);
INSERT INTO referentiels.avancement VALUES (2, 2, 'en cours');
INSERT INTO referentiels.avancement VALUES (3, 3, 'réalisée');
INSERT INTO referentiels.avancement VALUES (1, 1, 'à réaliser');

INSERT INTO referentiels.cat_a VALUES (0, '', '');
INSERT INTO referentiels.cat_a VALUES (1, 'RE', 'Disparue au niveau régional');
INSERT INTO referentiels.cat_a VALUES (2, 'CR*', 'Disparue ?');
INSERT INTO referentiels.cat_a VALUES (3, 'CR', 'En danger critique');
INSERT INTO referentiels.cat_a VALUES (4, 'EN', 'En danger');
INSERT INTO referentiels.cat_a VALUES (5, 'VU', 'Vulnérable');
INSERT INTO referentiels.cat_a VALUES (6, 'NT', 'Quasi menacée');
INSERT INTO referentiels.cat_a VALUES (7, 'LC', 'Préoccupation mineure');
INSERT INTO referentiels.cat_a VALUES (8, 'DD', 'Données insuffisantes');
INSERT INTO referentiels.cat_a VALUES (9, 'NE', 'Non évalué');

INSERT INTO referentiels.categorie VALUES (0, '', '');
INSERT INTO referentiels.categorie VALUES (1, 'RE', 'Disparue au niveau régional');
INSERT INTO referentiels.categorie VALUES (2, 'CR*', 'Disparue ?');
INSERT INTO referentiels.categorie VALUES (3, 'CR', 'En danger critique');
INSERT INTO referentiels.categorie VALUES (4, 'EN', 'En danger');
INSERT INTO referentiels.categorie VALUES (5, 'VU', 'Vulnérable');
INSERT INTO referentiels.categorie VALUES (6, 'NT', 'Quasi menacée');
INSERT INTO referentiels.categorie VALUES (7, 'LC', 'Préoccupation mineure');
INSERT INTO referentiels.categorie VALUES (8, 'DD', 'Données insuffisantes');
INSERT INTO referentiels.categorie VALUES (9, 'NE', 'Non évalué');
INSERT INTO referentiels.categorie VALUES (10, 'NA', 'Non évaluable');

INSERT INTO referentiels.categorie_final VALUES (0, '', '');
INSERT INTO referentiels.categorie_final VALUES (1, 'RE', 'Disparue au niveau régional');
INSERT INTO referentiels.categorie_final VALUES (2, 'CR*', 'Disparue ?');
INSERT INTO referentiels.categorie_final VALUES (3, 'CR', 'En danger critique');
INSERT INTO referentiels.categorie_final VALUES (4, 'EN', 'En danger');
INSERT INTO referentiels.categorie_final VALUES (5, 'VU', 'Vulnérable');
INSERT INTO referentiels.categorie_final VALUES (6, 'NT', 'Quasi menacée');
INSERT INTO referentiels.categorie_final VALUES (7, 'LC', 'Préoccupation mineure');
INSERT INTO referentiels.categorie_final VALUES (8, 'DD', 'Données insuffisantes');
INSERT INTO referentiels.categorie_final VALUES (9, 'NE', 'Non évalué');
INSERT INTO referentiels.categorie_final VALUES (10, 'NA', 'Non évaluable');
INSERT INTO referentiels.categorie_final VALUES (11, 'EX', 'Éteinte');
INSERT INTO referentiels.categorie_final VALUES (12, 'EW', 'Disparue à l''état sauvage');

INSERT INTO referentiels.cbn VALUES (12, 'GUY', '[Guyane]');
INSERT INTO referentiels.cbn VALUES (13, 'GDE', '[Grand Est]');
INSERT INTO referentiels.cbn VALUES (14, 'GUA', '[Guadeloupe]');
INSERT INTO referentiels.cbn VALUES (15, 'MAR', '[Martinique]');
INSERT INTO referentiels.cbn VALUES (16, 'FCBN', 'FCBN');
INSERT INTO referentiels.cbn VALUES (0, 'inconnu', 'inconnu');
INSERT INTO referentiels.cbn VALUES (1, 'CBN-ALP', 'CBN Alpin');
INSERT INTO referentiels.cbn VALUES (2, 'CBN-BAL', 'CBN de Bailleul');
INSERT INTO referentiels.cbn VALUES (3, 'CBN-BRE', 'CBN de Brest');
INSERT INTO referentiels.cbn VALUES (4, 'CBN-COR', 'CBN de Corse');
INSERT INTO referentiels.cbn VALUES (5, 'CBN-FRC', 'CBN de Franche-Comté');
INSERT INTO referentiels.cbn VALUES (6, 'CBN-PMP', 'CBN des Pyrénées et de Midi-Pyrénées');
INSERT INTO referentiels.cbn VALUES (7, 'CBN-BPA', 'CBN du Bassin Parisien');
INSERT INTO referentiels.cbn VALUES (8, 'CBN-MCE', 'CBN du Massif central');
INSERT INTO referentiels.cbn VALUES (9, 'CBN-MED', 'CBN Méditerranéen de Porquerolles');
INSERT INTO referentiels.cbn VALUES (10, 'CBN-SAT', 'CBN Sud-Atlantique');
INSERT INTO referentiels.cbn VALUES (11, 'CBN-MAS', 'CBN Mascarin');

INSERT INTO referentiels.champs VALUES (31, 'eee', 'idp', 'val', 'Présence à l''internationale', 'statut_inter_pres', 'pays', NULL, NULL, true, NULL, 'idp_pres', true, 'statut_inter');
INSERT INTO referentiels.champs VALUES (33, 'eee', 'idp', 'val', 'Statut invasive avérée à l''international', 'statut_inter_invav', 'pays', NULL, NULL, true, NULL, 'idp_invav', true, 'statut_inter');
INSERT INTO referentiels.champs VALUES (32, 'eee', 'idp', 'val', 'Indigénat à l''internationale', 'statut_inter_indig', 'pays', NULL, NULL, true, NULL, 'idp_indig', true, 'statut_inter');
INSERT INTO referentiels.champs VALUES (45, 'eee', 'ids', 'val', 'Source - viabilité des graines et reproduction', 'liste_source_5', NULL, NULL, NULL, true, NULL, 'ids5', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (44, 'eee', 'ids', 'val', 'Source - indigénat en France', 'liste_source_4', NULL, NULL, NULL, true, NULL, 'ids4', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (43, 'eee', 'ids', 'val', 'Source - présence en France', 'liste_source_3', NULL, NULL, NULL, true, NULL, 'ids3', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (41, 'eee', 'ids', 'val', 'Source - présence international', 'liste_source_1', NULL, NULL, NULL, true, NULL, 'ids1', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (53, 'eee', 'ids', 'val', 'Source - densité de la population', 'liste_source_13', NULL, NULL, NULL, true, NULL, 'ids13', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (52, 'eee', 'ids', 'val', 'Source - habitat espèce', 'liste_source_12', NULL, NULL, NULL, true, NULL, 'ids12', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (51, 'eee', 'ids', 'val', 'Source - taxonomie', 'liste_source_11', NULL, NULL, NULL, true, NULL, 'ids11', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (86, 'lr', 'nbm5_post1990', 'int', 'Nb maille après 1990(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbm5_post1990', false, 'chorologie');
INSERT INTO referentiels.champs VALUES (87, 'lr', 'nbm5_post2000', 'int', 'Nb maille après 2000(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbm5_post2000', false, 'chorologie');
INSERT INTO referentiels.champs VALUES (187, 'catnat', 'type_statut', 'val', 'Statuts', 'statut', 'statut', NULL, NULL, false, 'type_statut', 'type_statut', false, 'statut');
INSERT INTO referentiels.champs VALUES (50, 'eee', 'ids', 'val', 'Source - statut invasive avérée en France', 'liste_source_10', NULL, NULL, NULL, true, NULL, 'ids10', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (38, 'eee', 'idr', 'val', 'Présence en France', 'statut_natio_pres', 'region', 3, NULL, true, 'presence', 'idr_pres', true, NULL);
INSERT INTO referentiels.champs VALUES (39, 'eee', 'idr', 'val', 'Indigénat en France', 'statut_natio_indig', 'region', NULL, NULL, true, NULL, 'idr_indig', true, NULL);
INSERT INTO referentiels.champs VALUES (185, 'catnat', 'indi', 'string', 'Indigenat', 'statut_nat', 'indigenat', 6, NULL, true, 'indi', 'indi', true, 'statut_nat');
INSERT INTO referentiels.champs VALUES (188, 'catnat', 'id_statut', 'string', 'Indigénat régional', 'statut_reg', NULL, NULL, NULL, true, 'statut_INDI', 'statut_INDI', true, 'statut_reg');
INSERT INTO referentiels.champs VALUES (192, 'catnat', 'id_statut', 'string', 'Liste rouge régionale', 'statut_reg', NULL, NULL, NULL, true, 'statut_LR', 'statut_LR', true, 'statut_reg');
INSERT INTO referentiels.champs VALUES (193, 'catnat', 'id_statut', 'string', 'Présence régionale', 'statut_reg', NULL, NULL, NULL, true, 'statut_PRES', 'statut_PRES', true, 'statut_reg');
INSERT INTO referentiels.champs VALUES (89, 'lr', 'nbcommune', 'int', 'Nb commune après 1990(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbcommune', false, 'chorologie');
INSERT INTO referentiels.champs VALUES (194, 'catnat', 'id_statut', 'string', 'Endemisme régionale', 'statut_reg', NULL, NULL, NULL, true, 'statut_END', 'statut_END', true, 'statut_reg');
INSERT INTO referentiels.champs VALUES (190, 'catnat', 'presence', 'string', 'Présence', 'statut_nat', NULL, NULL, NULL, true, 'presence', 'presence', true, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (1, 'lr', 'etape', 'val', 'Etape évaluation', 'evaluation', 'etape', 0, NULL, true, 'etape', 'etape', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (49, 'eee', 'ids', 'val', 'Source - statut invasive avérée international', 'liste_source_9', NULL, NULL, NULL, true, NULL, 'ids9', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (48, 'eee', 'ids', 'val', 'Source - type biologique', 'liste_source_8', NULL, NULL, NULL, true, NULL, 'ids8', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (47, 'eee', 'ids', 'val', 'Source - mode de dispersion', 'liste_source_7', NULL, NULL, NULL, true, NULL, 'ids7', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (46, 'eee', 'ids', 'val', 'Source - croissance végétative', 'liste_source_6', NULL, NULL, NULL, true, NULL, 'ids6', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (186, 'catnat', 'cd_rang', 'val', 'Rang', 'taxons_nat', 'rang', 3, NULL, true, 'cd_rang', 'cd_rang', false, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (153, 'eee', 'commentaire', 'string', 'Commentaire', 'taxons', NULL, NULL, NULL, true, NULL, 'commentaire', true, 'taxons');
INSERT INTO referentiels.champs VALUES (102, 'lr', 'declin_cont_iv', 'bool', 'Déclin continu(Nb Loc)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_iv', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (101, 'lr', 'declin_cont_ii', 'bool', 'Déclin continu(AOO)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_ii', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (61, 'eee', 'ida', 'val', 'Argument - densité de la population', 'liste_argument_13', NULL, NULL, NULL, true, NULL, 'ida13', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (109, 'lr', 'reduc_eff_precis', 'int', 'Réduction de l''effectif(précis)', 'chorologie', NULL, NULL, NULL, true, NULL, 'reduc_eff_precis', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (83, 'lr', 'menace', 'bool', 'Menace', 'evaluation', NULL, NULL, NULL, true, NULL, 'menace', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (147, 'eee', 'eval_expert', 'string', 'Évaluation experte', 'evaluation', NULL, 15, NULL, true, 'eval_expert', 'eval_expert', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (60, 'eee', 'ida', 'val', 'Argument - habitat espèce', 'liste_argument_12', NULL, NULL, NULL, true, NULL, 'ida12', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (152, 'eee', 'eval_tot', 'val', 'Évaluation finale', 'evaluation', NULL, 10, NULL, true, 'eval_tot', 'eval_tot', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (144, 'eee', 'liste_eval', 'val', 'Liste évaluation eee', 'evaluation', NULL, 12, NULL, true, 'liste_eval', 'liste_eval', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (149, 'eee', 'ind_b', 'int', 'Score weber risque propagation', 'evaluation', NULL, 7, NULL, true, 'ind_b', 'ind_b', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (146, 'eee', 'carac_avere', 'val', 'caractère invasive avérée', 'evaluation', NULL, 14, NULL, true, 'carac_avere', 'carac_avere', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (191, 'catnat', 'nom_reg', 'string', 'Nom de la région', 'statut_reg', 'region', NULL, NULL, true, 'nom_reg', 'nom_reg', true, 'statut_reg');
INSERT INTO referentiels.champs VALUES (104, 'lr', 'fluct_extrem_iv', 'bool', 'Fluctuation extrême(Nb Loc)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_iv', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (103, 'lr', 'fluct_extrem_ii', 'bool', 'Fluctuation extrême(AOO)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_ii', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (59, 'eee', 'ida', 'val', 'Argument - taxonomie', 'liste_argument_11', NULL, NULL, NULL, true, NULL, 'ida11', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (58, 'eee', 'ida', 'val', 'Argument - type biologique', 'liste_argument_8', NULL, NULL, NULL, true, NULL, 'ida8', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (150, 'eee', 'ind_c', 'int', 'Score weber risque impact', 'evaluation', NULL, 8, NULL, true, 'ind_c', 'ind_c', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (159, 'eee', 'fiab', 'bool', 'Fiabilité - taxonomie', 'fiab_11', NULL, NULL, NULL, true, NULL, 'fiab11', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (158, 'eee', 'fiab', 'bool', 'Fiabilité - habitat espèce', 'fiab_12', NULL, NULL, NULL, true, NULL, 'fiab12', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (157, 'eee', 'fiab', 'bool', 'Fiabilité - densité de la population', 'fiab_13', NULL, NULL, NULL, true, NULL, 'fiab13', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (156, 'eee', 'fiab', 'bool', 'Fiabilité - présence international', 'fiab_1', NULL, NULL, NULL, true, NULL, 'fiab1', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (155, 'eee', 'fiab', 'bool', 'Fiabilité - indigenat international', 'fiab_2', NULL, NULL, NULL, true, NULL, 'fiab2', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (154, 'eee', 'fiab', 'bool', 'Fiabilité - présence en France', 'fiab_3', NULL, NULL, NULL, true, NULL, 'fiab3', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (57, 'eee', 'ida', 'val', 'Argument - mode de dispersion', 'liste_argument_7', NULL, NULL, NULL, true, NULL, 'ida7', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (56, 'eee', 'ida', 'val', 'Argument - croissance végétative', 'liste_argument_6', NULL, NULL, NULL, true, NULL, 'ida6', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (55, 'eee', 'ida', 'val', 'Argument - viabilité des graines et reproduction', 'liste_argument_5', NULL, NULL, NULL, true, NULL, 'ida5', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (64, 'eee', 'ida', 'val', 'Argument - synthèse C (risques d''impact)', 'liste_argument_16', NULL, NULL, NULL, true, NULL, 'ida16', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (76, 'eee', 'idq', 'val', 'Reponse - Densité de population', 'liste_reponse_cg12', 'liste_reponse', NULL, NULL, true, NULL, 'cg12', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (71, 'eee', 'idq', 'val', 'Reponse - Croissance végétative', 'liste_reponse_bg6', 'liste_reponse', NULL, NULL, true, NULL, 'bg6', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (189, 'catnat', 'uid', 'int', 'Identifiant unique', 'taxons_nat', NULL, NULL, NULL, true, 'uid', 'uid', false, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (69, 'eee', 'idq', 'val', 'Reponse - Etendue de sa répartition au niveau mondial', 'liste_reponse_ag4', 'liste_reponse', NULL, NULL, true, NULL, 'ag4', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (68, 'eee', 'idq', 'val', 'Distribution géographique en Europe', 'liste_reponse_ag3', 'liste_reponse', NULL, NULL, true, NULL, 'ag3', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (67, 'eee', 'idq', 'val', 'Reponse - Statut de l''espèce en Europe', 'liste_reponse_ag2', 'liste_reponse', NULL, NULL, true, NULL, 'ag2', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (66, 'eee', 'idq', 'val', 'Reponse - Correspondance climatique', 'liste_reponse_ag1', 'liste_reponse', NULL, NULL, true, NULL, 'ag1', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (160, 'eee', 'fiab', 'bool', 'Fiabilité - statut invasive avérée en France', 'fiab_10', NULL, NULL, NULL, true, NULL, 'fiab10', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (42, 'eee', 'ids', 'val', 'Source - indigenat international', 'liste_source_2', NULL, NULL, NULL, true, NULL, 'ids2', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (63, 'eee', 'ida', 'val', 'Argument - synthèse B (risques de propagation)', 'liste_argument_15', NULL, NULL, NULL, true, NULL, 'ida15', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (19, 'lr', 'cat_synt_reg', 'val', 'Catégorie  Synthèse régionale', 'evaluation', 'categorie_final', 18, NULL, true, 'cat_synt_reg', 'cat_synt_reg', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (18, 'lr', 'cat_euro', 'val', 'Catégorie Europe', 'evaluation', 'categorie_final', 17, NULL, true, 'cat_euro', 'cat_euro', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (179, 'catnat', 'endemisme', 'bool', 'Endemisme', 'statut_nat', NULL, 9, NULL, true, 'endemisme', 'endemisme', true, 'statut_nat');
INSERT INTO referentiels.champs VALUES (167, 'eee', 'ind_tot', 'int', 'Score de Weber', 'evaluation', NULL, 9, NULL, true, 'ind_tot', 'ind_tot', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (16, 'lr', 'cat_fin', 'val', 'Catégorie Nationale finale', 'evaluation', 'categorie_final', 15, NULL, true, 'cat_fin', 'cat_fin', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (182, 'eee', 'gbif_url', 'string', 'URL données GBIF', 'taxons', NULL, 16, NULL, true, 'gbif_url', 'gbif_url', true, 'taxons');
INSERT INTO referentiels.champs VALUES (125, 'lr', 'cat_c2', 'val', 'Catégorie C2', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_c2', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (22, 'lr', 'avancement', 'val', 'Avancement évaluation', 'evaluation', 'avancement', 21, NULL, true, 'avancement', 'avancement', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (7, 'lr', 'endemisme', 'bool', 'Endemisme', 'taxons', NULL, 6, NULL, true, 'endemisme', 'endemisme', true, 'taxons');
INSERT INTO referentiels.champs VALUES (12, 'lr', 'cat_a', 'val', 'Catégorie A', 'evaluation', 'categorie_final', 11, NULL, true, 'cat_a', 'cat_a', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (28, 'lr', 'cat_a1', 'val', 'Catégorie A1', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_a1', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (27, 'lr', 'cat_a234', 'val', 'Catégorie A2, A3 et A4', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_a234', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (23, 'lr', 'cat_ini', 'val', 'Catégorie Nationale initiale', 'evaluation', 'categorie_final', NULL, NULL, true, NULL, 'cat_ini', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (62, 'eee', 'ida', 'val', 'Argument - synthèse A (risques introduction et installation)', 'liste_argument_14', NULL, NULL, NULL, true, NULL, 'ida14', true, 'liste_argument');
INSERT INTO referentiels.champs VALUES (26, 'lr', 'cat_d2', 'val', 'Catégorie D2', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_d2', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (15, 'lr', 'cat_d', 'val', 'Catégorie D', 'evaluation', 'categorie_final', 14, NULL, true, 'cat_d', 'cat_d', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (14, 'lr', 'cat_c', 'val', 'Catégorie C', 'evaluation', 'categorie_final', 13, NULL, true, 'cat_c', 'cat_c', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (13, 'lr', 'cat_b', 'val', 'Catégorie B', 'evaluation', 'categorie_final', 12, NULL, true, 'cat_b', 'cat_b', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (75, 'eee', 'idq', 'val', 'Reponse - Habitats de l''espèce', 'liste_reponse_cg11', 'liste_reponse', NULL, NULL, true, NULL, 'cg11', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (21, 'lr', 'notes', 'string', 'Notes', 'evaluation', NULL, 20, NULL, true, 'notes', 'notes', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (17, 'lr', 'just_fin', 'string', 'Justification évaluation nationale', 'evaluation', NULL, 16, NULL, true, 'just_fin', 'just_fin', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (74, 'eee', 'idq', 'val', 'Reponse - Taxonomie', 'liste_reponse_cg10', 'liste_reponse', NULL, NULL, true, NULL, 'cg10', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (73, 'eee', 'idq', 'val', 'Reponse - Type biologique', 'liste_reponse_bg8', 'liste_reponse', NULL, NULL, true, NULL, 'bg8', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (72, 'eee', 'idq', 'val', 'Reponse - Mode de dispersion', 'liste_reponse_bg7', 'liste_reponse', NULL, NULL, true, NULL, 'bg7', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (166, 'eee', 'fiab', 'bool', 'Fiabilité - indigénat en France', 'fiab_4', NULL, NULL, NULL, true, NULL, 'fiab4', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (165, 'eee', 'fiab', 'bool', 'Fiabilité - viabilité des graines et reproduction', 'fiab_5', NULL, NULL, NULL, true, NULL, 'fiab5', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (164, 'eee', 'fiab', 'bool', 'Fiabilité - croissance végétative', 'fiab_6', NULL, NULL, NULL, true, NULL, 'fiab6', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (163, 'eee', 'fiab', 'bool', 'Fiabilité - mode de dispersion', 'fiab_7', NULL, NULL, NULL, true, NULL, 'fiab7', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (162, 'eee', 'fiab', 'bool', 'Fiabilité - type biologique', 'fiab_8', NULL, NULL, NULL, true, NULL, 'fiab8', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (161, 'eee', 'fiab', 'bool', 'Fiabilité - statut invasive avérée international', 'fiab_9', NULL, NULL, NULL, true, NULL, 'fiab9', true, 'liste_source');
INSERT INTO referentiels.champs VALUES (176, 'catnat', 'lr', 'string', 'Liste rouge', 'statut_nat', NULL, 7, NULL, true, 'lr', 'lr', true, 'statut_nat');
INSERT INTO referentiels.champs VALUES (178, 'catnat', 'rarete', 'string', 'Indice de rarete', 'statut_nat', NULL, 8, NULL, true, 'rarete', 'rarete', true, 'statut_nat');
INSERT INTO referentiels.champs VALUES (168, 'eee', 'idr', 'int', 'Echelle de Lavergne', 'statut_inter_lavergne', NULL, 5, NULL, true, 'lavergne', 'idr', true, 'statut_natio');
INSERT INTO referentiels.champs VALUES (77, 'eee', 'idq', 'val', 'Reponse - Mauvaise herbe agricole ailleurs', 'liste_reponse_cg9', 'liste_reponse', NULL, NULL, true, NULL, 'cg9', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (70, 'eee', 'idq', 'val', 'Reponse - Viabilité des graines et reproduction', 'liste_reponse_bg5', 'liste_reponse', NULL, NULL, true, NULL, 'bg5', true, 'liste_reponse');
INSERT INTO referentiels.champs VALUES (40, 'eee', 'idr', 'val', 'Statut invasive avérée en France', 'statut_natio_invav', 'region', 4, NULL, true, 'invav', 'idr_invav', true, NULL);
INSERT INTO referentiels.champs VALUES (151, 'eee', 'fiab_tot', 'int', 'Fiabilité totale', 'evaluation', NULL, 11, NULL, true, 'fiab_tot', 'fiab_tot', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (8, 'lr', 'aoo4', 'int', 'AOO 4km²', 'chorologie', NULL, 7, NULL, true, 'aoo4', 'aoo4', false, 'chorologie');
INSERT INTO referentiels.champs VALUES (20, 'lr', 'nb_reg_evalue', 'int', 'Nb régions évaluées', 'evaluation', NULL, 19, NULL, true, 'nb_reg_evalue', 'nb_reg_evalue', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (6, 'lr', 'id_indi', 'val', 'Indigenat', 'taxons', 'indigenat', 5, NULL, true, 'id_indi', 'id_indi', true, 'taxons');
INSERT INTO referentiels.champs VALUES (145, 'eee', 'carac_emerg', 'val', 'caractère émergent', 'evaluation', NULL, 13, NULL, true, 'carac_emerg', 'carac_emerg', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (106, 'lr', 'id_nbindiv', 'val', 'Nb individus(intervalle)', 'chorologie', 'nbindiv', NULL, NULL, true, NULL, 'id_nbindiv', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (9, 'lr', 'aoo_precis', 'int', 'AOO estimé', 'chorologie', NULL, 8, NULL, true, 'aoo_precis', 'aoo_precis', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (148, 'eee', 'ind_a', 'int', 'Score weber risque introduction installation', 'evaluation', NULL, 6, NULL, true, 'ind_a', 'ind_a', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (136, 'lr', 'just_preced', 'string', 'Justification précédente', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_preced', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (137, 'lr', 'just_euro', 'string', 'Justification évaluation européene', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_euro', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (173, 'catnat', 'nom_vern', 'string', 'Nom vernaculaire', 'taxons_nat', NULL, 4, NULL, true, 'nom_vern', 'nom_vern', false, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (169, 'catnat', 'famille', 'string', 'Famille taxon', 'taxons_nat', NULL, 1, NULL, true, 'famille', 'famille', false, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (174, 'catnat', 'hybride', 'bool', 'Hybride', 'taxons_nat', NULL, 5, NULL, true, 'hybride', 'hybride', false, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (171, 'catnat', 'nom_sci', 'string', 'Nom scientifique', 'taxons_nat', NULL, 2, NULL, true, 'nom_sci', 'nom_sci', false, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (88, 'lr', 'nbm5_total', 'int', 'Nb maille total(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbm5_total', false, 'chorologie');
INSERT INTO referentiels.champs VALUES (11, 'lr', 'nbm5_post1990_est', 'int', 'Nb de maille après 1990', 'chorologie', NULL, 10, NULL, true, 'nbm5_post1990_est', 'nbm5_post1990_est', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (10, 'lr', 'nbloc_precis', 'int', 'Nb de localité(s)', 'chorologie', NULL, 9, NULL, true, 'nbloc_precis', 'nbloc_precis', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (85, 'lr', 'id_nbloc', 'val', 'Nb localité(intervalle)', 'chorologie', 'nbloc', NULL, NULL, true, NULL, 'id_nbloc', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (90, 'lr', 'just_a', 'string', 'Justification critère A', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_a', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (93, 'lr', 'just_d', 'string', 'Justification critère D', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_d', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (92, 'lr', 'just_c', 'string', 'Justification critère C', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_c', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (91, 'lr', 'just_b', 'string', 'Justification critère B', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_b', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (94, 'lr', 'just_e', 'string', 'Justification critère E', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_e', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (134, 'lr', 'just_ini', 'string', 'Justification initiale', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_ini', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (140, 'lr', 'commentaire', 'string', 'Commentaire', 'evaluation', NULL, NULL, NULL, true, NULL, 'commentaire', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (84, 'lr', 'id_aoo', 'val', 'AOO(intervalle)', 'chorologie', 'aoo', NULL, NULL, true, NULL, 'id_aoo', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (128, 'lr', 'crit_d1', 'string', 'Critère D1', 'evaluation', NULL, NULL, NULL, true, NULL, 'crit_d1', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (96, 'lr', 'limite_aire', 'bool', 'Taxon en limite d''aire', 'taxons', NULL, NULL, NULL, true, NULL, 'limite_aire', true, 'taxons');
INSERT INTO referentiels.champs VALUES (113, 'lr', 'declin_cont_iii', 'bool', 'Déclin continu(habitat)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_iii', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (112, 'lr', 'declin_cont_v', 'bool', 'Déclin continu(individus)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_v', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (111, 'lr', 'declin_cont_i', 'bool', 'Déclin continu(sous population)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_i', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (108, 'lr', 'immigration', 'bool', 'Immigration', 'chorologie', NULL, NULL, NULL, true, NULL, 'immigration', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (107, 'lr', 'pop_transfront', 'bool', 'Population transfrontalière', 'chorologie', NULL, NULL, NULL, true, NULL, 'pop_transfront', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (105, 'lr', 'nbindiv_precis', 'bool', 'Nb individus(précis)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbindiv_precis', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (100, 'lr', 'fragmt_sev', 'bool', 'Fragmentation sévère', 'chorologie', NULL, NULL, NULL, true, NULL, 'fragmt_sev', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (141, 'lr', 'just_synt_reg', 'string', 'Synthèse des justification régionales', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_synt_reg', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (98, 'lr', 'sous_obs', 'bool', 'Taxon sous-observé en métropole', 'taxons', NULL, NULL, NULL, true, NULL, 'sous_obs', true, 'taxons');
INSERT INTO referentiels.champs VALUES (97, 'lr', 'aire_disjointe', 'bool', 'Taxon en aire disjointe', 'taxons', NULL, NULL, NULL, true, NULL, 'aire_disjointe', true, 'taxons');
INSERT INTO referentiels.champs VALUES (138, 'lr', 'cd_ajustmt', 'val', 'Ajustement évaluation', 'evaluation', 'ajustmt', NULL, NULL, true, NULL, 'cd_ajustmt', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (127, 'lr', 'cat_d1', 'val', 'Catégorie D1', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_d1', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (123, 'lr', 'cat_c1', 'val', 'Catégorie C1', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_c1', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (131, 'lr', 'cat_e', 'val', 'Catégorie E', 'evaluation', 'categorie_final', NULL, NULL, true, NULL, 'cat_e', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (118, 'lr', 'crit_a1', 'val', 'Critère A1', 'evaluation', 'crit_a1', NULL, NULL, true, NULL, 'crit_a1', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (120, 'lr', 'crit_a2', 'val', 'Critère A2', 'evaluation', 'crit_a234', NULL, NULL, true, NULL, 'crit_a2', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (121, 'lr', 'crit_a3', 'val', 'Critère A3', 'evaluation', 'crit_a234', NULL, NULL, true, NULL, 'crit_a3', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (122, 'lr', 'crit_a4', 'val', 'Critère A4', 'evaluation', 'crit_a234', NULL, NULL, true, NULL, 'crit_a4', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (124, 'lr', 'crit_c1', 'val', 'Critère C1', 'evaluation', 'crit_c1', NULL, NULL, true, NULL, 'crit_c1', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (126, 'lr', 'crit_c2', 'val', 'Critère C2', 'evaluation', 'crit_c2', NULL, NULL, true, NULL, 'crit_c2', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (114, 'lr', 'id_tendance_pop', 'val', 'Tendance de la population', 'chorologie', 'tendance_pop', NULL, NULL, true, NULL, 'id_tendance_pop', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (130, 'lr', 'crit_d2', 'string', 'Critère D2', 'evaluation', NULL, NULL, NULL, true, NULL, 'crit_d2', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (116, 'lr', 'fluct_extrem_v', 'bool', 'Fluctuation extrême(individus)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_v', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (115, 'lr', 'fluct_extrem_iii', 'bool', 'Fluctuation extrême(sous population)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_iii', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (110, 'lr', 'id_reduc_eff', 'val', 'Réduction de l''effectif(intervalle)', 'chorologie', 'reduc_eff', NULL, NULL, true, NULL, 'id_reduc_eff', true, 'chorologie');
INSERT INTO referentiels.champs VALUES (143, 'lr', 'aoo1', 'int', 'AOO(1km²)', 'chorologie', NULL, NULL, NULL, true, NULL, 'aoo1', false, 'chorologie');
INSERT INTO referentiels.champs VALUES (135, 'lr', 'cat_preced', 'val', 'Catégorie précédente', 'evaluation', 'categorie_final', NULL, NULL, true, NULL, 'cat_preced', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (142, 'lr', 'nb_reg_presence', 'int', 'Nombre de régions où le taxon est présent', 'evaluation', NULL, NULL, NULL, true, NULL, 'nb_reg_presence', false, 'evaluation');
INSERT INTO referentiels.champs VALUES (139, 'lr', 'id_raison_ajust', 'val', 'Explication ajustement évaluation', 'evaluation', 'raison_ajust', NULL, NULL, true, NULL, 'id_raison_ajust', true, 'evaluation');
INSERT INTO referentiels.champs VALUES (198, 'defaut', 'info_int', 'int', 'Entier', 'base', NULL, 3, NULL, true, 'info_int', 'info_int', true, 'base');
INSERT INTO referentiels.champs VALUES (199, 'defaut', 'info_bool', 'bool', 'booléen', 'base', NULL, 4, NULL, true, 'info_bool', 'info_bool', true, 'base');
INSERT INTO referentiels.champs VALUES (440, 'droit_lr', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (441, 'droit_lr', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (442, 'droit_lr', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (443, 'droit_lr', 'id_cbn', 'string', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (2, 'lr', 'famille', 'string', 'Famille taxon', 'taxons', NULL, 1, NULL, true, 'famille', 'famille', false, 'taxons');
INSERT INTO referentiels.champs VALUES (95, 'lr', 'nom_vern', 'string', 'Nom vernaculaire', 'taxons', NULL, NULL, NULL, true, NULL, 'nom_vern', false, 'taxons');
INSERT INTO referentiels.champs VALUES (195, 'defaut', 'uid', 'int', 'Identifiant unique', 'base', NULL, 0, NULL, true, 'uid', 'uid', true, 'base');
INSERT INTO referentiels.champs VALUES (196, 'defaut', 'info_text', 'string', 'Texte', 'base', NULL, 1, NULL, true, 'info_text', 'info_text', true, 'base');
INSERT INTO referentiels.champs VALUES (197, 'defaut', 'info_real', 'float', 'Reel', 'base', NULL, 2, NULL, true, 'info_real', 'info_real', true, 'base');
INSERT INTO referentiels.champs VALUES (456, 'droit_eee', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (445, 'droit_lr', 'niveau_lr', 'string', 'Niveau de droit', 'utilisateur', 'droit_lr', 4, NULL, false, 'niveau_lr', 'niveau_lr', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (451, 'droit_refnat', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (452, 'droit_refnat', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (453, 'droit_refnat', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (454, 'droit_refnat', 'id_cbn', 'string', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (99, 'lr', 'hybride', 'bool', 'Taxon hybride', 'taxons', NULL, NULL, NULL, true, NULL, 'hybride', false, 'taxons');
INSERT INTO referentiels.champs VALUES (455, 'droit_refnat', 'niveau_refnat', 'string', 'Niveau de droit', 'utilisateur', 'droit_refnat', 4, NULL, false, 'niveau_refnat', 'niveau_refnat', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (457, 'droit_eee', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (458, 'droit_eee', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (459, 'droit_eee', 'id_cbn', 'string', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (446, 'droit_catnat', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (447, 'droit_catnat', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (448, 'droit_catnat', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (449, 'droit_catnat', 'id_cbn', 'string', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (450, 'droit_catnat', 'niveau_catnat', 'string', 'Niveau de droit', 'utilisateur', 'droit_catnat', 4, NULL, false, 'niveau_catnat', 'niveau_catnat', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (460, 'droit_eee', 'niveau_eee', 'string', 'Niveau de droit', 'utilisateur', 'droit_eee', 4, NULL, false, 'niveau_eee', 'niveau_eee', false, 'utilisateur');
INSERT INTO referentiels.champs VALUES (386, 'refnat', 'uid', 'int', 'Identifiant unique', 'taxons', NULL, NULL, NULL, true, 'uid', 'uid', false, 'taxons');
INSERT INTO referentiels.champs VALUES (387, 'refnat', 'cd_nom', 'int', 'Code unique du taxon dans TAXREF', 'taxons', NULL, 0, NULL, true, 'cd_nom', 'cd_nom', true, 'taxons');
INSERT INTO referentiels.champs VALUES (388, 'refnat', 'cd_ref', 'int', 'Code de référence du taxon dans TAXREF', 'taxons', NULL, 1, NULL, true, 'cd_ref', 'cd_ref', true, 'taxons');
INSERT INTO referentiels.champs VALUES (389, 'refnat', 'cd_taxsup', 'int', 'Code de référence du taxon supérieur dans TAXREF', 'taxons', NULL, NULL, NULL, true, 'cd_taxsup', 'cd_taxsup', true, 'taxons');
INSERT INTO referentiels.champs VALUES (390, 'refnat', 'rang', 'string', 'Rang taxonomique', 'taxons', NULL, 3, NULL, true, 'rang', 'rang', true, 'taxons');
INSERT INTO referentiels.champs VALUES (391, 'refnat', 'regne', 'string', 'Regne', 'taxons', NULL, NULL, NULL, true, 'regne', 'regne', true, 'taxons');
INSERT INTO referentiels.champs VALUES (392, 'refnat', 'phylum', 'string', 'Phylum', 'taxons', NULL, NULL, NULL, true, 'phylum', 'phylum', true, 'taxons');
INSERT INTO referentiels.champs VALUES (393, 'refnat', 'classe', 'string', 'Classe', 'taxons', NULL, NULL, NULL, true, 'classe', 'classe', true, 'taxons');
INSERT INTO referentiels.champs VALUES (394, 'refnat', 'ordre', 'string', 'Ordre', 'taxons', NULL, NULL, NULL, true, 'ordre', 'ordre', true, 'taxons');
INSERT INTO referentiels.champs VALUES (395, 'refnat', 'famille', 'string', 'Famille', 'taxons', NULL, 4, NULL, true, 'famille', 'famille', true, 'taxons');
INSERT INTO referentiels.champs VALUES (396, 'refnat', 'group1_inpn', 'string', 'Groupe principal', 'taxons', NULL, NULL, NULL, true, 'group1_inpn', 'group1_inpn', true, 'taxons');
INSERT INTO referentiels.champs VALUES (397, 'refnat', 'group2_inpn', 'string', 'Groupe secondaire', 'taxons', NULL, 5, NULL, true, 'group2_inpn', 'group2_inpn', true, 'taxons');
INSERT INTO referentiels.champs VALUES (184, 'lr', 'uid', 'int', 'Identifiant unique', 'taxons', NULL, NULL, NULL, true, NULL, 'uid', false, 'taxons');
INSERT INTO referentiels.champs VALUES (3, 'lr', 'cd_ref', 'int', 'CD REF', 'taxons', NULL, 2, NULL, true, 'cd_ref', 'cd_ref', false, 'taxons');
INSERT INTO referentiels.champs VALUES (4, 'lr', 'nom_sci', 'string', 'Nom scientifique', 'taxons', NULL, 3, NULL, true, 'nom_sci', 'nom_sci', false, 'taxons');
INSERT INTO referentiels.champs VALUES (5, 'lr', 'id_rang', 'val', 'Rang', 'taxons', 'rang', 4, NULL, true, 'id_rang', 'id_rang', false, 'taxons');
INSERT INTO referentiels.champs VALUES (183, 'eee', 'uid', 'int', 'Identifiant unique', 'taxons', NULL, NULL, NULL, true, NULL, 'uid', false, 'taxons');
INSERT INTO referentiels.champs VALUES (35, 'eee', 'nom_sci', 'string', 'Nom scientifique', 'taxons', NULL, 1, NULL, true, 'nom_sci', 'nom_sci', false, 'taxons');
INSERT INTO referentiels.champs VALUES (37, 'eee', 'nom_verna', 'string', 'Nom Vernaculaire', 'taxons', NULL, NULL, NULL, true, NULL, 'nom_verna', false, 'taxons');
INSERT INTO referentiels.champs VALUES (34, 'eee', 'cd_ref', 'int', 'Code REF.', 'taxons', NULL, 0, NULL, true, 'cd_ref', 'cd_ref', false, 'taxons');
INSERT INTO referentiels.champs VALUES (170, 'catnat', 'cd_ref', 'int', 'Code REF.', 'taxons_nat', NULL, 0, NULL, true, 'cd_ref', 'cd_ref', false, 'taxons_nat');
INSERT INTO referentiels.champs VALUES (36, 'eee', 'lib_rang', 'val', 'Rang', 'taxons', 'rang', 2, NULL, true, 'lib_rang', 'lib_rang', false, 'taxons');
INSERT INTO referentiels.champs VALUES (398, 'refnat', 'lb_nom', 'string', 'Nom du taxon', 'taxons', NULL, NULL, NULL, true, 'lb_nom', 'lb_nom', true, 'taxons');
INSERT INTO referentiels.champs VALUES (399, 'refnat', 'lb_auteur', 'string', 'Autorité du taxon', 'taxons', NULL, NULL, NULL, true, 'lb_auteur', 'lb_auteur', true, 'taxons');
INSERT INTO referentiels.champs VALUES (432, 'refnat', 'modif', 'bool', 'Taxon différent de la dernière version de TAXREF', 'taxons', NULL, 14, NULL, true, 'modif', 'modif', false, 'taxons');
INSERT INTO referentiels.champs VALUES (425, 'refnat', 'pres_v2', 'bool', 'Taxon présent dans taxref v2', 'taxons', NULL, 7, NULL, true, 'pres_v2', 'pres_v2', false, 'taxons');
INSERT INTO referentiels.champs VALUES (400, 'refnat', 'nom_complet', 'string', 'Nom complet du taxon', 'taxons', NULL, 2, NULL, true, 'nom_complet', 'nom_complet', true, 'taxons');
INSERT INTO referentiels.champs VALUES (401, 'refnat', 'nom_complet_html', 'string', 'Nom complet du taxon - version html', 'taxons', NULL, NULL, NULL, true, 'nom_complet_html', 'nom_complet_html', true, 'taxons');
INSERT INTO referentiels.champs VALUES (402, 'refnat', 'nom_valide', 'string', 'Nom valide du taxon', 'taxons', NULL, NULL, NULL, true, 'nom_valide', 'nom_valide', true, 'taxons');
INSERT INTO referentiels.champs VALUES (403, 'refnat', 'nom_vern', 'string', 'Nom vernaculaire du taxon', 'taxons', NULL, NULL, NULL, true, 'nom_vern', 'nom_vern', true, 'taxons');
INSERT INTO referentiels.champs VALUES (404, 'refnat', 'nom_vern_eng', 'string', 'Nom vernaculaire anglais du taxon', 'taxons', NULL, NULL, NULL, true, 'nom_vern_eng', 'nom_vern_eng', true, 'taxons');
INSERT INTO referentiels.champs VALUES (405, 'refnat', 'habitat', 'int', 'Habitat du taxon', 'taxons', NULL, NULL, NULL, true, 'habitat', 'habitat', true, 'taxons');
INSERT INTO referentiels.champs VALUES (406, 'refnat', 'fr', 'string', 'FR', 'taxons', NULL, 6, NULL, true, 'fr', 'fr', true, 'taxons');
INSERT INTO referentiels.champs VALUES (407, 'refnat', 'gf', 'string', 'GF', 'taxons', NULL, NULL, NULL, true, 'gf', 'gf', true, 'taxons');
INSERT INTO referentiels.champs VALUES (408, 'refnat', 'mar', 'string', 'MAR', 'taxons', NULL, NULL, NULL, true, 'mar', 'mar', true, 'taxons');
INSERT INTO referentiels.champs VALUES (409, 'refnat', 'gua', 'string', 'GUA', 'taxons', NULL, NULL, NULL, true, 'gua', 'gua', true, 'taxons');
INSERT INTO referentiels.champs VALUES (410, 'refnat', 'sm', 'string', 'SM', 'taxons', NULL, NULL, NULL, true, 'sm', 'sm', true, 'taxons');
INSERT INTO referentiels.champs VALUES (411, 'refnat', 'sb', 'string', 'SB', 'taxons', NULL, NULL, NULL, true, 'sb', 'sb', true, 'taxons');
INSERT INTO referentiels.champs VALUES (412, 'refnat', 'spm', 'string', 'SPM', 'taxons', NULL, NULL, NULL, true, 'spm', 'spm', true, 'taxons');
INSERT INTO referentiels.champs VALUES (413, 'refnat', 'may', 'string', 'MAY', 'taxons', NULL, NULL, NULL, true, 'may', 'may', true, 'taxons');
INSERT INTO referentiels.champs VALUES (414, 'refnat', 'epa', 'string', 'EPA', 'taxons', NULL, NULL, NULL, true, 'epa', 'epa', true, 'taxons');
INSERT INTO referentiels.champs VALUES (415, 'refnat', 'reu', 'string', 'REU', 'taxons', NULL, NULL, NULL, true, 'reu', 'reu', true, 'taxons');
INSERT INTO referentiels.champs VALUES (416, 'refnat', 'taaf', 'string', 'TAAF', 'taxons', NULL, NULL, NULL, true, 'taaf', 'taaf', true, 'taxons');
INSERT INTO referentiels.champs VALUES (417, 'refnat', 'pf', 'string', 'PF', 'taxons', NULL, NULL, NULL, true, 'pf', 'pf', true, 'taxons');
INSERT INTO referentiels.champs VALUES (418, 'refnat', 'nc', 'string', 'NC', 'taxons', NULL, NULL, NULL, true, 'nc', 'nc', true, 'taxons');
INSERT INTO referentiels.champs VALUES (419, 'refnat', 'cli', 'string', 'CLI', 'taxons', NULL, NULL, NULL, true, 'cli', 'cli', true, 'taxons');
INSERT INTO referentiels.champs VALUES (420, 'refnat', 'url', 'string', 'URL', 'taxons', NULL, NULL, NULL, true, 'url', 'url', true, 'taxons');
INSERT INTO referentiels.champs VALUES (421, 'refnat', 'hybride', 'bool', 'Taxon hybride', 'taxons', NULL, NULL, NULL, true, 'hybride', 'hybride', true, 'taxons');
INSERT INTO referentiels.champs VALUES (422, 'refnat', 'liste_rouge', 'bool', 'Appartient au module LR', 'taxons', NULL, NULL, NULL, true, 'liste_rouge', 'liste_rouge', true, 'taxons');
INSERT INTO referentiels.champs VALUES (423, 'refnat', 'catnat', 'bool', 'Appartient au module CATNAT', 'taxons', NULL, NULL, NULL, true, 'catnat', 'catnat', true, 'taxons');
INSERT INTO referentiels.champs VALUES (424, 'refnat', 'eee', 'bool', 'Appartient au module EEE', 'taxons', NULL, NULL, NULL, true, 'eee', 'eee', true, 'taxons');
INSERT INTO referentiels.champs VALUES (426, 'refnat', 'pres_v3', 'bool', 'Taxon présent dans taxref v3', 'taxons', NULL, 8, NULL, true, 'pres_v3', 'pres_v3', false, 'taxons');
INSERT INTO referentiels.champs VALUES (427, 'refnat', 'pres_v4', 'bool', 'Taxon présent dans taxref v4', 'taxons', NULL, 9, NULL, true, 'pres_v4', 'pres_v4', false, 'taxons');
INSERT INTO referentiels.champs VALUES (428, 'refnat', 'pres_v5', 'bool', 'Taxon présent dans taxref v5', 'taxons', NULL, 10, NULL, true, 'pres_v5', 'pres_v5', false, 'taxons');
INSERT INTO referentiels.champs VALUES (429, 'refnat', 'pres_v6', 'bool', 'Taxon présent dans taxref v6', 'taxons', NULL, 11, NULL, true, 'pres_v6', 'pres_v6', false, 'taxons');
INSERT INTO referentiels.champs VALUES (430, 'refnat', 'pres_v7', 'bool', 'Taxon présent dans taxref v7', 'taxons', NULL, 12, NULL, true, 'pres_v7', 'pres_v7', false, 'taxons');
INSERT INTO referentiels.champs VALUES (431, 'refnat', 'pres_v8', 'bool', 'Taxon présent dans taxref v8', 'taxons', NULL, 13, NULL, true, 'pres_v8', 'pres_v8', false, 'taxons');

INSERT INTO referentiels.champs_ref VALUES (24, 'etape', 'cd', 'lib', 'referentiels', 'etape', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (25, 'id_indi', 'id_indi', 'cd_indi', 'referentiels', 'indigenat', NULL, 'lr');
INSERT INTO referentiels.champs_ref VALUES (2, 'indigenat', 'id_indi', 'lib_indi', 'referentiels', 'indigenat', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (1, 'rang', 'id_rang', 'lib_rang', 'referentiels', 'rang', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (12, 'raison_ajust', 'id_raison_ajust', 'lib_raison_ajust', 'referentiels', 'raison_ajust', 'id_raison_ajust', 'lr');
INSERT INTO referentiels.champs_ref VALUES (26, 'region', 'insee_reg', 'region', 'eee', 'region', '', 'catnat');
INSERT INTO referentiels.champs_ref VALUES (27, 'statut', 'type_statut', 'lib_statut', 'referentiels', 'statut', '', 'catnat');
INSERT INTO referentiels.champs_ref VALUES (28, 'indigenat', 'cd_indi', 'lib_indi', 'referentiels', 'indigenat', '', 'catnat');
INSERT INTO referentiels.champs_ref VALUES (29, 'categorie_final', 'cd_cat', 'cd_cat', 'referentiels', 'categorie_final', '', 'catnat');
INSERT INTO referentiels.champs_ref VALUES (16, 'categorie_final', 'id_cat', 'cd_cat', 'referentiels', 'categorie_final', 'id_cat', 'lr');
INSERT INTO referentiels.champs_ref VALUES (15, 'categorie', 'id_cat', 'cd_cat', 'referentiels', 'categorie', 'id_cat', 'lr');
INSERT INTO referentiels.champs_ref VALUES (14, 'tendance_pop', 'id_tendance_pop', 'lib_tendance_pop', 'referentiels', 'tendance_pop', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (13, 'chgt_cat', 'cd_chgt_cat', 'lib_chgt_cat', 'referentiels', 'chgt_cat', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (11, 'ajustmt', 'cd_ajustmt', 'lib_ajustmt', 'referentiels', 'ajustmt', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (10, 'crit_c2', 'id_crit_c2', 'cd_crit_c2', 'referentiels', 'crit_c2', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (9, 'crit_c1', 'id_crit_c1', 'cd_crit_c1', 'referentiels', 'crit_c1', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (8, 'crit_a234', 'id_crit_a234', 'cd_crit_a234', 'referentiels', 'crit_a234', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (7, 'crit_a1', 'id_crit_a1', 'cd_crit_a1', 'referentiels', 'crit_a1', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (6, 'reduc_eff', 'id_reduc_eff', 'cd_reduc_eff', 'referentiels', 'reduc_eff', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (5, 'nbindiv', 'id_nbindiv', 'cd_nbindiv', 'referentiels', 'nbindiv', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (4, 'nbloc', 'id_nbloc', 'cd_nbloc', 'referentiels', 'nbloc', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (3, 'aoo', 'id_aoo', 'cd_aoo', 'referentiels', 'aoo', 'id_aoo', 'lr');
INSERT INTO referentiels.champs_ref VALUES (17, 'pays', 'idp', 'pays', 'eee', 'pays', '', 'eee');
INSERT INTO referentiels.champs_ref VALUES (18, 'region', 'idr', 'region', 'eee', 'region', '', 'eee');
INSERT INTO referentiels.champs_ref VALUES (19, 'liste_source', 'ids', 'libelle', 'eee', 'liste_source', '', 'eee');
INSERT INTO referentiels.champs_ref VALUES (20, 'liste_argument', 'ida', 'libelle', 'eee', 'liste_argument', '', 'eee');
INSERT INTO referentiels.champs_ref VALUES (21, 'liste_question', 'code_question', 'libelle_question', 'eee', 'liste_reponse', '', 'eee');
INSERT INTO referentiels.champs_ref VALUES (22, 'liste_reponse', 'idq', 'libelle_court_reponse', 'eee', 'liste_reponse', '', 'eee');
INSERT INTO referentiels.champs_ref VALUES (30, 'avancement', 'cd', 'lib', 'referentiels', 'avancement', '', 'lr');
INSERT INTO referentiels.champs_ref VALUES (36, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_lr');
INSERT INTO referentiels.champs_ref VALUES (39, 'droit_lr', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_lr');
INSERT INTO referentiels.champs_ref VALUES (40, 'droit_catnat', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_catnat');
INSERT INTO referentiels.champs_ref VALUES (41, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_catnat');
INSERT INTO referentiels.champs_ref VALUES (42, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_refnat');
INSERT INTO referentiels.champs_ref VALUES (43, 'droit_refnat', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_refnat');
INSERT INTO referentiels.champs_ref VALUES (44, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_eee');
INSERT INTO referentiels.champs_ref VALUES (45, 'droit_eee', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_eee');
INSERT INTO referentiels.champs_ref VALUES (47, 'rang', 'cd_rang', 'lib_rang', 'referentiels', 'rang', NULL, 'catnat');
INSERT INTO referentiels.champs_ref VALUES (48, 'rang', 'cd_rang', 'lib_rang', 'referentiels', 'rang', NULL, 'eee');

INSERT INTO referentiels.chgt_cat VALUES (0, '', '');
INSERT INTO referentiels.chgt_cat VALUES (1, 'V', 'Changement véritable (V)');
INSERT INTO referentiels.chgt_cat VALUES (2, 'Nvc', 'Changement non véritable (NV) - lié à l’amélioration des connaissances (NVc)');
INSERT INTO referentiels.chgt_cat VALUES (3, 'NVt', 'Changement non véritable (NV)-  lié à un changement taxonomique (NVt)');
INSERT INTO referentiels.chgt_cat VALUES (4, 'Nve', 'Changement non véritable (NV)- lié à une erreur d’évaluation antérieure (NVe)');
INSERT INTO referentiels.chgt_cat VALUES (5, 'NVm', 'Changement non véritable (NV)- lié à un changement de la méthodologie ou des lignes directrices d’application (NVm)');
INSERT INTO referentiels.chgt_cat VALUES (6, 'Non', 'Aucun changement (Non)');

INSERT INTO referentiels.crit_a1 VALUES (0, '', NULL);
INSERT INTO referentiels.crit_a1 VALUES (1, '100%', NULL);
INSERT INTO referentiels.crit_a1 VALUES (2, '≥ 90%', NULL);
INSERT INTO referentiels.crit_a1 VALUES (3, '≥ 70%', NULL);
INSERT INTO referentiels.crit_a1 VALUES (4, '≥ 50%', NULL);
INSERT INTO referentiels.crit_a1 VALUES (5, '≥ 40%', NULL);
INSERT INTO referentiels.crit_a1 VALUES (6, '< 40%', NULL);
INSERT INTO referentiels.crit_a1 VALUES (7, 'Inconnu', NULL);

INSERT INTO referentiels.crit_a234 VALUES (0, '', NULL);
INSERT INTO referentiels.crit_a234 VALUES (1, '100%', NULL);
INSERT INTO referentiels.crit_a234 VALUES (2, '≥ 80%', NULL);
INSERT INTO referentiels.crit_a234 VALUES (3, '≥ 50%', NULL);
INSERT INTO referentiels.crit_a234 VALUES (4, '≥ 30%', NULL);
INSERT INTO referentiels.crit_a234 VALUES (5, '≥ 20%', NULL);
INSERT INTO referentiels.crit_a234 VALUES (6, '< 20%', NULL);
INSERT INTO referentiels.crit_a234 VALUES (7, 'Inconnu', NULL);

INSERT INTO referentiels.crit_c1 VALUES (0, '', NULL);
INSERT INTO referentiels.crit_c1 VALUES (1, 'Inconnu', NULL);
INSERT INTO referentiels.crit_c1 VALUES (2, '<10', NULL);
INSERT INTO referentiels.crit_c1 VALUES (3, '10 à 20', NULL);
INSERT INTO referentiels.crit_c1 VALUES (4, '20 à 25', NULL);
INSERT INTO referentiels.crit_c1 VALUES (5, '25 et plus', NULL);

INSERT INTO referentiels.crit_c2 VALUES (0, '', '');
INSERT INTO referentiels.crit_c2 VALUES (1, 'CR', 'En danger critique');
INSERT INTO referentiels.crit_c2 VALUES (2, 'EN', 'En danger');
INSERT INTO referentiels.crit_c2 VALUES (3, 'VU', 'Vulnérable');
INSERT INTO referentiels.crit_c2 VALUES (4, 'Inconnu', 'Inconnu');

INSERT INTO referentiels.droit VALUES (0, 0, 'Pas d''accès');
INSERT INTO referentiels.droit VALUES (1, 1, 'Lecteur');
INSERT INTO referentiels.droit VALUES (2, 64, 'Participant');
INSERT INTO referentiels.droit VALUES (3, 128, 'Evaluateur');
INSERT INTO referentiels.droit VALUES (4, 255, 'Administrateur');
INSERT INTO referentiels.droit VALUES (5, 512, 'Super Admin');

INSERT INTO referentiels.etape VALUES (0, 0, NULL);
INSERT INTO referentiels.etape VALUES (1, 1, 'pré-eval');
INSERT INTO referentiels.etape VALUES (2, 2, 'éval');
INSERT INTO referentiels.etape VALUES (3, 3, 'post-eval');

INSERT INTO referentiels.indigenat VALUES (0, '', '');
INSERT INTO referentiels.indigenat VALUES (1, 'I', 'Indigène');
INSERT INTO referentiels.indigenat VALUES (2, 'I?', 'Cryptogène');
INSERT INTO referentiels.indigenat VALUES (3, 'E', 'Exotique');

INSERT INTO referentiels.liste_rouge VALUES (0, '', '');
INSERT INTO referentiels.liste_rouge VALUES (1, 'EX', 'Éteinte');
INSERT INTO referentiels.liste_rouge VALUES (2, 'EW', 'Disparue à l état sauvage');
INSERT INTO referentiels.liste_rouge VALUES (3, 'RE', 'Disparue au niveau régional');
INSERT INTO referentiels.liste_rouge VALUES (4, 'CR*', 'Disparue ?');
INSERT INTO referentiels.liste_rouge VALUES (5, 'CR', 'En danger critique');
INSERT INTO referentiels.liste_rouge VALUES (6, 'EN', 'En danger');
INSERT INTO referentiels.liste_rouge VALUES (7, 'VU', 'Vulnérable');
INSERT INTO referentiels.liste_rouge VALUES (8, 'NT', 'Quasi menacée');
INSERT INTO referentiels.liste_rouge VALUES (9, 'LC', 'Préoccupation mineure');
INSERT INTO referentiels.liste_rouge VALUES (10, 'DD', 'Données insuffisantes');
INSERT INTO referentiels.liste_rouge VALUES (11, 'NE', 'Non évalué');
INSERT INTO referentiels.liste_rouge VALUES (12, 'NA', 'Non évaluable');

INSERT INTO referentiels.nbindiv VALUES (0, '', NULL);
INSERT INTO referentiels.nbindiv VALUES (1, '0', NULL);
INSERT INTO referentiels.nbindiv VALUES (2, '< 50', NULL);
INSERT INTO referentiels.nbindiv VALUES (3, '< 250', NULL);
INSERT INTO referentiels.nbindiv VALUES (4, '< 1 000', NULL);
INSERT INTO referentiels.nbindiv VALUES (5, '< 2 000', NULL);
INSERT INTO referentiels.nbindiv VALUES (6, '< 2 500', NULL);
INSERT INTO referentiels.nbindiv VALUES (7, '< 10 000', NULL);
INSERT INTO referentiels.nbindiv VALUES (8, '≤ 15 000', NULL);
INSERT INTO referentiels.nbindiv VALUES (9, '> 15 000', NULL);
INSERT INTO referentiels.nbindiv VALUES (10, 'Inconnu', NULL);

INSERT INTO referentiels.nbloc VALUES (0, '', NULL);
INSERT INTO referentiels.nbloc VALUES (1, '1', NULL);
INSERT INTO referentiels.nbloc VALUES (2, '≤ 5', NULL);
INSERT INTO referentiels.nbloc VALUES (3, '≤ 10', NULL);
INSERT INTO referentiels.nbloc VALUES (4, '≤ 15', NULL);
INSERT INTO referentiels.nbloc VALUES (5, '> 15', NULL);

INSERT INTO referentiels.raison_ajust VALUES (1, 'V', 'Changement véritable (V)');
INSERT INTO referentiels.raison_ajust VALUES (2, 'Nvc', 'Changement non véritable (NV) - lié à l’amélioration des connaissances (NVc)');
INSERT INTO referentiels.raison_ajust VALUES (3, 'NVt', 'Changement non véritable (NV)-  lié à un changement taxonomique (NVt)');
INSERT INTO referentiels.raison_ajust VALUES (4, 'Nve', 'Changement non véritable (NV)- lié à une erreur d’évaluation antérieure (NVe)');
INSERT INTO referentiels.raison_ajust VALUES (5, 'NVm', 'Changement non véritable (NV)- lié à un changement de la méthodologie ou des lignes directrices d’application (NVm)');
INSERT INTO referentiels.raison_ajust VALUES (6, 'Non', 'Aucun changement (Non)');
INSERT INTO referentiels.raison_ajust VALUES (0, '0', '');

INSERT INTO referentiels.rang VALUES (0, '', '');
INSERT INTO referentiels.rang VALUES (1, 'ES', 'espèce');
INSERT INTO referentiels.rang VALUES (2, 'SSES', 'sous-espèce');
INSERT INTO referentiels.rang VALUES (3, 'VAR', 'variété');
INSERT INTO referentiels.rang VALUES (4, 'SVAR', 'sous-variété');
INSERT INTO referentiels.rang VALUES (5, 'FO', 'forme');
INSERT INTO referentiels.rang VALUES (6, 'SSFO', 'sous-forme');
INSERT INTO referentiels.rang VALUES (7, 'RACE', 'Race');
INSERT INTO referentiels.rang VALUES (8, 'CAR', 'Cultivar');
INSERT INTO referentiels.rang VALUES (9, 'KD', 'Règne');
INSERT INTO referentiels.rang VALUES (10, 'PH', 'Phylum');
INSERT INTO referentiels.rang VALUES (11, 'CL', 'Classe');
INSERT INTO referentiels.rang VALUES (12, 'OR', 'Ordre');
INSERT INTO referentiels.rang VALUES (13, 'FM', 'Famille');
INSERT INTO referentiels.rang VALUES (14, 'GN', 'Genre');
INSERT INTO referentiels.rang VALUES (15, 'AGES', 'Agrégat');

INSERT INTO referentiels.reduc_eff VALUES (0, '', NULL);
INSERT INTO referentiels.reduc_eff VALUES (1, '100%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (2, '≥ 90%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (3, '≥ 80%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (4, '≥ 70%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (5, '≥ 50%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (6, '≥ 40%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (7, '≥ 30%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (8, '≥ 20%', NULL);
INSERT INTO referentiels.reduc_eff VALUES (9, '< 20%', NULL);

INSERT INTO referentiels.regions VALUES (1, 'Guadeloupe');
INSERT INTO referentiels.regions VALUES (2, 'Martinique');
INSERT INTO referentiels.regions VALUES (3, 'Guyane');
INSERT INTO referentiels.regions VALUES (4, 'La Réunion');
INSERT INTO referentiels.regions VALUES (6, 'Mayotte');
INSERT INTO referentiels.regions VALUES (11, 'Île-de-France');
INSERT INTO referentiels.regions VALUES (21, 'Champagne-Ardenne');
INSERT INTO referentiels.regions VALUES (22, 'Picardie');
INSERT INTO referentiels.regions VALUES (23, 'Haute-Normandie');
INSERT INTO referentiels.regions VALUES (24, 'Centre');
INSERT INTO referentiels.regions VALUES (25, 'Basse-Normandie');
INSERT INTO referentiels.regions VALUES (26, 'Bourgogne');
INSERT INTO referentiels.regions VALUES (31, 'Nord-Pas-de-Calais');
INSERT INTO referentiels.regions VALUES (41, 'Lorraine');
INSERT INTO referentiels.regions VALUES (42, 'Alsace');
INSERT INTO referentiels.regions VALUES (43, 'Franche-Comté');
INSERT INTO referentiels.regions VALUES (52, 'Pays de la Loire');
INSERT INTO referentiels.regions VALUES (53, 'Bretagne');
INSERT INTO referentiels.regions VALUES (54, 'Poitou-Charentes');
INSERT INTO referentiels.regions VALUES (72, 'Aquitaine');
INSERT INTO referentiels.regions VALUES (73, 'Midi-Pyrénées');
INSERT INTO referentiels.regions VALUES (74, 'Limousin');
INSERT INTO referentiels.regions VALUES (82, 'Rhône-Alpes');
INSERT INTO referentiels.regions VALUES (83, 'Auvergne');
INSERT INTO referentiels.regions VALUES (91, 'Languedoc-Roussillon');
INSERT INTO referentiels.regions VALUES (93, 'Provence-Alpes-Côte d''Azur');
INSERT INTO referentiels.regions VALUES (94, 'Corse');

INSERT INTO referentiels.statut VALUES (1, 'INDI', 'Indigénat');
INSERT INTO referentiels.statut VALUES (2, 'LR', 'Liste rouge');
INSERT INTO referentiels.statut VALUES (3, 'RAR', 'Rareté');
INSERT INTO referentiels.statut VALUES (4, 'END', 'Endémisme');
INSERT INTO referentiels.statut VALUES (5, 'PRES', 'Présence');

INSERT INTO referentiels.tendance_pop VALUES (0, '', '');
INSERT INTO referentiels.tendance_pop VALUES (1, 'aug', 'augmentation');
INSERT INTO referentiels.tendance_pop VALUES (2, 'dim', 'diminution');
INSERT INTO referentiels.tendance_pop VALUES (3, 'sta', 'stable');
INSERT INTO referentiels.tendance_pop VALUES (4, '?', 'inconnue');

INSERT INTO referentiels.user_ref VALUES (1, 0, 'Pas d''accès');
INSERT INTO referentiels.user_ref VALUES (2, 1, 'Lecteur');
INSERT INTO referentiels.user_ref VALUES (3, 64, 'Participant');
INSERT INTO referentiels.user_ref VALUES (4, 128, 'Evaluateur');
INSERT INTO referentiels.user_ref VALUES (5, 129, 'Référent');
INSERT INTO referentiels.user_ref VALUES (6, 255, 'Administrateur');
INSERT INTO referentiels.user_ref VALUES (7, 512, 'Super Admin');

INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (7, 'eval_eee', 'footer', 'pied de page  de la rubrique', '<p align="center">---<br></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (10, 'refnat', 'header', 'en tête de la rubrique', '<p align="left"><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]--><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]--></p><hr><p align="center"><b><span style="font-size:18px;">Rubriques Flore</span></b><br></p><p class="MsoNormal" style="text-align:left" align="center"><br style="text-align:left"></p><p class="MsoNormal" style="text-align:left" align="center">Le référentiel national TAXREF, disponible sur l’INPN,dresse la liste des noms retenus et de leurs synonymes pour tous les taxons observés en France. L’outil de la FCBN vise à identifier les besoins d’évolution et de correction de ce référentiel national.</p><p align="left"></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (9, 'catnat', 'footer', 'pied de page  de la rubrique', '<p align="center">---<br></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (12, 'lsi', 'header', 'en tête de la rubrique', '<hr><p align="center"><b><span style="font-size:18px;">Rubriques Système d''Information</span></b><br></p><p align="center">La LSI est une newletter mensuelle de veille technologique spécifique au domaine de la biodiversité. Cette rubrique permet de contribuer directement à la lettre en ajoutant et enrichissant des actualités. Elle permet également de revenir sur des actualités anciennes en utilisant les systèmes de filtre et classement des actualités.<br></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (11, 'refnat', 'footer', 'pied de page de la rubrique', '<p align="center">---<br></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (13, 'lsi', 'footer', 'pied de page de la rubrique', '<p align="center">---<br></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (5, 'eval_lr', 'footer', 'pied de page de la rubrique', '<p align="center">---<br></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (8, 'catnat', 'header', 'en tête  de la rubrique', '<p align="left"><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]--><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]-->La FCBN développe un catalogue national qui correspond à l’inventaire des taxons de la flore vasculaire présents en France métropolitaine et à l’outre-mer sur la base du référentiel taxonomique et nomenclatural national (TAXREF). Pour chaque taxon,il capitalise des informations de niveau régional relatives à leurs statuts de présence, statuts réglementaires, fréquence, catégories de menaces, catégorie de risque invasif, traits biologiques, chorologie, etc., il restitue le même type d’informations pour le niveau national.</p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (1, 'home', 'home_header', 'Header home page', '<!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin:0cm;mso-para-margin-bottom:.0001pt;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-bidi-font-family:"Times New Roman";mso-fareast-language:EN-US;}</style><![endif]--><p class="MsoNormal" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;text-align:center" align="center"><span style="font-size: 14px;" times="" new="" roman","serif";="" font-size:="" 18px;"=""><b><span style="font-size:20px;">Bienvenue sur le dispositif de partage des connaissances et d''expertises du réseau des CBN</span></b></span></p><p style="font-size: 12px;"><span style="font-size: 12px;" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" mso-fareast-language:fr"=""><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]--></span></p><p class="MsoNormal" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;text-align:left" align="left"><span style="font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";mso-fareast-language:fr"=""><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]--></span></p>Dans le cadre de son activité de centre de ressources pour les CBN et leurs partenaires,la FCBN a mis en place un outil web permettant de :<br><ul><li>partager l’état des connaissances et l’expertise sur les données descriptives des taxons de la flore (référentiels taxonomiques, catalogues national et régionaux) ;</li><li>mutualiser les évaluations régionales pour permettre aux CBN d’avoir accès à une information à une échelle nationale (listes rouges régionales, listes régionales des espèces exotiques envahissantes). ;</li><li>réaliser une évaluation nationale des taxons de la flore (liste rouge, liste des espèces exotiques envahissantes).</li></ul>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (6, 'eval_eee', 'header', 'en tête de la rubrique', '<p align="center"><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]--></p><p class="MsoNormal" style="text-align:left" align="left"><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]-->La FCBN est mandatée par le MEDDE pour établir un projet de liste nationale des espèces exotiques envahissantes. L''évaluation se base sur une analyse de risque selon le modèle de Weber &amp; Gut.</p><p align="center"></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (4, 'eval_lr', 'header', 'en tête de la rubrique', '<p align="center"><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]--></p><p class="MsoNormal" style="text-align:left" align="left"><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings>  <o:AllowPNG></o:AllowPNG> </o:OfficeDocumentSettings></xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument>  <w:View>Normal</w:View>  <w:Zoom>0</w:Zoom>  <w:TrackMoves></w:TrackMoves>  <w:TrackFormatting></w:TrackFormatting>  <w:DoNotShowRevisions></w:DoNotShowRevisions>  <w:DoNotPrintRevisions></w:DoNotPrintRevisions>  <w:DoNotShowMarkup></w:DoNotShowMarkup>  <w:DoNotShowComments></w:DoNotShowComments>  <w:DoNotShowInsertionsAndDeletions></w:DoNotShowInsertionsAndDeletions>  <w:DoNotShowPropertyChanges></w:DoNotShowPropertyChanges>  <w:HyphenationZone>21</w:HyphenationZone>  <w:PunctuationKerning></w:PunctuationKerning>  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>  <w:DoNotPromoteQF></w:DoNotPromoteQF>  <w:LidThemeOther>FR</w:LidThemeOther>  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>  <w:Compatibility>   <w:BreakWrappedTables></w:BreakWrappedTables>   <w:SnapToGridInCell></w:SnapToGridInCell>   <w:WrapTextWithPunct></w:WrapTextWithPunct>   <w:UseAsianBreakRules></w:UseAsianBreakRules>   <w:DontGrowAutofit></w:DontGrowAutofit>   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>  </w:Compatibility>  <m:mathPr>   <m:mathFont m:val="Cambria Math"></m:mathFont>   <m:brkBin m:val="before"></m:brkBin>   <m:brkBinSub m:val="--"></m:brkBinSub>   <m:smallFrac m:val="off"></m:smallFrac>   <m:dispDef></m:dispDef>   <m:lMargin m:val="0"></m:lMargin>   <m:rMargin m:val="0"></m:rMargin>   <m:defJc m:val="centerGroup"></m:defJc>   <m:wrapIndent m:val="1440"></m:wrapIndent>   <m:intLim m:val="subSup"></m:intLim>   <m:naryLim m:val="undOvr"></m:naryLim>  </m:mathPr></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"  DefSemiHidden="true" DefQFormat="false" DefPriority="99"  LatentStyleCount="267">  <w:LsdException Locked="false" Priority="0" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>  <w:LsdException Locked="false" Priority="9" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>  <w:LsdException Locked="false" Priority="10" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"></w:LsdException>  <w:LsdException Locked="false" Priority="11" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>  <w:LsdException Locked="false" Priority="22" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>  <w:LsdException Locked="false" Priority="20" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="59" SemiHidden="false"   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>  <w:LsdException Locked="false" Priority="1" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>  <w:LsdException Locked="false" Priority="34" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>  <w:LsdException Locked="false" Priority="29" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="30" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>  <w:LsdException Locked="false" Priority="60" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="61" SemiHidden="false"   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="62" SemiHidden="false"   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="63" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="64" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="65" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="66" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="67" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="68" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="69" SemiHidden="false"   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="70" SemiHidden="false"   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="71" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="72" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="73" SemiHidden="false"   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>  <w:LsdException Locked="false" Priority="19" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="21" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>  <w:LsdException Locked="false" Priority="31" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="32" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>  <w:LsdException Locked="false" Priority="33" SemiHidden="false"   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException> </w:LatentStyles></xml><![endif]--><!--[if gte mso 10]><style> /* Style Definitions */ table.MsoNormalTable{mso-style-name:"Tableau Normal";mso-tstyle-rowband-size:0;mso-tstyle-colband-size:0;mso-style-noshow:yes;mso-style-priority:99;mso-style-parent:"";mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-para-margin-top:0cm;mso-para-margin-right:0cm;mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm;text-align:justify;mso-pagination:widow-orphan;font-size:10.0pt;font-family:"Calibri","sans-serif";mso-fareast-language:EN-US;}</style><![endif]-->La FCBN est mandatée par le MEDDE pour établir un projet de liste rouge nationale des trachéophytes de métropole. L’évaluation a débuté en 2010 (environ 1100 taxons du Livre rouge tome I et II) et se poursuit sur l’ensemble des taxons du catalogue national en utilisant la méthodologie UICN.</p> ', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (3, 'home', 'public_header', 'présentation publique', '<p align="center"><span style="font-size:24px;">Cet outil est réservé à l''usage interne du réseau des CBN.<br style="font-size: 24px;"><br style="font-size: 24px;">L''accès est contrôlé par un identifiant et un mot de passe délivrés par la FCBN.</span></p>', 0);
INSERT INTO applications.pres (id_pres, id_module, page, titre, pres, lang) VALUES (2, 'home', 'home_footer', 'Footer home page', '', 0);

INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES (3, 'catnat', 1, 'saisie.png', 'Catalogue National', '', 1, '../catnat', 0);
INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES (4, 'refnat', 2, 'saisie.png', 'Référentiel taxonomique', '', 1, '../refnat', 0);
INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES (5, 'lsi', 3, 'saisie.png', 'Lettre Système Information et Géomatique', '', 1, '../lsi', 0);
INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES (1, 'eval_lr', 4, 'saisie.png', 'Liste Rouge', '', 1, '../liste-rouge', 0);
INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES (2, 'eval_eee', 5, 'saisie.png', 'Liste EEE', '', 1, '../liste-eee', 0);


SET search_path = eee, pg_catalog;
INSERT INTO liste_argument (ida, libelle) VALUES (5, 'Argument - viabilité des graines et reproduction');
INSERT INTO liste_argument (ida, libelle) VALUES (6, 'Argument - croissance végétative');
INSERT INTO liste_argument (ida, libelle) VALUES (7, 'Argument - mode de dispersion');
INSERT INTO liste_argument (ida, libelle) VALUES (8, 'Argument - type biologique');
INSERT INTO liste_argument (ida, libelle) VALUES (11, 'Argument - taxonomie');
INSERT INTO liste_argument (ida, libelle) VALUES (12, 'Argument - habitat espèce');
INSERT INTO liste_argument (ida, libelle) VALUES (13, 'Argument - densité de la population');
INSERT INTO liste_argument (ida, libelle) VALUES (16, 'Argument - synthèse C (risques d''impact)');
INSERT INTO liste_argument (ida, libelle) VALUES (15, 'Argument - synthèse B (risques de propagation)');
INSERT INTO liste_argument (ida, libelle) VALUES (14, 'Argument - synthèse A (risques introduction et installation)');
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (2, 'ag1', 'Correspondance climatique', 'La répartition géographique mondiale de cette espèce (naturelle ou zones d''introduction) n’inclut aucune des 4 zones climatiques françaises', 'répartition inclut aucune des 4 zones climatiques', 0, 'ag', 1);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (5, 'ag2', 'Statut de l''espèce en Europe', 'l''espèce est indigène en Europe (tout ou partie)', 'indigène en Europe ', 0, 'ag', 2);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (6, 'ag2', 'Statut de l''espèce en Europe', 'L’espèce est exotique dans toute l’Europe', 'exotique en Europe', 2, 'ag', 2);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (9, 'ag3', 'Distribution géographique en Europe', 'L’espèce est présente dans 1 pays d’Europe ou absente', '0 à 1 pays d''Europe', 1, 'ag', 3);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (10, 'ag3', 'Distribution géographique en Europe', 'L’espèce est présente dans 2 à 5 pays d’Europe', '2 à 5 pays d''Europe', 2, 'ag', 3);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (11, 'ag3', 'Distribution géographique en Europe', 'L’espèce est présente dans plus de 5 pays d’Europe', 'plus de 5 pays d''Europe', 3, 'ag', 3);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (15, 'ag4', 'Etendue de sa répartition au niveau mondial', 'La répartition mondiale de l’espèce (native et introduite) est limitée, elle est restreinte à une petite zone sur un continent.', 'répartition mondiale limitée', 0, 'ag', 4);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (19, 'bg5', 'Viabilité des graines et reproduction', 'L’espèce produit approximativement peu de graines ou des graines non viables', 'peu de graines ou non viables', 1, 'bg', 5);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (20, 'bg5', 'Viabilité des graines et reproduction', 'L’espèce produit approximativement beaucoup de  graines ', 'beaucoup de graines', 3, 'bg', 5);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (21, 'bg5', 'Viabilité des graines et reproduction', 'Pas de données', 'pas de données', 2, 'bg', 5);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (25, 'bg6', 'Croissance végétative', 'L''espèce n''a pas de croissance végétative', 'pas de croissance végétative', 0, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (26, 'bg6', 'Croissance végétative', 'Si c''est un arbre ou un arbuste, l''espèce est capable de drageonner ou de marcotter', 'drageonnage/marcotage (arb,arbt)', 2, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (27, 'bg6', 'Croissance végétative', 'L''espèce est bulbeuse ou un tubercule', 'bulbe/tubercule', 1, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (28, 'bg6', 'Croissance végétative', 'L''espèce développe des rhizomes ou des stolons', 'rhizomes/stolons', 4, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (29, 'bg6', 'Croissance végétative', 'L''espèce se fragmente facilement, et les fragments peuvent être dispersés et produire de nouvelles plantes', 'fragments', 4, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (30, 'bg6', 'Croissance végétative', 'Autre ou ne sait pas', 'autre ou ne sait pas', 2, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (37, 'bg7', 'Mode de dispersion', 'Fruits charnus d''un diamètre inférieur à 5 cm', 'petits fruits charnus (max 5cm)', 2, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (38, 'bg7', 'Mode de dispersion', 'Fruits charnus dépassant 10 cm de longueur ou de diamètre', 'gros fruits charnus (+10 cm)', 0, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (40, 'bg7', 'Mode de dispersion', 'Fruits secs et les graines ont développé des structures pour une dispersion par les animaux sur de longues distances (épines, crochets)', 'zoochorie des fruits secs et les graines', 4, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (41, 'bg7', 'Mode de dispersion', 'L''espèce assure sa propre dispersion des graines', 'dispersion propre', 1, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (42, 'bg7', 'Mode de dispersion', 'Il existe une dispersion sur de longues distances par l’eau', 'hydrochorie', 4, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (43, 'bg7', 'Mode de dispersion', 'Autre ou ne sait pas', 'Autre ou ne sait pas', 2, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (52, 'bg8', 'Type biologique', 'Grande annuelle (> 80 cm)', 'Grande annuelle', 2, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (53, 'bg8', 'Type biologique', 'Ligneuse', 'Ligneuse', 4, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (54, 'bg8', 'Type biologique', 'Petite herbacée vivace (< 80 cm)', 'Petite herbacée vivace', 2, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (55, 'bg8', 'Type biologique', 'Grande herbacée vivace (> 80 cm)', 'Grande herbacée vivace', 4, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (56, 'bg8', 'Type biologique', 'Aquatique flottante', 'Aquatique flottante', 4, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (1, 'ag1', 'Correspondance climatique', 'La répartition géographique mondiale de cette espèce (naturelle ou zones d''introduction) inclut au moins une des  4 zones climatiques françaises', 'répartition inclut au moins une des 4 zones climatiques', 2, 'ag', 1);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (16, 'ag4', 'Etendue de sa répartition au niveau mondial', 'La répartition mondiale de l’espèce (native et introduite) est étendue à plus de 15° de latitude ou de longitude sur un continent ou couvre plus d''un continent', 'répartition mondiale étendue', 3, 'ag', 4);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (39, 'bg7', 'Mode de dispersion', 'Fruits secs et les graines ont développé des structures pour une dispersion par le vent sur de longues distances (aigrettes, poils ou ailes)', 'anémochorie des fruits secs et les graines', 4, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (51, 'bg8', 'Type biologique', 'Petite annuelle (< 80 cm)', 'Petite annuelle', 0, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (57, 'bg8', 'Type biologique', 'Autre', 'Autre', 2, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (65, 'cg9', 'Mauvaise herbe agricole ailleurs', 'L''espèce est mentionnée au moins 3 fois dans le monde comme une EEE avérée ', 'mentionnée au moins 3 fois dans le monde', 3, 'cg', 9);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (66, 'cg9', 'Mauvaise herbe agricole ailleurs', 'L''espèce est mentionnée moins de 3 fois comme une EEE avérée dans le monde ', 'mentionnée moins de 3 fois dans le monde', 0, 'cg', 9);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (69, 'cg10', 'Taxonomie', 'L''espèce appartient à un genre connu comme envahissant et mentionné dans le GCW', 'genre connu comme envahissant', 3, 'cg', 10);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (70, 'cg10', 'Taxonomie', 'L''espèce n’appartient pas à un genre connu comme envahissant et mentionné dans le GCW', 'genre non connu comme envahissant', 0, 'cg', 10);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (73, 'cg11', 'Habitats de l''espèce', 'Lacs, rivières et bords de rivières ou ruisseaux', 'Lacs, rivières', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (74, 'cg11', 'Habitats de l''espèce', 'Tourbière ou marécage', 'Tourbière', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (75, 'cg11', 'Habitats de l''espèce', 'Prairies (humides ou sèches)', 'Prairies', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (76, 'cg11', 'Habitats de l''espèce', 'Forêts', 'Forêts', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (77, 'cg11', 'Habitats de l''espèce', 'Dunes côtières et plages de sable', 'Dunes, plages', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (78, 'cg11', 'Habitats de l''espèce', 'Côtes rocheuses et falaises maritimes', 'Côtes rocheuses et falaises', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (79, 'cg11', 'Habitats de l''espèce', 'Autre', 'Autre', 0, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (87, 'cg12', 'Densité de population', 'L''espèce apparaît en population éparse', 'population éparse', 0, 'cg', 12);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (88, 'cg12', 'Densité de population', 'L''espèce forme occasionnellement des peuplements denses', 'occasionnellement denses', 2, 'cg', 12);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (89, 'cg12', 'Densité de population', 'L''espèce forme de grands peuplements monospécifiques', 'peuplements monospécifiques', 4, 'cg', 12);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (90, 'cg12', 'Densité de population', 'Non documentée', 'Non documentée', 0, 'cg', 12);
INSERT INTO liste_source (ids, libelle) VALUES (4, 'Source - indigénat en France');
INSERT INTO liste_source (ids, libelle) VALUES (3, 'Source - présence en France');
INSERT INTO liste_source (ids, libelle) VALUES (6, 'Source - croissance végétative');
INSERT INTO liste_source (ids, libelle) VALUES (7, 'Source - mode de dispersion');
INSERT INTO liste_source (ids, libelle) VALUES (8, 'Source - type biologique');
INSERT INTO liste_source (ids, libelle) VALUES (10, 'Source - statut invasive avérée en France');
INSERT INTO liste_source (ids, libelle) VALUES (13, 'Source - densité de la population');
INSERT INTO liste_source (ids, libelle) VALUES (1, 'Source - présence international');
INSERT INTO liste_source (ids, libelle) VALUES (2, 'Source - indigenat international');
INSERT INTO liste_source (ids, libelle) VALUES (5, 'Source - viabilité des graines et reproduction');
INSERT INTO liste_source (ids, libelle) VALUES (9, 'Source - statut invasive avérée international');
INSERT INTO liste_source (ids, libelle) VALUES (11, 'Source - taxonomie');
INSERT INTO liste_source (ids, libelle) VALUES (12, 'Source - habitat espèce');
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (1, 'Asia', 'Afghanistan', NULL, NULL, 60, 74, 29, 38);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (2, 'Africa', 'Afrique du Sud', NULL, NULL, 14, 37, -46, -22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (3, 'Europe', 'Albanie', NULL, NULL, 19, 21, 39, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (4, 'Africa', 'Algérie', NULL, NULL, -8, 11, 18, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (5, 'Europe', 'Allemagne', NULL, NULL, 5.8, 15, 47, 55);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (6, 'Europe', 'Andorre', NULL, NULL, 1.4, 1.7, 42, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (7, 'Africa', 'Angola', NULL, NULL, 11, 24, -18, -4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (8, 'North America', 'Anguilla', NULL, NULL, -63, -62, 18, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (9, 'Antarctica', 'Antarctique', NULL, NULL, -18, 180, -90, -60);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (10, 'North America', 'Antigua-et-Barbuda', NULL, NULL, -61, -61, 16, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (11, 'North America', 'Antilles Néerlandaises', NULL, NULL, -69, -68, 12, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (12, 'Asia', 'Arabie Saoudite', NULL, NULL, 34, 55, 15, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (13, 'South America', 'Argentine', NULL, NULL, -73, -53, -55, -21);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (14, 'Asia', 'Arménie', NULL, NULL, 43, 46, 38, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (15, 'North America', 'Aruba', NULL, NULL, -70, -69, 12, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (16, 'Oceania', 'Atoll Johnston', NULL, NULL, -16, -16, 16, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (17, 'Oceania', 'Australie', NULL, NULL, 112, 158, -54, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (18, 'Europe', 'Autriche', NULL, NULL, 9.5, 17, 46, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (19, 'Asia', 'Azerbaïdjan', NULL, NULL, 44, 50, 38, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (20, 'North America', 'Bahamas', NULL, NULL, -78, -72, 20, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (21, 'Asia', 'Bahreïn', NULL, NULL, 50, 50, 25, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (22, 'Asia', 'Bangladesh', NULL, NULL, 88, 92, 20, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (23, 'North America', 'Barbade', NULL, NULL, -59, -59, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (24, 'Europe', 'Bélarus', NULL, NULL, 23, 32, 51, 56);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (25, 'Europe', 'Belgique', NULL, NULL, 2.5, 6.3, 49, 51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (26, 'North America', 'Belize', NULL, NULL, -89, -87, 15, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (27, 'Africa', 'Bénin', NULL, NULL, 0.7, 3.8, 6.2, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (28, 'North America', 'Bermudes', NULL, NULL, -64, -64, 32, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (29, 'Asia', 'Bhoutan', NULL, NULL, 88, 92, 26, 28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (30, 'South America', 'Bolivie', NULL, NULL, -69, -57, -22, -9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (31, 'Europe', 'Bosnie-Herzégovine', NULL, NULL, 15, 19, 42, 45);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (32, 'Africa', 'Botswana', NULL, NULL, 19, 29, -26, -17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (33, 'South America', 'Brésil', NULL, NULL, -74, -34, -33, 5.2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (34, 'Asia', 'Brunéi Darussalam', NULL, NULL, 114, 115, 4, 5);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (35, 'Europe', 'Bulgarie', NULL, NULL, 22, 28, 41, 44);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (36, 'Africa', 'Burkina Faso', NULL, NULL, -5, 2.3, 9.3, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (37, 'Africa', 'Burundi', NULL, NULL, 28, 30, -4, -2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (38, 'Asia', 'Cambodge', NULL, NULL, 102, 107, 10, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (39, 'Africa', 'Cameroun', NULL, NULL, 8.5, 16, 1.6, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (40, 'North America', 'Canada', NULL, NULL, -14, -52, 41, 83);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (41, 'Africa', 'Cap-vert', NULL, NULL, -25, -22, 14, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (42, 'South America', 'Chili', NULL, NULL, -10, -66, -55, -17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (43, 'Asia', 'Chine', NULL, NULL, 73, 134, 18, 53);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (44, 'Asia', 'Chypre', NULL, NULL, 32, 34, 34, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (45, 'Asia', 'Cisjordanie', NULL, NULL, 34, 35, 31, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (46, 'South America', 'Colombie', NULL, NULL, -81, -66, -4, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (47, 'Africa', 'Comores', NULL, NULL, 43, 44, -12, -11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (48, 'Asia', 'Corée du Nord', NULL, NULL, 124, 130, 37, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (49, 'Asia', 'Corée du Sud', NULL, NULL, 126, 129, 33, 38);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (50, 'North America', 'Costa Rica', NULL, NULL, -85, -82, 8, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (51, 'Africa', 'Côte d''Ivoire', NULL, NULL, -8, -2, 4.3, 10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (52, 'Europe', 'Croatie', NULL, NULL, 13, 19, 42, 46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (53, 'North America', 'Cuba', NULL, NULL, -84, -74, 19, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (54, 'Europe', 'Danemark', NULL, NULL, 8, 15, 54, 57);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (55, 'Africa', 'Djibouti', NULL, NULL, 41, 43, 10, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (56, 'North America', 'Dominique', NULL, NULL, -61, -61, 15, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (57, 'Africa', 'Égypte', NULL, NULL, 24, 36, 21, 31);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (58, 'North America', 'El Salvador', NULL, NULL, -90, -87, 13, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (59, 'Asia', 'Émirats Arabes Unis', NULL, NULL, 51, 56, 22, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (60, 'South America', 'Équateur', NULL, NULL, -91, -75, -5, 1.4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (61, 'Africa', 'Érythrée', NULL, NULL, 36, 43, 12, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (62, 'Europe', 'Espagne', NULL, NULL, -18, 4.3, 27, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (63, 'Europe', 'Estonie', NULL, NULL, 21, 28, 57, 59);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (64, ' Federated States of', 'États Fédérés de Micronésie', NULL, NULL, 158, 163, 5.2, 6.9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (65, 'North America', 'États-Unis', NULL, NULL, -17, 179, 18, 71);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (66, 'Africa', 'Éthiopie', NULL, NULL, 32, 47, 3.4, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (67, 'Oceania', 'Fidji', NULL, NULL, -18, 180, -19, -16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (68, 'Europe', 'Finlande', NULL, NULL, 19, 31, 59, 70);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (69, 'Europe', 'France', NULL, NULL, -4, 9.5, 41, 51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (70, 'Africa', 'Gabon', NULL, NULL, 8.7, 14, -3, 2.3);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (71, 'Africa', 'Gambie', NULL, NULL, -16, -13, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (72, 'Asia', 'Géorgie', NULL, NULL, 40, 46, 41, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (73, 'Antarctica', 'Géorgie du Sud et les Îles Sandwich du Sud', NULL, NULL, -38, -26, -58, -53);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (74, 'Africa', 'Ghana', NULL, NULL, -3, 1.2, 4.7, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (75, 'Europe', 'Gibraltar', NULL, NULL, -5, -5, 36, 36);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (76, 'Europe', 'Grèce', NULL, NULL, 19, 28, 34, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (77, 'North America', 'Grenade', NULL, NULL, -61, -61, 11, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (78, 'North America', 'Groenland', NULL, NULL, -73, -12, 59, 83);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (79, 'North America', 'Guadeloupe', NULL, NULL, -61, -61, 15, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (80, 'Oceania', 'Guam', NULL, NULL, 144, 144, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (81, 'North America', 'Guatemala', NULL, NULL, -92, -88, 13, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (82, 'Europe', 'Guernesey', NULL, NULL, -2, -2, 49, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (83, 'Africa', 'Guinée', NULL, NULL, -15, -7, 7.1, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (84, 'Africa', 'Guinée Équatoriale', NULL, NULL, 8.4, 11, 0.9, 3.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (85, 'Africa', 'Guinée-Bissau', NULL, NULL, -16, -13, 10, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (86, 'South America', 'Guyana', NULL, NULL, -61, -56, 1.1, 8.5);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (87, 'South America', 'Guyane Française', NULL, NULL, -54, -51, 2.1, 5.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (88, 'North America', 'Haïti', NULL, NULL, -74, -71, 18, 20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (89, 'North America', 'Honduras', NULL, NULL, -89, -83, 12, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (90, 'Asia', 'Hong-Kong', NULL, NULL, 114, 114, 22, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (91, 'Europe', 'Hongrie', NULL, NULL, 16, 22, 45, 48);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (92, 'Oceania', 'Île Baker', NULL, NULL, -17, -17, 0.2, 0.2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (93, 'Antarctica', 'Île Bouvet', NULL, NULL, 3.3, 3.4, -54, -54);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (94, 'Oceania', 'Île Christmas', NULL, NULL, 105, 105, -10, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (95, 'Europe', 'Île de Man', NULL, NULL, -4, -4, 54, 54);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (96, 'Oceania', 'Île Howland', NULL, NULL, -17, -17, 0.7, 0.8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (97, 'North America', 'Île Jan Mayen', NULL, NULL, -9, -7, 70, 71);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (98, 'Oceania', 'Île Jarvis', NULL, NULL, -16, -16, 0, 0);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (99, 'Africa', 'Île Juan de Nova', NULL, NULL, 42, 42, -17, -17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (100, 'Oceania', 'Île Norfolk', NULL, NULL, 167, 167, -29, -29);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (101, 'Oceania', 'Île Pitcairn', NULL, NULL, -13, -12, -25, -24);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (102, 'Oceania', 'Île Wake', NULL, NULL, 166, 166, 19, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (103, 'South America', 'Îles (malvinas) Falkland', NULL, NULL, -61, -57, -52, -51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (104, 'Europe', 'Îles Åland', NULL, NULL, 19, 21, 59, 60);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (105, 'North America', 'Îles Caïmanes', NULL, NULL, -81, -81, 19, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (106, 'Oceania', 'Îles Cocos (Keeling)', NULL, NULL, 96, 96, -12, -12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (107, 'Oceania', 'Îles Cook', NULL, NULL, -16, -15, -21, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (108, 'Europe', 'Îles Féroé', NULL, NULL, -7, -6, 61, 62);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (109, 'Africa', 'Îles Glorieuses', NULL, NULL, 47, 47, -11, -11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (110, 'Antarctica', 'Îles Heard et Mcdonald', NULL, NULL, 73, 73, -53, -52);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (111, 'Oceania', 'Îles Mariannes du Nord', NULL, NULL, 145, 145, 14, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (112, 'Oceania', 'Îles Marshall', NULL, NULL, 162, 169, 5.6, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (113, 'Oceania', 'Îles Midway', NULL, NULL, -17, -17, 28, 28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (114, 'Oceania', 'Îles Salomon', NULL, NULL, 155, 166, -11, -6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (115, 'North America', 'Îles Turks et Caïques', NULL, NULL, -72, -71, 21, 21);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (116, 'North America', 'Îles Vierges Britanniques', NULL, NULL, -64, -64, 18, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (117, 'North America', 'Îles Vierges des États-Unis', NULL, NULL, -64, -64, 17, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (118, 'Asia', 'Inde', NULL, NULL, 68, 97, 6.7, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (119, 'Asia', 'Indonésie', NULL, NULL, 95, 141, -10, 5.9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (120, 'Asia', 'Iran', NULL, NULL, 44, 63, 25, 39);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (122, 'Europe', 'Irlande', NULL, NULL, -10, -6, 51, 55);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (123, 'Europe', 'Islande', NULL, NULL, -24, -13, 63, 66);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (124, 'Asia', 'Israël', NULL, NULL, 34, 35, 29, 33);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (125, 'Europe', 'Italie', NULL, NULL, 6.6, 18, 36, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (126, 'North America', 'Jamaïque', NULL, NULL, -78, -76, 17, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (127, 'Asia', 'Japon', NULL, NULL, 123, 145, 24, 45);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (128, 'Europe', 'Jersey', NULL, NULL, -2, -2, 49, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (129, 'Asia', 'Jordanie', NULL, NULL, 34, 39, 29, 33);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (130, 'Asia', 'Kazakhstan', NULL, NULL, 46, 87, 40, 55);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (131, 'Africa', 'Kenya', NULL, NULL, 33, 41, -4, 4.6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (132, 'Asia', 'Kirghizistan', NULL, NULL, 69, 80, 39, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (133, 'Oceania', 'Kiribati', NULL, NULL, -15, -15, 1.7, 2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (134, 'Asia', 'Koweït', NULL, NULL, 46, 48, 28, 30);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (135, 'Asia', 'Laos', NULL, NULL, 100, 107, 13, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (136, 'Africa', 'Lesotho', NULL, NULL, 27, 29, -30, -28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (137, 'Europe', 'Lettonie', NULL, NULL, 20, 28, 55, 58);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (138, 'Asia', 'Liban', NULL, NULL, 35, 36, 33, 34);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (139, 'Africa', 'Libéria', NULL, NULL, -11, -7, 4.3, 8.5);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (140, 'Africa', 'Libye', NULL, NULL, 9.3, 25, 19, 33);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (141, 'Europe', 'Liechtenstein', NULL, NULL, 9.4, 9.6, 47, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (142, 'Europe', 'Lituanie', NULL, NULL, 20, 26, 53, 56);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (143, 'Europe', 'Luxembourg', NULL, NULL, 5.7, 6.5, 49, 50);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (144, 'Asia', 'Macao', NULL, NULL, 113, 113, 22, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (145, 'Europe', 'Macédoine', NULL, NULL, 20, 23, 40, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (146, 'Africa', 'Madagascar', NULL, NULL, 43, 50, -25, -11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (147, 'Asia', 'Malaisie', NULL, NULL, 32, 35, -17, -9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (148, 'Africa', 'Malawi', NULL, NULL, 99, 119, 0.8, 7.3);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (149, 'Asia', 'Maldives', NULL, NULL, 72, 73, 0, 7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (150, 'Africa', 'Mali', NULL, NULL, -12, 4.2, 10, 25);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (151, 'Europe', 'Malte', NULL, NULL, 14, 14, 35, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (152, 'Africa', 'Maroc', NULL, NULL, -13, -1, 27, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (153, 'North America', 'Martinique', NULL, NULL, -61, -60, 14, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (154, 'Africa', 'Maurice', NULL, NULL, 57, 63, -20, -19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (155, 'Africa', 'Mauritanie', NULL, NULL, -17, -4, 14, 27);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (156, 'Africa', 'Mayotte', NULL, NULL, 45, 45, -12, -12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (157, 'North America', 'Mexique', NULL, NULL, -11, -86, 14, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (159, 'Europe', 'Monaco', NULL, NULL, 7.3, 7.4, 43, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (160, 'Asia', 'Mongolie', NULL, NULL, 87, 119, 41, 52);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (161, 'Europe', 'Montenegro', NULL, NULL, 18, 20, 41, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (162, 'North America', 'Montserrat', NULL, NULL, -62, -62, 16, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (163, 'Africa', 'Mozambique', NULL, NULL, 30, 40, -26, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (164, 'Asia', 'Myanmar', NULL, NULL, 92, 101, 9.8, 28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (165, 'Africa', 'Namibie', NULL, NULL, 11, 25, -28, -16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (166, 'Oceania', 'Nauru', NULL, NULL, 166, 166, 0, 0);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (167, 'Asia', 'Népal', NULL, NULL, 80, 88, 26, 30);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (168, 'North America', 'Nicaragua', NULL, NULL, -87, -83, 10, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (169, 'Africa', 'Niger', NULL, NULL, 0.1, 15, 11, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (170, 'Africa', 'Nigéria', NULL, NULL, 2.6, 14, 4.2, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (171, 'Oceania', 'Niué', NULL, NULL, -16, -16, -19, -18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (172, 'Europe', 'Norvège', NULL, NULL, 4.7, 31, 57, 71);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (173, 'Oceania', 'Nouvelle-Calédonie', NULL, NULL, 163, 168, -22, -20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (174, 'Oceania', 'Nouvelle-Zélande', NULL, NULL, -17, 178, -52, -34);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (175, 'Asia', 'Oman', NULL, NULL, 51, 59, 16, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (176, 'Africa', 'Ouganda', NULL, NULL, 29, 35, -1, 4.2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (177, 'Asia', 'Ouzbékistan', NULL, NULL, 55, 73, 37, 45);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (178, 'Asia', 'Pakistan', NULL, NULL, 60, 77, 23, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (179, 'Oceania', 'Palaos', NULL, NULL, 134, 134, 7.3, 7.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (180, 'North America', 'Panama', NULL, NULL, -83, -77, 7.2, 9.6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (181, 'Oceania', 'Papouasie-Nouvelle-Guinée', NULL, NULL, 140, 155, -11, -1);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (182, 'South America', 'Paraguay', NULL, NULL, -62, -54, -27, -19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (183, 'Europe', 'Pays-Bas', NULL, NULL, 3.3, 7.2, 50, 53);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (184, 'South America', 'Pérou', NULL, NULL, -81, -68, -18, 0);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (185, 'Asia', 'Philippines', NULL, NULL, 116, 126, 5, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (186, 'Europe', 'Pologne', NULL, NULL, 14, 24, 49, 54);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (187, 'Oceania', 'Polynésie Française', NULL, NULL, -15, -13, -17, -8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (188, 'North America', 'Porto Rico', NULL, NULL, -67, -65, 17, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (189, 'Europe', 'Portugal', NULL, NULL, -31, -6, 32, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (190, 'Asia', 'Qatar', NULL, NULL, 50, 51, 24, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (191, 'Africa', 'République Centrafricaine', NULL, NULL, 14, 27, 2.2, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (192, 'Africa', 'République Démocratique du Congo', NULL, NULL, 12, 31, -13, 5.3);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (193, 'North America', 'République Dominicaine', NULL, NULL, -72, -68, 17, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (194, 'Africa', 'République du Congo', NULL, NULL, 11, 18, -5, 3.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (121, 'Asia', 'Irak', NULL, NULL, 38, 48, 29, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (195, 'Europe', 'République Tchèque', NULL, NULL, 12, 18, 48, 51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (196, 'Africa', 'Réunion', NULL, NULL, 55, 55, -21, -20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (197, 'Europe', 'Roumanie', NULL, NULL, 20, 29, 43, 48);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (198, 'Europe', 'Royaume-Uni', NULL, NULL, -8, 1.7, 49, 60);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (199, 'Asie', 'Russie', NULL, NULL, -18, 180, 41, 81);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (200, 'Africa', 'Rwanda', NULL, NULL, 28, 30, -2, -1);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (201, 'Africa', 'Sahara Occidental', NULL, NULL, -17, -8, 20, 27);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (202, 'North America', 'Saint-Kitts-et-Nevis', NULL, NULL, -62, -62, 17, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (203, 'Europe', 'Saint-Marin', NULL, NULL, 12, 12, 43, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (204, 'North America', 'Saint-Pierre-et-Miquelon', NULL, NULL, -56, -56, 46, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (205, 'Europe', 'Saint-Siège (état de la Cité du Vatican)', NULL, NULL, 41, 41, 12, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (206, 'North America', 'Saint-Vincent-et-les Grenadines', NULL, NULL, -61, -61, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (207, 'Africa', 'Sainte-Hélène', NULL, NULL, -5, -5, -16, -15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (208, 'North America', 'Sainte-Lucie', NULL, NULL, -61, -60, 13, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (209, 'Oceania', 'Samoa', NULL, NULL, -17, -17, -14, -13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (210, 'Oceania', 'Samoa Américaines', NULL, NULL, -17, -17, -14, -14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (211, 'Africa', 'Sao Tomé-et-Principe', NULL, NULL, 6.4, 7.4, 0, 1.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (212, 'Africa', 'Sénégal', NULL, NULL, -17, -11, 12, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (213, 'Europe', 'Serbie', NULL, NULL, 18, 23, 41, 46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (214, 'Africa', 'Seychelles', NULL, NULL, 46, 55, -9, -4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (215, 'Africa', 'Sierra Leone', NULL, NULL, -13, -10, 6.9, 9.9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (216, 'Asia', 'Singapour', NULL, NULL, 103, 103, 1.2, 1.4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (217, 'Europe', 'Slovaquie', NULL, NULL, 16, 22, 47, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (218, 'Europe', 'Slovénie', NULL, NULL, 13, 16, 45, 46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (219, 'Africa', 'Somalie', NULL, NULL, 40, 51, -1, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (220, 'Africa', 'Soudan', NULL, NULL, 21, 38, 3.4, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (221, 'Asia', 'Sri Lanka', NULL, NULL, 79, 81, 5.9, 9.8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (222, 'Europe', 'Suède', NULL, NULL, 11, 24, 55, 69);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (223, 'Europe', 'Suisse', NULL, NULL, 5.9, 10, 45, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (224, 'South America', 'Suriname', NULL, NULL, -58, -53, 1.8, 6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (225, 'Europe', 'Svalbard', NULL, NULL, 10, 33, 74, 80);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (226, 'Africa', 'Swaziland', NULL, NULL, 30, 32, -27, -25);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (227, 'Asia', 'Syrie', NULL, NULL, 35, 42, 32, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (228, 'Asia', 'Tadjikistan', NULL, NULL, 67, 75, 36, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (229, 'Asia', 'Taïwan', NULL, NULL, 118, 122, 21, 25);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (231, 'Africa', 'Tchad', NULL, NULL, 13, 24, 7.4, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (232, 'Antarctica', 'Terres Australes Françaises', NULL, NULL, 51, 70, -49, -46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (233, 'Africa', 'Territoire Britannique de l''Océan Indien', NULL, NULL, 72, 72, -7, -7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (234, 'Asia', 'Territoire Palestinien Occupé', NULL, NULL, 34, 34, 31, 31);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (235, 'Asia', 'Thaïlande', NULL, NULL, 97, 105, 5.6, 20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (236, 'Oceania', 'Timor-Leste', NULL, NULL, -9, -8, 123, 127);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (237, 'Africa', 'Togo', NULL, NULL, 0, 1.7, 6.1, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (238, 'Oceania', 'Tokelau', NULL, NULL, -17, -17, -9, -9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (239, 'Oceania', 'Tonga', NULL, NULL, -17, -17, -21, -18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (240, 'North America', 'Trinité-et-Tobago', NULL, NULL, -61, -60, 10, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (241, 'Africa', 'Tunisie', NULL, NULL, 7.4, 11, 30, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (242, 'Asia', 'Turkménistan', NULL, NULL, 52, 66, 35, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (243, 'Asia', 'Turquie', NULL, NULL, 25, 44, 35, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (244, 'Oceania', 'Tuvalu', NULL, NULL, 176, 179, -8, -6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (245, 'Europe', 'Ukraine', NULL, NULL, 22, 40, 44, 52);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (246, 'South America', 'Uruguay', NULL, NULL, -58, -53, -34, -30);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (247, 'Oceania', 'Vanuatu', NULL, NULL, 166, 169, -20, -13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (248, 'South America', 'Venezuela', NULL, NULL, -73, -59, 0.6, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (250, 'Oceania', 'Wallis et Futuna', NULL, NULL, -17, -17, -14, -13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (251, 'Asia', 'Yémen', NULL, NULL, 42, 54, 12, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (252, 'Africa', 'Zambie', NULL, NULL, 21, 33, -18, -8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (253, 'Africa', 'Zimbabwe', NULL, NULL, 25, 33, -22, -15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (158, 'Europe', 'Moldavie', NULL, NULL, 26, 30, 45, 48);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (249, 'Asia', 'Vietnam', NULL, NULL, 102, 109, 8.5, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (230, 'Africa', 'Tanzanie', NULL, NULL, 29, 40, -11, 0);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (1, 42, NULL, 'Alsace', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (2, 72, NULL, 'Aquitaine', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (3, 83, NULL, 'Auvergne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (4, 25, NULL, 'Basse-Normandie', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (5, 26, NULL, 'Bourgogne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (6, 53, NULL, 'Bretagne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (7, 24, NULL, 'Centre', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (8, 21, NULL, 'Champagne-Ardenne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (9, 94, NULL, 'Corse', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (10, 43, NULL, 'Franche-Comté', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (11, 1, NULL, 'Guadeloupe', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (12, 3, NULL, 'Guyane', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (13, 23, NULL, 'Haute-Normandie', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (14, 11, NULL, 'Île-de-France', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (15, 4, NULL, 'La Réunion', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (16, 91, NULL, 'Languedoc-Roussillon', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (17, 74, NULL, 'Limousin', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (18, 41, NULL, 'Lorraine', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (19, 2, NULL, 'Martinique', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (20, 6, NULL, 'Mayotte', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (21, 73, NULL, 'Midi-Pyrénées', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (22, 31, NULL, 'Nord-Pas-de-Calais', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (23, 52, NULL, 'Pays de la Loire', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (24, 22, NULL, 'Picardie', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (25, 54, NULL, 'Poitou-Charentes', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (26, 93, NULL, 'Provence-Alpes-Côte d''Azur', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (27, 82, NULL, 'Rhône-Alpes', NULL);

SET search_path = lsi, pg_catalog;

INSERT INTO subject (id_subject, libelle_subject) VALUES (3, 'Des coups de pouce');
INSERT INTO subject (id_subject, libelle_subject) VALUES (4, 'Des données et des cartes');
INSERT INTO subject (id_subject, libelle_subject) VALUES (2, 'Des technologies, logiciels et matériels');
INSERT INTO subject (id_subject, libelle_subject) VALUES (5, 'Des évènements et formations');
INSERT INTO subject (id_subject, libelle_subject) VALUES (1, 'Les actus du réseau');

INSERT INTO tag (id_tag, libelle_tag) VALUES (1, 'QGIS');
INSERT INTO tag (id_tag, libelle_tag) VALUES (2, 'Postgresql');
INSERT INTO tag (id_tag, libelle_tag) VALUES (3, 'CBN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (4, 'FCBN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (13, 'Biodiversité');
INSERT INTO tag (id_tag, libelle_tag) VALUES (14, 'Flore');
INSERT INTO tag (id_tag, libelle_tag) VALUES (16, 'Outil naturaliste');
INSERT INTO tag (id_tag, libelle_tag) VALUES (20, 'OSM');
INSERT INTO tag (id_tag, libelle_tag) VALUES (24, 'GeoJSON');
INSERT INTO tag (id_tag, libelle_tag) VALUES (25, 'Web');
INSERT INTO tag (id_tag, libelle_tag) VALUES (26, 'Drone');
INSERT INTO tag (id_tag, libelle_tag) VALUES (27, 'GBIF');
INSERT INTO tag (id_tag, libelle_tag) VALUES (28, 'GPS');
INSERT INTO tag (id_tag, libelle_tag) VALUES (29, 'Nomade');
INSERT INTO tag (id_tag, libelle_tag) VALUES (30, 'Webmapping');
INSERT INTO tag (id_tag, libelle_tag) VALUES (31, 'SIG');
INSERT INTO tag (id_tag, libelle_tag) VALUES (32, 'JavaScript');
INSERT INTO tag (id_tag, libelle_tag) VALUES (33, 'R');
INSERT INTO tag (id_tag, libelle_tag) VALUES (34, 'OpenLayer');
INSERT INTO tag (id_tag, libelle_tag) VALUES (35, 'Open Data');
INSERT INTO tag (id_tag, libelle_tag) VALUES (36, 'MNHN/SPN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (37, 'Standard');
INSERT INTO tag (id_tag, libelle_tag) VALUES (38, 'IGN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (39, '3D');
INSERT INTO tag (id_tag, libelle_tag) VALUES (40, 'Postgis');
INSERT INTO tag (id_tag, libelle_tag) VALUES (41, 'BRGM');
INSERT INTO tag (id_tag, libelle_tag) VALUES (42, 'SI');
INSERT INTO tag (id_tag, libelle_tag) VALUES (43, 'ONEMA');
INSERT INTO tag (id_tag, libelle_tag) VALUES (45, 'BigData');
INSERT INTO tag (id_tag, libelle_tag) VALUES (46, 'SINP');
INSERT INTO tag (id_tag, libelle_tag) VALUES (47, 'Lidar');
INSERT INTO tag (id_tag, libelle_tag) VALUES (48, 'Rasberry-pi');
INSERT INTO tag (id_tag, libelle_tag) VALUES (50, 'Phytosociologie');
INSERT INTO tag (id_tag, libelle_tag) VALUES (51, 'Base de données');
INSERT INTO tag (id_tag, libelle_tag) VALUES (52, 'INSPIRE');
INSERT INTO tag (id_tag, libelle_tag) VALUES (53, 'Climat');
INSERT INTO tag (id_tag, libelle_tag) VALUES (54, 'OGC');
INSERT INTO tag (id_tag, libelle_tag) VALUES (55, 'Dev');
INSERT INTO tag (id_tag, libelle_tag) VALUES (56, 'Cartographie');
INSERT INTO tag (id_tag, libelle_tag) VALUES (57, 'Sécurité');
INSERT INTO tag (id_tag, libelle_tag) VALUES (58, 'Télédétection');
INSERT INTO tag (id_tag, libelle_tag) VALUES (59, 'Open Source');
INSERT INTO tag (id_tag, libelle_tag) VALUES (49, 'Google');
INSERT INTO tag (id_tag, libelle_tag) VALUES (44, 'Crowdsourcing');
INSERT INTO tag (id_tag, libelle_tag) VALUES (60, 'Git');
INSERT INTO tag (id_tag, libelle_tag) VALUES (61, 'Git');


CREATE SEQUENCE referentiels.tendance_pop_id_tendance_pop_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.tendance_pop_id_tendance_pop_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.tendance_pop_id_tendance_pop_seq OWNED BY referentiels.tendance_pop.id_tendance_pop;


ALTER TABLE referentiels.statut_id_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.statut_id_seq OWNED BY referentiels.statut.id;

CREATE SEQUENCE applications.bug_id_bug_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE applications.bug_id_bug_seq OWNER TO codex_admin;
ALTER SEQUENCE applications.bug_id_bug_seq OWNED BY applications.bug.id_bug;

CREATE SEQUENCE applications.log_id_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE applications.log_id_log_seq OWNER TO codex_admin;
ALTER SEQUENCE applications.log_id_log_seq OWNED BY applications.log.id_log;


CREATE SEQUENCE applications.pres_id_pres_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE applications.pres_id_pres_seq OWNER TO codex_admin;
ALTER SEQUENCE applications.pres_id_pres_seq OWNED BY applications.pres.id_pres;

CREATE SEQUENCE applications.rubrique_id_rubrique_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE applications.rubrique_id_rubrique_seq OWNER TO codex_admin;
ALTER SEQUENCE applications.rubrique_id_rubrique_seq OWNED BY applications.rubrique.id_rubrique;

CREATE SEQUENCE applications.suivi_id_suivi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE applications.suivi_id_suivi_seq OWNER TO codex_admin;
ALTER SEQUENCE applications.suivi_id_suivi_seq OWNED BY applications.suivi.id_suivi;

CREATE SEQUENCE applications.taxons_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE applications.taxons_uid_seq OWNER TO postgres;
ALTER SEQUENCE applications.taxons_uid_seq OWNED BY applications.taxons.uid;

CREATE SEQUENCE catnat.discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE catnat.discussion_id_discussion_seq OWNER TO codex_admin;
ALTER SEQUENCE catnat.discussion_id_discussion_seq OWNED BY catnat.discussion.id_discussion;

CREATE SEQUENCE eee.discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE eee.discussion_id_discussion_seq OWNER TO codex_admin;
ALTER SEQUENCE eee.discussion_id_discussion_seq OWNED BY eee.discussion.id_discussion;

CREATE SEQUENCE eee.liste_argument_ida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE eee.liste_argument_ida_seq OWNER TO codex_admin;
ALTER SEQUENCE eee.liste_argument_ida_seq OWNED BY eee.liste_argument.ida;

CREATE SEQUENCE eee.liste_reponse_idq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE eee.liste_reponse_idq_seq OWNER TO codex_admin;
ALTER SEQUENCE eee.liste_reponse_idq_seq OWNED BY eee.liste_reponse.idq;

CREATE SEQUENCE eee.liste_source_ids_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE eee.liste_source_ids_seq OWNER TO codex_admin;
ALTER SEQUENCE eee.liste_source_ids_seq OWNED BY eee.liste_source.ids;

CREATE SEQUENCE eee.pays_idp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE eee.pays_idp_seq OWNER TO codex_admin;
ALTER SEQUENCE eee.pays_idp_seq OWNED BY eee.pays.idp;

CREATE SEQUENCE liste_rouge.discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE liste_rouge.discussion_id_discussion_seq OWNER TO codex_admin;
ALTER SEQUENCE liste_rouge.discussion_id_discussion_seq OWNED BY liste_rouge.discussion.id_discussion;

CREATE SEQUENCE lsi.news_id_news_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE lsi.news_id_news_seq OWNER TO postgres;
ALTER SEQUENCE lsi.news_id_news_seq OWNED BY lsi.news.id;

CREATE SEQUENCE lsi.subject_id_subject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE lsi.subject_id_subject_seq OWNER TO postgres;
ALTER SEQUENCE lsi.subject_id_subject_seq OWNED BY lsi.subject.id_subject;

CREATE SEQUENCE lsi.tag_id_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE lsi.tag_id_tag_seq OWNER TO postgres;
ALTER SEQUENCE lsi.tag_id_tag_seq OWNED BY lsi.tag.id_tag;

CREATE SEQUENCE referentiels.ajustmt_id_ajustmt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.ajustmt_id_ajustmt_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.ajustmt_id_ajustmt_seq OWNED BY referentiels.ajustmt.id_ajustmt;

CREATE SEQUENCE referentiels.aoo_id_aoo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.aoo_id_aoo_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.aoo_id_aoo_seq OWNED BY referentiels.aoo.id_aoo;

CREATE SEQUENCE referentiels.cat_a_id_cat_a_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.cat_a_id_cat_a_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.cat_a_id_cat_a_seq OWNED BY referentiels.cat_a.id_cat_a;

CREATE SEQUENCE referentiels.categorie_final_id_cat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.categorie_final_id_cat_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.categorie_final_id_cat_seq OWNED BY referentiels.categorie_final.id_cat;

CREATE SEQUENCE referentiels.categorie_id_cat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.categorie_id_cat_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.categorie_id_cat_seq OWNED BY referentiels.categorie.id_cat;

CREATE SEQUENCE referentiels.champs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.champs_id_seq OWNER TO postgres;
ALTER SEQUENCE referentiels.champs_id_seq OWNED BY referentiels.champs.id;

CREATE SEQUENCE referentiels.champs_ref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.champs_ref_id_seq OWNER TO postgres;
ALTER SEQUENCE referentiels.champs_ref_id_seq OWNED BY referentiels.champs_ref.id;

CREATE SEQUENCE referentiels.chgt_cat_id_chgt_cat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.chgt_cat_id_chgt_cat_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.chgt_cat_id_chgt_cat_seq OWNED BY referentiels.chgt_cat.id_chgt_cat;

CREATE SEQUENCE referentiels.crit_a1_id_crit_a1_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.crit_a1_id_crit_a1_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.crit_a1_id_crit_a1_seq OWNED BY referentiels.crit_a1.id_crit_a1;

CREATE SEQUENCE referentiels.crit_a234_id_crit_a234_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.crit_a234_id_crit_a234_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.crit_a234_id_crit_a234_seq OWNED BY referentiels.crit_a234.id_crit_a234;

CREATE SEQUENCE referentiels.crit_c1_id_crit_c1_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.crit_c1_id_crit_c1_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.crit_c1_id_crit_c1_seq OWNED BY referentiels.crit_c1.id_crit_c1;

CREATE SEQUENCE referentiels.crit_c2_id_crit_c2_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.crit_c2_id_crit_c2_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.crit_c2_id_crit_c2_seq OWNED BY referentiels.crit_c2.id_crit_c2;

CREATE SEQUENCE referentiels.indigenat_id_indi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.indigenat_id_indi_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.indigenat_id_indi_seq OWNED BY referentiels.indigenat.id_indi;

CREATE SEQUENCE referentiels.nbindiv_id_nbindiv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.nbindiv_id_nbindiv_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.nbindiv_id_nbindiv_seq OWNED BY referentiels.nbindiv.id_nbindiv;

CREATE SEQUENCE referentiels.nbloc_id_nbloc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.nbloc_id_nbloc_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.nbloc_id_nbloc_seq OWNED BY referentiels.nbloc.id_nbloc;

CREATE SEQUENCE referentiels.raison_ajust_id_raison_ajust_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.raison_ajust_id_raison_ajust_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.raison_ajust_id_raison_ajust_seq OWNED BY referentiels.raison_ajust.id_raison_ajust;

CREATE SEQUENCE referentiels.rang_id_rang_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.rang_id_rang_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.rang_id_rang_seq OWNED BY referentiels.rang.id_rang;

CREATE SEQUENCE referentiels.reduc_eff_id_reduc_eff_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.reduc_eff_id_reduc_eff_seq OWNER TO codex_admin;
ALTER SEQUENCE referentiels.reduc_eff_id_reduc_eff_seq OWNED BY referentiels.reduc_eff.id_reduc_eff;

CREATE SEQUENCE referentiels.user_ref_idu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE referentiels.user_ref_idu_seq OWNER TO postgres;
ALTER SEQUENCE referentiels.user_ref_idu_seq OWNED BY referentiels.user_ref.idu;

CREATE SEQUENCE refnat.discussion_id_discussion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.discussion_id_discussion_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.discussion_id_discussion_seq OWNED BY refnat.discussion.id_discussion;

CREATE SEQUENCE refnat.taxons_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxons_uid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxons_uid_seq OWNED BY refnat.taxons.uid;

CREATE SEQUENCE refnat.taxref_changes_30_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxref_changes_30_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxref_changes_30_utf8_ogc_fid_seq OWNED BY refnat.taxref_changes_30_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxref_changes_40_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxref_changes_40_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxref_changes_40_utf8_ogc_fid_seq OWNED BY refnat.taxref_changes_40_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxref_changes_50_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxref_changes_50_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxref_changes_50_utf8_ogc_fid_seq OWNED BY refnat.taxref_changes_50_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxref_changes_60_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxref_changes_60_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxref_changes_60_utf8_ogc_fid_seq OWNED BY refnat.taxref_changes_60_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxref_changes_70_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxref_changes_70_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxref_changes_70_utf8_ogc_fid_seq OWNED BY refnat.taxref_changes_70_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxref_changes_80_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxref_changes_80_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxref_changes_80_utf8_ogc_fid_seq OWNED BY refnat.taxref_changes_80_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxrefv20_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxrefv20_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxrefv20_utf8_ogc_fid_seq OWNED BY refnat.taxrefv20_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxrefv30_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxrefv30_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxrefv30_utf8_ogc_fid_seq OWNED BY refnat.taxrefv30_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxrefv40_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxrefv40_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxrefv40_utf8_ogc_fid_seq OWNED BY refnat.taxrefv40_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxrefv50_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxrefv50_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxrefv50_utf8_ogc_fid_seq OWNED BY refnat.taxrefv50_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxrefv60_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxrefv60_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxrefv60_utf8_ogc_fid_seq OWNED BY refnat.taxrefv60_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxrefv70_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxrefv70_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxrefv70_utf8_ogc_fid_seq OWNED BY refnat.taxrefv70_utf8.ogc_fid;

CREATE SEQUENCE refnat.taxrefv80_utf8_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE refnat.taxrefv80_utf8_ogc_fid_seq OWNER TO codex_admin;
ALTER SEQUENCE refnat.taxrefv80_utf8_ogc_fid_seq OWNED BY refnat.taxrefv80_utf8.ogc_fid;

ALTER TABLE ONLY applications.log ALTER COLUMN id_log SET DEFAULT nextval('applications.log_id_log_seq'::regclass);
ALTER TABLE ONLY applications.bug ALTER COLUMN id_bug SET DEFAULT nextval('applications.bug_id_bug_seq'::regclass);
ALTER TABLE ONLY applications.pres ALTER COLUMN id_pres SET DEFAULT nextval('applications.pres_id_pres_seq'::regclass);
ALTER TABLE ONLY applications.rubrique ALTER COLUMN id_rubrique SET DEFAULT nextval('applications.rubrique_id_rubrique_seq'::regclass);
ALTER TABLE ONLY applications.suivi ALTER COLUMN id_suivi SET DEFAULT nextval('applications.suivi_id_suivi_seq'::regclass);
ALTER TABLE ONLY applications.taxons ALTER COLUMN uid SET DEFAULT nextval('applications.taxons_uid_seq'::regclass);
ALTER TABLE ONLY catnat.discussion ALTER COLUMN id_discussion SET DEFAULT nextval('catnat.discussion_id_discussion_seq'::regclass);
ALTER TABLE ONLY eee.discussion ALTER COLUMN id_discussion SET DEFAULT nextval('eee.discussion_id_discussion_seq'::regclass);
ALTER TABLE ONLY eee.liste_argument ALTER COLUMN ida SET DEFAULT nextval('eee.liste_argument_ida_seq'::regclass);
ALTER TABLE ONLY eee.liste_reponse ALTER COLUMN idq SET DEFAULT nextval('eee.liste_reponse_idq_seq'::regclass);
ALTER TABLE ONLY eee.liste_source ALTER COLUMN ids SET DEFAULT nextval('eee.liste_source_ids_seq'::regclass);
ALTER TABLE ONLY eee.pays ALTER COLUMN idp SET DEFAULT nextval('eee.pays_idp_seq'::regclass);
ALTER TABLE ONLY liste_rouge.discussion ALTER COLUMN id_discussion SET DEFAULT nextval('liste_rouge.discussion_id_discussion_seq'::regclass);
ALTER TABLE ONLY lsi.news ALTER COLUMN id SET DEFAULT nextval('lsi.news_id_news_seq'::regclass);
ALTER TABLE ONLY lsi.subject ALTER COLUMN id_subject SET DEFAULT nextval('lsi.subject_id_subject_seq'::regclass);
ALTER TABLE ONLY lsi.tag ALTER COLUMN id_tag SET DEFAULT nextval('lsi.tag_id_tag_seq'::regclass);
ALTER TABLE ONLY referentiels.ajustmt ALTER COLUMN id_ajustmt SET DEFAULT nextval('referentiels.ajustmt_id_ajustmt_seq'::regclass);
ALTER TABLE ONLY referentiels.aoo ALTER COLUMN id_aoo SET DEFAULT nextval('referentiels.aoo_id_aoo_seq'::regclass);
ALTER TABLE ONLY referentiels.cat_a ALTER COLUMN id_cat_a SET DEFAULT nextval('referentiels.cat_a_id_cat_a_seq'::regclass);
ALTER TABLE ONLY referentiels.categorie ALTER COLUMN id_cat SET DEFAULT nextval('referentiels.categorie_id_cat_seq'::regclass);
ALTER TABLE ONLY referentiels.categorie_final ALTER COLUMN id_cat SET DEFAULT nextval('referentiels.categorie_final_id_cat_seq'::regclass);
ALTER TABLE ONLY referentiels.champs ALTER COLUMN id SET DEFAULT nextval('referentiels.champs_id_seq'::regclass);
ALTER TABLE ONLY referentiels.champs_ref ALTER COLUMN id SET DEFAULT nextval('referentiels.champs_ref_id_seq'::regclass);
ALTER TABLE ONLY referentiels.chgt_cat ALTER COLUMN id_chgt_cat SET DEFAULT nextval('referentiels.chgt_cat_id_chgt_cat_seq'::regclass);
ALTER TABLE ONLY referentiels.crit_a1 ALTER COLUMN id_crit_a1 SET DEFAULT nextval('referentiels.crit_a1_id_crit_a1_seq'::regclass);
ALTER TABLE ONLY referentiels.crit_a234 ALTER COLUMN id_crit_a234 SET DEFAULT nextval('referentiels.crit_a234_id_crit_a234_seq'::regclass);
ALTER TABLE ONLY referentiels.crit_c1 ALTER COLUMN id_crit_c1 SET DEFAULT nextval('referentiels.crit_c1_id_crit_c1_seq'::regclass);
ALTER TABLE ONLY referentiels.crit_c2 ALTER COLUMN id_crit_c2 SET DEFAULT nextval('referentiels.crit_c2_id_crit_c2_seq'::regclass);
ALTER TABLE ONLY referentiels.indigenat ALTER COLUMN id_indi SET DEFAULT nextval('referentiels.indigenat_id_indi_seq'::regclass);
ALTER TABLE ONLY referentiels.nbindiv ALTER COLUMN id_nbindiv SET DEFAULT nextval('referentiels.nbindiv_id_nbindiv_seq'::regclass);
ALTER TABLE ONLY referentiels.nbloc ALTER COLUMN id_nbloc SET DEFAULT nextval('referentiels.nbloc_id_nbloc_seq'::regclass);
ALTER TABLE ONLY referentiels.raison_ajust ALTER COLUMN id_raison_ajust SET DEFAULT nextval('referentiels.raison_ajust_id_raison_ajust_seq'::regclass);
ALTER TABLE ONLY referentiels.rang ALTER COLUMN id_rang SET DEFAULT nextval('referentiels.rang_id_rang_seq'::regclass);
ALTER TABLE ONLY referentiels.reduc_eff ALTER COLUMN id_reduc_eff SET DEFAULT nextval('referentiels.reduc_eff_id_reduc_eff_seq'::regclass);
ALTER TABLE ONLY referentiels.statut ALTER COLUMN id SET DEFAULT nextval('referentiels.statut_id_seq'::regclass);
ALTER TABLE ONLY referentiels.tendance_pop ALTER COLUMN id_tendance_pop SET DEFAULT nextval('referentiels.tendance_pop_id_tendance_pop_seq'::regclass);
ALTER TABLE ONLY referentiels.user_ref ALTER COLUMN idu SET DEFAULT nextval('referentiels.user_ref_idu_seq'::regclass);
ALTER TABLE ONLY refnat.discussion ALTER COLUMN id_discussion SET DEFAULT nextval('refnat.discussion_id_discussion_seq'::regclass);
ALTER TABLE ONLY refnat.taxons ALTER COLUMN uid SET DEFAULT nextval('refnat.taxons_uid_seq'::regclass);
ALTER TABLE ONLY refnat.taxref_changes_30_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxref_changes_30_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxref_changes_40_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxref_changes_40_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxref_changes_50_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxref_changes_50_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxref_changes_60_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxref_changes_60_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxref_changes_70_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxref_changes_70_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxref_changes_80_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxref_changes_80_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxrefv20_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxrefv20_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxrefv30_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxrefv30_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxrefv40_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxrefv40_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxrefv50_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxrefv50_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxrefv60_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxrefv60_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxrefv70_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxrefv70_utf8_ogc_fid_seq'::regclass);
ALTER TABLE ONLY refnat.taxrefv80_utf8 ALTER COLUMN ogc_fid SET DEFAULT nextval('refnat.taxrefv80_utf8_ogc_fid_seq'::regclass);

SET search_path = refnat, pg_catalog;
REVOKE ALL ON SEQUENCE taxons_uid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE taxons_uid_seq FROM postgres;
GRANT ALL ON SEQUENCE taxons_uid_seq TO postgres;
GRANT ALL ON SEQUENCE taxons_uid_seq TO codex_admin;

SET search_path = lsi, pg_catalog;
REVOKE ALL ON SEQUENCE news_id_news_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE news_id_news_seq FROM postgres;
GRANT ALL ON SEQUENCE news_id_news_seq TO postgres;
GRANT ALL ON SEQUENCE news_id_news_seq TO codex_admin;

REVOKE ALL ON SEQUENCE subject_id_subject_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE subject_id_subject_seq FROM postgres;
GRANT ALL ON SEQUENCE subject_id_subject_seq TO postgres;
GRANT ALL ON SEQUENCE subject_id_subject_seq TO codex_admin;

REVOKE ALL ON SEQUENCE tag_id_tag_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tag_id_tag_seq FROM postgres;
GRANT ALL ON SEQUENCE tag_id_tag_seq TO postgres;
GRANT ALL ON SEQUENCE tag_id_tag_seq TO codex_admin;

SET search_path = applications, pg_catalog;
REVOKE ALL ON SEQUENCE taxons_uid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE taxons_uid_seq FROM postgres;
GRANT ALL ON SEQUENCE taxons_uid_seq TO postgres;
GRANT ALL ON SEQUENCE taxons_uid_seq TO codex_admin;

