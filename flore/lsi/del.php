<?php
//------------------------------------------------------------------------------//
//  module_gestion/lr-del.php                                                   //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  15/08/14 - MaJ tables                                         //
//------------------------------------------------------------------------------//

session_start();
include ("commun.inc.php");

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id_del=$_POST['select'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id)) 
{
    $query="DELETE FROM ".SQL_schema_lsi.".coor_news_tag WHERE $id_del;";
    $query.="DELETE FROM ".SQL_schema_lsi.".news WHERE $id_del;";
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	
    add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression fiche",$id,"news");
} elseif (strlen($_POST['select']) > 0) {
    $pairs=explode ("&",$_POST['select']);
    foreach ($pairs as $key=>$value)
        $where .= "uid=".ltrim ($value,"id=")." OR ";
    $where=rtrim ($where,"OR ");

	$query="DELETE FROM ".SQL_schema_lsi.".coor_news_tag WHERE $id_del;";
	$query.="DELETE FROM ".SQL_schema_lsi.".news WHERE $id_del;";
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

    add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"news");
}
pg_close ($db);
return (true);

?>
