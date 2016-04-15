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
include ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {


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
	
	
if (!empty($_POST['idCatalogue2'])) {

				
	//mise à jour de la sequence pour la colonne serial id_tri de st_catalogue_description(en cas d'ajout manuel de données dans la table directement à travers la base de données)
	$query="SELECT setval('syntaxa.st_catalogue_description_id_tri_seq ', COALESCE((SELECT MAX(uid)+1 FROM syntaxa.st_syntaxon), 1), false);";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	
	//description d'un nouveau catalogue dans le cas ou l'option du menu déroulant "non encore décrit" est choisie
	$insert="INSERT INTO syntaxa.st_catalogue_description (\"identifiantCatalogue\",\"libelleCatalogue\") VALUES (";
	$champs= rtrim (sql_format_quote($_POST['idCatalogue2'],'do')).",".sql_format_quote($_POST['libelleCatalogue2'],'do').") RETURNING \"identifiantCatalogue\";";
	$query=	$insert.$champs;
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	
				} else {
					
				echo "un catalogue a été choisi dans le menu déroulant";} 
			
	
	//mise à jour de la sequence pour la colonne serial uid de st_syntaxon (en cas d'ajout manuel de données dans la table directement à travers la base de données)
	$query="SELECT setval('syntaxa.st_syntaxon_uid_seq ', COALESCE((SELECT MAX(uid)+1 FROM syntaxa.st_syntaxon), 1), false);";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	
	//utilisation de l'uid comme compteur pour générer ensuite l'identifiant unique du syntaxon
	$query= "SELECT MAX(uid) as last_uid FROM syntaxa.st_syntaxon;";
	//echo $query;
	$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
	echo "last_uid=".pg_result($result,0,"\"last_uid\"");
	$last_uid=pg_result($result,0,"\"last_uid\"");
	settype ($last_uid,"integer");
	$a=1;
	$next_uid=$last_uid + $a;
	echo "next_uid=".$next_uid;
	
	//mise à jour de la table st_syntaxon
	if (($_POST['idCatalogue'])=='NI') {$codecatalogue='idCatalogue2';} 
	else {$codecatalogue='idCatalogue';
			}  ;
	
	$insert="INSERT INTO syntaxa.st_syntaxon (\"idCatalogue\",\"codeEnregistrementSyntax\", \"idSyntaxon\",\"nomSyntaxon\",
	\"auteurSyntaxon\",\"nomCompletSyntaxon\",\"rangSyntaxon\") VALUES (";
	$champs= rtrim (sql_format_quote($_POST[$codecatalogue],'do').",". sql_format_quote($_POST['idTerritoireObligatoire'],'do'),"'" )."_syntaxon_".$next_uid."',".sql_format_quote($_POST['idSyntaxon'],'do').",
	".sql_format_quote($_POST['nomSyntaxon'],'do').",".sql_format_quote($_POST['auteurSyntaxon'],'do').",'".$_POST['nomSyntaxon']." ".$_POST['auteurSyntaxon']."',".sql_format_quote($_POST['rangSyntaxon'],'do').") RETURNING \"codeEnregistrementSyntax\";";
	$query=	$insert.$champs;
	
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	
	//var_dump(pg_field_name ($result,0));
	//var_dump (pg_result($result,0,0));
	//retourne le resultat de RETURNING \"codeEnregistrementSyntax\""
	$uid=pg_result($result,0,0);
	echo $query;
	echo "<br> uid pour la table suivi is:". $uid;
	echo "<br> uid pour la table suivi is:". sql_format_quote($uid,'do');
	

	//insertion d'une nouvelle donnée dans la table syntaxa.st_chorologie
	$insert="INSERT INTO syntaxa.st_chorologie (\"codeEnregistrement\",\"idTerritoire\",\"statutChorologie\") VALUES (";
	$champs= "'".$uid."',".sql_format_quote($_POST['idTerritoireObligatoire'],'do').",".sql_format_quote($_POST['statutChorologie'],'do').") RETURNING \"idChorologie\";";
	
	//mise à jour de la sequence pour la colonne serial idChorologie (en cas d'ajout manuel de données dans la table directement à travers la base de données)
	$query="SELECT setval('syntaxa.\"st_chorologie_idChorologie_seq\" ', COALESCE((SELECT MAX(\"idChorologie\")+1 FROM syntaxa.st_chorologie), 1), false);"
	.$insert.$champs;
	
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	$id_chrologie=pg_result($result,0,0);
	
	//suivi des modifications
	if (!isset($_POST['idCatalogue2'])) {
	if (!empty($_POST['idCatalogue2'])) {
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_catalogue_description","identifiantCatalogue",null,$_POST["idCatalogue2"],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_catalogue_description","libelleCatalogue",null,$_POST["libelleCatalogue2"],'applications','manuel','ajout');
	}} else {echo "pas d'insertion de nouveau catalogue dans st_catalogue_description";}
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","idCatalogue",null,$_POST["idCatalogue"],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_chorologie","idTerritoire",null,$_POST["idTerritoireObligatoire"],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_chorologie","idChorologie",null,$id_chrologie,'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_chorologie","statutChorologie",null,$_POST["statutChorologie"],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","codeEnregistrementSyntax",null,$uid,'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","idSyntaxon",null,$_POST["idSyntaxon"],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","nomSyntaxon",null,$_POST["nomSyntaxon"],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","auteurSyntaxon",null,$_POST["auteurSyntaxon"],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","nomCompletSyntaxon",null,$_POST['nomSyntaxon']." ".$_POST['auteurSyntaxon'],'applications','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","rangSyntaxon",null,$_POST["rangSyntaxon"],'applications','manuel','ajout');

/*
if (!DEBUG) {
    echo ("<script language=\"javascript\" type=\"text/javascript\">");
    echo ("window.location.replace ( \"index.php\")");
    echo ("</script>");
}




*/
}
pg_close ($db);

return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 


?>