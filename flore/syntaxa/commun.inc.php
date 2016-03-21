<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "syntaxa";
$id_page_2 = "droit";
$name_page = "Catalogues des végétations";

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
	
$query_module_correspondance_pvf1 = "
SELECT t.*
	FROM syntaxa.st_correspondance_pvf t
	WHERE t.\"versionReferentiel\"='v1' and t.\"codeEnregistrementSyntaxon\"=";	
	
$query_module_correspondance_pvf2 = "
SELECT t.*
	FROM syntaxa.st_correspondance_pvf t
	WHERE t.\"versionReferentiel\"='v2' and t.\"codeEnregistrementSyntaxon\"=";	
	
$query_module_correspondance_hic = "
SELECT t.*
	FROM syntaxa.st_correspondance_hic t
	WHERE t.\"codeEnregistrement\"=";	
	
$query_module_correspondance_eunis = "
SELECT t.*
	FROM syntaxa.st_correspondance_eunis t
	WHERE t.\"codeEnregistrement\"=";	
	
$query_module_chorologie = "
SELECT t.*
	FROM syntaxa.st_chorologie t
	WHERE t.\"codeEnregistrement\"=";	
	
$query_module_etage_vegetation = "
SELECT t.*
	FROM syntaxa.st_etage_veg t
	WHERE t.\"codeEnregistrement\"=";	
	
$query_module_etage_bioclim = "
SELECT t.*
	FROM syntaxa.st_etage_bioclim t
	WHERE t.\"codeEnregistrement\"=";	
	
$query_description=
"SELECT champs.description FROM referentiels.champs WHERE rubrique_champ = 'syntaxa' and table_champ <>'st_serie_petitegeoserie' and table_champ not like 'st_ref%' and champs.nom_champ=";

$query_liste = "
SELECT count(*) OVER() AS total_count,*
	FROM syntaxa.st_syntaxon
	";
	
$query_export = "
SELECT t.* 
	FROM defaut.uid t 
	JOIN applications.taxons a ON a.uid = t.uid 
	WHERE a.defaut = TRUE ";

//$tables = array ('st_syntaxon','st_etage_bioclim','st_etage_veg','st_chorologie','st_correspondance_eunis','st_correspondance_hic','st_correspondance_pvf');

if (!isset($_POST["etape"])) {$etape = 1;}
else {$etape = $_POST["etape"];}

	
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