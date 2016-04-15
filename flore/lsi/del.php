<?php
/*------------------------------------------------------------------
--------------------------------------------------------------------
 Application Codex		                               			  
 https://github.com/fedecbn/codex					   			  
--------------------------------------------------------------------
 Interface avec la base de données (suppression)         
--------------------------------------------------------------------
--------------------------------------------------------------------*/
/*------------------------------------------------------------------------------ INITIALISATION*/ 
include_once ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id_del=$_POST['select'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id)) 
{
    $query="DELETE FROM lsi.coor_news_tag WHERE $id_del;";
    $query.="DELETE FROM lsi.news WHERE $id_del;";
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	
    add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression fiche",$id,"news");
} elseif (strlen($_POST['select']) > 0) {
    $pairs=explode ("&",$_POST['select']);
    foreach ($pairs as $key=>$value)
        $where .= "id=".ltrim ($value,"id=")." OR ";
    $where=rtrim ($where,"OR ");

	$query="DELETE FROM lsi.coor_news_tag WHERE $where;";
	$query.="DELETE FROM lsi.news WHERE $where;";

	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

	
    add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"news");
}
pg_close ($db);
return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
