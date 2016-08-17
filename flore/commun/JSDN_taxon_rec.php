<?php
header('Content-Type: text/html; charset=ISO-8859-1'); 
//------------------------------------------------------------------------------//
//  commun/JSDN_taxon_rec.PHP                                                   //
//                                                                              //
//  SILENE-Flore                                                                //
//  Module extrene : Typologie des habitats naturels du PNM                     //
//                                                                              //
//  Version 1.00  17/10/12 - OlGa                                               //
//  Version 2.00  17/12/14 - Nouvelle méthode de saisie des taxons (3e3)        //
//  Version 2.02  23/12/14 - Aj utf8_encode                                     //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("../../_INCLUDE/config_sql.inc.php");
include ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$param=$_POST["term"];
$SQL=$_POST["sql"];
//echo "variable sql:".$SQL."<br>";

//------------------------------------------------------------------------------ MAIN
if(strlen($param)>0 && $SQL !="" ) {
    $find = explode (" ",$param);

//------------------------------------------------------------------------------ CONNEXION SERVEUR postgresql
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);
 //   $db_selected=mysql_select_db(SQL_base,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

    $query=$SQL." nom_complet_taxon_referentiel ILIKE '".$find[0]."% ".$find[1]."%'  ORDER BY nom_complet_taxon_referentiel ASC LIMIT 50;";
//	echo $query."<br>";
	$result=pg_query($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
    //$result=mysql_query($query,$db) or die ("Erreur SQL : ".mysql_error($db));
    if ($result) {
     	$sOutput = '[';
        while ($row = pg_fetch_array($result,NULL,PGSQL_ASSOC)) {
			$row_array['CD_REF'] = $row["cd_ref"]; //je le mets en minuscule car la requete envoyee ne respecte pas la casse des noms de champs en majuscule
			$row_array['NOM_COMPLET'] = utf8_encode ($row["nom_complet"]); //je le mets en minuscule car la requete envoyee ne respecte pas la casse des noms de champs en majuscule
//			$row_array['idrattachement'] = utf8_encode ($row["id_rattachement_referentiel"]); //je le mets en minuscule car la requete envoyee ne respecte pas la casse des noms de champs en majuscule
    		$return_arr[]=$row_array;
    	}
        echo json_encode($return_arr);    		
   	} else echo 'Erreur SQL';

    pg_close ($db);
}	
?>
