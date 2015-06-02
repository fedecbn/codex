<?php
//------------------------------------------------------------------------------//
//  module_admin/text-liste.php                                                 //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
session_start();
include ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau'];
$table="pres";
$aColumns = array('id_pres','page','titre','lang');
$sIndexColumn = "id_pres";
$lang_ico = array('fr.gif','it.gif','en.gif');

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
$sLimit = "";                                                                   // Paging
if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".$_GET['iDisplayLength'];
//	$sLimit = "LIMIT ".pg_escape_string( $_GET['iDisplayStart'] ).", ".pg_escape_string( $_GET['iDisplayLength'] );

if (isset( $_GET['iSortCol_0'] ) )                                              // ORDER BY
{
	$sOrder="ORDER BY ";
	for ( $i=0 ; $i<intval( $_GET['iSortingCols'] ) ; $i++ ) {
		if ( $_GET[ 'bSortable_'.intval($_GET['iSortCol_'.$i]) ] == "true" ) {
			$sOrder .= $aColumns[ intval( $_GET['iSortCol_'.$i] ) ]." ".pg_escape_string( $_GET['sSortDir_'.$i] ) .", ";
		}
	}
	$sOrder = substr_replace( $sOrder, "", -2 );
	if ( $sOrder == "ORDER BY" )
		$sOrder = "";
}
$sWhere = "";                                                                   // Filtres
$query="SELECT * FROM ".SQL_schema_app.".".$table." WHERE 1=1 ".$sOrder." ".$sLimit;
//echo  $query;
$rResult=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($rResult));
/*
$query = "SELECT FOUND_ROWS()";
$rResultFilterTotal = mysql_query($query,$db) or die ($query." Erreur mySQL : ".mysql_error($db));
$aResultFilterTotal = mysql_fetch_array($rResultFilterTotal);
$iFilteredTotal = $aResultFilterTotal[0];

$query = "SELECT COUNT(".$sIndexColumn.") FROM $table ";
$rResultTotal = mysql_query($query,$db) or die ($query." Erreur mySQL : ".mysql_error($db));
$aResultTotal = mysql_fetch_array($rResultTotal);
*/
$query = "SELECT COUNT(".$sIndexColumn.") AS nbre FROM ".SQL_schema_app.".".$table.";";
//echo  $query;
$result = pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($rResultTotal)); 
$aResultTotal=pg_result($result,0,"nbre");
pg_free_result ($result);
$iTotal = $aResultTotal;
	$sOutput = '{';
	$sOutput .= '"sEcho": '.intval($_GET['sEcho']).', ';
	$sOutput .= '"iTotalRecords": '.$iTotal.', ';
//	$sOutput .= '"iTotalDisplayRecords": '.$iFilteredTotal.', ';
	$sOutput .= '"iTotalDisplayRecords": '.$aResultTotal.', ';
	$sOutput .= '"aaData": [ ';
    while ($row=pg_fetch_array ($rResult,NULL,PGSQL_ASSOC)) 
	{
		$sOutput .= "[";
		$sOutput .= '"'.str_replace('"', '\"', $row['id_module']).'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['titre']).'",';
		$sOutput .= '"<img src=\"../../_GRAPH/'.$lang_ico[$row['lang']].'\" >",';
        $sOutput .= '"<a class=admin-text-edit id=\"'.$row['id_pres'].'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>"';
		$sOutput .= "],";
	}
	$sOutput = substr_replace ($sOutput, "", -1);
	$sOutput .= '] }';
	echo $sOutput;

//------------------------------------------------------------------------------ FONCTIONS

?>
