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
$onglet = $_GET['onglet'];
// $class = $onglet == 'hub' ? 'edit' : 'hub';

//------------------------------------------------------------------------------ PARMS.
/*Droit sur les boutons de la dernière colonne*/
$typ_droit='d2';$rubrique=$id_page;$droit_user = $_SESSION['droit_user'][$id_page];
$view=affichage($typ_droit,$rubrique,$onglet,"view_fiche",$droit_user);
$edit=affichage($typ_droit,$rubrique,$onglet,"edit_fiche",$droit_user);

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
$db2=sql_connect_hub(SQL_base_hub);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);
				
//------------------------------------------------------------------------------ REF.		
ref_colonne_et_valeur ($onglet);

//------------------------------------------------------------------------------ FILTERS
$filters = filter_column($aColumns[$onglet]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	

//------------------------------------------------------------------------------ QUERY
$query= $query_liste[$_GET['onglet']]." ".$sWhere." ".$sOrder." ".$sLimit;

// echo "<br>".$query;

// $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
$result=pg_query ($db2,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
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

		/*---------------*/
		/*cas général avec référentiel*/
		/*---------------*/
			// else if (!empty($ref[$key]))
			if (!empty($ref[$key]))
				$sOutput .= '"'.$ref[$key][$row[$key]].'",';
		/*---------------*/
		/*cas général sans référentiel*/
		/*---------------*/
			else
				$sOutput .= '"'.$row[$key].'",';
			}
		/*---------------*/
		/*dernières colonnes*/
		/*---------------*/
		if ($onglet == 'hub') {
			/*boutons*/
			if ($edit) 		$sOutput .= '"'.bt_edit($row['uid']).'",'; 
			elseif ($view) 	$sOutput .= '"'.bt_view($row['uid']).'",'; 
			else 			$sOutput .= '"",';
			/*checkbox*/
			$sOutput .= '"<input type=checkbox class=\"liste-one\" name=id value=\"'.$row['uid'].'\" >"';
			}
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
