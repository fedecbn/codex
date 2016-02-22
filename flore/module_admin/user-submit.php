<?php
//------------------------------------------------------------------------------//
//  module_admin/user-submit.php                                                //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  21/08/14 - MaJ query                                          //
//------------------------------------------------------------------------------//

include ("../../_INCLUDE/config_sql.inc.php");
include ("../../_INCLUDE/fonctions.inc.php");
include_once ("commun.inc.php");
session_start();

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id=$_POST['id'];

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
/*référents et  niveau de droits*/
$query="SELECT * FROM applications.utilisateur WHERE id_user= '$id_user';";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($query),false);
$ref['all'] = 'f';$niveau['all'] = 0;
$arraysult = pg_fetch_array ($result);

foreach ($rubrique as $key => $val)
	{
	$ref[$key]= $arraysult["ref_".$key] != null ? $arraysult["ref_".$key] : 'f';
	$ref['all'] = $ref['all'] = 't' OR $ref['ref_'.$key] = 't' ? 't' : 'f';
	$niveau[$key]= $arraysult["niveau_".$key] != null ? intval($arraysult["niveau_".$key]) : 0;
	$niveau['all'] = max($niveau['all'],$niveau[$key]);
	}
	var_dump($niveau);
//------------------------------------------------------------------------------ EDIT
if (!empty($id))                                                                
{
$query_niveau = "";$query_ref = "";
foreach ($rubrique as $key => $val)	{
	if (empty($_POST["niveau_".$key])) $_POST["niveau_".$key] = 0;
	if (empty($_POST["ref_".$key])) $_POST["ref_".$key] = 'false';
	if ($ref[$key] === 't' OR $niveau[$key] >= 255) $query_niveau .= "niveau_".$key."=".sql_format_num ($_POST["niveau_".$key]).",";
	if ($ref[$key] === 't' OR $niveau[$key] >= 255) $query_ref .= "ref_".$key."=".sql_format_bool ($_POST["ref_".$key]).",";
	}


/*cas des modif de référent sur d'autres users*/
if ($id == $id_user OR $niveau['all'] >= 255) $code = "login=".sql_format ($_POST["login"]).",pw=".sql_format ($_POST["pw"]).","; else $code = "";
	
$query="UPDATE ".SQL_schema_app.".utilisateur SET 
	id_cbn=".sql_format_num ($_POST["id_cbn"]).",
	nom=".sql_format ($_POST["nom"]).",
	prenom=".sql_format ($_POST["prenom"]).",
	".$code."
	tel_bur=".sql_format ($_POST["tel_bur"]).",
	tel_port=".sql_format ($_POST["tel_port"]).",
	tel_int=".sql_format ($_POST["tel_int"]).",
	email=".sql_format ($_POST["email"]).",
	web=".sql_format ($_POST["web"]).",
	".$query_niveau."
	".$query_ref."
	descr=".sql_format ($_POST["descr"])." 
	WHERE id_user='".$id."';";
echo $query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. edit user",$id,"utilisateur");
} else { 
//------------------------------------------------------------------------------ ADD
foreach ($rubrique as $key => $val)	{
	if (empty($_POST["niveau_".$key])) $_POST["niveau_".$key] = 0;
	$val_niveau .= sql_format_num ($_POST["niveau_".$key]).",";
	$key_niveau .= "niveau_".$key.",";
	if (empty($_POST["ref_".$key])) $_POST["ref_".$key] = 0;
	$val_ref .= sql_format_bool ($_POST["ref_".$key]).",";
	$key_ref .= "ref_".$key.",";
	}
    $id=strtoupper(substr(stripAccents($_POST['prenom']),0,2).substr(stripAccents($_POST['nom']),0,2)).mt_rand(1,9);
    $query="INSERT INTO ".SQL_schema_app.".utilisateur (id_user, id_cbn,nom,prenom,login,pw,tel_bur,tel_port,tel_int,email,web,
	$key_niveau
	$key_ref
	descr)
	VALUES (
		'".$id."',
		".sql_format_num ($_POST["id_cbn"]).",
		".sql_format ($_POST["nom"]).",
		".sql_format ($_POST["prenom"]).",
		".sql_format ($_POST["login"]).",
		".sql_format ($_POST["pw"]).",
		".sql_format ($_POST["tel_bur"]).",
		".sql_format ($_POST["tel_port"]).",
		".sql_format ($_POST["tel_int"]).",
		".sql_format ($_POST["email"]).",
		".sql_format ($_POST["web"]).",
		$val_niveau $val_ref
		".sql_format ($_POST["descr"]).");";
echo $query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. ajout user",$id,"utilisateur");
}

//------------------------------------------------------------------------------ FONCTIONS
function stripAccents ($string) {
	return strtr ($string,'àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ','aaaaaceeeeiiiinooooouuuuyyAAAAACEEEEIIIINOOOOOUUUUY');
}
?>
