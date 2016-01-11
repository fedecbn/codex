<?php
//------------------------------------------------------------------------------//
//   commun/commun.inc.php                                                      //
//                                                                              //
//  Banque de semences ‘VANDA’                                                  //
//                                                                              //
//  Version 1.00  13/07/12 - DariaNet                                           //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
if (file_exists("../../_INCLUDE/config_sql.inc.php") == TRUE)	require_once ("../../_INCLUDE/config_sql.inc.php"); else require_once ("../../_INCLUDE/config_sql.inc.example.php");
require_once ("../../_INCLUDE/constants.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");
require_once ("../../_INCLUDE/common.lang.php");
require_once ("module.lang.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$etape_txt=array("","pré-eval","éval","post-éval");
global $lang;
global $langliste;

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
