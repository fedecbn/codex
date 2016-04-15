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
$onglet = 'eval';

//------------------------------------------------------------------------------ PARMS.
/*Droit sur les boutons de la dernière colonne*/
$typ_droit='d2';$rubrique=$id_page;$droit_user = $_SESSION['droit_user'][$id_page];
// $view=affichage($typ_droit,$rubrique,$onglet,"view_fiche",$droit_user);
// $edit=affichage($typ_droit,$rubrique,$onglet,"edit_fiche",$droit_user);
// $validate=affichage($typ_droit,$rubrique,$onglet,"validate_fiche",$droit_user);

$typ_droit='d2';$rubrique=$id_page;$onglet = 'lr';
$droit = ref_droit($id_user,$typ_droit,$rubrique,$onglet);
// var_dump($droit);

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($id_page);


//------------------------------------------------------------------------------ MAIN
$filters = filter_column_post($aColumns[$id_page]);
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

//------------------------------------------------------------------------------ Liste
	$sOutput = '{';
	// $sOutput .= '"sEcho": '.intval($_GET['sEcho']).', ';
	$sOutput .= '"sEcho": '.intval($_POST['sEcho']).', ';
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
				if ($row['notes'] != '') {$sOutput .= '"<a id=\"'.$row['uid'].'\" ><img src=\"../../_GRAPH/mini/info-icon.png\" title=\"'.sql_format_quote($row['notes'],"undo_list").'\" ></a>",';} else {$sOutput .= '"",';}
			else if ($key == 'val_com')
				if ($row['val_com'] != '') {$sOutput .= '"<a id=\"'.$row['uid'].'\" ><img src=\"../../_GRAPH/mini/info-icon.png\" title=\"'.sql_format_quote($row['val_com'],"undo_list").'\" ></a>",';} else {$sOutput .= '"",';}
			else if ($key == 'bouton')
				// if ($edit) 	$sOutput .= '"'.bt_edit($row['uid']).'",';  elseif ($view) 	$sOutput .= '"'.bt_view($row['uid']).'",'; else $sOutput .= '"",';
				if ($droit['edit_fiche']) 	$sOutput .= '"'.bt_edit($row['uid']).'",';  elseif ($droit['view_fiche']) 	$sOutput .= '"'.bt_view($row['uid']).'",'; else $sOutput .= '"",';
			else if ($key == 'checkbox') $sOutput .= '"<input type=checkbox class=\"liste-one\" name=id[] value=\"'.$row['uid'].'\" >",';
			else if ($key == 'validation') {
				// $sOutput .= '"'.$row[$key].'<img id=\"validation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/validate.png\"  title=\"validé\" style=\"display:none\" /><img id=\"invalidation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/invalidate.png\"  title=\"validé\" style=\"display:none\" />",';
					if ($row['validation'] == 'valid') $sOutput .= '"<img id=\"validation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/validate.png\"  title=\"validé\" style=\"\" /><img id=\"invalidation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/invalidate.png\"  title=\"validé\" style=\"display:none\" />",';
					elseif ($row['validation'] == 'invalid') $sOutput .= '"<img id=\"validation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/validate.png\"  title=\"validé\" style=\"display:none\" /><img id=\"invalidation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/invalidate.png\"  title=\"validé\" style=\"\" />",';
					else $sOutput .= '"<img id=\"validation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/validate.png\"  title=\"validé\" style=\"display:none\" /><img id=\"invalidation_'.$row['uid'].'\" src=\"../../_GRAPH/mini/invalidate.png\"  title=\"validé\" style=\"display:none\" />",';
				}
			else if ($key == 'bouton_valid') {
				// if ($validate AND $row['avancement'] == 3) 	{
				if ($droit['validate_fiche'] AND $row['avancement'] == 3) 	{
					if ($row['validation'] == null) $sOutput .= '"'.bt_validate($row['uid'],'valid').'",'; 
					elseif ($row['validation'] == 'valid') $sOutput .= '"'.bt_validate($row['uid'],'invalid').'",'; 
					elseif ($row['validation'] == 'invalid') $sOutput .= '"'.bt_validate($row['uid'],'revalid').'",'; 
					}
					else $sOutput .= '"",';
				}
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
