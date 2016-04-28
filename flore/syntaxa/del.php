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

//variable contenant l'identifiant du syntaxon quand une seule checkbox est cochée (on debug les crochets qui sont passés en UTF8
$id=str_replace('id%5B%5D=','',$_POST['select']);

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
//DEBUG si id ne renvoi rien
/*
if (empty ($id)) {echo "id est vide";
print_r( $_POST['id'] );
foreach($_POST as $key => $val) echo '$_POST["'.$key.'"]='.$val.'<br />'; }
*/

	
if (!empty ($id)) 
if (strpos($id, '&') === false) 
{ 
echo "blabla";
    $where .= "\"codeEnregistrementSyntax\"='".$id."'";
	$where2 .= "\"codeEnregistrement\"='".$id."'";
	$query="	
	DELETE FROM syntaxa.st_syntaxon WHERE $where;
	DELETE FROM syntaxa.st_chorologie WHERE $where2;
	";
	echo "</br>".$query;
	echo "</br>id=".sql_format_quote($id,'do');
	echo "</br>id='".$id."'";

    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
		

	add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_syntaxon","codeEnregistrementSyntax",$id,null,'syntaxa','manuel','suppr');
	add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_chorologie","codeEnregistrement",$id,null,'syntaxa','manuel','suppr');

	//add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression fiche",$id,"syntaxon");
	
	
	
} elseif (strlen($_POST['select']) > 0) {
    echo "<br> blibli";
   $pairs=explode ("&",str_replace('%5B%5D','[]',$_POST['select']));
    foreach ($pairs as $key=>$value){
        $id = ltrim ($value,"id[]=");
		$where .= "\"codeEnregistrementSyntax\"='".$id."' OR ";
		$where2 .= "\"codeEnregistrement\"='".$id."' OR ";
		add_suivi2(1,$id_user,sql_format_quote($id,'do'),'st_syntaxon','codeEnregistrementSyntax',$id,null,$id_page,'manuel','suppr');
		add_suivi2(1,$id_user,sql_format_quote($id,'do'),'st_chorologie','codeEnregistrement',$id,null,$id_page,'manuel','suppr');
		}
    $where=rtrim ($where,"OR ");
	$where2=rtrim ($where2,"OR ");

	$query="
	DELETE FROM syntaxa.st_syntaxon WHERE $where;
	DELETE FROM syntaxa.st_chorologie WHERE $where2;
	";
	echo "where=".$where;
	echo "where2=".$where;
	echo $query;
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);

   // add_suivi2(1,$id_user,$where,"taxons","uid",$id,null,$id_page,'manuel','suppr');
	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"syntaxon");

	
}
pg_close ($db);
return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
