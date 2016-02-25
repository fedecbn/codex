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
$path = Data_path.$id."";

/*type de jdd*/
$fsd = array("data" => "Data","taxa" => "Taxa","meta" => "Meta");
$fsd_simple = array("data" => "Data","taxa" => "Taxa");
$date_obs = array("1990" => "après 1990",	"2000" => "après 2000",	"tout" => "tout");

$typverif = array(
	"all" => "Toutes les verifications",
	"obligation" => "Obligation",
	"type" => "Format des champs",
	"doublon" => "Unicité des champs",
	"voca_ctrl" => "Vocabulaire contrôlé"
	);

$typpush = array(
	"add" => "Ajout de la différence",
	"del" => "Suppression de données à partir de la partie temporaire",
	"replace" => "Remplacement total"
	);
	
$typdiff = array(
	"add" => "Différences",
	"del" => "Points communs"
	);
	
$statut = array(
	"LR" => "Liste rouge",
	"LEEE" => "Liste EEE",
	"DEF_OBS" => "Déficit d'observation",
	"DEGNAT" => "Degré de naturalisation",
	"PRES_TEST_GERM" => "Présence de test de germination",
	"INDI" => "Indigénat",
	"PRES_BANQ" => "Présence en banque de semence",
	"RAR" => "Rareté",
	"ALL" => "Tous les statuts"
	);

$format = array(
	"fcbn" => "FCBN",
	"sinp" => "SINP"
	);

	
//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
$db2=sql_connect_hub(SQL_base_hub);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);


//------------------------------------------------------------------------------ REF.
/*type de jdd pour vérification*/
$query = "SELECT cd_jdd FROM ".$_GET['id'].".temp_metadonnees;";
$result=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
while ($row = pg_fetch_row($result))
	$jdd_cbn[$row[0]] = $row[0];
$jdd_cbn = $jdd_cbn == null ? array() : $jdd_cbn;

$query = "SELECT cd_jdd FROM ".$_GET['id'].".metadonnees;";
$result=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
while ($row = pg_fetch_row($result))
	$jdd_cbn_propre[$row[0]] = $row[0];
$jdd_cbn_propre = $jdd_cbn_propre == null ? array() : $jdd_cbn_propre;
	
 $all = array("all" => "Tous les jeux de données");	
 $jdd["import"] = $fsd_simple;
 $jdd["verif"] = array_merge($all,$fsd,$jdd_cbn);
 $jdd["export"] = array_merge($fsd_simple,$jdd_cbn);
 $jdd["clear"] = $jdd["push"] =  $jdd["diff"] = array_merge($all,$fsd_simple,$jdd_cbn);
 $jdd["pull"] = array_merge($all,$fsd_simple,$jdd_cbn_propre);
//------------------------------------------------------------------------------ CONSTANTES du module


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
	

function apparition_champ(champ1,champ2,val_affichage)
	{
	if (document.getElementById(champ1).value == val_affichage)
		{      
		document.getElementById(champ2).style.display = "";
		}
	else    
		{
		document.getElementById(champ2).style.display = "none";
		}
	}

	
</script> 
<?php
//------------------------------------------------------------------------------ REF.

echo ("<div id=\"chargement\" style=\"display:none;text-align:center;\">Chargement en cours... <img src=\"../../_GRAPH/aidesaisiewait.gif\">  Merci de patienter  </div>");


if (isset($_GET['id']) & !empty($_GET['id']))  
	{
	switch ($mode) {
		//------------------------------------------------------------------------------ Bilan
		case "clear" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"clear\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Nettoyage </LEGEND>");
			echo ("Supprime définitivement le contenu de la partie temporaire.");
echo ("<BR>");
			echo ("<label class=\"preField\">Type de jeu de données</label><select id=\"jdd\" name=\"jdd\"\">");
			foreach ($jdd[$mode] as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");

		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
	//------------------------------------------------------------------------------ Import
		case "import" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"import\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Choix du type de données </LEGEND>");
			echo ("<label class=\"preField\">Type de jeu de données</label><select id=\"jdd\" name=\"jdd\"\">");
			foreach ($jdd[$mode] as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
			
			echo ("<div id = \"div_format\" style=\"\">");
				echo ("<label class=\"preField\">Format d'import</label>");
				echo ("<select id=\"format\" name=\"format\">");
				foreach ($format as $key => $val) 
					echo ("<option value=\"$key\">".$val."</option>");
				echo ("</select>");
			echo ("</div>");
			
			/*Liste de fichiers*/
			$files = scandir($path."/import");
			unset($files[array_search("..", $files)]);
			unset($files[array_search(".", $files)]);
			echo ("<BR><BR>");
			echo ("<table class = \"basic_table\">");
			echo ("<tr><td>Liste des fichiers dans le dossier d'import</td></tr>");
			foreach ($files as $key => $val)
				echo ("<tr><td>$val</td></tr>");
			echo ("</table>");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
	//------------------------------------------------------------------------------ Import de taxon
		case "import_taxon" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"import_taxon\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Choix du fichier à importer</LEGEND>");
			echo("Attention, ENCODAGE = UTF8 et DELIMITER = ; ");
			metaform_text("Fichier \"Liste de taxon\"",null,50,null,"file_listtaxon",null);
			echo ("<BR>");
			metaform_bool ("Rechercher les infra-taxons",null,"infrataxon","f");
			
			/*Liste de fichiers*/
			$files = scandir($path."/import");
			unset($files[array_search("..", $files)]);
			unset($files[array_search(".", $files)]);
			echo ("<BR><BR>");
			echo ("<table class = \"basic_table\">");
			echo ("<tr><td>Liste des fichiers dans le dossier d'import</td></tr>");
			foreach ($files as $key => $val)
				echo ("<tr><td>$val</td></tr>");
			echo ("</table>");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
	//------------------------------------------------------------------------------ Verification
		case "verif" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"verif\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Choix des données à vérifier </LEGEND>");
			echo ("<label class=\"preField\">Jeu(x) de données</label><select id=\"jdd\" name=\"jdd\" >");
			foreach ($jdd[$mode] as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
			echo ("<label class=\"preField\">Type de vérification</label><select id=\"typverif\" name=\"typverif\" >");
			foreach ($typverif as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
	//------------------------------------------------------------------------------ Push
		case "push" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"push\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Choix des données à pousser </LEGEND>");
			echo ("<label class=\"preField\">Jeu(x) de données</label><select id=\"jdd\" name=\"jdd\" >");
			foreach ($jdd[$mode] as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
			echo ("<label class=\"preField\">Type d'action</label><select id=\"typpush\" name=\"typpush\" >");
			foreach ($typpush as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
	//------------------------------------------------------------------------------ Pull
		case "pull" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"pull\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Choix des données à tirer </LEGEND>");
			echo ("<label class=\"preField\">Jeu(x) de données</label><select id=\"jdd\" name=\"jdd\" >");
			foreach ($jdd[$mode] as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
	//------------------------------------------------------------------------------ diff
		case "diff" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"diff\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Choix des données à vérifier </LEGEND>");
			echo ("<label class=\"preField\">Jeu(x) de données</label><select id=\"jdd\" name=\"jdd\" >");
			foreach ($jdd[$mode] as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
			echo ("<label class=\"preField\">Type d'action</label><select id=\"typdiff\" name=\"typdiff\" >");
			foreach ($typdiff as $key => $val) 
				echo ("<option value=\"$key\">".$val."</option>");
			echo ("</select>");
			echo ("<BR>");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
		//------------------------------------------------------------------------------ Export	
		case "export" : {
		
		$query = "SELECT count(*) FROM $id.zz_log_liste_taxon";
		$result=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		$nb_taxon = pg_fetch_row($result,0);

		$query = "SELECT cd_ref, nom_valide  FROM $id.zz_log_liste_taxon LIMIT 10";
		$result=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		$list_taxon = pg_fetch_all($result);

		echo ("<form method=\"POST\" id=\"form1\" name=\"export\" action=\"#\" >");
		echo ("<fieldset>");
					echo ("<LEGEND> Paramétrage de l'export</LEGEND>");
					echo ("<label class=\"preField\">Type de jeu de données</label>");
					echo ("<select id=\"jdd\" name=\"jdd\" onChange=\"javascript:apparition_champ('jdd','div_data','data');apparition_champ('jdd','div_taxa','taxa');apparition_champ('jdd','div_listTaxon','listTaxon');\">");
					foreach ($jdd[$mode] as $key => $val) 
						echo ("<option value=\"$key\">".$val."</option>");
					echo ("</select>");
					/*DATA*/
					echo ("<div id = \"div_data\">");
						echo ("<BR>");
						metaform_bool ("...depuis la liste de taxon",null,"list_taxon",'t');
						echo("<i>(Nombre de taxon dans la liste : ".$nb_taxon[0].")</i>");
						echo ("<BR>");
						metaform_bool ("Inclure les infra-taxons",null,"infrataxon","f");
						echo ("<BR>");
						echo ("<label class=\"preField\">Période d'observation</label>");
						echo ("<select id=\"periode\" name=\"periode\">");
						foreach ($date_obs as $key => $val) 
							echo ("<option value=\"$key\">".$val."</option>");
						echo ("</select>");
						echo ("<BR>");
						echo ("<label class=\"preField\">Format d'export</label>");
						echo ("<select id=\"format\" name=\"format\">");
						foreach ($format as $key => $val) 
							echo ("<option value=\"$key\">".$val."</option>");
						echo ("</select>");
					echo("</div>");
					/*TAXA*/
					echo ("<div id = \"div_taxa\" style=\"display:none\">");
						echo ("<BR>");
						echo ("<select id=\"statut\" name=\"periode\">");
						foreach ($statut as $key => $val) 
							echo ("<option value=\"$key\">".$val."</option>");
						echo ("</select>");
					echo("</div>");
					/*Liste Taxon*/
					echo ("<div id = \"div_listTaxon\" style=\"display:none\">");
						echo ("<BR>");
						metaform_bool ("Inclure les infra-taxons",null,"infrataxon","f");
						echo ("<BR><BR>");
						echo ("Extrait de la liste des taxons <i>(Nombre total de taxon dans la liste : ".$nb_taxon[0].")</i>");
						echo ("<BR>");
						echo ("<table class = \"basic_table\">");
						echo ("<tr><td>cd_ref</td><td>Nom</td></tr>");
						foreach ($list_taxon as $key => $val)
							echo ("<tr><td>".$val['cdRef']."</td><td>".$val['nomValide']."</td></tr>");
						echo ("</table>");
					echo("</div>");

								/*Liste de fichiers*/
					$files = scandir($path."/export");
					unset($files[array_search("..", $files)]);
					unset($files[array_search(".", $files)]);
					echo ("<BR><BR>");
					echo ("<table class = \"basic_table\">");
					echo ("<tr><td>Liste des fichiers dans le dossier d'export</td></tr>");
					foreach ($files as $key => $val)
						echo ("<tr><td>$val</td></tr>");
					echo ("</table>");

		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
		//------------------------------------------------------------------------------ Bilan
		case "bilan" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"bilan\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Bilan </LEGEND>");
			echo ("Rafraîchir le bilan permet de mettre à jour le tableau de synthèse.");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
		//------------------------------------------------------------------------------ Logs
		case "log" : {
		echo ("<form method=\"POST\" id=\"form1\" name=\"bilan\" action=\"#\" >");
		echo ("<fieldset>");
			echo ("<LEGEND> Logs </LEGEND>");
			echo ("Vider les logs de cette fiche");
		echo ("</fieldset>");
		echo ("</form>");
			}
			break;
		}
	}
else die ("> Pas de résultats !");

?>
