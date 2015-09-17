<?php
//------------------------------------------------------------------------------//
//  module_admin/user-liste.php                                                 //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  15/08/14 - Aj $user_level                                     //
//  Version 1.02  18/08/14 - MaJ query                                          //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
session_start();
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");
require_once ("../../_INCLUDE/constants.inc.php");
include_once ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
// $niveau=$_SESSION['niveau'];
$table="utilisateur";
$aColumns = array('id_user','prenom','nom','lib_cbn','login','niveau_lr','niveau_eee','niveau_catnat','niveau_refnat','niveau_lsi','ref_lr','ref_eee','ref_catnat','ref_refnat','ref_lsi');
$sIndexColumn = "id_user";
$ouinon_txt=array("","<b>X</b>");

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

/*id_cbn du USER*/
$query="SELECT id_cbn FROM applications.utilisateur WHERE id_user = '$id_user'";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
$row = pg_fetch_row($result);
$id_cbn = $row[0];

//------------------------------------------------------------------------------ MAIN
	
$sLimit = "";                                                                   // Paging
if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".pg_escape_string( $_GET['iDisplayLength'] )." OFFSET ".pg_escape_string( $_GET['iDisplayStart'] );

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
$sWhere = "";                                                                   // Filtres
if ( $_GET['sSearch'] != "" )
{
    $sWhere = "AND ( u.id_user LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.prenom LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.nom LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "c.lib_cbn LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.login LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.niveau_lr = ".$_GET['sSearch']." OR ".
		                "u.niveau_eee LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.niveau_catnat LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.niveau_refnat LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.niveau_lsi LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.ref_lr = ".$_GET['sSearch']." OR ".
		                "u.ref_eee LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.ref_catnat LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.ref_refnat LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "u.ref_lsi LIKE '%".pg_escape_string( $_GET['sSearch'] )."%'
						)";
}
For ( $i=0 ; $i<count($aColumns) ; $i++ )                                       // columnFilter v2
{
	if ( isset($_GET['bSearchable_'.$i]) && $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '' )
	{
	if ($i == 5 or $i == 6 or $i == 7 or $i == 8 or $i == 9)
		$sWhere .= " AND ".$aColumns[$i]." = ".pg_escape_string($_GET['sSearch_'.$i])." ";
	else
    	$sWhere .= " AND ".$aColumns[$i]." LIKE '%".pg_escape_string($_GET['sSearch_'.$i])."%' ";
	}
}
//------------------------------------------------------------------------------ QUERY
if ($ref['all'] === 'f' AND $niveau['all'] < 255) $where1="WHERE u.id_cbn = $id_cbn";
elseif ($ref['all'] === 't' AND $niveau['all'] < 255) $where1="WHERE u.id_cbn = $id_cbn";
else $where1="WHERE 1=1" ;

$query="SELECT count(*) OVER() AS total_count,u.id_user,u.prenom,u.nom,c.lib_cbn,u.login,u.niveau_lr,u.niveau_eee,u.niveau_catnat,u.niveau_refnat,u.niveau_lsi,u.ref_lr,u.ref_eee,u.ref_catnat,u.ref_refnat,u.ref_lsi
FROM applications.utilisateur AS u
LEFT JOIN referentiels.cbn AS c ON c.id_cbn=u.id_cbn
$where1 ".$sWhere." ".$sOrder." ".$sLimit;

// echo  $query;

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
		$sOutput .= '"'.$row['id_user'].'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['prenom']).'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['nom']).'",';
		$sOutput .= '"'.$row['lib_cbn'].'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['login']).'",';
		foreach ($rub as $key => $val)
			$sOutput .= '"'.$user_level[$row['niveau_'.$key]].'",';
		foreach ($rub as $key => $val)	{
			if ($row['ref_'.$key] === 't') $row['ref_'.$key] = 'oui'; else $row['ref_'.$key] = 'non';
			$sOutput .= '"'.$row['ref_'.$key].'",';
			}
/*
        if ($row['niveau'] == 255) $sOutput .= '"<img src=\"../../_GRAPH/admin.png\" border=\"0\" title=\"Admin.\" />",';
		else $sOutput .= '"'.str_replace('"', '\"', $row['niveau']).'",';
*/
        // if ($niveau['all'] < 255 AND $ref['all'] == 'f') $sOutput .= '""';
        if ($niveau['all'] < 255 AND $row['id_user'] != $id_user AND $ref['all'] === 'f') $sOutput .= '""';
        elseif (($niveau['all'] < 255 AND $row['id_user'] == $id_user) OR ($niveau['all'] < 255 AND $ref['all'] === 't')) $sOutput .= '"<a class=admin-user-edit id=\"'.$row['id_user'].'\" name=\"'.$id_user.'\"><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>"';
        else $sOutput .= '"<a class=admin-user-edit id=\"'.$row['id_user'].'\" name=\"'.$id_user.'\"><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a> <a class=admin-user-del id=\"'.$row['id_user'].'\" name=\"'.$id_user.'\"><img src=\"../../_GRAPH/mini/del-icon.png\" title=\"Supprimer\" ></a>"'; 
		$sOutput .= "],";
	}
	$sOutput = substr_replace ($sOutput,"",-1);
	$sOutput .= '] }';

	echo $sOutput;

	// var_dump($ref);
//------------------------------------------------------------------------------ FONCTIONS

?>
