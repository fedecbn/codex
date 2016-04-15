<?php
//------------------------------------------------------------------------------//
//  bugs/bugs-encours-liste.php                                                 //
//                                                                              //
//  Version 1.00  26/08/12 - DariaNet                                           //
//  Version 1.10  11/10/13 - MaJ liste v2                                       //
//  Version 1.20  10/08/14 - MaJ pgSQL                                          //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau'];
$table="bug";
$aColumns = array('id_bug','cat','date_bug','auteur','id_rubrique','b.descr','statut','statut_descr','statut');
$sIndexColumn = "id_bug";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
$sLimit = "";                                                                   // Paging
if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".pg_escape_string( $_GET['iDisplayLength'] )." OFFSET ".pg_escape_string( $_GET['iDisplayStart'] );

$sWhere = "";                                                                   // FILTRE
if ( $_GET['sSearch'] != "" )
{
    $sWhere = "AND ( b.descr LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "statut_descr LIKE '%".pg_escape_string( $_GET['sSearch'] )."%' )";
}
For ( $i=0 ; $i<count($aColumns) ; $i++ )                                       // columnFilter
{
	if ( isset($_GET['bSearchable_'.$i]) && $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '' )
	{
      	if ($aColumns[$i] == 'id_bug' || $aColumns[$i] == 'cat' || $aColumns[$i] == 'statut' ) {
        	$sWhere .= " AND ".$aColumns[$i]." = ".pg_escape_string($_GET['sSearch_'.$i])." ";
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
$query="SELECT count(*) OVER() AS total_count,b.*,CONCAT(u.prenom,' ',u.nom) AS auteur
FROM ".SQL_schema_app.".bug AS b
LEFT JOIN ".SQL_schema_app.".utilisateur AS u ON b.id_user=u.id_user 
WHERE (statut=0 OR statut=1 OR statut=4 )".$sWhere." ".$sOrder." ".$sLimit;
//echo $query;

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
		$sOutput .= '"'.$row['id_bug'].'",';
        if ($row["cat"] !=0 ) 
            $sOutput .= '"<img src=\"../../_GRAPH/mini/cat_'.$row["cat"].'.png\" title=\"'.$cat_txt[$row["cat"]].'\" />",';
        else 
    		$sOutput .= '"",';
        $sOutput .= '"'.date("d/m/Y", strtotime($row['date_bug'])).'",';
		$sOutput .= '"'.str_replace('"', '\"', $row['auteur']).'",';
		$sOutput .= '"<b>'.$rubriques_txt[$row['id_rubrique']].'</b>",';
		$sOutput .= '"'.sql_format_quote($row['descr'],"undo_list").'",';
		$sOutput .= '"<b>'.$statut_txt[$row['statut']].'</b>",';

		if (strlen($row['statut_descr'])>1 ) 
    		$sOutput .= '"'.sql_format_quote($row['statut_descr'],"undo_list").'",';
		else 
		    $sOutput .= '"",';
		$sOutput .= '"'.$row['statut'].'",';
        if ($niveau == 64) 
            $sOutput .= '"<a class=bug-encours-edit id=\"'.$row['id_bug'].'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>"'; 
        if ($niveau >= 255) 
            $sOutput .= '"<a class=bug-encours-edit id=\"'.$row['id_bug'].'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a><a class=bug-encours-del id=\"'.$row['id_bug'].'\" ><img src=\"../../_GRAPH/mini/del-icon.png\" title=\"Supprimer\" ></a>"'; 
        else
            $sOutput .= '""';
    	$sOutput .= "],";
	}
	$sOutput = substr_replace( $sOutput, "", -1 );
	$sOutput .= '] }';
echo $sOutput;
?>

