<?php
//------------------------------------------------------------------------------//
//  bugs/bugs-del.php                                                           //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ PARMS.
$id=$_POST['id'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
$query="DELETE FROM ".SQL_schema_app.".bug WHERE id_bug='".$id."';";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

pg_close ();
?>

