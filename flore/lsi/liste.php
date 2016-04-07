<?php
/*------------------------------------------------------------------
--------------------------------------------------------------------
 Application Codex		                               			  
 https://github.com/fedecbn/codex					   			  
--------------------------------------------------------------------
 source de données pour DataTable         
--------------------------------------------------------------------
--------------------------------------------------------------------*/
/*------------------------------------------------------------------------------ INITIALISATION*/ 
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
		
//------------------------------------------------------------------------------ MAIN
$filters = filter_column($aColumns[$id_page]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	
$sHaving = $filters['sHaving']; 	

//------------------------------------------------------------------------------ QUERY
$query=$query_liste." ".$sWhere." ".$group_by." ".$sHaving." ".$sOrder." ".$sLimit;

//------------------------------------------------------------------------------ QUERY


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
		/*cas général avec référentiel*/
		/*---------------*/
			if (!empty($ref[$champ_ref[$key]]))
				$sOutput .= '"'.$ref[$champ_ref[$key]][$row[$key]].'",';
		/*---------------*/
		/*cas général sans référentiel*/
		/*---------------*/
			else
				$sOutput .= '"'.sql_format_quote($row[$key],'undo_table').'",';
			}
		/*---------------*/
		/*dernières colonnes*/
		/*---------------*/
        if ($niveau == 1)                                                       // Lecteur
            $sOutput .= '"<a class=view id=\"'.$row['id'].'\" ><img src=\"../../_GRAPH/mini/view-icon.png\" title=\"Consulter\" ></a>",'; 
        else        
            $sOutput .= '"<a class=edit id=\"'.$row['id'].'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>",'; 
		$sOutput .= '"<input type=checkbox class=\"liste-one\" name=id value=\"'.$row['id'].'\" >"';
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
