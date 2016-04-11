<?php
//------------------------------------------------------------------------------//
//   bugs/commun.inc.php                                                        //
//                                                                              //
//  Version 1.00  13/07/12 - DariaNet                                           //
//  Version 1.01  29/04/14 - MaJ pour multi-langues                             //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

$id_page = $_SESSION['page'] = "bugs";

//------------------------------------------------------------------------------ CONSTANTES du module
$ouinon_txt=array("Non","Oui");


$niveau=max($_SESSION['niveau_lr'],$_SESSION['niveau_eee'],$_SESSION['niveau_lsi'],$_SESSION['niveau_catnat'],$_SESSION['niveau_refnat']);


$rubriques_txt=array("",
                    "Page d'accueil",
                    "Rubrique Liste rouge",
                    "Rubrique Liste EEE",
                    "Rubrique Référentiel taxonomique",
                    "Rubrique Catalogue National",
                    "Administration (suivi des modification)",
                    "Login, sécurité",
                    "Autre");

$cat_txt=array(		0=>"",
                    1=>"Bug sur fonction existante ",
                    2=>"Remarque sur fonction existante",
                    3=>"Demande nouvelle fonction");

$statut_txt=array(  "Nouveau",
                    "En cours",
                    "OK",
                    "Terminé",
                    "Concertation");

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
