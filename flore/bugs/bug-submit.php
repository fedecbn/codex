<?php
header('Content-Type: text/html; charset=ISO-8859-1'); 
//------------------------------------------------------------------------------//
//  bugs/bugs-submit.php                                                        //
//                                                                              //
//  Version 1.00  26/08/12 - DariaNet                                           //
//  Version 1.10  10/08/14 - MaJ pgSQL                                          //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
include ("../../_INCLUDE/config_sql.inc.php");
include ("../../_INCLUDE/fonctions.inc.php");

//------------------------------------------------------------------------------ PARMS.
$id=$_POST['id'];

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id))                                                               // EDIT
{
    $query="UPDATE ".SQL_schema_app.".bug SET ";
    foreach ($_POST as $field => $val) {
        if ($field!="id" ) $query.=$field."=".sql_format ($val).",";
        if ($field!="descr" ) $query.=$field."=".sql_format_quote ($val,'do').",";
        if ($field!="statut_descr" ) $query.=$field."=".sql_format_quote ($val,'do').",";
        if ($field!="id" ) $query.=$field."=".sql_format ($val).",";
		}
	$query=rtrim ($query,",");
    $query.=" WHERE id_bug=".$id;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
}

//------------------------------------------------------------------------------ FONCTIONS

pg_close ();
?>