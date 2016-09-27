--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: syntaxa; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA syntaxa;


ALTER SCHEMA syntaxa OWNER TO postgres;

--
-- Name: SCHEMA syntaxa; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA syntaxa IS 'Applications';


SET search_path = syntaxa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
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


ALTER TABLE syntaxa.fsd_syntaxa OWNER TO postgres;

--
-- Name: fsd_syntaxa_id_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE fsd_syntaxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.fsd_syntaxa_id_seq OWNER TO postgres;

--
-- Name: fsd_syntaxa_id_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE fsd_syntaxa_id_seq OWNED BY fsd_syntaxa.id;


--
-- Name: images; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE images (
    "codeEnregistrementSerieGeoserie" text,
    chemin_img text,
    "typeImage" text
);


ALTER TABLE syntaxa.images OWNER TO postgres;

--
-- Name: liste_geo; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE liste_geo (
    id_territoire text NOT NULL,
    code_type_territoire text,
    code_territoire text,
    libelle_territoire text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.liste_geo OWNER TO postgres;

--
-- Name: TABLE liste_geo; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE liste_geo IS 'Table listant les territoires géographiques de référence pour la chorologie';


--
-- Name: COLUMN liste_geo.id_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.id_territoire IS 'identifiant unique du territoire';


--
-- Name: COLUMN liste_geo.code_type_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.code_type_territoire IS 'code du type de territoire (RA:région agricole, DEP: département, REG: région)';


--
-- Name: COLUMN liste_geo.code_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.code_territoire IS 'Code du territoire dans son référentiel d''origine (ex: insee pour les départements)';


--
-- Name: COLUMN liste_geo.libelle_territoire; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.libelle_territoire IS 'Libellé du territoire dans son référentiel d''origine (ex: insee pour les départements)';


--
-- Name: COLUMN liste_geo.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN liste_geo.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: liste_geo_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE liste_geo_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.liste_geo_id_tri_seq OWNER TO postgres;

--
-- Name: liste_geo_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE liste_geo_id_tri_seq OWNED BY liste_geo.id_tri;


--
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


ALTER TABLE syntaxa.referentiel_taxo OWNER TO postgres;

--
-- Name: TABLE referentiel_taxo; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE referentiel_taxo IS 'Table listant les taxons dans les différents référentiels taxonomiques';


--
-- Name: COLUMN referentiel_taxo.id_rattachement_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.id_rattachement_referentiel IS 'identifiant unique du taxon dans un référentiel donné';


--
-- Name: COLUMN referentiel_taxo.code_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.code_referentiel IS 'nom codifié du référentiel';


--
-- Name: COLUMN referentiel_taxo.version_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.version_referentiel IS 'version du référentiel';


--
-- Name: COLUMN referentiel_taxo.cd_ref_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.cd_ref_referentiel IS 'cd_ref dans le référentiel';


--
-- Name: COLUMN referentiel_taxo.cd_nom_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.cd_nom_referentiel IS 'cd_nom dans le référentiel';


--
-- Name: COLUMN referentiel_taxo.nom_complet_taxon_referentiel; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN referentiel_taxo.nom_complet_taxon_referentiel IS 'nom complet du taxon dans le référentiel';


--
-- Name: st_annuaire_organismes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_annuaire_organismes (
    "idOrganisme" text NOT NULL,
    "acronymeOrganisme" text,
    "libOrganisme" text
);


ALTER TABLE syntaxa.st_annuaire_organismes OWNER TO postgres;

--
-- Name: TABLE st_annuaire_organismes; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_annuaire_organismes IS 'Table d''annuaire qui recense les organismes en lien avec la création des catalogues';


--
-- Name: COLUMN st_annuaire_organismes."idOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_organismes."idOrganisme" IS 'Identifiant unique de l''organisme';


--
-- Name: COLUMN st_annuaire_organismes."acronymeOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_organismes."acronymeOrganisme" IS 'Acronyme de l''organisme';


--
-- Name: COLUMN st_annuaire_organismes."libOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_organismes."libOrganisme" IS 'Libellé complet de l''organisme';


--
-- Name: st_annuaire_personnes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_annuaire_personnes (
    "idPersonne" text NOT NULL,
    prenom text,
    nom text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_annuaire_personnes OWNER TO postgres;

--
-- Name: TABLE st_annuaire_personnes; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_annuaire_personnes IS 'Table d''annuaire qui recense les personnes en lien avec la création des catalogues';


--
-- Name: COLUMN st_annuaire_personnes."idPersonne"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes."idPersonne" IS 'Identifiant unique de la personne';


--
-- Name: COLUMN st_annuaire_personnes.prenom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes.prenom IS 'Prénom de la personne';


--
-- Name: COLUMN st_annuaire_personnes.nom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes.nom IS 'Nom de la personne';


--
-- Name: COLUMN st_annuaire_personnes.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_annuaire_personnes.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_annuaire_personnes_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_annuaire_personnes_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_annuaire_personnes_id_tri_seq OWNER TO postgres;

--
-- Name: st_annuaire_personnes_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_annuaire_personnes_id_tri_seq OWNED BY st_annuaire_personnes.id_tri;


--
-- Name: st_biblio; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_biblio (
    "idBiblio" integer NOT NULL,
    "codeEnregistrement" text,
    "libPublication" text,
    "urlPublication" text,
    "codePublication" text
);


ALTER TABLE syntaxa.st_biblio OWNER TO postgres;

--
-- Name: TABLE st_biblio; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_biblio IS 'Table qui recense les références bibliographiques en lien avec la description des syntaxons, des séries et géoséries';


--
-- Name: COLUMN st_biblio."idBiblio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."idBiblio" IS 'identifiant unique de la table de biblio qui associe une publication a un enregistrment dans la base';


--
-- Name: COLUMN st_biblio."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."codeEnregistrement" IS 'Code de l''enregistrement d''un syntaxon, série ou géosérie';


--
-- Name: COLUMN st_biblio."libPublication"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."libPublication" IS 'Libellé de la publication (dont titre, année,  volume et le nombre de pages) qui atteste de la présence du taxon dans le territoire étudié';


--
-- Name: COLUMN st_biblio."urlPublication"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."urlPublication" IS 'permalien vers la notice bibliographique du document source de référence (Kentika, PMB, Alexandrie, ..) ou permalien vers le document en téléchargement  qui atteste de la présence du syntaxon dans le territoire étudié';


--
-- Name: COLUMN st_biblio."codePublication"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_biblio."codePublication" IS 'numero ISSN de la publication qui atteste de la présence du syntaxon dans le territoire étudié';


--
-- Name: st_biblio_idBiblio_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_biblio_idBiblio_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa."st_biblio_idBiblio_seq" OWNER TO postgres;

--
-- Name: st_biblio_idBiblio_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_biblio_idBiblio_seq" OWNED BY st_biblio."idBiblio";


--
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


ALTER TABLE syntaxa.st_catalogue_description OWNER TO postgres;

--
-- Name: TABLE st_catalogue_description; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_catalogue_description IS 'Table de métadonnées de description des catalogues';


--
-- Name: COLUMN st_catalogue_description."identifiantCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."identifiantCatalogue" IS 'identifiant unique du catalogue';


--
-- Name: COLUMN st_catalogue_description."libelleCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."libelleCatalogue" IS 'libellé du catalogue de vegetation';


--
-- Name: COLUMN st_catalogue_description."versionCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."versionCatalogue" IS 'version du catalogue de vegetation';


--
-- Name: COLUMN st_catalogue_description."typeCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."typeCatalogue" IS 'Type de catalogue correspondant au champ thématique couvert par le catalogue.';


--
-- Name: COLUMN st_catalogue_description."dateCreationCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."dateCreationCatalogue" IS 'date de création du catalogue de vegetation';


--
-- Name: COLUMN st_catalogue_description."dateMiseAJourCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."dateMiseAJourCatalogue" IS 'date de dernière mise à jour du catalogue de vegetation';


--
-- Name: COLUMN st_catalogue_description."idCollaborateurCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."idCollaborateurCatalogue" IS 'identifiant vers une table contenant les noms des CBN ou autres organismes ayant collaborés à la réalisation du catalogue';


--
-- Name: COLUMN st_catalogue_description."idTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."idTerritoireCatalogue" IS 'identifiant unique du territoire utilisé pour décrire la validité spatiale du catalogue, fait référence à la table liste_geo';


--
-- Name: COLUMN st_catalogue_description."codeTypeTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."codeTypeTerritoireCatalogue" IS 'Code du type de territoire utilisé pour décrire la validité spatiale du catalogue, autrement dit emprise totale du catalogue ( CBN,régionale, nationale, autre…)';


--
-- Name: COLUMN st_catalogue_description."codeTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."codeTerritoireCatalogue" IS 'Code du territoire utilisé pour décrire de validité spatiale du catalogue, lié au référentiel territorial utilisé';


--
-- Name: COLUMN st_catalogue_description."libelleTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."libelleTerritoireCatalogue" IS 'Nom du territoire  utilisé pour décrire la validité spatiale du catalogue ';


--
-- Name: COLUMN st_catalogue_description."remarqueTerritoireCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description."remarqueTerritoireCatalogue" IS 'remarque concernant le territoire de validité spatiale du catalogue (si ce territoire est inférieur à une région  ou département administratif)';


--
-- Name: COLUMN st_catalogue_description.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_catalogue_description.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_catalogue_description_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_catalogue_description_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_catalogue_description_id_tri_seq OWNER TO postgres;

--
-- Name: st_catalogue_description_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_catalogue_description_id_tri_seq OWNED BY st_catalogue_description.id_tri;


--
-- Name: st_chorologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_chorologie (
    "idChorologie" integer NOT NULL,
    "codeEnregistrement" text,
    "statutChorologie" text,
    "idTerritoire" text
);


ALTER TABLE syntaxa.st_chorologie OWNER TO postgres;

--
-- Name: TABLE st_chorologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_chorologie IS 'Table indiquant la chorologie de chaque syntaxon, série ou petite géosérie';


--
-- Name: COLUMN st_chorologie."idChorologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."idChorologie" IS 'identifiant unique de la chorologie enregistrée (ex:idchoro_1, idchoro_2 etc)';


--
-- Name: COLUMN st_chorologie."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la chorologie est renseignée';


--
-- Name: COLUMN st_chorologie."statutChorologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."statutChorologie" IS 'statut de la présence sur le territoire (concerne la chorologie de la végétation c''est à dire la région naturelle de présence)';


--
-- Name: COLUMN st_chorologie."idTerritoire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_chorologie."idTerritoire" IS 'code unique du territoire pour lequel le statut de la végétation est renseigné, fait référence à la table liste_geo du taxa';


--
-- Name: st_chorologie_idChorologie_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_chorologie_idChorologie_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa."st_chorologie_idChorologie_seq" OWNER TO postgres;

--
-- Name: st_chorologie_idChorologie_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_chorologie_idChorologie_seq" OWNED BY st_chorologie."idChorologie";


--
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


ALTER TABLE syntaxa.st_collaborateur OWNER TO postgres;

--
-- Name: TABLE st_collaborateur; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_collaborateur IS 'Table de collaborateur qui fait le lien entre les personnes, leur organisme et le catalogue auquel elles ont participé';


--
-- Name: COLUMN st_collaborateur."idCollaborateur"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."idCollaborateur" IS 'Identifiant unique collaborateur qui est la combinaison d''une personne et d''un organisme (ex: collab_1, collab_2 etc)';


--
-- Name: COLUMN st_collaborateur."identifiantCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."identifiantCatalogue" IS 'identifiant du catalogue (clé étrangère)';


--
-- Name: COLUMN st_collaborateur."idOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."idOrganisme" IS 'identifiant de l''organisme d''appartenance du collaborateur';


--
-- Name: COLUMN st_collaborateur."acronymeOrganisme"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."acronymeOrganisme" IS 'acronyme de l''organisme d''appartenance du collaborateur';


--
-- Name: COLUMN st_collaborateur."idPersonne"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur."idPersonne" IS 'identifiant de la personne collaborateur';


--
-- Name: COLUMN st_collaborateur.prenom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur.prenom IS 'Prénom du collaborateur';


--
-- Name: COLUMN st_collaborateur.nom; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_collaborateur.nom IS 'Nom du collaborateur';


--
-- Name: st_correspondance_eunis; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_correspondance_eunis (
    "idCorresEUNIS" integer NOT NULL,
    "codeEnregistrement" text,
    "typeEnregistrement" text,
    "codeEUNIS" text,
    "rqEUNIS" text
);


ALTER TABLE syntaxa.st_correspondance_eunis OWNER TO postgres;

--
-- Name: TABLE st_correspondance_eunis; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_correspondance_eunis IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats EUNIS';


--
-- Name: COLUMN st_correspondance_eunis."idCorresEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."idCorresEUNIS" IS 'identifiant unique portant un couple syntaxon/correspondance typologie EUNIS';


--
-- Name: COLUMN st_correspondance_eunis."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."codeEnregistrement" IS 'code de l'' enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- Name: COLUMN st_correspondance_eunis."typeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."typeEnregistrement" IS 'indique s''il s''agit d''un enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- Name: COLUMN st_correspondance_eunis."codeEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."codeEUNIS" IS 'code de l''habitat EUNIS concerné par la correspondance';


--
-- Name: COLUMN st_correspondance_eunis."rqEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_eunis."rqEUNIS" IS 'champ libre de remarque à propos du rattachement au code HIc';


--
-- Name: st_correspondance_eunis_idCorresEUNIS_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa."st_correspondance_eunis_idCorresEUNIS_seq" OWNER TO postgres;

--
-- Name: st_correspondance_eunis_idCorresEUNIS_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" OWNED BY st_correspondance_eunis."idCorresEUNIS";


--
-- Name: st_correspondance_hic; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_correspondance_hic (
    "idCorresHIC" integer NOT NULL,
    "codeEnregistrement" text,
    "typeEnregistrement" text,
    "codeHIC" text,
    "rqHIC" text
);


ALTER TABLE syntaxa.st_correspondance_hic OWNER TO postgres;

--
-- Name: TABLE st_correspondance_hic; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_correspondance_hic IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats de la directive habitat (N2000)';


--
-- Name: COLUMN st_correspondance_hic."idCorresHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."idCorresHIC" IS 'identifiant unique de la correspondance entre le syntaxon et l''habitat d''intérêt communautaire';


--
-- Name: COLUMN st_correspondance_hic."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."codeEnregistrement" IS 'code de l'' enregistrement de syntaxon, du syntaxon dans le cadre d''un cortège syntaxonomique, du (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- Name: COLUMN st_correspondance_hic."typeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."typeEnregistrement" IS 'indique s''il s''agit d''un enregistrement de syntaxon, syntaxon de cortège, (geo)sigmafacies ou SeriePetiteGeoserie';


--
-- Name: COLUMN st_correspondance_hic."codeHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."codeHIC" IS 'code de l''habitat Natura 2000 concerné par la correspondance';


--
-- Name: COLUMN st_correspondance_hic."rqHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_hic."rqHIC" IS 'champ libre de remarque à propos du rattachement au code HIC';


--
-- Name: st_correspondance_hic_idCorresHIC_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_correspondance_hic_idCorresHIC_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa."st_correspondance_hic_idCorresHIC_seq" OWNER TO postgres;

--
-- Name: st_correspondance_hic_idCorresHIC_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_correspondance_hic_idCorresHIC_seq" OWNED BY st_correspondance_hic."idCorresHIC";


--
-- Name: st_correspondance_pvf; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_correspondance_pvf (
    "idRattachementPVF" integer,
    "codeEnregistrementSyntaxon" text,
    "versionReferentiel" text,
    "idCorrespondancePVF" integer NOT NULL
);


ALTER TABLE syntaxa.st_correspondance_pvf OWNER TO postgres;

--
-- Name: TABLE st_correspondance_pvf; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_correspondance_pvf IS 'Table de correspondance avec la typologie du PVF (PVF1 et PVF2)';


--
-- Name: COLUMN st_correspondance_pvf."idRattachementPVF"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_pvf."idRattachementPVF" IS 'identifiant unique du syntaxon dans la table contenant pvf1 et pvf2';


--
-- Name: COLUMN st_correspondance_pvf."codeEnregistrementSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_pvf."codeEnregistrementSyntaxon" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la géomorphologie est renseignée';


--
-- Name: COLUMN st_correspondance_pvf."versionReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_correspondance_pvf."versionReferentiel" IS 'version du référentiel';


--
-- Name: st_correspondance_pvf_idCorrespondancePVF_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa."st_correspondance_pvf_idCorrespondancePVF_seq" OWNER TO postgres;

--
-- Name: st_correspondance_pvf_idCorrespondancePVF_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" OWNED BY st_correspondance_pvf."idCorrespondancePVF";


--
-- Name: st_cortege_floristique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_cortege_floristique (
    "idCortegeFloristique" serial not null,
    "codeEnregistrementSyntaxon" text,
    "idRattachementReferentiel" text,
    "typeTaxon" text,
     code_referentiel text,
     version_referentiel text,
     cd_ref text,
     nom_complet text,
     "rqTaxon" text
);


ALTER TABLE syntaxa.st_cortege_floristique OWNER TO postgres;

--
-- Name: TABLE st_cortege_floristique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_cortege_floristique IS 'Cortège floristique qui accompagne le syntaxon';


--
-- Name: COLUMN st_cortege_floristique."idCortegeFloristique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."idCortegeFloristique" IS 'identifiant unique du taxon dans le cortège floristique';


--
-- Name: COLUMN st_cortege_floristique."codeEnregistrementSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."codeEnregistrementSyntaxon" IS 'code de l''enregistrement du syntaxon';


--
-- Name: COLUMN st_cortege_floristique."idRattachementReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."idRattachementReferentiel" IS 'identifiant du rattachement au référentiel';


--
-- Name: COLUMN st_cortege_floristique."typeTaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_floristique."typeTaxon" IS 'indique si le taxon est caractéristique ou différentiel';


--
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


ALTER TABLE syntaxa.st_cortege_syntaxonomique OWNER TO postgres;

--
-- Name: TABLE st_cortege_syntaxonomique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_cortege_syntaxonomique IS 'Cortège syntaxonomique de chaque geosigmafacies. Chaque syntaxon représente un stade dynamique du (geo)sigmasyntaxa. Ce stade peut être progressif ou regressif.';


--
-- Name: COLUMN st_cortege_syntaxonomique."codeEnregistrementCortegeSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."codeEnregistrementCortegeSyntax" IS 'identifiant unique de la ligne qui décrit le syntaxon composant le cortège';


--
-- Name: COLUMN st_cortege_syntaxonomique."idGeosigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."idGeosigmafacies" IS 'Identifiant unique du (geo)sigmafacies';


--
-- Name: COLUMN st_cortege_syntaxonomique."libelleGeoSigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."libelleGeoSigmafacies" IS 'clé étrangère vers le libellé du geosigmafacies';


--
-- Name: COLUMN st_cortege_syntaxonomique."codeEnregistrementSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."codeEnregistrementSyntax" IS 'clé étrangère vers l''enregistrement du syntaxon';


--
-- Name: COLUMN st_cortege_syntaxonomique."idSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."idSyntaxonRetenu" IS 'code du syntaxon retenu dans le catalogue d''origine pour le faciès donné d''une série ou petite géosérie donnée';


--
-- Name: COLUMN st_cortege_syntaxonomique."nomSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."nomSyntaxonRetenu" IS 'nom complet du syntaxon retenu dans le catalogue d''origine pour le faciès donné d''une série ou petite géosérie donnée';


--
-- Name: COLUMN st_cortege_syntaxonomique."rqSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."rqSyntaxon" IS 'remarque concernant ce syntaxon dans le cadre de son appartenance au cortège syntaxonomique d''un (geo)sigmafacies particulier';


--
-- Name: COLUMN st_cortege_syntaxonomique."pourcentageTheoriqSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."pourcentageTheoriqSyntax" IS 'Pourcentage moyen théorique du syntaxon pour le faciès donné d''une série ou petite géosérie donnée';


--
-- Name: COLUMN st_cortege_syntaxonomique."codeTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_cortege_syntaxonomique."codeTeteSerie" IS 'Le syntaxon représente-t-il la tête de la (geo)série à laquelle il est associé';


--
-- Name: st_etage_bioclim; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_etage_bioclim (
    "idCorresEtageBioclim" integer NOT NULL,
    "codeEnregistrement" text,
    "codeEtageBioclim" text,
    "libEtageBioclim" text
);


ALTER TABLE syntaxa.st_etage_bioclim OWNER TO postgres;

--
-- Name: TABLE st_etage_bioclim; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_etage_bioclim IS 'Table indiquant l''appartenance d''un syntaxon,série ou petite géosérie à un ou plusieurs étages de végétation ';


--
-- Name: COLUMN st_etage_bioclim."idCorresEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."idCorresEtageBioclim" IS 'identifiant unique de la correspondance entre l''enregistrement et l''étage bioclimatique';


--
-- Name: COLUMN st_etage_bioclim."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."codeEnregistrement" IS 'identifiant unique de l''enregistrement du syntaxon, faciès, série ou petite géosérie';


--
-- Name: COLUMN st_etage_bioclim."codeEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."codeEtageBioclim" IS 'code de l''étage bioclimatique';


--
-- Name: COLUMN st_etage_bioclim."libEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_etage_bioclim."libEtageBioclim" IS 'libellé de l''étage bioclimatique';


--
-- Name: st_etage_bioclim_idCorresEtageBioclim_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa."st_etage_bioclim_idCorresEtageBioclim_seq" OWNER TO postgres;

--
-- Name: st_etage_bioclim_idCorresEtageBioclim_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" OWNED BY st_etage_bioclim."idCorresEtageBioclim";


--
-- Name: st_etage_veg; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_etage_veg (
    "idCorresEtageveg" integer NOT NULL,
    "codeEnregistrement" text,
    "codeEtageVeg" text,
    "libEtageVeg" text
);


ALTER TABLE syntaxa.st_etage_veg OWNER TO postgres;

--
-- Name: st_etage_veg_idCorresEtageveg_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE "st_etage_veg_idCorresEtageveg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa."st_etage_veg_idCorresEtageveg_seq" OWNER TO postgres;

--
-- Name: st_etage_veg_idCorresEtageveg_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE "st_etage_veg_idCorresEtageveg_seq" OWNED BY st_etage_veg."idCorresEtageveg";

COMMENT ON TABLE syntaxa.st_etage_veg
  IS 'Table de correspondance entre le syntaxon-série-petite géosérie et l''étage de végétation ';
COMMENT ON COLUMN syntaxa.st_etage_veg."idCorresEtageveg" IS 'identifiant unique de la correspondance entre l''enregistrement et l''étage de végétation';
COMMENT ON COLUMN syntaxa.st_etage_veg."codeEnregistrement" IS 'identifiant unique de l''enregistrement du syntaxon, faciès, série ou petite géosérie';
COMMENT ON COLUMN syntaxa.st_etage_veg."codeEtageVeg" IS 'code de l''étage de végétation';
COMMENT ON COLUMN syntaxa.st_etage_veg."libEtageVeg" IS 'libellé de l''étage de végétation';


--
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


ALTER TABLE syntaxa.st_geo_sigmafacies OWNER TO postgres;

--
-- Name: TABLE st_geo_sigmafacies; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_geo_sigmafacies IS 'Table de correspondance entre le(geo)sigmataxon et un faciès qui donne le (geo)sigmafacies';


--
-- Name: COLUMN st_geo_sigmafacies."idGeosigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."idGeosigmafacies" IS 'Identifiant unique du sigmafacies';


--
-- Name: COLUMN st_geo_sigmafacies."codeEnregistrementSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."codeEnregistrementSerieGeoserie" IS 'Clé étrangère vers l''identifiant unique de la série ou petite géosérie';


--
-- Name: COLUMN st_geo_sigmafacies."codeFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."codeFacies" IS 'clé étrangère vers le code du type de faciès';


--
-- Name: COLUMN st_geo_sigmafacies."libelleGeoSigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."libelleGeoSigmafacies" IS 'Concaténation du libelle du geosigmasyntaxa et du libelle du type de faciès ex: "pelouse de la Série de la forêt à Fagus sylvatica et Deschampsia flexuosa"';


--
-- Name: COLUMN st_geo_sigmafacies.dominance; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies.dominance IS 'Champ texte libre qui indique si le (geo)sigmafaciès est généralement dominant dans la série (oui/non)';


--
-- Name: COLUMN st_geo_sigmafacies.usage; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies.usage IS 'Champ texte libre qui vise à décrire sigmafaciès';


--
-- Name: COLUMN st_geo_sigmafacies."remarqueVariabilite"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geo_sigmafacies."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité du faciès. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';


--
-- Name: st_geomorphologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_geomorphologie (
    "idVegGeomorpho" text,
    "codeEnregistrement" text,
    "idGeomorphologie" text,
    "libGeomorphologie" text
);


ALTER TABLE syntaxa.st_geomorphologie OWNER TO postgres;

--
-- Name: TABLE st_geomorphologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_geomorphologie IS 'Table d''appartenance d''une végétation à une ou plusieurs géomorphologie';


--
-- Name: COLUMN st_geomorphologie."idVegGeomorpho"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."idVegGeomorpho" IS 'identifiant unique de l''association d''une végétation et d''une géomorphologie';


--
-- Name: COLUMN st_geomorphologie."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la géomorphologie est renseignée';


--
-- Name: COLUMN st_geomorphologie."idGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."idGeomorphologie" IS 'identifiant du taxon géomorphologique';


--
-- Name: COLUMN st_geomorphologie."libGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_geomorphologie."libGeomorphologie" IS 'libellé du taxon géomorphologique';


--
-- Name: st_indicateurs_floristiques; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_indicateurs_floristiques (
    "idIndicateurFlor" text NOT NULL,
    "idGeosigmafacies" text,
    "idRattachementReferentiel" text
);


ALTER TABLE syntaxa.st_indicateurs_floristiques OWNER TO postgres;

--
-- Name: TABLE st_indicateurs_floristiques; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_indicateurs_floristiques IS 'Indicateurs floristiques de chaque (geo)sigmafacies';


--
-- Name: COLUMN st_indicateurs_floristiques."idIndicateurFlor"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_indicateurs_floristiques."idIndicateurFlor" IS 'Identifiant unique de la ligne qui correspond au taxon qui sert d''indicateur floristique au (geo)sigmafacies';


--
-- Name: COLUMN st_indicateurs_floristiques."idGeosigmafacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_indicateurs_floristiques."idGeosigmafacies" IS 'Identifiant unique du (geo)sigmafacies auquel l''indicateur floristique est rattaché';


--
-- Name: COLUMN st_indicateurs_floristiques."idRattachementReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_indicateurs_floristiques."idRattachementReferentiel" IS 'Identifiant unique de la ligne qui correspond au taxon dans un référentiel donné (taxref ou autre)';


--
-- Name: st_ref_action_suivi; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_action_suivi (
    "codeActionSuivi" text NOT NULL,
    "libActionSuivi" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_action_suivi OWNER TO postgres;

--
-- Name: TABLE st_ref_action_suivi; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_action_suivi IS 'Référentiel des types de suivi de données';


--
-- Name: COLUMN st_ref_action_suivi."codeActionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi."codeActionSuivi" IS 'Codification du type de suivi';


--
-- Name: COLUMN st_ref_action_suivi."libActionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi."libActionSuivi" IS 'Libellé du type de suivi';


--
-- Name: COLUMN st_ref_action_suivi.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_action_suivi.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_action_suivi_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_action_suivi_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_action_suivi_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_action_suivi_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_action_suivi_id_tri_seq OWNED BY st_ref_action_suivi.id_tri;


--
-- Name: st_ref_categorie_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_categorie_seriegeoserie (
    "codeCategorieSerieGeoserie" text NOT NULL,
    "libCategorieSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_categorie_seriegeoserie OWNER TO postgres;

--
-- Name: TABLE st_ref_categorie_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_categorie_seriegeoserie IS 'Référentiel des catégorie de série et de géoséries';


--
-- Name: COLUMN st_ref_categorie_seriegeoserie."codeCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie."codeCategorieSerieGeoserie" IS 'code de la catégorie de série et de géoséries';


--
-- Name: COLUMN st_ref_categorie_seriegeoserie."libCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie."libCategorieSerieGeoserie" IS 'libelle de la catégorie de série et de géoséries';


--
-- Name: COLUMN st_ref_categorie_seriegeoserie.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_categorie_seriegeoserie.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_categorie_seriegeoserie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_categorie_seriegeoserie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_categorie_seriegeoserie_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_categorie_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_categorie_seriegeoserie_id_tri_seq OWNED BY st_ref_categorie_seriegeoserie.id_tri;


--
-- Name: st_ref_continentalite; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_continentalite (
    "indCont" text NOT NULL,
    "libCont" text,
    "libLongCont" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_continentalite OWNER TO postgres;

--
-- Name: TABLE st_ref_continentalite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_continentalite IS 'Référentiel de la continentalité selon Landolt';


--
-- Name: COLUMN st_ref_continentalite."indCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."indCont" IS 'Indice de la continentalite selon Landolt';


--
-- Name: COLUMN st_ref_continentalite."libCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."libCont" IS 'libellé court de la Continentalité selon Landolt';


--
-- Name: COLUMN st_ref_continentalite."libLongCont"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite."libLongCont" IS 'libellé long de continentalité selon Landolt';


--
-- Name: COLUMN st_ref_continentalite.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_continentalite.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_continentalite_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_continentalite_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_continentalite_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_continentalite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_continentalite_id_tri_seq OWNED BY st_ref_continentalite.id_tri;


--
-- Name: st_ref_critique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_critique (
    "idCritique" text,
    "libCritique" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_critique OWNER TO postgres;

--
-- Name: TABLE st_ref_critique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_critique IS 'Référentiel de la criticité des syntaxons';


--
-- Name: COLUMN st_ref_critique."idCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique."idCritique" IS 'valeurs que prend le caractère critique (oui/non)';


--
-- Name: COLUMN st_ref_critique."libCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique."libCritique" IS 'libellé du caractère critique le syntaxon est critique, le syntaxon n''est pas critique';


--
-- Name: COLUMN st_ref_critique.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_critique.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_critique_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_critique_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_critique_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_critique_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_critique_id_tri_seq OWNED BY st_ref_critique.id_tri;


--
-- Name: st_ref_etage_bioclim; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_etage_bioclim (
    "codeEtageBioclim" text NOT NULL,
    "libEtageBioclim" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_etage_bioclim OWNER TO postgres;

--
-- Name: TABLE st_ref_etage_bioclim; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_etage_bioclim IS 'Référentiel des étages bioclimatiques';


--
-- Name: COLUMN st_ref_etage_bioclim."codeEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim."codeEtageBioclim" IS 'code de l''étage bioclimatique';


--
-- Name: COLUMN st_ref_etage_bioclim."libEtageBioclim"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim."libEtageBioclim" IS 'libellé de l''étage bioclimatique';


--
-- Name: COLUMN st_ref_etage_bioclim.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_bioclim.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_etage_bioclim_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_etage_bioclim_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_etage_bioclim_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_etage_bioclim_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_etage_bioclim_id_tri_seq OWNED BY st_ref_etage_bioclim.id_tri;


--
-- Name: st_ref_etage_veg; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_etage_veg (
    "codeEtageVeg" text NOT NULL,
    "libEtageVeg" text,
    "libLongEtageVeg" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_etage_veg OWNER TO postgres;

--
-- Name: TABLE st_ref_etage_veg; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_etage_veg IS 'Référentiel des étages de végétation proposé par le réseau';


--
-- Name: COLUMN st_ref_etage_veg."codeEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."codeEtageVeg" IS 'code de l''étage de végétation';


--
-- Name: COLUMN st_ref_etage_veg."libEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."libEtageVeg" IS 'libellé de l''étage de végétation';


--
-- Name: COLUMN st_ref_etage_veg."libLongEtageVeg"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg."libLongEtageVeg" IS 'libellé long de l''étage de végétation';


--
-- Name: COLUMN st_ref_etage_veg.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_etage_veg.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_etage_veg_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_etage_veg_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_etage_veg_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_etage_veg_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_etage_veg_id_tri_seq OWNED BY st_ref_etage_veg.id_tri;


--
-- Name: st_ref_eunis; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_eunis (
    "codeEUNIS" text NOT NULL,
    "libEUNIS" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_eunis OWNER TO postgres;

--
-- Name: TABLE st_ref_eunis; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_eunis IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats de la directive habitat (N2000)';


--
-- Name: COLUMN st_ref_eunis."codeEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis."codeEUNIS" IS 'code de l''habitat EUNIS concerné par la correspondance';


--
-- Name: COLUMN st_ref_eunis."libEUNIS"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis."libEUNIS" IS 'libellé de l''habitat EUNIS concerné par la correspondance';


--
-- Name: COLUMN st_ref_eunis.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_eunis.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_eunis_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_eunis_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_eunis_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_eunis_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_eunis_id_tri_seq OWNED BY st_ref_eunis.id_tri;


--
-- Name: st_ref_exposition; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_exposition (
    "idExposition" text NOT NULL,
    "libExposition" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_exposition OWNER TO postgres;

--
-- Name: TABLE st_ref_exposition; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_exposition IS 'Référentiel des valeurs d''exposition';


--
-- Name: COLUMN st_ref_exposition."idExposition"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition."idExposition" IS 'identifiant de l''exposition de la végétation';


--
-- Name: COLUMN st_ref_exposition."libExposition"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition."libExposition" IS 'libellé de l''exposition de la végétation';


--
-- Name: COLUMN st_ref_exposition.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_exposition.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_exposition_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_exposition_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_exposition_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_exposition_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_exposition_id_tri_seq OWNED BY st_ref_exposition.id_tri;


--
-- Name: st_ref_geomorpho; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_geomorpho (
   "idGeomorphologie" integer NOT NULL, -- identifiant du taxon géomorphologique
   "domaine" text, 
    "taxon" text,
    "sous_taxon" text, 
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_geomorpho OWNER TO postgres;

--
-- Name: TABLE st_ref_geomorpho; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_geomorpho IS 'Référentiel géomorphologique';


--
-- Name: COLUMN st_ref_geomorpho."idGeomorphologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."idGeomorphologie" IS 'identifiant du taxon géomorphologique';


--
-- Name: COLUMN st_ref_geomorpho."domaine"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."domaine" IS 'domaine géomorphologique';


--
-- Name: COLUMN st_ref_geomorpho."taxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."taxon" IS 'taxon géomorphologique';

--
-- Name: COLUMN st_ref_geomorpho."sous_taxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho."sous_taxon" IS 'sous_taxon géomorphologique';

--
-- Name: COLUMN st_ref_geomorpho.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_geomorpho.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_geomorpho_idGeomorphologie_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_geomorpho_idGeomorphologie_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_geomorpho_idGeomorphologie_seq OWNER TO postgres;

--
-- Name: st_ref_geomorpho_idGeomorphologie_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_geomorpho_idGeomorphologie_seq OWNED BY st_ref_geomorpho.idGeomorphologie;


--
-- Name: st_ref_geomorpho_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_geomorpho_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_geomorpho_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_geomorpho_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_geomorpho_id_tri_seq OWNED BY st_ref_geomorpho.id_tri;




--
-- Name: st_ref_hic; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_hic (
    "codeHIC" text NOT NULL,
    "libHIC" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_hic OWNER TO postgres;

--
-- Name: TABLE st_ref_hic; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_hic IS 'Référentiel des habitats de la directive habitat (N2000)';


--
-- Name: COLUMN st_ref_hic."codeHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_hic."codeHIC" IS 'code de l''habitat Natura 2000';


--
-- Name: COLUMN st_ref_hic."libHIC"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_hic."libHIC" IS 'libellé de l''habitat Natura 2000';


--
-- Name: st_ref_hic_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_hic_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_hic_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_hic_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_hic_id_tri_seq OWNED BY st_ref_hic.id_tri;


--
-- Name: st_ref_humidite; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_humidite (
    "indHum" text NOT NULL,
    "libHum" text,
    "libLongHum" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_humidite OWNER TO postgres;

--
-- Name: TABLE st_ref_humidite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_humidite IS 'Référentiel de l''indice d''humidité édaphique selon Ellenberg et Julve (moisture)';


--
-- Name: COLUMN st_ref_humidite."indHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."indHum" IS 'Indice de l''Humidité selon Ellenberg et Julve';


--
-- Name: COLUMN st_ref_humidite."libHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."libHum" IS 'libellé court de l''Humidité selon Ellenberg et Julve';


--
-- Name: COLUMN st_ref_humidite."libLongHum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite."libLongHum" IS 'libellé long de l''Humidité selon Ellenberg et Julve';


--
-- Name: COLUMN st_ref_humidite.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_humidite.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_humidite_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_humidite_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_humidite_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_humidite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_humidite_id_tri_seq OWNED BY st_ref_humidite.id_tri;


--
-- Name: st_ref_lumiere; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_lumiere (
    "indLum" text NOT NULL,
    "libLum" text,
    "libLongLum" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_lumiere OWNER TO postgres;

--
-- Name: TABLE st_ref_lumiere; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_lumiere IS 'Référentiel des indices d''affinité de la végétation à la lumière selon Landolt';


--
-- Name: COLUMN st_ref_lumiere."indLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."indLum" IS 'Indice d''affinité à la lumière selon Landolt';


--
-- Name: COLUMN st_ref_lumiere."libLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."libLum" IS 'libellé court d''affinité à la lumière selon Landolt';


--
-- Name: COLUMN st_ref_lumiere."libLongLum"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere."libLongLum" IS 'libellé long  d''affinité à la lumière selon Landolt';


--
-- Name: COLUMN st_ref_lumiere.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_lumiere.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_lumiere_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_lumiere_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_lumiere_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_lumiere_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_lumiere_id_tri_seq OWNED BY st_ref_lumiere.id_tri;


--
-- Name: st_ref_neige; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_neige (
    "idNeige" text NOT NULL,
    "libNeige" text,
    "libLongNeige" text,
    "exempleNeige" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_neige OWNER TO postgres;

--
-- Name: TABLE st_ref_neige; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_neige IS 'Référentiel de l''affinité de la végétation à la neige';


--
-- Name: COLUMN st_ref_neige."idNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."idNeige" IS 'identifiant (code) qui indique l''affinité de la végétation à la neige';


--
-- Name: COLUMN st_ref_neige."libNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."libNeige" IS 'libellé qui indique l''affinité de la végétation à la neige';


--
-- Name: COLUMN st_ref_neige."libLongNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."libLongNeige" IS 'libellé long qui indique l''affinité de la végétation à la neige';


--
-- Name: COLUMN st_ref_neige."exempleNeige"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige."exempleNeige" IS 'exemple de végétation pour ce critère d''affinité à la neige';


--
-- Name: COLUMN st_ref_neige.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_neige.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_neige_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_neige_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_neige_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_neige_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_neige_id_tri_seq OWNED BY st_ref_neige.id_tri;


--
-- Name: st_ref_periode; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_periode (
    "codePeriode" text NOT NULL,
    "libPeriode" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_periode OWNER TO postgres;

--
-- Name: TABLE st_ref_periode; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_periode IS 'Table qui référence les périodes optimales de végétation (liste de début et fin de chaque saison)';


--
-- Name: COLUMN st_ref_periode."codePeriode"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_periode."codePeriode" IS 'code de la période';


--
-- Name: COLUMN st_ref_periode."libPeriode"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_periode."libPeriode" IS 'libellé de la période';


--
-- Name: st_ref_periode_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_periode_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_periode_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_periode_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_periode_id_tri_seq OWNED BY st_ref_periode.id_tri;


--
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


ALTER TABLE syntaxa.st_ref_pvf OWNER TO postgres;

--
-- Name: TABLE st_ref_pvf; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_pvf IS 'Typologie du PVF (PVF1 et PVF2)';


--
-- Name: COLUMN st_ref_pvf."idRattachementPVF"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."idRattachementPVF" IS 'code du syntaxon dans l''un des référentiels pvf (1 ou 2)';


--
-- Name: COLUMN st_ref_pvf."codeReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."codeReferentiel" IS 'code du référentiel (ici PVF)';


--
-- Name: COLUMN st_ref_pvf."versionReferentiel"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."versionReferentiel" IS 'version du référentiel';


--
-- Name: COLUMN st_ref_pvf."identifiantSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."identifiantSyntaxonRetenu" IS 'identifiant du syntaxon retenu dans le référentiel choisi (CD_SYNTAXON dans le PVF)';


--
-- Name: COLUMN st_ref_pvf."rangSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."rangSyntaxonRetenu" IS 'rang du syntaxon retenu dans le référentiel choisi (niveau dans le PVF)';


--
-- Name: COLUMN st_ref_pvf."nomSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf."nomSyntaxonRetenu" IS 'nom du syntaxon retenu dans le référentiel choisi (LB_SYNTAXON dans le PVF)';


--
-- Name: COLUMN st_ref_pvf.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_pvf.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_pvf_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_pvf_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_pvf_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_pvf_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_pvf_id_tri_seq OWNED BY st_ref_pvf.id_tri;


--
-- Name: st_ref_rang_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_rang_seriegeoserie (
    "codeRangSerieGeoserie" text NOT NULL,
    "libRangSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_rang_seriegeoserie OWNER TO postgres;

--
-- Name: TABLE st_ref_rang_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rang_seriegeoserie IS 'Référentiel des rangs de série et de géoséries (ce référentiel n''est pas encore normé par la Société phytosociologique de France- SPF)';


--
-- Name: COLUMN st_ref_rang_seriegeoserie."codeRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_seriegeoserie."codeRangSerieGeoserie" IS 'code du grand de série et de géoséries';


--
-- Name: COLUMN st_ref_rang_seriegeoserie."libRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_seriegeoserie."libRangSerieGeoserie" IS 'libelle du rang de série et de géoséries';


--
-- Name: st_ref_rang_seriegeoserie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_rang_seriegeoserie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_rang_seriegeoserie_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_rang_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rang_seriegeoserie_id_tri_seq OWNED BY st_ref_rang_seriegeoserie.id_tri;


--
-- Name: st_ref_rang_syntaxon; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_rang_syntaxon (
    "codeRangSyntaxon" text NOT NULL,
    "libRangSyntaxon" text,
    "niveauRangSyntaxon" text,
    "suffixeRangSyntaxon" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_rang_syntaxon OWNER TO postgres;

--
-- Name: TABLE st_ref_rang_syntaxon; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rang_syntaxon IS 'Référentiel des rangs de syntaxons';


--
-- Name: COLUMN st_ref_rang_syntaxon."codeRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."codeRangSyntaxon" IS 'code du rang de syntaxon';


--
-- Name: COLUMN st_ref_rang_syntaxon."libRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."libRangSyntaxon" IS 'libelle du rang de syntaxon';


--
-- Name: COLUMN st_ref_rang_syntaxon."niveauRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."niveauRangSyntaxon" IS 'niveau du rang de syntaxon';


--
-- Name: COLUMN st_ref_rang_syntaxon."suffixeRangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rang_syntaxon."suffixeRangSyntaxon" IS 'suffixe correspondant au rang du syntaxon';


--
-- Name: st_ref_rang_syntaxon_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_rang_syntaxon_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_rang_syntaxon_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_rang_syntaxon_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rang_syntaxon_id_tri_seq OWNED BY st_ref_rang_syntaxon.id_tri;


--
-- Name: st_ref_reaction; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_reaction (
    "indReaction" text NOT NULL,
    "libReaction" text,
    "libLongReaction" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_reaction OWNER TO postgres;

--
-- Name: TABLE st_ref_reaction; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_reaction IS 'Référentiel de l''indice de pH selon Landolt (réaction)';


--
-- Name: COLUMN st_ref_reaction."indReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."indReaction" IS 'Indice de la réaction selon Landolt';


--
-- Name: COLUMN st_ref_reaction."libReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."libReaction" IS 'libellé court dela réaction selon Landolt';


--
-- Name: COLUMN st_ref_reaction."libLongReaction"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_reaction."libLongReaction" IS 'libellé long de l''Humidité selon Landolt';


--
-- Name: st_ref_reaction_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_reaction_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_reaction_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_reaction_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_reaction_id_tri_seq OWNED BY st_ref_reaction.id_tri;


--
-- Name: st_ref_rivasmartinez_ombroclimat; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_rivasmartinez_ombroclimat (
    "idOmbroclimat" text NOT NULL,
    "libOmbroclimat" text,
    "libLongOmbroclimat" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_rivasmartinez_ombroclimat OWNER TO postgres;

--
-- Name: TABLE st_ref_rivasmartinez_ombroclimat; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_rivasmartinez_ombroclimat IS 'Référentiel des ombro-climats d''après Rivas-Martinez';


--
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."idOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."idOmbroclimat" IS 'code de l''ombroclimat d''après Rivas-Martinez';


--
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."libOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."libOmbroclimat" IS 'libellé court de l''ombroclimat selon Rivas Martinez';


--
-- Name: COLUMN st_ref_rivasmartinez_ombroclimat."libLongOmbroclimat"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_rivasmartinez_ombroclimat."libLongOmbroclimat" IS 'libellé long de l''ombroclimat selon Rivas-Martinez';


--
-- Name: st_ref_rivasmartinez_ombroclimat_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_rivasmartinez_ombroclimat_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_rivasmartinez_ombroclimat_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_rivasmartinez_ombroclimat_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_rivasmartinez_ombroclimat_id_tri_seq OWNED BY st_ref_rivasmartinez_ombroclimat.id_tri;


--
-- Name: st_ref_salinite; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_salinite (
    "indSali" text NOT NULL,
    "libSali" text,
    "libLongSali" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_salinite OWNER TO postgres;

--
-- Name: TABLE st_ref_salinite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_salinite IS 'Référentiel de l''affinité à la salinité selon Ellenberg et Julve';


--
-- Name: COLUMN st_ref_salinite."indSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."indSali" IS 'Indice de l''affinité à la salinite selon Ellenberg et Julve';


--
-- Name: COLUMN st_ref_salinite."libSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."libSali" IS 'libellé court de l''affinité à la salinite selon Ellenberg et Julve';


--
-- Name: COLUMN st_ref_salinite."libLongSali"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite."libLongSali" IS 'libellé long de l''affinité à la salinite selon Ellenberg et Julve';


--
-- Name: COLUMN st_ref_salinite.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_salinite.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_salinite_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_salinite_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_salinite_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_salinite_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_salinite_id_tri_seq OWNED BY st_ref_salinite.id_tri;


--
-- Name: st_ref_statut_chorologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_statut_chorologie (
    "idStatutChorologie" text NOT NULL,
    "libStatutChrologie" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_statut_chorologie OWNER TO postgres;

--
-- Name: TABLE st_ref_statut_chorologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_statut_chorologie IS 'Référentiel qui contient les valeurs que peuvent prendre les statuts de chorologie';


--
-- Name: COLUMN st_ref_statut_chorologie."idStatutChorologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_statut_chorologie."idStatutChorologie" IS 'Code du statut de chorologie';


--
-- Name: COLUMN st_ref_statut_chorologie."libStatutChrologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_statut_chorologie."libStatutChrologie" IS 'libellé du statut de chorologie';


--
-- Name: st_ref_statut_chorologie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_statut_chorologie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_statut_chorologie_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_statut_chorologie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_statut_chorologie_id_tri_seq OWNED BY st_ref_statut_chorologie.id_tri;


--
-- Name: st_ref_temperature; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_temperature (
    "indTemp" text NOT NULL,
    "libTemp" text,
    "libLongTemp" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_temperature OWNER TO postgres;

--
-- Name: TABLE st_ref_temperature; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_temperature IS 'Référentiel des indices de température selon Landolt';


--
-- Name: COLUMN st_ref_temperature."indTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."indTemp" IS 'Indice de la température selon Landolt';


--
-- Name: COLUMN st_ref_temperature."libTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."libTemp" IS 'libellé court de la température selon Landolt';


--
-- Name: COLUMN st_ref_temperature."libLongTemp"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature."libLongTemp" IS 'libellé long de température selon Landolt';


--
-- Name: COLUMN st_ref_temperature.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_temperature.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_temperature_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_temperature_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_temperature_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_temperature_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_temperature_id_tri_seq OWNED BY st_ref_temperature.id_tri;


--
-- Name: st_ref_tete_serie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_tete_serie (
    "codeTeteSerie" text NOT NULL,
    "libTeteSerie" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_tete_serie OWNER TO postgres;

--
-- Name: TABLE st_ref_tete_serie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_tete_serie IS 'Référentiel des stades de la série (ou géosérie)';


--
-- Name: COLUMN st_ref_tete_serie."codeTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_tete_serie."codeTeteSerie" IS 'Indique si ce stade représente la tête de série ou non';


--
-- Name: COLUMN st_ref_tete_serie."libTeteSerie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_tete_serie."libTeteSerie" IS 'Décrit le type de stade (tête de série ou stade intermediaire)';


--
-- Name: st_ref_tete_serie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_tete_serie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_tete_serie_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_tete_serie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_tete_serie_id_tri_seq OWNED BY st_ref_tete_serie.id_tri;


--
-- Name: st_ref_trophie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_trophie (
    "indTrophie" text NOT NULL,
    "libTrophie" text,
    "libLongTrophie" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_trophie OWNER TO postgres;

--
-- Name: TABLE st_ref_trophie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_trophie IS 'Référentiel de la trophie selon Landolt';


--
-- Name: COLUMN st_ref_trophie."indTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."indTrophie" IS 'Indice de la trophie selon Landolt';


--
-- Name: COLUMN st_ref_trophie."libTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."libTrophie" IS 'libellé court dela trophie selon Landolt';


--
-- Name: COLUMN st_ref_trophie."libLongTrophie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_trophie."libLongTrophie" IS 'libellé long de trophie selon Landolt';


--
-- Name: st_ref_trophie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_trophie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_trophie_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_trophie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_trophie_id_tri_seq OWNED BY st_ref_trophie.id_tri;


--
-- Name: st_ref_type_facies; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_facies (
    "codeFacies" text NOT NULL,
    "libFacies" text,
    "libLongFacies" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_type_facies OWNER TO postgres;

--
-- Name: TABLE st_ref_type_facies; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_facies IS 'Référentiel des types de faciès';


--
-- Name: COLUMN st_ref_type_facies."codeFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."codeFacies" IS 'code du type de faciès';


--
-- Name: COLUMN st_ref_type_facies."libFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."libFacies" IS 'libelle du type de faciès';


--
-- Name: COLUMN st_ref_type_facies."libLongFacies"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_facies."libLongFacies" IS 'libelle long du type de faciès';


--
-- Name: st_ref_type_facies_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_facies_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_type_facies_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_type_facies_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_facies_id_tri_seq OWNED BY st_ref_type_facies.id_tri;


--
-- Name: st_ref_type_physionomique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_physionomique (
    "idTypePhysio" text NOT NULL,
    "libTypePhysio" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_type_physionomique OWNER TO postgres;

--
-- Name: TABLE st_ref_type_physionomique; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_physionomique IS 'Référentiel des types physionomiques';


--
-- Name: COLUMN st_ref_type_physionomique."idTypePhysio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_physionomique."idTypePhysio" IS 'identifiant du type physionomique';


--
-- Name: COLUMN st_ref_type_physionomique."libTypePhysio"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_physionomique."libTypePhysio" IS 'libellé du type physionomique';


--
-- Name: st_ref_type_physionomique_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_physionomique_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_type_physionomique_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_type_physionomique_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_physionomique_id_tri_seq OWNED BY st_ref_type_physionomique.id_tri;


--
-- Name: st_ref_type_seriegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_seriegeoserie (
    "codeTypeSerieGeoserie" text NOT NULL,
    "libTypeSerieGeoserie" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_type_seriegeoserie OWNER TO postgres;

--
-- Name: TABLE st_ref_type_seriegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_seriegeoserie IS 'Référentiel des types de série et de géoséries';


--
-- Name: COLUMN st_ref_type_seriegeoserie."codeTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie."codeTypeSerieGeoserie" IS 'code du type de série et de géoséries';


--
-- Name: COLUMN st_ref_type_seriegeoserie."libTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie."libTypeSerieGeoserie" IS 'libelle du type de série et de géoséries';


--
-- Name: COLUMN st_ref_type_seriegeoserie.id_tri; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_seriegeoserie.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


--
-- Name: st_ref_type_seriegeoserie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_seriegeoserie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_type_seriegeoserie_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_type_seriegeoserie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_seriegeoserie_id_tri_seq OWNED BY st_ref_type_seriegeoserie.id_tri;


--
-- Name: st_ref_type_synonymie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE st_ref_type_synonymie (
    "idTypeSyn" text NOT NULL,
    "libTypSyn" text,
    id_tri integer NOT NULL
);


ALTER TABLE syntaxa.st_ref_type_synonymie OWNER TO postgres;

--
-- Name: TABLE st_ref_type_synonymie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_ref_type_synonymie IS 'Référentiel des types de synonymie';


--
-- Name: COLUMN st_ref_type_synonymie."idTypeSyn"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_synonymie."idTypeSyn" IS 'identifiant du type de synonymie';


--
-- Name: COLUMN st_ref_type_synonymie."libTypSyn"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_ref_type_synonymie."libTypSyn" IS 'libellé du type de synonymie';


--
-- Name: st_ref_type_synonymie_id_tri_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_ref_type_synonymie_id_tri_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_ref_type_synonymie_id_tri_seq OWNER TO postgres;

--
-- Name: st_ref_type_synonymie_id_tri_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_ref_type_synonymie_id_tri_seq OWNED BY st_ref_type_synonymie.id_tri;


--
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


ALTER TABLE syntaxa.st_serie_petitegeoserie OWNER TO postgres;

--
-- Name: TABLE st_serie_petitegeoserie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_serie_petitegeoserie IS 'Table contenant la nomenclature des séries et petites géoséries ainsi que leurs principaux descripteurs (univariés)';


--
-- Name: COLUMN st_serie_petitegeoserie."idCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idCatalogue" IS 'clef étrangère vers identifiant unique du catalogue';


--
-- Name: COLUMN st_serie_petitegeoserie."codeEnregistrementSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeEnregistrementSerieGeoserie" IS 'identifiant unique de l''enregistrement (de la ligne) dans le catalogue qui associe l''identifiant unique du (geo)sigmataxon et l''identifiant du catalogue';


--
-- Name: COLUMN st_serie_petitegeoserie."idSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idSerieGeoserie" IS 'identifiant unique du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';


--
-- Name: COLUMN st_serie_petitegeoserie."nomSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomSerieGeoserie" IS 'nom latin du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';


--
-- Name: COLUMN st_serie_petitegeoserie."auteurSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."auteurSerieGeoserie" IS 'autorité du (geo)sigmataxon:  on met le nom de l''auteur qui a publié le (geo)sigmataxon synonyme sinon on met (ined = « inédit »)';


--
-- Name: COLUMN st_serie_petitegeoserie."nomCompletSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomCompletSerieGeoserie" IS 'nom complet  (nom+autorité) du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';


--
-- Name: COLUMN st_serie_petitegeoserie."remarqueNomenclaturale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."remarqueNomenclaturale" IS 'Champ libre donnant des précisions sur le nom choisi dans le cas où le nom n''existe pas dans le PVF';


--
-- Name: COLUMN st_serie_petitegeoserie."typeSynonymie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."typeSynonymie" IS 'type de synonymie du (geo)sigmataxon';


--
-- Name: COLUMN st_serie_petitegeoserie."idSerieGeoserieRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idSerieGeoserieRetenu" IS 'identifiant du (geo)sigmataxon retenu auquel renvoie le (geo)sigmataxon synonyme dans la base mère';


--
-- Name: COLUMN st_serie_petitegeoserie."nomSerieGeoserieRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomSerieGeoserieRetenu" IS 'nom complet latin du (geo)sigmataxon retenu auquel renvoie le (geo)sigmataxon synonyme dans la base mère';


--
-- Name: COLUMN st_serie_petitegeoserie."nomSerieGeoserieRaccourci"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomSerieGeoserieRaccourci" IS 'nom raccourci du (geo)sigmataxon retenu';


--
-- Name: COLUMN st_serie_petitegeoserie."idSerieGeoserieSup"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."idSerieGeoserieSup" IS 'identifiant du (geo)sigmataxon directement supérieur auquel appartient le (geo)sigmataxon (notamment dans l''hypothèse de l''existance de sous-séries)';


--
-- Name: COLUMN st_serie_petitegeoserie."codeTypeSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeTypeSerieGeoserie" IS 'type de (geo)sigmataxon (permasérie, curtasérie, série...)';


--
-- Name: COLUMN st_serie_petitegeoserie."codeCategorieSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeCategorieSerieGeoserie" IS 'catégorie de (geo)sigmataxon (Edaphoxérophile, …)';


--
-- Name: COLUMN st_serie_petitegeoserie."codeRangSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."codeRangSerieGeoserie" IS 'niveau du (geo)sigmataxon (série, sous-série, ...)';


--
-- Name: COLUMN st_serie_petitegeoserie."nomFrancaisSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."nomFrancaisSerieGeoserie" IS 'Nom français pour les séries <série> de la <type de formation> à <nom latin 1> et <nom latin 2>
Sous-série à <nom latin du stade dynamique discriminant> et les petites géoséries < géosérie> de <nom de la série dominante en français>';


--
-- Name: COLUMN st_serie_petitegeoserie."diagnoseCourteSerieGeoserie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."diagnoseCourteSerieGeoserie" IS 'La diagnose doit tenir en une seule phrase et inclus le type de série (série, curtasérie, permasérie), la catégorie (climatophile, édaphoxérophile, edaphohygrophile), la géographie, le bioclimat, la lithologie, l''étage de végétation éventuellement et le nom français.';


--
-- Name: COLUMN st_serie_petitegeoserie.confusion; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie.confusion IS 'confusion possible : nom complet du (geo)sigmataxon qui pourrait être confondu avec';


--
-- Name: COLUMN st_serie_petitegeoserie."confusionRemarque"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."confusionRemarque" IS 'text libre portant sur la nature de la confusion et les critères de différentiation';


--
-- Name: COLUMN st_serie_petitegeoserie."repartitionGenerale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."repartitionGenerale" IS 'Texte libre qui indique la répartition sur le territoire français et transfrontalier';


--
-- Name: COLUMN st_serie_petitegeoserie."repartitionTerritoire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."repartitionTerritoire" IS 'Répartition dans le territoire étudié. Champ texte libre. Répartition à petite échelle. On indique la présence dans les petites régions naturelles propres à chaque CBN (région naturelle de présence)';


--
-- Name: COLUMN st_serie_petitegeoserie."aireMinimale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."aireMinimale" IS 'Aire minimale d''expression du (geo)sigmasyntaxa en hectares';


--
-- Name: COLUMN st_serie_petitegeoserie."typePhysionomique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."typePhysionomique" IS 'il s''agit de la physionomie de la formations végétale dominante. On utilise pour ce champ la typologie des formations végétales.';


--
-- Name: COLUMN st_serie_petitegeoserie."lithologiePedologieHumus"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."lithologiePedologieHumus" IS 'texte libre sur la lithologie, la pédologie et l''humus.';


--
-- Name: COLUMN st_serie_petitegeoserie.geomorphologie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie.geomorphologie IS 'liste de vocabulaire partagé proposé par B.Etlicher';


--
-- Name: COLUMN st_serie_petitegeoserie."humiditePrincipale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."humiditePrincipale" IS 'codification du caractère hygrophile du (geo)sigmasyntaxon sur le territoire (appartenance principale = conditions optimales)';


--
-- Name: COLUMN st_serie_petitegeoserie."humiditeSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."humiditeSecondaire" IS 'codification du caractère hygrophile du (geo)sigmasyntaxon sur le territoire (appartenance secondaire= condition favorables)';


--
-- Name: COLUMN st_serie_petitegeoserie."phPrincipal"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."phPrincipal" IS 'codification du pH (appartenance principale= conditions optimales d''expression du (geo)sigmasyntaxon)';


--
-- Name: COLUMN st_serie_petitegeoserie."phSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."phSecondaire" IS 'codification du pH  (appartenance secondaire= conditions favorables d''expression du (geo)sigmasyntaxon)';


--
-- Name: COLUMN st_serie_petitegeoserie.exposition; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie.exposition IS 'exposition dominante de la série ou petite géosérie';


--
-- Name: COLUMN st_serie_petitegeoserie."descriptionEcologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."descriptionEcologie" IS 'Champ libre mais harmonisé de remarque sur l''écologie du (geo)sigmasyntaxon';


--
-- Name: COLUMN st_serie_petitegeoserie."remarqueVariabilite"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité de la série ou la géosérie. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';


--
-- Name: COLUMN st_serie_petitegeoserie."remarqueRarete"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."remarqueRarete" IS 'Champ libre sur la rareté, l''endémisme et les végétations remarquables';


--
-- Name: COLUMN st_serie_petitegeoserie."etatConservation"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_serie_petitegeoserie."etatConservation" IS 'Champ texte libre. Menaces, état de conservation, principaux usages, facteurs de conservation.
Il s''agit de décrire les menaces sur la série dans son entier ou sur un sigmafaciès et pas sur un stade dynamique (dans ce cas on se réfère à la fiche syntaxon du stade dynamique).';


--
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


ALTER TABLE syntaxa.st_suivi_enregistrement OWNER TO postgres;

--
-- Name: TABLE st_suivi_enregistrement; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_suivi_enregistrement IS 'Table de suivi des enregistrements (création et mise à jour)';


--
-- Name: COLUMN st_suivi_enregistrement."idSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."idSuivi" IS ' identifiant unique de l''action de suivi de l''enregistrement dans la table';


--
-- Name: COLUMN st_suivi_enregistrement."codeEnregistrement"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel le suivi est réalisé';


--
-- Name: COLUMN st_suivi_enregistrement."dateSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."dateSuivi" IS 'date de suivi de la table';


--
-- Name: COLUMN st_suivi_enregistrement."idAuteurSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."idAuteurSuivi" IS 'identifiant de la personne ayant réalisé le suivi de la table';


--
-- Name: COLUMN st_suivi_enregistrement."prenomAuteurSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."prenomAuteurSuivi" IS 'prénom de la personne ayany réalisé le suivi de l''enregistrement';


--
-- Name: COLUMN st_suivi_enregistrement."nomAuteurSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."nomAuteurSuivi" IS 'nom de la personne ayany réalisé le suivi de l''enregistrement';


--
-- Name: COLUMN st_suivi_enregistrement."actionSuivi"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_suivi_enregistrement."actionSuivi" IS 'action de suivi (création ou mise à jour)';


--
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


ALTER TABLE syntaxa.st_syntaxon OWNER TO postgres;

--
-- Name: TABLE st_syntaxon; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON TABLE st_syntaxon IS 'Table contenant les syntaxons et leurs principaux descripteurs (univariés)';


--
-- Name: COLUMN st_syntaxon."idCatalogue"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idCatalogue" IS 'identifiant du catalogue d''appartenance de l''enregistrmenet';


--
-- Name: COLUMN st_syntaxon."codeEnregistrementSyntax"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."codeEnregistrementSyntax" IS 'identifiant unique de l''enregistrement (de la ligne) dans le catalogue qui associe l''identifiant unique du syntaxon synonyme et l''identifiant du catalogue';


--
-- Name: COLUMN st_syntaxon."idSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idSyntaxon" IS 'identifiant unique du syntaxon dans le catalogue d''origine';


--
-- Name: COLUMN st_syntaxon."nomSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomSyntaxon" IS 'nom latin du syntaxon synonyme dans le catalogue d''origine';


--
-- Name: COLUMN st_syntaxon."auteurSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."auteurSyntaxon" IS 'autorité et date du syntaxon synonyme';


--
-- Name: COLUMN st_syntaxon."nomCompletSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomCompletSyntaxon" IS 'Nom complet du syntaxon synonyme dans le catalogue d''origine (concaténation des champs "NOM_SYNTAXON" et "AUTEUR_SYNTAXON")';


--
-- Name: COLUMN st_syntaxon."rqNomenclaturale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqNomenclaturale" IS 'Champ libre donnant des précisions sur le nom choisi dans le cas où le nom n''existe pas dans le PVF';


--
-- Name: COLUMN st_syntaxon."typeSynonymie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."typeSynonymie" IS 'type de synonymie du syntaxon';


--
-- Name: COLUMN st_syntaxon."idSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idSyntaxonRetenu" IS 'identifiant unique du syntaxon retenu dans le catalogue d''origine (syntaxon de référence retenu par le CBN)  auquel renvoie le syntaxon ';


--
-- Name: COLUMN st_syntaxon."nomSyntaxonRetenu"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomSyntaxonRetenu" IS 'nom complet du syntaxon retenu dans le catalogue d''origine (syntaxon de référence retenu par le CBN) auquel renvoie le syntaxon synonyme';


--
-- Name: COLUMN st_syntaxon."nomSyntaxonRaccourci"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomSyntaxonRaccourci" IS 'nom raccourci du syntaxon retenu';


--
-- Name: COLUMN st_syntaxon."rangSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rangSyntaxon" IS 'niveau du syntaxon dans la classification syntaxonomique';


--
-- Name: COLUMN st_syntaxon."idSyntaxonSup"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idSyntaxonSup" IS 'identifiant du syntaxon directement supérieur auquel appartient le syntaxon';


--
-- Name: COLUMN st_syntaxon."nomFrancaisSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."nomFrancaisSyntaxon" IS 'nom français harmonisé qui correspond à la traduction française du nom latin. ';


--
-- Name: COLUMN st_syntaxon."diagnoseCourteSyntaxon"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."diagnoseCourteSyntaxon" IS 'Description libre en une phrase qui inclus formation végétale + terme écologique et chorologique incluant l’étage de végétation';


--
-- Name: COLUMN st_syntaxon."idCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."idCritique" IS 'réponse de type oui/non: Le syntaxon est-il clairement délimité ou non? Est-il franc? (renvoi à la typicité du syntaxon)';


--
-- Name: COLUMN st_syntaxon."rqCritique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqCritique" IS 'champ texte libre de commentaire sur la typicité du syntaxon';


--
-- Name: COLUMN st_syntaxon."repartitionGenerale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."repartitionGenerale" IS 'Texte libre qui indique la répartition sur le territoire français et transfrontalier';


--
-- Name: COLUMN st_syntaxon."repartitionTerritoire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."repartitionTerritoire" IS 'Répartition dans le territoire étudié. Champ texte libre. Répartition à petite échelle. On indique la présence dans les petites régions naturelles propres à chaque CBN (région naturelle de présence)';


--
-- Name: COLUMN st_syntaxon."periodeDebObsOptimale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."periodeDebObsOptimale" IS 'début de la période  optimale d''observation de la végétation';


--
-- Name: COLUMN st_syntaxon."periodeFinObsOptimale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."periodeFinObsOptimale" IS 'fin de la période  optimale d''observation de la végétation';


--
-- Name: COLUMN st_syntaxon."rqPhenologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqPhenologie" IS 'Champ libre (mais harmonisé) de remarque sur la phénologie';


--
-- Name: COLUMN st_syntaxon."typeBiologiqueDom"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."typeBiologiqueDom" IS 'Champ libre du type biologique dominant (type biologique dominant des taxons composant la végétation)';


--
-- Name: COLUMN st_syntaxon."typePhysionomique"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."typePhysionomique" IS 'Type physionomique de la formation végétale (référentiel interne aux CBN, le plus précis possible)';


--
-- Name: COLUMN st_syntaxon."rqPhysionomie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."rqPhysionomie" IS 'champ libre de remarque portant sur la physionomie de la végétation';


--
-- Name: COLUMN st_syntaxon."humiditePrincipale"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."humiditePrincipale" IS 'codification du caractère hygrophile du syntaxon sur le territoire (appartenance principale = conditions optimales)';


--
-- Name: COLUMN st_syntaxon."humiditeSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."humiditeSecondaire" IS 'codification du caractère hygrophile du syntaxon sur le territoire (appartenance secondaire= condition favorables)';


--
-- Name: COLUMN st_syntaxon."phPrincipal"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."phPrincipal" IS 'codification du pH (appartenance principale= conditions optimales)';


--
-- Name: COLUMN st_syntaxon."phSecondaire"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."phSecondaire" IS 'codification du pH  (appartenance secondaire= conditions favorables)';


--
-- Name: COLUMN st_syntaxon.trophie; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.trophie IS 'codification de la trophie';


--
-- Name: COLUMN st_syntaxon.temperature; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.temperature IS 'codification du caractère thermique';


--
-- Name: COLUMN st_syntaxon.luminosite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.luminosite IS 'codification de la luminosité';


--
-- Name: COLUMN st_syntaxon.exposition; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.exposition IS 'codification de l''exposition';


--
-- Name: COLUMN st_syntaxon.salinite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.salinite IS 'caractère halophile de la végétation';


--
-- Name: COLUMN st_syntaxon.neige; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.neige IS 'caractère chinophile de la végétation';


--
-- Name: COLUMN st_syntaxon.continentalite; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.continentalite IS 'caractère continental ou non de la végétation';


--
-- Name: COLUMN st_syntaxon.ombroclimat; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.ombroclimat IS 'ombroclimat  selon Rivas-Martinez, 1981';


--
-- Name: COLUMN st_syntaxon.climat; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon.climat IS 'climats selon Joly et al, 2010';


--
-- Name: COLUMN st_syntaxon."descriptionEcologie"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."descriptionEcologie" IS 'Champ texte libre de description de l''écologie générale du syntaxon';


--
-- Name: COLUMN st_syntaxon."remarqueVariabilite"; Type: COMMENT; Schema: syntaxa; Owner: postgres
--

COMMENT ON COLUMN st_syntaxon."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité du faciès. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';


--
-- Name: st_syntaxon_uid_seq; Type: SEQUENCE; Schema: syntaxa; Owner: postgres
--

CREATE SEQUENCE st_syntaxon_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE syntaxa.st_syntaxon_uid_seq OWNER TO postgres;

--
-- Name: st_syntaxon_uid_seq; Type: SEQUENCE OWNED BY; Schema: syntaxa; Owner: postgres
--

ALTER SEQUENCE st_syntaxon_uid_seq OWNED BY st_syntaxon.uid;


--
-- Name: temp_st_annuaire_organismes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_annuaire_organismes (
    "idOrganisme" character varying,
    "acronymeOrganisme" character varying,
    "libOrganisme" character varying
);


ALTER TABLE syntaxa.temp_st_annuaire_organismes OWNER TO postgres;

--
-- Name: temp_st_annuaire_personnes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_annuaire_personnes (
    "idPersonne" character varying,
    prenom character varying,
    nom character varying
);


ALTER TABLE syntaxa.temp_st_annuaire_personnes OWNER TO postgres;

--
-- Name: temp_st_biblio; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_biblio (
    "idBiblio" character varying,
    "codeEnregistrement" character varying,
    "libPublication" character varying,
    "urlPublication" character varying,
    "codePublication" character varying
);


ALTER TABLE syntaxa.temp_st_biblio OWNER TO postgres;

--
-- Name: temp_st_catalogue_description; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_catalogue_description (
    "identifiantCatalogue" character varying,
    "libelleCatalogue" character varying,
    "versionCatalogue" character varying,
    "typeCatalogue" character varying,
    "dateCreationCatalogue" character varying,
    "dateMiseAJourCatalogue" character varying,
    "idCollaborateurCatalogue" character varying,
    "idTerritoireCatalogue" character varying,
    "codeTypeTerritoireCatalogue" character varying,
    "codeTerritoireCatalogue" character varying,
    "libelleTerritoireCatalogue" character varying,
    "empriseTerritoireCatalogue" character varying,
    "remarqueTerritoireCatalogue" character varying
);


ALTER TABLE syntaxa.temp_st_catalogue_description OWNER TO postgres;

--
-- Name: temp_st_chorologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_chorologie (
    "idChorologie" character varying,
    "codeEnregistrement" character varying,
    "statutChorologie" character varying,
    "idTerritoire" character varying
);


ALTER TABLE syntaxa.temp_st_chorologie OWNER TO postgres;

--
-- Name: temp_st_collaborateur; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_collaborateur (
    "idCollaborateur" character varying,
    "identifiantCatalogue" character varying,
    "idOrganisme" character varying,
    "acronymeOrganisme" character varying,
    "idPersonne" character varying,
    prenom character varying,
    nom character varying
);


ALTER TABLE syntaxa.temp_st_collaborateur OWNER TO postgres;

--
-- Name: temp_st_correspondance_hic; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_correspondance_hic (
    "idCorresHIC" character varying,
    "codeEnregistrement" character varying,
    "typeEnregistrement" character varying,
    "codeHIC" character varying,
    "libHIC" character varying,
    "rqHIC" character varying
);


ALTER TABLE syntaxa.temp_st_correspondance_hic OWNER TO postgres;

--
-- Name: temp_st_correspondance_pvf; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_correspondance_pvf (
    "idCorrespondancePVF" character varying,
    "idRattachementPVF" character varying,
    "codeEnregistrementSyntaxon" character varying,
    "codeReferentiel" character varying,
    "versionReferentiel" character varying,
    "identifiantSyntaxonRetenu" character varying,
    "nomSyntaxonRetenu" character varying,
    "identifiantSyntaxonOrigine" character varying
);


ALTER TABLE syntaxa.temp_st_correspondance_pvf OWNER TO postgres;

--
-- Name: temp_st_cortege_floristique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_cortege_floristique (
    "idCortegeFloristique" character varying,
    "codeEnregistrementSyntaxon" character varying,
    "idRattachementReferentiel" character varying,
    "typeTaxon" character varying
);


ALTER TABLE syntaxa.temp_st_cortege_floristique OWNER TO postgres;

--
-- Name: temp_st_cortege_syntaxonomique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_cortege_syntaxonomique (
    "codeEnregistrementCortegeSyntax" character varying,
    "idGeosigmafacies" character varying,
    "libelleGeoSigmafacies" character varying,
    "codeEnregistrementSyntax" character varying,
    "idSyntaxonRetenu" character varying,
    "nomSyntaxonRetenu" character varying,
    "rqSyntaxon" character varying,
    "pourcentageTheoriqSyntax" character varying,
    "codeTeteSerie" character varying
);


ALTER TABLE syntaxa.temp_st_cortege_syntaxonomique OWNER TO postgres;

--
-- Name: temp_st_etage_bioclim; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_etage_bioclim (
    "idCorresEtageBioclim" character varying,
    "codeEnregistrement" character varying,
    "codeEtageBioclim" character varying,
    "libEtageBioclim" character varying
);


ALTER TABLE syntaxa.temp_st_etage_bioclim OWNER TO postgres;

--
-- Name: temp_st_etage_veg; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_etage_veg (
    "idCorresEtageveg" character varying,
    "codeEnregistrement" character varying,
    "codeEtageVeg" character varying,
    "libEtageVeg" character varying
);


ALTER TABLE syntaxa.temp_st_etage_veg OWNER TO postgres;

--
-- Name: temp_st_geo_sigmafacies; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_geo_sigmafacies (
    "idGeosigmafacies" character varying,
    "codeEnregistrementSerieGeoserie" character varying,
    "codeFacies" character varying,
    "libelleGeoSigmafacies" character varying,
    dominance character varying,
    usage character varying,
    "remarqueVariabilite" character varying
);


ALTER TABLE syntaxa.temp_st_geo_sigmafacies OWNER TO postgres;

--
-- Name: temp_st_geomorphologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_geomorphologie (
    "idVegGeomorpho" character varying,
    "codeEnregistrement" character varying,
    "idGeomorphologie" character varying,
    "libGeomorphologie" character varying
);


ALTER TABLE syntaxa.temp_st_geomorphologie OWNER TO postgres;

--
-- Name: temp_st_indicateurs_floristiques; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_indicateurs_floristiques (
    "idIndicateurFlor" character varying,
    "idGeosigmafacies" character varying,
    "idRattachementReferentiel" character varying
);


ALTER TABLE syntaxa.temp_st_indicateurs_floristiques OWNER TO postgres;

--
-- Name: temp_st_serie_petitegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_serie_petitegeoserie (
    "idCatalogue" character varying,
    "codeEnregistrementSerieGeoserie" character varying,
    "idSerieGeoserie" character varying,
    "nomSerieGeoserie" character varying,
    "auteurSerieGeoserie" character varying,
    "nomCompletSerieGeoserie" character varying,
    "remarqueNomenclaturale" character varying,
    "typeSynonymie" character varying,
    "idSerieGeoserieRetenu" character varying,
    "nomSerieGeoserieRetenu" character varying,
    "nomSerieGeoserieRaccourci" character varying,
    "idSerieGeoserieSup" character varying,
    "codeTypeSerieGeoserie" character varying,
    "codeCategorieSerieGeoserie" character varying,
    "codeRangSerieGeoserie" character varying,
    "nomFrancaisSerieGeoserie" character varying,
    "diagnoseCourteSerieGeoserie" character varying,
    confusion character varying,
    "confusionRemarque" character varying,
    "repartitionGenerale" character varying,
    "repartitionTerritoire" character varying,
    "aireMinimale" character varying,
    "typePhysionomique" character varying,
    "lithologiePedologieHumus" character varying,
    geomorphologie character varying,
    "humiditePrincipale" character varying,
    "humiditeSecondaire" character varying,
    "phPrincipal" character varying,
    "phSecondaire" character varying,
    exposition character varying,
    "descriptionEcologie" character varying,
    "remarqueVariabilite" character varying,
    "remarqueRarete" character varying,
    "etatConservation" character varying
);


ALTER TABLE syntaxa.temp_st_serie_petitegeoserie OWNER TO postgres;

--
-- Name: temp_st_suivi_enregistrement; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_suivi_enregistrement (
    "idSuivi" character varying,
    "codeEnregistrement" character varying,
    "dateSuivi" character varying,
    "idAuteurSuivi" character varying,
    "prenomAuteurSuivi" character varying,
    "nomAuteurSuivi" character varying,
    "actionSuivi" character varying
);


ALTER TABLE syntaxa.temp_st_suivi_enregistrement OWNER TO postgres;

--
-- Name: temp_st_syntaxon; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_syntaxon (
    "idCatalogue" character varying,
    "codeEnregistrementSyntax" character varying,
    "idSyntaxon" character varying,
    "nomSyntaxon" character varying,
    "auteurSyntaxon" character varying,
    "nomCompletSyntaxon" character varying,
    "rqNomenclaturale" character varying,
    "typeSynonymie" character varying,
    "idSyntaxonRetenu" character varying,
    "nomSyntaxonRetenu" character varying,
    "nomSyntaxonRaccourci" character varying,
    "rangSyntaxon" character varying,
    "idSyntaxonSup" character varying,
    "nomFrancaisSyntaxon" character varying,
    "diagnoseCourteSyntaxon" character varying,
    "idCritique" character varying,
    "rqCritique" character varying,
    "repartitionGenerale" character varying,
    "repartitionTerritoire" character varying,
    "periodeDebObsOptimale" character varying,
    "periodeFinObsOptimale" character varying,
    "rqPhenologie" character varying,
    "aireMinimale" character varying,
    "typeBiologiqueDom" character varying,
    "typePhysionomique" character varying,
    "rqPhysionomie" character varying,
    "humiditePrincipale" character varying,
    "humiditeSecondaire" character varying,
    "phPrincipal" character varying,
    "phSecondaire" character varying,
    trophie character varying,
    temperature character varying,
    luminosite character varying,
    exposition character varying,
    salinite character varying,
    neige character varying,
    continentalite character varying,
    ombroclimat character varying,
    climat character varying,
    "descriptionEcologie" character varying,
    "remarqueVariabilite" character varying
);


ALTER TABLE syntaxa.temp_st_syntaxon OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY fsd_syntaxa ALTER COLUMN id SET DEFAULT nextval('fsd_syntaxa_id_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY liste_geo ALTER COLUMN id_tri SET DEFAULT nextval('liste_geo_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_annuaire_personnes ALTER COLUMN id_tri SET DEFAULT nextval('st_annuaire_personnes_id_tri_seq'::regclass);


--
-- Name: idBiblio; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_biblio ALTER COLUMN "idBiblio" SET DEFAULT nextval('"st_biblio_idBiblio_seq"'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_catalogue_description ALTER COLUMN id_tri SET DEFAULT nextval('st_catalogue_description_id_tri_seq'::regclass);


--
-- Name: idChorologie; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_chorologie ALTER COLUMN "idChorologie" SET DEFAULT nextval('"st_chorologie_idChorologie_seq"'::regclass);


--
-- Name: idCorresEUNIS; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_eunis ALTER COLUMN "idCorresEUNIS" SET DEFAULT nextval('"st_correspondance_eunis_idCorresEUNIS_seq"'::regclass);


--
-- Name: idCorresHIC; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_hic ALTER COLUMN "idCorresHIC" SET DEFAULT nextval('"st_correspondance_hic_idCorresHIC_seq"'::regclass);


--
-- Name: idCorrespondancePVF; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_pvf ALTER COLUMN "idCorrespondancePVF" SET DEFAULT nextval('"st_correspondance_pvf_idCorrespondancePVF_seq"'::regclass);


--
-- Name: idCorresEtageBioclim; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_bioclim ALTER COLUMN "idCorresEtageBioclim" SET DEFAULT nextval('"st_etage_bioclim_idCorresEtageBioclim_seq"'::regclass);


--
-- Name: idCorresEtageveg; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_veg ALTER COLUMN "idCorresEtageveg" SET DEFAULT nextval('"st_etage_veg_idCorresEtageveg_seq"'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_action_suivi ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_action_suivi_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_categorie_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_categorie_seriegeoserie_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_continentalite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_continentalite_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_critique ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_critique_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_etage_bioclim ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_etage_bioclim_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_etage_veg ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_etage_veg_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_eunis ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_eunis_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_exposition ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_exposition_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_geomorpho ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_geomorpho_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_hic ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_hic_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_humidite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_humidite_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_lumiere ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_lumiere_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_neige ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_neige_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_periode ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_periode_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_pvf ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_pvf_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rang_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rang_seriegeoserie_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rang_syntaxon ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rang_syntaxon_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_reaction ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_reaction_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_rivasmartinez_ombroclimat ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_rivasmartinez_ombroclimat_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_salinite ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_salinite_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_statut_chorologie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_statut_chorologie_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_temperature ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_temperature_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_tete_serie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_tete_serie_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_trophie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_trophie_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_facies ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_facies_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_physionomique ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_physionomique_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_seriegeoserie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_seriegeoserie_id_tri_seq'::regclass);


--
-- Name: id_tri; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_ref_type_synonymie ALTER COLUMN id_tri SET DEFAULT nextval('st_ref_type_synonymie_id_tri_seq'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon ALTER COLUMN uid SET DEFAULT nextval('st_syntaxon_uid_seq'::regclass);


--
-- Name: PK_liste_geo; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY liste_geo
    ADD CONSTRAINT "PK_liste_geo" PRIMARY KEY (id_territoire);


--
-- Name: PK_referentiel; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY referentiel_taxo
    ADD CONSTRAINT "PK_referentiel" PRIMARY KEY (id_rattachement_referentiel);


--
-- Name: codeActionSuivi_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_action_suivi
    ADD CONSTRAINT "codeActionSuivi_pkey" PRIMARY KEY ("codeActionSuivi");


--
-- Name: codeCategorieSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_categorie_seriegeoserie
    ADD CONSTRAINT "codeCategorieSerieGeoserie_pkey" PRIMARY KEY ("codeCategorieSerieGeoserie");


--
-- Name: codeEUNIS_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_eunis
    ADD CONSTRAINT "codeEUNIS_pkey" PRIMARY KEY ("codeEUNIS");


--
-- Name: codeEnregistrementCortegeSyntax_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_cortege_syntaxonomique
    ADD CONSTRAINT "codeEnregistrementCortegeSyntax_pkey" PRIMARY KEY ("codeEnregistrementCortegeSyntax");


--
-- Name: codeEnregistrementSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "codeEnregistrementSerieGeoserie_pkey" PRIMARY KEY ("codeEnregistrementSerieGeoserie");


--
-- Name: codeEnregistrementSyntax_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "codeEnregistrementSyntax_pkey" PRIMARY KEY ("codeEnregistrementSyntax");


--
-- Name: codeEtageBioclim_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_etage_bioclim
    ADD CONSTRAINT "codeEtageBioclim_pkey" PRIMARY KEY ("codeEtageBioclim");


--
-- Name: codeEtageVeg_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_etage_veg
    ADD CONSTRAINT "codeEtageVeg_pkey" PRIMARY KEY ("codeEtageVeg");


--
-- Name: codeFacis_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_facies
    ADD CONSTRAINT "codeFacis_pkey" PRIMARY KEY ("codeFacies");


--
-- Name: codeHIC_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_hic
    ADD CONSTRAINT "codeHIC_pkey" PRIMARY KEY ("codeHIC");


--
-- Name: codeRangSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rang_seriegeoserie
    ADD CONSTRAINT "codeRangSerieGeoserie_pkey" PRIMARY KEY ("codeRangSerieGeoserie");


--
-- Name: codeRangSyntaxon_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rang_syntaxon
    ADD CONSTRAINT "codeRangSyntaxon_pkey" PRIMARY KEY ("codeRangSyntaxon");


--
-- Name: codeTeteSerie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_tete_serie
    ADD CONSTRAINT "codeTeteSerie_pkey" PRIMARY KEY ("codeTeteSerie");


--
-- Name: codeTypeSerieGeoserie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_seriegeoserie
    ADD CONSTRAINT "codeTypeSerieGeoserie_pkey" PRIMARY KEY ("codeTypeSerieGeoserie");


--
-- Name: fsd_data_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fsd_syntaxa
    ADD CONSTRAINT fsd_data_pkey PRIMARY KEY (id);


--
-- Name: idBiblio_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_biblio
    ADD CONSTRAINT "idBiblio_pkey" PRIMARY KEY ("idBiblio");


--
-- Name: idChorologie; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_chorologie
    ADD CONSTRAINT "idChorologie" PRIMARY KEY ("idChorologie");


--
-- Name: idCollaborateur; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idCollaborateur" PRIMARY KEY ("idCollaborateur");


--
-- Name: idCorresEtageBioclim_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_etage_bioclim
    ADD CONSTRAINT "idCorresEtageBioclim_pkey" PRIMARY KEY ("idCorresEtageBioclim");


--
-- Name: idCorresEtageVeg_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_etage_veg
    ADD CONSTRAINT "idCorresEtageVeg_pkey" PRIMARY KEY ("idCorresEtageveg");


--
-- Name: idCorrespondanceEUNIS_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_correspondance_eunis
    ADD CONSTRAINT "idCorrespondanceEUNIS_pkey" PRIMARY KEY ("idCorresEUNIS");


--
-- Name: idCorrespondancePVF_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_correspondance_pvf
    ADD CONSTRAINT "idCorrespondancePVF_pkey" PRIMARY KEY ("idCorrespondancePVF");


--
-- Name: idExposition_fkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_exposition
    ADD CONSTRAINT "idExposition_fkey" PRIMARY KEY ("idExposition");


--
-- Name: idGeosigmafacies; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_geo_sigmafacies
    ADD CONSTRAINT "idGeosigmafacies" PRIMARY KEY ("idGeosigmafacies");


--
-- Name: idIndicateurFlor_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_indicateurs_floristiques
    ADD CONSTRAINT "idIndicateurFlor_pkey" PRIMARY KEY ("idIndicateurFlor");


--
-- Name: idOmbroClimat_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_rivasmartinez_ombroclimat
    ADD CONSTRAINT "idOmbroClimat_pkey" PRIMARY KEY ("idOmbroclimat");


--
-- Name: idOrganisme_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_annuaire_organismes
    ADD CONSTRAINT "idOrganisme_pkey" PRIMARY KEY ("idOrganisme");


--
-- Name: idPersonne_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_annuaire_personnes
    ADD CONSTRAINT "idPersonne_pkey" PRIMARY KEY ("idPersonne");


--
-- Name: idRattachementPVF; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_pvf
    ADD CONSTRAINT "idRattachementPVF" PRIMARY KEY ("idRattachementPVF");


--
-- Name: idStatutchorologie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_statut_chorologie
    ADD CONSTRAINT "idStatutchorologie_pkey" PRIMARY KEY ("idStatutChorologie");


--
-- Name: idSuivi_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_suivi_enregistrement
    ADD CONSTRAINT "idSuivi_pkey" PRIMARY KEY ("idSuivi");


--
-- Name: idTypePhysio_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_physionomique
    ADD CONSTRAINT "idTypePhysio_pkey" PRIMARY KEY ("idTypePhysio");


--
-- Name: idTypeSyn; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_type_synonymie
    ADD CONSTRAINT "idTypeSyn" PRIMARY KEY ("idTypeSyn");


--
-- Name: identifiantCatalogue_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_catalogue_description
    ADD CONSTRAINT "identifiantCatalogue_pkey" PRIMARY KEY ("identifiantCatalogue");


--
-- Name: indCont_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_continentalite
    ADD CONSTRAINT "indCont_pkey" PRIMARY KEY ("indCont");


--
-- Name: indHum_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_humidite
    ADD CONSTRAINT "indHum_pkey" PRIMARY KEY ("indHum");


--
-- Name: indLum_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_lumiere
    ADD CONSTRAINT "indLum_pkey" PRIMARY KEY ("indLum");


--
-- Name: indReac_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_reaction
    ADD CONSTRAINT "indReac_pkey" PRIMARY KEY ("indReaction");


--
-- Name: indSali_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_salinite
    ADD CONSTRAINT "indSali_pkey" PRIMARY KEY ("indSali");


--
-- Name: indTemperaturee_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_temperature
    ADD CONSTRAINT "indTemperaturee_pkey" PRIMARY KEY ("indTemp");


--
-- Name: indTrophie_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_trophie
    ADD CONSTRAINT "indTrophie_pkey" PRIMARY KEY ("indTrophie");


--
-- Name: libPeriode; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_periode
    ADD CONSTRAINT "libPeriode" PRIMARY KEY ("codePeriode");


--
-- Name: neige_pkey; Type: CONSTRAINT; Schema: syntaxa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_ref_neige
    ADD CONSTRAINT neige_pkey PRIMARY KEY ("idNeige");


--
-- Name: acronymeorganisme_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX acronymeorganisme_uniq ON st_annuaire_organismes USING btree ("acronymeOrganisme");


--
-- Name: id_territoire_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX id_territoire_uniq ON liste_geo USING btree (id_territoire);


--
-- Name: idcritique_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idcritique_uniq ON st_ref_critique USING btree ("idCritique");


--
-- Name: idgeomorphologie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idgeomorphologie_uniq ON st_ref_geomorpho USING btree ("idGeomorphologie");


--
-- Name: idombroclimat_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idombroclimat_uniq ON st_ref_rivasmartinez_ombroclimat USING btree ("idOmbroclimat");


--
-- Name: indcont_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indcont_uniq ON st_ref_continentalite USING btree ("indCont");


--
-- Name: indsali_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indsali_uniq ON st_ref_salinite USING btree ("indSali");


--
-- Name: indtemp_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indtemp_uniq ON st_ref_temperature USING btree ("indTemp");


--
-- Name: indtrophie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX indtrophie_uniq ON st_ref_trophie USING btree ("indTrophie");


--
-- Name: libcont_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libcont_uniq ON st_ref_continentalite USING btree ("libCont");


--
-- Name: libetageveg_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libetageveg_uniq ON st_ref_etage_veg USING btree ("libEtageVeg");


--
-- Name: libombroclimat_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libombroclimat_uniq ON st_ref_rivasmartinez_ombroclimat USING btree ("libOmbroclimat");


--
-- Name: libsali_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libsali_uniq ON st_ref_salinite USING btree ("libSali");


--
-- Name: libtemp_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libtemp_uniq ON st_ref_temperature USING btree ("libTemp");


--
-- Name: libtrophie_uniq; Type: INDEX; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX libtrophie_uniq ON st_ref_trophie USING btree ("libTrophie");


--
-- Name: Neige_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "Neige_fkey" FOREIGN KEY (neige) REFERENCES st_ref_neige("idNeige") MATCH FULL;


--
-- Name: acronymeOrganisme_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "acronymeOrganisme_fkey" FOREIGN KEY ("acronymeOrganisme") REFERENCES st_annuaire_organismes("acronymeOrganisme") MATCH FULL ON UPDATE CASCADE;


--
-- Name: codeActionSuivi_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_suivi_enregistrement
    ADD CONSTRAINT "codeActionSuivi_fkey" FOREIGN KEY ("actionSuivi") REFERENCES st_ref_action_suivi("codeActionSuivi") MATCH FULL ON UPDATE CASCADE;


--
-- Name: codeEnregistrementSerieGeoserie_fkey1; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geo_sigmafacies
    ADD CONSTRAINT "codeEnregistrementSerieGeoserie_fkey1" FOREIGN KEY ("codeEnregistrementSerieGeoserie") REFERENCES st_serie_petitegeoserie("codeEnregistrementSerieGeoserie") MATCH FULL;


--
-- Name: codeEtageVeg_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_veg
    ADD CONSTRAINT "codeEtageVeg_fkey" FOREIGN KEY ("codeEtageVeg") REFERENCES st_ref_etage_veg("codeEtageVeg") MATCH FULL;


--
-- Name: codeFacies_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geo_sigmafacies
    ADD CONSTRAINT "codeFacies_fkey" FOREIGN KEY ("codeFacies") REFERENCES st_ref_type_facies("codeFacies") MATCH FULL;


--
-- Name: codeTeteSerie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_cortege_syntaxonomique
    ADD CONSTRAINT "codeTeteSerie_fkey" FOREIGN KEY ("codeTeteSerie") REFERENCES st_ref_tete_serie("codeTeteSerie") MATCH FULL;


--
-- Name: codecategorieseriegeoserie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT codecategorieseriegeoserie_fkey FOREIGN KEY ("codeCategorieSerieGeoserie") REFERENCES st_ref_categorie_seriegeoserie("codeCategorieSerieGeoserie") MATCH FULL;


--
-- Name: coderangseriegeoserie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT coderangseriegeoserie_fkey FOREIGN KEY ("codeRangSerieGeoserie") REFERENCES st_ref_rang_seriegeoserie("codeRangSerieGeoserie") MATCH FULL;


--
-- Name: coderangsyntaxon_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT coderangsyntaxon_fkey FOREIGN KEY ("rangSyntaxon") REFERENCES st_ref_rang_syntaxon("codeRangSyntaxon") MATCH FULL;


--
-- Name: codetypeseriegeoserie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT codetypeseriegeoserie_fkey FOREIGN KEY ("codeTypeSerieGeoserie") REFERENCES st_ref_type_seriegeoserie("codeTypeSerieGeoserie") MATCH FULL;


--
-- Name: continentalite_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT continentalite_fkey FOREIGN KEY (continentalite) REFERENCES st_ref_continentalite("indCont") MATCH FULL;


--
-- Name: debObsOptimale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "debObsOptimale_fkey" FOREIGN KEY ("periodeDebObsOptimale") REFERENCES st_ref_periode("codePeriode") MATCH FULL;


--
-- Name: exposition_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT exposition_fkey FOREIGN KEY (exposition) REFERENCES st_ref_exposition("idExposition") MATCH FULL;


--
-- Name: exposition_fkey2; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT exposition_fkey2 FOREIGN KEY (exposition) REFERENCES st_ref_exposition("idExposition") MATCH FULL;


--
-- Name: finObsOptimale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "finObsOptimale_fkey" FOREIGN KEY ("periodeFinObsOptimale") REFERENCES st_ref_periode("codePeriode") MATCH FULL;


--
-- Name: humiditePrincipale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "humiditePrincipale_fkey" FOREIGN KEY ("humiditePrincipale") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- Name: humiditePrincipale_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "humiditePrincipale_fkey" FOREIGN KEY ("humiditePrincipale") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- Name: humiditeSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "humiditeSecondaire_fkey" FOREIGN KEY ("humiditeSecondaire") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- Name: humiditeSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "humiditeSecondaire_fkey" FOREIGN KEY ("humiditeSecondaire") REFERENCES st_ref_humidite("indHum") MATCH FULL;


--
-- Name: idAuteurSuivi; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_suivi_enregistrement
    ADD CONSTRAINT "idAuteurSuivi" FOREIGN KEY ("idAuteurSuivi") REFERENCES st_annuaire_personnes("idPersonne") MATCH FULL ON UPDATE CASCADE;


--
-- Name: idCatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idCatalogue_fkey" FOREIGN KEY ("identifiantCatalogue") REFERENCES st_catalogue_description("identifiantCatalogue") MATCH FULL ON UPDATE CASCADE;


--
-- Name: idCatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "idCatalogue_fkey" FOREIGN KEY ("idCatalogue") REFERENCES st_catalogue_description("identifiantCatalogue") MATCH FULL ON UPDATE CASCADE;


--
-- Name: idCritique_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "idCritique_fkey" FOREIGN KEY ("idCritique") REFERENCES st_ref_critique("idCritique") MATCH FULL ON UPDATE CASCADE;


--
-- Name: idEnregistrement_fkey2; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geomorphologie
    ADD CONSTRAINT "idEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement") REFERENCES st_serie_petitegeoserie("codeEnregistrementSerieGeoserie") MATCH FULL;


--
-- Name: idEnregistrement_fkey3; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geomorphologie
    ADD CONSTRAINT "idEnregistrement_fkey3" FOREIGN KEY ("codeEnregistrement") REFERENCES st_geo_sigmafacies("idGeosigmafacies") MATCH FULL;


--
-- Name: idGeomorphologie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_geomorphologie
    ADD CONSTRAINT "idGeomorphologie_fkey" FOREIGN KEY ("idGeomorphologie") REFERENCES st_ref_geomorpho("idGeomorphologie") MATCH FULL;


--
-- Name: idGeosigmafacies_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_cortege_syntaxonomique
    ADD CONSTRAINT "idGeosigmafacies_fkey" FOREIGN KEY ("idGeosigmafacies") REFERENCES st_geo_sigmafacies("idGeosigmafacies") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idGeosigmafacies_fkey2; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_indicateurs_floristiques
    ADD CONSTRAINT "idGeosigmafacies_fkey2" FOREIGN KEY ("idGeosigmafacies") REFERENCES st_geo_sigmafacies("idGeosigmafacies") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idOrganisme_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idOrganisme_fkey" FOREIGN KEY ("idOrganisme") REFERENCES st_annuaire_organismes("idOrganisme") MATCH FULL ON UPDATE CASCADE;


--
-- Name: idPersonne_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_collaborateur
    ADD CONSTRAINT "idPersonne_fkey" FOREIGN KEY ("idPersonne") REFERENCES st_annuaire_personnes("idPersonne") MATCH FULL ON UPDATE CASCADE;


--
-- Name: idRattachementPVF_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_correspondance_pvf
    ADD CONSTRAINT "idRattachementPVF_fkey" FOREIGN KEY ("idRattachementPVF") REFERENCES st_ref_pvf("idRattachementPVF") MATCH FULL;


--
-- Name: idRattachementReferentiel_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_cortege_floristique
    ADD CONSTRAINT "idRattachementReferentiel_fkey" FOREIGN KEY ("idRattachementReferentiel") REFERENCES referentiel_taxo(id_rattachement_referentiel) MATCH FULL;


--
-- Name: idRattachementreferentiel_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_indicateurs_floristiques
    ADD CONSTRAINT "idRattachementreferentiel_fkey" FOREIGN KEY ("idRattachementReferentiel") REFERENCES referentiel_taxo(id_rattachement_referentiel) MATCH FULL ON UPDATE CASCADE;


--
-- Name: idTerritoireCatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_catalogue_description
    ADD CONSTRAINT "idTerritoireCatalogue_fkey" FOREIGN KEY ("idTerritoireCatalogue") REFERENCES liste_geo(id_territoire) MATCH FULL ON UPDATE CASCADE;


--
-- Name: idcatalogue_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT idcatalogue_fkey FOREIGN KEY ("idCatalogue") REFERENCES st_catalogue_description("identifiantCatalogue") MATCH FULL;


--
-- Name: libEtageVeg_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_etage_veg
    ADD CONSTRAINT "libEtageVeg_fkey" FOREIGN KEY ("libEtageVeg") REFERENCES st_ref_etage_veg("libEtageVeg") MATCH FULL;


--
-- Name: lumiere_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT lumiere_fkey FOREIGN KEY (luminosite) REFERENCES st_ref_lumiere("indLum") MATCH FULL;


--
-- Name: ombroclimat_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT ombroclimat_fkey FOREIGN KEY (ombroclimat) REFERENCES st_ref_rivasmartinez_ombroclimat("idOmbroclimat") MATCH FULL;


--
-- Name: pHprincipal_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "pHprincipal_fkey" FOREIGN KEY ("phPrincipal") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- Name: phPrincipal_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "phPrincipal_fkey" FOREIGN KEY ("phPrincipal") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- Name: phSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_serie_petitegeoserie
    ADD CONSTRAINT "phSecondaire_fkey" FOREIGN KEY ("phSecondaire") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- Name: phSecondaire_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "phSecondaire_fkey" FOREIGN KEY ("phSecondaire") REFERENCES st_ref_reaction("indReaction") MATCH FULL;


--
-- Name: salinite_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT salinite_fkey FOREIGN KEY (salinite) REFERENCES st_ref_salinite("indSali") MATCH FULL;


--
-- Name: temperature_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT temperature_fkey FOREIGN KEY (temperature) REFERENCES st_ref_temperature("indTemp") MATCH FULL;


--
-- Name: trophie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT trophie_fkey FOREIGN KEY (trophie) REFERENCES st_ref_trophie("indTrophie") MATCH FULL;


--
-- Name: typePhysionomique_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "typePhysionomique_fkey" FOREIGN KEY ("typePhysionomique") REFERENCES st_ref_type_physionomique("idTypePhysio") MATCH FULL ON UPDATE CASCADE;


--
-- Name: typeSynonymie_fkey; Type: FK CONSTRAINT; Schema: syntaxa; Owner: postgres
--

ALTER TABLE ONLY st_syntaxon
    ADD CONSTRAINT "typeSynonymie_fkey" FOREIGN KEY ("typeSynonymie") REFERENCES st_ref_type_synonymie("idTypeSyn") MATCH FULL;


--
-- Name: syntaxa; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA syntaxa FROM PUBLIC;
REVOKE ALL ON SCHEMA syntaxa FROM postgres;
GRANT ALL ON SCHEMA syntaxa TO postgres;
GRANT ALL ON SCHEMA syntaxa TO user_codex;


--
-- Name: fsd_syntaxa; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE fsd_syntaxa FROM PUBLIC;
REVOKE ALL ON TABLE fsd_syntaxa FROM postgres;
GRANT ALL ON TABLE fsd_syntaxa TO postgres;
GRANT ALL ON TABLE fsd_syntaxa TO user_codex;


--
-- Name: liste_geo; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE liste_geo FROM PUBLIC;
REVOKE ALL ON TABLE liste_geo FROM postgres;
GRANT ALL ON TABLE liste_geo TO postgres;
GRANT ALL ON TABLE liste_geo TO user_codex;


--
-- Name: referentiel_taxo; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE referentiel_taxo FROM PUBLIC;
REVOKE ALL ON TABLE referentiel_taxo FROM postgres;
GRANT ALL ON TABLE referentiel_taxo TO postgres;
GRANT ALL ON TABLE referentiel_taxo TO user_codex;


--
-- Name: st_annuaire_organismes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_annuaire_organismes FROM PUBLIC;
REVOKE ALL ON TABLE st_annuaire_organismes FROM postgres;
GRANT ALL ON TABLE st_annuaire_organismes TO postgres;
GRANT ALL ON TABLE st_annuaire_organismes TO user_codex;


--
-- Name: st_annuaire_personnes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_annuaire_personnes FROM PUBLIC;
REVOKE ALL ON TABLE st_annuaire_personnes FROM postgres;
GRANT ALL ON TABLE st_annuaire_personnes TO postgres;
GRANT ALL ON TABLE st_annuaire_personnes TO user_codex;


--
-- Name: st_biblio; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_biblio FROM PUBLIC;
REVOKE ALL ON TABLE st_biblio FROM postgres;
GRANT ALL ON TABLE st_biblio TO postgres;
GRANT ALL ON TABLE st_biblio TO user_codex;


--
-- Name: st_biblio_idBiblio_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_biblio_idBiblio_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_biblio_idBiblio_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_biblio_idBiblio_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_biblio_idBiblio_seq" TO user_codex;


--
-- Name: st_catalogue_description; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_catalogue_description FROM PUBLIC;
REVOKE ALL ON TABLE st_catalogue_description FROM postgres;
GRANT ALL ON TABLE st_catalogue_description TO postgres;
GRANT ALL ON TABLE st_catalogue_description TO user_codex;


--
-- Name: st_catalogue_description_id_tri_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE st_catalogue_description_id_tri_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE st_catalogue_description_id_tri_seq FROM postgres;
GRANT ALL ON SEQUENCE st_catalogue_description_id_tri_seq TO postgres;
GRANT ALL ON SEQUENCE st_catalogue_description_id_tri_seq TO user_codex;


--
-- Name: st_chorologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_chorologie FROM PUBLIC;
REVOKE ALL ON TABLE st_chorologie FROM postgres;
GRANT ALL ON TABLE st_chorologie TO postgres;
GRANT ALL ON TABLE st_chorologie TO user_codex;


--
-- Name: st_chorologie_idChorologie_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_chorologie_idChorologie_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_chorologie_idChorologie_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_chorologie_idChorologie_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_chorologie_idChorologie_seq" TO user_codex;


--
-- Name: st_collaborateur; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_collaborateur FROM PUBLIC;
REVOKE ALL ON TABLE st_collaborateur FROM postgres;
GRANT ALL ON TABLE st_collaborateur TO postgres;
GRANT ALL ON TABLE st_collaborateur TO user_codex;


--
-- Name: st_correspondance_eunis; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_correspondance_eunis FROM PUBLIC;
REVOKE ALL ON TABLE st_correspondance_eunis FROM postgres;
GRANT ALL ON TABLE st_correspondance_eunis TO postgres;
GRANT ALL ON TABLE st_correspondance_eunis TO user_codex;


--
-- Name: st_correspondance_eunis_idCorresEUNIS_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_correspondance_eunis_idCorresEUNIS_seq" TO user_codex;


--
-- Name: st_correspondance_hic; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_correspondance_hic FROM PUBLIC;
REVOKE ALL ON TABLE st_correspondance_hic FROM postgres;
GRANT ALL ON TABLE st_correspondance_hic TO postgres;
GRANT ALL ON TABLE st_correspondance_hic TO user_codex;


--
-- Name: st_correspondance_hic_idCorresHIC_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_correspondance_hic_idCorresHIC_seq" TO user_codex;


--
-- Name: st_correspondance_pvf; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_correspondance_pvf FROM PUBLIC;
REVOKE ALL ON TABLE st_correspondance_pvf FROM postgres;
GRANT ALL ON TABLE st_correspondance_pvf TO postgres;
GRANT ALL ON TABLE st_correspondance_pvf TO user_codex;


--
-- Name: st_correspondance_pvf_idCorrespondancePVF_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_correspondance_pvf_idCorrespondancePVF_seq" TO user_codex;


--
-- Name: st_cortege_floristique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_cortege_floristique FROM PUBLIC;
REVOKE ALL ON TABLE st_cortege_floristique FROM postgres;
GRANT ALL ON TABLE st_cortege_floristique TO postgres;
GRANT ALL ON TABLE st_cortege_floristique TO user_codex;


--
-- Name: st_cortege_syntaxonomique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_cortege_syntaxonomique FROM PUBLIC;
REVOKE ALL ON TABLE st_cortege_syntaxonomique FROM postgres;
GRANT ALL ON TABLE st_cortege_syntaxonomique TO postgres;
GRANT ALL ON TABLE st_cortege_syntaxonomique TO user_codex;


--
-- Name: st_etage_bioclim; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_etage_bioclim FROM PUBLIC;
REVOKE ALL ON TABLE st_etage_bioclim FROM postgres;
GRANT ALL ON TABLE st_etage_bioclim TO postgres;
GRANT ALL ON TABLE st_etage_bioclim TO user_codex;


--
-- Name: st_etage_bioclim_idCorresEtageBioclim_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_etage_bioclim_idCorresEtageBioclim_seq" TO user_codex;


--
-- Name: st_etage_veg; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_etage_veg FROM PUBLIC;
REVOKE ALL ON TABLE st_etage_veg FROM postgres;
GRANT ALL ON TABLE st_etage_veg TO postgres;
GRANT ALL ON TABLE st_etage_veg TO user_codex;


--
-- Name: st_etage_veg_idCorresEtageveg_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" FROM postgres;
GRANT ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" TO postgres;
GRANT ALL ON SEQUENCE "st_etage_veg_idCorresEtageveg_seq" TO user_codex;


--
-- Name: st_geo_sigmafacies; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_geo_sigmafacies FROM PUBLIC;
REVOKE ALL ON TABLE st_geo_sigmafacies FROM postgres;
GRANT ALL ON TABLE st_geo_sigmafacies TO postgres;
GRANT ALL ON TABLE st_geo_sigmafacies TO user_codex;


--
-- Name: st_geomorphologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_geomorphologie FROM PUBLIC;
REVOKE ALL ON TABLE st_geomorphologie FROM postgres;
GRANT ALL ON TABLE st_geomorphologie TO postgres;
GRANT ALL ON TABLE st_geomorphologie TO user_codex;


--
-- Name: st_indicateurs_floristiques; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_indicateurs_floristiques FROM PUBLIC;
REVOKE ALL ON TABLE st_indicateurs_floristiques FROM postgres;
GRANT ALL ON TABLE st_indicateurs_floristiques TO postgres;
GRANT ALL ON TABLE st_indicateurs_floristiques TO user_codex;


--
-- Name: st_ref_action_suivi; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_action_suivi FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_action_suivi FROM postgres;
GRANT ALL ON TABLE st_ref_action_suivi TO postgres;
GRANT ALL ON TABLE st_ref_action_suivi TO user_codex;


--
-- Name: st_ref_categorie_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_categorie_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_categorie_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_categorie_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_categorie_seriegeoserie TO user_codex;


--
-- Name: st_ref_continentalite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_continentalite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_continentalite FROM postgres;
GRANT ALL ON TABLE st_ref_continentalite TO postgres;
GRANT ALL ON TABLE st_ref_continentalite TO user_codex;


--
-- Name: st_ref_critique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_critique FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_critique FROM postgres;
GRANT ALL ON TABLE st_ref_critique TO postgres;
GRANT ALL ON TABLE st_ref_critique TO user_codex;


--
-- Name: st_ref_etage_bioclim; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_etage_bioclim FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_etage_bioclim FROM postgres;
GRANT ALL ON TABLE st_ref_etage_bioclim TO postgres;
GRANT ALL ON TABLE st_ref_etage_bioclim TO user_codex;


--
-- Name: st_ref_etage_bioclim_id_tri_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq FROM postgres;
GRANT ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq TO postgres;
GRANT ALL ON SEQUENCE st_ref_etage_bioclim_id_tri_seq TO user_codex;


--
-- Name: st_ref_etage_veg; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_etage_veg FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_etage_veg FROM postgres;
GRANT ALL ON TABLE st_ref_etage_veg TO postgres;
GRANT ALL ON TABLE st_ref_etage_veg TO user_codex;


--
-- Name: st_ref_eunis; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_eunis FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_eunis FROM postgres;
GRANT ALL ON TABLE st_ref_eunis TO postgres;
GRANT ALL ON TABLE st_ref_eunis TO user_codex;


--
-- Name: st_ref_exposition; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_exposition FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_exposition FROM postgres;
GRANT ALL ON TABLE st_ref_exposition TO postgres;
GRANT ALL ON TABLE st_ref_exposition TO user_codex;


--
-- Name: st_ref_geomorpho; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_geomorpho FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_geomorpho FROM postgres;
GRANT ALL ON TABLE st_ref_geomorpho TO postgres;
GRANT ALL ON TABLE st_ref_geomorpho TO user_codex;


--
-- Name: st_ref_hic; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_hic FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_hic FROM postgres;
GRANT ALL ON TABLE st_ref_hic TO postgres;
GRANT ALL ON TABLE st_ref_hic TO user_codex;


--
-- Name: st_ref_humidite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_humidite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_humidite FROM postgres;
GRANT ALL ON TABLE st_ref_humidite TO postgres;
GRANT ALL ON TABLE st_ref_humidite TO user_codex;


--
-- Name: st_ref_lumiere; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_lumiere FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_lumiere FROM postgres;
GRANT ALL ON TABLE st_ref_lumiere TO postgres;
GRANT ALL ON TABLE st_ref_lumiere TO user_codex;


--
-- Name: st_ref_neige; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_neige FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_neige FROM postgres;
GRANT ALL ON TABLE st_ref_neige TO postgres;
GRANT ALL ON TABLE st_ref_neige TO user_codex;


--
-- Name: st_ref_periode; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_periode FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_periode FROM postgres;
GRANT ALL ON TABLE st_ref_periode TO postgres;
GRANT ALL ON TABLE st_ref_periode TO user_codex;


--
-- Name: st_ref_pvf; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_pvf FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_pvf FROM postgres;
GRANT ALL ON TABLE st_ref_pvf TO postgres;
GRANT ALL ON TABLE st_ref_pvf TO user_codex;


--
-- Name: st_ref_rang_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rang_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rang_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_rang_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_rang_seriegeoserie TO user_codex;


--
-- Name: st_ref_rang_syntaxon; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rang_syntaxon FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rang_syntaxon FROM postgres;
GRANT ALL ON TABLE st_ref_rang_syntaxon TO postgres;
GRANT ALL ON TABLE st_ref_rang_syntaxon TO user_codex;


--
-- Name: st_ref_reaction; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_reaction FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_reaction FROM postgres;
GRANT ALL ON TABLE st_ref_reaction TO postgres;
GRANT ALL ON TABLE st_ref_reaction TO user_codex;


--
-- Name: st_ref_rivasmartinez_ombroclimat; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_rivasmartinez_ombroclimat FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_rivasmartinez_ombroclimat FROM postgres;
GRANT ALL ON TABLE st_ref_rivasmartinez_ombroclimat TO postgres;
GRANT ALL ON TABLE st_ref_rivasmartinez_ombroclimat TO user_codex;


--
-- Name: st_ref_salinite; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_salinite FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_salinite FROM postgres;
GRANT ALL ON TABLE st_ref_salinite TO postgres;
GRANT ALL ON TABLE st_ref_salinite TO user_codex;


--
-- Name: st_ref_statut_chorologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_statut_chorologie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_statut_chorologie FROM postgres;
GRANT ALL ON TABLE st_ref_statut_chorologie TO postgres;
GRANT ALL ON TABLE st_ref_statut_chorologie TO user_codex;


--
-- Name: st_ref_temperature; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_temperature FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_temperature FROM postgres;
GRANT ALL ON TABLE st_ref_temperature TO postgres;
GRANT ALL ON TABLE st_ref_temperature TO user_codex;


--
-- Name: st_ref_tete_serie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_tete_serie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_tete_serie FROM postgres;
GRANT ALL ON TABLE st_ref_tete_serie TO postgres;
GRANT ALL ON TABLE st_ref_tete_serie TO user_codex;


--
-- Name: st_ref_trophie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_trophie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_trophie FROM postgres;
GRANT ALL ON TABLE st_ref_trophie TO postgres;
GRANT ALL ON TABLE st_ref_trophie TO user_codex;


--
-- Name: st_ref_type_facies; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_facies FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_facies FROM postgres;
GRANT ALL ON TABLE st_ref_type_facies TO postgres;
GRANT ALL ON TABLE st_ref_type_facies TO user_codex;


--
-- Name: st_ref_type_physionomique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_physionomique FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_physionomique FROM postgres;
GRANT ALL ON TABLE st_ref_type_physionomique TO postgres;
GRANT ALL ON TABLE st_ref_type_physionomique TO user_codex;


--
-- Name: st_ref_type_seriegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_seriegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_seriegeoserie FROM postgres;
GRANT ALL ON TABLE st_ref_type_seriegeoserie TO postgres;
GRANT ALL ON TABLE st_ref_type_seriegeoserie TO user_codex;


--
-- Name: st_ref_type_synonymie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_ref_type_synonymie FROM PUBLIC;
REVOKE ALL ON TABLE st_ref_type_synonymie FROM postgres;
GRANT ALL ON TABLE st_ref_type_synonymie TO postgres;
GRANT ALL ON TABLE st_ref_type_synonymie TO user_codex;


--
-- Name: st_serie_petitegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_serie_petitegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE st_serie_petitegeoserie FROM postgres;
GRANT ALL ON TABLE st_serie_petitegeoserie TO postgres;
GRANT ALL ON TABLE st_serie_petitegeoserie TO user_codex;


--
-- Name: st_suivi_enregistrement; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_suivi_enregistrement FROM PUBLIC;
REVOKE ALL ON TABLE st_suivi_enregistrement FROM postgres;
GRANT ALL ON TABLE st_suivi_enregistrement TO postgres;
GRANT ALL ON TABLE st_suivi_enregistrement TO user_codex;


--
-- Name: st_syntaxon; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE st_syntaxon FROM PUBLIC;
REVOKE ALL ON TABLE st_syntaxon FROM postgres;
GRANT ALL ON TABLE st_syntaxon TO postgres;
GRANT ALL ON TABLE st_syntaxon TO user_codex;


--
-- Name: st_syntaxon_uid_seq; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON SEQUENCE st_syntaxon_uid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE st_syntaxon_uid_seq FROM postgres;
GRANT ALL ON SEQUENCE st_syntaxon_uid_seq TO postgres;
GRANT ALL ON SEQUENCE st_syntaxon_uid_seq TO user_codex;


--
-- Name: temp_st_annuaire_organismes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_annuaire_organismes FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_annuaire_organismes FROM postgres;
GRANT ALL ON TABLE temp_st_annuaire_organismes TO postgres;
GRANT ALL ON TABLE temp_st_annuaire_organismes TO user_codex;


--
-- Name: temp_st_annuaire_personnes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_annuaire_personnes FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_annuaire_personnes FROM postgres;
GRANT ALL ON TABLE temp_st_annuaire_personnes TO postgres;
GRANT ALL ON TABLE temp_st_annuaire_personnes TO user_codex;


--
-- Name: temp_st_biblio; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_biblio FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_biblio FROM postgres;
GRANT ALL ON TABLE temp_st_biblio TO postgres;
GRANT ALL ON TABLE temp_st_biblio TO user_codex;


--
-- Name: temp_st_catalogue_description; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_catalogue_description FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_catalogue_description FROM postgres;
GRANT ALL ON TABLE temp_st_catalogue_description TO postgres;
GRANT ALL ON TABLE temp_st_catalogue_description TO user_codex;


--
-- Name: temp_st_chorologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_chorologie FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_chorologie FROM postgres;
GRANT ALL ON TABLE temp_st_chorologie TO postgres;
GRANT ALL ON TABLE temp_st_chorologie TO user_codex;


--
-- Name: temp_st_collaborateur; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_collaborateur FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_collaborateur FROM postgres;
GRANT ALL ON TABLE temp_st_collaborateur TO postgres;
GRANT ALL ON TABLE temp_st_collaborateur TO user_codex;


--
-- Name: temp_st_correspondance_hic; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_correspondance_hic FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_correspondance_hic FROM postgres;
GRANT ALL ON TABLE temp_st_correspondance_hic TO postgres;
GRANT ALL ON TABLE temp_st_correspondance_hic TO user_codex;


--
-- Name: temp_st_correspondance_pvf; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_correspondance_pvf FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_correspondance_pvf FROM postgres;
GRANT ALL ON TABLE temp_st_correspondance_pvf TO postgres;
GRANT ALL ON TABLE temp_st_correspondance_pvf TO user_codex;


--
-- Name: temp_st_cortege_floristique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_cortege_floristique FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_cortege_floristique FROM postgres;
GRANT ALL ON TABLE temp_st_cortege_floristique TO postgres;
GRANT ALL ON TABLE temp_st_cortege_floristique TO user_codex;


--
-- Name: temp_st_cortege_syntaxonomique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_cortege_syntaxonomique FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_cortege_syntaxonomique FROM postgres;
GRANT ALL ON TABLE temp_st_cortege_syntaxonomique TO postgres;
GRANT ALL ON TABLE temp_st_cortege_syntaxonomique TO user_codex;


--
-- Name: temp_st_etage_bioclim; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_etage_bioclim FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_etage_bioclim FROM postgres;
GRANT ALL ON TABLE temp_st_etage_bioclim TO postgres;
GRANT ALL ON TABLE temp_st_etage_bioclim TO user_codex;


--
-- Name: temp_st_etage_veg; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_etage_veg FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_etage_veg FROM postgres;
GRANT ALL ON TABLE temp_st_etage_veg TO postgres;
GRANT ALL ON TABLE temp_st_etage_veg TO user_codex;


--
-- Name: temp_st_geo_sigmafacies; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_geo_sigmafacies FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_geo_sigmafacies FROM postgres;
GRANT ALL ON TABLE temp_st_geo_sigmafacies TO postgres;
GRANT ALL ON TABLE temp_st_geo_sigmafacies TO user_codex;


--
-- Name: temp_st_geomorphologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_geomorphologie FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_geomorphologie FROM postgres;
GRANT ALL ON TABLE temp_st_geomorphologie TO postgres;
GRANT ALL ON TABLE temp_st_geomorphologie TO user_codex;


--
-- Name: temp_st_indicateurs_floristiques; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_indicateurs_floristiques FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_indicateurs_floristiques FROM postgres;
GRANT ALL ON TABLE temp_st_indicateurs_floristiques TO postgres;
GRANT ALL ON TABLE temp_st_indicateurs_floristiques TO user_codex;


--
-- Name: temp_st_serie_petitegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_serie_petitegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_serie_petitegeoserie FROM postgres;
GRANT ALL ON TABLE temp_st_serie_petitegeoserie TO postgres;
GRANT ALL ON TABLE temp_st_serie_petitegeoserie TO user_codex;


--
-- Name: temp_st_suivi_enregistrement; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_suivi_enregistrement FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_suivi_enregistrement FROM postgres;
GRANT ALL ON TABLE temp_st_suivi_enregistrement TO postgres;
GRANT ALL ON TABLE temp_st_suivi_enregistrement TO user_codex;


--
-- Name: temp_st_syntaxon; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_syntaxon FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_syntaxon FROM postgres;
GRANT ALL ON TABLE temp_st_syntaxon TO postgres;
GRANT ALL ON TABLE temp_st_syntaxon TO user_codex;


--
-- PostgreSQL database dump complete
--

