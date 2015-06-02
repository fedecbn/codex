<?php
//------------------------------------------------------------------------------//
//  module_admin/content-submit.php                                             //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

include ("../../_INCLUDE/config_sql.inc.php");
include ("../../_INCLUDE/fonctions.inc.php");
session_start();

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id=$_POST['id'];

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN

if (!empty ($id))                                                                // EDIT
{
    $query="UPDATE ".SQL_schema_app.".pres SET ";
    foreach ($_POST as $field => $val) 
        if ($field!="submit_x"  && $field!="submit_y" && $field!="id" ) $query.=$field."=".sql_format ($val).",";
    $query=rtrim ($query,",");
    $query.=" WHERE id_pres=".$id.";";
//echo $query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. edit pres",$id,"pres");
} else {                                                                        //  ADD
    $query="INSERT INTO ".SQL_schema_app.".pres (";
    foreach ($_POST as $field => $val) 
        if ($field!="submit_x"  && $field!="submit_y" && $field!="id" ) $query.=$field.",";
    $query=rtrim ($query,",");
    $query.=") VALUES (";
    foreach ($_POST as $field => $val) 
    $query=rtrim ($query,",");
    $query.=")";                            
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. ajout pres",$id,"pres");
}

//------------------------------------------------------------------------------ FONCTIONS
function stripAccents ($string) {
	return strtr ($string,'àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ','aaaaaceeeeiiiinooooouuuuyyAAAAACEEEEIIIINOOOOOUUUUY');
}
?>
