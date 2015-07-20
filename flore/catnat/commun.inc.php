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

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

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

$rang= array(''=>'','ES'=>'ES','SSES'=>'SSES','VAR'=>'VAR','SVAR'=>'SVAR','FO'=>'FO','SSFO'=>'SSFO','CAR'=>'CAR');

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
