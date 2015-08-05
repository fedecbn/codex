<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/constants.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");

require_once ("../../_INCLUDE/common.lang.php");
require_once ("../commun/module.lang.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "catnat";
$id_page_2 = "droit";
$title = $lang['fr']['titre_web']." - ".$id_page;


$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

if (ON_Server == 'no') $path = 'D:/'; else $path = '/home/export_pgsql/';

$query_module = "
	SELECT * FROM catnat.taxons_nat t
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.catnat = TRUE AND t.uid=";

$query_liste = "
	SELECT count(*) OVER() AS total_count, taxons_nat.cd_ref , taxons_nat.famille, taxons_nat.nom_sci, taxons_nat.nom_vern, 
	CASE taxons_nat.hybride WHEN true THEN 'oui' WHEN false THEN 'non' ELSE '' END as hybride, 
	taxons_nat.cd_rang, statut_nat.indi, statut_nat.lr, statut_nat.just_lr, statut_nat.rarete, 
	CASE statut_nat.endemisme WHEN true THEN 'oui' WHEN false THEN 'non' ELSE '' END as endemisme, taxons_nat.uid
	FROM catnat.taxons_nat
	LEFT JOIN catnat.statut_nat ON taxons_nat.uid = statut_nat.uid
	JOIN refnat.taxons a ON a.uid = taxons_nat.uid 
	WHERE a.catnat = TRUE ";

$query_export = "
	SELECT * FROM catnat.taxons_nat t
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.catnat = TRUE ";

$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";

$query_discussion = "
	SELECT prenom||' '||nom||' ('||cd_cbn||') le '||to_char(datetime, 'dd/MM/YYYY')||' à '||to_char(datetime, 'HH24')||'h'||to_char(datetime, 'MI'), commentaire_eval 
	FROM catnat.discussion a JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn 
	WHERE uid = ";

/*Import du taxa dans outil evaluation*/
$recup_taxa = "
------------------------------------------------------------------------------------------
--- Récupération du TAXA(si_flore_national_v3)
------------------------------------------------------------------------------------------
--- NB : le HAVING count(*) > 1 permet de supprimer les doublons liés au rattachement à TAXREF (id_taxa_fcbn différent MAIS cd_ref identique!!)
COPY (SELECT cd_ref_referentiel, type_statut, code_statut, libelle_statut, code_territoire, libelle_territoire
FROM taxa.statuts a
JOIN taxa.liste_statuts z ON a.id_statut = z.id_statut
JOIN taxa.taxon_taxa e ON e.id_taxa_fcbn = a.id_taxa_fcbn
JOIN taxa.coor_taxon_reftaxo q ON e.id_taxa_fcbn = q.id_taxa_fcbn
JOIN taxa.referentiel_taxo s ON s.id_rattachement_referentiel = q.id_rattachement_referentiel
JOIN taxa.liste_geo d ON d.id_territoire=a.id_territoire
WHERE code_type_territoire = 'REG' AND s.cd_ref_referentiel NOT IN 
	(
	SELECT cd_ref_referentiel
	FROM taxa.statuts a
	JOIN taxa.liste_statuts z ON a.id_statut = z.id_statut
	JOIN taxa.taxon_taxa e ON e.id_taxa_fcbn = a.id_taxa_fcbn
	JOIN taxa.coor_taxon_reftaxo q ON e.id_taxa_fcbn = q.id_taxa_fcbn
	JOIN taxa.referentiel_taxo s ON s.id_rattachement_referentiel = q.id_rattachement_referentiel
	JOIN taxa.liste_geo d ON d.id_territoire=a.id_territoire
	WHERE code_type_territoire = 'REG' AND cd_ref_referentiel IS NOT NULL 
	GROUP BY cd_ref_referentiel, type_statut, code_territoire
	HAVING count(*) > 1
	)
GROUP BY cd_ref_referentiel, type_statut, code_statut, libelle_statut, code_territoire, libelle_territoire
ORDER BY cd_ref_referentiel)
 TO '".$path."taxa_statut.csv' WITH csv HEADER DELIMITER ';';
";
	
/*mise à jour du catalogue régional et national calculé à partir du taxa*/
$import_taxa = "
--- Import dans outil d'évaluation
---- CHANGER DE BDD !!!
DROP TABLE IF EXISTS codex_taxa;
CREATE TABLE codex_taxa
(cd_ref_referentiel integer, type_statut character varying, code_statut character varying, libelle_statut character varying, code_territoire character varying, libelle_territoire character varying,CONSTRAINT codex_taxa_pkey PRIMARY KEY (cd_ref_referentiel,type_statut,code_territoire)) WITH (OIDS=FALSE);
ALTER TABLE codex_taxa  OWNER TO postgres;
COPY codex_taxa FROM '".$path."taxa_statut.csv' WITH csv HEADER DELIMITER ';';
";

$maj_from_taxa = "
------------------------------------------------------------------------------------------
--- Mise à jour des statuts REGIONAL (catnat.statut_reg)
--- AJOUT des nouveaux statuts
INSERT INTO catnat.statut_reg
SELECT code_territoire::integer, libelle_territoire,  a.type_statut, code_statut, libelle_statut, uid
	FROM codex_taxa a JOIN refnat.taxons ON cd_ref_referentiel = cd_nom JOIN (
	SELECT cd_ref, id_reg, id_statut, type_statut
		FROM catnat.statut_reg a JOIN refnat.taxons z ON a.uid = z.uid WHERE cd_ref = cd_nom
		) as one ON (one.cd_ref = cd_ref_referentiel AND id_reg = code_territoire::integer AND a.type_statut = one.type_statut) 
	WHERE one.cd_ref IS NULL;
---MISE A JOUR des statuts
UPDATE catnat.statut_reg b SET id_statut = code_statut FROM (
SELECT code_territoire::integer, code_statut, id_statut, uid, a.type_statut
	FROM codex_taxa a JOIN refnat.taxons ON cd_ref_referentiel = cd_nom JOIN (
	SELECT cd_ref, id_reg, id_statut, type_statut
		FROM catnat.statut_reg a JOIN refnat.taxons z ON a.uid = z.uid WHERE cd_ref = cd_nom
	) as one ON (one.cd_ref = cd_ref_referentiel AND id_reg = code_territoire::integer AND a.type_statut = one.type_statut)
	WHERE id_statut <> code_statut) as two
WHERE b.type_statut = two.type_statut AND code_territoire=two.code_territoire AND b.uid = two.uid;

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--- MISE A JOUR DES STATUTS NATIONAUX CALCULÉ
--- Sauvegarde de l'existant
COPY (SELECT * FROM catnat.statut_nat) TO '".$path."codex.statut_nat.csv' WITH csv HEADER DELIMITER ';';

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--- INDIGENAT --- Le statut national calculé est égale à :
---	1. Indigénat si au moins une fois indigène
--- 2. Cryptogène si partout cryptogène
--- 3. Exotique si partout exotique
--- Ajout des colonnes si elles n'existes pas
DO $$ BEGIN ALTER TABLE catnat.statut_nat ADD COLUMN indi_cal character varying;
EXCEPTION WHEN duplicate_column THEN RAISE NOTICE 'column indi_cal already exists in catnat.statut_nat.';
END;$$;
--- INDIGENAT Calculé
UPDATE catnat.statut_nat a SET indi_cal = nom_statut FROM (
	SELECT a.uid, CASE WHEN strpos(string_agg(nom_statut, ', '),'Indigène') <> 0 THEN 'Indigène' ELSE string_agg(nom_statut, ', ') END as nom_statut
	FROM catnat.statut_reg a FULL OUTER JOIN catnat.statut_nat z ON a.uid = z.uid WHERE type_statut = 'INDI' GROUP BY a.uid
	HAVING strpos(string_agg(nom_statut, ', '),'Indigène') <> 0 OR string_agg(nom_statut, ', ') = 'Cryptogène' OR string_agg(nom_statut, ', ') = 'Exotique'
) as one WHERE a.uid = one.uid;

--- INDIGENAT From rubrique LISTE ROUGE remonté dans le catalogue national
DO $$ BEGIN ALTER TABLE catnat.statut_nat ADD COLUMN indi_lr character varying;
EXCEPTION WHEN duplicate_column THEN RAISE NOTICE 'column indi_lr already exists in catnat.statut_nat.';
END;$$;
UPDATE catnat.statut_nat a SET indi_lr = indi_liste_rouge FROM (
	SELECT uid, lib_indi as indi_liste_rouge 
	FROM liste_rouge.taxons a JOIN referentiels.indigenat z ON a.id_indi = z.id_indi WHERE lib_indi <> '' ORDER BY uid ASC
) as one WHERE a.uid = one.uid;

--- 2. Les différences problématique entre régionale et national
--- A envoyer à Johan // Problématique si Expert != Indigène et Calculé = Indigène)
COPY (
	SELECT a.uid, b.cd_ref, b.famille, b.nom_complet, indi as indi_expert, indi_cal as indi_calcule
	FROM catnat.statut_nat a JOIN refnat.taxons b ON a.uid = b.uid WHERE (indi IS NOT NULL OR indi_cal IS NOT NULL) AND (indi <> 'Indigène' AND indi_cal = 'Indigène') ORDER BY b.famille, b.nom_complet ASC
) TO '".$path."codex.pb_indigenat.csv' WITH csv HEADER DELIMITER ';';


------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--- LISTE ROUGE --- Le statut national calculé est égale :
--- au statut régional le moins menacé.
--- Ajout des colonnes si elles n'existes pas
DO $$ BEGIN ALTER TABLE catnat.statut_nat ADD COLUMN lr_cal character varying;
EXCEPTION WHEN duplicate_column THEN RAISE NOTICE 'column lr_cal already exists in catnat.statut_nat.';
END;$$;
--- LISTE ROUGE calculé à partir des valeurs régionales
UPDATE catnat.statut_nat a SET lr_cal = two.lr FROM (
SELECT a.uid, id_statut as lr 
FROM catnat.statut_reg a JOIN referentiels.liste_rouge b ON cd_cat = id_statut JOIN (
	SELECT a.uid, max(id_cat) as cat 
	FROM catnat.statut_reg a JOIN referentiels.liste_rouge b ON cd_cat = id_statut GROUP BY uid
	) as one ON one.uid = a.uid
WHERE type_statut = 'LR' AND b.id_cat = one.cat	GROUP BY a.uid, id_statut
) as two WHERE a.uid = two.uid;

--- LISTE ROUGE From rubrique LISTE ROUGE remonté dans le catalogue national
DO $$ BEGIN ALTER TABLE catnat.statut_nat ADD COLUMN lr_lr character varying;
EXCEPTION WHEN duplicate_column THEN RAISE NOTICE 'column lr_lr already exists in catnat.statut_nat.';
END;$$;
UPDATE catnat.statut_nat a SET lr_lr = cd_cat FROM (
	SELECT uid, cd_cat
	FROM liste_rouge.evaluation a JOIN referentiels.categorie_final z ON a.cat_fin = z.id_cat ORDER BY uid ASC
) as one WHERE a.uid = one.uid;

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--- ENDEMISME --- Le statut national calculé est égale :
--- 1. oui si endemisme régional (au moins un)
--- 2. non si pas endémique dans toute les région
--- Ajout des colonnes si elles n'existes pas
DO $$ BEGIN ALTER TABLE catnat.statut_nat ADD COLUMN endemisme_cal character varying;
EXCEPTION WHEN duplicate_column THEN RAISE NOTICE 'column endemisme_cal already exists in catnat.statut_nat.';
END;$$;
--- ENDEMISME calculé à partir des valeurs régionales
UPDATE catnat.statut_nat a SET endemisme_cal = one.ende FROM (
	SELECT a.uid, CASE WHEN strpos(string_agg(id_statut, ', '),'oui') <> 0 THEN 'oui' ELSE string_agg(id_statut, ', ') END as ende
	FROM catnat.statut_reg a
	WHERE type_statut = 'END' GROUP BY a.uid, id_statut
	HAVING strpos(string_agg(id_statut, ', '),'oui') <> 0 OR string_agg(id_statut, ', ') = 'non'
) as one
WHERE a.uid = one.uid;

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--- PRESENCE --- Le statut national calculé est égale :
--- 1. oui si PRESENCE régional (au moins un)
--- 2. non si pas PRESENCE dans toute les régions
--- Ajout des colonnes si elles n'existes pas
DO $$ BEGIN ALTER TABLE catnat.statut_nat ADD COLUMN presence_cal character varying;
EXCEPTION WHEN duplicate_column THEN RAISE NOTICE 'column presence_cal already exists in catnat.statut_nat.';
END;$$;
--- PRESENCE calculé à partir des valeurs régionales
UPDATE catnat.statut_nat a SET presence_cal = one.pres
FROM (
	SELECT a.uid, CASE WHEN strpos(string_agg(id_statut, ', '),'oui') <> 0 THEN 'oui' ELSE string_agg(id_statut, ', ') END as pres
	FROM catnat.statut_reg a
	WHERE type_statut = 'PRES' GROUP BY a.uid, id_statut
	HAVING strpos(string_agg(id_statut, ', '),'oui') <> 0 OR string_agg(id_statut, ', ') = 'non'
) as one
WHERE a.uid = one.uid;


--- TO DO les autres statuts + javascript pour mettre  à jour catnat
DO $$ BEGIN ALTER TABLE catnat.statut_nat ADD COLUMN rarete_cal character varying;
EXCEPTION WHEN duplicate_column THEN RAISE NOTICE 'column rarete_cal already exists in catnat.statut_nat.';
END;$$;
";

$rang= array(''=>'','ES'=>'ES','SSES'=>'SSES','VAR'=>'VAR','SVAR'=>'SVAR','FO'=>'FO','SSFO'=>'SSFO','CAR'=>'CAR');

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
