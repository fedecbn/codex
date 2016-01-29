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
$table=$id_page="utilisateur";
$aColumns = array('id_user','prenom','nom','lib_cbn','email','tel_bur','niveau_lr','niveau_eee','niveau_catnat','niveau_refnat','niveau_lsi','niveau_fsd','ref_lr','ref_eee','ref_catnat','ref_refnat','ref_lsi','ref_fsd');
$sIndexColumn = "id_user";
$ouinon_txt=array("","<b>X</b>");

//------------------------------------------------------------------------------ REF.
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($id_page);

//------------------------------------------------------------------------------ MAIN
$filters = filter_column($aColumns[$id_page]);
$sLimit = $filters['sLimit'];  
$sOrder = $filters['sOrder']; 	
$sWhere = $filters['sWhere']; 	

//------------------------------------------------------------------------------ QUERY
	/*id_cbn du USER*/
$query="SELECT id_cbn FROM applications.utilisateur WHERE id_user = '$id_user'";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
$row = pg_fetch_row($result);
$id_cbn = $row[0];

if ($ref['all'] === 'f' AND $niveau['all'] < 255) $where1="WHERE u.id_cbn = $id_cbn";
elseif ($ref['all'] === 't' AND $niveau['all'] < 255) $where1="WHERE u.id_cbn = $id_cbn";
else $where1="WHERE 1=1" ;

$query = "SELECT string_agg(one.champ,',') AS les_champs FROM 
(SELECT nom_champ as champ FROM referentiels.champs WHERE rubrique_champ = 'utilisateur' AND pos IS NOT NULL AND nom_champ <> 'id_cbn' ORDER BY pos) as one;";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

$query_liste="SELECT count(*) OVER() AS total_count,".pg_result($result,0,"les_champs").",cbn.id_cbn
	FROM applications.utilisateur
	LEFT JOIN referentiels.cbn ON cbn.id_cbn=utilisateur.id_cbn
	$where1 ";

$query=$query_liste." ".$sWhere." ".$sOrder." ".$sLimit;

// echo $query;

$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
if (pg_num_rows ($result)) 
    $aResultTotal=pg_result($result,0,"total_count");
else $aResultTotal=0; 
$iTotal = $aResultTotal;

//------------------------------------------------------------------------------ Liste
	$sOutput = '{';
	$sOutput .= '"sEcho": '.intval($_GET['sEcho']).', ';
	$sOutput .= '"iTotalRecords": '.$iTotal.', ';
	$sOutput .= '"iTotalDisplayRecords": '.$aResultTotal.', ';
	$sOutput .= '"aaData": [ ';
    while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC)) 
	{
		$sOutput .= "[";
		foreach ($aColumns[$id_page] as $key => $value) {
		/*---------------*/
		/*cas paticuliers*/
		/*---------------*/
		/*---------------*/
		/*cas général avec référentiel*/
		/*---------------*/
			if (!empty($ref[$champ_ref[$key]]))
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
		/*Final*/
		/*---------------*/
		if ($niveau['all'] < 255 AND $row['id_user'] != $id_user AND $ref['all'] === 'f') 
			$sOutput .= '"",';
        elseif (($niveau['all'] < 255 AND $row['id_user'] == $id_user) OR ($niveau['all'] < 255 AND $ref['all'] === 't')) 
			$sOutput .= '"<a class=admin-user-edit id=\"'.$row['id_user'].'\" name=\"'.$id_user.'\"><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>",';
        else 
			$sOutput .= '"<a class=admin-user-edit id=\"'.$row['id_user'].'\" name=\"'.$id_user.'\"><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a> <a class=admin-user-del id=\"'.$row['id_user'].'\" name=\"'.$id_user.'\"><img src=\"../../_GRAPH/mini/del-icon.png\" title=\"Supprimer\" ></a>",'; 
		$sOutput .= '"<input type=checkbox class=\"liste-one\" name=\"id\" value=\"'.$row['id_user'].'\" >"';
		$sOutput .= "],";
	}
	$sOutput = substr_replace ($sOutput,"",-1);
	$sOutput .= '] }';

	echo $sOutput;

	// var_dump($ref);
//------------------------------------------------------------------------------ FONCTIONS

?>
