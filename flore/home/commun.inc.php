<?php
//------------------------------------------------------------------------------//
//   home/commun.inc.php                                                        //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/constants.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");

require_once ("../../_INCLUDE/common.lang.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$query_rub = "
	SELECT id_module
	FROM applications.rubrique
	ORDER BY pos";

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
