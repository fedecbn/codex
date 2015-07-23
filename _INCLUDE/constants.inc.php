<?php
//------------------------------------------------------------------------------//
//   _INCLUDE/constants.inc.php                                                 //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  15/08/14 - Aj $user_level                                     //
//------------------------------------------------------------------------------//
error_reporting (E_ALL ^ E_NOTICE);
//error_reporting (0);


//------------------------------------------------------------------------------ VARIABLES GLOBALES

define ("NOM_BDD","Outil d’aide à l’evaluation de la flore");
define ("AUTEUR","DariaNet");

define ("ACCES_URL","http://www.fcbn.fr/");

define ("DATE_ANC",1990);
define ("REF_TAXO","TAXREF v5");

define ("EMAIL_EXP","");
define ("FPDF_FONTPATH","../../_INCLUDE/font/");
define ("ICONES_SET", "icones_A");

//------------------------------------------------------------------------------ PATHS
define ("ROOT_PATH","../../_DATA");
define ("PDF_PATH","../../_DATA/PDF/");
define ("CSV_PATH","../../_DATA/CSV/");
define ("XML_PATH","../../_DATA/XML/");
define ("KML_PATH","../../_DATA/KML/");
define ("EXPORT_PATH","../../_DATA/EXPORTS/");
define ("IMPORT_PATH","../../_DATA/IMPORTS/");

//------------------------------------------------------------------------------ Atlas 11
define ("EVAL_NOM","Dispositif de partage des connaissances et d'expertise du réseau des CBN");
define ("EVAL_AUTEUR","DariaNet");
define ("EVAL_CARTES_PATH","../../_DATA/eval/cartes/");
define ("EVAL_PHOTOS_PATH","../../_DATA/eval/photos/");
define ("EVAL_PDF_PATH","../../_DATA/eval/PDF/");
define ("EVAL_RTF_PATH","../../_DATA/eval/RTF/");

//------------------------------------------------------------------------------ MAX.
define ("MAX_FILE_SIZE", 1000000);                                              //  Taille MAXI = 1 Mo
define ("MAX_OBS_CARTO", 5000);                                                 //  Nbre de points maxi à afficher

//------------------------------------------------------------------------------ Niveaux_Utilisateurs
$user_level=array("0"=>"Pas d'accès",
				"1"=>"Lecteur",
                "64"=>"Participant",
                "128"=>"Evaluateur",
                "129"=>"Référent",
                "255"=>"Administrateur");

//------------------------------------------------------------------------------ multi-langues

define ("FR",0);
define ("IT",1);

//------------------------------------------------------------------------------ indentifiant sources, argumentaire et fiabilité EEE
// $ids = array (0=> "ids0",1=> "ids1",2=> "ids2",3=> "ids3",4=> "ids4",5=> "ids5",6=> "ids6",7=> "ids7",8=> "ids8",9=> "ids9",10=> "ids10",11=> "ids11",12=> "ids12");
// $ida = array (4=> "ids4",5=> "ids5",6=> "ids6",7=> "ids7",10=> "ids10",11=> "ids11",12=> "ids12",13=> "ids13",14=> "ids12",14=> "ids12",15=> "ids15",16=> "ids16",17=> "ids17",18=> "ids18");



?>
