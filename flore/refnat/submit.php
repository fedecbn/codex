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
$id = isset($_POST['id']) ? $_POST['id'] : "";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $db, $ref, $aColumns, $aColumnsExp, $aColumnsTot, $aColumnsSub, $champ_ref;
ref_colonne_et_valeur ($id_page);

//------------------------------------------------------------------------------ VAR.
$in["cd_nom"] = sql_format_num ($_POST["cd_nom"]);$in["cd_ref"] = sql_format_num ($_POST["cd_ref"]);$in["lb_nom"] = sql_format_quote ($_POST["lb_nom"],'do');$in["lb_auteur"] = sql_format_quote ($_POST["lb_auteur"],'do');$in["nom_complet"] = sql_format_quote ($_POST["nom_complet"],'do');$in["nom_valide"] = sql_format_quote ($_POST["nom_valide"],'do');$in["nom_vern"] = sql_format_quote ($_POST["nom_vern"],'do');$in["nom_vern_eng"] = sql_format_quote ($_POST["nom_vern_eng"],'do');$in["cd_taxsup"] = sql_format_num ($_POST["cd_ref"]);$in["rang"] = sql_format_quote ($_POST["rang"],'do');$in["regne"] = sql_format_quote ($_POST["regne"],'do');$in["phylum"] = sql_format_quote ($_POST["phylum"],'do');$in["classe"] = sql_format_quote ($_POST["classe"],'do');$in["ordre"] = sql_format_quote ($_POST["ordre"],'do');$in["famille"] = sql_format_quote ($_POST["famille"],'do');$in["fr"] = sql_format ($_POST["fr"]);$in["gf"] = sql_format ($_POST["gf"]);$in["mar"] = sql_format ($_POST["mar"]);$in["gua"] = sql_format ($_POST["gua"]);$in["sm"] = sql_format ($_POST["sm"]);$in["sb"] = sql_format ($_POST["sb"]);$in["spm"] = sql_format ($_POST["spm"]);$in["may"] = sql_format ($_POST["may"]);$in["epa"] = sql_format ($_POST["epa"]);$in["reu"] = sql_format ($_POST["reu"]);$in["taaf"] = sql_format ($_POST["taaf"]);$in["pf"] = sql_format ($_POST["pf"]);$in["nc"] = sql_format ($_POST["nc"]);$in["wf"] = sql_format ($_POST["wf"]);$in["cli"] = sql_format ($_POST["cli"]);$in["habitat"] = sql_format_num ($_POST["habitat"],'do');

$in["catnat"] = sql_format_bool ($_POST["catnat"]);$in["lr"] = sql_format_bool ($_POST["lr"]);$in["eee"] = sql_format_bool ($_POST["eee"]);

$in["hybride"] = sql_format_bool ($_POST["hybride"],'do');

// var_dump($in);

//------------------------------------------------------------------------------ EDIT
if (!empty ($id))                                                               
	{
	if ($niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
		{
		/*SUIVI DES MODIFICATIONS ET UPDATE*/
		if (!isset($_POST["etape"])) {$etape = 1;}
		else {$etape = $_POST["etape"];}
		
			$champs = '';
			$update ="UPDATE ".$id_page.".taxons SET ";
			foreach ($aColumnsTot[$id_page] as $key => $val)	{
				if ($val['modifiable'] == 't' AND $val['table_champ'] == 'taxons') {
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
			$select="SELECT ".rtrim($champs,',')." FROM ".$id_page.".taxons AS t WHERE uid=".$id.";";
			if (DEBUG) echo "<br>".$select;
			$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);                          // Old values
			foreach ($backup as $field => $val_1) {
				$val_2 = $_POST[$field];
				if ($val_1 == 't') $val_1 = "TRUE";
				if ($val_1 == 'f') $val_1 = "FALSE";
				$modif = check_modif($val_1,$val_2,$field);
				if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
				if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,'taxons',$field,$val_1,$val_2,$id_page,'manuel',$modif);
			} 
			/*UPDATE*/
			$update = rtrim($update,',')." WHERE uid = ".$id.";";
			if (DEBUG) echo "<br>".$update;
			$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));
		
			add_and_modif_taxon ($in,'modif',$id); //fonction qui permet l'insertion du taxon dans la table de la rubrique pour laquelle le boleen a été coché (ex: le taxon appartient à la rubrique eee) 
		}
	if ($niveau >= 64)	/*Seulement les participants et au dessus*/
		{
		if (isset($_POST['commentaire_eval']))	{
			if (!empty($_POST['commentaire_eval'])) {
				$result=pg_query ($db,$query_user." AND id_user = '$id_user'") or die ("Erreur pgSQL : ".pg_result_error ($result));
				$user=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
				$insert = "INSERT INTO refnat.discussion (uid,id_user,nom,prenom,id_cbn,commentaire_eval,datetime) 
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
	$uid = add_and_modif_taxon ($in,'add',null);
	
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
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
