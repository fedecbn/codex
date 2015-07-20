<?php
//------------------------------------------------------------------------------//
//  module_gestion/lr-submit.php                                                //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  15/08/14 - MaJ tables                                         //
//  Version 1.10  01/08/14 - MaJ tables v2                                      //
//------------------------------------------------------------------------------//
session_start();
include ("commun.inc.php");

//------------------------------------------------------------------------------ PARMS.
define ("DEBUG",FALSE);
$id = isset($_POST['id']) ? $_POST['id'] : "";


//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $db, $ref, $aColumns, $aColumnsExp, $aColumnsTot, $aColumnsSub, $champ_ref;
ref_colonne_et_valeur ($id_page);
//$ref['etape'] = array(0 =>"",1=>"pré-eval",2=>"éval",3=>"post-éval");
// $ref['endemisme'] = array("" =>"",f=>"NON",t=>"<b>OUI</b>");


if ($_POST['hybride1'] == 'TRUE' OR $_POST['id_indi'] == '3')	{
	$_POST['cat_ini'] = 10;
	$_POST['cat_fin'] = 10;
	}

if (!isset($_POST["etape"])) {$etape = 1;}
else {$etape = $_POST["etape"];}

//------------------------------------------------------------------------------	
//------------------------------------------------------------------------------ UPDATE.
if (!empty ($id))                                                              
	{
	if ($niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
		{
		/*SUIVI DES MODIFICATIONS ET UPDATE*/
		foreach ($tables as $i)	{
			$champs = '';
			$update ="UPDATE ".SQL_schema_lr.".$i SET ";
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
			$select="SELECT ".rtrim($champs,',')." FROM ".SQL_schema_lr.".$i AS t WHERE uid=".$id.";";
			if (DEBUG) echo "<br>".$select;
			$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);                          // Old values
			foreach ($backup as $field => $val_1) {
				$val_2 = $_POST[$field];
				if ($val_1 == 't') $val_1 = "TRUE";
				if ($val_1 == 'f') $val_1 = "FALSE";
				$modif = check_modif($val_1,$val_2,$field);
				if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
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

		add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Saisie edit fiche",$id,"liste_rouge");
		}
	if ($niveau >= 64)	/*Seulement les participants et au dessus*/
		{
		if (isset($_POST['commentaire_eval']))	{
			if (!empty($_POST['commentaire_eval'])) {
				$result=pg_query ($db,$query_user." AND id_user = '$id_user'") or die ("Erreur pgSQL : ".pg_result_error ($result));
				$user=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
				$insert = "INSERT INTO liste_rouge.discussion (uid,id_user,nom,prenom,id_cbn,commentaire_eval,datetime) 
				VALUES ($id,'$user[id_user]','$user[nom]','$user[prenom]',$user[id_cbn],".sql_format_quote($_POST[commentaire_eval],'do').",NOW())";
				echo $insert;
				$result=pg_query ($db,$insert) or die ("Erreur pgSQL : ".pg_result_error ($result));
				add_suivi2($etape,$id_user,$id,"discussion","commentaire_eval","",sql_format_quote($_POST[commentaire_eval],'do'),$id_page,'manuel',"ajout");
				}
			}
		}
	} else {                                                                        
//------------------------------------------------------------------------------	
//------------------------------------------------------------------------------ ADD.
/*Nothing ==> go Refnat*/
	}

/*
if (!DEBUG) {
    echo ("<script language=\"javascript\" type=\"text/javascript\">");
    echo ("window.location.replace ( \"index.php\")");
    echo ("</script>");
}
*/
pg_close ($db);

return (true);


?>
