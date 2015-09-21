<?php
//------------------------------------------------------------------------------//
//  module_gestion/lr-liste.php                                                 //
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
include ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ PARMS.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($id_page);
		
//------------------------------------------------------------------------------ MAIN
$filters = filter_column($aColumns[$id_page]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	

//------------------------------------------------------------------------------ QUERY
$query=$query_liste." ".$sWhere." ".$sOrder." ".$sLimit;

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
		$sOutput .= "[";
		foreach ($aColumns[$id_page] as $key => $value) {
		/*---------------*/
		/*cas paticuliers*/
		/*---------------*/
			if 	($key == 'aoo_precis')	
				if ($row['aoo_precis'] != 0) {$sOutput .= '"'.$row['aoo_precis'].'",';} else {$sOutput .= '"'.$ref['aoo'][$row['id_aoo']].'",';}
			else if ($key == 'nbloc_precis')
        		if ($row['nbloc_precis'] != 0) {$sOutput .= '"'.$row['nbloc_precis'].'",';} else {$sOutput .= '"'.$ref['nbloc'][$row['id_nbloc']].'",';}
			else if ($key == 'nbm5_post1990_est')
				if ($row['nbm5_post1990_est'] != '') {$sOutput .= '"'.$row['nbm5_post1990_est'].'",';} else {$sOutput .= '"'.$row['nbm5_post1990'].'",';}
			else if ($key == 'notes')
				if ($row['notes'] != '') {$sOutput .= '"<a id=\"'.$row['uid'].'\" ><img src=\"../../_GRAPH/mini/info-icon.png\" title=\"'.sql_format_quote($row['notes'],"undo_hmtl").'\" ></a>",';} else {$sOutput .= '"",';}
		/*---------------*/
		/*cas général avec référentiel*/
		/*---------------*/
			else if (!empty($ref[$champ_ref[$key]]))
				$sOutput .= '"'.$ref[$champ_ref[$key]][$row[$key]].'",';
		/*---------------*/
		/*cas général sans référentiel*/
		/*---------------*/
			elseif ($value["type"] == "bool")
				{if ($row[$key] == 't') $sOutput .= '"oui",'; elseif ($row[$key] == 'f') $sOutput .= '"non",'; else $sOutput .= '"'.$row[$key].'",';}
			else
				$sOutput .= '"'.$row[$key].'",';
			}
		/*---------------*/
		/*dernières colonnes*/
		/*---------------*/
        if ($niveau == 1)                                                       // Lecteur
            $sOutput .= '"<a class=view id=\"'.$row['uid'].'\" target=\"_blank\"><img src=\"../../_GRAPH/mini/view-icon.png\" title=\"Consulter\" ></a>",'; 
        else        
            $sOutput .= '"<a class=edit id=\"'.$row['uid'].'\" target=\"_blank\"><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>",'; 
		$sOutput .= '"<input type=checkbox class=\"liste-one\" name=id value=\"'.$row['uid'].'\" >"';
    	$sOutput .= "],";
	}
	$sOutput = substr_replace( $sOutput, "", -1 );
	$sOutput .= '] }';
echo $sOutput;

?>
