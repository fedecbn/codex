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
define ("DEBUG",false);
$id = isset($_POST['id']) ? $_POST['id'] : "";
$mode = $_POST['m'] != null ? $_POST['m'] : null;
$jdd = $_POST['jdd'];
$typverif = $_POST['typverif'];
$typpush = $_POST['typpush'];
$typdiff = $_POST['typdiff'];
$lonely_file = $_POST['lonely_file'] != null ? $_POST['lonely_file'] : 'f';
$infrataxon = $_POST['infrataxon'] != null ? $_POST['infrataxon'] : 'f';
$from_propre = $_POST['from_propre'] != null ? $_POST['from_propre'] : 'f';
$ecraser = $_POST['ecraser'] != null ? $_POST['ecraser'] : 'f';
$file = $_POST['file'];
$statut = $_POST['statut'];
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
		/*CLEAR*/
		case "clear" : {
			if ($jdd == 'all')
				{
				$query = "SELECT * FROM hub_clear('$id', 'data', 'temp');";
				$query .= "SELECT * FROM hub_clear('$id', 'taxa', 'temp');";
				}
			else $query = "SELECT * FROM hub_clear('$id', '$jdd', 'temp');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
		/*DEL*/
		case "del" : {
			if ($jdd == 'all')
				{
				$query = "SELECT * FROM hub_clear('$id', 'data', 'propre');";
				$query .= "SELECT * FROM hub_clear('$id', 'taxa', 'propre');";
				}
			else $query = "SELECT * FROM hub_clear('$id', '$jdd', 'propre');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
		/*IMPORT*/
		case "import" : {
			$path .= "import/";
			/*Récupération des cj_jdd*/
			
			if ($lonely_file == true) {$file = substr(substr($file, 4), 0, -4);$query = "SELECT * FROM hub_import('$id', '$jdd', '$path', $ecraser, '$file');";}
			else $query = "SELECT * FROM hub_import('$id', '$jdd', '$path', $ecraser);";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
		/*IMPORT TAXON*/	
		case "import_taxon" : {			
			/*Import du fichier*/
			$path .= "import/";
			$nomOrigine = $_FILES['file']['name'];
			$elementsChemin = pathinfo($nomOrigine);
			$extensionFichier = $elementsChemin['extension'];
			// var_dump($elementsChemin);
			$extensionsAutorisees = array("csv","txt");
			if (!(in_array($extensionFichier, $extensionsAutorisees))) {
				echo "Le fichier n'a pas l'extension attendue";
			} else {    
				$repertoireDestination = $path;
				$nomDestination = $nomOrigine;
				if (file_exists($repertoireDestination.$nomDestination))  unlink($repertoireDestination.$nomDestination);
				if (move_uploaded_file($_FILES["file"]["tmp_name"], $repertoireDestination.$nomDestination)) {
					echo "Le fichier temporaire ".$_FILES["file"]["tmp_name"]." a été déplacé vers ".$repertoireDestination.$nomDestination;
				} else echo "Le fichier n'a pas été uploadé (trop gros ?) ou Le déplacement du fichier temporaire a échoué vérifiez l'existence du répertoire ".$repertoireDestination;
			}
			
			$query = "SELECT * FROM hub_import_taxon('$id', '$path','$nomOrigine');";	
			if ($infrataxon == 'TRUE') $query .= "SELECT * FROM hub_txInfra('$id');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;

		/*VERIFICATION*/
		case "verif" : {
			if ($jdd == 'all') $query = "SELECT * FROM hub_verif_all('$id');";
			else $query = "SELECT * FROM hub_verif('$id', '$jdd', '$typverif');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;

		/*PUSH*/
		case "push" : {
			if ($jdd == 'all')
				{
				$query = "SELECT * FROM hub_push('$id', 'data', '$typpush');";
				$query .= "SELECT * FROM hub_push('$id', 'taxa', '$typpush');";
				}
			else $query = "SELECT * FROM hub_push('$id', '$jdd', '$typpush');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
			
		/*PULL*/
		case "pull" : {
			if ($jdd == 'all')
				{
				$query = "SELECT * FROM hub_pull('$id', 'data');";
				$query .= "SELECT * FROM hub_pull('$id', 'taxa');";
				}
			else $query = "SELECT * FROM hub_pull('$id', '$jdd');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
			
		/*DIFF*/
		case "diff" : {
			if ($jdd == 'all')
				{
				$query = "SELECT * FROM hub_diff('$id', 'data','$typdiff');";
				$query .= "SELECT * FROM hub_diff('$id', 'taxa','$typdiff');";
				}
			else $query = "SELECT * FROM hub_diff('$id', '$jdd', '$typdiff');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;

		/*EXPORT*/
		case "export" : {
			$path .= "export/";
			$tempsource = $from_propre == 'TRUE' ? null : 'temp_';
			if ($jdd == 'data' OR $jdd == 'taxa')
				$query = "SELECT * FROM hub_export('$id','$jdd','$path','$format','$tempsource');";
			elseif ($jdd == 'listTaxon')
				{
				if ($infrataxon == 'TRUE') $source = 'listtaxoninfra';
					else $source = 'listtaxon';
				if ($source == 'listtaxoninfra')
					$query = "SELECT * FROM hub_txInfra('$id');SELECT * FROM hub_export('$id', '$source', '$path','taxon');";
				else 
					$query = "SELECT * FROM hub_export('$id', '$source', '$path','taxon');";
				}
			else
				$query = "SELECT * FROM hub_export('$id','$jdd','$path','$format','$tempsource');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
		
		/*BILAN*/
		case "bilan" : {
			$query = "SELECT * FROM hub_bilan('$id');";
			pg_query ($db2,$query) or die ("Erreur pgSQL : ".$query);unset($query);
			}
			break;
		/*LOGS*/
		case "log" : {
			$query = "SELECT * FROM hub_log('$id',null,'clear');";
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
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
