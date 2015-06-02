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
$id_page_2 = "refnat_2";

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

/*R�cup�ration des info pour la fiche*/
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
	WHERE t.uid=";
// ------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>