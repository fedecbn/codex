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
define ("DEBUG",true);
$id = isset($_POST['id']) ? $_POST['id'] : "";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
ref_colonne_et_valeur ($id_page);
global $db, $ref, $champ_ref;

//------------------------------------------------------------------------------ EDIT
if (!empty ($id))                                                               
	{
	if ($niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
		{
		/*SUIVI DES MODIFICATIONS ET UPDATE*/
		//var_dump($aColumnsTot);
		$tables = array ('st_syntaxon');
		/*modification et suivi des modifications pour la table st_syntaxon (univariée)*/
		foreach ($tables as $i)	{
			$champs = '';
			$update ="UPDATE syntaxa.$i SET ";
			foreach ($aColumnsTot[$id_page] as $key => $val)	{
				if ($val['modifiable'] == 't' AND $val['table_champ'] == $i) {
					/*récupération des champs modifiables*/
					$champs .= "\"".$i."\".\"".$val['nom_champ']."\",";
					/*construction de l'update*/
					if ($val['type'] == 'string') $update .= "\"".$val['nom_champ']."\" = ".sql_format_quote($_POST[$val['nom_champ']],'do').",";
					if ($val['type'] == 'val') $update .= "\"".$val['nom_champ']."\" = ".sql_format_quote($_POST[$val['nom_champ']],'do').",";
					if ($val['type'] == 'bool') $update .= "\"".$val['nom_champ']."\" = ".sql_format_bool($_POST[$val['nom_champ']]).",";
					if ($val['type'] == 'int') $update .= "\"".$val['nom_champ']."\" = ".sql_format_num($_POST[$val['nom_champ']]).",";					}
				}
			/*SUIVI AVANT UPDATE*/
			echo $champs;
			$select="SELECT ".rtrim($champs,',')." FROM syntaxa.$i WHERE \"codeEnregistrementSyntax\"=".$id.";";
			if (DEBUG) echo "<br>".$select; //affichage en mode debug de la variable select
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
			$update = rtrim($update,',')." WHERE \"codeEnregistrementSyntax\" = ".$id.";";
			if (DEBUG) echo "<br>".$update;
			$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));
			}
			/*modification et suivi des modifications pour les tables des correspondances pvf, hic et eunis (multivariée) en récupérant l'id de l'enregistrement*/
			
	
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
				$insert = "INSERT INTO lr.discussion (\"codeEnregistrementSyntax\",id_user,nom,prenom,id_cbn,commentaire_eval,datetime) 
				VALUES ($id,'$user[id_user]','$user[nom]','$user[prenom]',$user[id_cbn],".sql_format_quote($_POST[commentaire_eval],'do').",NOW())";
				echo $insert;
				$result=pg_query ($db,$insert) or die ("Erreur pgSQL : ".pg_result_error ($result));
				add_suivi2($etape,$id_user,$id,"discussion","commentaire_eval","",sql_format_quote($_POST[commentaire_eval],'do'),$id_page,'manuel',"ajout");
				}
			}
		}
	} else {                                                                     //  ADD
//------------------------------------------------------------------------------ Valeurs numériques
    if ($_POST['etape']=="") $_POST['etape']=2;
//------------------------------------------------------------------------------
	/*Paramètre à ajouter*/
	$in["cd_ref"] = sql_format_num ($_POST["cd_ref"]);
	$in["famille"] = sql_format_quote ($_POST["famille"],'do');
	$in["nom_sci"] = sql_format_quote ($_POST["nom_sci"],'do');
	$in["cd_rang"] = sql_format ($_POST["cd_rang"]);
	$in["nom_verna"] = sql_format_quote ($_POST["nom_verna"],'do');
	$in["hybride"] = sql_format_bool ($_POST["hybride"],'do');
	
	$rub[$id_page] = 'true';
	
	$uid = add_taxon ($in,$rub);
	
	add_suivi2($_POST["etape"],$id_user,$uid,"taxons","nom",null,sql_format_num ($_POST["nom_sci"]),'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,$uid,"taxons","uid",null,$uid,'applications','manuel','ajout');	
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
