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
define ("DEBUG",false);
$id = isset($_POST['id']) ? $_POST['id'] : "";
$mode = $_POST['m'] != null ? $_POST['m'] : null;
$typjdd = $_POST['typjdd'];
$listaxon = $_POST['file_listtaxon'];

/*Datapath*/
$path = Data_path.$id."/";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
$db2=sql_connect_hub(SQL_base_hub);

if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);


//------------------------------------------------------------------------------ EDIT
if (!empty ($id))                                                               
	{
	switch ($mode) {
		case "import" : {
			$path = $path."import/";
			if ($typjdd == 'data' OR $typjdd == 'taxa' )
				$query = "SELECT * FROM hub_import('$id', '$typjdd', '$path')";
			elseif ($typjdd == 'listTaxon')
				$query = "SELECT * FROM hub_import('$id', '$typjdd', '$path','$listaxon')";
			// echo $query;
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
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
