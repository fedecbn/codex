<?php
//------------------------------------------------------------------------------//
//  commun/JSON_instit.PHP                                                       //
//                                                                              //
//  Banque de semences VANDA                                                    //
//                                                                              //
//  Version 1.00  11/05/13 - DariaNet                                           //
//  Version 1.01  04/02/14 - MaJ table institut                                 //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ VAR.
$param=$_GET["term"];

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
include ("../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ 
if(strlen($param)>0) {
    $db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
    $db_selected=mysql_select_db(SQL_base_SILENE,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

    $query="SELECT IDINSTIT,LIBINSTIT FROM institut WHERE TAG='CBNMED' AND LIBINSTIT REGEXP '^$param' ORDER BY LIBINSTIT LIMIT 20";
    $result=mysql_query($query,$db) or die ("Erreur SQL : ".mysql_error($db));
    if($result){
        while ($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			$row_array['value']=$row["LIBINSTIT"];
			$row_array['idinstit']=$row["IDINSTIT"];
    		$return_arr[]=$row_array;
    	}
        echo json_encode($return_arr);    		
   	} else echo 'Erreur SQL';
    mysql_close($db);
}	
?>