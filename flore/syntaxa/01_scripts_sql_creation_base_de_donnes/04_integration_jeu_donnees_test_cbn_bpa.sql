
-----------------------------------------------------------------------------CREATION DES TABLES TEMPORAIRES--------------------------------------------------------

--------------------------------------------------------------------------CREATION DES TABLES-----------------------------------------------------------------
-- object: syntaxa.temp_st_catalogue_description | type: TABLE --
/*
DROP TABLE IF EXISTS syntaxa.temp_st_catalogue_description cascade;
CREATE TABLE syntaxa.temp_st_catalogue_description("identifiantCatalogue" character varying,"libelleCatalogue" character varying,
	"versionCatalogue" character varying,"typeCatalogue" character varying,"dateCreationCatalogue" character varying,"dateMiseAJourCatalogue" character varying,"idCollaborateurCatalogue" character varying,"idTerritoireCatalogue" character varying,"codeTypeTerritoireCatalogue" character varying,
	"codeTerritoireCatalogue" character varying,"libelleTerritoireCatalogue" character varying,"empriseTerritoireCatalogue" character varying ,"remarqueTerritoireCatalogue" character varying);

-- object: syntaxa.temp_st_serie_petitegeoserie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_serie_petitegeoserie cascade;
CREATE TABLE syntaxa.temp_st_serie_petitegeoserie("idCatalogue" character varying,"codeEnregistrementSerieGeoserie" character varying,"idSerieGeoserie" character varying,"nomSerieGeoserie" character varying,"auteurSerieGeoserie" character varying,
	"nomCompletSerieGeoserie" character varying,"remarqueNomenclaturale" character varying,"typeSynonymie" character varying,"idSerieGeoserieRetenu" character varying,"nomSerieGeoserieRetenu" character varying,"nomSerieGeoserieRaccourci" character varying,
	"idSerieGeoserieSup" character varying,"codeTypeSerieGeoserie" character varying,"codeCategorieSerieGeoserie" character varying,"codeRangSerieGeoserie" character varying,"nomFrancaisSerieGeoserie" character varying,"diagnoseCourteSerieGeoserie" character varying,
	confusion character varying,"confusionRemarque" character varying,"repartitionGenerale" character varying,"repartitionTerritoire" character varying,"aireMinimale" character varying,"typePhysionomique" character varying,"lithologiePedologieHumus" character varying,geomorphologie character varying,
	"humiditePrincipale" character varying,"humiditeSecondaire" character varying,"phPrincipal" character varying,"phSecondaire" character varying,exposition character varying,"descriptionEcologie" character varying,"remarqueVariabilite" character varying,"remarqueRarete" character varying,
	"etatConservation" character varying);

-- object: syntaxa.temp_st_geo_sigmafacies | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_geo_sigmafacies cascade;
CREATE TABLE syntaxa.temp_st_geo_sigmafacies("idGeosigmafacies" character varying,"codeEnregistrementSerieGeoserie" character varying,"codeFacies" character varying,"libelleGeoSigmafacies" character varying,dominance character varying,usage character varying,"remarqueVariabilite" character varying);


-- object: syntaxa.st_cortege_syntaxonomique | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_cortege_syntaxonomique cascade;
CREATE TABLE syntaxa.temp_st_cortege_syntaxonomique("codeEnregistrementCortegeSyntax" character varying,"idGeosigmafacies" character varying,"libelleGeoSigmafacies" character varying,"codeEnregistrementSyntax" character varying,"idSyntaxonRetenu" character varying,
	"nomSyntaxonRetenu" character varying,"rqSyntaxon" character varying,"pourcentageTheoriqSyntax" character varying,"codeTeteSerie" character varying);


-- object: syntaxa.temp_st_indicateurs_floristiques | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_indicateurs_floristiques cascade;
CREATE TABLE syntaxa.temp_st_indicateurs_floristiques("idIndicateurFlor" character varying,"idGeosigmafacies" character varying,"idRattachementReferentiel" character varying);


-- object: syntaxa.temp_st_syntaxon | type: TABLE 
DROP TABLE IF EXISTS syntaxa.temp_st_syntaxon;
CREATE TABLE syntaxa.temp_st_syntaxon("idCatalogue" character varying,"codeEnregistrementSyntax" character varying,"idSyntaxon" character varying,"nomSyntaxon" character varying,"auteurSyntaxon" character varying,"nomCompletSyntaxon" character varying,"rqNomenclaturale" character varying,"typeSynonymie" character varying,"idSyntaxonRetenu" character varying,"nomSyntaxonRetenu" character varying,"nomSyntaxonRaccourci" character varying,"rangSyntaxon" character varying,"idSyntaxonSup" character varying,
"nomFrancaisSyntaxon" character varying,"diagnoseCourteSyntaxon" character varying,"idCritique" character varying,"rqCritique" character varying,"repartitionGenerale" character varying,"repartitionTerritoire" character varying,"periodeDebObsOptimale" character varying,
"periodeFinObsOptimale" character varying,"rqPhenologie" character varying,"aireMinimale" character varying,"typeBiologiqueDom" character varying,"typePhysionomique" character varying,"rqPhysionomie" character varying,"humiditePrincipale" character varying,"humiditeSecondaire" character varying,
"phPrincipal" character varying,"phSecondaire" character varying,trophie character varying,temperature character varying,luminosite character varying,exposition character varying,salinite character varying,neige character varying,continentalite character varying,ombroclimat character varying,climat character varying,"descriptionEcologie" character varying,"remarqueVariabilite" character varying);
	
	
-- object: syntaxa.temp_st_suivi_enregistrement | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_suivi_enregistrement cascade;
CREATE TABLE syntaxa.temp_st_suivi_enregistrement("idSuivi" character varying,"codeEnregistrement" character varying,"dateSuivi" character varying,"idAuteurSuivi" character varying,"prenomAuteurSuivi" character varying,"nomAuteurSuivi" character varying,"actionSuivi" character varying);

-- object: syntaxa.temp_st_chorologie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_chorologie cascade;
CREATE TABLE syntaxa.temp_st_chorologie("idChorologie" character varying,"codeEnregistrement" character varying,"statutChorologie" character varying,"idTerritoire" character varying);


-- object: syntaxa.st_correspondance_pvf | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_correspondance_pvf cascade;
CREATE TABLE syntaxa.temp_st_correspondance_pvf("idCorrespondancePVF" character varying,"idRattachementPVF" character varying,"codeEnregistrementSyntaxon" character varying,"codeReferentiel" character varying,"versionReferentiel" character varying,"identifiantSyntaxonRetenu" character varying,"nomSyntaxonRetenu" character varying, "identifiantSyntaxonOrigine" character varying);

-- object: syntaxa.temp_st_geomorphologie | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_geomorphologie cascade;
CREATE TABLE syntaxa.temp_st_geomorphologie("idVegGeomorpho" character varying,"codeEnregistrement" character varying,"idGeomorphologie" character varying,"libGeomorphologie" character varying);


-- object: syntaxa.st_cortege_floristique | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_cortege_floristique cascade;
CREATE TABLE syntaxa.temp_st_cortege_floristique("idCortegeFloristique" character varying,"codeEnregistrementSyntaxon" character varying,"idRattachementReferentiel" character varying,"typeTaxon" character varying);


-- object: syntaxa.temp_st_correspondance_hic | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_correspondance_hic cascade;
CREATE TABLE syntaxa.temp_st_correspondance_hic("idCorresHIC" character varying,"codeEnregistrement" character varying,"typeEnregistrement" character varying,"codeHIC" character varying,"libHIC" character varying,"rqHIC" character varying);



-- object: syntaxa.st_etage_veg | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_etage_veg cascade;
CREATE TABLE syntaxa.temp_st_etage_veg("idCorresEtageveg" character varying,"codeEnregistrement" character varying,"codeEtageVeg" character varying,"libEtageVeg" character varying);


-- object: syntaxa.st_etage_bioclim | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_etage_bioclim cascade;
CREATE TABLE syntaxa.temp_st_etage_bioclim("idCorresEtageBioclim" character varying,"codeEnregistrement" character varying,"codeEtageBioclim" character varying,"libEtageBioclim" character varying);



-- object: syntaxa.temp_st_biblio | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_biblio cascade;
CREATE TABLE syntaxa.temp_st_biblio("idBiblio" character varying,"codeEnregistrement" character varying,"libPublication" character varying,"urlPublication" character varying,"codePublication" character varying);


-- ddl-end --
-- object: syntaxa.temp_st_annuaire_organismes | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_annuaire_organismes cascade;
CREATE TABLE syntaxa.temp_st_annuaire_organismes("idOrganisme" character varying,"acronymeOrganisme" character varying,"libOrganisme" character varying);


-- object: syntaxa.temp_st_annuaire_personnes | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_annuaire_personnes cascade;
CREATE TABLE syntaxa.temp_st_annuaire_personnes("idPersonne" character varying,prenom character varying,nom character varying);


-- object: syntaxa.temp_st_collaborateur | type: TABLE --
DROP TABLE IF EXISTS syntaxa.temp_st_collaborateur cascade;
CREATE TABLE syntaxa.temp_st_collaborateur("idCollaborateur" character varying,"identifiantCatalogue" character varying,"idOrganisme" character varying,"acronymeOrganisme" character varying,"idPersonne" character varying, prenom character varying, nom character varying);
*/

------------------------------------------------------------------------------REMPLISSAGE DES TABLES-----------------------------------------------------------------

-----retrouver le nom de toutes les tables du schema

/*SELECT c.oid, n.nspname, c.relname AS table_name, CASE WHEN obj_description(c.oid, 'pg_class') is null THEN 'pas de description disponible' ELSE obj_description(c.oid, 'pg_class') END AS description
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = ANY(CASE WHEN n.nspname = 'dgi' OR n.nspname = 'public' THEN array['r'] ELSE array['r','v'] END)
AND c.relname NOT LIKE 'geometry%'
AND c.relname NOT LIKE 'cg_34%'
AND c.relname NOT LIKE 'temp_%'
AND c.relname NOT LIKE '%life%'
AND c.relname NOT LIKE 'cel_%'
AND c.relname NOT LIKE '%a_integrer'
AND c.relname <> 'views'
AND c.relname <> 'fsd_syntaxa'
AND n.nspname NOT IN ('information_schema','nature_sdi','pg_catalog','temp', 'ambroisie', 'public', 'observation', 'exploitation', 'exploitation_veg', 'observation_reunion','observation_veg','syntaxa_regional','bilan', 'bilan_carto', 'corrections','rattachement', 'taxref','topology','taxa', 'refnat', 'eee', 'lsi', 'catnat', 'lr', 'applications', 'referentiels')

--pour avoir le taxa on rajoute ça
/*union

SELECT c.oid, n.nspname, c.relname AS table_name, CASE WHEN obj_description(c.oid, 'pg_class') is null THEN 'pas de description disponible' ELSE obj_description(c.oid, 'pg_class') END AS description
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = ANY(CASE WHEN n.nspname = 'dgi' OR n.nspname = 'public' THEN array['r'] ELSE array['r','v'] END)
AND c.relname NOT LIKE 'geometry%'
AND c.relname NOT LIKE 'cg_34%'
AND c.relname NOT LIKE 'temp_%'
AND c.relname NOT LIKE '%life%'
AND c.relname NOT LIKE 'cel_%'
AND c.relname NOT LIKE '%a_integrer'
AND c.relname <> 'views'
AND n.nspname IN ('taxa')
and c.relname LIKE('referentiel_taxo%')
or c.relname LIKE('liste_geo%')

order by table_name asc;*/

-------------------------------------------------------------------------------------------
--CREATION D'UNE TABLE QUI DETAILLE LE FSD ET QUI VA REMPLIR LES TABLES TEMPORAIRES
----------------------------------------------------------------------------------------------

------CREATION TABLE FSD SYNTAXA

drop table if exists syntaxa.fsd_syntaxa;
CREATE TABLE syntaxa.fsd_syntaxa
(
  id serial NOT NULL,
  --tbl_order integer,
  tbl_name character varying,
  commentaire_tbl character varying,
  pos character varying,
  cd character varying,
  type_cd character varying,
  commentaire_colonne character varying,
  --lib character varying,
  --obligation character varying,
  --unicite character varying,
  --regle character varying,
  --commentaire_cbn character varying,
  CONSTRAINT fsd_data_pkey PRIMARY KEY (id)
)WITH (  OIDS=FALSE);
ALTER TABLE syntaxa.fsd_syntaxa  OWNER TO postgres;
GRANT ALL ON TABLE syntaxa.fsd_syntaxa TO postgres;


---ALIMENTATION TABLE FSD SYNTAXA


CREATE OR REPLACE FUNCTION creation_fsd(libSchema varchar) RETURNS integer AS 
$BODY$ DECLARE libTable varchar; DECLARE oid integer; BEGIN
--- Commande
EXECUTE 'truncate table "'||libSchema||'".fsd_'||libSchema||';';
	FOR oid, libTable in EXECUTE 
	'SELECT c.oid, c.relname AS table_name
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = ANY(CASE WHEN n.nspname = ''dgi'' OR n.nspname = ''public'' THEN array[''r''] ELSE array[''r'',''v''] END)
AND c.relname NOT LIKE ''geometry%''
AND c.relname NOT LIKE ''cg_34%''
AND c.relname NOT LIKE ''temp_%''
AND c.relname NOT LIKE ''%life%''
AND c.relname NOT LIKE ''cel_%''
AND c.relname NOT LIKE ''%a_integrer''
AND c.relname <> ''views''
AND c.relname <> ''fsd_syntaxa''
AND n.nspname IN (''syntaxa'');'

		LOOP 
		EXECUTE ' insert into "'||libSchema||'".fsd_'||libSchema||' (tbl_name,commentaire_tbl, pos, cd, type_cd, commentaire_colonne)
SELECT 
sub.table_name as nom_table, 
mtd_liste_table.commentaire_tbl,
sub.ordinal_position AS ordre,
sub.nom_colonne,
sub."type" AS "type",
CASE WHEN col_description(oid, ordinal_position) is null THEN '''' ELSE col_description(oid, ordinal_position) END as description
		FROM 	(
					SELECT
						columns.table_name AS table_name,
						columns.column_name AS nom_colonne,
						columns.data_type::text AS "type",
						columns.is_nullable,
						columns.ordinal_position
					FROM information_schema.columns
					ORDER BY columns.ordinal_position
				) sub
--		LEFT JOIN
--				(

--select * from geometry_columns;
--select oid from pg_class where relname="'||libTable||'";
--					SELECT
--						geometry_columns.f_geometry_column
--					FROM geometry_columns
--		WHERE geometry_columns.f_table_name::text = '''||libTable||'''::text
--				) sub2
--		ON sub.nom_colonne::text = sub2.f_geometry_column::text
		JOIN (SELECT c.relname AS table_name, n.nspname, c.oid, obj_description(c.oid, ''pg_class'') as commentaire_tbl 
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  ORDER BY c.relname) as mtd_liste_table USING(table_name)
   WHERE oid::text = '''||oid||'''
  ORDER BY sub.ordinal_position;
		
		
		';  
		END LOOP;

RETURN 1; END; $BODY$  LANGUAGE plpgsql;



select * from creation_fsd ('syntaxa');


select * from syntaxa.fsd_syntaxa;

------------------------------------------------------------------------------------------
---CREATION DE LA FONCTION DE REMPLISSAGE DES TABLES TEMPORAIRES A PARTIR DE FICHIERS CSV
-------------------------------------------------------------------------------------------

--creation des tables permanentes
DROP FUNCTION IF EXISTS hub_import(libSchema varchar, jdd varchar, path varchar);

CREATE OR REPLACE FUNCTION hub_import(libSchema varchar, jdd varchar, path varchar) RETURNS integer AS 
$BODY$ DECLARE libTable varchar; DECLARE i varchar; BEGIN
--- Commande
CASE WHEN jdd = 'syntaxa' THEN 
	FOR libTable in EXECUTE 'SELECT DISTINCT tbl_name FROM syntaxa.fsd_'||jdd||' where tbl_name in (''st_annuaire_organismes'',''st_annuaire_personnes'', ''st_catalogue_description'', ''st_collaborateur'', ''st_correspondance_pvf'', ''st_cortege_syntaxonomique'', ''st_geo_sigmafacies'', ''st_serie_petitegeoserie'' , ''st_suivi_enregistrement'', ''st_syntaxon'');'
		LOOP 
		EXECUTE 'TRUNCATE "'||libSchema||'".temp_'||libTable||'';
		EXECUTE 'COPY "'||libSchema||'".temp_'||libTable||' FROM '''||path||'std_'||libTable||'.csv'' HEADER CSV DELIMITER '';'' ENCODING ''UTF8'';';  
		END LOOP;
END CASE;

RETURN 1; END; $BODY$  LANGUAGE plpgsql;


select * from hub_import('syntaxa','syntaxa', 'F:\02_jeu_donnees_test_cbn_bpa/');

select * from syntaxa.temp_st_syntaxon;




--------------------------------------------------------------------------
--remplissage des nomSyntaxonRetenu
-------------------------------------------------------------------------
update syntaxa.temp_st_syntaxon set "nomSyntaxonRetenu"= foo."nomSyntaxonRetenu" from 
	(        select s1.*, s2."nomCompletSyntaxon" as "nomSyntaxonRetenu"
	from (select "idSyntaxon", "nomCompletSyntaxon", "idSyntaxonRetenu" from syntaxa.temp_st_syntaxon) as s1
	left outer join
	(select "idSyntaxon", "nomCompletSyntaxon", "idSyntaxonRetenu" from syntaxa.temp_st_syntaxon) as s2
	on 
	s1."idSyntaxonRetenu"=s2."idSyntaxon") as foo
	
 where temp_st_syntaxon."idSyntaxon"=foo."idSyntaxon";

--------------------------------------------------------------------------
---ALIMENTATION DES TABLES PERMANENTES A PARTIR DES TABLES TEMPORAIRES
-------------------------------------------------------------------------

--  CREATION FONCTION




CREATE OR REPLACE FUNCTION hub_add(libSchema varchar, jdd varchar, in_array text[]) RETURNS int AS
$BODY$ 
DECLARE libTable varchar;DECLARE x text[]; DECLARE listeChamp1 varchar; DECLARE listeChamp2 varchar; DECLARE i varchar; 
BEGIN
--- Commande
CASE WHEN jdd = 'syntaxa' THEN 
	FOREACH libTable in  array in_array
	--EXECUTE 'SELECT DISTINCT tbl_name FROM syntaxa.fsd_'||jdd||' where tbl_name in ( ''st_serie_petitegeoserie'' );'
		LOOP 
		--EXECUTE 'TRUNCATE "'||libSchema||'".'||libTable||' CASCADE';
		EXECUTE 'SELECT string_agg(''"''||column_name||''"::''||data_type,'','')  FROM information_schema.columns where table_name = '''||libTable||''' AND table_schema = '''||libSchema||''' and column_name <>''id_tri'' and column_name <>''uid'' ' INTO listeChamp1;
		EXECUTE 'SELECT string_agg(''"''||column_name||''"'','','')  FROM information_schema.columns where table_name = '''||libTable||''' AND table_schema = '''||libSchema||''' and column_name <>''id_tri'' and column_name <>''uid'' ' INTO listeChamp2;
		EXECUTE 'INSERT INTO "'||libSchema||'"."'||libTable||'" ('||listeChamp2||') SELECT '||listeChamp1||' FROM "'||libSchema||'"."temp_'||libTable||'" z ';
		END LOOP;
END CASE;

RETURN 1; END; $BODY$  LANGUAGE plpgsql;





---------------------- 
---LANCEMENT FONCTION
----------------------

----REMPLISSAGE DE TOUTES LES TABLES D'UN COUP

select * from hub_add('syntaxa','syntaxa',array['st_catalogue_description','st_syntaxon', 'st_serie_petitegeoserie','st_geo_sigmafacies','st_cortege_syntaxonomique','st_annuaire_personnes', 'st_annuaire_organismes', 'st_suivi_enregistrement', 'st_collaborateur']);
select * from hub_add('syntaxa','syntaxa',array['st_suivi_enregistrement']);
---SINON REMPLISSAGE AU CAS PAR CAS 


--REMPLISSAGE TABLE DE DESCRIPTION DU CATALOGUE
select * from hub_add('syntaxa','syntaxa',array['st_catalogue_description']);
select * from syntaxa.st_catalogue_description;

--REMPLISSAGE TABLE DES SYNTAXONS

select * from hub_add('syntaxa','syntaxa',array['st_syntaxon']);
select * from syntaxa.st_syntaxon;

--REMPLISSAGE TABLE DES SERIES et GEOSERIES

--truncate syntaxa.st_serie_petitegeoserie cascade;
--select * from hub_add('syntaxa','syntaxa',array['st_serie_petitegeoserie']);


insert into syntaxa.st_serie_petitegeoserie("idCatalogue" ,"codeEnregistrementSerieGeoserie" ,"idSerieGeoserie" ,"nomSerieGeoserie" ,"auteurSerieGeoserie" ,"nomCompletSerieGeoserie" ,
"remarqueNomenclaturale" ,"typeSynonymie" ,"idSerieGeoserieRetenu" ,"nomSerieGeoserieRetenu" ,"nomSerieGeoserieRaccourci" ,"idSerieGeoserieSup" ,"codeTypeSerieGeoserie" ,
"codeCategorieSerieGeoserie" ,"codeRangSerieGeoserie" ,"nomFrancaisSerieGeoserie" ,"diagnoseCourteSerieGeoserie" ,confusion ,"confusionRemarque" ,"repartitionGenerale" ,"repartitionTerritoire" ,
"aireMinimale" ,"typePhysionomique" ,"lithologiePedologieHumus" ,geomorphologie ,"humiditePrincipale" ,"humiditeSecondaire" ,"phPrincipal" ,"phSecondaire" ,
exposition ,"descriptionEcologie" ,"remarqueVariabilite","remarqueRarete" ,"etatConservation")
select 
'SYNTAXA_REG_CENTRE_1' as "idCatalogue",
"codeEnregistrementSerieGeoserie" ,
"idSerieGeoserie",
"nomSerieGeoserie",
"auteurSerieGeoserie",
"nomSerieGeoserie" as "nomCompletSerieGeoserie",
'' as "remarqueNomenclaturale",
'' as "typeSynonymie",
'idSerieGeoserie' as "idSerieGeoserieRetenu",
'' as "nomSerieGeoserieRetenu" ,
'' as "nomSerieGeoserieRaccourci" ,
'' as "idSerieGeoserieSup" ,
case when "codeTypeSerieGeoserie"='série' then 'S' when "codeTypeSerieGeoserie"='géosérie' then 'GS' when "codeTypeSerieGeoserie"='curtasérie' then 'CS' when "codeTypeSerieGeoserie"='géopermasérie' then 'GS' else "codeTypeSerieGeoserie" end as "codeTypeSerieGeoserie",
case when "codeCategorieSerieGeoserie"='climatophile' then 'CLI' when "codeCategorieSerieGeoserie"='édaphoxérophile' then 'EDAX' when "codeCategorieSerieGeoserie"='temporhygrophile' or "codeCategorieSerieGeoserie"='topoaérohygrophile' then 'TEMH' when "codeCategorieSerieGeoserie"='édaphohygrophile' then 'EDAH'else "codeCategorieSerieGeoserie" end as "codeCategorieSerieGeoserie",
'NI' as "codeRangSerieGeoserie" ,
"nomFrancaisSerieGeoserie" ,
"diagnoseCourteSerieGeoserie" ,
'' as confusion ,
'' as "confusionRemarque" ,
"repartitionGenerale" ,
"repartitionTerritoire" ,
0 as "aireMinimale" ,
'' as "typePhysionomique" ,
"lithologiePedologieHumus" as "lithologiePedologieHumus" ,
geomorphologie ,
"humiditePrincipale" ,
"humiditeSecondaire"  ,
"phPrincipal" , 
"phSecondaire" , 
case when exposition ='Aucune' then 'aucune' when exposition ='variable' then 'var' when exposition ='Dominante sud' then 'DS' when exposition ='ouest, est et sud' then 'OES' when exposition ='Dominante sud, parfois au nord' then 'DSN' when exposition ='nord' or exposition='nord ' then 'N' else "exposition" end as exposition ,
"descriptionEcologie" ,
"remarqueVariabilite" ,
"remarqueRarete" ,
"etatConservation"
 from syntaxa.temp_st_serie_petitegeoserie;
 

--REMPLISSAGE TABLE DES SIGMAFACIES
--select * from hub_add('syntaxa','syntaxa',array['st_geo_sigmafacies']);

--truncate syntaxa.st_geo_sigmafacies cascade
--select * from hub_add('syntaxa','syntaxa',array['st_geo_sigmafacies']);

insert into syntaxa.st_geo_sigmafacies
( "idGeosigmafacies", "codeEnregistrementSerieGeoserie" , "codeFacies" , "libelleGeoSigmafacies",  "usage", "dominance","remarqueVariabilite")
select 
"idGeosigmafacies", 
"codeEnregistrementSerieGeoserie", 
case when "codeFacies" ='Aquatique' then 'AQUA' 
when "codeFacies" ='Chaméphytique' then 'CHAM' 
when "codeFacies" ='Complexe de recolonisation' then 'RCOL' 
when "codeFacies" ='Cultural' then 'C' 
when "codeFacies" ='Cultural - agriculture' then 'CAGR' 
when "codeFacies" ='Cultural - ligniculture' then 'CLIG' 
when "codeFacies" ='Forestier' or "codeFacies" ='forestier' then 'FOR' 
when "codeFacies" ='Forestier mâture' then 'FORM' 
when "codeFacies" ='Forestier pionnier' then 'FORP' 
when "codeFacies" ='Herbacé haut' then 'HERB' 
when "codeFacies" ='Minéral peu végétalisé' then 'MINV' 
when "codeFacies" ='Pelousaire' then 'PELO' 
when "codeFacies" ='Prairial' then 'P' 
when "codeFacies" ='Prairial gras' then 'PG' 
when "codeFacies" ='Prairial maigre' then 'PM' 
when "codeFacies" ='Tourbière' then 'TOUR'
else "codeFacies"
end as "codeFacies" , 
"libelleGeoSigmafacies",  
dominance,
usage,
"remarqueVariabilite"
 from syntaxa.temp_st_geo_sigmafacies sf;
 
 select * from syntaxa.temp_st_geo_sigmafacies 
 --select * from syntaxa.st_geo_sigmafacies order by "codeEnregistrementSerieGeoserie" asc, "idGeosigmafacies" asc , "codeFacies" asc;
 
 
 --REMPLISSAGE TABLE COMPOSYNTAXONOMIQUE

insert into syntaxa.st_cortege_syntaxonomique ("codeEnregistrementCortegeSyntax" , "idGeosigmafacies" ,  "libelleGeoSigmafacies" ,  "codeEnregistrementSyntax" ,  "idSyntaxonRetenu" ,  "nomSyntaxonRetenu",  "rqSyntaxon" ,  "pourcentageTheoriqSyntax",  "codeTeteSerie" )
select
'CBNBPA_cortegesyntax_'||row_number()over(order by "idGeosigmafacies" asc) as "codeEnregistrementCortegeSyntax",
"idGeosigmafacies",
(select "libelleGeoSigmafacies" from syntaxa.st_geo_sigmafacies where "idGeosigmafacies"=cs."idGeosigmafacies") as "libelleGeoSigmafacies" ,
s."codeEnregistrementSyntax" ,
cs."idSyntaxonRetenu" ,
cs."nomSyntaxonRetenu" ,
"rqSyntaxon",
0 as "pourcentageTheoriqSyntax" ,
case when "codeTeteSerie"='nc' then 'NI' else "codeTeteSerie" end as "codeTeteSerie"
from  syntaxa.temp_st_cortege_syntaxonomique cs inner join syntaxa.st_syntaxon s on (cs."nomSyntaxonRetenu"=s."nomSyntaxonRetenu")
where "idGeosigmafacies" <> '#N/A';


/*
il reste ces colonnes du modèle CBN BPA a intégrer...
	"nomSerieGeoserie" text,

	"libelleFacies" text,
	"recSyntaxon" text,
	"caracteristique" text,

);
*/


 --REMPLISSAGE TABLES ANNUAIRES,  SUIVI ENREGISTREMENT
 
select * from hub_add('syntaxa','syntaxa',array['st_annuaire_personnes', 'st_annuaire_organismes', 'st_suivi_enregistrement', 'st_collaborateur']);


 --REMPLISSAGE TABLE CHOROLOGIE (pas terminé, voir ce qu'on fait de la répartition territoire)
insert into syntaxa.st_chorologie(
"idChorologie" ,
"codeEnregistrement" ,
"statutChorologie" ,
"idTerritoire" ,
"choroTypeTerritoire" ,
"choroCodeTerritoire" ,
"choroLibTerritoire" ,
"repartitionTerritoire" 
)
select * from 

(select

row_number()over(order by "codeEnregistrement" asc) as "idChorologie" ,
	"codeEnregistrement" ,
	"statutChorologie" ,
	"idTerritoire" ,
	"choroTypeTerritoire" ,
	"choroCodeTerritoire" ,
	"choroLibTerritoire" ,
	"repartitionTerritoire" 
from syntaxa.st_syntaxon
)
union
(select

row_number()over(order by "codeEnregistrement" asc) as "idChorologie" ,
	"codeEnregistrement" ,
	"statutChorologie" ,
	"idTerritoire" ,
	"choroTypeTerritoire" ,
	"choroCodeTerritoire" ,
	"choroLibTerritoire" ,
	"repartitionTerritoire" 
from syntaxa.st_serie_petitegeoserie
) as foo


;


------------------------------------MISE A JOUR MARS 2016-------------------------------------------------

drop table if exists public.facies_envoi_cbnbpa_mars_2016;
CREATE TABLE public.facies_envoi_cbnbpa_mars_2016
(
  id_facies character varying,
  id_serie character varying,
  nom_facies character varying,
  num_type_facies character varying,
  type_facies character varying,
  codeFacies character varying
)WITH (  OIDS=FALSE);
ALTER TABLE public.facies_envoi_cbnbpa_mars_2016  OWNER TO postgres;
GRANT ALL ON TABLE public.facies_envoi_cbnbpa_mars_2016 TO postgres;


copy public.facies_envoi_cbnbpa_mars_2016 from 'D:\jeu_donnees_test_cbn_bpa\facies_envoi_mars_2016.csv' CSV HEADER encoding 'LATIN1' DELIMITER E';'  ;


drop table if exists public.serie_geoserie_envoi_cbnbpa_mars_2016;
CREATE TABLE public.serie_geoserie_envoi_cbnbpa_mars_2016
(
  id_serie character varying,
  id_serie_ref character varying,
  num_type_serie character varying,
  lib_type_serie character varying,
  code_type_serie character varying,
  nom_serie character varying,
  id_serie2 character varying

)WITH (  OIDS=FALSE);
ALTER TABLE public.serie_geoserie_envoi_cbnbpa_mars_2016  OWNER TO postgres;
GRANT ALL ON TABLE public.serie_geoserie_envoi_cbnbpa_mars_2016 TO postgres;


copy public.serie_geoserie_envoi_cbnbpa_mars_2016 from 'D:\jeu_donnees_test_cbn_bpa\serie_geoserie_envoi_mars_2016.csv' CSV HEADER encoding 'LATIN1' DELIMITER E';'  ;




----jointure des données envoyées précédemment et des données actuelles

select a.*, b.nom_serie from st_serie_petitegeoserie a left outer join public.serie_geoserie_envoi_cbnbpa_mars_2016 b on a."nomCompletSerieGeoserie"=b.nom_serie; 

