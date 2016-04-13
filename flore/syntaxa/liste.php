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
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ PARMS.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.		
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($id_page);
// var_dump($aColumns[$id_page]);
//var_dump($champ_ref);
//var_dump($ref['codeEnregistrementSyntax']);
// var_dump($ref['nomSyntaxonRetenu']);
//------------------------------------------------------------------------------ FILTERS
$filters = filter_column($aColumns[$id_page]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	

//------------------------------------------------------------------------------ QUERY
$query= $query_liste." ".$sWhere." ".$sOrder." ".$sLimit;

 //echo "<br>".$query;

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

		/*---------------*/
		/*cas général avec référentiel*/
		/*---------------*/
			// else if (!empty($ref[$key]))
			if (!empty($ref[$champ_ref[$key]]))
				$sOutput .= '"'.$ref[$champ_ref[$key]][$row[$key]].'",';
		/*---------------*/
		/*cas général sans référentiel*/
		/*---------------*/
			else
				$sOutput .= '"'.$row[$key].'",';
			}
		/*---------------*/
		/*dernières colonnes*/
		/*---------------*/
        if ($niveau == 1)                                                       // Lecteur
            $sOutput .= '"<a class=view id=\"'.$row['codeEnregistrementSyntax'].'\" ><img src=\"../../_GRAPH/mini/view-icon.png\" title=\"Consulter\" ></a>",'; 
        else        
            $sOutput .= '"<a class=edit id=\"'.$row['codeEnregistrementSyntax'].'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>",'; 
		$sOutput .= '"<input type=checkbox class=\"liste-one\" name=id value=\"'.$row['codeEnregistrementSyntax'].'\" >"';
    	$sOutput .= "],";
	}
	$sOutput = substr_replace( $sOutput, "", -1 );
	$sOutput .= '] }';
echo $sOutput;

	//------------------------------------------------------------------------------ SI PAS ACCES 
	} else {
	$sOutput = '{';
	$sOutput .= '"sEcho": '.intval($_GET['sEcho']).', ';
	$sOutput .= '"iTotalRecords": '.$iTotal.', ';
	$sOutput .= '"iTotalDisplayRecords": '.$aResultTotal.', ';
	$sOutput .= '"aaData": [ ';
	$sOutput .= '] }';
	echo $sOutput;
	}

?>
