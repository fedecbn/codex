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
$jdd = $_POST['jdd'];
$typverif = $_POST['typverif'];
$typpush = $_POST['typpush'];
$infrataxon = $_POST['infrataxon'] != null ? $_POST['infrataxon'] : 'f';
$listaxon = $_POST['file_listtaxon'] != null ? $_POST['file_listtaxon'] : 'f';
$format = $_POST['format'] != null ? $_POST['format'] : 'fcbn';

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
		/*IMPORT*/
		case "import" : {
			$path = $path."import/";
			if ($typjdd == 'data' OR $typjdd == 'taxa' )
				$query = "SELECT * FROM hub_import('$id', '$typjdd', '$path')";
			elseif ($typjdd == 'listTaxon')
				$query = "SELECT * FROM hub_import('$id', '$typjdd', '$path','$listaxon')";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;

		/*VERIFICATION*/
		case "verif" : {
			if ($jdd == 'all')
				$query = "SELECT * FROM hub_verif_all('$id')";
			else
				$query = "SELECT * FROM hub_verif('$id', '$jdd', '$typverif')";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;

		/*PUSH*/
		case "push" : {
			$query = "SELECT * FROM hub_push('$id', '$jdd', '$typpush')";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;

		/*EXPORT*/
		case "export" : {
			$path = $path."export/";
			if ($typjdd == 'data' OR $typjdd == 'taxa')
				$query = "SELECT * FROM hub_export('$id','$typjdd','$path','$format')";
			elseif ($typjdd == 'listTaxon')
				{
				if ($infrataxon == 'TRUE') $source = 'listtaxoninfra';
					else $source = 'listtaxon';
				if ($source == 'listtaxoninfra')
					$query = "SELECT * FROM hub_txInfra('$id');SELECT * FROM hub_export('$id', '$source', '$path','taxon');";
				else 
					$query = "SELECT * FROM hub_export('$id', '$source', '$path','taxon');";
				}
				echo $query;
				pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
		
		/*BILAN*/
		case "bilan" : {
			$query = "SELECT * FROM hub_bilan('$id');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
		}
	} else {                                                                     //  ADD
//------------------------------------------------------------------------------ Valeurs numériques
    if ($_POST['etape']=="") $_POST['etape']=2;
//------------------------------------------------------------------------------
	/*Paramètre à ajouter*/
	
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
