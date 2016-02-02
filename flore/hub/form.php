<?php
//------------------------------------------------------------------------------//
//  module_admin/user-form.php                                                  //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  15/08/14 - Aj $user_level                                     //
//------------------------------------------------------------------------------//
include("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$id = $_GET['id'] != null ? $_GET['id'] : null;
$mode = $_GET['m'] != null ? $_GET['m'] : null;

/*Datapath*/
$path = Data_path.$id."/";
$files = scandir($path);
unset($files[array_search("..", $files)]);
unset($files[array_search(".", $files)]);

$typejdd = array(
	"data" => "jdd data",
	"taxa" => "jdd taxa",
	"listTaxon" => "liste de taxons"
	);
	
//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
// $db=sql_connect (SQL_base);
// if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
//------------------------------------------------------------------------------ CONSTANTES du module
// /*récupération des rubriques*/
/*référents et  niveau de droits*/

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){
	$("#form1").validate({
		rules: {
			jdd: {
				required: true,
                minlength: 2
			},
		},
		messages: {
			jdd: { required: "",	minlength: ""}
			}
		}
	)}); 
</script> 
<?php
//------------------------------------------------------------------------------ REF.
if (isset($_GET['id']) & !empty($_GET['id']))  
	{
	switch ($mode) {
	//------------------------------------------------------------------------------ Import
		case "import" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"import\" action=\"#\" >");
		echo ("<fieldset><LEGEND> Choix du type de données </LEGEND>");
			echo ("<label class=\"preField\">Type de jeu de données</label><select name=\"typjdd\">");
			foreach ($typejdd as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
			metaform_text("Fichier \"Liste de taxon\"",null,50,null,"file_listtaxon","std_listtaxon.csv");
			echo ("<BR><label class=\"preField\">Liste des fichiers disponibles</label><BR>");
			foreach ($files as $key => $val) 
				echo ("- $val<BR>");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
		
		
		}
	}
else die ("> Pas de résultats !");

?>
