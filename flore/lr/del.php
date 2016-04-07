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
session_start();
include_once ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id=$_POST['id'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id)) 
{
    $query="UPDATE refnat.taxons	SET $id_rub = false";

    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

	add_suivi2(1,$id_user,$id,"taxons",'uid',$uid,null,$id_rub,'manuel','suppr');
	
    add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression fiche",$id,"taxons,chorologie,evaluation");
} elseif (strlen($_POST['select']) > 0) {
    $pairs=explode ("&",$_POST['select']);
    foreach ($pairs as $key=>$value) {
        $id = ltrim ($value,"id=");
		$where .= "uid=".$id." OR ";
		add_suivi2(1,$id_user,$id,"taxons",'uid',$id,null,$id_rub,'manuel','suppr');
		}
    $where=rtrim ($where,"OR ");

    $query="UPDATE refnat.taxons	SET $id_rub = false WHERE ".$where.";";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	
    add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"taxons,chorologie,evaluation");
}
pg_close ($db);
return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
