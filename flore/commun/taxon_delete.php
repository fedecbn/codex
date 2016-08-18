<?php
//------------------------------------------------------------------------------//
//  commun/TAXON_DELETE.PHP                                                     //
//                                                                              //
//  SILENE-Flore                                                                //
//  Module extrene : Typologie des habitats naturels du PNM                     //
//                                                                              //
//  Version 1.00  28/11/12 - OlGa                                               //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("../../_INCLUDE/config_sql.inc.php");
include ("commun.inc.php");
//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ MAIN
if ($_POST['id']){
//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);
//    $db_selected=mysql_select_db(SQL_base_HABITATS,$db) or die ("Impossible d'utiliser la base : ".mysql_error());
    
	$id=$_POST['id'];
    $query="DELETE FROM syntaxa.st_cortege_floristique WHERE \"idCortegeFloristique\"=".$id;
    $result=pg_query($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

    pg_close($db);
}
?>
