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
$id=$_POST['id'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id)) 
{
    $query="
	DELETE FROM fsd.ddd WHERE uid = $id;
	DELETE FROM fsd.lien_champs WHERE uid = $id OR id_from = $id;
	";

    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
		
   	add_suivi2(1,$id_user,$id,"ddd",'uid',$id,null,$id_page,'manuel','suppr');
	
	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression fsd",$id,"ddd");
	
	
} elseif (strlen($_POST['select']) > 0) {
    $pairs=explode ("&",$_POST['select']);
    foreach ($pairs as $key=>$value){
        $id = ltrim ($value,"id=");
		$where .= "uid=".$id." OR ";
		$where2 .= "id_from=".$id." OR ";
		add_suivi2(1,$id_user,$id,'taxons_nat','uid',$id,null,'catnat','manuel','suppr');
		}
    $where=rtrim ($where,"OR ");
    $where2=rtrim ($where2,"OR ");

    $query="
	DELETE FROM fsd.ddd WHERE ".$where.";
	DELETE FROM fsd.lien_champs WHERE ".$where." OR ".$where2."
	;";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);

	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fsd",$where,"ddd");
	
}
pg_close ($db);
return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
