<?php
//------------------------------------------------------------------------------//
//  module_gestion/lr-submit.php                                                //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  15/08/14 - MaJ tables                                         //
//  Version 1.10  01/08/14 - MaJ tables v2                                      //
//------------------------------------------------------------------------------//

session_start();
include ("commun.inc.php");
define ("DEBUG",false);

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id = isset($_POST['id']) ? $_POST['id'] : "";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

if (!empty ($id))                                                               // EDIT
{
//------------------------------------------------------------------------------ Bavkup

    $query="SELECT id,title,abstract,link,link_2,id_subject,date FROM ".SQL_schema_lsi.".news AS n WHERE id=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
    $backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);                          // Old values
    foreach ($backup as $field => $val) {
        if (DEBUG) echo ($field." -> ".$val."  | ".$_POST[$field]."<br>");
        if ( $val != $_POST[$field])
            add_suivi (1,$id_user,$id,"news",$field,$val,$_POST[$field]);
    // pg_free_result ($result);
	}
	$query="SELECT id_tag FROM ".SQL_schema_lsi.".coor_news_tag cnt WHERE cnt.id=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$i=0;
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
		{
		$tag_base[$i]=$row["id_tag"];
		$i++;
		}
	/*déclaration quand la variable est vide*/
	if (empty($tag_base)) {$tag_base = array();}
	if (empty($_POST["tag_select"])) {$_POST["tag_select"] = array();}
	// pg_free_result ($result);    


//------------------------------------------------------------------------------ Update
    $query="UPDATE ".SQL_schema_lsi.".news SET  
abstract=".sql_format_quote ($_POST["abstract"],'do').",
link=".sql_format($_POST["link"]).",
link_2=".sql_format($_POST["link_2"]).",
date=".sql_format($_POST["date"]).",
title=".sql_format($_POST["title"]).",
id_subject=".sql_format_num($_POST["id_subject"])."
WHERE id=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

//------------------------------------------------------------------------------ Update tag

$supp = array_diff($tag_base, $_POST["tag_select"]);
$add = array_diff($_POST["tag_select"],$tag_base);


if (!empty($supp))
	{
   foreach ($supp as $field => $val)
   $query = $query."DELETE FROM ".SQL_schema_lsi.".coor_news_tag WHERE (id,id_tag) = ($id,$val); ";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	}
if (!empty($add))
	{
   foreach ($add as $field => $val)
   $query = $query."INSERT INTO ".SQL_schema_lsi.".coor_news_tag VALUES ($id,$val); ";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	}

//------------------------------------------------------------------------------
} else {                                                                        //  ADD

//------------------------------------------------------------------------------
    $query="INSERT INTO ".SQL_schema_lsi.".news (abstract,link,link_2,id_subject,date,title) 
VALUES (
".sql_format_quote ($_POST["abstract"],'do').",
".sql_format ($_POST["link"]).",
".sql_format ($_POST["link_2"]).",
".sql_format_num($_POST["id_subject"]).",
".sql_format ($_POST["date"]).",
".sql_format ($_POST["title"]).") RETURNING id;";
// echo $query;
    if (DEBUG)echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
    $id=pg_result($result,0,"id");

	$add = $_POST["tag_select"];
	$query = '';
	foreach ($add as $field => $val)
		$query .= "INSERT INTO ".SQL_schema_lsi.".coor_news_tag VALUES ($id,$val); ";
    if ($query != '')
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
}

/*
if (!DEBUG) {
    echo ("<script language=\"javascript\" type=\"text/javascript\">");
    echo ("window.location.replace ( \"index.php\")");
    echo ("</script>");
}
*/
pg_close ($db);

return (true);

//------------------------------------------------------------------------------ FONCTIONS

function add_suivi ($etape,$id_user,$id,$table,$champ,$valeur_1,$valeur_2) {
    global $db;

    $query="INSERT INTO ".SQL_schema_app.".suivi (etape,id_user,uid,tables,champ,valeur_1,valeur_2,datetime) VALUES  
    (".$etape.",'".$id_user."',".$id.",'".$table."','".$champ."',".sql_format ($valeur_1).",".sql_format ($valeur_2).",NOW());";
   // echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
}

?>
