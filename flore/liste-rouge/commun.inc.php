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
$id_page = $_SESSION['page'] = "lr";
$id_page_2 = "lr_reg";
$id_rub = "liste_rouge";
$rub[$id_rub] = 'true';

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

$query_module = "
	SELECT t.*,c.*,e.*, f.indi_cal  
	FROM liste_rouge.taxons AS t 
	LEFT JOIN liste_rouge.chorologie AS c ON c.uid=t.uid 
	LEFT JOIN liste_rouge.evaluation AS e ON e.uid=t.uid
	LEFT JOIN catnat.statut_nat AS f ON f.uid = t.uid
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_rub = TRUE AND t.uid=";

	
$query_liste = "
	SELECT count(*) OVER() AS total_count,
	taxons.uid,taxons.famille,taxons.cd_ref,taxons.nom_sci,taxons.id_rang,taxons.id_indi,
	CASE taxons.endemisme WHEN true THEN 'oui' WHEN false THEN 'non' ELSE '' END as endemisme,
	chorologie.aoo4,chorologie.aoo_precis,chorologie.id_aoo,chorologie.nbloc_precis,chorologie.id_nbloc,chorologie.nbm5_post1990_est,chorologie.nbm5_post1990,chorologie.nbm5_post2000,chorologie.nbm5_total,chorologie.nbcommune,
	evaluation.etape,evaluation.cat_a,evaluation.just_a,evaluation.cat_b,evaluation.just_b,evaluation.cat_c,evaluation.just_c,evaluation.cat_d,evaluation.just_d,evaluation.menace,evaluation.cat_fin,evaluation.just_fin,evaluation.cat_euro , evaluation.cat_synt_reg,evaluation.nb_reg_presence,evaluation.nb_reg_evalue,evaluation.notes,
	CASE evaluation.avancement WHEN 1 THEN 'a réaliser' WHEN 2 THEN 'en cours' WHEN 3 THEN 'réalisée' ELSE '' END as avancement
	FROM liste_rouge.taxons
	LEFT JOIN liste_rouge.chorologie ON chorologie.uid=taxons.uid 
	LEFT JOIN liste_rouge.evaluation ON evaluation.uid=taxons.uid  
	LEFT JOIN referentiels.indigenat ON indigenat.id_indi = taxons.id_indi
	JOIN refnat.taxons a ON a.uid = taxons.uid 
	WHERE a.$id_rub = TRUE ";

$query_export = "
SELECT *
	FROM liste_rouge.taxons AS t  
	LEFT JOIN liste_rouge.chorologie AS c ON c.uid=t.uid 
	LEFT JOIN liste_rouge.evaluation AS e ON e.uid=t.uid
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_rub = TRUE;
	";

$rang= array(''=>'','ES'=>'ES','SSES'=>'SSES','VAR'=>'VAR','SVAR'=>'SVAR','FO'=>'FO','SSFO'=>'SSFO','CAR'=>'CAR');
$tables = array ('taxons','chorologie','evaluation');

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
