<?php
//------------------------------------------------------------------------------//
//  module_gestion/eee-liste.php                                                 //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ liste                                          //
//  Version 1.02  21/08/14 - MaJ droits                                         //
//  Version 1.03  22/08/14 - MaJ liste                                          //
//  Version 1.04  31/08/14 - MaJ liste (Aj champs)                              //
//  Version 1.05  08/09/14 - MaJ liste                                          //
//  Version 1.06  23/09/14 - MaJ sOrder                                         //
//  Version 1.07  24/09/14 - MaJ columnFilter                                   //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
include_once ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$onglet = $_GET['onglet'];
//------------------------------------------------------------------------------ PARMS.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
ref_colonne_et_valeur ($onglet);

//------------------------------------------------------------------------------ FILTERS
$filters = filter_column($aColumns[$onglet]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	

//------------------------------------------------------------------------------ QUERY
$query = $query_liste[$_GET['onglet']].$sWhere." ".$sOrder." ".$sLimit;
// echo "<br>".$query;

$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
if (pg_num_rows ($result)) 
    $aResultTotal=pg_result($result,0,"total_count");
else $aResultTotal=0; 
$iTotal = $aResultTotal;

	$sOutput = '{';
	$sOutput .= '"sEcho": '.intval($_GET['sEcho']).', ';
	$sOutput .= '"iTotalRecords": '.$iTotal.', ';
//	$sOutput .= '"iTotalDisplayRecords": '.$iFilteredTotal.', ';
	$sOutput .= '"iTotalDisplayRecords": '.$aResultTotal.', ';
	$sOutput .= '"aaData": [ ';
    while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC)) 
	{
		if ($onglet == "fsd") $id = $row['uid']; else $id = $row['cd_ddd'];
		$sOutput .= "[";
		foreach ($aColumns[$onglet] as $key => $value) {
		/*---------------*/
		/*cas paticuliers*/
		/*---------------*/
			if ($key == 'regleRens')
				if (!empty($row['regleRens'])) {$sOutput .= '"<img src=\"../../_GRAPH/mini/info-icon.png\" title=\"'.sql_format_quote($row['regleRens'],'undo_table').'\" >",';} else {$sOutput .= '"",';}
			elseif ($key == 'vocaCtrl')
				if (!empty($row['vocaCtrl'])) {$sOutput .= '"<img class=\"vocactrl\" id=\"'.sql_format_quote($row['vocaCtrl'],'undo_table').'\" src=\"../../_GRAPH/mini/fiche-icon.png\" title=\"'.sql_format_quote($row['vocaCtrl'],'undo_table').'\" >",';} else {$sOutput .= '"",';}
			elseif ($key == 'discussion')
				if (!empty($row['discussion'])) {$sOutput .= '"<img class=\"discussion\" id=\"'.sql_format_quote($row['discussion'],'undo_table').'\" src=\"../../_GRAPH/mini/attention-icon.png\" title=\"'.sql_format_quote($row['discussion'],'undo_table').'\" >",';} else {$sOutput .= '"",';}
		/*---------------*/
		/*cas général avec référentiel*/
		/*---------------*/
			else if (!empty($ref[$key]))
				$sOutput .= '"'.$ref[$key][$row[$key]].'",';
		/*---------------*/
		/*cas général sans référentiel*/
		/*---------------*/
			elseif ($value["type"] == "bool")
				{if ($row[$key] == 't') $sOutput .= '"oui",'; elseif ($row[$key] == 'f') $sOutput .= '"non",'; else $sOutput .= '"'.$row[$key].'",';}
			else
				$sOutput .= '"'.sql_format_quote($row[$key],'undo_table').'",';
			}
		/*---------------*/
		/*dernières colonnes*/
		/*---------------*/
        if ($niveau == 1)                                                       // Lecteur
            $sOutput .= '"<a class=view id=\"'.$id.'\" ><img src=\"../../_GRAPH/mini/view-icon.png\" title=\"Consulter\" ></a>",'; 
        else        
            $sOutput .= '"<a class=edit id=\"'.$id.'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>",'; 
		$sOutput .= '"<input type=checkbox class=\"liste-one\" name=id value=\"'.$id.'\" >"';
    	$sOutput .= "],";
	}
	$sOutput = substr_replace( $sOutput, "", -1 );
	$sOutput .= '] }';
echo $sOutput;

?>
