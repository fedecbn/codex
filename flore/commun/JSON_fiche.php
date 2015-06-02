<?php
header('Content-Type: text/html; charset=ISO-8859-1'); 
//------------------------------------------------------------------------------//
//  commun/JSON_fiche.PHP                                                       //
//                                                                              //
//  Banque de semences VANDA                                                    //
//                                                                              //
//  Version 1.00  21/04/13 - DariaNet                                           //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ VAR.
$param=$_GET["term"];

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base_SILENE,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ MAIN
if(strlen($param)>0) {
    $query="SELECT IDFICHE,IDINSEE,LIEUDIT FROM fiches WHERE IDFICHE REGEXP '^$param' LIMIT 20";    
    $result=mysql_query($query,$db) or die ("Erreur SQL : ".mysql_error($db));
    if ($result) {
     	$sOutput = '[';
        while ($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
    		$sOutput .= "{";
    		$sOutput .= '"value":"'.$row['IDFICHE'].'",';
       		$sOutput .= '"insee_commune":"'.$row["IDINSEE"].'",';
       		$sOutput .= '"lieu_dit":"'.$row["LIEUDIT"].'"';
    		$sOutput .= "},";
    	}
    	$sOutput = substr_replace( $sOutput, "", -1 );
    	$sOutput .= ']';
    	echo $sOutput;
   	} else echo 'Erreur SQL';
    mysql_close ($db);
}	
?>

