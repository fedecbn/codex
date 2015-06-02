<?php
//------------------------------------------------------------------------------//
//  commun/JSDN_commune.PHP                                                     //
//                                                                              //
//  Banque de semences VANDA                                                    //
//                                                                              //
//  Version 1.00  04/08/12 - DariaNet                                           //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ VAR.
$table="ref_commune";
$param=$_GET["term"];

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ MAIN
if(strlen($param)>0) {
    $query="SELECT insee_commune,nom_commune_maj FROM ".$table." WHERE nom_commune_maj REGEXP '^$param' ORDER BY nom_commune_maj";
    $result=mysql_query($query,$db) or die ("Erreur SQL : ".mysql_error($db));
    if($result){
        while ($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			$row_array['value'] = $row["nom_commune_maj"];
			$row_array['insee'] = $row["insee_commune"];
    		$return_arr[]=$row_array;
    	}
        echo json_encode($return_arr);    		
   	} else echo 'Erreur SQL';
    mysql_close($db);
}	
?>

