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
define ("DEBUG",true);
$id_user=$_SESSION['id_user'];

/*variable contenant l'identifiant du syntaxon quand une seule checkbox est cochée 
(on retire le nom de la checkbox, à noter que les crochets sont passés percent encoding normalement utilisé pour faire passer des paramètres à un url %5B%5D )*/
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
//id reçois $_POST['select'], quand plusieurs checkbox sont cochées alors on a une chaine de caractère du type "name1=valeur1&name2=valeur2" sinon on a juste " name1=valeur1"
if (strpos($id, '&') === false) 
{ 
	if (DEBUG) echo "une seule case est cochée";
    $where .= "\"codeEnregistrementSyntax\"='".$id."'";
	$where2 .= "\"codeEnregistrement\"='".$id."'";
	$where3 .= "\"codeEnregistrementSyntaxon\"='".$id."'";
	$query="	
	DELETE FROM syntaxa.st_syntaxon WHERE $where;
	DELETE FROM syntaxa.st_chorologie WHERE $where2;
	DELETE FROM syntaxa.st_biblio WHERE $where2;
	DELETE FROM syntaxa.st_correspondance_pvf WHERE $where3;
	";
	if (DEBUG)  echo "</br>".$query;
	if (DEBUG)  echo "</br>id=".sql_format_quote($id,'do');
	if (DEBUG)  echo "</br>id='".$id."'";

    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
		

	add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_syntaxon","codeEnregistrementSyntax",$id,null,'syntaxa','manuel','suppr');
	add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_chorologie","codeEnregistrement",$id,null,'syntaxa','manuel','suppr');
	add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_biblio","codeEnregistrement",$id,null,'syntaxa','manuel','suppr');
	add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_correspondance_pvf","codeEnregistrementSyntaxon",$id,null,'syntaxa','manuel','suppr');

	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression une fiche",$where,"syntaxon");
	
	
	
} 
//elseif (strlen($_POST['select']) > 0) {
	else {
	if (DEBUG) echo "<br> plusieurs cases cochées";
    $pairs=explode ("&",str_replace('%5B%5D','[]',$_POST['select']));
    foreach ($pairs as $key=>$value){
        $id = ltrim ($value,"id[]=");
		$where .= "\"codeEnregistrementSyntax\"='".$id."' OR ";
		$where2 .= "\"codeEnregistrement\"='".$id."' OR ";
		$where3 .= "\"codeEnregistrementSyntaxon\"='".$id."' OR ";
		add_suivi2(1,$id_user,sql_format_quote($id,'do'),'st_syntaxon','codeEnregistrementSyntax',$id,null,$id_page,'manuel','suppr');
		add_suivi2(1,$id_user,sql_format_quote($id,'do'),'st_chorologie','codeEnregistrement',$id,null,$id_page,'manuel','suppr');
		add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_biblio","codeEnregistrement",$id,null,$id_page,'manuel','suppr');
		add_suivi2(1,$id_user,sql_format_quote($id,'do'),"st_correspondance_pvf","codeEnregistrementSyntaxon",$id,null,$id_page,'manuel','suppr');
		}
    $where=rtrim ($where,"OR ");
	$where2=rtrim ($where2,"OR ");
	$where3=rtrim ($where3,"OR ");

	$query="
	DELETE FROM syntaxa.st_syntaxon WHERE $where;
	DELETE FROM syntaxa.st_chorologie WHERE $where2;
	DELETE FROM syntaxa.st_biblio WHERE $where2;
	DELETE FROM syntaxa.st_correspondance_pvf WHERE $where3;
	";
	if (DEBUG)  echo "<br> effacé de st_syntaxon=".$where;
	if (DEBUG)  echo "<br> effacé de st_chorologie et biblio=".$where2;
	if (DEBUG)  echo "<br> effacé de st_correspondance_pvf where3=".$where3;
	echo $query;
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);

	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"syntaxon");

	
}
pg_close ($db);
return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
