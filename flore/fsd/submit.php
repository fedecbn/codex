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
define ("DEBUG",TRUE);
$id = isset($_POST['id']) ? $_POST['id'] : "";
$type = isset($_POST['type']) ? $_POST['type'] : "";



//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
ref_colonne_et_valeur ($id_page);
global $db, $ref, $champ_ref;

if (!isset($_POST["etape"])) {$etape = 0;}
else {$etape = $_POST["etape"];}

//------------------------------------------------------------------------------ EDIT
if (!empty ($id) AND !empty($type))                                                              
	{
	if ($type == 'champ' AND $niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
		{
		/*SUIVI DES MODIFICATIONS ET UPDATE*/
		$liste_champs = '';
		$update ="UPDATE fsd.ddd SET ";
		foreach ($aColumnsTot[$id_page] as $key => $val)	{
			if ($val['modifiable'] == 't' AND $val['table_champ'] == "ddd" AND $val['nom_champ'] != "id_from") {
				/*récupération des champs modifiables*/
				$liste_champs .= "\"".$val['champ_interface']."\",";
				$champs = "\"".$val['champ_interface']."\"";
				$post = $val['champ_interface'];
				echo $champs."<BR>";
				echo $_POST[$post]."<BR>";
				/*construction de l'update*/
				if ($val['type'] == 'string') $update .= $champs." = ".sql_format_quote($_POST[$post],'do').",";
				if ($val['type'] == 'val') $update .= $champs." = ".sql_format_quote($_POST[$post],'do').",";
				if ($val['type'] == 'bool') $update .= $champs." = ".sql_format_bool($_POST[$post]).",";
				if ($val['type'] == 'int') $update .= $champs." = ".sql_format_num($_POST[$post]).",";
				}
			}
			/*SUIVI AVANT UPDATE*/
			$select="SELECT ".rtrim($liste_champs,',')." FROM fsd.ddd AS t WHERE uid=".$id.";";
			if (DEBUG) echo "<br>".$select;
			$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);                          // Old values
			foreach ($backup as $field => $val_1) {
				$val_2 = $_POST[$field];
				if ($val_1 == 't') $val_1 = "TRUE";
				if ($val_1 == 'f') $val_1 = "FALSE";
				$modif = check_modif($val_1,$val_2,$field);
				// if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
				if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,"fsd.ddd",$field,$val_1,$val_2,$id_page,'manuel',$modif);
				} 
			/*UPDATE*/
			$update = rtrim($update,',')." WHERE uid = ".$id.";";
			if (DEBUG) echo "<br>".$update;
			$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));

			/*les champs rattachées anciens*/
			$query = "SELECT id_from FROM fsd.lien_champs WHERE uid=$id;";
			$ligne = sql_assoc ($query,true);
			
			var_dump($_POST['id_from_0']);
			var_dump($ligne['id_from']);
			
			$supp = array_diff($ligne['id_from'], $_POST['id_from_0']);
			$add = array_diff($_POST['id_from_0'],$ligne['id_from']);

			// $modif = check_modif($ligne['id_from'],$_POST["id_from"],"id_from");
			// if ($modif != 'vide' AND $modif != 'identiques') add_suivi2(null,$id_user,$id,"id_from","id_from",$ligne['id_from'],$_POST["id_from"],'fsd','manuel',$modif);
			
			if (!empty($supp))		/*Suppression*/
				{
				foreach ($supp as $field => $val)
					$query= $query."DELETE FROM fsd.lien_champs WHERE (uid,id_from) = ($id,$val); ";
				// echo "<br>".$query;
				$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
				}
			if (!empty($add))		/*Ajout*/
				{
				foreach ($add as $field => $val)
					$query= $query."INSERT INTO fsd.lien_champs VALUES ($id,$val); ";
				// echo "<br>".$query;
				$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
				}
				/*Log*/
			add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Saisie edit fiche",$id,"fsd");
			pg_free_result ($result);		
			
		}
	if ($type == 'champ' AND $niveau >= 64)	/*Seulement les participants et au dessus*/
		{
		if (isset($_POST['commentaire_eval']))	{
			if (!empty($_POST['commentaire_eval'])) {
				$result=pg_query ($db,$query_user." AND id_user = '$id_user'") or die ("Erreur pgSQL : ".pg_result_error ($result));
				$user=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
				$insert = "INSERT INTO fsd.discussion (uid,id_user,nom,prenom,id_cbn,commentaire_eval,datetime) 
				VALUES ($id,'$user[id_user]','$user[nom]','$user[prenom]',$user[id_cbn],".sql_format_quote($_POST[commentaire_eval],'do').",NOW())";
				echo $insert;
				$result=pg_query ($db,$insert) or die ("Erreur pgSQL : ".pg_result_error ($result));
				add_suivi2($etape,$id_user,$id,"discussion","commentaire_eval","",sql_format_quote($_POST[commentaire_eval],'do'),$id_page,'manuel',"ajout");
				}
			}
		}
	if ($type == 'vocactrl' AND $niveau >= 128)
		{
		for ($j=0;$j<=$_POST['nb'];$j++)
		if ($_POST['cdChamp_'.$j] == null AND $_POST['libChamp_'.$j] == null)
			$query .= "DELETE FROM fsd.voca_ctrl WHERE id = ".sql_format_quote($_POST['id_'.$j],'do').";";
		else
			$query .= "UPDATE fsd.voca_ctrl SET \"cdChamp\" = ".sql_format_quote($_POST['cdChamp_'.$j],'do').", \"libChamp\" = ".sql_format_quote($_POST['libChamp_'.$j],'do').", \"descChamp\" = ".sql_format_quote($_POST['descChamp_'.$j],'do').", \"typChamp\" = ".sql_format_quote($_POST['typChamp'],'do')." WHERE id = ".sql_format_quote($_POST['id_'.$j],'do').";";
		if (isset($_POST['cdChamp']) AND isset($_POST['libChamp']))
			if (!empty($_POST['cdChamp']) AND !empty($_POST['libChamp']))
				$query .= "INSERT INTO fsd.voca_ctrl (\"typChamp\",\"cdChamp\",\"libChamp\",\"descChamp\") VALUES (".sql_format_quote($_POST['typChamp'],'do').",".sql_format_quote($_POST['cdChamp'],'do').",".sql_format_quote($_POST['libChamp'],'do').",".sql_format_quote($_POST['descChamp'],'do').");";
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
		}
	} else {                                      
//------------------------------------------------------------------------------	
//------------------------------------------------------------------------------ ADD.
		/*SUIVI DES MODIFICATIONS ET UPDATE*/
		$liste_champs = '';
		foreach ($aColumnsTot[$id_page] as $key => $val)	{
			if ($val['modifiable'] == 't' AND $val['table_champ'] == "ddd" AND $val['nom_champ'] != "id_from") {
				/*récupération des champs modifiables*/
				$liste_champs .= "\"".$val['champ_interface']."\",";
				/*construction de l'update*/
				if ($val['type'] == 'string') $values .= sql_format_quote($_POST[$val['champ_interface']],'do').",";
				if ($val['type'] == 'val') $values .= sql_format_quote($_POST[$val['champ_interface']],'do').",";
				if ($val['type'] == 'bool') $values .= sql_format_bool($_POST[$val['champ_interface']]).",";
				if ($val['type'] == 'int') $values .= sql_format_num($_POST[$val['champ_interface']]).",";
				}
			}
			
			$insert ="INSERT INTO fsd.ddd (".rtrim($liste_champs,',').") VALUES (".rtrim($values,',').") RETURNING uid";
		
			
			/*INSERT*/
			if (DEBUG) echo "<br>".$insert;
			$result=pg_query ($db,$insert) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$uid = pg_fetch_row($result);
			
			if (!empty($_POST['id_from']))
				{
				$idfrominsert=null;
				foreach ($_POST['id_from'] as $id_from)
					$idfrominsert .= "INSERT INTO fsd.lien_champs VALUES (".$uid[0].",$id_from)";
				if ($idfrominsert != null)
				$result=pg_query ($db,$idfrominsert) or die ("Erreur pgSQL : ".pg_result_error ($idfrominsert));
				}
			
			add_suivi2($etape,$id_user,$uid[0],"fsd.ddd",$field,'','',$id_page,'manuel','add');


			/*Log*/
			add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Saisie edit fiche",$id,"fsd");
			pg_free_result ($result);		
			}
pg_close ($db);

return (true);

?>
