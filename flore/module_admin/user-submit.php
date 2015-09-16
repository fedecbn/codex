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
session_start();

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id=$_POST['id'];

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty($id))                                                                // EDIT
{
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
niveau_lr=".sql_format_num ($_POST["niveau_lr"]).",
niveau_eee=".sql_format_num ($_POST["niveau_eee"]).",
niveau_catnat=".sql_format_num ($_POST["niveau_catnat"]).",
niveau_refnat=".sql_format_num ($_POST["niveau_refnat"]).",
niveau_lsi=".sql_format_num ($_POST["niveau_lsi"]).",
ref_lr=".sql_format_bool ($_POST["ref_lr"]).",
ref_eee=".sql_format_bool ($_POST["ref_eee"]).",
ref_catnat=".sql_format_bool ($_POST["ref_catnat"]).",
ref_refnat=".sql_format_bool ($_POST["ref_refnat"]).",
ref_lsi=".sql_format_bool ($_POST["ref_lsi"]).",
descr=".sql_format ($_POST["descr"])." 
WHERE id_user='".$id."';";
//echo $query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. edit user",$id,"utilisateur");
} else {                                                                        //  ADD
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
echo $query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. ajout user",$id,"utilisateur");
}

//------------------------------------------------------------------------------ FONCTIONS
function stripAccents ($string) {
	return strtr ($string,'àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ','aaaaaceeeeiiiinooooouuuuyyAAAAACEEEEIIIINOOOOOUUUUY');
}
?>
