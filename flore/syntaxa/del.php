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
$id=$_POST['id'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id)) 
{
    $query="	
	DELETE FROM syntaxa.st_syntaxon WHERE \"codeEnregistrementSyntax\"=$id;
	DELETE FROM syntaxa.st_chorologie WHERE \"codeEnregistrementSyntax\"=$id;
	";

	// INSERT INTO 
	// INSERT INTO (uid) VALUES ($uid);
	// INSERT INTO liste_rouge.chorologie(uid) VALUES ($uid);
	// INSERT INTO liste_rouge.evaluation(uid) VALUES ($uid);

    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
		
   	add_suivi2(1,$id_user,$id,"st_syntaxon",'codeEnregistrementSyntax',$id,null,$id_page,'manuel','suppr');
	add_suivi2(1,$id_user,$id,"st_chorologie",'codeEnregistrementSyntax',$id,null,$id_page,'manuel','suppr');

	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression fiche",$id,"syntaxon");
	
	
} elseif (strlen($_POST['select']) > 0) {
    $pairs=explode ("&",$_POST['select']);
    foreach ($pairs as $key=>$value){
        $id = ltrim ($value,"id=");
		$where .= "\"codeEnregistrementSyntax\"=".$id." OR ";
		add_suivi2(1,$id_user,$id,'st_syntaxon','codeEnregistrementSyntax',$id,null,'syntaxa','manuel','suppr');
		}
    $where=rtrim ($where,"OR ");

	    $query="
	DELETE FROM syntaxa.st_syntaxon WHERE $where;
	DELETE FROM syntaxa.st_chorologie WHERE $where;
	";

    // $query="UPDATE refnat.taxons	SET $id_page = false WHERE ".$where.";";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);

    add_suivi2(1,$id_user,$where,"taxons","uid",$id,null,$id_page,'manuel','suppr');
	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"syntaxon");
	
	
}
pg_close ($db);
return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
