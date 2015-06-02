<?php
//------------------------------------------------------------------------------//
//  module_gestion/lsi-liste.php                                                 //
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
include ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau'];
$table="news";
$aColumns = array('id','libelle_subject','title','abstract','libelle_tag','link','link_2','date');
$sIndexColumn = 'id';
$bool_txt=array(""=>"","f"=>"","t"=>"<b>Oui</b>");

//------------------------------------------------------------------------------ PARMS.

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);


//------------------------------------------------------------------------------ MAIN
$sLimit = "";                                                                   // Paging
if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".pg_escape_string( $_GET['iDisplayLength'] )." OFFSET ".pg_escape_string( $_GET['iDisplayStart'] );

$sOrder = "";                                                                   // Paging
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

$sWhere = "";                                                                   // FILTRE
if ( $_GET['sSearch'] != "" )
{
	$sWhere=" AND (";
	for ( $i=0 ; $i<count($aColumns) ; $i++ ) 
		$sWhere .= $aColumns[$i]." ILIKE '%".mysql_real_escape_string( $_GET['sSearch'] )."%' OR ";
	$sWhere = substr_replace( $sWhere, "", -3 );
	$sWhere .= ')';
}

For ( $i=0 ; $i<count($aColumns) ; $i++ )                                       // columnFilter v2.1
{
    if ( $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '' )
//	if ( isset($_GET['bSearchable_'.$i]) && $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '' )
	{
        if ($aColumns[$i] == 'cd_rang') {
        	$sWhere .= " AND ".$aColumns[$i]." ='".pg_escape_string($_GET['sSearch_'.$i])."' ";
     	} else {
        	$sWhere .= " AND ".$aColumns[$i]."::text ILIKE '%".pg_escape_string($_GET['sSearch_'.$i])."%' ";
    	}
	}
}
//------------------------------------------------------------------------------ QUERY
$query="SELECT count(*) OVER() AS total_count,n.id,libelle_subject,title,abstract,string_agg(libelle_tag,' / ') as libelle_tag,link,link_2,date
FROM ".SQL_schema_lsi.".news AS n 
LEFT JOIN ".SQL_schema_lsi.".coor_news_tag nt ON n.id=nt.id
LEFT JOIN ".SQL_schema_lsi.".tag t ON nt.id_tag=t.id_tag  
LEFT JOIN ".SQL_schema_lsi.".subject s ON n.id_subject=s.id_subject 
WHERE 1=1 ".$sWhere." GROUP BY n.id,libelle_subject,title,abstract,link, link_2,date ".$sOrder." ".$sLimit;

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
		$sOutput .= '"'.$row['id'].'",';
		$sOutput .= '"'.$row['libelle_subject'].'",';
		$sOutput .= '"'.$row['title'].'",';
		$sOutput .= '"'.$row['abstract'].'",';
		$sOutput .= '"'.$row['libelle_tag'].'",';
		$sOutput .= '"'.$row['link'].'",';
		$sOutput .= '"'.$row['link_2'].'",';
		$sOutput .= '"'.$row['date'].'",';

        if ($niveau == 1)                                                       // Lecteur
            $sOutput .= '"<a class=lsi-view id=\"'.$row['id'].'\" ><img src=\"../../_GRAPH/mini/view-icon.png\" title=\"Consulter\" ></a>",'; 
        else        
            $sOutput .= '"<a class=lsi-edit id=\"'.$row['id'].'\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>",'; 
		$sOutput .= '"<input type=checkbox class=\"lsi-liste-one\" name=id value=\"'.$row['id'].'\" >"';
    	$sOutput .= "],";
	}
	$sOutput = substr_replace( $sOutput, "", -1 );
	$sOutput .= '] }';
echo $sOutput;

?>
