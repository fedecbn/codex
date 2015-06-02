<?php
//------------------------------------------------------------------------------//
//  module_admin/log-del.php                                                    //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ PARMS.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
$query="DELETE FROM ".SQL_schema_app.".log WHERE event=1;";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

pg_close ();
?>
