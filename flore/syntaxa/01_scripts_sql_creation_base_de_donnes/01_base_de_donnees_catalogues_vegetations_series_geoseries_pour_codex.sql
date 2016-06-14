-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.7.0
-- PostgreSQL version: 9.3
-- Project Site: pgmodeler.com.br
-- Model Author: ---

SET check_function_bodies = false;
-- ddl-end --

-----------------------------------------------------------------------------CREATION DU SCHEMA--------------------------------------------------------
-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: siflore_national_v3 | type: DATABASE --
-- -- DROP DATABASE siflore_national_v3;
-- CREATE DATABASE siflore_national_v3
-- 	ENCODING = 'UTF8'
-- 	OWNER = postgres
-- ;
-- -- ddl-end --
-- 
/*
-- object: syntaxa | type: SCHEMA --
-- DROP SCHEMA syntaxa;
CREATE SCHEMA syntaxa;
ALTER SCHEMA syntaxa OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,syntaxa,taxa;
-- ddl-end --


-- object: taxa | type: SCHEMA --
-- DROP SCHEMA taxa;
CREATE SCHEMA taxa;
ALTER SCHEMA taxa OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,syntaxa,taxa;
-- ddl-end --
*/

------------------------------------------------------------------

------------------------------------------------------------------

DROP TABLE if exists syntaxa.images;

CREATE TABLE syntaxa.images
(
  "codeEnregistrement" text,
  chemin_img text,
  "typeImage" text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE syntaxa.images
  OWNER TO postgres;
  
  
DROP TABLE IF EXISTS syntaxa.liste_geo CASCADE;
CREATE TABLE syntaxa.liste_geo
(
  id_territoire text NOT NULL,
  code_type_territoire text,
  code_territoire text,
  libelle_territoire text,
  id_tri serial,
  CONSTRAINT "PK_liste_geo" PRIMARY KEY (id_territoire)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE syntaxa.liste_geo
  OWNER TO postgres;
GRANT ALL ON TABLE syntaxa.liste_geo TO postgres;
--GRANT SELECT ON TABLE syntaxa.liste_geo TO pg_user;

-- Index: taxa.id_territoire_uniq

-- DROP INDEX taxa.id_territoire_uniq;

CREATE UNIQUE INDEX id_territoire_uniq
  ON syntaxa.liste_geo
  USING btree
  (id_territoire COLLATE pg_catalog."default");
  
COMMENT ON TABLE syntaxa.liste_geo IS 'Table listant les territoires géographiques de référence pour la chorologie';
COMMENT ON COLUMN syntaxa.liste_geo."id_territoire" IS 'identifiant unique du territoire';
COMMENT ON COLUMN syntaxa.liste_geo."code_type_territoire" IS 'code du type de territoire (RA:région agricole, DEP: département, REG: région)';
COMMENT ON COLUMN syntaxa.liste_geo."code_territoire" IS 'Code du territoire dans son référentiel d''origine (ex: insee pour les départements)';
COMMENT ON COLUMN syntaxa.liste_geo."libelle_territoire" IS 'Libellé du territoire dans son référentiel d''origine (ex: insee pour les départements)';
COMMENT ON COLUMN syntaxa.liste_geo.id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


-- Table: taxa.referentiel_taxo

-- DROP TABLE taxa.referentiel_taxo;

DROP TABLE IF EXISTS syntaxa.referentiel_taxo CASCADE;
CREATE TABLE syntaxa.referentiel_taxo
(
  id_rattachement_referentiel text NOT NULL,
  code_referentiel text,
  version_referentiel text,
  cd_ref_referentiel text,
  cd_nom_referentiel text,
  nom_complet_taxon_referentiel text,
  CONSTRAINT "PK_referentiel" PRIMARY KEY (id_rattachement_referentiel)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE syntaxa.referentiel_taxo
  OWNER TO postgres;
GRANT ALL ON TABLE syntaxa.referentiel_taxo TO postgres;
--GRANT SELECT ON TABLE syntaxa.referentiel_taxo TO pg_user;

COMMENT ON TABLE syntaxa.referentiel_taxo IS 'Table listant les taxons dans les différents référentiels taxonomiques';
COMMENT ON COLUMN syntaxa.referentiel_taxo."id_rattachement_referentiel" IS 'identifiant unique du taxon dans un référentiel donné';
COMMENT ON COLUMN syntaxa.referentiel_taxo."code_referentiel" IS 'nom codifié du référentiel';
COMMENT ON COLUMN syntaxa.referentiel_taxo."version_referentiel" IS 'version du référentiel';
COMMENT ON COLUMN syntaxa.referentiel_taxo."cd_ref_referentiel" IS 'cd_ref dans le référentiel';
COMMENT ON COLUMN syntaxa.referentiel_taxo."cd_nom_referentiel" IS 'cd_nom dans le référentiel';
COMMENT ON COLUMN syntaxa.referentiel_taxo."nom_complet_taxon_referentiel" IS 'nom complet du taxon dans le référentiel';

-- object: syntaxa.st_catalogue_description | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_catalogue_description cascade;
CREATE TABLE syntaxa.st_catalogue_description(
	"identifiantCatalogue" text,
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
	id_tri serial,
	CONSTRAINT "identifiantCatalogue_pkey" PRIMARY KEY ("identifiantCatalogue")

);
-- ddl-end --
--COMMENT ON TABLE syntaxa.st_catalogue_description IS NULL;
COMMENT ON TABLE syntaxa.st_catalogue_description IS 'Table de métadonnées de description des catalogues';
COMMENT ON COLUMN syntaxa.st_catalogue_description."identifiantCatalogue" IS 'identifiant unique du catalogue';
COMMENT ON COLUMN syntaxa.st_catalogue_description."libelleCatalogue" IS 'libellé du catalogue de vegetation';
COMMENT ON COLUMN syntaxa.st_catalogue_description."versionCatalogue" IS 'version du catalogue de vegetation';
COMMENT ON COLUMN syntaxa.st_catalogue_description."typeCatalogue" IS 'Type de catalogue correspondant au champ thématique couvert par le catalogue.';
COMMENT ON COLUMN syntaxa.st_catalogue_description."dateCreationCatalogue" IS 'date de création du catalogue de vegetation';
COMMENT ON COLUMN syntaxa.st_catalogue_description."dateMiseAJourCatalogue" IS 'date de dernière mise à jour du catalogue de vegetation';
COMMENT ON COLUMN syntaxa.st_catalogue_description."idCollaborateurCatalogue" IS 'identifiant vers une table contenant les noms des CBN ou autres organismes ayant collaborés à la réalisation du catalogue';
COMMENT ON COLUMN syntaxa.st_catalogue_description."idTerritoireCatalogue" IS 'identifiant unique du territoire utilisé pour décrire la validité spatiale du catalogue, fait référence à la table liste_geo';
COMMENT ON COLUMN syntaxa.st_catalogue_description."codeTypeTerritoireCatalogue" IS 'Code du type de territoire utilisé pour décrire la validité spatiale du catalogue, autrement dit emprise totale du catalogue ( CBN,régionale, nationale, autre…)';
COMMENT ON COLUMN syntaxa.st_catalogue_description."codeTerritoireCatalogue" IS 'Code du territoire utilisé pour décrire de validité spatiale du catalogue, lié au référentiel territorial utilisé';
COMMENT ON COLUMN syntaxa.st_catalogue_description."libelleTerritoireCatalogue" IS 'Nom du territoire  utilisé pour décrire la validité spatiale du catalogue ';
COMMENT ON COLUMN syntaxa.st_catalogue_description."remarqueTerritoireCatalogue" IS 'remarque concernant le territoire de validité spatiale du catalogue (si ce territoire est inférieur à une région  ou département administratif)';
COMMENT ON COLUMN syntaxa.st_catalogue_description.id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';

ALTER TABLE syntaxa.st_catalogue_description OWNER TO postgres;
-- ddl-end --

-- object: syntaxa.st_serie_petitegeoserie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_serie_petitegeoserie cascade;
CREATE TABLE syntaxa.st_serie_petitegeoserie(
	"idCatalogue" text,
	"codeEnregistrementSerieGeoserie" text,
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
	"etatConservation" text,
	CONSTRAINT "codeEnregistrementSerieGeoserie_pkey" PRIMARY KEY ("codeEnregistrementSerieGeoserie")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_serie_petitegeoserie IS 'Table contenant la nomenclature des séries et petites géoséries ainsi que leurs principaux descripteurs (univariés)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."idCatalogue" IS 'clef étrangère vers identifiant unique du catalogue';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."codeEnregistrementSerieGeoserie" IS 'identifiant unique de l''enregistrement (de la ligne) dans le catalogue qui associe l''identifiant unique du (geo)sigmataxon et l''identifiant du catalogue';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."idSerieGeoserie" IS 'identifiant unique du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."nomSerieGeoserie" IS 'nom latin du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."auteurSerieGeoserie" IS 'autorité du (geo)sigmataxon:  on met le nom de l''auteur qui a publié le (geo)sigmataxon synonyme sinon on met (ined = « inédit »)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."nomCompletSerieGeoserie" IS 'nom complet  (nom+autorité) du (geo)sigmataxon synonyme dans la base de donnée du CBN (base mère)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."remarqueNomenclaturale" IS 'Champ libre donnant des précisions sur le nom choisi dans le cas où le nom n''existe pas dans le PVF';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."typeSynonymie" IS 'type de synonymie du (geo)sigmataxon';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."idSerieGeoserieRetenu" IS 'identifiant du (geo)sigmataxon retenu auquel renvoie le (geo)sigmataxon synonyme dans la base mère';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."nomSerieGeoserieRetenu" IS 'nom complet latin du (geo)sigmataxon retenu auquel renvoie le (geo)sigmataxon synonyme dans la base mère';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."nomSerieGeoserieRaccourci" IS 'nom raccourci du (geo)sigmataxon retenu';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."idSerieGeoserieSup" IS 'identifiant du (geo)sigmataxon directement supérieur auquel appartient le (geo)sigmataxon (notamment dans l''hypothèse de l''existance de sous-séries)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."codeTypeSerieGeoserie" IS 'type de (geo)sigmataxon (permasérie, curtasérie, série...)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."codeCategorieSerieGeoserie" IS 'catégorie de (geo)sigmataxon (Edaphoxérophile, …)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."codeRangSerieGeoserie" IS 'niveau du (geo)sigmataxon (série, sous-série, ...)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."nomFrancaisSerieGeoserie" IS 'Nom français pour les séries <série> de la <type de formation> à <nom latin 1> et <nom latin 2>
Sous-série à <nom latin du stade dynamique discriminant> et les petites géoséries < géosérie> de <nom de la série dominante en français>';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."diagnoseCourteSerieGeoserie" IS 'La diagnose doit tenir en une seule phrase et inclus le type de série (série, curtasérie, permasérie), la catégorie (climatophile, édaphoxérophile, edaphohygrophile), la géographie, le bioclimat, la lithologie, l''étage de végétation éventuellement et le nom français.';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie.confusion IS 'confusion possible : nom complet du (geo)sigmataxon qui pourrait être confondu avec';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."confusionRemarque" IS 'text libre portant sur la nature de la confusion et les critères de différentiation';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."repartitionGenerale" IS 'Texte libre qui indique la répartition sur le territoire français et transfrontalier';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."repartitionTerritoire" IS 'Répartition dans le territoire étudié. Champ texte libre. Répartition à petite échelle. On indique la présence dans les petites régions naturelles propres à chaque CBN (région naturelle de présence)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."aireMinimale" IS 'Aire minimale d''expression du (geo)sigmasyntaxa en hectares';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."typePhysionomique" IS 'il s''agit de la physionomie de la formations végétale dominante. On utilise pour ce champ la typologie des formations végétales.';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."lithologiePedologieHumus" IS 'texte libre sur la lithologie, la pédologie et l''humus.';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie.geomorphologie IS 'liste de vocabulaire partagé proposé par B.Etlicher';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."humiditePrincipale" IS 'codification du caractère hygrophile du (geo)sigmasyntaxon sur le territoire (appartenance principale = conditions optimales)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."humiditeSecondaire" IS 'codification du caractère hygrophile du (geo)sigmasyntaxon sur le territoire (appartenance secondaire= condition favorables)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."phPrincipal" IS 'codification du pH (appartenance principale= conditions optimales d''expression du (geo)sigmasyntaxon)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."phSecondaire" IS 'codification du pH  (appartenance secondaire= conditions favorables d''expression du (geo)sigmasyntaxon)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie.exposition IS 'exposition dominante de la série ou petite géosérie';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."descriptionEcologie" IS 'Champ libre mais harmonisé de remarque sur l''écologie du (geo)sigmasyntaxon';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité de la série ou la géosérie. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."remarqueRarete" IS 'Champ libre sur la rareté, l''endémisme et les végétations remarquables';
COMMENT ON COLUMN syntaxa.st_serie_petitegeoserie."etatConservation" IS 'Champ texte libre. Menaces, état de conservation, principaux usages, facteurs de conservation.
Il s''agit de décrire les menaces sur la série dans son entier ou sur un sigmafaciès et pas sur un stade dynamique (dans ce cas on se réfère à la fiche syntaxon du stade dynamique).';
-- ddl-end --





-- object: syntaxa.st_ref_type_seriegeoserie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_type_seriegeoserie cascade;
CREATE TABLE syntaxa.st_ref_type_seriegeoserie(
	"codeTypeSerieGeoserie" text,
	"libTypeSerieGeoserie" text,
	id_tri serial,
	CONSTRAINT "codeTypeSerieGeoserie_pkey" PRIMARY KEY ("codeTypeSerieGeoserie")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_type_seriegeoserie IS 'Référentiel des types de série et de géoséries'; 
COMMENT ON COLUMN syntaxa.st_ref_type_seriegeoserie."codeTypeSerieGeoserie" IS 'code du type de série et de géoséries';
COMMENT ON COLUMN syntaxa.st_ref_type_seriegeoserie."libTypeSerieGeoserie" IS 'libelle du type de série et de géoséries';
COMMENT ON COLUMN syntaxa.st_ref_type_seriegeoserie.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
ALTER TABLE syntaxa.st_ref_type_seriegeoserie OWNER TO postgres;
-- ddl-end --


-- object: syntaxa.st_ref_categorie_seriegeoserie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_categorie_seriegeoserie cascade;
CREATE TABLE syntaxa.st_ref_categorie_seriegeoserie(
	"codeCategorieSerieGeoserie" text,
	"libCategorieSerieGeoserie" text,
	id_tri serial,
	CONSTRAINT "codeCategorieSerieGeoserie_pkey" PRIMARY KEY ("codeCategorieSerieGeoserie")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_categorie_seriegeoserie IS 'Référentiel des catégorie de série et de géoséries'; 
COMMENT ON COLUMN syntaxa.st_ref_categorie_seriegeoserie."codeCategorieSerieGeoserie" IS 'code de la catégorie de série et de géoséries';
COMMENT ON COLUMN syntaxa.st_ref_categorie_seriegeoserie."libCategorieSerieGeoserie" IS 'libelle de la catégorie de série et de géoséries';
COMMENT ON COLUMN syntaxa.st_ref_categorie_seriegeoserie.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
ALTER TABLE syntaxa.st_ref_categorie_seriegeoserie OWNER TO postgres;
-- ddl-end --


-- object: syntaxa.st_ref_rang_syntaxon | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_rang_syntaxon cascade;
CREATE TABLE syntaxa.st_ref_rang_syntaxon(
	"codeRangSyntaxon" text,
	"libRangSyntaxon" text,
	"niveauRangSyntaxon" text,
	"suffixeRangSyntaxon" text,
	id_tri serial,
	CONSTRAINT "codeRangSyntaxon_pkey" PRIMARY KEY ("codeRangSyntaxon")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_rang_syntaxon IS 'Référentiel des rangs de syntaxons'; 
COMMENT ON COLUMN syntaxa.st_ref_rang_syntaxon."codeRangSyntaxon" IS 'code du rang de syntaxon';
COMMENT ON COLUMN syntaxa.st_ref_rang_syntaxon."libRangSyntaxon" IS 'libelle du rang de syntaxon';
COMMENT ON COLUMN syntaxa.st_ref_rang_syntaxon."niveauRangSyntaxon" IS 'niveau du rang de syntaxon';
COMMENT ON COLUMN syntaxa.st_ref_rang_syntaxon."suffixeRangSyntaxon" IS 'suffixe correspondant au rang du syntaxon';
COMMENT ON COLUMN syntaxa.st_ref_rang_syntaxon.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';

ALTER TABLE syntaxa.st_ref_rang_syntaxon OWNER TO postgres;
-- ddl-end --



-- object: syntaxa.st_ref_rang_seriegeoserie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_rang_seriegeoserie cascade;
CREATE TABLE syntaxa.st_ref_rang_seriegeoserie(
	"codeRangSerieGeoserie" text,
	"libRangSerieGeoserie" text,
	id_tri serial,
	CONSTRAINT "codeRangSerieGeoserie_pkey" PRIMARY KEY ("codeRangSerieGeoserie")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_rang_seriegeoserie IS 'Référentiel des rangs de série et de géoséries (ce référentiel n''est pas encore normé par la Société phytosociologique de France- SPF)'; 
COMMENT ON COLUMN syntaxa.st_ref_rang_seriegeoserie."codeRangSerieGeoserie" IS 'code du grand de série et de géoséries';
COMMENT ON COLUMN syntaxa.st_ref_rang_seriegeoserie."libRangSerieGeoserie" IS 'libelle du rang de série et de géoséries';
COMMENT ON COLUMN syntaxa.st_ref_rang_seriegeoserie.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';

ALTER TABLE syntaxa.st_ref_rang_seriegeoserie OWNER TO postgres;
-- ddl-end --





-- object: syntaxa.st_ref_type_facies | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_type_facies cascade;
CREATE TABLE syntaxa.st_ref_type_facies(
	"codeFacies" text,
	"libFacies" text,
	"libLongFacies" text,
	id_tri serial,
	CONSTRAINT "codeFacis_pkey" PRIMARY KEY ("codeFacies")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_type_facies IS 'Référentiel des types de faciès'; 
COMMENT ON COLUMN syntaxa.st_ref_type_facies."codeFacies" IS 'code du type de faciès';
COMMENT ON COLUMN syntaxa.st_ref_type_facies."libFacies" IS 'libelle du type de faciès';
COMMENT ON COLUMN syntaxa.st_ref_type_facies."libLongFacies" IS 'libelle long du type de faciès';
COMMENT ON COLUMN syntaxa.st_ref_type_facies.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';

ALTER TABLE syntaxa.st_ref_type_facies OWNER TO postgres;
-- ddl-end --

-- object: syntaxa.st_geo_sigmafacies | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_geo_sigmafacies cascade;
CREATE TABLE syntaxa.st_geo_sigmafacies(
	"idGeosigmafacies" text,
	"codeEnregistrementSerieGeoserie" text,
	"codeFacies" text,
	"libelleGeoSigmafacies" text,
	dominance text,
	usage text,
	"remarqueVariabilite" text,
	CONSTRAINT "idGeosigmafacies" PRIMARY KEY ("idGeosigmafacies")

);
ALTER TABLE syntaxa.st_geo_sigmafacies OWNER TO postgres;
-- ddl-end --
COMMENT ON TABLE syntaxa.st_geo_sigmafacies IS 'Table de correspondance entre le(geo)sigmataxon et un faciès qui donne le (geo)sigmafacies';
COMMENT ON COLUMN syntaxa.st_geo_sigmafacies."idGeosigmafacies" IS 'Identifiant unique du sigmafacies';
COMMENT ON COLUMN syntaxa.st_geo_sigmafacies."codeEnregistrementSerieGeoserie" IS 'Clé étrangère vers l''identifiant unique de la série ou petite géosérie';
COMMENT ON COLUMN syntaxa.st_geo_sigmafacies."codeFacies" IS 'clé étrangère vers le code du type de faciès';
COMMENT ON COLUMN syntaxa.st_geo_sigmafacies."libelleGeoSigmafacies" IS 'Concaténation du libelle du geosigmasyntaxa et du libelle du type de faciès ex: "pelouse de la Série de la forêt à Fagus sylvatica et Deschampsia flexuosa"';
COMMENT ON COLUMN syntaxa.st_geo_sigmafacies.dominance IS 'Champ texte libre qui indique si le (geo)sigmafaciès est généralement dominant dans la série (oui/non)';
COMMENT ON COLUMN syntaxa.st_geo_sigmafacies.usage IS 'Champ texte libre qui vise à décrire sigmafaciès';
COMMENT ON COLUMN syntaxa.st_geo_sigmafacies."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité du faciès. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';

-- ddl-end --

-- object: syntaxa.st_cortege_syntaxonomique | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_cortege_syntaxonomique cascade;
CREATE TABLE syntaxa.st_cortege_syntaxonomique(
	"codeEnregistrementCortegeSyntax" text,
	"idGeosigmafacies" text,
	"libelleGeoSigmafacies" text,
	"codeEnregistrementSyntax" text,
	"idSyntaxonRetenu" text,
	"nomSyntaxonRetenu" text,
	"rqSyntaxon" text,
	"pourcentageTheoriqSyntax" integer,
	"codeTeteSerie" text,
	CONSTRAINT "codeEnregistrementCortegeSyntax_pkey" PRIMARY KEY ("codeEnregistrementCortegeSyntax")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_cortege_syntaxonomique IS 'Cortège syntaxonomique de chaque geosigmafacies. Chaque syntaxon représente un stade dynamique du (geo)sigmasyntaxa. Ce stade peut être progressif ou regressif.';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."codeEnregistrementCortegeSyntax" IS 'identifiant unique de la ligne qui décrit le syntaxon composant le cortège';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."idGeosigmafacies" IS 'Identifiant unique du (geo)sigmafacies';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."libelleGeoSigmafacies" IS 'clé étrangère vers le libellé du geosigmafacies';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."codeEnregistrementSyntax" IS 'clé étrangère vers l''enregistrement du syntaxon';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."idSyntaxonRetenu" IS 'code du syntaxon retenu dans le catalogue d''origine pour le faciès donné d''une série ou petite géosérie donnée';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."nomSyntaxonRetenu" IS 'nom complet du syntaxon retenu dans le catalogue d''origine pour le faciès donné d''une série ou petite géosérie donnée';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."rqSyntaxon" IS 'remarque concernant ce syntaxon dans le cadre de son appartenance au cortège syntaxonomique d''un (geo)sigmafacies particulier';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."pourcentageTheoriqSyntax" IS 'Pourcentage moyen théorique du syntaxon pour le faciès donné d''une série ou petite géosérie donnée';
--COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."freqPresence" IS 'fréquence de présence d''un syntaxon sur le (geo)sigmafaciès sur le territoire étudié (pourcentage calculé ou informé à dire d''expert)';
--COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."origineFreqPresence" IS 'Indique l''origine de cette fréquence de présence (calculé ou à dire d''expert)';
COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."codeTeteSerie" IS 'Le syntaxon représente-t-il la tête de la (geo)série à laquelle il est associé';
--COMMENT ON COLUMN syntaxa.st_cortege_syntaxonomique."codeTypeStade" IS 'Indique le caractère progressif ou régressif du stade';
ALTER TABLE syntaxa.st_cortege_syntaxonomique OWNER TO postgres;
-- ddl-end --


/* --cette table a été supprimée de la base de données
-- object: syntaxa.st_ref_type_stade | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_type_stade cascade;
CREATE TABLE syntaxa.st_ref_type_stade(
	"codeTypeStade" text,
	"libTypeStade" text,
	CONSTRAINT "codeTypeStade_pkey" PRIMARY KEY ("codeTypeStade")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_type_stade IS 'Référentiel des stades dynamiques';
COMMENT ON COLUMN syntaxa.st_ref_type_stade."codeTypeStade" IS 'Code du type de stade dynamique';
COMMENT ON COLUMN syntaxa.st_ref_type_stade."libTypeStade" IS 'libelle du type de stade dynamique';
-- ddl-end --
*/





-- object: syntaxa.st_ref_tete_serie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_tete_serie cascade;
CREATE TABLE syntaxa.st_ref_tete_serie(
	"codeTeteSerie" text,
	"libTeteSerie" text,
	id_tri serial,
	CONSTRAINT "codeTeteSerie_pkey" PRIMARY KEY ("codeTeteSerie")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_tete_serie IS 'Référentiel des stades de la série (ou géosérie)';
COMMENT ON COLUMN syntaxa.st_ref_tete_serie."codeTeteSerie" IS 'Indique si ce stade représente la tête de série ou non';
COMMENT ON COLUMN syntaxa.st_ref_tete_serie."libTeteSerie" IS 'Décrit le type de stade (tête de série ou stade intermediaire)';
-- ddl-end --

-- object: syntaxa.st_indicateurs_floristiques | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_indicateurs_floristiques cascade;
CREATE TABLE syntaxa.st_indicateurs_floristiques(
	"idIndicateurFlor" text,
	"idGeosigmafacies" text,
	"idRattachementReferentiel" text,
	CONSTRAINT "idIndicateurFlor_pkey" PRIMARY KEY ("idIndicateurFlor")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_indicateurs_floristiques IS 'Indicateurs floristiques de chaque (geo)sigmafacies';
COMMENT ON COLUMN syntaxa.st_indicateurs_floristiques."idIndicateurFlor" IS 'Identifiant unique de la ligne qui correspond au taxon qui sert d''indicateur floristique au (geo)sigmafacies';
COMMENT ON COLUMN syntaxa.st_indicateurs_floristiques."idGeosigmafacies" IS 'Identifiant unique du (geo)sigmafacies auquel l''indicateur floristique est rattaché';
COMMENT ON COLUMN syntaxa.st_indicateurs_floristiques."idRattachementReferentiel" IS 'Identifiant unique de la ligne qui correspond au taxon dans un référentiel donné (taxref ou autre)';

ALTER TABLE syntaxa.st_indicateurs_floristiques OWNER TO postgres;
-- ddl-end --

-- object: taxa.referentiel_taxo | type: TABLE --
-- DROP TABLE IF EXISTS taxa.referentiel_taxo;
/*CREATE TABLE taxa.referentiel_taxo(
	id_rattachement_referentiel text,
	code_referentiel text,
	version_referentiel text,
	cd_ref_referentiel text,
	cd_nom_referentiel text,
	nom_complet_taxon_referentiel text,
	CONSTRAINT "PK_referentiel" PRIMARY KEY (id_rattachement_referentiel)

);*/
-- ddl-end --
-- object: syntaxa.st_syntaxon | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_syntaxon cascade;
CREATE TABLE syntaxa.st_syntaxon(
	"idCatalogue" text,
	"codeEnregistrementSyntax" text,
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
	"aireMinimale" text,
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
	CONSTRAINT "codeEnregistrementSyntax_pkey" PRIMARY KEY ("codeEnregistrementSyntax")

);

/* A vérifier mais j'ai changé le type de la colonne aireMinimale 
alter table syntaxa.st_syntaxon drop column "aireMinimale"; 
alter table syntaxa.st_syntaxon add column "aireMinimale" text;
pour l'application qui ne prenait pas encore en compte le type float

du coup il faut lancer un 
update referentiels.champs set type='string' where nom_champ='aireMinimale' and table_champ='st_syntaxon' ;

Dans la table des référentiels*/

alter table syntaxa.st_syntaxon add column uid serial not null;
COMMENT ON COLUMN syntaxa.st_syntaxon.uid IS 'Autoincrément pour les besoins de l''application codex';

GRANT ALL PRIVILEGES ON syntaxa.st_syntaxon TO user_codex;
grant all on TABLE syntaxa.st_syntaxon_uid_seq TO user_codex;




-- Sequence: refnat.taxons_uid_seq
 
-- DROP SEQUENCE refnat.taxons_uid_seq;

/*CREATE SEQUENCE syntaxa.st_syntaxon_uid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE syntaxa.st_syntaxon_uid_seq
  OWNER TO user_codex;
  */
  

-- ddl-end --
COMMENT ON TABLE syntaxa.st_syntaxon IS 'Table contenant les syntaxons et leurs principaux descripteurs (univariés)';
COMMENT ON COLUMN syntaxa.st_syntaxon."idCatalogue" IS 'identifiant du catalogue d''appartenance de l''enregistrmenet';
COMMENT ON COLUMN syntaxa.st_syntaxon."codeEnregistrementSyntax" IS 'identifiant unique de l''enregistrement (de la ligne) dans le catalogue qui associe l''identifiant unique du syntaxon synonyme et l''identifiant du catalogue';
COMMENT ON COLUMN syntaxa.st_syntaxon."idSyntaxon" IS 'identifiant unique du syntaxon dans le catalogue d''origine';
COMMENT ON COLUMN syntaxa.st_syntaxon."nomSyntaxon" IS 'nom latin du syntaxon synonyme dans le catalogue d''origine';
COMMENT ON COLUMN syntaxa.st_syntaxon."auteurSyntaxon" IS 'autorité et date du syntaxon synonyme';
COMMENT ON COLUMN syntaxa.st_syntaxon."nomCompletSyntaxon" IS 'Nom complet du syntaxon synonyme dans le catalogue d''origine (concaténation des champs "NOM_SYNTAXON" et "AUTEUR_SYNTAXON")';
COMMENT ON COLUMN syntaxa.st_syntaxon."rqNomenclaturale" IS 'Champ libre donnant des précisions sur le nom choisi dans le cas où le nom n''existe pas dans le PVF';
COMMENT ON COLUMN syntaxa.st_syntaxon."typeSynonymie" IS 'type de synonymie du syntaxon';
COMMENT ON COLUMN syntaxa.st_syntaxon."idSyntaxonRetenu" IS 'identifiant unique du syntaxon retenu dans le catalogue d''origine (syntaxon de référence retenu par le CBN)  auquel renvoie le syntaxon ';
COMMENT ON COLUMN syntaxa.st_syntaxon."nomSyntaxonRetenu" IS 'nom complet du syntaxon retenu dans le catalogue d''origine (syntaxon de référence retenu par le CBN) auquel renvoie le syntaxon synonyme';
COMMENT ON COLUMN syntaxa.st_syntaxon."nomSyntaxonRaccourci" IS 'nom raccourci du syntaxon retenu';
COMMENT ON COLUMN syntaxa.st_syntaxon."rangSyntaxon" IS 'niveau du syntaxon dans la classification syntaxonomique';
COMMENT ON COLUMN syntaxa.st_syntaxon."idSyntaxonSup" IS 'identifiant du syntaxon directement supérieur auquel appartient le syntaxon';
COMMENT ON COLUMN syntaxa.st_syntaxon."nomFrancaisSyntaxon" IS 'nom français harmonisé qui correspond à la traduction française du nom latin. ';
COMMENT ON COLUMN syntaxa.st_syntaxon."diagnoseCourteSyntaxon" IS 'Description libre en une phrase qui inclus formation végétale + terme écologique et chorologique incluant l’étage de végétation';
COMMENT ON COLUMN syntaxa.st_syntaxon."idCritique" IS 'réponse de type oui/non: Le syntaxon est-il clairement délimité ou non? Est-il franc? (renvoi à la typicité du syntaxon)';
COMMENT ON COLUMN syntaxa.st_syntaxon."rqCritique" IS 'champ texte libre de commentaire sur la typicité du syntaxon';
COMMENT ON COLUMN syntaxa.st_syntaxon."repartitionGenerale" IS 'Texte libre qui indique la répartition sur le territoire français et transfrontalier';
COMMENT ON COLUMN syntaxa.st_syntaxon."repartitionTerritoire" IS 'Répartition dans le territoire étudié. Champ texte libre. Répartition à petite échelle. On indique la présence dans les petites régions naturelles propres à chaque CBN (région naturelle de présence)';
COMMENT ON COLUMN syntaxa.st_syntaxon."periodeDebObsOptimale" IS 'début de la période  optimale d''observation de la végétation';
COMMENT ON COLUMN syntaxa.st_syntaxon."periodeFinObsOptimale" IS 'fin de la période  optimale d''observation de la végétation';
COMMENT ON COLUMN syntaxa.st_syntaxon."rqPhenologie" IS 'Champ libre (mais harmonisé) de remarque sur la phénologie';
COMMENT ON COLUMN syntaxa.st_syntaxon."aireMinimale" IS 'Aire minimale théorique d''expression de la végétation (aire au-delà de laquelle le nombre d''espèces végétales rencontrées n''augmente plus de façon significative,  surface nécessaire pour relever la quasi-totalité du cortège floristique) en m2';
COMMENT ON COLUMN syntaxa.st_syntaxon."typeBiologiqueDom" IS 'Champ libre du type biologique dominant (type biologique dominant des taxons composant la végétation)';
COMMENT ON COLUMN syntaxa.st_syntaxon."typePhysionomique" IS 'Type physionomique de la formation végétale (référentiel interne aux CBN, le plus précis possible)';
COMMENT ON COLUMN syntaxa.st_syntaxon."rqPhysionomie" IS 'champ libre de remarque portant sur la physionomie de la végétation';
COMMENT ON COLUMN syntaxa.st_syntaxon."humiditePrincipale" IS 'codification du caractère hygrophile du syntaxon sur le territoire (appartenance principale = conditions optimales)';
COMMENT ON COLUMN syntaxa.st_syntaxon."humiditeSecondaire" IS 'codification du caractère hygrophile du syntaxon sur le territoire (appartenance secondaire= condition favorables)';
COMMENT ON COLUMN syntaxa.st_syntaxon."phPrincipal" IS 'codification du pH (appartenance principale= conditions optimales)';
COMMENT ON COLUMN syntaxa.st_syntaxon."phSecondaire" IS 'codification du pH  (appartenance secondaire= conditions favorables)';
COMMENT ON COLUMN syntaxa.st_syntaxon.trophie IS 'codification de la trophie';
COMMENT ON COLUMN syntaxa.st_syntaxon.temperature IS 'codification du caractère thermique';
COMMENT ON COLUMN syntaxa.st_syntaxon.luminosite IS 'codification de la luminosité';
COMMENT ON COLUMN syntaxa.st_syntaxon.exposition IS 'codification de l''exposition';
COMMENT ON COLUMN syntaxa.st_syntaxon.salinite IS 'caractère halophile de la végétation';
COMMENT ON COLUMN syntaxa.st_syntaxon.neige IS 'caractère chinophile de la végétation';
COMMENT ON COLUMN syntaxa.st_syntaxon.continentalite IS 'caractère continental ou non de la végétation';
COMMENT ON COLUMN syntaxa.st_syntaxon.ombroclimat IS 'ombroclimat  selon Rivas-Martinez, 1981';
COMMENT ON COLUMN syntaxa.st_syntaxon.climat IS 'climats selon Joly et al, 2010';
COMMENT ON COLUMN syntaxa.st_syntaxon."descriptionEcologie" IS 'Champ texte libre de description de l''écologie générale du syntaxon';
COMMENT ON COLUMN syntaxa.st_syntaxon."remarqueVariabilite" IS 'Champ libre de remarque sur la variabilité du faciès. On peut y inclure des remarques sur les dynamiques primaires, secondaires, etc. 
Elles pourraient faire l’objet d’une codification ultérieurement. Pour le moment, ce n’est pas figé. Ces variantes dépendent du déterminisme (qui n’est pas toujours bien identifié en l’état actuel des connaissances)';


-- ddl-end --
-- object: syntaxa.st_suivi_enregistrement | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_suivi_enregistrement cascade;
CREATE TABLE syntaxa.st_suivi_enregistrement(
	"idSuivi" text,
	"codeEnregistrement" text,
	"dateSuivi" date,
	"idAuteurSuivi" text,
	"prenomAuteurSuivi" text,
	"nomAuteurSuivi" text,
	"actionSuivi" text,
	CONSTRAINT "idSuivi_pkey" PRIMARY KEY ("idSuivi")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_suivi_enregistrement IS 'Table de suivi des enregistrements (création et mise à jour)';
COMMENT ON COLUMN syntaxa.st_suivi_enregistrement."idSuivi" IS ' identifiant unique de l''action de suivi de l''enregistrement dans la table';
COMMENT ON COLUMN syntaxa.st_suivi_enregistrement."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel le suivi est réalisé';
COMMENT ON COLUMN syntaxa.st_suivi_enregistrement."dateSuivi" IS 'date de suivi de la table';
COMMENT ON COLUMN syntaxa.st_suivi_enregistrement."idAuteurSuivi" IS 'identifiant de la personne ayant réalisé le suivi de la table';
COMMENT ON COLUMN syntaxa.st_suivi_enregistrement."prenomAuteurSuivi" IS 'prénom de la personne ayany réalisé le suivi de l''enregistrement';
COMMENT ON COLUMN syntaxa.st_suivi_enregistrement."nomAuteurSuivi" IS 'nom de la personne ayany réalisé le suivi de l''enregistrement';
COMMENT ON COLUMN syntaxa.st_suivi_enregistrement."actionSuivi" IS 'action de suivi (création ou mise à jour)';
ALTER TABLE syntaxa.st_suivi_enregistrement OWNER TO postgres;
-- ddl-end --

-- object: syntaxa.st_ref_action_suivi | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_action_suivi cascade;
CREATE TABLE syntaxa.st_ref_action_suivi(
	"codeActionSuivi" text,
	"libActionSuivi" text,
	id_tri serial,
	CONSTRAINT "codeActionSuivi_pkey" PRIMARY KEY ("codeActionSuivi")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_action_suivi IS 'Référentiel des types de suivi de données';
COMMENT ON COLUMN syntaxa.st_ref_action_suivi."codeActionSuivi" IS 'Codification du type de suivi';
COMMENT ON COLUMN syntaxa.st_ref_action_suivi."libActionSuivi" IS 'Libellé du type de suivi';
COMMENT ON COLUMN syntaxa.st_ref_action_suivi."id_tri" IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';

ALTER TABLE syntaxa.st_ref_action_suivi OWNER TO postgres;
-- ddl-end --




-- object: syntaxa.st_chorologie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_chorologie cascade;
CREATE TABLE syntaxa.st_chorologie(
	"idChorologie" serial not null,
	"codeEnregistrement" text,
	"statutChorologie" text,
	"idTerritoire" text,
	CONSTRAINT "idChorologie" PRIMARY KEY ("idChorologie")


);

--ajout des droits sur la sequence serial pour l'application
grant all on TABLE syntaxa."st_chorologie_idChorologie_seq" TO user_codex;

-- ddl-end --
COMMENT ON TABLE syntaxa.st_chorologie IS 'Table indiquant la chorologie de chaque syntaxon, série ou petite géosérie';
COMMENT ON COLUMN syntaxa.st_chorologie."idChorologie" IS 'identifiant unique de la chorologie enregistrée (ex:idchoro_1, idchoro_2 etc)';
COMMENT ON COLUMN syntaxa.st_chorologie."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la chorologie est renseignée';
COMMENT ON COLUMN syntaxa.st_chorologie."statutChorologie" IS 'statut de la présence sur le territoire (concerne la chorologie de la végétation c''est à dire la région naturelle de présence)';
COMMENT ON COLUMN syntaxa.st_chorologie."idTerritoire" IS 'code unique du territoire pour lequel le statut de la végétation est renseigné, fait référence à la table liste_geo du taxa';
ALTER TABLE syntaxa.st_chorologie OWNER TO postgres;
-- ddl-end --

-- object: syntaxa.st_ref_statut_chorologie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_statut_chorologie cascade;
CREATE TABLE syntaxa.st_ref_statut_chorologie(
	"idStatutChorologie" text,
	"libStatutChrologie" text,
	id_tri serial,
	CONSTRAINT "idStatutchorologie_pkey" PRIMARY KEY ("idStatutChorologie")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_statut_chorologie IS 'Référentiel qui contient les valeurs que peuvent prendre les statuts de chorologie';
COMMENT ON COLUMN syntaxa.st_ref_statut_chorologie."idStatutChorologie" IS 'Code du statut de chorologie';
COMMENT ON COLUMN syntaxa.st_ref_statut_chorologie."libStatutChrologie" IS 'libellé du statut de chorologie';
COMMENT ON COLUMN syntaxa.st_ref_statut_chorologie.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_correspondance_pvf | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_correspondance_pvf cascade;
CREATE TABLE syntaxa.st_correspondance_pvf(
	"idCorrespondancePVF" serial not null,
	"idRattachementPVF" integer,
	"codeEnregistrementSyntaxon" text,
--	"codeReferentiel" text,
	"versionReferentiel" text,
--	"identifiantSyntaxonRetenu" text,
--	"nomSyntaxonRetenu" text,
	CONSTRAINT "idCorrespondancePVF_pkey" PRIMARY KEY ("idCorrespondancePVF")

);
/*
alter table syntaxa.st_correspondance_pvf drop column "codeReferentiel";
alter table syntaxa.st_correspondance_pvf drop column "identifiantSyntaxonRetenu";
alter table syntaxa.st_correspondance_pvf drop column "nomSyntaxonRetenu";
*/

/* A vérifier mais j'ai changé le type de la colonne idCorrespondancePVF 
alter table syntaxa.st_correspondance_pvf drop column "idCorrespondancePVF"; 
alter table syntaxa.st_correspondance_pvf add column "idCorrespondancePVF" serial not null;
pour l'application qui ne prenait pas encore en compte le type float

du coup il faut lancer un 
update referentiels.champs set type='string' where nom_champ='idCorrespondancePVF' and table_champ='st_correspondance_pvf' ;

Dans la table des référentiels*/



alter table syntaxa.st_correspondance_pvf  
-- ddl-end --
COMMENT ON TABLE syntaxa.st_correspondance_pvf IS 'Table de correspondance avec la typologie du PVF (PVF1 et PVF2)';
COMMENT ON COLUMN syntaxa.st_correspondance_pvf."idCorrespondancePVF" IS 'identifiant unique pour la table de correspondance';
COMMENT ON COLUMN syntaxa.st_correspondance_pvf."idRattachementPVF" IS 'identifiant unique du syntaxon dans la table contenant pvf1 et pvf2';
COMMENT ON COLUMN syntaxa.st_correspondance_pvf."codeEnregistrementSyntaxon" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la géomorphologie est renseignée';
COMMENT ON COLUMN syntaxa.st_correspondance_pvf."codeReferentiel" IS 'code du référentiel (ici PVF)';
COMMENT ON COLUMN syntaxa.st_correspondance_pvf."versionReferentiel" IS 'version du référentiel';
COMMENT ON COLUMN syntaxa.st_correspondance_pvf."identifiantSyntaxonRetenu" IS 'identifiant du syntaxon retenu dans le référentiel choisi (CD_SYNTAXON dans le PVF)';
COMMENT ON COLUMN syntaxa.st_correspondance_pvf."nomSyntaxonRetenu" IS 'nom du syntaxon retenu dans le référentiel choisi (LB_SYNTAXON dans le PVF)';
-- ddl-end --

-- object: syntaxa.st_geomorphologie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_geomorphologie cascade;
CREATE TABLE syntaxa.st_geomorphologie(
	"idVegGeomorpho" text,
	"codeEnregistrement" text,
	"idGeomorphologie" text,
	"libGeomorphologie" text
);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_geomorphologie IS 'Table d''appartenance d''une végétation à une ou plusieurs géomorphologie';
COMMENT ON COLUMN syntaxa.st_geomorphologie."idVegGeomorpho" IS 'identifiant unique de l''association d''une végétation et d''une géomorphologie';
COMMENT ON COLUMN syntaxa.st_geomorphologie."codeEnregistrement" IS 'code de l''enregistrement (Syntaxon, série ou petite géosérie) pour lequel la géomorphologie est renseignée';
COMMENT ON COLUMN syntaxa.st_geomorphologie."idGeomorphologie" IS 'identifiant du taxon géomorphologique';
COMMENT ON COLUMN syntaxa.st_geomorphologie."libGeomorphologie" IS 'libellé du taxon géomorphologique';
-- ddl-end --

-- object: syntaxa.st_ref_geomorpho | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_geomorpho cascade;
CREATE TABLE syntaxa.st_ref_geomorpho(
	"idGeomorphologie" text,
	"libGeomorphologie" text,
	id_tri serial
);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_geomorpho IS 'Référentiel géomorphologique';
COMMENT ON COLUMN syntaxa.st_ref_geomorpho."idGeomorphologie" IS 'identifiant du taxon géomorphologique';
COMMENT ON COLUMN syntaxa.st_ref_geomorpho."libGeomorphologie" IS 'libellé de la géomorphologie';
COMMENT ON COLUMN syntaxa.st_ref_geomorpho.id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_cortege_floristique | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_cortege_floristique cascade;
CREATE TABLE syntaxa.st_cortege_floristique(
	"idCortegeFloristique" text,
	"codeEnregistrementSyntaxon" text,
	"idRattachementReferentiel" text,
	"typeTaxon" text
);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_cortege_floristique IS 'Cortège floristique qui accompagne le syntaxon';
COMMENT ON COLUMN syntaxa.st_cortege_floristique."idCortegeFloristique" IS 'identifiant unique du taxon dans le cortège floristique';
COMMENT ON COLUMN syntaxa.st_cortege_floristique."codeEnregistrementSyntaxon" IS 'code de l''enregistrement du syntaxon';
COMMENT ON COLUMN syntaxa.st_cortege_floristique."idRattachementReferentiel" IS 'identifiant du rattachement au référentiel';
COMMENT ON COLUMN syntaxa.st_cortege_floristique."typeTaxon" IS 'indique si le taxon est caractéristique ou différentiel';
-- ddl-end --

-- object: syntaxa.st_ref_pvf | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_pvf cascade;
CREATE TABLE syntaxa.st_ref_pvf(
	"idRattachementPVF" oid,
	"codeReferentiel" text,
	"versionReferentiel" text,
	"identifiantSyntaxonRetenu" text,
	"rangSyntaxonRetenu" text,
	"nomSyntaxonRetenu" text,
	id_tri serial,
	CONSTRAINT "idRattachementPVF" PRIMARY KEY ("idRattachementPVF")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_pvf IS 'Typologie du PVF (PVF1 et PVF2)';
COMMENT ON COLUMN syntaxa.st_ref_pvf."idRattachementPVF" IS 'code du syntaxon dans l''un des référentiels pvf (1 ou 2)';
COMMENT ON COLUMN syntaxa.st_ref_pvf."codeReferentiel" IS 'code du référentiel (ici PVF)';
COMMENT ON COLUMN syntaxa.st_ref_pvf."versionReferentiel" IS 'version du référentiel';
COMMENT ON COLUMN syntaxa.st_ref_pvf."identifiantSyntaxonRetenu" IS 'identifiant du syntaxon retenu dans le référentiel choisi (CD_SYNTAXON dans le PVF)';
COMMENT ON COLUMN syntaxa.st_ref_pvf."rangSyntaxonRetenu" IS 'rang du syntaxon retenu dans le référentiel choisi (niveau dans le PVF)';
COMMENT ON COLUMN syntaxa.st_ref_pvf."nomSyntaxonRetenu" IS 'nom du syntaxon retenu dans le référentiel choisi (LB_SYNTAXON dans le PVF)';
COMMENT ON COLUMN syntaxa.st_ref_pvf.id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_correspondance_hic | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_correspondance_hic cascade;
CREATE TABLE syntaxa.st_correspondance_hic(
	"idCorresHIC" serial not null,
	"codeEnregistrement" text,
	"typeEnregistrement" text,
	"codeHIC" text,
	--"libHIC" text,
	"rqHIC" text
);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_correspondance_hic IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats de la directive habitat (N2000)';
COMMENT ON COLUMN syntaxa.st_correspondance_hic."idCorresHIC" IS 'identifiant unique de la correspondance entre le syntaxon et l''habitat d''intérêt communautaire';
COMMENT ON COLUMN syntaxa.st_correspondance_hic."codeEnregistrement" IS 'code de l'' enregistrement de syntaxon, du syntaxon dans le cadre d''un cortège syntaxonomique, du (geo)sigmafacies ou SeriePetiteGeoserie';
COMMENT ON COLUMN syntaxa.st_correspondance_hic."typeEnregistrement" IS 'indique s''il s''agit d''un enregistrement de syntaxon, syntaxon de cortège, (geo)sigmafacies ou SeriePetiteGeoserie';
COMMENT ON COLUMN syntaxa.st_correspondance_hic."codeHIC" IS 'code de l''habitat Natura 2000 concerné par la correspondance';
--COMMENT ON COLUMN syntaxa.st_correspondance_hic."libHIC" IS 'libellé de l''habitat Natura 2000 concerné par la correspondance';
COMMENT ON COLUMN syntaxa.st_correspondance_hic."rqHIC" IS 'champ libre de remarque à propos du rattachement au code HIC';
-- ddl-end --

-- object: syntaxa.st_ref_hic | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_hic cascade;
CREATE TABLE syntaxa.st_ref_hic(
	"codeHIC" text,
	"libHIC" text,
	id_tri serial,
	CONSTRAINT "codeHIC_pkey" PRIMARY KEY ("codeHIC")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_hic IS 'Référentiel des habitats de la directive habitat (N2000)';
COMMENT ON COLUMN syntaxa.st_ref_hic."codeHIC" IS 'code de l''habitat Natura 2000';
COMMENT ON COLUMN syntaxa.st_ref_hic."libHIC" IS 'libellé de l''habitat Natura 2000';
COMMENT ON COLUMN syntaxa.st_ref_hic.id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --


 /*
 
 --cette table permettait de faire la correspondance avec le fond physio et de faire des extrapolation.
 --Elle n'est pas retenue dans le format de catalogue définitif
 
-- object: syntaxa.st_correspondance_fondphysio | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_correspondance_fondphysio cascade;
CREATE TABLE syntaxa.st_correspondance_fondphysio(
	"idCorresPhysio" text,
	"idChorologie" text,
	"probaOccurence" text,
	"idFdPhysioN3" text,
	"libFdPhysioN3" text,
	"rqFdPhysioN3" text,
	CONSTRAINT "idCorresPhysio_pkey" PRIMARY KEY ("idCorresPhysio")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_correspondance_fondphysio IS 'Table de correspondance entre une UTV pour un territoire donné avec une classe du fond physionomique produit par l''IGN';
COMMENT ON COLUMN syntaxa.st_correspondance_fondphysio."idCorresPhysio" IS 'identifiant unique de la correspondance entre la physionomie et l''enregistrement de végétation (syntaxon, série ou petite géosérie)';
COMMENT ON COLUMN syntaxa.st_correspondance_fondphysio."idChorologie" IS 'code de la chorologie qui correspond au code de l'' enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie (UTV) associé à un territoire';
COMMENT ON COLUMN syntaxa.st_correspondance_fondphysio."probaOccurence" IS 'code de la chorologie qui correspond au code de l'' enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie (UTV) associé à un territoire';
COMMENT ON COLUMN syntaxa.st_correspondance_fondphysio."idFdPhysioN3" IS 'Probabilité d''occurence de l'' UTV dans ce territoire donné et pour cette classe du fond physionomique';
COMMENT ON COLUMN syntaxa.st_correspondance_fondphysio."libFdPhysioN3" IS 'Nom du poste de nomenclature correspondant dans le fond physionomique (niveau le plus fin de la nomenclature)';
COMMENT ON COLUMN syntaxa.st_correspondance_fondphysio."rqFdPhysioN3" IS 'Champ tete libre de remarque sur le rattachement entre l''enregistrement de végétation (syntaxon, sigmafacies, série ou petite géosérie) et le fond physio';
-- ddl-end --

*/

/*
--cette table n'est pas retenue dans le format définitif des catalogues

-- object: syntaxa.st_ref_physio | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_physio cascade;
CREATE TABLE syntaxa.st_ref_physio(
	"milieuCarhab" text,
	"idFdPhysioN3" text,
	"libFdPhysioN3" text,
	CONSTRAINT "idFdPhysioN3_pkey" PRIMARY KEY ("idFdPhysioN3")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_physio IS 'Référentiel du fond physionomique produit par l''IGN';
COMMENT ON COLUMN syntaxa.st_ref_physio."milieuCarhab" IS 'Type de milieu au sens carhab milieu ouvert de plaine, d''altitude, milieu forestier...';
COMMENT ON COLUMN syntaxa.st_ref_physio."idFdPhysioN3" IS 'Identifiant du poste de nomenclature dans le fond physionomique (niveau le plus fin de la nomenclature)';
COMMENT ON COLUMN syntaxa.st_ref_physio."libFdPhysioN3" IS 'Nom du poste de nomenclature dans le fond physionomique (niveau le plus fin de la nomenclature)';
-- ddl-end --
*/

-- object: syntaxa.st_etage_veg | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_etage_veg cascade;
CREATE TABLE syntaxa.st_etage_veg(
	"idCorresEtageveg" serial not null,
	"codeEnregistrement" text,
	"codeEtageVeg" text,
	"libEtageVeg" text,
	CONSTRAINT "idCorresEtageVeg_pkey" PRIMARY KEY ("idCorresEtageveg")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_etage_veg IS 'Table de correspondance entre le syntaxon-série-petite géosérie et l''étage de végétation ';
COMMENT ON COLUMN syntaxa.st_etage_veg."idCorresEtageveg" IS 'identifiant unique de la correspondance entre l''enregistrement et l''étage de végétation';
COMMENT ON COLUMN syntaxa.st_etage_veg."codeEnregistrement" IS 'identifiant unique de l''enregistrement du syntaxon, faciès, série ou petite géosérie';
COMMENT ON COLUMN syntaxa.st_etage_veg."codeEtageVeg" IS 'code de l''étage de végétation';
COMMENT ON COLUMN syntaxa.st_etage_veg."libEtageVeg" IS 'libellé de l''étage de végétation';
-- ddl-end --

-- object: syntaxa."st_ref_etage_veg" | type: TABLE --
DROP TABLE IF EXISTS syntaxa."st_ref_etage_veg" cascade;
CREATE TABLE syntaxa."st_ref_etage_veg"(
	"codeEtageVeg" text,
	"libEtageVeg" text,
	"libLongEtageVeg" text,
	id_tri serial,
	CONSTRAINT "codeEtageVeg_pkey" PRIMARY KEY ("codeEtageVeg")

);
-- ddl-end --
COMMENT ON TABLE syntaxa."st_ref_etage_veg" IS 'Référentiel des étages de végétation proposé par le réseau';
COMMENT ON COLUMN syntaxa."st_ref_etage_veg"."codeEtageVeg" IS 'code de l''étage de végétation';
COMMENT ON COLUMN syntaxa."st_ref_etage_veg"."libEtageVeg" IS 'libellé de l''étage de végétation';
COMMENT ON COLUMN syntaxa."st_ref_etage_veg"."libLongEtageVeg" IS 'libellé long de l''étage de végétation';
COMMENT ON COLUMN syntaxa."st_ref_etage_veg".id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_etage_bioclim | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_etage_bioclim cascade;
CREATE TABLE syntaxa.st_etage_bioclim(
	"idCorresEtageBioclim" serial not null,
	"codeEnregistrement" text,
	"codeEtageBioclim" text,
	"libEtageBioclim" text,
	CONSTRAINT "idCorresEtageBioclim_pkey" PRIMARY KEY ("idCorresEtageBioclim")

);
-- ddl-end --
COMMENT ON TABLE syntaxa."st_etage_bioclim" IS 'Table indiquant l''appartenance d''un syntaxon,série ou petite géosérie à un ou plusieurs étages de végétation ';
COMMENT ON COLUMN syntaxa.st_etage_bioclim."idCorresEtageBioclim" IS 'identifiant unique de la correspondance entre l''enregistrement et l''étage bioclimatique';
COMMENT ON COLUMN syntaxa.st_etage_bioclim."codeEnregistrement" IS 'identifiant unique de l''enregistrement du syntaxon, faciès, série ou petite géosérie';
COMMENT ON COLUMN syntaxa.st_etage_bioclim."codeEtageBioclim" IS 'code de l''étage bioclimatique';
COMMENT ON COLUMN syntaxa.st_etage_bioclim."libEtageBioclim" IS 'libellé de l''étage bioclimatique';
-- ddl-end --

-- object: syntaxa.st_ref_etage_bioclim | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_etage_bioclim CASCADE;
CREATE TABLE syntaxa.st_ref_etage_bioclim(
	"codeEtageBioclim" text,
	"libEtageBioclim" text,
	id_tri serial,
	CONSTRAINT "codeEtageBioclim_pkey" PRIMARY KEY ("codeEtageBioclim")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_etage_bioclim IS 'Référentiel des étages bioclimatiques';
COMMENT ON COLUMN syntaxa.st_ref_etage_bioclim."codeEtageBioclim" IS 'code de l''étage bioclimatique';
COMMENT ON COLUMN syntaxa.st_ref_etage_bioclim."libEtageBioclim" IS 'libellé de l''étage bioclimatique';
COMMENT ON COLUMN syntaxa.st_ref_etage_bioclim.id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_biblio | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_biblio cascade;
CREATE TABLE syntaxa.st_biblio(
	"idBiblio" serial not null,
	"codeEnregistrement" text,
	"libPublication" text,
	"urlPublication" text,
	"codePublication" text,
	CONSTRAINT "idBiblio_pkey" PRIMARY KEY ("idBiblio")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_biblio IS 'Table qui recense les références bibliographiques en lien avec la description des syntaxons, des séries et géoséries';
COMMENT ON COLUMN syntaxa.st_biblio."idBiblio" IS 'identifiant unique de la table de biblio qui associe une publication a un enregistrment dans la base';
COMMENT ON COLUMN syntaxa.st_biblio."codeEnregistrement" IS 'Code de l''enregistrement d''un syntaxon, série ou géosérie';
COMMENT ON COLUMN syntaxa.st_biblio."libPublication" IS 'Libellé de la publication (dont titre, année,  volume et le nombre de pages) qui atteste de la présence du taxon dans le territoire étudié';
COMMENT ON COLUMN syntaxa.st_biblio."urlPublication" IS 'permalien vers la notice bibliographique du document source de référence (Kentika, PMB, Alexandrie, ..) ou permalien vers le document en téléchargement  qui atteste de la présence du syntaxon dans le territoire étudié';
COMMENT ON COLUMN syntaxa.st_biblio."codePublication" IS 'numero ISSN de la publication qui atteste de la présence du syntaxon dans le territoire étudié';
-- ddl-end --

-- object: syntaxa.st_ref_periode | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_periode cascade;
CREATE TABLE syntaxa.st_ref_periode(
	"codePeriode" text,
	"libPeriode" text,
	id_tri serial,
	CONSTRAINT "libPeriode" PRIMARY KEY ("codePeriode")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_periode IS 'Table qui référence les périodes optimales de végétation (liste de début et fin de chaque saison)';
COMMENT ON COLUMN syntaxa.st_ref_periode."codePeriode" IS 'code de la période';
COMMENT ON COLUMN syntaxa.st_ref_periode."libPeriode" IS 'libellé de la période';
COMMENT ON COLUMN syntaxa.st_ref_periode.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_humidite | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_humidite cascade;
CREATE TABLE syntaxa.st_ref_humidite(
	"indHum" text,
	"libHum" text,
	"libLongHum" text,
	id_tri serial,
	CONSTRAINT "indHum_pkey" PRIMARY KEY ("indHum")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_humidite IS 'Référentiel de l''indice d''humidité édaphique selon Ellenberg et Julve (moisture)';
COMMENT ON COLUMN syntaxa.st_ref_humidite."indHum" IS 'Indice de l''Humidité selon Ellenberg et Julve';
COMMENT ON COLUMN syntaxa.st_ref_humidite."libHum" IS 'libellé court de l''Humidité selon Ellenberg et Julve';
COMMENT ON COLUMN syntaxa.st_ref_humidite."libLongHum" IS 'libellé long de l''Humidité selon Ellenberg et Julve';
COMMENT ON COLUMN syntaxa.st_ref_humidite.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_reaction | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_reaction cascade;
CREATE TABLE syntaxa.st_ref_reaction(
	"indReaction" text,
	"libReaction" text,
	"libLongReaction" text,
	id_tri serial,
	CONSTRAINT "indReac_pkey" PRIMARY KEY ("indReaction")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_reaction IS 'Référentiel de l''indice de pH selon Landolt (réaction)';
COMMENT ON COLUMN syntaxa.st_ref_reaction."indReaction" IS 'Indice de la réaction selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_reaction."libReaction" IS 'libellé court dela réaction selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_reaction."libLongReaction" IS 'libellé long de l''Humidité selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_reaction.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_trophie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_trophie cascade;
CREATE TABLE syntaxa.st_ref_trophie(
	"indTrophie" text,
	"libTrophie" text,
	"libLongTrophie" text,
	id_tri serial,
	CONSTRAINT "indTrophie_pkey" PRIMARY KEY ("indTrophie")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_trophie IS 'Référentiel de la trophie selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_trophie."indTrophie" IS 'Indice de la trophie selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_trophie."libTrophie" IS 'libellé court dela trophie selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_trophie."libLongTrophie" IS 'libellé long de trophie selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_trophie.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_exposition | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_exposition cascade;
CREATE TABLE syntaxa.st_ref_exposition(
	"idExposition" text,
	"libExposition" text,
	id_tri serial,
	CONSTRAINT "idExposition_fkey" PRIMARY KEY ("idExposition")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_exposition IS 'Référentiel des valeurs d''exposition';
COMMENT ON COLUMN syntaxa.st_ref_exposition."idExposition" IS 'identifiant de l''exposition de la végétation';
COMMENT ON COLUMN syntaxa.st_ref_exposition."libExposition" IS 'libellé de l''exposition de la végétation';
COMMENT ON COLUMN syntaxa.st_ref_exposition.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_type_synonymie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_type_synonymie cascade;
CREATE TABLE syntaxa.st_ref_type_synonymie(
	"idTypeSyn" text,
	"libTypSyn" text,
	id_tri serial,
	CONSTRAINT "idTypeSyn" PRIMARY KEY ("idTypeSyn")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_type_synonymie IS 'Référentiel des types de synonymie';
COMMENT ON COLUMN syntaxa.st_ref_type_synonymie."idTypeSyn" IS 'identifiant du type de synonymie';
COMMENT ON COLUMN syntaxa.st_ref_type_synonymie."libTypSyn" IS 'libellé du type de synonymie';
COMMENT ON COLUMN syntaxa.st_ref_type_synonymie.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';

-- ddl-end --
-- object: syntaxa.st_annuaire_organismes | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_annuaire_organismes cascade;
CREATE TABLE syntaxa.st_annuaire_organismes(
	"idOrganisme" text,
	"acronymeOrganisme" text,
	"libOrganisme" text,
	CONSTRAINT "idOrganisme_pkey" PRIMARY KEY ("idOrganisme")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_annuaire_organismes IS 'Table d''annuaire qui recense les organismes en lien avec la création des catalogues';
COMMENT ON COLUMN syntaxa.st_annuaire_organismes."idOrganisme" IS 'Identifiant unique de l''organisme';
COMMENT ON COLUMN syntaxa.st_annuaire_organismes."acronymeOrganisme" IS 'Acronyme de l''organisme';
COMMENT ON COLUMN syntaxa.st_annuaire_organismes."libOrganisme" IS 'Libellé complet de l''organisme';
-- ddl-end --

-- object: syntaxa.st_annuaire_personnes | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_annuaire_personnes cascade;
CREATE TABLE syntaxa.st_annuaire_personnes(
	"idPersonne" text,
	prenom text,
	nom text,
	id_tri serial NOT NULL,
	CONSTRAINT "idPersonne_pkey" PRIMARY KEY ("idPersonne")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_annuaire_personnes IS 'Table d''annuaire qui recense les personnes en lien avec la création des catalogues';
COMMENT ON COLUMN syntaxa.st_annuaire_personnes."idPersonne" IS 'Identifiant unique de la personne';
COMMENT ON COLUMN syntaxa.st_annuaire_personnes."prenom" IS 'Prénom de la personne';
COMMENT ON COLUMN syntaxa.st_annuaire_personnes."nom" IS 'Nom de la personne';
COMMENT ON COLUMN syntaxa.st_annuaire_personnes.id_tri is 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --


-- object: syntaxa.st_collaborateur | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_collaborateur cascade;
CREATE TABLE syntaxa.st_collaborateur(
	"idCollaborateur" text,
	"identifiantCatalogue" text,
	"idOrganisme" text,
	"acronymeOrganisme" text,
	"idPersonne" text,
	prenom text,
	nom text,
	CONSTRAINT "idCollaborateur" PRIMARY KEY ("idCollaborateur")

);
-- ddl-end --

COMMENT ON TABLE syntaxa.st_collaborateur IS 'Table de collaborateur qui fait le lien entre les personnes, leur organisme et le catalogue auquel elles ont participé';
COMMENT ON COLUMN syntaxa.st_collaborateur."idCollaborateur" IS 'Identifiant unique collaborateur qui est la combinaison d''une personne et d''un organisme (ex: collab_1, collab_2 etc)';
COMMENT ON COLUMN syntaxa.st_collaborateur."identifiantCatalogue" IS 'identifiant du catalogue (clé étrangère)';
COMMENT ON COLUMN syntaxa.st_collaborateur."idOrganisme" IS 'identifiant de l''organisme d''appartenance du collaborateur';
COMMENT ON COLUMN syntaxa.st_collaborateur."acronymeOrganisme" IS 'acronyme de l''organisme d''appartenance du collaborateur';
COMMENT ON COLUMN syntaxa.st_collaborateur."idPersonne" IS 'identifiant de la personne collaborateur';
COMMENT ON COLUMN syntaxa.st_collaborateur."prenom" IS 'Prénom du collaborateur';
COMMENT ON COLUMN syntaxa.st_collaborateur."nom" IS 'Nom du collaborateur';


-- object: syntaxa.st_ref_critique | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_critique cascade;
CREATE TABLE syntaxa.st_ref_critique(
	"idCritique" text,
	"libCritique" text,
	id_tri serial,
	CONSTRAINT "idCritique_pkey" PRIMARY KEY ("idCritique")
);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_critique IS 'Référentiel de la criticité des syntaxons';
COMMENT ON COLUMN syntaxa.st_ref_critique."idCritique" IS 'valeurs que prend le caractère critique (oui/non)';
COMMENT ON COLUMN syntaxa.st_ref_critique."libCritique" IS 'libellé du caractère critique le syntaxon est critique, le syntaxon n''est pas critique';
COMMENT ON COLUMN syntaxa.st_ref_critique.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_type_physionomique | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_type_physionomique cascade;
CREATE TABLE syntaxa.st_ref_type_physionomique(
	"idTypePhysio" text,
	"libTypePhysio" text,
	id_tri serial,
	CONSTRAINT "idTypePhysio_pkey" PRIMARY KEY ("idTypePhysio")

);
-- ddl-end --

COMMENT ON TABLE syntaxa.st_ref_type_physionomique IS 'Référentiel des types physionomiques';
COMMENT ON COLUMN syntaxa.st_ref_type_physionomique."idTypePhysio" IS 'identifiant du type physionomique';
COMMENT ON COLUMN syntaxa.st_ref_type_physionomique."libTypePhysio" IS 'libellé du type physionomique';


-- object: syntaxa.st_ref_temperature | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_temperature cascade;
CREATE TABLE syntaxa.st_ref_temperature(
	"indTemp" text,
	"libTemp" text,
	"libLongTemp" text,
	id_tri serial,
	CONSTRAINT "indTemperaturee_pkey" PRIMARY KEY ("indTemp")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_temperature IS 'Référentiel des indices de température selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_temperature."indTemp" IS 'Indice de la température selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_temperature."libTemp" IS 'libellé court de la température selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_temperature."libLongTemp" IS 'libellé long de température selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_temperature.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_lumiere | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_lumiere cascade;
CREATE TABLE syntaxa.st_ref_lumiere(
	"indLum" text,
	"libLum" text,
	"libLongLum" text,
	id_tri serial,
	CONSTRAINT "indLum_pkey" PRIMARY KEY ("indLum")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_lumiere IS 'Référentiel des indices d''affinité de la végétation à la lumière selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_lumiere."indLum" IS 'Indice d''affinité à la lumière selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_lumiere."libLum" IS 'libellé court d''affinité à la lumière selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_lumiere."libLongLum" IS 'libellé long  d''affinité à la lumière selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_lumiere.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_neige | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_neige cascade;
CREATE TABLE syntaxa.st_ref_neige(
	"idNeige" text,
	"libNeige" text,
	"libLongNeige" text, 
	"exempleNeige" text,
	id_tri serial,
	CONSTRAINT neige_pkey PRIMARY KEY ("idNeige")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_neige IS 'Référentiel de l''affinité de la végétation à la neige';
COMMENT ON COLUMN syntaxa.st_ref_neige."idNeige" IS 'identifiant (code) qui indique l''affinité de la végétation à la neige';
COMMENT ON COLUMN syntaxa.st_ref_neige."libNeige" IS 'libellé qui indique l''affinité de la végétation à la neige';
COMMENT ON COLUMN syntaxa.st_ref_neige."libLongNeige" IS 'libellé long qui indique l''affinité de la végétation à la neige';
COMMENT ON COLUMN syntaxa.st_ref_neige."exempleNeige" IS 'exemple de végétation pour ce critère d''affinité à la neige';
COMMENT ON COLUMN syntaxa.st_ref_neige.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_continentalite | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_continentalite cascade;
CREATE TABLE syntaxa.st_ref_continentalite(
	"indCont" text,
	"libCont" text,
	"libLongCont" text,
	id_tri serial,
	CONSTRAINT "indCont_pkey" PRIMARY KEY ("indCont")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_continentalite IS 'Référentiel de la continentalité selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_continentalite."indCont" IS 'Indice de la continentalite selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_continentalite."libCont" IS 'libellé court de la Continentalité selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_continentalite."libLongCont" IS 'libellé long de continentalité selon Landolt';
COMMENT ON COLUMN syntaxa.st_ref_continentalite.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_salinite | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_salinite cascade;
CREATE TABLE syntaxa.st_ref_salinite(
	"indSali" text,
	"libSali" text,
	"libLongSali" text,
	id_tri serial,
	CONSTRAINT "indSali_pkey" PRIMARY KEY ("indSali")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_salinite IS 'Référentiel de l''affinité à la salinité selon Ellenberg et Julve';
COMMENT ON COLUMN syntaxa.st_ref_salinite."indSali" IS 'Indice de l''affinité à la salinite selon Ellenberg et Julve';
COMMENT ON COLUMN syntaxa.st_ref_salinite."libSali" IS 'libellé court de l''affinité à la salinite selon Ellenberg et Julve';
COMMENT ON COLUMN syntaxa.st_ref_salinite."libLongSali" IS 'libellé long de l''affinité à la salinite selon Ellenberg et Julve';
COMMENT ON COLUMN syntaxa.st_ref_salinite.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_ref_rivasmartinez_ombroclimat | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_rivasmartinez_ombroclimat cascade;
CREATE TABLE syntaxa.st_ref_rivasmartinez_ombroclimat(
	"idOmbroclimat" text,
	"libOmbroclimat" text,
	"libLongOmbroclimat" text,
	id_tri serial,
	CONSTRAINT "idOmbroClimat_pkey" PRIMARY KEY ("idOmbroclimat")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_rivasmartinez_ombroclimat IS 'Référentiel des ombro-climats d''après Rivas-Martinez';
COMMENT ON COLUMN syntaxa.st_ref_rivasmartinez_ombroclimat."idOmbroclimat" IS 'code de l''ombroclimat d''après Rivas-Martinez';
COMMENT ON COLUMN syntaxa.st_ref_rivasmartinez_ombroclimat."libOmbroclimat" IS 'libellé court de l''ombroclimat selon Rivas Martinez';
COMMENT ON COLUMN syntaxa.st_ref_rivasmartinez_ombroclimat."libLongOmbroclimat" IS 'libellé long de l''ombroclimat selon Rivas-Martinez';
COMMENT ON COLUMN syntaxa.st_ref_rivasmartinez_ombroclimat.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --

-- object: syntaxa.st_correspondance_eunis | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_correspondance_eunis cascade;
CREATE TABLE syntaxa.st_correspondance_eunis(
	"idCorresEUNIS" serial not null,
	"codeEnregistrement" text,
	"typeEnregistrement" text,
	"codeEUNIS" text,
--	"libEUNIS" text,
	"rqEUNIS" text,
	CONSTRAINT "idCorrespondanceEUNIS_pkey" PRIMARY KEY ("idCorresEUNIS")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_correspondance_eunis IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats EUNIS';
COMMENT ON COLUMN syntaxa.st_correspondance_eunis."idCorresEUNIS" IS 'identifiant unique portant un couple syntaxon/correspondance typologie EUNIS';
COMMENT ON COLUMN syntaxa.st_correspondance_eunis."codeEnregistrement" IS 'code de l'' enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie';
COMMENT ON COLUMN syntaxa.st_correspondance_eunis."typeEnregistrement" IS 'indique s''il s''agit d''un enregistrement de syntaxon, (geo)sigmafacies ou SeriePetiteGeoserie';
COMMENT ON COLUMN syntaxa.st_correspondance_eunis."codeEUNIS" IS 'code de l''habitat EUNIS concerné par la correspondance';
--COMMENT ON COLUMN syntaxa.st_correspondance_eunis."libEUNIS" IS 'libellé de l''habitat EUNIS concerné par la correspondance';
COMMENT ON COLUMN syntaxa.st_correspondance_eunis."rqEUNIS" IS 'champ libre de remarque à propos du rattachement au code HIc';
-- ddl-end --

-- object: syntaxa.st_ref_eunis | type: TABLE --
DROP TABLE IF EXISTS syntaxa.st_ref_eunis cascade;
CREATE TABLE syntaxa.st_ref_eunis(
	"codeEUNIS" text,
	"libEUNIS" text,
	id_tri serial,
	CONSTRAINT "codeEUNIS_pkey" PRIMARY KEY ("codeEUNIS")

);
-- ddl-end --
COMMENT ON TABLE syntaxa.st_ref_eunis IS 'Table de correspondance entre les végétations (syntaxon, (geo)sigmafacies, séries et petites géoséries) et les habitats de la directive habitat (N2000)';
COMMENT ON COLUMN syntaxa.st_ref_eunis."codeEUNIS" IS 'code de l''habitat EUNIS concerné par la correspondance';
COMMENT ON COLUMN syntaxa.st_ref_eunis."libEUNIS" IS 'libellé de l''habitat EUNIS concerné par la correspondance';
COMMENT ON COLUMN syntaxa.st_ref_eunis.id_tri is'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';
-- ddl-end --




-------------------------------------------------------------------------------CONTRAINTES---------------------------------------------------------------------------------------------

-- object: idcatalogue_fkey | type: CONSTRAINT --
--ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT idcatalogue_fkey;
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT idcatalogue_fkey FOREIGN KEY ("idCatalogue")
REFERENCES syntaxa.st_catalogue_description ("identifiantCatalogue") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --




-- object: "humiditePrincipale_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT "humiditePrincipale_fkey";
--CREATE UNIQUE INDEX libHum_uniq ON syntaxa.st_ref_humidite ("indHum");
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT "humiditePrincipale_fkey" FOREIGN KEY ("humiditePrincipale")
REFERENCES syntaxa.st_ref_humidite ("indHum") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "humiditeSecondaire_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT "humiditeSecondaire_fkey";
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT "humiditeSecondaire_fkey" FOREIGN KEY ("humiditeSecondaire")
REFERENCES syntaxa.st_ref_humidite ("indHum") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "phPrincipal_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT "phPrincipal_fkey";
--CREATE UNIQUE INDEX libReaction_uniq ON syntaxa.st_ref_reaction ("indReaction");
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT "phPrincipal_fkey" FOREIGN KEY ("phPrincipal")
REFERENCES syntaxa.st_ref_reaction ("indReaction") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "phSecondaire_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT "phSecondaire_fkey";
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT "phSecondaire_fkey" FOREIGN KEY ("phSecondaire")
REFERENCES syntaxa.st_ref_reaction ("indReaction") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --






-- object: exposition_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT exposition_fkey;
--CREATE UNIQUE INDEX libExposition_uniq ON syntaxa.st_ref_exposition ("libExposition");
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT exposition_fkey FOREIGN KEY (exposition)
REFERENCES syntaxa.st_ref_exposition ("idExposition") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: exposition_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT exposition_fkey2;
--CREATE UNIQUE INDEX libExposition_uniq ON syntaxa.st_ref_exposition ("libExposition");
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT exposition_fkey2 FOREIGN KEY (exposition)
REFERENCES syntaxa.st_ref_exposition ("idExposition") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



-- object: exposition_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT codeCategorieSerieGeoserie_fkey;
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT codeCategorieSerieGeoserie_fkey FOREIGN KEY ("codeCategorieSerieGeoserie")
REFERENCES syntaxa.st_ref_categorie_seriegeoserie ("codeCategorieSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: exposition_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT codeTypeSerieGeoserie_fkey;
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT codeTypeSerieGeoserie_fkey FOREIGN KEY ("codeTypeSerieGeoserie")
REFERENCES syntaxa.st_ref_type_seriegeoserie ("codeTypeSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: exposition_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT codeRangSerieGeoserie_fkey;
ALTER TABLE syntaxa.st_serie_petitegeoserie ADD CONSTRAINT codeRangSerieGeoserie_fkey FOREIGN KEY ("codeRangSerieGeoserie")
REFERENCES syntaxa.st_ref_rang_seriegeoserie ("codeRangSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --




-- object: exposition_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_serie_petitegeoserie DROP CONSTRAINT codeRangSerieGeoserie_fkey;
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT codeRangSyntaxon_fkey FOREIGN KEY ("rangSyntaxon")
REFERENCES syntaxa.st_ref_rang_syntaxon ("codeRangSyntaxon") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --






-- object: "codeEnregistrementSerieGeoserie_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_geo_sigmafacies DROP CONSTRAINT "codeEnregistrementSerieGeoserie_fkey1";

ALTER TABLE syntaxa.st_geo_sigmafacies ADD CONSTRAINT "codeEnregistrementSerieGeoserie_fkey1" FOREIGN KEY ("codeEnregistrementSerieGeoserie")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeFacies_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_geo_sigmafacies DROP CONSTRAINT "codeFacies_fkey";
ALTER TABLE syntaxa.st_geo_sigmafacies ADD CONSTRAINT "codeFacies_fkey" FOREIGN KEY ("codeFacies")
REFERENCES syntaxa.st_ref_type_facies ("codeFacies") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idGeosigmafacies_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_syntaxonomique DROP CONSTRAINT "idGeosigmafacies_fkey";
ALTER TABLE syntaxa.st_cortege_syntaxonomique ADD CONSTRAINT "idGeosigmafacies_fkey" FOREIGN KEY ("idGeosigmafacies")
REFERENCES syntaxa.st_geo_sigmafacies ("idGeosigmafacies") MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


/*-- object: "libelleGeoSigmafacies _fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_syntaxonomique DROP CONSTRAINT "libelleGeoSigmafacies _fkey";
--CREATE UNIQUE INDEX codeFacies_uniq ON syntaxa.st_geo_sigmafacies("codeFacies");
ALTER TABLE syntaxa.st_cortege_syntaxonomique ADD CONSTRAINT "libelleGeoSigmafacies_fkey" FOREIGN KEY ("libelleGeoSigmafacies")
REFERENCES syntaxa.st_geo_sigmafacies ("codeFacies") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --*/



/*
--Cette table a été supprimée de la base de données
-- object: "codeTypeStade_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_syntaxonomique DROP CONSTRAINT "codeTypeStade_fkey";
ALTER TABLE syntaxa.st_cortege_syntaxonomique ADD CONSTRAINT "codeTypeStade_fkey" FOREIGN KEY ("codeTypeStade")
REFERENCES syntaxa.st_ref_type_stade ("codeTypeStade") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
*/

-- object: "codeTeteSerie_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_syntaxonomique DROP CONSTRAINT "codeTeteSerie_fkey";
ALTER TABLE syntaxa.st_cortege_syntaxonomique ADD CONSTRAINT "codeTeteSerie_fkey" FOREIGN KEY ("codeTeteSerie")
REFERENCES syntaxa.st_ref_tete_serie ("codeTeteSerie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrementSyntax_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_syntaxonomique DROP CONSTRAINT "codeEnregistrementSyntax_fkey";
ALTER TABLE syntaxa.st_cortege_syntaxonomique ADD CONSTRAINT "codeEnregistrementSyntax_fkey" FOREIGN KEY ("codeEnregistrementSyntax")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --


-- object: "nomSyntaxonretenu" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_syntaxonomique DROP CONSTRAINT "nomSyntaxonretenu";
--CREATE UNIQUE INDEX idyntaxonretenu_uniq ON syntaxa.st_syntaxon ("idSyntaxonRetenu");
--ALTER TABLE syntaxa.st_cortege_syntaxonomique ADD CONSTRAINT "idSyntaxonretenu" FOREIGN KEY ("idSyntaxonRetenu")
--REFERENCES syntaxa.st_syntaxon ("idSyntaxonRetenu") MATCH FULL
--ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "nomSyntaxonretenu" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_syntaxonomique DROP CONSTRAINT "nomSyntaxonretenu";
--DROP nomSyntaxonretenu_uniq ON syntaxa.st_syntaxon ("nomSyntaxonRetenu");
--ALTER TABLE syntaxa.st_cortege_syntaxonomique ADD CONSTRAINT "nomSyntaxonretenu" FOREIGN KEY ("nomSyntaxonRetenu")
--REFERENCES syntaxa.st_syntaxon ("nomSyntaxonRetenu") MATCH FULL
--ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idGeosigmafacies_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_indicateurs_floristiques DROP CONSTRAINT "idGeosigmafacies_fkey2";
ALTER TABLE syntaxa.st_indicateurs_floristiques ADD CONSTRAINT "idGeosigmafacies_fkey2" FOREIGN KEY ("idGeosigmafacies")
REFERENCES syntaxa.st_geo_sigmafacies ("idGeosigmafacies") MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: "idRattachementreferentiel_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_indicateurs_floristiques DROP CONSTRAINT "idRattachementreferentiel_fkey";
ALTER TABLE syntaxa.st_indicateurs_floristiques ADD CONSTRAINT "idRattachementreferentiel_fkey" FOREIGN KEY ("idRattachementReferentiel")
REFERENCES syntaxa.referentiel_taxo (id_rattachement_referentiel) MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --


-- object: "idTerritoireCatalogue_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_catalogue_description DROP CONSTRAINT "idTerritoireCatalogue_fkey";
ALTER TABLE syntaxa.st_catalogue_description ADD CONSTRAINT "idTerritoireCatalogue_fkey" FOREIGN KEY ("idTerritoireCatalogue")
REFERENCES syntaxa.liste_geo ("id_territoire") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --

-- object: "idCatalogue_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "idCatalogue_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "idCatalogue_fkey" FOREIGN KEY ("idCatalogue")
REFERENCES syntaxa.st_catalogue_description ("identifiantCatalogue") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --




-- object: "debObsOptimale_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "debObsOptimale_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "debObsOptimale_fkey" FOREIGN KEY ("periodeDebObsOptimale")
REFERENCES syntaxa.st_ref_periode ("codePeriode") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "finObsOptimale_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "finObsOptimale_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "finObsOptimale_fkey" FOREIGN KEY ("periodeFinObsOptimale")
REFERENCES syntaxa.st_ref_periode ("codePeriode") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "humiditePrincipale_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.syntaxon DROP CONSTRAINT "humiditePrincipale_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "humiditePrincipale_fkey" FOREIGN KEY ("humiditePrincipale")
REFERENCES syntaxa.st_ref_humidite ("indHum") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "humiditeSecondaire_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "humiditeSecondaire_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "humiditeSecondaire_fkey" FOREIGN KEY ("humiditeSecondaire")
REFERENCES syntaxa.st_ref_humidite ("indHum") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "pHprincipal_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "pHprincipal_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "pHprincipal_fkey" FOREIGN KEY ("phPrincipal")
REFERENCES syntaxa.st_ref_reaction ("indReaction") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "phSecondaire_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "phSecondaire_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "phSecondaire_fkey" FOREIGN KEY ("phSecondaire")
REFERENCES syntaxa.st_ref_reaction ("indReaction") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: trophie_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT trophie_fkey;
CREATE UNIQUE INDEX indTrophie_uniq ON syntaxa.st_ref_trophie ("indTrophie");
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT trophie_fkey FOREIGN KEY (trophie)
REFERENCES syntaxa.st_ref_trophie ("indTrophie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "typeSynonymie_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "typeSynonymie_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "typeSynonymie_fkey" FOREIGN KEY ("typeSynonymie")
REFERENCES syntaxa.st_ref_type_synonymie ("idTypeSyn") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idCritique" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "idCritique";
CREATE UNIQUE INDEX idCritique_uniq ON syntaxa.st_ref_critique ("idCritique");
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "idCritique_fkey" FOREIGN KEY ("idCritique")
REFERENCES syntaxa.st_ref_critique ("idCritique") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --

-- object: "idCritique" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_suivi_enregistrement DROP CONSTRAINT "codeActionSuivi_fkey";
ALTER TABLE syntaxa.st_suivi_enregistrement ADD CONSTRAINT "codeActionSuivi_fkey" FOREIGN KEY ("actionSuivi")
REFERENCES syntaxa.st_ref_action_suivi ("codeActionSuivi") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --


-- object: "typePhysionomique_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "typePhysionomique_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "typePhysionomique_fkey" FOREIGN KEY ("typePhysionomique")
REFERENCES syntaxa.st_ref_type_physionomique ("idTypePhysio") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --


-- object: temperature_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT temperature_fkey;
CREATE UNIQUE INDEX indTemp_uniq ON syntaxa.st_ref_temperature ("indTemp");
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT temperature_fkey FOREIGN KEY (temperature)
REFERENCES syntaxa.st_ref_temperature ("indTemp") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: lumiere_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT lumiere_fkey;
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT lumiere_fkey FOREIGN KEY (luminosite)
REFERENCES syntaxa.st_ref_lumiere ("indLum") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "Neige_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT "Neige_fkey";
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT "Neige_fkey" FOREIGN KEY (neige)
REFERENCES syntaxa.st_ref_neige ("idNeige") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: continentalite_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT continentalite_fkey;
CREATE UNIQUE INDEX indCont_uniq ON syntaxa.st_ref_continentalite ("indCont");
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT continentalite_fkey FOREIGN KEY (continentalite)
REFERENCES syntaxa.st_ref_continentalite ("indCont") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: salinite_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT salinite_fkey;
CREATE UNIQUE INDEX indSali_uniq ON syntaxa.st_ref_salinite ("indSali");
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT salinite_fkey FOREIGN KEY (salinite)
REFERENCES syntaxa.st_ref_salinite ("indSali") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: ombroclimat_fkey | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_syntaxon DROP CONSTRAINT ombroclimat_fkey;
CREATE UNIQUE INDEX idOmbroclimat_uniq ON syntaxa.st_ref_rivasmartinez_ombroclimat ("idOmbroclimat");
ALTER TABLE syntaxa.st_syntaxon ADD CONSTRAINT ombroclimat_fkey FOREIGN KEY (ombroclimat)
REFERENCES syntaxa.st_ref_rivasmartinez_ombroclimat ("idOmbroclimat") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

/* --pas possible de mettre une contrainte sur deux tables en même temps car quand on ajoute un enregistrement syntaxa ( de la table st_syntaxon) il considère que l'enregistrement n'existe pas dans la table st_serie_petitegeoserie 
-- object: "codeEnregistrement_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_suivi_enregistrement DROP CONSTRAINT "codeEnregistrement_fkey1";

ALTER TABLE syntaxa.st_suivi_enregistrement ADD CONSTRAINT "codeEnregistrement_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_suivi_enregistrement DROP CONSTRAINT "codeEnregistrement_fkey2";
ALTER TABLE syntaxa.st_suivi_enregistrement ADD CONSTRAINT "codeEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --
*/


-- object: "idAuteurSuivi" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_suivi_enregistrement DROP CONSTRAINT "idAuteurSuivi";
ALTER TABLE syntaxa.st_suivi_enregistrement ADD CONSTRAINT "idAuteurSuivi" FOREIGN KEY ("idAuteurSuivi")
REFERENCES syntaxa.st_annuaire_personnes ("idPersonne") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --



-- object: "codeEnregistrementSerieGeoserie_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_chorologie DROP CONSTRAINT "codeEnregistrementSerieGeoserie_fkey1";
ALTER TABLE syntaxa.st_chorologie ADD CONSTRAINT "codeEnregistrementSerieGeoserie_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: "codeEnregistrementSyntaxon_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_chorologie DROP CONSTRAINT "codeEnregistrementSyntaxon_fkey";
ALTER TABLE syntaxa.st_chorologie ADD CONSTRAINT "codeEnregistrementSyntaxon_fkey" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: "choroTypeTerritoire" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_chorologie DROP CONSTRAINT "choroTypeTerritoire";
DROP index syntaxa.id_territoire_uniq;
CREATE UNIQUE INDEX id_territoire_uniq ON syntaxa.liste_geo ("id_territoire");
ALTER TABLE syntaxa.st_chorologie ADD CONSTRAINT "idTerritoire" FOREIGN KEY ("idTerritoire")
REFERENCES syntaxa.liste_geo (id_territoire) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



-- object: "idStatut_Chorologie" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_chorologie DROP CONSTRAINT "idStatut_Chorologie";
ALTER TABLE syntaxa.st_chorologie ADD CONSTRAINT "idStatut_Chorologie" FOREIGN KEY ("statutChorologie")
REFERENCES syntaxa.st_ref_statut_chorologie ("idStatutChorologie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrementSyntaxon_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_pvf DROP CONSTRAINT "codeEnregistrementSyntaxon_fkey";
ALTER TABLE syntaxa.st_correspondance_pvf ADD CONSTRAINT "codeEnregistrementSyntaxon_fkey" FOREIGN KEY ("codeEnregistrementSyntaxon")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idRattachementPVF_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_pvf DROP CONSTRAINT "idRattachementPVF_fkey";
ALTER TABLE syntaxa.st_correspondance_pvf ADD CONSTRAINT "idRattachementPVF_fkey" FOREIGN KEY ("idRattachementPVF")
REFERENCES syntaxa.st_ref_pvf ("idRattachementPVF") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrementSyntaxon_pkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_pvf DROP CONSTRAINT "codeEnregistrementSyntaxon_pkey";
ALTER TABLE syntaxa.st_correspondance_pvf ADD CONSTRAINT "codeEnregistrementSyntaxon_pkey" FOREIGN KEY ("codeEnregistrementSyntaxon")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idEnregistrement_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_geomorphologie DROP CONSTRAINT "idEnregistrement_fkey1";
ALTER TABLE syntaxa.st_geomorphologie ADD CONSTRAINT "idEnregistrement_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_geomorphologie DROP CONSTRAINT "idEnregistrement_fkey2";
ALTER TABLE syntaxa.st_geomorphologie ADD CONSTRAINT "idEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



-- object: "idGeomorphologie_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_geomorphologie DROP CONSTRAINT "idGeomorphologie_fkey";
CREATE UNIQUE INDEX idGeomorphologie_uniq ON syntaxa.st_ref_geomorpho ("idGeomorphologie");
ALTER TABLE syntaxa.st_geomorphologie ADD CONSTRAINT "idGeomorphologie_fkey" FOREIGN KEY ("idGeomorphologie")
REFERENCES syntaxa.st_ref_geomorpho ("idGeomorphologie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --





-- object: "idEnregistrement_fkey3" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_geomorphologie DROP CONSTRAINT "idEnregistrement_fkey3";
ALTER TABLE syntaxa.st_geomorphologie ADD CONSTRAINT "idEnregistrement_fkey3" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_geo_sigmafacies ("idGeosigmafacies") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrementSyntaxo_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_floristique DROP CONSTRAINT "codeEnregistrementSyntaxo_fkey";
ALTER TABLE syntaxa.st_cortege_floristique ADD CONSTRAINT "codeEnregistrementSyntaxo_fkey" FOREIGN KEY ("codeEnregistrementSyntaxon")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idRattachementReferentiel_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_cortege_floristique DROP CONSTRAINT "idRattachementReferentiel_fkey";
ALTER TABLE syntaxa.st_cortege_floristique ADD CONSTRAINT "idRattachementReferentiel_fkey" FOREIGN KEY ("idRattachementReferentiel")
REFERENCES syntaxa.referentiel_taxo (id_rattachement_referentiel) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

/*
-- object: "codeEnregistrement_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_hic DROP CONSTRAINT "codeEnregistrement_fkey1";

ALTER TABLE syntaxa.st_correspondance_hic ADD CONSTRAINT "codeEnregistrement_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_hic DROP CONSTRAINT "codeEnregistrement_fkey2";
ALTER TABLE syntaxa.st_correspondance_hic ADD CONSTRAINT "codeEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_geo_sigmafacies ("idGeosigmafacies") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_hic DROP CONSTRAINT "codeEnregistrement_fkey3";
ALTER TABLE syntaxa.st_correspondance_hic ADD CONSTRAINT "codeEnregistrement_fkey3" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_cortege_syntaxonomique ("codeEnregistrementCortegeSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_hic DROP CONSTRAINT "codeEnregistrement_fkey4";
ALTER TABLE syntaxa.st_correspondance_hic ADD CONSTRAINT "codeEnregistrement_fkey4" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


*/




-- object: "codeHIC_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_hic DROP CONSTRAINT "codeHIC_fkey";
ALTER TABLE syntaxa.st_correspondance_hic ADD CONSTRAINT "codeHIC_fkey" FOREIGN KEY ("codeHIC")
REFERENCES syntaxa.st_ref_hic ("codeHIC") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



/*-- object: "idChorologie_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_fondphysio DROP CONSTRAINT "idChorologie_fkey";
ALTER TABLE syntaxa.st_correspondance_fondphysio ADD CONSTRAINT "idChorologie_fkey" FOREIGN KEY ("idChorologie")
REFERENCES syntaxa.st_chorologie ("idChorologie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_fondphysio DROP CONSTRAINT "codeEnregistrement_fkey1";
ALTER TABLE syntaxa.st_correspondance_fondphysio ADD CONSTRAINT "codeEnregistrement_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("idCatalogue") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_fondphysio DROP CONSTRAINT "codeEnregistrement_fkey2";
ALTER TABLE syntaxa.st_correspondance_fondphysio ADD CONSTRAINT "codeEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_geo_sigmafacies ("idGeosigmafacies") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey3" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_fondphysio DROP CONSTRAINT "codeEnregistrement_fkey3";
ALTER TABLE syntaxa.st_correspondance_fondphysio ADD CONSTRAINT "codeEnregistrement_fkey3" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
*/

/*
--la table de fond physio fond blanc n'est pas retenue dans le format définitif des catalogues
-- object: "idFdPhysioN3_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_fondphysio DROP CONSTRAINT "idFdPhysioN3_fkey";
ALTER TABLE syntaxa.st_correspondance_fondphysio ADD CONSTRAINT "idFdPhysioN3_fkey" FOREIGN KEY ("idFdPhysioN3")
REFERENCES syntaxa.st_ref_physio ("idFdPhysioN3") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
*/

--ces clefs posent problème car si j'enregistre avec l'application des étages de végétation pour un syntaxon il me dit que le syntaxon n'existe pas dans la table
--syntaxa.st_serie_petitegeoserie et viole donc la contrainte de clé étrangère « codeEnregistrement_fkey2 »  
/*
-- object: "codeEnregistrement_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_veg DROP CONSTRAINT "codeEnregistrement_fkey1";
ALTER TABLE syntaxa.st_etage_veg ADD CONSTRAINT "codeEnregistrement_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_veg DROP CONSTRAINT "codeEnregistrement_fkey2";
ALTER TABLE syntaxa.st_etage_veg ADD CONSTRAINT "codeEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
*/

-- object: "codeEtageVeg_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_veg DROP CONSTRAINT "codeEtageVeg_fkey";
ALTER TABLE syntaxa.st_etage_veg ADD CONSTRAINT "codeEtageVeg_fkey" FOREIGN KEY ("codeEtageVeg")
REFERENCES syntaxa."st_ref_etage_veg" ("codeEtageVeg") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "libEtageVeg_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_veg DROP CONSTRAINT "libEtageVeg_fkey";
CREATE UNIQUE INDEX libEtageVeg_uniq ON syntaxa.st_ref_etage_veg("libEtageVeg");
ALTER TABLE syntaxa.st_etage_veg ADD CONSTRAINT "libEtageVeg_fkey" FOREIGN KEY ("libEtageVeg")
REFERENCES syntaxa."st_ref_etage_veg" ("libEtageVeg") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



-- object: "codeEtageBioclim_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_bioclim DROP CONSTRAINT "codeEtageBioclim_fkey1";
ALTER TABLE syntaxa.st_etage_bioclim ADD CONSTRAINT "codeEtageBioclim_fkey1" FOREIGN KEY ("codeEtageBioclim")
REFERENCES syntaxa.st_ref_etage_bioclim ("codeEtageBioclim") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



-- object: "codeEtageBioclim_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_bioclim DROP CONSTRAINT "codeEtageBioclim_fkey";
ALTER TABLE syntaxa.st_etage_bioclim ADD CONSTRAINT "codeEtageBioclim_fkey" FOREIGN KEY ("codeEtageBioclim")
REFERENCES syntaxa.st_ref_etage_bioclim ("codeEtageBioclim") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_bioclim DROP CONSTRAINT "codeEnregistrement_fkey1";
ALTER TABLE syntaxa.st_etage_bioclim ADD CONSTRAINT "codeEnregistrement_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_etage_bioclim DROP CONSTRAINT "codeEnregistrement_fkey2";
ALTER TABLE syntaxa.st_etage_bioclim ADD CONSTRAINT "codeEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



-- object: "codeEnregistrement_fkey1" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_biblio DROP CONSTRAINT "codeEnregistrement_fkey1";
ALTER TABLE syntaxa.st_biblio ADD CONSTRAINT "codeEnregistrement_fkey1" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



-- object: "codeEnregistrement_fkey2" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_biblio DROP CONSTRAINT "codeEnregistrement_fkey2";
ALTER TABLE syntaxa.st_biblio ADD CONSTRAINT "codeEnregistrement_fkey2" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_serie_petitegeoserie ("codeEnregistrementSerieGeoserie") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: "idPersonne_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_collaborateur DROP CONSTRAINT "idPersonne_fkey";
ALTER TABLE syntaxa.st_collaborateur ADD CONSTRAINT "idPersonne_fkey" FOREIGN KEY ("idPersonne")
REFERENCES syntaxa.st_annuaire_personnes ("idPersonne") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --



-- object: "idOrganisme_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_collaborateur DROP CONSTRAINT "idOrganisme_fkey";
ALTER TABLE syntaxa.st_collaborateur ADD CONSTRAINT "idOrganisme_fkey" FOREIGN KEY ("idOrganisme")
REFERENCES syntaxa.st_annuaire_organismes ("idOrganisme") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --


-- object: "acronymeOrganisme_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_collaborateur DROP CONSTRAINT "acronymeOrganisme_fkey";
CREATE UNIQUE INDEX acronymeOrganisme_uniq ON syntaxa.st_annuaire_organismes("acronymeOrganisme");
ALTER TABLE syntaxa.st_collaborateur ADD CONSTRAINT "acronymeOrganisme_fkey" FOREIGN KEY ("acronymeOrganisme")
REFERENCES syntaxa.st_annuaire_organismes ("acronymeOrganisme") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --


-- object: "idCatalogue_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_collaborateur DROP CONSTRAINT "idCatalogue_fkey";
ALTER TABLE syntaxa.st_collaborateur ADD CONSTRAINT "idCatalogue_fkey" FOREIGN KEY ("identifiantCatalogue")
REFERENCES syntaxa.st_catalogue_description ("identifiantCatalogue") MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --


-- object: "codeEunis_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_eunis DROP CONSTRAINT "codeEunis_fkey";
ALTER TABLE syntaxa.st_correspondance_eunis ADD CONSTRAINT "codeEunis_fkey" FOREIGN KEY ("codeEUNIS")
REFERENCES syntaxa.st_ref_eunis ("codeEUNIS") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --




-- object: "codeEnregistrement_fkey" | type: CONSTRAINT --
-- ALTER TABLE syntaxa.st_correspondance_eunis DROP CONSTRAINT "codeEnregistrement_fkey";
ALTER TABLE syntaxa.st_correspondance_eunis ADD CONSTRAINT "codeEnregistrement_fkey" FOREIGN KEY ("codeEnregistrement")
REFERENCES syntaxa.st_syntaxon ("codeEnregistrementSyntax") MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



