<?php
//------------------------------------------------------------------------------//
//  module_admin/suivi-liste.php                                                //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  15/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
session_start();
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");
require_once ("../../_INCLUDE/constants.inc.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau'];
$niveau_lr=isset ($_SESSION['niveau_lr']) ? $_SESSION['niveau_lr'] : 0;
$niveau_eee=isset ($_SESSION['niveau_eee']) ? $_SESSION['niveau_eee'] : 0;
$niveau_lsi=isset ($_SESSION['niveau_lsi']) ? $_SESSION['niveau_lsi'] : 0;
$niveau_refnat=isset ($_SESSION['niveau_refnat']) ? $_SESSION['niveau_refnat'] : 0;
$niveau_catnat=isset ($_SESSION['niveau_catnat']) ? $_SESSION['niveau_catnat'] : 0;

$table="suivi";
$aColumns = array('s.uid','u.nom','lib_cbn','cd_ref','nom_scien','rubrique','type_modif','methode','description','libelle_1','libelle_2','day','hour','id_suivi');
$sIndexColumn = "id_suivi";
$ouinon_txt=array("","<b>X</b>");

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

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
									// Filtres
$sWhere = ""; 
if ($niveau_lr >= 128)
	$add['lr'] = "rubrique_champ = 'lr'";
if ($niveau_eee >= 128)
	$add['eee'] = "rubrique_champ = 'eee'";
if ($niveau_catnat >= 128)
	$add['catnat'] = "rubrique_champ = 'catnat'";
if ($niveau_refnat >= 128)
	$add['eval_refnat'] = "rubrique_champ = 'refnat'";
if ($niveau_lsi >= 128)
	$add['lsi'] = "rubrique_champ = 'lsi'";
if (!empty($add))
	$sWhere = " AND (".implode($add,' OR ').")"; 


if ( $_GET['sSearch'] != "" )
{
    $sWhere = "AND ( uid = ".pg_escape_string( $_GET['sSearch'] )." OR ".
		                "u.nom ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "lib_cbn = ".pg_escape_string( $_GET['sSearch'] )." OR ".
		                "cd_ref = ".pg_escape_string( $_GET['sSearch'] )." OR ".
		                "nom_sci = ".pg_escape_string( $_GET['sSearch'] )." OR ".
		                "rubrique_champ ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "description ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "type_modif ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "methode ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "datetime ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "libelle_1 ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%' OR ".
		                "libelle_2 ILIKE '%".pg_escape_string( $_GET['sSearch'] )."%')";
}

For ( $i=0 ; $i<count($aColumns) ; $i++ )                                       // columnFilter v2
{
	if ( isset($_GET['bSearchable_'.$i]) && $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '' )
	{
        if ($aColumns[$i] == 'datetime' ) 
            	$sWhere .= " AND substring(datetime::text from 1 for 10) ILIKE '%".pg_escape_string($_GET['sSearch_'.$i])."%'";
        else if ($aColumns[$i] == 'hour' )
            	$sWhere .= " AND substring(datetime::text from 11 for 16) ILIKE '%".pg_escape_string($_GET['sSearch_'.$i])."%'";
      	else
				$sWhere .= " AND ".$aColumns[$i]."::text ILIKE '%".pg_escape_string($_GET['sSearch_'.$i])."%' ";
    	
	}
}

//------------------------------------------------------------------------------ QUERY
$query="SELECT count(*) OVER() AS total_count,s.*,ch.*,u.nom,u.prenom,u.id_cbn,c.lib_cbn,lt.nom as nom_scien, lt.cd_ref, s.datetime as hour, s.datetime as day
 FROM applications.suivi AS s 
 LEFT JOIN applications.utilisateur AS u ON u.id_user=s.id_user 
 LEFT JOIN referentiels.cbn AS c ON c.id_cbn=u.id_cbn 
 LEFT JOIN referentiels.champs AS ch ON s.champ=ch.champ_interface AND s.tables = ch.table_champ AND s.rubrique=ch.rubrique_champ
 LEFT JOIN applications.taxons AS lt ON lt.uid=s.uid
 WHERE (libelle_1 <> '-' AND  libelle_2 <> '-') ".$sWhere." ".$sOrder." ".$sLimit;

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
		$sOutput .= '"'.$row['uid'].'",';
		$sOutput .= '"<b>'.$row['id_user'].'</b><br>'.$row['u.nom'].' '.$row['prenom'].'",';
		$sOutput .= '"'.$row['lib_cbn'].'",';
		$sOutput .= '"'.$row['cd_ref'].'",';
		$sOutput .= '"'.$row['nom_scien'].'",';
		$sOutput .= '"'.$row['rubrique'].'",';
		$sOutput .= '"'.$row['type_modif'].'",';
		$sOutput .= '"'.$row['methode'].'",';
		$sOutput .= '"'.$row['description'].'",';
		// $sOutput .= '"'.$row['libelle_1'].'",';
		// $sOutput .= '"'.$row['libelle_2'].'",';
		$sOutput .= '"'.sql_format_quote($row['libelle_1'],'undo_hmtl').'",';
		$sOutput .= '"'.sql_format_quote($row['libelle_2'],'undo_hmtl').'",';
		$sOutput .= '"'.strftime ("%d/%m/%Y",strtotime ($row['datetime'])).'",';
		$sOutput .= '"'.substr ($row['datetime'],11,5).'",';
		$sOutput .= '"'.$row['id_suivi'].'",';
		$sOutput .= '"<input type=checkbox class=\"admin-suivi-liste-one\" name=id value=\"'.$row['id_suivi'].'\" >"';
		$sOutput .= "],";
	}
	$sOutput = substr_replace ($sOutput,"",-1);
	$sOutput .= '] }';
	echo $sOutput;


//------------------------------------------------------------------------------ FONCTIONS

?>
