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
include_once ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ VAR.
$onglet = $_GET['onglet'];

//------------------------------------------------------------------------------ PARMS.
/*Droit sur les boutons de la dernière colonne*/
/*Droit sur les boutons de la dernière colonne*/
$typ_droit='d2';$rubrique=$id_page;
$droit = ref_droit($id_user,$typ_droit,$rubrique,$onglet);

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.		
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($onglet);

//------------------------------------------------------------------------------ FILTERS
$filters = filter_column($aColumns[$onglet]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	

//------------------------------------------------------------------------------ QUERY
$query = $query_liste[$onglet].$sWhere." ".$sOrder." ".$sLimit;

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
		foreach ($aColumns[$onglet] as $key => $value) {
		/*---------------*/
		/*cas paticuliers*/
		/*---------------*/
			if 	($key == 'gbif_url')	
				if (!empty($row['gbif_url'])) {$sOutput .= '"<a href=\"'.$row['gbif_url'].'\" id=\"gbif\"  target=\"_blank\" ><img src=\"../../_GRAPH/mini/gbif.png\" title=\"lien gbif\" ></a>",';} else {$sOutput .= '"",';}
			else if ($key == 'eval_expert')
				if ($row['eval_expert'] != '') {$sOutput .= '"<a class=lr-view id=\"'.sql_format_quote($row['eval_expert'],'undo_table').'\" ><img src=\"../../_GRAPH/mini/info-icon.png\" title=\"'.sql_format_quote($row['eval_expert'],'undo_table').'\" ></a>",';} else {$sOutput .= '"",';}
			else if ($key == 'bouton')
				if ($droit['edit_fiche']) 	$sOutput .= '"'.bt_edit($row['uid']).'",';  elseif ($droit['view_fiche']) 	$sOutput .= '"'.bt_view($row['uid']).'",'; else $sOutput .= '"",';
			else if ($key == 'checkbox') 
				$sOutput .= '"<input type=checkbox class=\"liste-one\" name=id[] value=\"'.$row['uid'].'\" >",';
		/*---------------*/
		/*cas général avec référentiel*/
		/*---------------*/
			else if (!empty($ref[$champ_ref[$key]]))
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
		$sOutput = trim($sOutput,',');
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
