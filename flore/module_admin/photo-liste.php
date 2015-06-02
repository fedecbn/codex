<?php
header('Content-Type: text/html; charset=ISO-8859-1');
//------------------------------------------------------------------------------//
//  module_admin/photo-liste.php                                                //
//                                                                              //
//  Banque de semences ‘VANDA’                                                  //
//                                                                              //
//  Version 1.00  06/03/14 - DariaNet                                           //
//  Version 1.01  10/04/14 - MaJ liste                                          //
//  Version 1.02  28/04/14 - MaJ query & liste                                  //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
session_start();
include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau'];
$table="addinfo_images";
$aColumns = array('i.id','file','file','category_id','CD_REF','NOM_COMPLET','FAMILLE','ID_LOT','DATE_PV','AUTEUR','COMMUNE','CADRAGE','FORME','POIDS','SOURCE','PUBLI');
$sIndexColumn = "id";

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base_photo,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ REF.
$cat_txt[""]="";
$query="SELECT id,name FROM categories;";
$result=mysql_query($query,$db) or die ("Erreur mySQL : ".mysql_error($db));
while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) 
    $cat_txt[$row["id"]]=$row["name"];
mysql_free_result ($result);

$publi_txt=array(""=>"","0"=>"Non","1"=>"Flore","2"=>"Scan","3"=>"Zoom");

//------------------------------------------------------------------------------ MAIN
$sLimit = "";                                                                   // Paging
if (isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".pg_escape_string( $_GET['iDisplayLength'] )." OFFSET ".pg_escape_string( $_GET['iDisplayStart'] );

if (isset( $_GET['iSortCol_0'] ) )                                              // ORDER BY
{
	$sOrder="ORDER BY ";
	for ( $i=0 ; $i<intval( $_GET['iSortingCols'] ) ; $i++ ) {
		if ( $_GET[ 'bSortable_'.intval($_GET['iSortCol_'.$i]) ] == "true" ) {
			$sOrder .= $aColumns[ intval( $_GET['iSortCol_'.$i] ) ]." ".mysql_real_escape_string( $_GET['sSortDir_'.$i] ) .", ";
		}
	}
	$sOrder = substr_replace( $sOrder, "", -2 );
	if ( $sOrder == "ORDER BY" )
		$sOrder = "";
}
$sWhere = "";                                                                   // Filtres
if ( $_GET['sSearch'] != "" )
{
	$sWhere = "AND (";
	for ( $i=0 ; $i<count($fColumns) ; $i++ )
		$sWhere .= $fColumns[$i]." LIKE '%".mysql_real_escape_string( $_GET['sSearch'] )."%' OR ";
	$sWhere = substr_replace( $sWhere, "", -3 );
	$sWhere .= ')';
}

For ( $i=0 ; $i<count($aColumns) ; $i++ )                                       // columnFilter v2
{
	if ( isset($_GET['bSearchable_'.$i]) && $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '' )
	{
        if ($aColumns[$i] == 'meta_date_maj' ) {
            if (strlen($_GET['sSearch_'.$i]) == 10)
        	    $sWhere .= " AND ".$aColumns[$i]." LIKE CONCAT(STR_TO_DATE ('".mysql_real_escape_string($_GET['sSearch_'.$i])."','%d/%m/%Y'),'%') ";
     	} else {
        	$sWhere .= " AND ".$aColumns[$i]." LIKE '%".mysql_real_escape_string($_GET['sSearch_'.$i])."%' ";
    	}
	}
}
//------------------------------------------------------------------------------ QUERY
$query="SELECT count(*) OVER() AS total_count, i.id AS img_id,i.file,i.path,c.category_id,a.*
FROM images AS i
LEFT JOIN addinfo_images AS a ON a.id=i.id 
LEFT JOIN image_category AS c ON c.image_id=a.id 
WHERE 1=1 ".$sWhere." ".$sOrder." ".$sLimit;
//echo $query;
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
if (pg_num_rows ($result)) 
    $aResultTotal=pg_result($result,0,"total_count");
else $aResultTotal=0; 
$iTotal = $aResultTotal[0];

	$sOutput = '{';
	$sOutput .= '"sEcho": '.intval($_GET['sEcho']).', ';
	$sOutput .= '"iTotalRecords": '.$iTotal.', ';
	$sOutput .= '"iTotalDisplayRecords": '.$iFilteredTotal.', ';
	$sOutput .= '"aaData": [ ';
    while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC)) 
	{
		$sOutput .= "[";
		$sOutput .= '"'.$row['img_id'].'",';
        if (file_exists ("../../phototheque/".$row['path']))
    		$sOutput .= '"<img src=\"../../phototheque/'.$row['path'].'\" width=\"70\" height=\"70\" title=\"'.$row['file'].'\" >",';
        else
    		$sOutput .= '"X",';
		$sOutput .= '"'.$row['file'].'",';
		$sOutput .= '"'.$cat_txt[$row['category_id']].'",';
//		$sOutput .= '"'.$row['category_id'].'",';
		$sOutput .= '"'.$row['CD_REF'].'",';
		$sOutput .= '"<b>'.remove_special_car ($row['NOM_COMPLET']).'</b>",';
		$sOutput .= '"'.$row['FAMILLE'].'",';
		$sOutput .= '"'.$row['ID_LOT'].'",';
		$sOutput .= '"'.$row['DATE_PV'].'",';
		$sOutput .= '"'.$row['AUTEUR'].'",';
		$sOutput .= '"'.$row['COMMUNE'].'",';
		$sOutput .= '"'.$row['CADRAGE'].'",';
//		$sOutput .= '"'.remove_special_car( $row['FORME']).'",';
    	$sOutput .= '"'.$row['FORME'].'",';
		$sOutput .= '"'.$row['POIDS'].'",';
		$sOutput .= '"'.$row['SOURCE'].'",';
		$sOutput .= '"'.$publi_txt[$row['PUBLI']].'",';
//		$sOutput .= '"'.$row['PUBLI'].'",';
        if ($niveau < 255 )         
            $sOutput .= '"<a class=photo-edit id=\"'.$row['id'].'\" ><img src=\"../../_GRAPH/edit.gif\" title=\"Modifier\" ></a>"'; 
        else 
            $sOutput .= '"<a class=photo-edit id=\"'.$row['id'].'\" ><img src=\"../../_GRAPH/edit.gif\" title=\"Modifier\" ></a> <a class=photo-del id=\"'.$row['id'].'\" ><img src=\"../../_GRAPH/del.gif\" title=\"Supprimer\" ></a>"'; 
		$sOutput .= "],";
	}
	$sOutput = substr_replace( $sOutput, "", -1 );
	$sOutput .= '] }';
echo $sOutput;

//------------------------------------------------------------------------------ FONCTIONS
function remove_special_car ($string) {
//    return preg_replace ('/[^a-zA-Z0-9_ %\[\]\.\(\)%&-]/s', '', $String);
//    return preg_replace ( '/[\x7f-\xff]/', '', $string);
//    return (preg_replace ("/[^A-Za-z0-9?![:space:]]/", "", $string));
    return (preg_replace ("/[^A-Za-z0-9?.!]/", " ", $string));
    
}

?>
