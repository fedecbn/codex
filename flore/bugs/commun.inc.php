<?php
//------------------------------------------------------------------------------//
//   bugs/commun.inc.php                                                        //
//                                                                              //
//  Version 1.00  13/07/12 - DariaNet                                           //
//  Version 1.01  29/04/14 - MaJ pour multi-langues                             //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/constants.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");

require_once ("../../_INCLUDE/common.lang.php");
require_once ("../commun/module.lang.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$ouinon_txt=array("Non","Oui");

$rubriques_txt=array("",
                    "Page d'accueil",
                    "Liste rouge",
                    "Liste EVEE",
                    "Fiche taxon",
                    "Administration du logiciel",
                    "Login, sécurité",
                    "Autre");

$cat_txt=array("",
                    "Bug sur fonction existante ",
                    "Remarque sur fonction existante",
                    "Demande nouvelle fonction");

$statut_txt=array(  "Nouveau",
                    "En cours",
                    "OK",
                    "Terminé",
                    "Concertation");

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
