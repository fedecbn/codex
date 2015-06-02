<?php
header('Content-Type: text/html; charset=ISO-8859-1'); 
//------------------------------------------------------------------------------//
//  module_admin/photo-submit.php                                                //
//                                                                              //
//  Banque de semences 'VANDA'                                                  //
//                                                                              //
//  Version 1.00  10/04/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

include ("../../_INCLUDE/config_sql.inc.php");
session_start();

//------------------------------------------------------------------------------ PARMS.
$id_user=$_SESSION['id_user'];
$id=$_POST['id'];

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ MAIN
if (!empty ($id))                                                               // EDIT
{
    $query="UPDATE ".SQL_base_photo.".addinfo_images SET ";
    foreach ($_POST as $field => $val) 
        if ($field!="submit_x"  && $field!="submit_y" && $field!="id" ) $query.=$field."=".sql_format_utf8 ($val).",";
    $query=rtrim ($query,",");
    $query.=" WHERE id=".$id.";";
    $result=mysql_query($query,$db) or die ($query." Erreur mySQL : ".mysql_error($db));

    add_log ("app_log",4,$id_user,getenv("REMOTE_ADDR"),"Photothèque edit méta",$id,"addinfo_images");
} else {                                                                        //  ADD
    $query="INSERT INTO ".SQL_base_photo.".addinfo_images (";
    foreach ($_POST as $field => $val) 
        if ($field!="submit_x"  && $field!="submit_y" && $field!="id" ) $query.=$field.",";
    $query=rtrim ($query,",");
    $query.=") VALUES (";
    foreach ($_POST as $field => $val) 
        if ($field!="submit_x"  && $field!="submit_y" && $field!="id" ) $query.=sql_format_utf8 ($val).",";
    $query=rtrim ($query,",");
    $query.=")";                            
    $result=mysql_query($query,$db) or die ($query." Erreur mySQL : ".mysql_error($db));

    add_log ("app_log",4,$id_user,getenv("REMOTE_ADDR"),"Photothèque ajout méta",$id,"addinfo_images");
}

//------------------------------------------------------------------------------ FONCTIONS
function stripAccents ($string) {
	return strtr ($string,'àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ','aaaaaceeeeiiiinooooouuuuyyAAAAACEEEEIIIINOOOOOUUUUY');
}
?>
