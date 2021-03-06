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
	{ echo "id n'est pas vide"; echo $niveau;
//	if ($niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
//		{ echo "niveau >128";
			
		/*SUIVI DES MODIFICATIONS ET UPDATE*/
		if (DEBUG) foreach($_POST as $key => $val) echo '$_POST["'.$key.'"]='.$val.'<br />';
		echo "<br> hic";var_dump($_POST["hic"]);
		echo "<br> hic select";var_dump($_POST["hic_select"]);
		echo "<br> departement select";var_dump($_POST["departement_select"]);
		echo "<br> etage veg";var_dump($_POST["etage_veg"]);
		echo "<br> etage veg select";var_dump($_POST["etage_veg_select"]);
		echo "<br> etage bioclim";var_dump($_POST["etage_bioclim"]);
		echo "<br> etage bioclim select";var_dump($_POST["etage_bioclim_select"]);
		echo "<br> eunis";var_dump($_POST["eunis"]);
		echo "<br> eunis select";var_dump($_POST["eunis_select"]);
		
		
//-----------------------------------------------------EDITION DE LA TABLE SYNTAXON---------------------------------------------------------------------------
//----------------------------------------------------creation de des variables contenant le texte de l' update et les champs du select-------------------------------		
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
					/*verification que l'appli reçoit bien  $val['nom_champ']==='nomCompletSyntaxon' */
					//echo "1:".$val['nom_champ'];
					//if ($val['nom_champ']!=='nomCompletSyntaxon') echo " is nomComplet is false<br>";
					//if ($val['nom_champ']==='nomCompletSyntaxon') echo " is nomComplet is true<br>";
					
					/*construction de l'update*/
					if ($val['type'] == 'string' and $val['nom_champ']!=='nomCompletSyntaxon') $update .= "\"".$val['nom_champ']."\" = ".sql_format_quote($_POST[$val['nom_champ']],'do').",";
					if ($val['type'] == 'val') $update .= "\"".$val['nom_champ']."\" = ".sql_format_quote($_POST[$val['nom_champ']],'do').",";
					if ($val['type'] == 'bool') $update .= "\"".$val['nom_champ']."\" = ".sql_format_bool($_POST[$val['nom_champ']]).",";
					if ($val['type'] == 'int') $update .= "\"".$val['nom_champ']."\" = ".sql_format_num($_POST[$val['nom_champ']]).",";					}
				}
			//echo "<br> voici l'update avant trim <bre>".$update	;
					/*on ajoute le nom complet car parfois ne fonctionne pas en formulaire*/
			//si on avait pas ajouté le nomComplet en bout de la variable update, il aurait fallu supprimer la virgule générée par la boucle (d'où le rtrim initial)		
			//$update = rtrim($update,',')." WHERE \"codeEnregistrementSyntax\" = ".$id.";";
			$update .= " \"nomCompletSyntaxon\" = '".$_POST['nomSyntaxon']." ".$_POST['auteurSyntaxon']."' ";
			
					/*on ajoute la condition sur le code de l'enregistrement*/
			$update .= "WHERE \"codeEnregistrementSyntax\"=".$id.";";
			if (DEBUG) echo "<br> update = ".$update;

		
//-----------------------------------------------------------	backup qui enregistre l'état des champs en base, avant l'enregistrement-----------------
	
			/*SUIVI AVANT UPDATE*/
			if (DEBUG) echo "<br> liste des champs = ". $champs;
			
			$select="SELECT ".rtrim($champs,',')." FROM syntaxa.$i WHERE \"codeEnregistrementSyntax\"=".$id.";";
			if (DEBUG) echo "<br>".$select; //affichage en mode debug de la variable select
			$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);  
			var_dump($backup);
			// Old values
			foreach ($backup as $field => $val_1) {
				if ($field != 'nomCompletSyntaxon') $val_2 = $_POST[$field];
				if ($field == 'nomCompletSyntaxon') $val_2 = $_POST['nomSyntaxon']." ".$_POST['auteurSyntaxon'];
				if ($val_1 == 't') $val_1 = "TRUE";
				if ($val_1 == 'f') $val_1 = "FALSE";
				$modif = check_modif($val_1,$val_2,$field);
				// if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
				if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,$i,$field,$val_1,$val_2,$id_page,'manuel',$modif);
				} 	
			
//-----------------------------------------------------------lancement de la requête de mise à jour-------------------				
			/*UPDATE*/

			if (DEBUG) echo "<br>".$update;
			$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));
			pg_free_result($result);
					
			}
			
//-----------------------------------------------------------EDITION DE LA TABLE DE RATTACHEMENT A LA BIBLIO

//---backup qui enregistre l'état des champs de la table st_biblio en base de données, avant l'enregistrement de la fiche ---------------------

$select="SELECT \"libPublication\" FROM syntaxa.st_biblio WHERE \"codeEnregistrement\"=".$id.";";
if (DEBUG) echo "<br>".$select; //affichage en mode debug de la variable select
			$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC); 
			$num_rows = pg_num_rows($result);
//s'il y a déjà des références biblio enregistrées pour ce syntaxon alors on fait une mise à jour des données, sinon on insert de nouvelles données
			if ($num_rows > 0) {			
			//echo "<br>var_dump de backup:";var_dump($backup);
			// renvoi un tableau pour le développeur qui montre les anciennes valeurs et les nouvelles, rempli la table de suivi
			foreach ($backup as $field => $val_1) {
				$val_2 = $_POST[$field];
				if ($val_1 == 't') $val_1 = "TRUE";
				if ($val_1 == 'f') $val_1 = "FALSE";
				$modif = check_modif($val_1,$val_2,$field);
				// if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
				if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,'st_biblio',$field,$val_1,$val_2,$id_page,'manuel',$modif);
				
			//mise à jour des données dans la table de correspondance entre les syntaxons et leur biblio
				$update="update syntaxa.st_biblio set \"libPublication\"='$val_2',\"urlPublication\"= ".sql_format_quote($_POST[urlPublication],'do').",\"codePublication\"=".sql_format_quote($_POST[codePublication],'do')." where \"libPublication\"='$val_1' and \"codeEnregistrement\"=".$id.";";	
				if (DEBUG) echo "<br>".$update;
				$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));
				pg_free_result($result);
				} 	
			} else {
				//mise à jour de la sequence pour la colonne serial idRattachementPVF (en cas d'ajout manuel de données dans la table directement à travers la base de données)
			$query="SELECT setval('syntaxa.\"st_biblio_idBiblio_seq\" ', COALESCE((SELECT MAX(\"idBiblio\")+1 FROM syntaxa.st_biblio), 1), false);";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
			pg_free_result($result);
			//insertion d'une nouvelle valeur dans la table de correspondance entre le syntaxon et le pvf (ici nouvelle valeur de rattachement au pvf1)
			$insert="INSERT INTO syntaxa.st_biblio (\"codeEnregistrement\",\"libPublication\",\"urlPublication\",\"codePublication\") VALUES (";
			$champs= $id.",".sql_format_quote($_POST['libPublication'],'do').",".sql_format_quote($_POST['urlPublication'],'do').",".sql_format_quote($_POST['codePublication'],'do').") RETURNING \"idBiblio\";";
			$query=	$insert.$champs;
			echo "<br>".$query;
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
			
				//récupérer le resultat de RETURNING \"idBiblio\""
				$idbiblio=pg_result($result,0,0);
			pg_free_result($result);
			
			echo "<br> un nouveau rattachement biblio ajouté en base <br>";
			add_suivi2($etape,$id_user,$id,'st_biblio','idBiblio','',$idbiblio,$id_page,'manuel','ajout');
			add_suivi2($etape,$id_user,$id,'st_biblio','libPublication','',$_POST['libPublication'],$id_page,'manuel','ajout');
			add_suivi2($etape,$id_user,$id,'st_biblio','urlPublication','',$_POST['urlPublication'],$id_page,'manuel','ajout');
			add_suivi2($etape,$id_user,$id,'st_biblio','codePublication','',$_POST['codePublication'],$id_page,'manuel','ajout');
				}	
//-----------------------------------------------------------EDITION DE LA TABLE DE RATTACHEMENT AU PVF

//-----------------------------------------------------------POUR LES DONNEES PVF1
//---backup qui enregistre l'état des champs en base avant l'enregistrement (version v1 du référentiel)---------------------

$select="SELECT \"idRattachementPVF\" FROM syntaxa.st_correspondance_pvf WHERE \"versionReferentiel\"='v1' and \"codeEnregistrementSyntaxon\"=".$id.";";
if (DEBUG) echo "<br>".$select; //affichage en mode debug de la variable select
			$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC); 
			$num_rows = pg_num_rows($result);
//s'il y a déjà des correspondances avec le pvf1 enregistrées pour ce syntaxon alors on fait une mise à jour des données, sinon on insert de nouvelles données
			if ($num_rows > 0) {			
			//echo "<br>var_dump de backup:";var_dump($backup);
			// renvoi un tableau pour le développeur qui montre les anciennes valeurs et les nouvelles, rempli la table de suivi
			foreach ($backup as $field => $val_1) {
				$val_2 = $_POST[$field.'1'];
				if ($val_1 == 't') $val_1 = "TRUE";
				if ($val_1 == 'f') $val_1 = "FALSE";
				$modif = check_modif($val_1,$val_2,$field);
				// if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
				if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,'st_correspondance_pvf',$field,$val_1,$val_2,$id_page,'manuel',$modif);
				
			//mise à jour des données dans la table de correspondance entre les syntaxons et le pvf
				$update="update syntaxa.st_correspondance_pvf set \"idRattachementPVF\"=$val_2 where \"versionReferentiel\"='v1' and \"codeEnregistrementSyntaxon\"=".$id.";";	
				if (DEBUG) echo "<br>".$update;
				$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));
				pg_free_result($result);
				} 	
			} else {
				//mise à jour de la sequence pour la colonne serial idRattachementPVF (en cas d'ajout manuel de données dans la table directement à travers la base de données)
			$query="SELECT setval('syntaxa.\"st_correspondance_pvf_idCorrespondancePVF_seq\" ', COALESCE((SELECT MAX(\"idCorrespondancePVF\")+1 FROM syntaxa.st_correspondance_pvf), 1), false);";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
			pg_free_result($result);
			//insertion d'une nouvelle valeur dans la table de correspondance entre le syntaxon et le pvf (ici nouvelle valeur de rattachement au pvf1)
			$insert="INSERT INTO syntaxa.st_correspondance_pvf (\"idRattachementPVF\",\"codeEnregistrementSyntaxon\",\"versionReferentiel\") VALUES (";
			$champs= sql_format_quote($_POST['idRattachementPVF1'],'do').",".$_POST['id'].",'v1') RETURNING \"idRattachementPVF\";";
			$query=	$insert.$champs;
			echo "<br>".$query;
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
			pg_free_result($result);
			echo "<br> un nouveau rattachement pvf ajouté en base <br>";
			add_suivi2($etape,$id_user,$id,'st_correspondance_pvf','idRattachementPVF',null,$_POST['idRattachementPVF1'],$id_page,'manuel','ajout');
				}	
				
//-----------------------------------------------------------POUR LES DONNEES PVF2
//---backup qui enregistre l'état des champs en base avant l'enregistrement (version v2 du référentiel)---------------------

$select="SELECT \"idRattachementPVF\" FROM syntaxa.st_correspondance_pvf WHERE \"versionReferentiel\"='v2' and \"codeEnregistrementSyntaxon\"=".$id.";";
if (DEBUG) echo "<br>".$select; //affichage en mode debug de la variable select
			$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".pg_result_error ($result));
			$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC); 
			$num_rows = pg_num_rows($result);
//s'il y a déjà des correspondances avec le pvf1 enregistrées pour ce syntaxon alors on fait une mise à jour des données, sinon on insert de nouvelles données
			if ($num_rows > 0) {			
			//echo "<br>var_dump de backup:";var_dump($backup);
			// renvoi un tableau pour le développeur qui montre les anciennes valeurs et les nouvelles, rempli la table de suivi
			foreach ($backup as $field => $val_1) {
				$val_2 = $_POST[$field.'2'];
				if ($val_1 == 't') $val_1 = "TRUE";
				if ($val_1 == 'f') $val_1 = "FALSE";
				$modif = check_modif($val_1,$val_2,$field);
				// if (DEBUG) echo ("<BR> $field  ->  $val_1  | $val_2");
				if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($etape,$id_user,$id,'st_correspondance_pvf',$field,$val_1,$val_2,$id_page,'manuel',$modif);
				
			//mise à jour des données dans la table de correspondance entre les syntaxons et le pvf
				$update="update syntaxa.st_correspondance_pvf set \"idRattachementPVF\"=$val_2 where \"versionReferentiel\"='v2' and \"codeEnregistrementSyntaxon\"=".$id.";";	
				if (DEBUG) echo "<br>".$update;
				$result=pg_query ($db,$update) or die ("Erreur pgSQL : ".pg_result_error ($result));
				pg_free_result($result);
				} 	
			} else {
				//mise à jour de la sequence pour la colonne serial idRattachementPVF (en cas d'ajout manuel de données dans la table directement à travers la base de données)
			$query="SELECT setval('syntaxa.\"st_correspondance_pvf_idCorrespondancePVF_seq\" ', COALESCE((SELECT MAX(\"idCorrespondancePVF\")+1 FROM syntaxa.st_correspondance_pvf), 1), false);";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
			pg_free_result($result);
			//insertion d'une nouvelle valeur dans la table de correspondance entre le syntaxon et le pvf (ici nouvelle valeur de rattachement au pvf2)
			$insert="INSERT INTO syntaxa.st_correspondance_pvf (\"idRattachementPVF\",\"codeEnregistrementSyntaxon\",\"versionReferentiel\") VALUES (";
			$champs= sql_format_quote($_POST['idRattachementPVF2'],'do').",".$_POST['id'].",'v2') RETURNING \"idRattachementPVF\";";
			$query=	$insert.$champs;
			echo "<br>".$query;
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
			pg_free_result($result);
			echo "<br> un nouveau rattachement pvf ajouté en base <br>";
			add_suivi2($etape,$id_user,$id,'st_correspondance_pvf','idRattachementPVF',null,$_POST['idRattachementPVF2'],$id_page,'manuel','ajout');
				}	
			

//-----------------------------------------------------------EDITION DE LA TABLE DES HIC-------------------------------------------
//-----------------------------------------------------------	backup qui enregistre l'état des champs en base, avant l'enregistrement-----------------
//
//ATTENTION AU MOMENT DE L'EDITION, SI L ENREGISTREMENT NEXISTE PAS C UN INSERT SINON C UN UPDATE!

	$query="SELECT \"codeHIC\" FROM syntaxa.st_correspondance_hic where \"codeEnregistrement\"=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$i=0;
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
		{
		$hic_base[$i]=$row["codeHIC"];
		$i++;
		}
	//echo "<br>hic_base 0=".$hic_base[0];
	//echo "<br>hic_base 1 =".$hic_base[1];

	/*déclaration quand la variable est vide*/

	if (empty($hic_base)) {$hic_base = array();}
	if (empty($_POST["hic_select"])) {$_POST["hic_select"] = array();}
	pg_free_result ($result);
  

//-------------------------------------------------------------- mise à jour de la table st_correspondance_hic avec les nouvelles valeurs d'hic ---------------------


$supp = array_diff($hic_base, $_POST["hic_select"]);
$add = array_diff($_POST["hic_select"],$hic_base);
var_dump($supp);
var_dump($add);

if (!empty($supp))
	{
   foreach ($supp as $field => $val)
		{
		$val="'".$val."'";
		$query.= "DELETE FROM syntaxa.st_correspondance_hic WHERE (\"codeEnregistrement\",\"codeHIC\") = ($id,$val); ";
		add_suivi2($etape,$id_user,$id,'st_correspondance_hic','codeHIC',$val,'',$id_page,'manuel','suppr');
		}
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	pg_free_result ($result); 
	//mise à jour de la table de suivi

	
	}
	
if (!empty($add))
	{
   foreach ($add as $field => $val)
		{
   if (DEBUG) echo "valeur=".$val."<br>";
   $val="'".$val."'";
   $query.="INSERT INTO syntaxa.st_correspondance_hic (\"codeEnregistrement\",\"typeEnregistrement\",\"codeHIC\") VALUES ($id,'syntaxon',$val); ";
   add_suivi2($etape,$id_user,$id,'st_correspondance_hic','codeHIC','',$val,$id_page,'manuel','ajout');
		}
	if (DEBUG) echo "<br> query de HIC".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	pg_free_result ($result); 

	}
	
	

//-----------------------------------------------------------EDITION DE LA TABLE DES EUNIS-------------------------------------------
//-----------------------------------------------------------	backup qui enregistre l'état des champs en base, avant l'enregistrement-----------------
//
//ATTENTION AU MOMENT DE L'EDITION, SI L ENREGISTREMENT NEXISTE PAS C UN INSERT SINON C UN UPDATE!

/*
	$query="SELECT \"codeEUNIS\" FROM syntaxa.st_correspondance_eunis where \"codeEnregistrement\"=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$i=0;
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
		{
		$eunis_base[$i]=$row["codeEUNIS"];
		$i++;
		}
	//echo "<br>eunis_base 0=".$eunis_base[0];
	//echo "<br>eunis_base 1 =".$eunis_base[1];

	/*déclaration quand la variable est vide*/
/*
	if (empty($eunis_base)) {$eunis_base = array();}
	if (empty($_POST["eunis_select"])) {$_POST["eunis_select"] = array();}
	pg_free_result ($result);
  

//-------------------------------------------------------------- mise à jour de la table st_correspondance_eunis avec les nouvelles valeurs d'eunis ---------------------


$supp = array_diff($eunis_base, $_POST["eunis_select"]);
$add = array_diff($_POST["eunis_select"],$eunis_base);
var_dump($supp);
var_dump($add);

if (!empty($supp))
	{
   foreach ($supp as $field => $val)
		{
		$val="'".$val."'";
		$query.= "DELETE FROM syntaxa.st_correspondance_eunis WHERE (\"codeEnregistrement\",\"codeEUNIS\") = ($id,$val); ";
		add_suivi2($etape,$id_user,$id,'st_correspondance_eunis','codeEUNIS',$val,'',$id_page,'manuel','suppr');
		}
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	pg_free_result ($result); 
	//mise à jour de la table de suivi

	
	}
	
if (!empty($add))
	{
   foreach ($add as $field => $val)
		{
   if (DEBUG) echo "valeur=".$val."<br>";
   $val="'".$val."'";
   $query.="INSERT INTO syntaxa.st_correspondance_eunis (\"codeEnregistrement\",\"typeEnregistrement\",\"codeEUNIS\") VALUES ($id,'syntaxon',$val); ";
   add_suivi2($etape,$id_user,$id,'st_correspondance_eunis','codeEUNIS','',$val,$id_page,'manuel','ajout');
		}
	if (DEBUG) echo "<br> query de eunis".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	pg_free_result ($result); 

	}

	*/

//-----------------------------------------------------------EDITION DE LA TABLE DE CHOROLOGIE-------------------------------------------
//-----------------------------------------------------------	backup qui enregistre l'état des champs en base, avant l'enregistrement-----------------
//
//ATTENTION AU MOMENT DE L'EDITION, SI L ENREGISTREMENT NEXISTE PAS C UN INSERT SINON C UN UPDATE!
/*
select "codeEnregistrement","idTerritoire", "statutChorologie","idTerritoire" from syntaxa.st_chorologie ch
inner join syntaxa.liste_geo li
on ch."idTerritoire"=li."id_territoire"
where li.code_type_territoire='DEP' and "codeEnregistrement"='CBIG_syntaxon_3964' ;

*/  
	$query="SELECT \"idTerritoire\" FROM syntaxa.st_chorologie ch inner join syntaxa.liste_geo li on ch.\"idTerritoire\"=li.id_territoire WHERE li.code_type_territoire='DEP' and \"codeEnregistrement\"=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$i=0;
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
		{
		$dep_base[$i]=$row["idTerritoire"];
		$i++;
		}
	//echo "<br>dep_base 0=".$dep_base[0];
	//echo "<br>dep_base 1 =".$dep_base[1];

	/*déclaration quand la variable est vide*/

	if (empty($dep_base)) {$dep_base = array();}
	if (empty($_POST["departement_select"])) {$_POST["departement_select"] = array();}
	
	 pg_free_result ($result); 

//-------------------------------------------------------------- mise à jour de la table chorologie avec les nouvelles valeurs de départements ---------------------


$supp = array_diff($dep_base, $_POST["departement_select"]);
$add = array_diff($_POST["departement_select"],$dep_base);
var_dump($supp);
var_dump($add);

if (!empty($supp))
	{
   foreach ($supp as $field => $val)
		{
		$val="'".$val."'";
		$query.= "DELETE FROM syntaxa.st_chorologie WHERE (\"codeEnregistrement\",\"idTerritoire\") = ($id,$val); ";
		add_suivi2($etape,$id_user,$id,'st_chorologie','idTerritoire',$val,'',$id_page,'manuel','suppr');
		}
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	pg_free_result ($result);
	//mise à jour de la table de suivi

	
	}
	
if (!empty($add))
	{
	//mise à jour de la sequence pour la colonne serial idChorologie (en cas d'ajout manuel de données dans la table directement à travers la base de données)
	$query.="SELECT setval('syntaxa.\"st_chorologie_idChorologie_seq\" ', COALESCE((SELECT MAX(\"idChorologie\")+1 FROM syntaxa.st_chorologie), 1), false);";
	foreach ($add as $field => $val)
		{
   if (DEBUG) echo "<br>valeur=".$val."<br>";
   $val="'".$val."'";
   $query.="INSERT INTO syntaxa.st_chorologie (\"codeEnregistrement\",\"idTerritoire\") VALUES ($id,$val); ";
   add_suivi2($etape,$id_user,$id,'st_chorologie','idTerritoire','',$val,$id_page,'manuel','ajout');
		}
	if (DEBUG) echo "<br> query de departement".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	pg_free_result ($result);
	}


//-----------------------------------------------------------EDITION DE LA TABLE DES ETAGES DE VEGETATION-------------------------------------------
//-----------------------------------------------------------	backup qui enregistre l'état des champs en base, avant l'enregistrement-----------------
//
//ATTENTION AU MOMENT DE L'EDITION, SI L ENREGISTREMENT NEXISTE PAS C UN INSERT SINON C UN UPDATE!

	$query="SELECT \"codeEtageVeg\" FROM syntaxa.st_etage_veg where \"codeEnregistrement\"=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$i=0;
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
		{
		$etag_veg_base[$i]=$row["codeEtageVeg"];
		$i++;
		}
	//echo "<br>etag_veg_base 0=".$etag_veg_base[0];
	//echo "<br>etag_veg_base 1 =".$etag_veg_base[1];

	/*déclaration quand la variable est vide*/

	if (empty($etag_veg_base)) {$etag_veg_base = array();}
	if (empty($_POST["etage_veg_select"])) {$_POST["etage_veg_select"] = array();}
	
	// pg_free_result ($result); 

//-------------------------------------------------------------- mise à jour de la table st_etage_veg avec les nouvelles valeurs d'étages ---------------------


$supp = array_diff($etag_veg_base, $_POST["etage_veg_select"]);
$add = array_diff($_POST["etage_veg_select"],$etag_veg_base);
echo 'supp:<br>';var_dump($supp);
echo 'add:<br>';var_dump($add);

if (!empty($supp))
	{
   foreach ($supp as $field => $val)
		{
		$val="'".$val."'";
		$query.= "DELETE FROM syntaxa.st_etage_veg WHERE (\"codeEnregistrement\",\"codeEtageVeg\") = ($id,$val); ";
		add_suivi2($etape,$id_user,$id,'st_etage_veg','codeEtageVeg',$val,'',$id_page,'manuel','suppr');
		}
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	//mise à jour de la table de suivi

	
	}
	
if (!empty($add))
	{
    //mise à jour de la sequence pour la colonne serial idCorresEtageveg (en cas d'ajout manuel de données dans la table directement à travers la base de données)
   $query.="SELECT setval('syntaxa.\"st_etage_veg_idCorresEtageveg_seq\" ', COALESCE((SELECT MAX(\"idCorresEtageveg\")+1 FROM syntaxa.st_etage_veg), 1), false);";
   foreach ($add as $field => $val)
		{
   if (DEBUG) echo "<br>valeur=".$val."<br>";
   $val="'".$val."'";
   $query.="INSERT INTO syntaxa.st_etage_veg (\"codeEnregistrement\",\"codeEtageVeg\") VALUES ($id,$val); ";
   add_suivi2($etape,$id_user,$id,'st_etage_veg','codeEtageVeg','',$val,$id_page,'manuel','ajout');
		}
	if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	pg_free_result ($result);
	}
	
	

//-----------------------------------------------------------EDITION DE LA TABLE DES ETAGES BIOCLIMATIQUES-------------------------------------------
//-----------------------------------------------------------	backup qui enregistre l'état des champs en base, avant l'enregistrement-----------------
//
//ATTENTION AU MOMENT DE L'EDITION, SI L ENREGISTREMENT NEXISTE PAS C UN INSERT SINON C UN UPDATE!

	$query="SELECT \"codeEtageBioclim\" FROM syntaxa.st_etage_bioclim where \"codeEnregistrement\"=".$id.";";
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$i=0;
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
		{
		$etag_bioclim_base[$i]=$row["codeEtageBioclim"];
		$i++;
		}
	//echo "<br>etag_bioclim_base 0=".$etag_bioclim_base[0];
	//echo "<br>etag_bioclim_base 1 =".$etag_bioclim_base[1];

	/*déclaration quand la variable est vide*/

	if (empty($etag_bioclim_base)) {$etag_bioclim_base = array();}
	if (empty($_POST["etage_bioclim_select"])) {$_POST["etage_bioclim_select"] = array();}
	
	// pg_free_result ($result); 

//-------------------------------------------------------------- mise à jour de la table st_etage_veg avec les nouvelles valeurs d'étages ---------------------


$supp = array_diff($etag_bioclim_base, $_POST["etage_bioclim_select"]);
$add = array_diff($_POST["etage_bioclim_select"],$etag_bioclim_base);
var_dump($supp);
var_dump($add);

if (!empty($supp))
	{
   foreach ($supp as $field => $val)
		{
		$val="'".$val."'";
		$query.= "DELETE FROM syntaxa.st_etage_bioclim WHERE (\"codeEnregistrement\",\"codeEtageBioclim\") = ($id,$val); ";
		add_suivi2($etape,$id_user,$id,'st_etage_bioclim','codeEtageBioclim',$val,'',$id_page,'manuel','suppr');
		}
    if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	//mise à jour de la table de suivi

	
	}
	
if (!empty($add))
	{ 
	//mise à jour de la sequence pour la colonne serial idCorresEtageBioclim (en cas d'ajout manuel de données dans la table directement à travers la base de données)
	$query.="SELECT setval('syntaxa.\"st_etage_bioclim_idCorresEtageBioclim_seq\" ', COALESCE((SELECT MAX(\"idCorresEtageBioclim\")+1 FROM syntaxa.st_etage_bioclim), 1), false);";
	foreach ($add as $field => $val)
		{
   if (DEBUG) echo "valeur=".$val."<br>";
   $val="'".$val."'";
   $query.="INSERT INTO syntaxa.st_etage_bioclim (\"codeEnregistrement\",\"codeEtageBioclim\") VALUES ($id,$val); ";
   add_suivi2($etape,$id_user,$id,'st_etage_bioclim','codeEtageBioclim','',$val,$id_page,'manuel','ajout');
		}
	if (DEBUG) echo "<br>".$query;
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

	}


//----------------------------------------------------------------------------------------------------------------------------------------
			
	
    // $query="UPDATE applications.liste_taxon SET nom_scien= ".frt("nom_sci",$_POST["nom_sci"]).", cd_ref= '".frt("cd_ref",$_POST["cd_ref"])."' WHERE uid = ".$id." AND rubrique_taxon = 'lr';";
    // if (DEBUG) echo "<br>".$query;
    // $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));

		add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Saisie edit fiche",$id,"syntaxa");
//		}
//	if ($niveau >= 64)	/*Seulement les participants et au dessus*/
/*		{ echo "niveau >64";
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
		*/
//---------------------------------------------------------------ENREGISTREMENT DANS LE CADRE D'UN NOUVEL AJOUT DE FICHE 		
	} else {   echo "id est vide";
                                                                  //  ADD
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
	echo $query;
	
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
	".sql_format_quote($_POST['nomSyntaxon'],'do').",".sql_format_quote($_POST['auteurSyntaxon'],'do').",TRIM('".$_POST['nomSyntaxon']." ".$_POST['auteurSyntaxon']."'),".sql_format_quote($_POST['rangSyntaxon'],'do').") RETURNING \"codeEnregistrementSyntax\";";
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
	if (isset($_POST['idCatalogue2'])) {
	if (!empty($_POST['idCatalogue2'])) {
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_catalogue_description","identifiantCatalogue",null,$_POST["idCatalogue2"],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_catalogue_description","libelleCatalogue",null,$_POST["libelleCatalogue2"],'syntaxa','manuel','ajout');
	}} else {echo "</br> pas d'insertion de nouveau catalogue dans st_catalogue_description";}
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","idCatalogue",null,$_POST["idCatalogue"],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_chorologie","idTerritoire",null,$_POST["idTerritoireObligatoire"],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_chorologie","idChorologie",null,$id_chrologie,'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_chorologie","statutChorologie",null,$_POST["statutChorologie"],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","codeEnregistrementSyntax",null,$uid,'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","idSyntaxon",null,$_POST["idSyntaxon"],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","nomSyntaxon",null,$_POST["nomSyntaxon"],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","auteurSyntaxon",null,$_POST["auteurSyntaxon"],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","nomCompletSyntaxon",null,$_POST['nomSyntaxon']." ".$_POST['auteurSyntaxon'],'syntaxa','manuel','ajout');
	add_suivi2($_POST["etape"],$id_user,sql_format_quote($uid,'do'),"st_syntaxon","rangSyntaxon",null,$_POST["rangSyntaxon"],'syntaxa','manuel','ajout');

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