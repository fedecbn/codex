<?php
//------------------------------------------------------------------------------//
//  module_admin/photo-del.php                                                  //
//                                                                              //
//  Banque de semences ‘VANDA’                                                  //
//                                                                              //
//  Version 1.00  10/04/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ PARMS.
$id=$_POST[id];

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base_photo,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ MAIN
$query="DELETE FROM addinfo_images WHERE id=".$id.";";
$result=mysql_query($query,$db) or die ($query." Erreur mySQL : ".mysql_error($db));

mysql_close ();

?>
