--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-07-18 16:14:10

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = syntaxa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 367 (class 1259 OID 20929)
-- Name: fsd_syntaxa; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE fsd_syntaxa (
    id integer NOT NULL,
    tbl_name character varying,
    commentaire_tbl character varying,
    pos character varying,
    cd character varying,
    type_cd character varying,
    commentaire_colonne character varying
);


ALTER TABLE fsd_syntaxa OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 20927)
-- Name: fsd_syntaxa_id_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE fsd_syntaxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fsd_syntaxa_id_seq OWNER TO postgres;

--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 366
-- Name: fsd_syntaxa_id_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE fsd_syntaxa_id_seq OWNED BY fsd_syntaxa.id;


--
-- TOC entry 370 (class 1259 OID 24668)
-- Name: images; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE images (
    "codeEnregistrementSerieGeoserie" text,
    chemin_img text,
    "typeImage" text
);


ALTER TABLE images OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 20055)
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
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE liste_geo; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE liste_geo IS 'Table listant les territoires géographiques de référence pour la chorologie';


--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 308
-- Name: COLUMN liste_geo.id_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.id_territoire IS 'identifiant unique du territoire';


--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 308
-- Name: COLUMN liste_geo.code_type_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.code_type_territoire IS 'code du type de territoire (RA:région agricole, DEP: département, REG: région)';


--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 308
-- Name: COLUMN liste_geo.code_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.code_territoire IS 'Code du territoire dans son référentiel d''origine (ex: insee pour les départements)';


--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 308
-- Name: COLUMN liste_geo.libelle_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.libelle_territoire IS 'Libellé du territoire dans son référentiel d''origine (ex: insee pour les départements)';


--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 308
-- Name: COLUMN liste_geo.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 396 (class 1259 OID 33524)
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
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 396
-- Name: liste_geo_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE liste_geo_id_tri_seq OWNED BY liste_geo.id_tri;


--
-- TOC entry 309 (class 1259 OID 20064)
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
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE referentiel_taxo; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE referentiel_taxo IS 'Table listant les taxons dans les différents référentiels taxonomiques';


--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN referentiel_taxo.id_rattachement_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.id_rattachement_referentiel IS 'identifiant unique du taxon dans un référentiel donné';


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN referentiel_taxo.code_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.code_referentiel IS 'nom codifié du référentiel';


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN referentiel_taxo.version_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.version_referentiel IS 'version du référentiel';


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN referentiel_taxo.cd_ref_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.cd_ref_referentiel IS 'cd_ref dans le référentiel';


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN referentiel_taxo.cd_nom_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.cd_nom_referentiel IS 'cd_nom dans le référentiel';


--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN referentiel_taxo.nom_complet_taxon_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.nom_complet_taxon_referentiel IS 'nom complet du taxon dans le référentiel';


--
-- TOC entry 337 (class 1259 OID 20336)
-- Name: st_annuaire_organismes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_annuaire_organismes (
    "idOrganisme" text NOT NULL,
    "acronymeOrganisme" text,
    "libOrganisme" text
);


ALTER TABLE st_annuaire_organismes OWNER TO postgres;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE st_annuaire_organismes; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_annuaire_organismes IS 'Table d''annuaire qui recense les organismes en lien avec la création des catalogues';


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 337
-- Name: COLUMN st_annuaire_organismes."idOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_organismes."idOrganisme" IS 'Identifiant unique de l''organisme';


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 337
-- Name: COLUMN st_annuaire_organismes."acronymeOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_organismes."acronymeOrganisme" IS 'Acronyme de l''organisme';


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 337
-- Name: COLUMN st_annuaire_organismes."libOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_organismes."libOrganisme" IS 'Libellé complet de l''organisme';


--
-- TOC entry 338 (class 1259 OID 20344)
-- Name: st_annuaire_personnes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_annuaire_personnes (
    "idPersonne" text NOT NULL,
    prenom text,
    nom text,
    id_tri integer NOT NULL
);


ALTER TABLE st_annuaire_personnes OWNER TO postgres;

--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE st_annuaire_personnes; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_annuaire_personnes IS 'Table d''annuaire qui recense les personnes en lien avec la création des catalogues';


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 338
-- Name: COLUMN st_annuaire_personnes."idPersonne"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes."idPersonne" IS 'Identifiant unique de la personne';


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 338
-- Name: COLUMN st_annuaire_personnes.prenom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes.prenom IS 'Prénom de la personne';


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 338
-- Name: COLUMN st_annuaire_personnes.nom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes.nom IS 'Nom de la personne';


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 338
-- Name: COLUMN st_annuaire_personnes.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 405 (class 1259 OID 33804)
-- Name: st_annuaire_personnes_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_annuaire_personnes_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_annuaire_personnes_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 405
-- Name: st_annuaire_personnes_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_annuaire_personnes_id_tri_seq OWNED BY st_annuaire_personnes.id_tri;


--
-- TOC entry 431 (class 1259 OID 59293)
-- Name: st_biblio; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_biblio (
    "idBiblio" integer NOT NULL,
    "codeEnregistrement" text,
    "libPublication" text,
    "urlPublication" text,
    "codePublication" text
);


ALTER TABLE st_biblio OWNER TO postgres;

--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 431
-- Name: TABLE st_biblio; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_biblio IS 'Table qui recense les références bibliographiques en lien avec la description des syntaxons, des séries et géoséries';


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 431
-- Name: COLUMN st_biblio."idBiblio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."idBiblio" IS 'identifiant unique de la table de biblio qui associe une publication a un enregistrment dans la base';


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 431
-- Name: COLUMN st_biblio."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."codeEnregistrement" IS 'Code de l''enregistrement d''un syntaxon, série ou géosérie';


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 431
-- Name: COLUMN st_biblio."libPublication"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."libPublication" IS 'Libellé de la publication (dont titre, année,  volume et le nombre de pages) qui atteste de la présence du taxon dans le territoire étudié';


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 431
-- Name: COLUMN st_biblio."urlPublication"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."urlPublication" IS 'permalien vers la notice bibliographique du document source de référence (Kentika, PMB, Alexandrie, ..) ou permalien vers le document en téléchargement  qui atteste de la présence du syntaxon dans le territoire étudié';


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 431
-- Name: COLUMN st_biblio."codePublication"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."codePublication" IS 'numero ISSN de la publication qui atteste de la présence du syntaxon dans le territoire étudié';


--
-- TOC entry 430 (class 1259 OID 59291)
-- Name: st_biblio_idBiblio_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_biblio_idBiblio_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "st_biblio_idBiblio_seq" OWNER TO postgres;

--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 430
-- Name: st_biblio_idBiblio_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_biblio_idBiblio_seq" OWNED BY st_biblio."idBiblio";


--
-- TOC entry 310 (class 1259 OID 20072)
-- Name: st_catalogue_description; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_catalogue_description (
    "identifiantCatalogue" text NOT NULL,
    "libelleCatalogue" text,
    "versionCatalogue" text,
    "typeCatalogue" text,
    "dateCreationCatalogue" date,
    "dateMiseAJourCatalogue" date,
    "idCollaborateurCatalogue" text,
    "idTerritoireCatalogue" text,
    "codeTypeTerritoireCatalogue" text,
    "codeTerritoireCatalogue" text,
    "libelleTerritoireCatalogue" text,
    "empriseTerritoireCatalogue" text,
    "remarqueTerritoireCatalogue" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_catalogue_description OWNER TO postgres;

--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE st_catalogue_description; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_catalogue_description IS 'Table de métadonnées de description des catalogues';


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."identifiantCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."identifiantCatalogue" IS 'identifiant unique du catalogue';


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."libelleCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."libelleCatalogue" IS 'libellé du catalogue de vegetation';


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."versionCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."versionCatalogue" IS 'version du catalogue de vegetation';


--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."typeCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."typeCatalogue" IS 'Type de catalogue correspondant au champ thématique couvert par le catalogue.';


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."dateCreationCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."dateCreationCatalogue" IS 'date de création du catalogue de vegetation';


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."dateMiseAJourCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."dateMiseAJourCatalogue" IS 'date de dernière mise à jour du catalogue de vegetation';


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."idCollaborateurCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."idCollaborateurCatalogue" IS 'identifiant vers une table contenant les noms des CBN ou autres organismes ayant collaborés à la réalisation du catalogue';


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."idTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."idTerritoireCatalogue" IS 'identifiant unique du territoire utilisé pour décrire la validité spatiale du catalogue, fait référence à la table liste_geo';


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."codeTypeTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."codeTypeTerritoireCatalogue" IS 'Code du type de territoire utilisé pour décrire la validité spatiale du catalogue, autrement dit emprise totale du catalogue ( CBN,régionale, nationale, autre…)';


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."codeTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."codeTerritoireCatalogue" IS 'Code du territoire utilisé pour décrire de validité spatiale du catalogue, lié au référentiel territorial utilisé';


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."libelleTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."libelleTerritoireCatalogue" IS 'Nom du territoire  utilisé pour décrire la validité spatiale du catalogue ';


--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description."remarqueTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."remarqueTerritoireCatalogue" IS 'remarque concernant le territoire de validité spatiale du catalogue (si ce territoire est inférieur à une région  ou département administratif)';


--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 310
-- Name: COLUMN st_catalogue_description.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 410 (class 1259 OID 34198)
-- Name: st_catalogue_description_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_catalogue_description_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_catalogue_description_id_tri_seq OWNER TO postgres;

--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 410
-- Name: st_catalogue_description_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_catalogue_description_id_tri_seq OWNED BY st_catalogue_description.id_tri;


--
-- TOC entry 409 (class 1259 OID 34189)
-- Name: st_chorologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_chorologie (
    "idChorologie" integer NOT NULL,
    "codeEnregistrement" text,
    "statutChorologie" text,
    "idTerritoire" text
);


ALTER TABLE st_chorologie OWNER TO postgres;

--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 409
-- Name: TABLE st_chorologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_chorologie IS 'Table indiquant la chorologie de chaque syntaxon, série ou petite géosérie';


--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 409
-- Name: COLUMN st_chorologie."idChorologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."idChorologie" IS 'identifiant unique de la chorologie enregistrée (ex:idchoro_1, idchoro_2 etc)';


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 409
-- Name: COLUMN st_chorologie."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la chorologie est renseignée';


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 409
-- Name: COLUMN st_chorologie."statutChorologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."statutChorologie" IS 'statut de la présence sur le territoire (concerne la chorologie de la végétation c''est à dire la région naturelle de présence)';


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 409
-- Name: COLUMN st_chorologie."idTerritoire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."idTerritoire" IS 'code unique du territoire pour lequel le statut de la végétation est renseigné, fait référence à la table liste_geo du taxa';


--
-- TOC entry 408 (class 1259 OID 34187)
-- Name: st_chorologie_idChorologie_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_chorologie_idChorologie_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "st_chorologie_idChorologie_seq" OWNER TO postgres;

--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 408
-- Name: st_chorologie_idChorologie_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_chorologie_idChorologie_seq" OWNED BY st_chorologie."idChorologie";


--
-- TOC entry 339 (class 1259 OID 20352)
-- Name: st_collaborateur; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_collaborateur (
    "idCollaborateur" text NOT NULL,
    "identifiantCatalogue" text,
    "idOrganisme" text,
    "acronymeOrganisme" text,
    "idPersonne" text,
    prenom text,
    nom text
);


ALTER TABLE st_collaborateur OWNER TO postgres;

--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE st_collaborateur; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_collaborateur IS 'Table de collaborateur qui fait le lien entre les personnes, leur organisme et le catalogue auquel elles ont participé';


--
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN st_collaborateur."idCollaborateur"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."idCollaborateur" IS 'Identifiant unique collaborateur qui est la combinaison d''une personne et d''un organisme (ex: collab_1, collab_2 etc)';


--
-- TOC entry 3106 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN st_collaborateur."identifiantCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."identifiantCatalogue" IS 'identifiant du catalogue (clé étrangère)';


--
-- TOC entry 3107 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN st_collaborateur."idOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."idOrganisme" IS 'identifiant de l''organisme d''appartenance du collaborateur';


--
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN st_collaborateur."acronymeOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."acronymeOrganisme" IS 'acronyme de l''organisme d''appartenance du collaborateur';


--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN st_collaborateur."idPersonne"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."idPersonne" IS 'identifiant de la personne collaborateur';


--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN st_collaborateur.prenom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur.prenom IS 'Prénom du collaborateur';


--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN st_collaborateur.nom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur.nom IS 'Nom du collaborateur';


--
-- TOC entry 435 (class 1259 OID 67479)
-- Name: st_correspondance_eunis; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_correspondance_eunis (
    "idCorresEUNIS" integer NOT NULL,
    "codeEnregistrement" text,
    "typeEnregistrement" text,
    "codeEUNIS" text,
    "rqEUNIS" text
);


ALTER TABLE st_correspondance_eunis OWNER TO postgres;

--
-- TOC entry 3113 (class 0 OID 0)
-- Dependencies: 435
-- Name: TABLE st_correspondance_eunis; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_correspondance_eunis IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats EUNIS';


--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 435
-- Name: COLUMN st_correspondance_eunis."idCorresEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."idCorresEUNIS" IS 'identifiant unique portant un couple syntaxon/correspondance typologie EUNIS';


--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 435
-- Name: COLUMN st_correspondance_eunis."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."codeEnregistrement" IS 'code de l'' enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 435
-- Name: COLUMN st_correspondance_eunis."typeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."typeEnregistrement" IS 'indique s''il s''agit d''un enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 435
-- Name: COLUMN st_correspondance_eunis."codeEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."codeEUNIS" IS 'code de l''habitat EUNIS concerné par la correspondance';


--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 435
-- Name: COLUMN st_correspondance_eunis."rqEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."rqEUNIS" IS 'champ libre de remarque à propos du rattachement au code HIc';


--
-- TOC entry 434 (class 1259 OID 67477)
-- Name: st_correspondance_eunis_idCorresEUNIS_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "st_correspondance_eunis_idCorresEUNIS_seq" OWNER TO postgres;

--
-- TOC entry 3120 (class 0 OID 0)
-- Dependencies: 434
-- Name: st_correspondance_eunis_idCorresEUNIS_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" OWNED BY st_correspondance_eunis."idCorresEUNIS";


--
-- TOC entry 433 (class 1259 OID 67470)
-- Name: st_correspondance_hic; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_correspondance_hic (
    "idCorresHIC" integer NOT NULL,
    "codeEnregistrement" text,
    "typeEnregistrement" text,
    "codeHIC" text,
    "rqHIC" text
);


ALTER TABLE st_correspondance_hic OWNER TO postgres;

--
-- TOC entry 3122 (class 0 OID 0)
-- Dependencies: 433
-- Name: TABLE st_correspondance_hic; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_correspondance_hic IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats de la directive habitat (N2000)';


--
-- TOC entry 3123 (class 0 OID 0)
-- Dependencies: 433
-- Name: COLUMN st_correspondance_hic."idCorresHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."idCorresHIC" IS 'identifiant unique de la correspondance entre le syntaxon et l''habitat d''intérêt communautaire';


--
-- TOC entry 3124 (class 0 OID 0)
-- Dependencies: 433
-- Name: COLUMN st_correspondance_hic."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."codeEnregistrement" IS 'code de l'' enregistrement de syntaxon, du syntaxon dans le cadre d''un cortège syntaxonomique, du (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- TOC entry 3125 (class 0 OID 0)
-- Dependencies: 433
-- Name: COLUMN st_correspondance_hic."typeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."typeEnregistrement" IS 'indique s''il s''agit d''un enregistrement de syntaxon, syntaxon de cortège, (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- TOC entry 3126 (class 0 OID 0)
-- Dependencies: 433
-- Name: COLUMN st_correspondance_hic."codeHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."codeHIC" IS 'code de l''habitat Natura 2000 concerné par la correspondance';


--
-- TOC entry 3127 (class 0 OID 0)
-- Dependencies: 433
-- Name: COLUMN st_correspondance_hic."rqHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."rqHIC" IS 'champ libre de remarque à propos du rattachement au code HIC';


--
-- TOC entry 432 (class 1259 OID 67468)
-- Name: st_correspondance_hic_idCorresHIC_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_correspondance_hic_idCorresHIC_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "st_correspondance_hic_idCorresHIC_seq" OWNER TO postgres;

--
-- TOC entry 3129 (class 0 OID 0)
-- Dependencies: 432
-- Name: st_correspondance_hic_idCorresHIC_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_correspondance_hic_idCorresHIC_seq" OWNED BY st_correspondance_hic."idCorresHIC";


--
-- TOC entry 324 (class 1259 OID 20200)
-- Name: st_correspondance_pvf; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_correspondance_pvf (
    "idRattachementPVF" integer,
    "codeEnregistrementSyntaxon" text,
    "versionReferentiel" text,
    "idCorrespondancePVF" integer NOT NULL
);


ALTER TABLE st_correspondance_pvf OWNER TO postgres;

--
-- TOC entry 3131 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE st_correspondance_pvf; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_correspondance_pvf IS 'Table de correspondance avec la typologie du PVF (PVF1 et PVF2)';


--
-- TOC entry 3132 (class 0 OID 0)
-- Dependencies: 324
-- Name: COLUMN st_correspondance_pvf."idRattachementPVF"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_pvf."idRattachementPVF" IS 'identifiant unique du syntaxon dans la table contenant pvf1 et pvf2';


--
-- TOC entry 3133 (class 0 OID 0)
-- Dependencies: 324
-- Name: COLUMN st_correspondance_pvf."codeEnregistrementSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_pvf."codeEnregistrementSyntaxon" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la géomorphologie est renseignée';


--
-- TOC entry 3134 (class 0 OID 0)
-- Dependencies: 324
-- Name: COLUMN st_correspondance_pvf."versionReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_pvf."versionReferentiel" IS 'version du référentiel';


--
-- TOC entry 425 (class 1259 OID 43356)
-- Name: st_correspondance_pvf_idCorrespondancePVF_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "st_correspondance_pvf_idCorrespondancePVF_seq" OWNER TO postgres;

--
-- TOC entry 3136 (class 0 OID 0)
-- Dependencies: 425
-- Name: st_correspondance_pvf_idCorrespondancePVF_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" OWNED BY st_correspondance_pvf."idCorrespondancePVF";


--
-- TOC entry 327 (class 1259 OID 20220)
-- Name: st_cortege_floristique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_cortege_floristique (
    "idCortegeFloristique" text,
    "codeEnregistrementSyntaxon" text,
    "idRattachementReferentiel" text,
    "typeTaxon" text
);


ALTER TABLE st_cortege_floristique OWNER TO postgres;

--
-- TOC entry 3138 (class 0 OID 0)
-- Dependencies: 327
-- Name: TABLE st_cortege_floristique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_cortege_floristique IS 'Cortège floristique qui accompagne le syntaxon';


--
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 327
-- Name: COLUMN st_cortege_floristique."idCortegeFloristique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."idCortegeFloristique" IS 'identifiant unique du taxon dans le cortège floristique';


--
-- TOC entry 3140 (class 0 OID 0)
-- Dependencies: 327
-- Name: COLUMN st_cortege_floristique."codeEnregistrementSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."codeEnregistrementSyntaxon" IS 'code de l''enregistrement du syntaxon';


--
-- TOC entry 3141 (class 0 OID 0)
-- Dependencies: 327
-- Name: COLUMN st_cortege_floristique."idRattachementReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."idRattachementReferentiel" IS 'identifiant du rattachement au référentiel';


--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 327
-- Name: COLUMN st_cortege_floristique."typeTaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."typeTaxon" IS 'indique si le taxon est caractéristique ou différentiel';


--
-- TOC entry 318 (class 1259 OID 20136)
-- Name: st_cortege_syntaxonomique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_cortege_syntaxonomique (
    "codeEnregistrementCortegeSyntax" text NOT NULL,
    "idGeosigmafacies" text,
    "libelleGeoSigmafacies" text,
    "codeEnregistrementSyntax" text,
    "idSyntaxonRetenu" text,
    "nomSyntaxonRetenu" text,
    "rqSyntaxon" text,
    "pourcentageTheoriqSyntax" integer,
    "codeTeteSerie" text
);


ALTER TABLE st_cortege_syntaxonomique OWNER TO postgres;

--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 318
-- Name: TABLE st_cortege_syntaxonomique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_cortege_syntaxonomique IS 'Cortège syntaxonomique de chaque geosigmafacies. Chaque syntaxon représente un stade dynamique du (geo)sigmasyntaxa. Ce stade peut être progressif ou regressif.';


--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."codeEnregistrementCortegeSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."codeEnregistrementCortegeSyntax" IS 'identifiant unique de la ligne qui décrit le syntaxon composant le cortège';


--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."idGeosigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."idGeosigmafacies" IS 'Identifiant unique du (geo)sigmafacies';


--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."libelleGeoSigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."libelleGeoSigmafacies" IS 'clé étrangère vers le libellé du geosigmafacies';


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."codeEnregistrementSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."codeEnregistrementSyntax" IS 'clé étrangère vers l''enregistrement du syntaxon';


--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."idSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."idSyntaxonRetenu" IS 'code du syntaxon retenu dans le catalogue d''origine pour le faciès donné d''une série ou petite géosérie donnée';


--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."nomSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."nomSyntaxonRetenu" IS 'nom complet du syntaxon retenu dans le catalogue d''origine pour le faciès donné d''une série ou petite géosérie donnée';


--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."rqSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."rqSyntaxon" IS 'remarque concernant ce syntaxon dans le cadre de son appartenance au cortège syntaxonomique d''un (geo)sigmafacies particulier';


--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."pourcentageTheoriqSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."pourcentageTheoriqSyntax" IS 'Pourcentage moyen théorique du syntaxon pour le faciès donné d''une série ou petite géosérie donnée';


--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 318
-- Name: COLUMN st_cortege_syntaxonomique."codeTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."codeTeteSerie" IS 'Le syntaxon représente-t-il la tête de la (geo)série à laquelle il est associé';


--
-- TOC entry 437 (class 1259 OID 67504)
-- Name: st_etage_bioclim; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_etage_bioclim (
    "idCorresEtageBioclim" integer NOT NULL,
    "codeEnregistrement" text,
    "codeEtageBioclim" text,
    "libEtageBioclim" text
);


ALTER TABLE st_etage_bioclim OWNER TO postgres;

--
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 437
-- Name: TABLE st_etage_bioclim; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_etage_bioclim IS 'Table indiquant l''appartenance d''un syntaxon,série ou petite géosérie à un ou plusieurs étages de végétation ';


--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 437
-- Name: COLUMN st_etage_bioclim."idCorresEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."idCorresEtageBioclim" IS 'identifiant unique de la correspondance entre l''enregistrement et l''étage bioclimatique';


--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 437
-- Name: COLUMN st_etage_bioclim."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."codeEnregistrement" IS 'identifiant unique de l''enregistrement du syntaxon, faciès, série ou petite géosérie';


--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 437
-- Name: COLUMN st_etage_bioclim."codeEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."codeEtageBioclim" IS 'code de l''étage bioclimatique';


--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 437
-- Name: COLUMN st_etage_bioclim."libEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."libEtageBioclim" IS 'libellé de l''étage bioclimatique';


--
-- TOC entry 436 (class 1259 OID 67502)
-- Name: st_etage_bioclim_idCorresEtageBioclim_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "st_etage_bioclim_idCorresEtageBioclim_seq" OWNER TO postgres;

--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 436
-- Name: st_etage_bioclim_idCorresEtageBioclim_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" OWNED BY st_etage_bioclim."idCorresEtageBioclim";


--
-- TOC entry 429 (class 1259 OID 59261)
-- Name: st_etage_veg; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_etage_veg (
    "idCorresEtageveg" integer NOT NULL,
    "codeEnregistrement" text,
    "codeEtageVeg" text,
    "libEtageVeg" text
);


ALTER TABLE st_etage_veg OWNER TO postgres;

--
-- TOC entry 428 (class 1259 OID 59259)
-- Name: st_etage_veg_idCorresEtageveg_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_etage_veg_idCorresEtageveg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "st_etage_veg_idCorresEtageveg_seq" OWNER TO postgres;

--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 428
-- Name: st_etage_veg_idCorresEtageveg_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_etage_veg_idCorresEtageveg_seq" OWNED BY st_etage_veg."idCorresEtageveg";


--
-- TOC entry 317 (class 1259 OID 20128)
-- Name: st_geo_sigmafacies; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_geo_sigmafacies (
    "idGeosigmafacies" text NOT NULL,
    "codeEnregistrementSerieGeoserie" text,
    "codeFacies" text,
    "libelleGeoSigmafacies" text,
    dominance text,
    usage text,
    "remarqueVariabilite" text
);


ALTER TABLE st_geo_sigmafacies OWNER TO postgres;

--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE st_geo_sigmafacies; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_geo_sigmafacies IS 'Table de correspondance entre le(geo)sigmataxon et un faciès qui donne le (geo)sigmafacies';


--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN st_geo_sigmafacies."idGeosigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."idGeosigmafacies" IS 'Identifiant unique du sigmafacies';


--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN st_geo_sigmafacies."codeEnregistrementSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."codeEnregistrementSerieGeoserie" IS 'Clé étrangère vers l''identifiant unique de la série ou petite géosérie';


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN st_geo_sigmafacies."codeFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."codeFacies" IS 'clé étrangère vers le code du type de faciès';


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN st_geo_sigmafacies."libelleGeoSigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."libelleGeoSigmafacies" IS 'Concaténation du libelle du geosigmasyntaxa et du libelle du type de faciès ex: "pelouse de la Série de la forêt à Fagus sylvatica et Deschampsia flexuosa"';


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN st_geo_sigmafacies.dominance; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies.dominance IS 'Champ texte libre qui indique si le (geo)sigmafaciès est généralement dominant dans la série (oui/non)';


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN st_geo_sigmafacies.usage; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies.usage IS 'Champ texte libre qui vise à décrire sigmafaciès';


--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN st_geo_sigmafacies."remarqueVariabilite"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité du faciès. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';


--
-- TOC entry 325 (class 1259 OID 20208)
-- Name: st_geomorphologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_geomorphologie (
    "idVegGeomorpho" text,
    "codeEnregistrement" text,
    "idGeomorphologie" text,
    "libGeomorphologie" text
);


ALTER TABLE st_geomorphologie OWNER TO postgres;

--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE st_geomorphologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_geomorphologie IS 'Table d''appartenance d''une végétation à une ou plusieurs géomorphologie';


--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 325
-- Name: COLUMN st_geomorphologie."idVegGeomorpho"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."idVegGeomorpho" IS 'identifiant unique de l''association d''une végétation et d''une géomorphologie';


--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 325
-- Name: COLUMN st_geomorphologie."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la géomorphologie est renseignée';


--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 325
-- Name: COLUMN st_geomorphologie."idGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."idGeomorphologie" IS 'identifiant du taxon géomorphologique';


--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 325
-- Name: COLUMN st_geomorphologie."libGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."libGeomorphologie" IS 'libellé du taxon géomorphologique';


--
-- TOC entry 320 (class 1259 OID 20152)
-- Name: st_indicateurs_floristiques; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_indicateurs_floristiques (
    "idIndicateurFlor" text NOT NULL,
    "idGeosigmafacies" text,
    "idRattachementReferentiel" text
);


ALTER TABLE st_indicateurs_floristiques OWNER TO postgres;

--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE st_indicateurs_floristiques; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_indicateurs_floristiques IS 'Indicateurs floristiques de chaque (geo)sigmafacies';


--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 320
-- Name: COLUMN st_indicateurs_floristiques."idIndicateurFlor"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_indicateurs_floristiques."idIndicateurFlor" IS 'Identifiant unique de la ligne qui correspond au taxon qui sert d''indicateur floristique au (geo)sigmafacies';


--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 320
-- Name: COLUMN st_indicateurs_floristiques."idGeosigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_indicateurs_floristiques."idGeosigmafacies" IS 'Identifiant unique du (geo)sigmafacies auquel l''indicateur floristique est rattaché';


--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 320
-- Name: COLUMN st_indicateurs_floristiques."idRattachementReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_indicateurs_floristiques."idRattachementReferentiel" IS 'Identifiant unique de la ligne qui correspond au taxon dans un référentiel donné (taxref ou autre)';


--
-- TOC entry 322 (class 1259 OID 20176)
-- Name: st_ref_action_suivi; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_action_suivi (
    "codeActionSuivi" text NOT NULL,
    "libActionSuivi" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_action_suivi OWNER TO postgres;

--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 322
-- Name: TABLE st_ref_action_suivi; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_action_suivi IS 'Référentiel des types de suivi de données';


--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 322
-- Name: COLUMN st_ref_action_suivi."codeActionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi."codeActionSuivi" IS 'Codification du type de suivi';


--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 322
-- Name: COLUMN st_ref_action_suivi."libActionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi."libActionSuivi" IS 'Libellé du type de suivi';


--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 322
-- Name: COLUMN st_ref_action_suivi.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 398 (class 1259 OID 33565)
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
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 398
-- Name: st_ref_action_suivi_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_action_suivi_id_tri_seq OWNED BY st_ref_action_suivi.id_tri;


--
-- TOC entry 313 (class 1259 OID 20096)
-- Name: st_ref_categorie_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_categorie_seriegeoserie (
    "codeCategorieSerieGeoserie" text NOT NULL,
    "libCategorieSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_categorie_seriegeoserie OWNER TO postgres;

--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE st_ref_categorie_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_categorie_seriegeoserie IS 'Référentiel des catégorie de série et de géoséries';


--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN st_ref_categorie_seriegeoserie."codeCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie."codeCategorieSerieGeoserie" IS 'code de la catégorie de série et de géoséries';


--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN st_ref_categorie_seriegeoserie."libCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie."libCategorieSerieGeoserie" IS 'libelle de la catégorie de série et de géoséries';


--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN st_ref_categorie_seriegeoserie.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 400 (class 1259 OID 33607)
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
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 400
-- Name: st_ref_categorie_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_categorie_seriegeoserie_id_tri_seq OWNED BY st_ref_categorie_seriegeoserie.id_tri;


--
-- TOC entry 345 (class 1259 OID 20398)
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
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE st_ref_continentalite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_continentalite IS 'Référentiel de la continentalité selon Landolt';


--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 345
-- Name: COLUMN st_ref_continentalite."indCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."indCont" IS 'Indice de la continentalite selon Landolt';


--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 345
-- Name: COLUMN st_ref_continentalite."libCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."libCont" IS 'libellé court de la Continentalité selon Landolt';


--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 345
-- Name: COLUMN st_ref_continentalite."libLongCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."libLongCont" IS 'libellé long de continentalité selon Landolt';


--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 345
-- Name: COLUMN st_ref_continentalite.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 376 (class 1259 OID 33277)
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
-- TOC entry 3204 (class 0 OID 0)
-- Dependencies: 376
-- Name: st_ref_continentalite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_continentalite_id_tri_seq OWNED BY st_ref_continentalite.id_tri;


--
-- TOC entry 340 (class 1259 OID 20360)
-- Name: st_ref_critique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_critique (
    "idCritique" text,
    "libCritique" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_critique OWNER TO postgres;

--
-- TOC entry 3205 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE st_ref_critique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_critique IS 'Référentiel de la criticité des syntaxons';


--
-- TOC entry 3206 (class 0 OID 0)
-- Dependencies: 340
-- Name: COLUMN st_ref_critique."idCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique."idCritique" IS 'valeurs que prend le caractère critique (oui/non)';


--
-- TOC entry 3207 (class 0 OID 0)
-- Dependencies: 340
-- Name: COLUMN st_ref_critique."libCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique."libCritique" IS 'libellé du caractère critique le syntaxon est critique, le syntaxon n''est pas critique';


--
-- TOC entry 3208 (class 0 OID 0)
-- Dependencies: 340
-- Name: COLUMN st_ref_critique.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 375 (class 1259 OID 33256)
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
-- TOC entry 3210 (class 0 OID 0)
-- Dependencies: 375
-- Name: st_ref_critique_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_critique_id_tri_seq OWNED BY st_ref_critique.id_tri;


--
-- TOC entry 330 (class 1259 OID 20272)
-- Name: st_ref_etage_bioclim; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_etage_bioclim (
    "codeEtageBioclim" text NOT NULL,
    "libEtageBioclim" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_etage_bioclim OWNER TO postgres;

--
-- TOC entry 3211 (class 0 OID 0)
-- Dependencies: 330
-- Name: TABLE st_ref_etage_bioclim; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_etage_bioclim IS 'Référentiel des étages bioclimatiques';


--
-- TOC entry 3212 (class 0 OID 0)
-- Dependencies: 330
-- Name: COLUMN st_ref_etage_bioclim."codeEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim."codeEtageBioclim" IS 'code de l''étage bioclimatique';


--
-- TOC entry 3213 (class 0 OID 0)
-- Dependencies: 330
-- Name: COLUMN st_ref_etage_bioclim."libEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim."libEtageBioclim" IS 'libellé de l''étage bioclimatique';


--
-- TOC entry 3214 (class 0 OID 0)
-- Dependencies: 330
-- Name: COLUMN st_ref_etage_bioclim.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 383 (class 1259 OID 33351)
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
-- TOC entry 3216 (class 0 OID 0)
-- Dependencies: 383
-- Name: st_ref_etage_bioclim_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_etage_bioclim_id_tri_seq OWNED BY st_ref_etage_bioclim.id_tri;


--
-- TOC entry 427 (class 1259 OID 51138)
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
-- TOC entry 3218 (class 0 OID 0)
-- Dependencies: 427
-- Name: TABLE st_ref_etage_veg; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_etage_veg IS 'Référentiel des étages de végétation proposé par le réseau';


--
-- TOC entry 3219 (class 0 OID 0)
-- Dependencies: 427
-- Name: COLUMN st_ref_etage_veg."codeEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."codeEtageVeg" IS 'code de l''étage de végétation';


--
-- TOC entry 3220 (class 0 OID 0)
-- Dependencies: 427
-- Name: COLUMN st_ref_etage_veg."libEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."libEtageVeg" IS 'libellé de l''étage de végétation';


--
-- TOC entry 3221 (class 0 OID 0)
-- Dependencies: 427
-- Name: COLUMN st_ref_etage_veg."libLongEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."libLongEtageVeg" IS 'libellé long de l''étage de végétation';


--
-- TOC entry 3222 (class 0 OID 0)
-- Dependencies: 427
-- Name: COLUMN st_ref_etage_veg.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 426 (class 1259 OID 51136)
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
-- TOC entry 3224 (class 0 OID 0)
-- Dependencies: 426
-- Name: st_ref_etage_veg_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_etage_veg_id_tri_seq OWNED BY st_ref_etage_veg.id_tri;


--
-- TOC entry 348 (class 1259 OID 20430)
-- Name: st_ref_eunis; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_eunis (
    "codeEUNIS" text NOT NULL,
    "libEUNIS" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_eunis OWNER TO postgres;

--
-- TOC entry 3225 (class 0 OID 0)
-- Dependencies: 348
-- Name: TABLE st_ref_eunis; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_eunis IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats de la directive habitat (N2000)';


--
-- TOC entry 3226 (class 0 OID 0)
-- Dependencies: 348
-- Name: COLUMN st_ref_eunis."codeEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis."codeEUNIS" IS 'code de l''habitat EUNIS concerné par la correspondance';


--
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 348
-- Name: COLUMN st_ref_eunis."libEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis."libEUNIS" IS 'libellé de l''habitat EUNIS concerné par la correspondance';


--
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 348
-- Name: COLUMN st_ref_eunis.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 395 (class 1259 OID 33514)
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
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 395
-- Name: st_ref_eunis_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_eunis_id_tri_seq OWNED BY st_ref_eunis.id_tri;


--
-- TOC entry 335 (class 1259 OID 20320)
-- Name: st_ref_exposition; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_exposition (
    "idExposition" text NOT NULL,
    "libExposition" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_exposition OWNER TO postgres;

--
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE st_ref_exposition; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_exposition IS 'Référentiel des valeurs d''exposition';


--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 335
-- Name: COLUMN st_ref_exposition."idExposition"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition."idExposition" IS 'identifiant de l''exposition de la végétation';


--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 335
-- Name: COLUMN st_ref_exposition."libExposition"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition."libExposition" IS 'libellé de l''exposition de la végétation';


--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 335
-- Name: COLUMN st_ref_exposition.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 384 (class 1259 OID 33361)
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
-- TOC entry 3236 (class 0 OID 0)
-- Dependencies: 384
-- Name: st_ref_exposition_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_exposition_id_tri_seq OWNED BY st_ref_exposition.id_tri;


--
-- TOC entry 326 (class 1259 OID 20214)
-- Name: st_ref_geomorpho; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_geomorpho (
    "idGeomorphologie" text,
    "libGeomorphologie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_geomorpho OWNER TO postgres;

--
-- TOC entry 3237 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE st_ref_geomorpho; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_geomorpho IS 'Référentiel géomorphologique';


--
-- TOC entry 3238 (class 0 OID 0)
-- Dependencies: 326
-- Name: COLUMN st_ref_geomorpho."idGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."idGeomorphologie" IS 'identifiant du taxon géomorphologique';


--
-- TOC entry 3239 (class 0 OID 0)
-- Dependencies: 326
-- Name: COLUMN st_ref_geomorpho."libGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."libGeomorphologie" IS 'libellé de la géomorphologie';


--
-- TOC entry 3240 (class 0 OID 0)
-- Dependencies: 326
-- Name: COLUMN st_ref_geomorpho.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 387 (class 1259 OID 33393)
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
-- TOC entry 3242 (class 0 OID 0)
-- Dependencies: 387
-- Name: st_ref_geomorpho_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_geomorpho_id_tri_seq OWNED BY st_ref_geomorpho.id_tri;


--
-- TOC entry 329 (class 1259 OID 20240)
-- Name: st_ref_hic; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_hic (
    "codeHIC" text NOT NULL,
    "libHIC" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_hic OWNER TO postgres;

--
-- TOC entry 3243 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE st_ref_hic; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_hic IS 'Référentiel des habitats de la directive habitat (N2000)';


--
-- TOC entry 3244 (class 0 OID 0)
-- Dependencies: 329
-- Name: COLUMN st_ref_hic."codeHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_hic."codeHIC" IS 'code de l''habitat Natura 2000';


--
-- TOC entry 3245 (class 0 OID 0)
-- Dependencies: 329
-- Name: COLUMN st_ref_hic."libHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_hic."libHIC" IS 'libellé de l''habitat Natura 2000';


--
-- TOC entry 394 (class 1259 OID 33504)
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
-- TOC entry 3247 (class 0 OID 0)
-- Dependencies: 394
-- Name: st_ref_hic_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_hic_id_tri_seq OWNED BY st_ref_hic.id_tri;


--
-- TOC entry 332 (class 1259 OID 20296)
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
-- TOC entry 3248 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE st_ref_humidite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_humidite IS 'Référentiel de l''indice d''humidité édaphique selon Ellenberg et Julve (moisture)';


--
-- TOC entry 3249 (class 0 OID 0)
-- Dependencies: 332
-- Name: COLUMN st_ref_humidite."indHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."indHum" IS 'Indice de l''Humidité selon Ellenberg et Julve';


--
-- TOC entry 3250 (class 0 OID 0)
-- Dependencies: 332
-- Name: COLUMN st_ref_humidite."libHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."libHum" IS 'libellé court de l''Humidité selon Ellenberg et Julve';


--
-- TOC entry 3251 (class 0 OID 0)
-- Dependencies: 332
-- Name: COLUMN st_ref_humidite."libLongHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."libLongHum" IS 'libellé long de l''Humidité selon Ellenberg et Julve';


--
-- TOC entry 3252 (class 0 OID 0)
-- Dependencies: 332
-- Name: COLUMN st_ref_humidite.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 377 (class 1259 OID 33288)
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
-- TOC entry 3254 (class 0 OID 0)
-- Dependencies: 377
-- Name: st_ref_humidite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_humidite_id_tri_seq OWNED BY st_ref_humidite.id_tri;


--
-- TOC entry 343 (class 1259 OID 20382)
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
-- TOC entry 3255 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE st_ref_lumiere; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_lumiere IS 'Référentiel des indices d''affinité de la végétation à la lumière selon Landolt';


--
-- TOC entry 3256 (class 0 OID 0)
-- Dependencies: 343
-- Name: COLUMN st_ref_lumiere."indLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."indLum" IS 'Indice d''affinité à la lumière selon Landolt';


--
-- TOC entry 3257 (class 0 OID 0)
-- Dependencies: 343
-- Name: COLUMN st_ref_lumiere."libLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."libLum" IS 'libellé court d''affinité à la lumière selon Landolt';


--
-- TOC entry 3258 (class 0 OID 0)
-- Dependencies: 343
-- Name: COLUMN st_ref_lumiere."libLongLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."libLongLum" IS 'libellé long  d''affinité à la lumière selon Landolt';


--
-- TOC entry 3259 (class 0 OID 0)
-- Dependencies: 343
-- Name: COLUMN st_ref_lumiere.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 378 (class 1259 OID 33298)
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
-- TOC entry 3261 (class 0 OID 0)
-- Dependencies: 378
-- Name: st_ref_lumiere_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_lumiere_id_tri_seq OWNED BY st_ref_lumiere.id_tri;


--
-- TOC entry 344 (class 1259 OID 20390)
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
-- TOC entry 3262 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE st_ref_neige; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_neige IS 'Référentiel de l''affinité de la végétation à la neige';


--
-- TOC entry 3263 (class 0 OID 0)
-- Dependencies: 344
-- Name: COLUMN st_ref_neige."idNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."idNeige" IS 'identifiant (code) qui indique l''affinité de la végétation à la neige';


--
-- TOC entry 3264 (class 0 OID 0)
-- Dependencies: 344
-- Name: COLUMN st_ref_neige."libNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."libNeige" IS 'libellé qui indique l''affinité de la végétation à la neige';


--
-- TOC entry 3265 (class 0 OID 0)
-- Dependencies: 344
-- Name: COLUMN st_ref_neige."libLongNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."libLongNeige" IS 'libellé long qui indique l''affinité de la végétation à la neige';


--
-- TOC entry 3266 (class 0 OID 0)
-- Dependencies: 344
-- Name: COLUMN st_ref_neige."exempleNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."exempleNeige" IS 'exemple de végétation pour ce critère d''affinité à la neige';


--
-- TOC entry 3267 (class 0 OID 0)
-- Dependencies: 344
-- Name: COLUMN st_ref_neige.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 385 (class 1259 OID 33371)
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
-- TOC entry 3269 (class 0 OID 0)
-- Dependencies: 385
-- Name: st_ref_neige_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_neige_id_tri_seq OWNED BY st_ref_neige.id_tri;


--
-- TOC entry 331 (class 1259 OID 20288)
-- Name: st_ref_periode; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_periode (
    "codePeriode" text NOT NULL,
    "libPeriode" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_periode OWNER TO postgres;

--
-- TOC entry 3270 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE st_ref_periode; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_periode IS 'Table qui référence les périodes optimales de végétation (liste de début et fin de chaque saison)';


--
-- TOC entry 3271 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN st_ref_periode."codePeriode"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_periode."codePeriode" IS 'code de la période';


--
-- TOC entry 3272 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN st_ref_periode."libPeriode"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_periode."libPeriode" IS 'libellé de la période';


--
-- TOC entry 388 (class 1259 OID 33444)
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
-- TOC entry 3274 (class 0 OID 0)
-- Dependencies: 388
-- Name: st_ref_periode_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_periode_id_tri_seq OWNED BY st_ref_periode.id_tri;


--
-- TOC entry 328 (class 1259 OID 20226)
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
-- TOC entry 3275 (class 0 OID 0)
-- Dependencies: 328
-- Name: TABLE st_ref_pvf; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_pvf IS 'Typologie du PVF (PVF1 et PVF2)';


--
-- TOC entry 3276 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN st_ref_pvf."idRattachementPVF"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."idRattachementPVF" IS 'code du syntaxon dans l''un des référentiels pvf (1 ou 2)';


--
-- TOC entry 3277 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN st_ref_pvf."codeReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."codeReferentiel" IS 'code du référentiel (ici PVF)';


--
-- TOC entry 3278 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN st_ref_pvf."versionReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."versionReferentiel" IS 'version du référentiel';


--
-- TOC entry 3279 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN st_ref_pvf."identifiantSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."identifiantSyntaxonRetenu" IS 'identifiant du syntaxon retenu dans le référentiel choisi (CD_SYNTAXON dans le PVF)';


--
-- TOC entry 3280 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN st_ref_pvf."rangSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."rangSyntaxonRetenu" IS 'rang du syntaxon retenu dans le référentiel choisi (niveau dans le PVF)';


--
-- TOC entry 3281 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN st_ref_pvf."nomSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."nomSyntaxonRetenu" IS 'nom du syntaxon retenu dans le référentiel choisi (LB_SYNTAXON dans le PVF)';


--
-- TOC entry 3282 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN st_ref_pvf.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 397 (class 1259 OID 33555)
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
-- TOC entry 3284 (class 0 OID 0)
-- Dependencies: 397
-- Name: st_ref_pvf_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_pvf_id_tri_seq OWNED BY st_ref_pvf.id_tri;


--
-- TOC entry 315 (class 1259 OID 20112)
-- Name: st_ref_rang_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_rang_seriegeoserie (
    "codeRangSerieGeoserie" text NOT NULL,
    "libRangSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_rang_seriegeoserie OWNER TO postgres;

--
-- TOC entry 3285 (class 0 OID 0)
-- Dependencies: 315
-- Name: TABLE st_ref_rang_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rang_seriegeoserie IS 'Référentiel des rangs de série et de géoséries (ce référentiel n''est pas encore normé par la Société phytosociologique de France- SPF)';


--
-- TOC entry 3286 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN st_ref_rang_seriegeoserie."codeRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_seriegeoserie."codeRangSerieGeoserie" IS 'code du grand de série et de géoséries';


--
-- TOC entry 3287 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN st_ref_rang_seriegeoserie."libRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_seriegeoserie."libRangSerieGeoserie" IS 'libelle du rang de série et de géoséries';


--
-- TOC entry 401 (class 1259 OID 33617)
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
-- TOC entry 3289 (class 0 OID 0)
-- Dependencies: 401
-- Name: st_ref_rang_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rang_seriegeoserie_id_tri_seq OWNED BY st_ref_rang_seriegeoserie.id_tri;


--
-- TOC entry 314 (class 1259 OID 20104)
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
-- TOC entry 3290 (class 0 OID 0)
-- Dependencies: 314
-- Name: TABLE st_ref_rang_syntaxon; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rang_syntaxon IS 'Référentiel des rangs de syntaxons';


--
-- TOC entry 3291 (class 0 OID 0)
-- Dependencies: 314
-- Name: COLUMN st_ref_rang_syntaxon."codeRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."codeRangSyntaxon" IS 'code du rang de syntaxon';


--
-- TOC entry 3292 (class 0 OID 0)
-- Dependencies: 314
-- Name: COLUMN st_ref_rang_syntaxon."libRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."libRangSyntaxon" IS 'libelle du rang de syntaxon';


--
-- TOC entry 3293 (class 0 OID 0)
-- Dependencies: 314
-- Name: COLUMN st_ref_rang_syntaxon."niveauRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."niveauRangSyntaxon" IS 'niveau du rang de syntaxon';


--
-- TOC entry 3294 (class 0 OID 0)
-- Dependencies: 314
-- Name: COLUMN st_ref_rang_syntaxon."suffixeRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."suffixeRangSyntaxon" IS 'suffixe correspondant au rang du syntaxon';


--
-- TOC entry 402 (class 1259 OID 33637)
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
-- TOC entry 3296 (class 0 OID 0)
-- Dependencies: 402
-- Name: st_ref_rang_syntaxon_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rang_syntaxon_id_tri_seq OWNED BY st_ref_rang_syntaxon.id_tri;


--
-- TOC entry 333 (class 1259 OID 20304)
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
-- TOC entry 3297 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE st_ref_reaction; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_reaction IS 'Référentiel de l''indice de pH selon Landolt (réaction)';


--
-- TOC entry 3298 (class 0 OID 0)
-- Dependencies: 333
-- Name: COLUMN st_ref_reaction."indReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."indReaction" IS 'Indice de la réaction selon Landolt';


--
-- TOC entry 3299 (class 0 OID 0)
-- Dependencies: 333
-- Name: COLUMN st_ref_reaction."libReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."libReaction" IS 'libellé court dela réaction selon Landolt';


--
-- TOC entry 3300 (class 0 OID 0)
-- Dependencies: 333
-- Name: COLUMN st_ref_reaction."libLongReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."libLongReaction" IS 'libellé long de l''Humidité selon Landolt';


--
-- TOC entry 379 (class 1259 OID 33308)
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
-- TOC entry 3302 (class 0 OID 0)
-- Dependencies: 379
-- Name: st_ref_reaction_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_reaction_id_tri_seq OWNED BY st_ref_reaction.id_tri;


--
-- TOC entry 347 (class 1259 OID 20414)
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
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE st_ref_rivasmartinez_ombroclimat; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rivasmartinez_ombroclimat IS 'Référentiel des ombro-climats d''après Rivas-Martinez';


--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."idOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."idOmbroclimat" IS 'code de l''ombroclimat d''après Rivas-Martinez';


--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."libOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."libOmbroclimat" IS 'libellé court de l''ombroclimat selon Rivas Martinez';


--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."libLongOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."libLongOmbroclimat" IS 'libellé long de l''ombroclimat selon Rivas-Martinez';


--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 386 (class 1259 OID 33382)
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
-- TOC entry 3309 (class 0 OID 0)
-- Dependencies: 386
-- Name: st_ref_rivasmartinez_ombroclimat_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rivasmartinez_ombroclimat_id_tri_seq OWNED BY st_ref_rivasmartinez_ombroclimat.id_tri;


--
-- TOC entry 346 (class 1259 OID 20406)
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
-- TOC entry 3310 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE st_ref_salinite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_salinite IS 'Référentiel de l''affinité à la salinité selon Ellenberg et Julve';


--
-- TOC entry 3311 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN st_ref_salinite."indSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."indSali" IS 'Indice de l''affinité à la salinite selon Ellenberg et Julve';


--
-- TOC entry 3312 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN st_ref_salinite."libSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."libSali" IS 'libellé court de l''affinité à la salinite selon Ellenberg et Julve';


--
-- TOC entry 3313 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN st_ref_salinite."libLongSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."libLongSali" IS 'libellé long de l''affinité à la salinite selon Ellenberg et Julve';


--
-- TOC entry 3314 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN st_ref_salinite.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 382 (class 1259 OID 33340)
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
-- TOC entry 3316 (class 0 OID 0)
-- Dependencies: 382
-- Name: st_ref_salinite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_salinite_id_tri_seq OWNED BY st_ref_salinite.id_tri;


--
-- TOC entry 323 (class 1259 OID 20192)
-- Name: st_ref_statut_chorologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_statut_chorologie (
    "idStatutChorologie" text NOT NULL,
    "libStatutChrologie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_statut_chorologie OWNER TO postgres;

--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE st_ref_statut_chorologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_statut_chorologie IS 'Référentiel qui contient les valeurs que peuvent prendre les statuts de chorologie';


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 323
-- Name: COLUMN st_ref_statut_chorologie."idStatutChorologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_statut_chorologie."idStatutChorologie" IS 'Code du statut de chorologie';


--
-- TOC entry 3319 (class 0 OID 0)
-- Dependencies: 323
-- Name: COLUMN st_ref_statut_chorologie."libStatutChrologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_statut_chorologie."libStatutChrologie" IS 'libellé du statut de chorologie';


--
-- TOC entry 389 (class 1259 OID 33454)
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
-- TOC entry 3321 (class 0 OID 0)
-- Dependencies: 389
-- Name: st_ref_statut_chorologie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_statut_chorologie_id_tri_seq OWNED BY st_ref_statut_chorologie.id_tri;


--
-- TOC entry 342 (class 1259 OID 20374)
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
-- TOC entry 3322 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE st_ref_temperature; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_temperature IS 'Référentiel des indices de température selon Landolt';


--
-- TOC entry 3323 (class 0 OID 0)
-- Dependencies: 342
-- Name: COLUMN st_ref_temperature."indTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."indTemp" IS 'Indice de la température selon Landolt';


--
-- TOC entry 3324 (class 0 OID 0)
-- Dependencies: 342
-- Name: COLUMN st_ref_temperature."libTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."libTemp" IS 'libellé court de la température selon Landolt';


--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 342
-- Name: COLUMN st_ref_temperature."libLongTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."libLongTemp" IS 'libellé long de température selon Landolt';


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 342
-- Name: COLUMN st_ref_temperature.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 380 (class 1259 OID 33318)
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
-- TOC entry 3328 (class 0 OID 0)
-- Dependencies: 380
-- Name: st_ref_temperature_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_temperature_id_tri_seq OWNED BY st_ref_temperature.id_tri;


--
-- TOC entry 319 (class 1259 OID 20144)
-- Name: st_ref_tete_serie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_tete_serie (
    "codeTeteSerie" text NOT NULL,
    "libTeteSerie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_tete_serie OWNER TO postgres;

--
-- TOC entry 3329 (class 0 OID 0)
-- Dependencies: 319
-- Name: TABLE st_ref_tete_serie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_tete_serie IS 'Référentiel des stades de la série (ou géosérie)';


--
-- TOC entry 3330 (class 0 OID 0)
-- Dependencies: 319
-- Name: COLUMN st_ref_tete_serie."codeTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_tete_serie."codeTeteSerie" IS 'Indique si ce stade représente la tête de série ou non';


--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 319
-- Name: COLUMN st_ref_tete_serie."libTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_tete_serie."libTeteSerie" IS 'Décrit le type de stade (tête de série ou stade intermediaire)';


--
-- TOC entry 390 (class 1259 OID 33464)
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
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 390
-- Name: st_ref_tete_serie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_tete_serie_id_tri_seq OWNED BY st_ref_tete_serie.id_tri;


--
-- TOC entry 334 (class 1259 OID 20312)
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
-- TOC entry 3334 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE st_ref_trophie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_trophie IS 'Référentiel de la trophie selon Landolt';


--
-- TOC entry 3335 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN st_ref_trophie."indTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."indTrophie" IS 'Indice de la trophie selon Landolt';


--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN st_ref_trophie."libTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."libTrophie" IS 'libellé court dela trophie selon Landolt';


--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN st_ref_trophie."libLongTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."libLongTrophie" IS 'libellé long de trophie selon Landolt';


--
-- TOC entry 381 (class 1259 OID 33329)
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
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 381
-- Name: st_ref_trophie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_trophie_id_tri_seq OWNED BY st_ref_trophie.id_tri;


--
-- TOC entry 316 (class 1259 OID 20120)
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
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 316
-- Name: TABLE st_ref_type_facies; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_facies IS 'Référentiel des types de faciès';


--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 316
-- Name: COLUMN st_ref_type_facies."codeFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."codeFacies" IS 'code du type de faciès';


--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 316
-- Name: COLUMN st_ref_type_facies."libFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."libFacies" IS 'libelle du type de faciès';


--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 316
-- Name: COLUMN st_ref_type_facies."libLongFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."libLongFacies" IS 'libelle long du type de faciès';


--
-- TOC entry 391 (class 1259 OID 33474)
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
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 391
-- Name: st_ref_type_facies_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_facies_id_tri_seq OWNED BY st_ref_type_facies.id_tri;


--
-- TOC entry 341 (class 1259 OID 20366)
-- Name: st_ref_type_physionomique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_physionomique (
    "idTypePhysio" text NOT NULL,
    "libTypePhysio" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_type_physionomique OWNER TO postgres;

--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE st_ref_type_physionomique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_physionomique IS 'Référentiel des types physionomiques';


--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 341
-- Name: COLUMN st_ref_type_physionomique."idTypePhysio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_physionomique."idTypePhysio" IS 'identifiant du type physionomique';


--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 341
-- Name: COLUMN st_ref_type_physionomique."libTypePhysio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_physionomique."libTypePhysio" IS 'libellé du type physionomique';


--
-- TOC entry 392 (class 1259 OID 33484)
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
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 392
-- Name: st_ref_type_physionomique_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_physionomique_id_tri_seq OWNED BY st_ref_type_physionomique.id_tri;


--
-- TOC entry 312 (class 1259 OID 20088)
-- Name: st_ref_type_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_seriegeoserie (
    "codeTypeSerieGeoserie" text NOT NULL,
    "libTypeSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_type_seriegeoserie OWNER TO postgres;

--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 312
-- Name: TABLE st_ref_type_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_seriegeoserie IS 'Référentiel des types de série et de géoséries';


--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 312
-- Name: COLUMN st_ref_type_seriegeoserie."codeTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie."codeTypeSerieGeoserie" IS 'code du type de série et de géoséries';


--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 312
-- Name: COLUMN st_ref_type_seriegeoserie."libTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie."libTypeSerieGeoserie" IS 'libelle du type de série et de géoséries';


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 312
-- Name: COLUMN st_ref_type_seriegeoserie.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- TOC entry 399 (class 1259 OID 33597)
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
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 399
-- Name: st_ref_type_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_seriegeoserie_id_tri_seq OWNED BY st_ref_type_seriegeoserie.id_tri;


--
-- TOC entry 336 (class 1259 OID 20328)
-- Name: st_ref_type_synonymie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_synonymie (
    "idTypeSyn" text NOT NULL,
    "libTypSyn" text,
    id_tri integer NOT NULL
);


ALTER TABLE st_ref_type_synonymie OWNER TO postgres;

--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 336
-- Name: TABLE st_ref_type_synonymie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_synonymie IS 'Référentiel des types de synonymie';


--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN st_ref_type_synonymie."idTypeSyn"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_synonymie."idTypeSyn" IS 'identifiant du type de synonymie';


--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN st_ref_type_synonymie."libTypSyn"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_synonymie."libTypSyn" IS 'libellé du type de synonymie';


--
-- TOC entry 393 (class 1259 OID 33494)
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
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 393
-- Name: st_ref_type_synonymie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_synonymie_id_tri_seq OWNED BY st_ref_type_synonymie.id_tri;


--
-- TOC entry 311 (class 1259 OID 20080)
-- Name: st_serie_petitegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_serie_petitegeoserie (
    "idCatalogue" text,
    "codeEnregistrementSerieGeoserie" text NOT NULL,
    "idSerieGeoserie" text,
    "nomSerieGeoserie" text,
    "auteurSerieGeoserie" text,
    "nomCompletSerieGeoserie" text,
    "remarqueNomenclaturale" text,
    "typeSynonymie" text,
    "idSerieGeoserieRetenu" text,
    "nomSerieGeoserieRetenu" text,
    "nomSerieGeoserieRaccourci" text,
    "idSerieGeoserieSup" text,
    "codeTypeSerieGeoserie" text,
    "codeCategorieSerieGeoserie" text,
    "codeRangSerieGeoserie" text,
    "nomFrancaisSerieGeoserie" text,
    "diagnoseCourteSerieGeoserie" text,
    confusion text,
    "confusionRemarque" text,
    "repartitionGenerale" text,
    "repartitionTerritoire" text,
    "aireMinimale" text,
    "typePhysionomique" text,
    "lithologiePedologieHumus" text,
    geomorphologie text,
    "humiditePrincipale" text,
    "humiditeSecondaire" text,
    "phPrincipal" text,
    "phSecondaire" text,
    exposition text,
    "descriptionEcologie" text,
    "remarqueVariabilite" text,
    "remarqueRarete" text,
    "etatConservation" text
);


ALTER TABLE st_serie_petitegeoserie OWNER TO postgres;

--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE st_serie_petitegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_serie_petitegeoserie IS 'Table contenant la nomenclature des séries et petites géoséries ainsi que leurs principaux descripteurs (univariés)';


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."idCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idCatalogue" IS 'clef étrangère vers identifiant unique du catalogue';


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."codeEnregistrementSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeEnregistrementSerieGeoserie" IS 'identifiant unique de l''enregistrement (de la ligne) dans le catalogue qui associe l''identifiant unique du (geo)sigmataxon et l''identifiant du catalogue';


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."idSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idSerieGeoserie" IS 'identifiant unique du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."nomSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomSerieGeoserie" IS 'nom latin du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."auteurSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."auteurSerieGeoserie" IS 'autorité du (geo)sigmataxon:  on met le nom de l''auteur qui a publié le (geo)sigmataxon synonyme sinon on met (ined = « inédit »)';


--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."nomCompletSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomCompletSerieGeoserie" IS 'nom complet  (nom+autorité) du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';


--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."remarqueNomenclaturale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."remarqueNomenclaturale" IS 'Champ libre donnant des précisions sur le nom choisi dans le cas où le nom n''existe pas dans le PVF';


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."typeSynonymie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."typeSynonymie" IS 'type de synonymie du (geo)sigmataxon';


--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."idSerieGeoserieRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idSerieGeoserieRetenu" IS 'identifiant du (geo)sigmataxon retenu auquel renvoie le (geo)sigmataxon synonyme dans la base mère';


--
-- TOC entry 3372 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."nomSerieGeoserieRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomSerieGeoserieRetenu" IS 'nom complet latin du (geo)sigmataxon retenu auquel renvoie le (geo)sigmataxon synonyme dans la base mère';


--
-- TOC entry 3373 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."nomSerieGeoserieRaccourci"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomSerieGeoserieRaccourci" IS 'nom raccourci du (geo)sigmataxon retenu';


--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."idSerieGeoserieSup"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idSerieGeoserieSup" IS 'identifiant du (geo)sigmataxon directement supérieur auquel appartient le (geo)sigmataxon (notamment dans l''hypothèse de l''existance de sous-séries)';


--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."codeTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeTypeSerieGeoserie" IS 'type de (geo)sigmataxon (permasérie, curtasérie, série...)';


--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."codeCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeCategorieSerieGeoserie" IS 'catégorie de (geo)sigmataxon (Edaphoxérophile, …)';


--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."codeRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeRangSerieGeoserie" IS 'niveau du (geo)sigmataxon (série, sous-série, ...)';


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."nomFrancaisSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomFrancaisSerieGeoserie" IS 'Nom français pour les séries <série> de la <type de formation> à <nom latin 1> et <nom latin 2>
Sous-série à <nom latin du stade dynamique discriminant> et les petites géoséries < géosérie> de <nom de la série dominante en français>';


--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."diagnoseCourteSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."diagnoseCourteSerieGeoserie" IS 'La diagnose doit tenir en une seule phrase et inclus le type de série (série, curtasérie, permasérie), la catégorie (climatophile, édaphoxérophile, edaphohygrophile), la géographie, le bioclimat, la lithologie, l''étage de végétation éventuellement et le nom français.';


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie.confusion; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie.confusion IS 'confusion possible : nom complet du (geo)sigmataxon qui pourrait être confondu avec';


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."confusionRemarque"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."confusionRemarque" IS 'text libre portant sur la nature de la confusion et les critères de différentiation';


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."repartitionGenerale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."repartitionGenerale" IS 'Texte libre qui indique la répartition sur le territoire français et transfrontalier';


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."repartitionTerritoire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."repartitionTerritoire" IS 'Répartition dans le territoire étudié. Champ texte libre. Répartition à petite échelle. On indique la présence dans les petites régions naturelles propres à chaque CBN (région naturelle de présence)';


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."aireMinimale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."aireMinimale" IS 'Aire minimale d''expression du (geo)sigmasyntaxa en hectares';


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."typePhysionomique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."typePhysionomique" IS 'il s''agit de la physionomie de la formations végétale dominante. On utilise pour ce champ la typologie des formations végétales.';


--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."lithologiePedologieHumus"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."lithologiePedologieHumus" IS 'texte libre sur la lithologie, la pédologie et l''humus.';


--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie.geomorphologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie.geomorphologie IS 'liste de vocabulaire partagé proposé par B.Etlicher';


--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."humiditePrincipale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."humiditePrincipale" IS 'codification du caractère hygrophile du (geo)sigmasyntaxon sur le territoire (appartenance principale = conditions optimales)';


--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."humiditeSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."humiditeSecondaire" IS 'codification du caractère hygrophile du (geo)sigmasyntaxon sur le territoire (appartenance secondaire= condition favorables)';


--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."phPrincipal"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."phPrincipal" IS 'codification du pH (appartenance principale= conditions optimales d''expression du (geo)sigmasyntaxon)';


--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."phSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."phSecondaire" IS 'codification du pH  (appartenance secondaire= conditions favorables d''expression du (geo)sigmasyntaxon)';


--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie.exposition; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie.exposition IS 'exposition dominante de la série ou petite géosérie';


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."descriptionEcologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."descriptionEcologie" IS 'Champ libre mais harmonisé de remarque sur l''écologie du (geo)sigmasyntaxon';


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."remarqueVariabilite"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité de la série ou la géosérie. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';


--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."remarqueRarete"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."remarqueRarete" IS 'Champ libre sur la rareté, l''endémisme et les végétations remarquables';


--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN st_serie_petitegeoserie."etatConservation"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."etatConservation" IS 'Champ texte libre. Menaces, état de conservation, principaux usages, facteurs de conservation.
Il s''agit de décrire les menaces sur la série dans son entier ou sur un sigmafaciès et pas sur un stade dynamique (dans ce cas on se réfère à la fiche syntaxon du stade dynamique).';


--
-- TOC entry 321 (class 1259 OID 20168)
-- Name: st_suivi_enregistrement; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_suivi_enregistrement (
    "idSuivi" text NOT NULL,
    "codeEnregistrement" text,
    "dateSuivi" date,
    "idAuteurSuivi" text,
    "prenomAuteurSuivi" text,
    "nomAuteurSuivi" text,
    "actionSuivi" text
);


ALTER TABLE st_suivi_enregistrement OWNER TO postgres;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE st_suivi_enregistrement; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_suivi_enregistrement IS 'Table de suivi des enregistrements (création et mise à jour)';


--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN st_suivi_enregistrement."idSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."idSuivi" IS ' identifiant unique de l''action de suivi de l''enregistrement dans la table';


--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN st_suivi_enregistrement."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel le suivi est réalisé';


--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN st_suivi_enregistrement."dateSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."dateSuivi" IS 'date de suivi de la table';


--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN st_suivi_enregistrement."idAuteurSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."idAuteurSuivi" IS 'identifiant de la personne ayant réalisé le suivi de la table';


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN st_suivi_enregistrement."prenomAuteurSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."prenomAuteurSuivi" IS 'prénom de la personne ayany réalisé le suivi de l''enregistrement';


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN st_suivi_enregistrement."nomAuteurSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."nomAuteurSuivi" IS 'nom de la personne ayany réalisé le suivi de l''enregistrement';


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN st_suivi_enregistrement."actionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."actionSuivi" IS 'action de suivi (création ou mise à jour)';


--
-- TOC entry 372 (class 1259 OID 33047)
-- Name: st_syntaxon; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_syntaxon (
    "idCatalogue" text,
    "codeEnregistrementSyntax" text NOT NULL,
    "idSyntaxon" text,
    "nomSyntaxon" text,
    "auteurSyntaxon" text,
    "nomCompletSyntaxon" text,
    "rqNomenclaturale" text,
    "typeSynonymie" text,
    "idSyntaxonRetenu" text,
    "nomSyntaxonRetenu" text,
    "nomSyntaxonRaccourci" text,
    "rangSyntaxon" text,
    "idSyntaxonSup" text,
    "nomFrancaisSyntaxon" text,
    "diagnoseCourteSyntaxon" text,
    "idCritique" text,
    "rqCritique" text,
    "repartitionGenerale" text,
    "repartitionTerritoire" text,
    "periodeDebObsOptimale" text,
    "periodeFinObsOptimale" text,
    "rqPhenologie" text,
    "typeBiologiqueDom" text,
    "typePhysionomique" text,
    "rqPhysionomie" text,
    "humiditePrincipale" text,
    "humiditeSecondaire" text,
    "phPrincipal" text,
    "phSecondaire" text,
    trophie text,
    temperature text,
    luminosite text,
    exposition text,
    salinite text,
    neige text,
    continentalite text,
    ombroclimat text,
    climat text,
    "descriptionEcologie" text,
    "remarqueVariabilite" text,
    uid integer NOT NULL,
    "aireMinimale" text
);


ALTER TABLE st_syntaxon OWNER TO postgres;

--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 372
-- Name: TABLE st_syntaxon; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_syntaxon IS 'Table contenant les syntaxons et leurs principaux descripteurs (univariés)';


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."idCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idCatalogue" IS 'identifiant du catalogue d''appartenance de l''enregistrmenet';


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."codeEnregistrementSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."codeEnregistrementSyntax" IS 'identifiant unique de l''enregistrement (de la ligne) dans le catalogue qui associe l''identifiant unique du syntaxon synonyme et l''identifiant du catalogue';


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."idSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idSyntaxon" IS 'identifiant unique du syntaxon dans le catalogue d''origine';


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."nomSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomSyntaxon" IS 'nom latin du syntaxon synonyme dans le catalogue d''origine';


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."auteurSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."auteurSyntaxon" IS 'autorité et date du syntaxon synonyme';


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."nomCompletSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomCompletSyntaxon" IS 'Nom complet du syntaxon synonyme dans le catalogue d''origine (concaténation des champs "NOM_SYNTAXON" et "AUTEUR_SYNTAXON")';


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."rqNomenclaturale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqNomenclaturale" IS 'Champ libre donnant des précisions sur le nom choisi dans le cas où le nom n''existe pas dans le PVF';


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."typeSynonymie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."typeSynonymie" IS 'type de synonymie du syntaxon';


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."idSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idSyntaxonRetenu" IS 'identifiant unique du syntaxon retenu dans le catalogue d''origine (syntaxon de référence retenu par le CBN)  auquel renvoie le syntaxon ';


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."nomSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomSyntaxonRetenu" IS 'nom complet du syntaxon retenu dans le catalogue d''origine (syntaxon de référence retenu par le CBN) auquel renvoie le syntaxon synonyme';


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."nomSyntaxonRaccourci"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomSyntaxonRaccourci" IS 'nom raccourci du syntaxon retenu';


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."rangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rangSyntaxon" IS 'niveau du syntaxon dans la classification syntaxonomique';


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."idSyntaxonSup"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idSyntaxonSup" IS 'identifiant du syntaxon directement supérieur auquel appartient le syntaxon';


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."nomFrancaisSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomFrancaisSyntaxon" IS 'nom français harmonisé qui correspond à la traduction française du nom latin. ';


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."diagnoseCourteSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."diagnoseCourteSyntaxon" IS 'Description libre en une phrase qui inclus formation végétale + terme écologique et chorologique incluant l’étage de végétation';


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."idCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idCritique" IS 'réponse de type oui/non: Le syntaxon est-il clairement délimité ou non? Est-il franc? (renvoi à la typicité du syntaxon)';


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."rqCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqCritique" IS 'champ texte libre de commentaire sur la typicité du syntaxon';


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."repartitionGenerale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."repartitionGenerale" IS 'Texte libre qui indique la répartition sur le territoire français et transfrontalier';


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."repartitionTerritoire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."repartitionTerritoire" IS 'Répartition dans le territoire étudié. Champ texte libre. Répartition à petite échelle. On indique la présence dans les petites régions naturelles propres à chaque CBN (région naturelle de présence)';


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."periodeDebObsOptimale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."periodeDebObsOptimale" IS 'début de la période  optimale d''observation de la végétation';


--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."periodeFinObsOptimale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."periodeFinObsOptimale" IS 'fin de la période  optimale d''observation de la végétation';


--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."rqPhenologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqPhenologie" IS 'Champ libre (mais harmonisé) de remarque sur la phénologie';


--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."typeBiologiqueDom"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."typeBiologiqueDom" IS 'Champ libre du type biologique dominant (type biologique dominant des taxons composant la végétation)';


--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."typePhysionomique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."typePhysionomique" IS 'Type physionomique de la formation végétale (référentiel interne aux CBN, le plus précis possible)';


--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."rqPhysionomie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqPhysionomie" IS 'champ libre de remarque portant sur la physionomie de la végétation';


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."humiditePrincipale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."humiditePrincipale" IS 'codification du caractère hygrophile du syntaxon sur le territoire (appartenance principale = conditions optimales)';


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."humiditeSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."humiditeSecondaire" IS 'codification du caractère hygrophile du syntaxon sur le territoire (appartenance secondaire= condition favorables)';


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."phPrincipal"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."phPrincipal" IS 'codification du pH (appartenance principale= conditions optimales)';


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."phSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."phSecondaire" IS 'codification du pH  (appartenance secondaire= conditions favorables)';


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.trophie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.trophie IS 'codification de la trophie';


--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.temperature; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.temperature IS 'codification du caractère thermique';


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.luminosite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.luminosite IS 'codification de la luminosité';


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.exposition; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.exposition IS 'codification de l''exposition';


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.salinite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.salinite IS 'caractère halophile de la végétation';


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.neige; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.neige IS 'caractère chinophile de la végétation';


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.continentalite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.continentalite IS 'caractère continental ou non de la végétation';


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.ombroclimat; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.ombroclimat IS 'ombroclimat  selon Rivas-Martinez, 1981';


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon.climat; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.climat IS 'climats selon Joly et al, 2010';


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."descriptionEcologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."descriptionEcologie" IS 'Champ texte libre de description de l''écologie générale du syntaxon';


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 372
-- Name: COLUMN st_syntaxon."remarqueVariabilite"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité du faciès. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';


--
-- TOC entry 407 (class 1259 OID 34177)
-- Name: st_syntaxon_uid_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_syntaxon_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE st_syntaxon_uid_seq OWNER TO postgres;

--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 407
-- Name: st_syntaxon_uid_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_syntaxon_uid_seq OWNED BY st_syntaxon.uid;


--
-- TOC entry 2765 (class 2604 OID 20932)
-- Name: id; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY fsd_syntaxa ALTER COLUMN id SET DEFAULT nextval('fsd_syntaxa_id_seq'::regclass);


--
-- TOC entry 2734 (class 2604 OID 33526)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY liste_geo ALTER COLUMN id_tri SET DEFAULT nextval('liste_geo_id_tri_seq'::regclass);


--
-- TOC entry 2755 (class 2604 OID 33806)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_annuaire_personnes ALTER COLUMN id_tri SET DEFAULT nextval('st_annuaire_personnes_id_tri_seq'::regclass);


--
-- TOC entry 2770 (class 2604 OID 59296)
-- Name: idBiblio; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_biblio ALTER COLUMN "idBiblio" SET DEFAULT nextval('"st_biblio_idBiblio_seq"'::regclass);


--
-- TOC entry 2735 (class 2604 OID 34200)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_catalogue_description ALTER COLUMN id_tri SET DEFAULT nextval('st_catalogue_description_id_tri_seq'::regclass);


--
-- TOC entry 2767 (class 2604 OID 34192)
-- Name: idChorologie; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_chorologie ALTER COLUMN "idChorologie" SET DEFAULT nextval('"st_chorologie_idChorologie_seq"'::regclass);


--
-- TOC entry 2772 (class 2604 OID 67482)
-- Name: idCorresEUNIS; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_eunis ALTER COLUMN "idCorresEUNIS" SET DEFAULT nextval('"st_correspondance_eunis_idCorresEUNIS_seq"'::regclass);


--
-- TOC entry 2771 (class 2604 OID 67473)
-- Name: idCorresHIC; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_hic ALTER COLUMN "idCorresHIC" SET DEFAULT nextval('"st_correspondance_hic_idCorresHIC_seq"'::regclass);


--
-- TOC entry 2744 (class 2604 OID 43358)
-- Name: idCorrespondancePVF; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_pvf ALTER COLUMN "idCorrespondancePVF" SET DEFAULT nextval('"st_correspondance_pvf_idCorrespondancePVF_seq"'::regclass);


--
-- TOC entry 2773 (class 2604 OID 67507)
-- Name: idCorresEtageBioclim; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_bioclim ALTER COLUMN "idCorresEtageBioclim" SET DEFAULT nextval('"st_etage_bioclim_idCorresEtageBioclim_seq"'::regclass);


--
-- TOC entry 2769 (class 2604 OID 59264)
-- Name: idCorresEtageveg; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_veg ALTER COLUMN "idCorresEtageveg" SET DEFAULT nextval('"st_etage_veg_idCorresEtageveg_seq"'::regclass);


--
-- TOC entry 2742 (class 2604 OID 33567)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_action_suivi ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_action_suivi_id_tri_seq'::regclass);


--
-- TOC entry 2737 (class 2604 OID 33609)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_categorie_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_categorie_seriegeoserie_id_tri_seq'::regclass);


--
-- TOC entry 2761 (class 2604 OID 33279)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_continentalite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_continentalite_id_tri_seq'::regclass);


--
-- TOC entry 2756 (class 2604 OID 33258)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_critique ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_critique_id_tri_seq'::regclass);


--
-- TOC entry 2748 (class 2604 OID 33353)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_etage_bioclim ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_etage_bioclim_id_tri_seq'::regclass);


--
-- TOC entry 2768 (class 2604 OID 51141)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_etage_veg ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_etage_veg_id_tri_seq'::regclass);


--
-- TOC entry 2764 (class 2604 OID 33516)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_eunis ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_eunis_id_tri_seq'::regclass);


--
-- TOC entry 2753 (class 2604 OID 33363)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_exposition ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_exposition_id_tri_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 33395)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_geomorpho ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_geomorpho_id_tri_seq'::regclass);


--
-- TOC entry 2747 (class 2604 OID 33506)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_hic ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_hic_id_tri_seq'::regclass);


--
-- TOC entry 2750 (class 2604 OID 33290)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_humidite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_humidite_id_tri_seq'::regclass);


--
-- TOC entry 2759 (class 2604 OID 33300)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_lumiere ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_lumiere_id_tri_seq'::regclass);


--
-- TOC entry 2760 (class 2604 OID 33373)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_neige ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_neige_id_tri_seq'::regclass);


--
-- TOC entry 2749 (class 2604 OID 33446)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_periode ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_periode_id_tri_seq'::regclass);


--
-- TOC entry 2746 (class 2604 OID 33557)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_pvf ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_pvf_id_tri_seq'::regclass);


--
-- TOC entry 2739 (class 2604 OID 33619)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rang_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rang_seriegeoserie_id_tri_seq'::regclass);


--
-- TOC entry 2738 (class 2604 OID 33639)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rang_syntaxon ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rang_syntaxon_id_tri_seq'::regclass);


--
-- TOC entry 2751 (class 2604 OID 33310)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_reaction ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_reaction_id_tri_seq'::regclass);


--
-- TOC entry 2763 (class 2604 OID 33384)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rivasmartinez_ombroclimat ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rivasmartinez_ombroclimat_id_tri_seq'::regclass);


--
-- TOC entry 2762 (class 2604 OID 33342)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_salinite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_salinite_id_tri_seq'::regclass);


--
-- TOC entry 2743 (class 2604 OID 33456)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_statut_chorologie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_statut_chorologie_id_tri_seq'::regclass);


--
-- TOC entry 2758 (class 2604 OID 33320)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_temperature ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_temperature_id_tri_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 33466)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_tete_serie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_tete_serie_id_tri_seq'::regclass);


--
-- TOC entry 2752 (class 2604 OID 33331)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_trophie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_trophie_id_tri_seq'::regclass);


--
-- TOC entry 2740 (class 2604 OID 33476)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_facies ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_facies_id_tri_seq'::regclass);


--
-- TOC entry 2757 (class 2604 OID 33486)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_physionomique ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_physionomique_id_tri_seq'::regclass);


--
-- TOC entry 2736 (class 2604 OID 33599)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_seriegeoserie_id_tri_seq'::regclass);


--
-- TOC entry 2754 (class 2604 OID 33496)
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_synonymie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_synonymie_id_tri_seq'::regclass);


--
-- TOC entry 2766 (class 2604 OID 34179)
-- Name: uid; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon ALTER COLUMN uid SET DEFAULT nextval('st_syntaxon_uid_seq'::regclass);


--
-- TOC entry 2775 (class 2606 OID 20062)
-- Name: PK_liste_geo; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY liste_geo
    ADD CONSTRAINT "PK_liste_geo" PRIMARY KEY (id_territoire);


--
-- TOC entry 2778 (class 2606 OID 20071)
-- Name: PK_referentiel; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY referentiel_taxo
    ADD CONSTRAINT "PK_referentiel" PRIMARY KEY (id_rattachement_referentiel);


--
-- TOC entry 2804 (class 2606 OID 20183)
-- Name: codeActionSuivi_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_action_suivi
    ADD CONSTRAINT "codeActionSuivi_pkey" PRIMARY KEY ("codeActionSuivi");


--
-- TOC entry 2786 (class 2606 OID 20103)
-- Name: codeCategorieSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_categorie_seriegeoserie
    ADD CONSTRAINT "codeCategorieSerieGeoserie_pkey" PRIMARY KEY ("codeCategorieSerieGeoserie");


--
-- TOC entry 2861 (class 2606 OID 20437)
-- Name: codeEUNIS_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_eunis
    ADD CONSTRAINT "codeEUNIS_pkey" PRIMARY KEY ("codeEUNIS");


--
-- TOC entry 2796 (class 2606 OID 20143)
-- Name: codeEnregistrementCortegeSyntax_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_cortege_syntaxonomique
    ADD CONSTRAINT "codeEnregistrementCortegeSyntax_pkey" PRIMARY KEY ("codeEnregistrementCortegeSyntax");


--
-- TOC entry 2782 (class 2606 OID 20087)
-- Name: codeEnregistrementSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "codeEnregistrementSerieGeoserie_pkey" PRIMARY KEY ("codeEnregistrementSerieGeoserie");


--
-- TOC entry 2865 (class 2606 OID 33054)
-- Name: codeEnregistrementSyntax_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "codeEnregistrementSyntax_pkey" PRIMARY KEY ("codeEnregistrementSyntax");


--
-- TOC entry 2815 (class 2606 OID 20279)
-- Name: codeEtageBioclim_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_etage_bioclim
    ADD CONSTRAINT "codeEtageBioclim_pkey" PRIMARY KEY ("codeEtageBioclim");


--
-- TOC entry 2869 (class 2606 OID 51146)
-- Name: codeEtageVeg_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_etage_veg
    ADD CONSTRAINT "codeEtageVeg_pkey" PRIMARY KEY ("codeEtageVeg");


--
-- TOC entry 2792 (class 2606 OID 20127)
-- Name: codeFacis_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_facies
    ADD CONSTRAINT "codeFacis_pkey" PRIMARY KEY ("codeFacies");


--
-- TOC entry 2813 (class 2606 OID 20247)
-- Name: codeHIC_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_hic
    ADD CONSTRAINT "codeHIC_pkey" PRIMARY KEY ("codeHIC");


--
-- TOC entry 2790 (class 2606 OID 20119)
-- Name: codeRangSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rang_seriegeoserie
    ADD CONSTRAINT "codeRangSerieGeoserie_pkey" PRIMARY KEY ("codeRangSerieGeoserie");


--
-- TOC entry 2788 (class 2606 OID 20111)
-- Name: codeRangSyntaxon_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rang_syntaxon
    ADD CONSTRAINT "codeRangSyntaxon_pkey" PRIMARY KEY ("codeRangSyntaxon");


--
-- TOC entry 2798 (class 2606 OID 20151)
-- Name: codeTeteSerie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_tete_serie
    ADD CONSTRAINT "codeTeteSerie_pkey" PRIMARY KEY ("codeTeteSerie");


--
-- TOC entry 2784 (class 2606 OID 20095)
-- Name: codeTypeSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_seriegeoserie
    ADD CONSTRAINT "codeTypeSerieGeoserie_pkey" PRIMARY KEY ("codeTypeSerieGeoserie");


--
-- TOC entry 2863 (class 2606 OID 20937)
-- Name: fsd_data_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fsd_syntaxa
    ADD CONSTRAINT fsd_data_pkey PRIMARY KEY (id);


--
-- TOC entry 2874 (class 2606 OID 59301)
-- Name: idBiblio_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_biblio
    ADD CONSTRAINT "idBiblio_pkey" PRIMARY KEY ("idBiblio");


--
-- TOC entry 2867 (class 2606 OID 34197)
-- Name: idChorologie; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_chorologie
    ADD CONSTRAINT "idChorologie" PRIMARY KEY ("idChorologie");


--
-- TOC entry 2836 (class 2606 OID 20359)
-- Name: idCollaborateur; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idCollaborateur" PRIMARY KEY ("idCollaborateur");


--
-- TOC entry 2878 (class 2606 OID 67512)
-- Name: idCorresEtageBioclim_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_etage_bioclim
    ADD CONSTRAINT "idCorresEtageBioclim_pkey" PRIMARY KEY ("idCorresEtageBioclim");


--
-- TOC entry 2872 (class 2606 OID 59269)
-- Name: idCorresEtageVeg_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_etage_veg
    ADD CONSTRAINT "idCorresEtageVeg_pkey" PRIMARY KEY ("idCorresEtageveg");


--
-- TOC entry 2876 (class 2606 OID 67487)
-- Name: idCorrespondanceEUNIS_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_correspondance_eunis
    ADD CONSTRAINT "idCorrespondanceEUNIS_pkey" PRIMARY KEY ("idCorresEUNIS");


--
-- TOC entry 2808 (class 2606 OID 43366)
-- Name: idCorrespondancePVF_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_correspondance_pvf
    ADD CONSTRAINT "idCorrespondancePVF_pkey" PRIMARY KEY ("idCorrespondancePVF");


--
-- TOC entry 2827 (class 2606 OID 20327)
-- Name: idExposition_fkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_exposition
    ADD CONSTRAINT "idExposition_fkey" PRIMARY KEY ("idExposition");


--
-- TOC entry 2794 (class 2606 OID 20135)
-- Name: idGeosigmafacies; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_geo_sigmafacies
    ADD CONSTRAINT "idGeosigmafacies" PRIMARY KEY ("idGeosigmafacies");


--
-- TOC entry 2800 (class 2606 OID 20159)
-- Name: idIndicateurFlor_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_indicateurs_floristiques
    ADD CONSTRAINT "idIndicateurFlor_pkey" PRIMARY KEY ("idIndicateurFlor");


--
-- TOC entry 2857 (class 2606 OID 20421)
-- Name: idOmbroClimat_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rivasmartinez_ombroclimat
    ADD CONSTRAINT "idOmbroClimat_pkey" PRIMARY KEY ("idOmbroclimat");


--
-- TOC entry 2832 (class 2606 OID 20343)
-- Name: idOrganisme_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_annuaire_organismes
    ADD CONSTRAINT "idOrganisme_pkey" PRIMARY KEY ("idOrganisme");


--
-- TOC entry 2834 (class 2606 OID 20351)
-- Name: idPersonne_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_annuaire_personnes
    ADD CONSTRAINT "idPersonne_pkey" PRIMARY KEY ("idPersonne");


--
-- TOC entry 2811 (class 2606 OID 20233)
-- Name: idRattachementPVF; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_pvf
    ADD CONSTRAINT "idRattachementPVF" PRIMARY KEY ("idRattachementPVF");


--
-- TOC entry 2806 (class 2606 OID 20199)
-- Name: idStatutchorologie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_statut_chorologie
    ADD CONSTRAINT "idStatutchorologie_pkey" PRIMARY KEY ("idStatutChorologie");


--
-- TOC entry 2802 (class 2606 OID 20175)
-- Name: idSuivi_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_suivi_enregistrement
    ADD CONSTRAINT "idSuivi_pkey" PRIMARY KEY ("idSuivi");


--
-- TOC entry 2839 (class 2606 OID 20373)
-- Name: idTypePhysio_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_physionomique
    ADD CONSTRAINT "idTypePhysio_pkey" PRIMARY KEY ("idTypePhysio");


--
-- TOC entry 2829 (class 2606 OID 20335)
-- Name: idTypeSyn; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_synonymie
    ADD CONSTRAINT "idTypeSyn" PRIMARY KEY ("idTypeSyn");


--
-- TOC entry 2780 (class 2606 OID 20079)
-- Name: identifiantCatalogue_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_catalogue_description
    ADD CONSTRAINT "identifiantCatalogue_pkey" PRIMARY KEY ("identifiantCatalogue");


--
-- TOC entry 2849 (class 2606 OID 20405)
-- Name: indCont_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_continentalite
    ADD CONSTRAINT "indCont_pkey" PRIMARY KEY ("indCont");


--
-- TOC entry 2819 (class 2606 OID 20303)
-- Name: indHum_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_humidite
    ADD CONSTRAINT "indHum_pkey" PRIMARY KEY ("indHum");


--
-- TOC entry 2845 (class 2606 OID 20389)
-- Name: indLum_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_lumiere
    ADD CONSTRAINT "indLum_pkey" PRIMARY KEY ("indLum");


--
-- TOC entry 2821 (class 2606 OID 20311)
-- Name: indReac_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_reaction
    ADD CONSTRAINT "indReac_pkey" PRIMARY KEY ("indReaction");


--
-- TOC entry 2853 (class 2606 OID 20413)
-- Name: indSali_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_salinite
    ADD CONSTRAINT "indSali_pkey" PRIMARY KEY ("indSali");


--
-- TOC entry 2841 (class 2606 OID 20381)
-- Name: indTemperaturee_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_temperature
    ADD CONSTRAINT "indTemperaturee_pkey" PRIMARY KEY ("indTemp");


--
-- TOC entry 2823 (class 2606 OID 20319)
-- Name: indTrophie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_trophie
    ADD CONSTRAINT "indTrophie_pkey" PRIMARY KEY ("indTrophie");


--
-- TOC entry 2817 (class 2606 OID 20295)
-- Name: libPeriode; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_periode
    ADD CONSTRAINT "libPeriode" PRIMARY KEY ("codePeriode");


--
-- TOC entry 2847 (class 2606 OID 20397)
-- Name: neige_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_neige
    ADD CONSTRAINT neige_pkey PRIMARY KEY ("idNeige");


--
-- TOC entry 2830 (class 1259 OID 20793)
-- Name: acronymeorganisme_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX acronymeorganisme_uniq ON st_annuaire_organismes USING btree ("acronymeOrganisme");


--
-- TOC entry 2776 (class 1259 OID 20650)
-- Name: id_territoire_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX id_territoire_uniq ON liste_geo USING btree (id_territoire);


--
-- TOC entry 2837 (class 1259 OID 20585)
-- Name: idcritique_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idcritique_uniq ON st_ref_critique USING btree ("idCritique");


--
-- TOC entry 2809 (class 1259 OID 20686)
-- Name: idgeomorphologie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idgeomorphologie_uniq ON st_ref_geomorpho USING btree ("idGeomorphologie");


--
-- TOC entry 2858 (class 1259 OID 33838)
-- Name: idombroclimat_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idombroclimat_uniq ON st_ref_rivasmartinez_ombroclimat USING btree ("idOmbroclimat");


--
-- TOC entry 2850 (class 1259 OID 33826)
-- Name: indcont_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indcont_uniq ON st_ref_continentalite USING btree ("indCont");


--
-- TOC entry 2854 (class 1259 OID 33832)
-- Name: indsali_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indsali_uniq ON st_ref_salinite USING btree ("indSali");


--
-- TOC entry 2842 (class 1259 OID 33820)
-- Name: indtemp_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indtemp_uniq ON st_ref_temperature USING btree ("indTemp");


--
-- TOC entry 2824 (class 1259 OID 33814)
-- Name: indtrophie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indtrophie_uniq ON st_ref_trophie USING btree ("indTrophie");


--
-- TOC entry 2851 (class 1259 OID 20617)
-- Name: libcont_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libcont_uniq ON st_ref_continentalite USING btree ("libCont");


--
-- TOC entry 2870 (class 1259 OID 59285)
-- Name: libetageveg_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libetageveg_uniq ON st_ref_etage_veg USING btree ("libEtageVeg");


--
-- TOC entry 2859 (class 1259 OID 20629)
-- Name: libombroclimat_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libombroclimat_uniq ON st_ref_rivasmartinez_ombroclimat USING btree ("libOmbroclimat");


--
-- TOC entry 2855 (class 1259 OID 20623)
-- Name: libsali_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libsali_uniq ON st_ref_salinite USING btree ("libSali");


--
-- TOC entry 2843 (class 1259 OID 20601)
-- Name: libtemp_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libtemp_uniq ON st_ref_temperature USING btree ("libTemp");


--
-- TOC entry 2825 (class 1259 OID 20574)
-- Name: libtrophie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libtrophie_uniq ON st_ref_trophie USING btree ("libTrophie");


--
-- TOC entry 2924 (class 2606 OID 33055)
-- Name: Neige_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "Neige_fkey" FOREIGN KEY (neige) REFERENCES st_ref_neige("idNeige") MATCH FULL;


--
-- TOC entry 2903 (class 2606 OID 20794)
-- Name: acronymeOrganisme_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "acronymeOrganisme_fkey" FOREIGN KEY ("acronymeOrganisme") REFERENCES st_annuaire_organismes("acronymeOrganisme") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2896 (class 2606 OID 20591)
-- Name: codeActionSuivi_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_suivi_enregistrement
    ADD CONSTRAINT "codeActionSuivi_fkey" FOREIGN KEY ("actionSuivi") REFERENCES st_ref_action_suivi("codeActionSuivi") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2890 (class 2606 OID 20494)
-- Name: codeEnregistrementSerieGeoserie_fkey1; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geo_sigmafacies
    ADD CONSTRAINT "codeEnregistrementSerieGeoserie_fkey1" FOREIGN KEY ("codeEnregistrementSerieGeoserie") REFERENCES st_serie_petitegeoserie("codeEnregistrementSerieGeoserie") MATCH FULL;


--
-- TOC entry 2926 (class 2606 OID 59280)
-- Name: codeEtageVeg_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_veg
    ADD CONSTRAINT "codeEtageVeg_fkey" FOREIGN KEY ("codeEtageVeg") REFERENCES st_ref_etage_veg("codeEtageVeg") MATCH FULL;


--
-- TOC entry 2889 (class 2606 OID 20499)
-- Name: codeFacies_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geo_sigmafacies
    ADD CONSTRAINT "codeFacies_fkey" FOREIGN KEY ("codeFacies") REFERENCES st_ref_type_facies("codeFacies") MATCH FULL;


--
-- TOC entry 2891 (class 2606 OID 20509)
-- Name: codeTeteSerie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_cortege_syntaxonomique
    ADD CONSTRAINT "codeTeteSerie_fkey" FOREIGN KEY ("codeTeteSerie") REFERENCES st_ref_tete_serie("codeTeteSerie") MATCH FULL;


--
-- TOC entry 2882 (class 2606 OID 20474)
-- Name: codecategorieseriegeoserie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT codecategorieseriegeoserie_fkey FOREIGN KEY ("codeCategorieSerieGeoserie") REFERENCES st_ref_categorie_seriegeoserie("codeCategorieSerieGeoserie") MATCH FULL;


--
-- TOC entry 2880 (class 2606 OID 20484)
-- Name: coderangseriegeoserie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT coderangseriegeoserie_fkey FOREIGN KEY ("codeRangSerieGeoserie") REFERENCES st_ref_rang_seriegeoserie("codeRangSerieGeoserie") MATCH FULL;


--
-- TOC entry 2923 (class 2606 OID 33060)
-- Name: coderangsyntaxon_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT coderangsyntaxon_fkey FOREIGN KEY ("rangSyntaxon") REFERENCES st_ref_rang_syntaxon("codeRangSyntaxon") MATCH FULL;


--
-- TOC entry 2881 (class 2606 OID 20479)
-- Name: codetypeseriegeoserie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT codetypeseriegeoserie_fkey FOREIGN KEY ("codeTypeSerieGeoserie") REFERENCES st_ref_type_seriegeoserie("codeTypeSerieGeoserie") MATCH FULL;


--
-- TOC entry 2908 (class 2606 OID 33827)
-- Name: continentalite_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT continentalite_fkey FOREIGN KEY (continentalite) REFERENCES st_ref_continentalite("indCont") MATCH FULL;


--
-- TOC entry 2922 (class 2606 OID 33070)
-- Name: debObsOptimale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "debObsOptimale_fkey" FOREIGN KEY ("periodeDebObsOptimale") REFERENCES st_ref_periode("codePeriode") MATCH FULL;


--
-- TOC entry 2921 (class 2606 OID 33075)
-- Name: exposition_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT exposition_fkey FOREIGN KEY (exposition) REFERENCES st_ref_exposition("idExposition") MATCH FULL;


--
-- TOC entry 2883 (class 2606 OID 20469)
-- Name: exposition_fkey2; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT exposition_fkey2 FOREIGN KEY (exposition) REFERENCES st_ref_exposition("idExposition") MATCH FULL;


--
-- TOC entry 2920 (class 2606 OID 33080)
-- Name: finObsOptimale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "finObsOptimale_fkey" FOREIGN KEY ("periodeFinObsOptimale") REFERENCES st_ref_periode("codePeriode") MATCH FULL;


--
-- TOC entry 2887 (class 2606 OID 20444)
-- Name: humiditePrincipale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "humiditePrincipale_fkey" FOREIGN KEY ("humiditePrincipale") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- TOC entry 2919 (class 2606 OID 33085)
-- Name: humiditePrincipale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "humiditePrincipale_fkey" FOREIGN KEY ("humiditePrincipale") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- TOC entry 2886 (class 2606 OID 20449)
-- Name: humiditeSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "humiditeSecondaire_fkey" FOREIGN KEY ("humiditeSecondaire") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- TOC entry 2918 (class 2606 OID 33090)
-- Name: humiditeSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "humiditeSecondaire_fkey" FOREIGN KEY ("humiditeSecondaire") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- TOC entry 2895 (class 2606 OID 20635)
-- Name: idAuteurSuivi; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_suivi_enregistrement
    ADD CONSTRAINT "idAuteurSuivi" FOREIGN KEY ("idAuteurSuivi") REFERENCES st_annuaire_personnes("idPersonne") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2902 (class 2606 OID 20799)
-- Name: idCatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idCatalogue_fkey" FOREIGN KEY ("identifiantCatalogue") REFERENCES st_catalogue_description("identifiantCatalogue") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2917 (class 2606 OID 33095)
-- Name: idCatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "idCatalogue_fkey" FOREIGN KEY ("idCatalogue") REFERENCES st_catalogue_description("identifiantCatalogue") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2916 (class 2606 OID 33100)
-- Name: idCritique_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "idCritique_fkey" FOREIGN KEY ("idCritique") REFERENCES st_ref_critique("idCritique") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2900 (class 2606 OID 20681)
-- Name: idEnregistrement_fkey2; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geomorphologie
    ADD CONSTRAINT "idEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement") REFERENCES st_serie_petitegeoserie("codeEnregistrementSerieGeoserie") MATCH FULL;


--
-- TOC entry 2898 (class 2606 OID 20692)
-- Name: idEnregistrement_fkey3; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geomorphologie
    ADD CONSTRAINT "idEnregistrement_fkey3" FOREIGN KEY ("codeEnregistrement") REFERENCES st_geo_sigmafacies("idGeosigmafacies") MATCH FULL;


--
-- TOC entry 2899 (class 2606 OID 20687)
-- Name: idGeomorphologie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geomorphologie
    ADD CONSTRAINT "idGeomorphologie_fkey" FOREIGN KEY ("idGeomorphologie") REFERENCES st_ref_geomorpho("idGeomorphologie") MATCH FULL;


--
-- TOC entry 2892 (class 2606 OID 20504)
-- Name: idGeosigmafacies_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_cortege_syntaxonomique
    ADD CONSTRAINT "idGeosigmafacies_fkey" FOREIGN KEY ("idGeosigmafacies") REFERENCES st_geo_sigmafacies("idGeosigmafacies") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2894 (class 2606 OID 20524)
-- Name: idGeosigmafacies_fkey2; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_indicateurs_floristiques
    ADD CONSTRAINT "idGeosigmafacies_fkey2" FOREIGN KEY ("idGeosigmafacies") REFERENCES st_geo_sigmafacies("idGeosigmafacies") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2904 (class 2606 OID 20788)
-- Name: idOrganisme_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idOrganisme_fkey" FOREIGN KEY ("idOrganisme") REFERENCES st_annuaire_organismes("idOrganisme") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2905 (class 2606 OID 20783)
-- Name: idPersonne_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idPersonne_fkey" FOREIGN KEY ("idPersonne") REFERENCES st_annuaire_personnes("idPersonne") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2897 (class 2606 OID 43367)
-- Name: idRattachementPVF_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_pvf
    ADD CONSTRAINT "idRattachementPVF_fkey" FOREIGN KEY ("idRattachementPVF") REFERENCES st_ref_pvf("idRattachementPVF") MATCH FULL;


--
-- TOC entry 2901 (class 2606 OID 20702)
-- Name: idRattachementReferentiel_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_cortege_floristique
    ADD CONSTRAINT "idRattachementReferentiel_fkey" FOREIGN KEY ("idRattachementReferentiel") REFERENCES referentiel_taxo(id_rattachement_referentiel) MATCH FULL;


--
-- TOC entry 2893 (class 2606 OID 20529)
-- Name: idRattachementreferentiel_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_indicateurs_floristiques
    ADD CONSTRAINT "idRattachementreferentiel_fkey" FOREIGN KEY ("idRattachementReferentiel") REFERENCES referentiel_taxo(id_rattachement_referentiel) MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2879 (class 2606 OID 20534)
-- Name: idTerritoireCatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_catalogue_description
    ADD CONSTRAINT "idTerritoireCatalogue_fkey" FOREIGN KEY ("idTerritoireCatalogue") REFERENCES liste_geo(id_territoire) MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2888 (class 2606 OID 20439)
-- Name: idcatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT idcatalogue_fkey FOREIGN KEY ("idCatalogue") REFERENCES st_catalogue_description("identifiantCatalogue") MATCH FULL;


--
-- TOC entry 2925 (class 2606 OID 59286)
-- Name: libEtageVeg_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_veg
    ADD CONSTRAINT "libEtageVeg_fkey" FOREIGN KEY ("libEtageVeg") REFERENCES st_ref_etage_veg("libEtageVeg") MATCH FULL;


--
-- TOC entry 2915 (class 2606 OID 33105)
-- Name: lumiere_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT lumiere_fkey FOREIGN KEY (luminosite) REFERENCES st_ref_lumiere("indLum") MATCH FULL;


--
-- TOC entry 2906 (class 2606 OID 33849)
-- Name: ombroclimat_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT ombroclimat_fkey FOREIGN KEY (ombroclimat) REFERENCES st_ref_rivasmartinez_ombroclimat("idOmbroclimat") MATCH FULL;


--
-- TOC entry 2914 (class 2606 OID 33115)
-- Name: pHprincipal_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "pHprincipal_fkey" FOREIGN KEY ("phPrincipal") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- TOC entry 2885 (class 2606 OID 20454)
-- Name: phPrincipal_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "phPrincipal_fkey" FOREIGN KEY ("phPrincipal") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- TOC entry 2884 (class 2606 OID 20459)
-- Name: phSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "phSecondaire_fkey" FOREIGN KEY ("phSecondaire") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- TOC entry 2913 (class 2606 OID 33120)
-- Name: phSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "phSecondaire_fkey" FOREIGN KEY ("phSecondaire") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- TOC entry 2907 (class 2606 OID 33833)
-- Name: salinite_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT salinite_fkey FOREIGN KEY (salinite) REFERENCES st_ref_salinite("indSali") MATCH FULL;


--
-- TOC entry 2909 (class 2606 OID 33821)
-- Name: temperature_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT temperature_fkey FOREIGN KEY (temperature) REFERENCES st_ref_temperature("indTemp") MATCH FULL;


--
-- TOC entry 2910 (class 2606 OID 33815)
-- Name: trophie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT trophie_fkey FOREIGN KEY (trophie) REFERENCES st_ref_trophie("indTrophie") MATCH FULL;


--
-- TOC entry 2912 (class 2606 OID 33140)
-- Name: typePhysionomique_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "typePhysionomique_fkey" FOREIGN KEY ("typePhysionomique") REFERENCES st_ref_type_physionomique("idTypePhysio") MATCH FULL ON UPDATE CASCADE;


--
-- TOC entry 2911 (class 2606 OID 33145)
-- Name: typeSynonymie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "typeSynonymie_fkey" FOREIGN KEY ("typeSynonymie") REFERENCES st_ref_type_synonymie("idTypeSyn") MATCH FULL;


--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 367
-- Name: fsd_syntaxa; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE fsd_syntaxa FROM PUBLIC;
REVOKE ALL ON TABLE fsd_syntaxa FROM postgres;
GRANT ALL ON TABLE fsd_syntaxa TO postgres;
GRANT ALL ON TABLE fsd_syntaxa TO user_codex;


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 308
-- Name: liste_geo; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE liste_geo FROM PUBLIC;
REVOKE ALL ON TABLE liste_geo FROM postgres;
GRANT ALL ON TABLE liste_geo TO postgres;
GRANT ALL ON TABLE liste_geo TO user_codex;


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 309
-- Name: referentiel_taxo; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE referentiel_taxo FROM PUBLIC;
REVOKE ALL ON TABLE referentiel_taxo FROM postgres;
GRANT ALL ON TABLE referentiel_taxo TO postgres;
GRANT ALL ON TABLE referentiel_taxo TO user_codex;


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 337
-- Name: st_annuaire_organismes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_annuaire_organismes FROM PUBLIC;
REVOKE ALL ON TABLE st_annuaire_organismes FROM postgres;
GRANT ALL ON TABLE st_annuaire_organismes TO postgres;
GRANT ALL ON TABLE st_annuaire_organismes TO user_codex;


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 338
-- Name: st_annuaire_personnes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_annuaire_personnes FROM PUBLIC;
REVOKE ALL ON TABLE st_annuaire_personnes FROM postgres;
GRANT ALL ON TABLE st_annuaire_personnes TO postgres;
GRANT ALL ON TABLE st_annuaire_personnes TO user_codex;


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 431
-- Name: st_biblio; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_biblio FROM PUBLIC;
REVOKE ALL ON TABLE st_biblio FROM postgres;
GRANT ALL ON TABLE st_biblio TO postgres;
GRANT ALL ON TABLE st_biblio TO user_codex;


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 430
-- Name: st_biblio_idBiblio_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_biblio_idBiblio_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_biblio_idBiblio_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_biblio_idBiblio_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_biblio_idBiblio_seq" TO user_codex;


--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 310
-- Name: st_catalogue_description; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_catalogue_description FROM PUBLIC;
REVOKE ALL ON TABLE st_catalogue_description FROM postgres;
GRANT ALL ON TABLE st_catalogue_description TO postgres;
GRANT ALL ON TABLE st_catalogue_description TO user_codex;


--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 410
-- Name: st_catalogue_description_id_tri_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE st_catalogue_description_id_tri_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE st_catalogue_description_id_tri_seq FROM postgres;
GRANT ALL ON SEQUENCE st_catalogue_description_id_tri_seq TO postgres;
GRANT ALL ON SEQUENCE st_catalogue_description_id_tri_seq TO user_codex;


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 409
-- Name: st_chorologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_chorologie FROM PUBLIC;
REVOKE ALL ON TABLE st_chorologie FROM postgres;
GRANT ALL ON TABLE st_chorologie TO postgres;
GRANT ALL ON TABLE st_chorologie TO user_codex;


--
-- TOC entry 3103 (class 0 OID 0)
-- Dependencies: 408
-- Name: st_chorologie_idChorologie_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_chorologie_idChorologie_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_chorologie_idChorologie_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_chorologie_idChorologie_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_chorologie_idChorologie_seq" TO user_codex;


--
-- TOC entry 3112 (class 0 OID 0)
-- Dependencies: 339
-- Name: st_collaborateur; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_collaborateur FROM PUBLIC;
REVOKE ALL ON TABLE st_collaborateur FROM postgres;
GRANT ALL ON TABLE st_collaborateur TO postgres;
GRANT ALL ON TABLE st_collaborateur TO user_codex;


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 435
-- Name: st_correspondance_eunis; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_correspondance_eunis FROM PUBLIC;
REVOKE ALL ON TABLE st_correspondance_eunis FROM postgres;
GRANT ALL ON TABLE st_correspondance_eunis TO postgres;
GRANT ALL ON TABLE st_correspondance_eunis TO user_codex;


--
-- TOC entry 3121 (class 0 OID 0)
-- Dependencies: 434
-- Name: st_correspondance_eunis_idCorresEUNIS_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" TO user_codex;


--
-- TOC entry 3128 (class 0 OID 0)
-- Dependencies: 433
-- Name: st_correspondance_hic; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_correspondance_hic FROM PUBLIC;
REVOKE ALL ON TABLE st_correspondance_hic FROM postgres;
GRANT ALL ON TABLE st_correspondance_hic TO postgres;
GRANT ALL ON TABLE st_correspondance_hic TO user_codex;


--
-- TOC entry 3130 (class 0 OID 0)
-- Dependencies: 432
-- Name: st_correspondance_hic_idCorresHIC_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" TO user_codex;


--
-- TOC entry 3135 (class 0 OID 0)
-- Dependencies: 324
-- Name: st_correspondance_pvf; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_correspondance_pvf FROM PUBLIC;
REVOKE ALL ON TABLE st_correspondance_pvf FROM postgres;
GRANT ALL ON TABLE st_correspondance_pvf TO postgres;
GRANT ALL ON TABLE st_correspondance_pvf TO user_codex;


--
-- TOC entry 3137 (class 0 OID 0)
-- Dependencies: 425
-- Name: st_correspondance_pvf_idCorrespondancePVF_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" TO user_codex;


--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 327
-- Name: st_cortege_floristique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_cortege_floristique FROM PUBLIC;
REVOKE ALL ON TABLE st_cortege_floristique FROM postgres;
GRANT ALL ON TABLE st_cortege_floristique TO postgres;
GRANT ALL ON TABLE st_cortege_floristique TO user_codex;


--
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 318
-- Name: st_cortege_syntaxonomique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_cortege_syntaxonomique FROM PUBLIC;
REVOKE ALL ON TABLE st_cortege_syntaxonomique FROM postgres;
GRANT ALL ON TABLE st_cortege_syntaxonomique TO postgres;
GRANT ALL ON TABLE st_cortege_syntaxonomique TO user_codex;


--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 437
-- Name: st_etage_bioclim; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_etage_bioclim FROM PUBLIC;
REVOKE ALL ON TABLE st_etage_bioclim FROM postgres;
GRANT ALL ON TABLE st_etage_bioclim TO postgres;
GRANT ALL ON TABLE st_etage_bioclim TO user_codex;


--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 436
-- Name: st_etage_bioclim_idCorresEtageBioclim_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" TO user_codex;


--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 429
-- Name: st_etage_veg; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_etage_veg FROM PUBLIC;
REVOKE ALL ON TABLE st_etage_veg FROM postgres;
GRANT ALL ON TABLE st_etage_veg TO postgres;
GRANT ALL ON TABLE st_etage_veg TO user_codex;


--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 428
-- Name: st_etage_veg_idCorresEtageveg_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" TO user_codex;


--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 317
-- Name: st_geo_sigmafacies; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_geo_sigmafacies FROM PUBLIC;
REVOKE ALL ON TABLE st_geo_sigmafacies FROM postgres;
GRANT ALL ON TABLE st_geo_sigmafacies TO postgres;
GRANT ALL ON TABLE st_geo_sigmafacies TO user_codex;


--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 325
-- Name: st_geomorphologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_geomorphologie FROM PUBLIC;
REVOKE ALL ON TABLE st_geomorphologie FROM postgres;
GRANT ALL ON TABLE st_geomorphologie TO postgres;
GRANT ALL ON TABLE st_geomorphologie TO user_codex;


--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 320
-- Name: st_indicateurs_floristiques; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_indicateurs_floristiques FROM PUBLIC;
REVOKE ALL ON TABLE st_indicateurs_floristiques FROM postgres;
GRANT ALL ON TABLE st_indicateurs_floristiques TO postgres;
GRANT ALL ON TABLE st_indicateurs_floristiques TO user_codex;


--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 322
-- Name: st_ref_action_suivi; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_action_suivi FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_action_suivi FROM postgres;
GRANT ALL ON TABLE st_ref_action_suivi TO postgres;
GRANT ALL ON TABLE st_ref_action_suivi TO user_codex;


--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 313
-- Name: st_ref_categorie_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_categorie_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_categorie_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_categorie_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_categorie_seriegeoserie TO user_codex;


--
-- TOC entry 3203 (class 0 OID 0)
-- Dependencies: 345
-- Name: st_ref_continentalite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_continentalite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_continentalite FROM postgres;
GRANT ALL ON TABLE st_ref_continentalite TO postgres;
GRANT ALL ON TABLE st_ref_continentalite TO user_codex;


--
-- TOC entry 3209 (class 0 OID 0)
-- Dependencies: 340
-- Name: st_ref_critique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_critique FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_critique FROM postgres;
GRANT ALL ON TABLE st_ref_critique TO postgres;
GRANT ALL ON TABLE st_ref_critique TO user_codex;


--
-- TOC entry 3215 (class 0 OID 0)
-- Dependencies: 330
-- Name: st_ref_etage_bioclim; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_etage_bioclim FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_etage_bioclim FROM postgres;
GRANT ALL ON TABLE st_ref_etage_bioclim TO postgres;
GRANT ALL ON TABLE st_ref_etage_bioclim TO user_codex;


--
-- TOC entry 3217 (class 0 OID 0)
-- Dependencies: 383
-- Name: st_ref_etage_bioclim_id_tri_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq FROM postgres;
GRANT ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq TO postgres;
GRANT ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq TO user_codex;


--
-- TOC entry 3223 (class 0 OID 0)
-- Dependencies: 427
-- Name: st_ref_etage_veg; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_etage_veg FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_etage_veg FROM postgres;
GRANT ALL ON TABLE st_ref_etage_veg TO postgres;
GRANT ALL ON TABLE st_ref_etage_veg TO user_codex;


--
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 348
-- Name: st_ref_eunis; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_eunis FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_eunis FROM postgres;
GRANT ALL ON TABLE st_ref_eunis TO postgres;
GRANT ALL ON TABLE st_ref_eunis TO user_codex;


--
-- TOC entry 3235 (class 0 OID 0)
-- Dependencies: 335
-- Name: st_ref_exposition; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_exposition FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_exposition FROM postgres;
GRANT ALL ON TABLE st_ref_exposition TO postgres;
GRANT ALL ON TABLE st_ref_exposition TO user_codex;


--
-- TOC entry 3241 (class 0 OID 0)
-- Dependencies: 326
-- Name: st_ref_geomorpho; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_geomorpho FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_geomorpho FROM postgres;
GRANT ALL ON TABLE st_ref_geomorpho TO postgres;
GRANT ALL ON TABLE st_ref_geomorpho TO user_codex;


--
-- TOC entry 3246 (class 0 OID 0)
-- Dependencies: 329
-- Name: st_ref_hic; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_hic FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_hic FROM postgres;
GRANT ALL ON TABLE st_ref_hic TO postgres;
GRANT ALL ON TABLE st_ref_hic TO user_codex;


--
-- TOC entry 3253 (class 0 OID 0)
-- Dependencies: 332
-- Name: st_ref_humidite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_humidite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_humidite FROM postgres;
GRANT ALL ON TABLE st_ref_humidite TO postgres;
GRANT ALL ON TABLE st_ref_humidite TO user_codex;


--
-- TOC entry 3260 (class 0 OID 0)
-- Dependencies: 343
-- Name: st_ref_lumiere; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_lumiere FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_lumiere FROM postgres;
GRANT ALL ON TABLE st_ref_lumiere TO postgres;
GRANT ALL ON TABLE st_ref_lumiere TO user_codex;


--
-- TOC entry 3268 (class 0 OID 0)
-- Dependencies: 344
-- Name: st_ref_neige; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_neige FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_neige FROM postgres;
GRANT ALL ON TABLE st_ref_neige TO postgres;
GRANT ALL ON TABLE st_ref_neige TO user_codex;


--
-- TOC entry 3273 (class 0 OID 0)
-- Dependencies: 331
-- Name: st_ref_periode; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_periode FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_periode FROM postgres;
GRANT ALL ON TABLE st_ref_periode TO postgres;
GRANT ALL ON TABLE st_ref_periode TO user_codex;


--
-- TOC entry 3283 (class 0 OID 0)
-- Dependencies: 328
-- Name: st_ref_pvf; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_pvf FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_pvf FROM postgres;
GRANT ALL ON TABLE st_ref_pvf TO postgres;
GRANT ALL ON TABLE st_ref_pvf TO user_codex;


--
-- TOC entry 3288 (class 0 OID 0)
-- Dependencies: 315
-- Name: st_ref_rang_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rang_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rang_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_rang_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_rang_seriegeoserie TO user_codex;


--
-- TOC entry 3295 (class 0 OID 0)
-- Dependencies: 314
-- Name: st_ref_rang_syntaxon; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rang_syntaxon FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rang_syntaxon FROM postgres;
GRANT ALL ON TABLE st_ref_rang_syntaxon TO postgres;
GRANT ALL ON TABLE st_ref_rang_syntaxon TO user_codex;


--
-- TOC entry 3301 (class 0 OID 0)
-- Dependencies: 333
-- Name: st_ref_reaction; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_reaction FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_reaction FROM postgres;
GRANT ALL ON TABLE st_ref_reaction TO postgres;
GRANT ALL ON TABLE st_ref_reaction TO user_codex;


--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 347
-- Name: st_ref_rivasmartinez_ombroclimat; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rivasmartinez_ombroclimat FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rivasmartinez_ombroclimat FROM postgres;
GRANT ALL ON TABLE st_ref_rivasmartinez_ombroclimat TO postgres;
GRANT ALL ON TABLE st_ref_rivasmartinez_ombroclimat TO user_codex;


--
-- TOC entry 3315 (class 0 OID 0)
-- Dependencies: 346
-- Name: st_ref_salinite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_salinite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_salinite FROM postgres;
GRANT ALL ON TABLE st_ref_salinite TO postgres;
GRANT ALL ON TABLE st_ref_salinite TO user_codex;


--
-- TOC entry 3320 (class 0 OID 0)
-- Dependencies: 323
-- Name: st_ref_statut_chorologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_statut_chorologie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_statut_chorologie FROM postgres;
GRANT ALL ON TABLE st_ref_statut_chorologie TO postgres;
GRANT ALL ON TABLE st_ref_statut_chorologie TO user_codex;


--
-- TOC entry 3327 (class 0 OID 0)
-- Dependencies: 342
-- Name: st_ref_temperature; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_temperature FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_temperature FROM postgres;
GRANT ALL ON TABLE st_ref_temperature TO postgres;
GRANT ALL ON TABLE st_ref_temperature TO user_codex;


--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 319
-- Name: st_ref_tete_serie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_tete_serie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_tete_serie FROM postgres;
GRANT ALL ON TABLE st_ref_tete_serie TO postgres;
GRANT ALL ON TABLE st_ref_tete_serie TO user_codex;


--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 334
-- Name: st_ref_trophie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_trophie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_trophie FROM postgres;
GRANT ALL ON TABLE st_ref_trophie TO postgres;
GRANT ALL ON TABLE st_ref_trophie TO user_codex;


--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 316
-- Name: st_ref_type_facies; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_facies FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_facies FROM postgres;
GRANT ALL ON TABLE st_ref_type_facies TO postgres;
GRANT ALL ON TABLE st_ref_type_facies TO user_codex;


--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 341
-- Name: st_ref_type_physionomique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_physionomique FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_physionomique FROM postgres;
GRANT ALL ON TABLE st_ref_type_physionomique TO postgres;
GRANT ALL ON TABLE st_ref_type_physionomique TO user_codex;


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 312
-- Name: st_ref_type_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_type_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_type_seriegeoserie TO user_codex;


--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 336
-- Name: st_ref_type_synonymie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_synonymie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_synonymie FROM postgres;
GRANT ALL ON TABLE st_ref_type_synonymie TO postgres;
GRANT ALL ON TABLE st_ref_type_synonymie TO user_codex;


--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 311
-- Name: st_serie_petitegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_serie_petitegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_serie_petitegeoserie FROM postgres;
GRANT ALL ON TABLE st_serie_petitegeoserie TO postgres;
GRANT ALL ON TABLE st_serie_petitegeoserie TO user_codex;


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 321
-- Name: st_suivi_enregistrement; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_suivi_enregistrement FROM PUBLIC;
REVOKE ALL ON TABLE st_suivi_enregistrement FROM postgres;
GRANT ALL ON TABLE st_suivi_enregistrement TO postgres;
GRANT ALL ON TABLE st_suivi_enregistrement TO user_codex;


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 372
-- Name: st_syntaxon; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_syntaxon FROM PUBLIC;
REVOKE ALL ON TABLE st_syntaxon FROM postgres;
GRANT ALL ON TABLE st_syntaxon TO postgres;
GRANT ALL ON TABLE st_syntaxon TO user_codex;


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 407
-- Name: st_syntaxon_uid_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE st_syntaxon_uid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE st_syntaxon_uid_seq FROM postgres;
GRANT ALL ON SEQUENCE st_syntaxon_uid_seq TO postgres;
GRANT ALL ON SEQUENCE st_syntaxon_uid_seq TO user_codex;


-- Completed on 2016-07-18 16:14:12

--
-- PostgreSQL database dump complete
--

