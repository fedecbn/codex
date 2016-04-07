<?php
/*------------------------------------------------------------------
--------------------------------------------------------------------
 Application Codex		                               			  
 https://github.com/fedecbn/codex					   			  
--------------------------------------------------------------------
 Interface avec la base de données (modification et ajout)         
--------------------------------------------------------------------
--------------------------------------------------------------------*/
/*------------------------------------------------------------------------------ INITIALISATION*/ session_start();
include ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ PARMS.
define ("DEBUG",TRUE);
$id = isset($_POST['id']) ? $_POST['id'] : "";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
ref_colonne_et_valeur ('catnat');
global $db, $ref, $champ_ref;

if (!isset($_POST["etape"])) {$etape = 0;}
else {$etape = $_POST["etape"];}




//------------------------------------------------------------------------------ EDIT
if (!empty ($id))                                                               // EDIT
	{
	echo "droit OK";
	if ($niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
		{
		/*statut_reg*/
		$query = "SELECT * FROM catnat.statut_reg WHERE uid = $id;";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC)) 
				$stt[$row["type_statut"]][$row["id_reg"]] = $row["id_statut"];
			foreach ($ref['region'] as $id_reg => $region)	{
				foreach ($ref['statut'] as $type_stt => $lib_stt)	{
					$new_val = $_POST[$type_stt."_".$id_reg];
					$old_val = $stt[$type_stt][$id_reg];
					// echo "<BR> $type_stt => $lib_stt Values $old_val -> $new_val";
					if ($new_val != $old_val)	{	/*différence*/
						if ($old_val == null)	/*NEW*/
							{
							$valeur = sql_format($_POST[$val_st]);
							$query = "INSERT INTO catnat.statut_reg (uid, id_reg, nom_reg, type_statut, id_statut, nom_statut) VALUES ($id, $id_reg, ".frt('nom_reg',$region).", '$type_stt', '$new_val', '$lib_stt');";
							if (DEBUG) echo "<BR>$query";		
							$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
							add_suivi2($etape,$id_user,$id,"statut_reg","statut_".$type_stt,$old_val,$new_val,'catnat','manuel','ajout');				
							}
						elseif($new_val == null)	/*SUPPR*/
							{
							$query = "DELETE FROM catnat.statut_reg WHERE uid = $id AND id_statut = '$old_val' AND id_reg = '$id_reg'";
							if (DEBUG) echo "<BR>$query";
							$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
							add_suivi2($etape,$id_user,$id,"statut_reg","statut_".$type_stt,$old_val,$new_val,'catnat','manuel','suppr');				
							}
						else {																										/*Autres cas = modif*/
							$valeur = sql_format($_POST[$val_st]);
							$query = "UPDATE catnat.statut_reg SET (id_statut, nom_statut) = ('$new_val', '$lib_stt') WHERE uid = $id AND id_statut = '$old_val' AND id_reg = '$id_reg' and type_statut = '$type_stt'";
							if (DEBUG) echo "<BR>$query";
							$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
							add_suivi2($etape,$id_user,$id,"statut_reg","statut_".$type_stt,$old_val,$new_val,'catnat','manuel','modif');
							}
						}
					}
				}
			
			/*statut_nat*/
			$coor_stt = array("indi" => "INDI", "lr" =>"LR", "rarete" =>"RAR", "endemisme" =>"END", "presence" =>"PRES");
			$query="SELECT indi, lr, rarete, endemisme, presence FROM catnat.statut_nat	WHERE uid=$id;";
			if (DEBUG) echo "<br>".$query;
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
			var_dump($backup);
			foreach ($backup as $field => $val_1) {
				$val_2 = $_POST[$coor_stt[$field]];
				if ($val_1 == 't') $val_1 = "oui";
				if ($val_1 == 'f') $val_1 = "non";
				$modif = check_modif($val_1,$val_2,$field);
				if (DEBUG) echo ($field." -> ".$val_1."  | ".$val_2."<br>");
				if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,"statut_nat",$field,$val_1,$val_2,'catnat','manuel',$modif);
			} 
			pg_free_result ($result);unset($val_1);unset($val_2);
					
					
			// if (isset($ref[$champ_ref["statut_".$type_stt]])) {$res_new = ;} else {$res_new = $new_val;}
			
			$indi = frt('indi',$ref[$champ_ref['indi']][$_POST['INDI']]);
			$query = "UPDATE catnat.statut_nat SET indi=".$indi.", lr=".frt('lr',$_POST['LR']).", rarete=".frt('rarete',$_POST['RAR']).", endemisme=".frt('endemisme',$_POST['END']).", presence=".frt('presence',$_POST['PRES'])." WHERE uid = $id;";
			if (DEBUG) echo "<BR>$query";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		}
	if ($niveau >= 64)	/*Seulement les participants et au dessus*/
		{
		/*Commentaires Taxon*/
		$query="SELECT commentaire FROM catnat.taxons_nat WHERE uid=".$id.";";
		if (DEBUG) echo "<br>".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
		foreach ($backup as $field => $val_1) {
			$val_2 = $_POST[$field];
			if ($val_1 == 't') $val_1 = "TRUE";
			if ($val_1 == 'f') $val_1 = "FALSE";
			$modif = check_modif($val_1,$val_2,$field);
			if (DEBUG) echo ($field." -> ".$val_1."  | ".$val_2."<br>");
			if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,"taxons_nat",$field,$val_1,$val_2,'catnat','manuel',$modif);
		} 
		$query="UPDATE catnat.taxons_nat SET commentaire= ".sql_format_quote ($_POST["commentaire"],"do")." WHERE uid = ".$id.";";
		if (DEBUG) echo "<br>".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

		pg_free_result ($result);unset($val_1);unset($val_2);

		/*Discussion générale*/
		if (isset($_POST['commentaire_eval']))	{
			if (!empty($_POST['commentaire_eval'])) {
				$result=pg_query ($db,$query_user." AND id_user = '$id_user'") or die ("Erreur pgSQL : ".pg_result_error ($result));
				$user=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
				$insert = "INSERT INTO catnat.discussion (uid,id_user,nom,prenom,id_cbn,commentaire_eval,datetime) 
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
	
	pg_close ($db);
	return (true);

//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 
?>
