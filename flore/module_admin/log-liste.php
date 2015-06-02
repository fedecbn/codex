<?php
//------------------------------------------------------------------------------//
//  module_admin/log-liste.php                                                  //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  15/08/14 - MaJ pour datetime_event                            //
//  Version 1.02  16/09/14 - Aj filtre pour datetime_event                      //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
include ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");

//------------------------------------------------------------------------------ VAR.
$table="log";
$aColumns = array('event','l.id_user','ip','descr1','descr2','tables','datetime_event','datetime_event','id_log');
$sIndexColumn = "id_log";
$log_event_txt=array("","Information","Erreur","Sécurité","Système","Données","Réf");

//------------------------------------------------------------------------------ PARMS.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
	
$sLimit = "";                                                                   // Pagination
if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".pg_escape_string( $_GET['iDisplayLength'] )." OFFSET ".pg_escape_string( $_GET['iDisplayStart'] );

$sWhere = "";                                                                   // Filtres
if ( $_GET['sSearch'] != "" )
{
    $sWhere = "AND ( event LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "id_user LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "ip LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "descr1 LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "descr2 LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "tables LIKE '%".pg_escape_string( $_GET['sSearch'] )."%')";
}
For ( $i=0 ; $i<count($aColumns) ; $i++ )                                       // columnFilter v2
{
	if ( isset($_GET['bSearchable_'.$i]) && $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '' )
	{
        if ($aColumns[$i] == 'event') { 
        	$sWhere .= " AND ".$aColumns[$i]."=".pg_escape_string($_GET['sSearch_'.$i])." ";
      	} elseif ($aColumns[$i] == 'datetime_event' ) {
            $sWhere .= " AND datetime_event::date=TO_DATE('".pg_escape_string($_GET['sSearch_'.$i])."','DD/MM/YYYY') ";
     	} else {
        	$sWhere .= " AND ".$aColumns[$i]." LIKE '%".pg_escape_string($_GET['sSearch_'.$i])."%' ";
    	}
	}
}

$sOrder = "";
if ( isset( $_GET['iSortCol_0'] ) )                                             // ORDER BY
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
//------------------------------------------------------------------------------ QUERY
$query="SELECT count(*) OVER() AS total_count,l.*,u.nom,u.prenom
 FROM ".SQL_schema_app.".log AS l 
 LEFT JOIN ".SQL_schema_app.".utilisateur AS u ON l.id_user=u.id_user
 WHERE 1=1 ".$sWhere." ".$sOrder." ".$sLimit;
//   echo $query;
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
		$sOutput .= '"'.$log_event_txt[$row['event']].'",';
		$sOutput .= '"<b>'.$row['id_user'].'</b><br>'.$row['nom'].' '.$row['prenom'].'",';
		$sOutput .= '"'.$row['ip'].'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['descr1']).'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['descr2']).'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['tables']).'",';
		$sOutput .= '"'.strftime ("%d/%m/%Y",strtotime ($row['datetime_event'])).'",';
		$sOutput .= '"'.substr ($row['datetime_event'],11,5).'",';
		$sOutput .= '"'.$row['id_log'].'",';
		$sOutput .= '"'.$row['event'].'"';
		$sOutput .= "],";
	}
	$sOutput = substr_replace ($sOutput, "", -1 );
	$sOutput .= '] }';
	echo $sOutput;
?>
