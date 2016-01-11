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
$id_page = $_SESSION['page'] = "refnat";
$titre = "REFNAT";
$name_page = "Référentiel National";
$id_page_2 = "droit";
$title = $lang['fr']['titre_web']." - ".$id_page;


$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ QUERY du module
$query_module = "
SELECT t.* 
	FROM refnat.taxons t 
	WHERE t.uid=";

$query_liste = "
SELECT count(*) OVER() AS total_count,*
	FROM refnat.taxons
	WHERE 1=1 ";
	
$query_export = "
SELECT t.* 
	FROM refnat.taxons t 
	WHERE 1=1 ";
$export_id = "t.uid";

$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page.", utilisateur.ref_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";
	
$query_discussion = "
	SELECT prenom||' '||nom||' ('||cd_cbn||') le '||to_char(datetime, 'dd/MM/YYYY')||' à '||to_char(datetime, 'HH24')||'h'||to_char(datetime, 'MI'), commentaire_eval 
	FROM refnat.discussion a JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn 
	WHERE uid = ";

//------------------------------------------------------------------------------ VOCABULAIRE du module
$lang['fr']['refnat_1']="Ajouter";
$lang['it']['refnat_1']="";

$lang['fr']['refnat']="Evolution TAXREF";
$lang['it']['refnat']="";

$lang['fr']['refnat_2']="Rechercher";
$lang['it']['refnat_2']="";

$lang['fr']['add_refnat']="Ajouter un taxon";
$lang['it']['add_refnat']="";

$lang['fr']['edit_refnat']="Modifier un taxon";
$lang['it']['edit_refnat']="";

$lang['fr']['voir_refnat']="Consulter une fiche taxon";
$lang['it']['voir_refnat']="";


//------------------------------------------------------------------------------ CHAMPS du module
$langliste['fr']['refnat'][]="Cdnom";
$langliste['fr']['refnat-popup'][]="CD NOM";

$langliste['fr']['refnat'][]="Cdref";
$langliste['fr']['refnat-popup'][]="CD REF";

$langliste['fr']['refnat'][]="Nom complet";
$langliste['fr']['refnat-popup'][]="Nom complet";

$langliste['fr']['refnat'][]="Rang";
$langliste['fr']['refnat-popup'][]="Rang";

$langliste['fr']['refnat'][]="Famille";
$langliste['fr']['refnat-popup'][]="Famille";

$langliste['fr']['refnat'][]="Groupe taxo";
$langliste['fr']['refnat-popup'][]="Groupe taxonomique systématique / fonctionnel";

$langliste['fr']['refnat'][]="Biogéo";
$langliste['fr']['refnat-popup'][]="Statut biogéographique en France métropolitaine";

$langliste['fr']['refnat'][]="v2";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v2";

$langliste['fr']['refnat'][]="v3";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v3";

$langliste['fr']['refnat'][]="v4";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v4";

$langliste['fr']['refnat'][]="v5";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v5";

$langliste['fr']['refnat'][]="v6";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v6";

$langliste['fr']['refnat'][]="v7";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v7";

$langliste['fr']['refnat'][]="v8";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v8";

$langliste['fr']['refnat'][]="Modif";
$langliste['fr']['refnat-popup'][]="Proposition de modifications réalisée";



//------------------------------------------------------------------------------ FONCTIONS du module

?>