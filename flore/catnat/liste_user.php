<?php
/*------------------------------------------------------------------
--------------------------------------------------------------------
 Application Codex		                               			  
 https://github.com/fedecbn/codex					   			  
--------------------------------------------------------------------
 Source de données pour DataTable (liste utilisateurs)     
--------------------------------------------------------------------
--------------------------------------------------------------------*/

//------------------------------------------------------------------------------ INIT.
include ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ PARMS.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ("droit_$id_page");
		
//------------------------------------------------------------------------------ MAIN
$filters = filter_column($aColumns["droit_$id_page"]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	

//------------------------------------------------------------------------------ QUERY
$query=$query_user." ".$sWhere." ".$sOrder." ".$sLimit;

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
		foreach ($aColumns["droit_$id_page"] as $key => $value) {
		/*---------------*/
		/*cas paticuliers*/
		/*---------------*/
		/*---------------*/
		/*cas général avec référentiel*/
		/*---------------*/
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
        // if ($niveau == 1)                                                       // Lecteur
            // $sOutput .= '"<a class=view id=\"'.$row['uid'].'\" ><img src=\"../../_GRAPH/mini/view-icon.png\" title=\"Consulter\" ></a>",'; 
        // else        
            // $sOutput .= '"<a class=edit id=\"'.$row['uid'].'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>",'; 
		// $sOutput .= '"<input type=checkbox class=\"liste-one\" name=id value=\"'.$row['uid'].'\" >"';
    	$sOutput = substr_replace( $sOutput, "", -1 );
		$sOutput .= "],";
	}
	$sOutput = substr_replace( $sOutput, "", -1 );
	$sOutput .= '] }';
echo $sOutput;

?>
