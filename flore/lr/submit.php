<?php
/*------------------------------------------------------------------
--------------------------------------------------------------------
 Application Codex		                               			  
 https://github.com/fedecbn/codex					   			  
--------------------------------------------------------------------
 Interface avec la base de données (modification et ajout)         
--------------------------------------------------------------------
--------------------------------------------------------------------*/
/*------------------------------------------------------------------------------ INITIALISATION*/ 
include ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {


//------------------------------------------------------------------------------ PARMS.
define ("DEBUG",FALSE);
$mode = isset($_GET['mode']) ? $_GET['mode'] : "fiche";
echo "mode : ".$mode;

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $db, $ref, $aColumns, $aColumnsExp, $aColumnsTot, $aColumnsSub, $champ_ref;
ref_colonne_et_valeur ($id_page);

/*Droit sur les boutons*/
$typ_droit='d2';$rubrique=$id_page;$onglet = 'lr';
$droit = ref_droit($id_user,$typ_droit,$rubrique,$onglet);



switch ($mode) {
//------------------------------------------------------------------------------	
//------------------------------------------------------------------------------ 
	case "fiche" : {
	//------------------------------------------------------------------------------ PARMS.

	$id = isset($_POST['id']) ? $_POST['id'] : "";
	if ($_POST['hybride1'] == 'TRUE' OR $_POST['id_indi'] == '3')	{
		$_POST['cat_ini'] = 10;
		$_POST['cat_fin'] = 10;
		}

	/*changment d'étape*/
	if (!isset($_POST["etape"])) {$etape = 1;}
	else {$etape = $_POST["etape"];}

	if (!empty ($id))                                                              
		{
		if ($niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
			{
			/*SUIVI DES MODIFICATIONS ET UPDATE*/
			foreach ($tables as $i)	{
				$champs = '';
				$update ="UPDATE lr.$i SET ";
				foreach ($aColumnsTot[$id_page] as $key => $val)	{
					if ($val['modifiable'] == 't' AND $val['table_champ'] == $i) {
						/*récupération des champs modifiables*/
						$champs .= $val['champ_interface'].",";
						/*construction de l'update*/
						if ($val['type'] == 'string') $update .= $val['champ_interface']." = ".sql_format_quote($_POST[$val['champ_interface']],'do').",";
						if ($val['type'] == 'val') $update .= $val['champ_interface']." = ".sql_format_num($_POST[$val['champ_interface']]).",";
						if ($val['type'] == 'bool') $update .= $val['champ_interface']." = ".sql_format_bool($_POST[$val['champ_interface']]).",";
						if ($val['type'] == 'int') $update .= $val['champ_interface']." = ".sql_format_num($_POST[$val['champ_interface']]).",";
						}
					}
				/*SUIVI AVANT UPDATE*/
				$select="SELECT ".rtrim($champs,',')." FROM lr.$i AS t WHERE uid=".$id.";";
				if (DEBUG) echo "<br>".$select;
				$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
				$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);                          // Old values
				foreach ($backup as $field => $val_1) {
					$val_2 = $_POST[$field];
					if ($val_1 == 't') $val_1 = "TRUE";
					if ($val_1 == 'f') $val_1 = "FALSE";
					$modif = check_modif($val_1,$val_2,$field);
					// if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
					if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,$i,$field,$val_1,$val_2,$id_page,'manuel',$modif);
					} 
				/*UPDATE*/
				$update = rtrim($update,',')." WHERE uid = ".$id.";";
				if (DEBUG) echo "<br>".$update;
				$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));
				}
		
		// $query="UPDATE applications.liste_taxon SET nom_scien= ".frt("nom_sci",$_POST["nom_sci"]).", cd_ref= '".frt("cd_ref",$_POST["cd_ref"])."' WHERE uid = ".$id." AND rubrique_taxon = 'lr';";
		// if (DEBUG) echo "<br>".$query;
		// $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

			add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Saisie edit fiche",$id,"lr");
			}
		if ($niveau >= 64)	/*Seulement les participants et au dessus*/
			{
			if (isset($_POST['commentaire_eval']))	{
				if (!empty($_POST['commentaire_eval'])) {
					$result=pg_query ($db,$query_user." AND id_user = '$id_user'") or die ("Erreur pgSQL : ".pg_result_error ($result));
					$user=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
					$insert = "INSERT INTO lr.discussion (uid,id_user,nom,prenom,id_cbn,commentaire_eval,datetime) 
					VALUES ($id,'$user[id_user]','$user[nom]','$user[prenom]',$user[id_cbn],".sql_format_quote($_POST[commentaire_eval],'do').",NOW())";
					echo $insert;
					$result=pg_query ($db,$insert) or die ("Erreur pgSQL : ".pg_result_error ($result));
					add_suivi2($etape,$id_user,$id,"discussion","commentaire_eval","",sql_format_quote($_POST[commentaire_eval],'do'),$id_page,'manuel',"ajout");
					}
				}
			}
		} else {                                                                        
	/*Nothing ==> go Refnat*/
		}
	}
	break;

	case "validation" : {
	$id=$_GET['id']; 
	$class_valid=$_GET['class_valid']; 
	$val_com = sql_format_quote($_GET['val_com'],'do'); 
	$id_user = $_SESSION['id_user'];
	$db=sql_connect(SQL_base);

	foreach($id as $uid) {
	//------------------------------------------------------------------------------ Query
	$query = "SELECT evaluation.etape, evaluation.version,evaluation.avancement, validation FROM lr.evaluation 
	LEFT JOIN lr.validation ON evaluation.uid = validation.uid
	WHERE evaluation.uid=$uid ;";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$row = pg_fetch_assoc($result);
	//------------------------------------------------------------------------------ MAIN
	if ($row['avancement'] == 3 AND $class_valid == 'valid') {
		if ($row['validation'] == null) $query = "INSERT INTO lr.validation(uid, etape, version, id_user, validation, val_com, dat_val) VALUES ($uid, '".$row['etape']."', ".$row['version'].", '$id_user', 'valid', null, NOW());";
		else $query = "UPDATE lr.validation SET validation='valid', val_com=null,  dat_val=NOW() WHERE uid=$uid AND etape= ".$row['etape']." AND version=".$row['version']." AND id_user='$id_user';";
		echo "<BR>$uid validé";
		}
	elseif ($row['avancement'] == 3 AND $class_valid == 'invalid') {
		if ($row['validation'] == null) $query = "INSERT INTO lr.validation(uid, etape, version, id_user, validation, val_com, dat_val) VALUES ($uid, '".$row['etape']."', ".$row['version'].", '$id_user', 'invalid', '$val_com', NOW());";
		else $query = "UPDATE lr.validation SET validation='invalid', val_com= $val_com,  dat_val=NOW() WHERE uid=$uid AND etape=".$row['etape']." AND version=".$row['version']." AND id_user='$id_user';";
		echo "<BR>$uid invalidé";
		// echo "<BR>$query";
		}
	else {
		$query = "SELECT 1;";
		echo "<BR>$uid non traité";
	}
	
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	}

	}
	break;

	
}
pg_close ($db);

return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 


?>
