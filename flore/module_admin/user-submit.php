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
$query="SELECT id_user,niveau_lr,niveau_eee,niveau_lsi,niveau_catnat,niveau_refnat,ref_lr,ref_eee,ref_lsi,ref_catnat,ref_refnat 
FROM applications.utilisateur WHERE id_user= '$id_user';";
// echo $query;
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($query),false);
if (pg_num_rows ($result)) {
	/*niveau de droit*/
	$niveau['lr']=pg_result ($result,0,"niveau_lr");
	$niveau['eee']=pg_result ($result,0,"niveau_eee");
	$niveau['lsi']=pg_result ($result,0,"niveau_lsi");
	$niveau['catnat']=pg_result ($result,0,"niveau_catnat");
	$niveau['refnat']=pg_result ($result,0,"niveau_refnat");
	$niveau['all'] = max($niveau['lr'],$niveau['eee'],$niveau['lsi'],$niveau['catnat'],$niveau['refnat']);
	/*niveau référents*/
	$ref['lr']=pg_result ($result,0,"ref_lr");
	$ref['eee']=pg_result ($result,0,"ref_eee");
	$ref['lsi']=pg_result ($result,0,"ref_lsi");
	$ref['catnat']=pg_result ($result,0,"ref_catnat");
	$ref['refnat']=pg_result ($result,0,"ref_refnat");
	if (($ref['lr'] == 't') OR ($ref['eee'] == 't') OR ($ref['lsi'] == 't') OR ($ref['catnat'] == 't') OR ($ref['refnat'] == 't')) $ref['all']= 't'; else $ref['all']= 'f';
}
//------------------------------------------------------------------------------ EDIT
if (!empty($id))                                                                
{
$query_niveau = "";$query_ref = "";
foreach ($rub as $key => $val)	{
	if (!empty($ref[$key])) $query_niveau .= "niveau_".$key."=".sql_format_num ($_POST["niveau_".$key]).",";
	if (!empty($ref[$key])) $query_ref .= "ref_".$key."=".sql_format_bool ($_POST["ref_".$key]).",";
	}
$query="UPDATE ".SQL_schema_app.".utilisateur SET 
	id_cbn=".sql_format_num ($_POST["id_cbn"]).",
	nom=".sql_format ($_POST["nom"]).",
	prenom=".sql_format ($_POST["prenom"]).",
	login=".sql_format ($_POST["login"]).",
	pw=".sql_format ($_POST["pw"]).",
	tel_bur=".sql_format ($_POST["tel_bur"]).",
	tel_port=".sql_format ($_POST["tel_port"]).",
	tel_int=".sql_format ($_POST["tel_int"]).",
	email=".sql_format ($_POST["email"]).",
	web=".sql_format ($_POST["web"]).",
	".$query_niveau."
	".$query_ref."
	descr=".sql_format ($_POST["descr"])." 
	WHERE id_user='".$id."';";
// echo $query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. edit user",$id,"utilisateur");
} else { 
//------------------------------------------------------------------------------ ADD
foreach ($rub as $key => $val)	{
	if (empty($_POST["niveau_".$key])) $_POST["niveau_".$key] = 0;
	if (empty($_POST["ref_".$key])) $_POST["ref_".$key] = 0;
	}
    $id=strtoupper(substr(stripAccents($_POST['prenom']),0,2).substr(stripAccents($_POST['nom']),0,2)).mt_rand(1,9);
    $query="INSERT INTO ".SQL_schema_app.".utilisateur (id_user, id_cbn,nom,prenom,login,pw,tel_bur,tel_port,tel_int,email,web,niveau_lr,niveau_eee,niveau_catnat,niveau_refnat,niveau_lsi,ref_lr,ref_eee,ref_catnat,ref_refnat,ref_lsi,descr)
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
		".sql_format_num ($_POST["niveau_lr"]).",
		".sql_format_num ($_POST["niveau_eee"]).",
		".sql_format_num ($_POST["niveau_catnat"]).",
		".sql_format_num ($_POST["niveau_refnat"]).",
		".sql_format_num ($_POST["niveau_lsi"]).",
		".sql_format_bool ($_POST["ref_lr"]).",
		".sql_format_bool ($_POST["ref_eee"]).",
		".sql_format_bool ($_POST["ref_catnat"]).",
		".sql_format_bool ($_POST["ref_refnat"]).",
		".sql_format_bool ($_POST["ref_lsi"]).",
		".sql_format ($_POST["descr"]).");";
// echo $query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. ajout user",$id,"utilisateur");
}

//------------------------------------------------------------------------------ FONCTIONS
function stripAccents ($string) {
	return strtr ($string,'àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ','aaaaaceeeeiiiinooooouuuuyyAAAAACEEEEIIIINOOOOOUUUUY');
}
?>
