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
$id_page = $_SESSION['page'] = "syntaxa";
$id_page_2 = "droit";

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

$query_module = "
SELECT t.* 
	FROM syntaxa.st_syntaxon t 
	WHERE t.\"codeEnregistrementSyntax\"=";

$query_liste = "
SELECT count(*) OVER() AS total_count,*
	FROM syntaxa.st_syntaxon
	";
	
$query_export = "
SELECT t.* 
	FROM defaut.uid t 
	JOIN applications.taxons a ON a.uid = t.uid 
	WHERE a.defaut = TRUE ";

// ------------------------------------------------------------------------------ Vocabulaire du module
$langliste['fr']['syntaxa'][]="blabal";
$langliste['fr']['syntaxa-popup'][]="Identifiant unique";

$langliste['fr']['syntaxa'][]="Texte";
$langliste['fr']['syntaxa-popup'][]="info_text";

$langliste['fr']['syntaxa'][]="Réel";
$langliste['fr']['syntaxa-popup'][]="info_real";

$langliste['fr']['syntaxa'][]="Entier";
$langliste['fr']['syntaxa-popup'][]="info_integer";
//------------------------------------------------------------------------------ FONCTIONS du module

?>