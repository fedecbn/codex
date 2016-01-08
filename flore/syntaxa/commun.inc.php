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

$query_module_biblio = "
SELECT t.* 
	FROM syntaxa.st_biblio t 
	WHERE t.\"codeEnregistrement\"=";	
	
$query_description=
"SELECT champs.description FROM referentiels.champs WHERE rubrique_champ = 'syntaxa' and table_champ='st_syntaxon' and champs.nom_champ=";

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

$lang['fr']['titre']="Codex - Rubrique Catalogue des végétations";

$lang['fr']['liste_taxons']="Liste des syntaxons";

$langliste['fr']['syntaxa'][]="Code enregistrement";
$langliste['fr']['syntaxa-popup'][]="Identifiant unique du Syntaxon dans le catalogue partagé ";

$langliste['fr']['syntaxa'][]="Identifiant syntaxon";
$langliste['fr']['syntaxa-popup'][]="Identifiant du syntaxon dans le catalogue d'origine";

$langliste['fr']['syntaxa'][]="Nom scientifique syntaxon";
$langliste['fr']['syntaxa-popup'][]="Nom complet du syntaxon";

$langliste['fr']['syntaxa'][]="Rang syntaxon retenu";
$langliste['fr']['syntaxa-popup'][]="Rang du syntaxon";

$langliste['fr']['syntaxa'][]="Identifiant syntaxon retenu";
$langliste['fr']['syntaxa-popup'][]="Identifiant du syntaxon retenu dans le catalogue d'origine";

$langliste['fr']['syntaxa'][]="Nom scientifique syntaxon retenu";
$langliste['fr']['syntaxa-popup'][]="Nom complet du syntaxon retenu";

$langliste['fr']['syntaxa'][]="Identifiant syntaxon supérieur";
$langliste['fr']['syntaxa-popup'][]="Identifiant du syntaxon supérieur dans le catalogue d'origine";
//------------------------------------------------------------------------------ FONCTIONS du module

?>