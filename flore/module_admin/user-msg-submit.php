<?php
//------------------------------------------------------------------------------//
//  module_admin/content-submit.php                                             //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

include ("../../_INCLUDE/config_sql.inc.php");
include ("../../_INCLUDE/fonctions.inc.php");
session_start();

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$select=$_POST['id'];
$sujet=$_POST['sujet'];
$message_html=$_POST['msg-txt'];
$where = "";

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN

if (!empty ($select) AND strpos($select,'&') == null)
	{

	$query = "SELECT email FROM applications.utilisateur WHERE id_user = '$select';";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$row = pg_fetch_array($result);
	
	envoi_mail($row['email'], $sujet, $message_html, "");
	
	 add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. envoi msg",$id_user,"pres");
	}
elseif (strlen($select) > 0) 
	{
	$pairs=explode ("&",$select);
	foreach ($pairs as $key=>$value){
		$id = ltrim ($value,"id=");
		$where .= "id_user='".$id."' OR ";
		}
	$where=rtrim ($where,"OR ");
	$query = "SELECT email FROM applications.utilisateur WHERE $where;";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

	while ($row = pg_fetch_array($result))
		{
		
		envoi_mail($row['email'], $sujet, $message_html, "");
		}
	
    add_log ("log",4,$id_user,getenv("REMOTE_ADDR"),"Admin. envoi msg",$id_user,"pres");
	} 
else 
	{                                                                        //  ADD
	echo ("ERREUR");
	}

?>
