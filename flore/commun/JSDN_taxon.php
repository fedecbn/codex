<?php
header('Content-Type: text/html; charset=ISO-8859-1'); 
//------------------------------------------------------------------------------//
//  commun/JSDN_taxon.PHP                                                       //
//                                                                              //
//  Banque de semences VANDA                                                    //
//                                                                              //
//  Version 1.00  04/08/12 - DariaNet                                           //
//  Version 1.01  21/04/13 - Aj famille                                         //
//  Version 1.10  28/08/13 - MaJ saisie 3e3                                     //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ VAR.
$param=$_GET["term"];

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ MAIN
if (strlen ($param)>0) {
    $find = explode (" ",$param);
//  $query="SELECT CD_NOM,CD_REF,NOM_COMPLET,NOM_VALIDE,NOM_VERN,FAMILLE FROM ref_taxref WHERE NOM_COMPLET REGEXP '^$param' ORDER BY NOM_COMPLET LIMIT 20";
    $query="SELECT CD_NOM,CD_REF,NOM_COMPLET,NOM_VALIDE,NOM_VERN,FAMILLE FROM ref_taxref WHERE NOM_COMPLET LIKE '".$find[0]."% ".$find[1]."%' ORDER BY REC DESC,RANG,NOM_COMPLET LIMIT 50";
    $result=mysql_query($query,$db) or die ("Erreur SQL : ".mysql_error($db));
//  echo $query;
    if ($result) {
     	$sOutput = '[';
        while ($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
            $nc=utf8_encode($row["NOM_COMPLET"]);
            $row_array['value'] = $nc;
            $row_array['NOM_COMPLET'] = $nc;
			$row_array['CD_NOM'] = $row["CD_NOM"];;
			$row_array['CD_REF'] = $row["CD_REF"];
			$row_array['NOM_VERN'] = $row["NOM_VERN"];
			$row_array['FAMILLE'] = $row["FAMILLE"];
/*
            if ($row_array['CD_NOM'] == $row_array['CD_REF'])
                $row_array['label'] = "<b>".$nc."</b>";
            else
*/
                $row_array['label'] = $nc;
			$row_array['nom_rec'] = utf8_encode($row["NOM_VALIDE"]);
    		$return_arr[]=$row_array;
    	}
        echo json_encode($return_arr);    		
   	} else echo 'Erreur SQL';
    mysql_close ($db);
}	
?>

