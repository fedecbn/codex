<?php
//------------------------------------------------------------------------------//
//  /index.php                                                                  //
//                                                                              //
//  Version 1.00  13/07/12 - OlGa (CBNMED)                                      //
//------------------------------------------------------------------------------//
require_once ("../../_INCLUDE/fonctions.inc.php");
?>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.validate.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.cookie.js"></script>

<script type="text/javascript" language="javascript" >
$(document).ready(function(){
	$("#form1").validate({
		rules: {
			host: {
				required: true,
                minlength: 2
			},
			port: {
				required: true,
                minlength: 3
			},
			user: {
				required: true,
                minlength: 2
			},
			mdp: {
				required: true,	
                minlength: 3
			},
		},
		messages: {
			host: { required: "",	minlength: ""},
			port: { required: "",	minlength: ""},
			user: { required: "",	minlength: ""},
			mdp: { required: "",	minlength: ""}
		}
	}); 
	
	$("#install-button")
        .button({
            text: true
        });
	
	$("#install-finish-button")
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('index.php');
		});
	
    $("#return-button")
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('install.php');
		});
	
});
</script> 
<?php

html_header_2 ("utf-8","table_eval.css","jquery-te-1.4.0.css","Installation de Codex");
/*-------------------------------------------------------------------------------------*/
/*En-tête------------------------------------------------------------------------------*/
echo ("<body>");
echo ("<div id=\"header2\">");
    echo ("<font size=5> Installation de l'outil Codex </font>");
echo ("</div>");

/*-------------------------------------------------------------------------------------*/
/*Variables----------------------------------------------------------------------------*/
$action=isset ($_POST['action']) ? $_POST['action'] : "";
$dir = scandir("../");
/*suppression des valeurs non concernées*/
$less = array ('bugs', 'home', 'module_admin','commun','index.php','.','..');
foreach ($less as $element)
	unset($dir[array_search($element, $dir)]);

foreach ($dir  as $key => $val)
	{
	include ("../$val/commun.inc.php");
	$rub[$val] = $name_page;
	}

$pos = 0;

switch ($action)
{
/*-------------------------------------------------------------------------------------*/
/*Formulaire d'installation------------------------------------------------------------*/
default :
case "install-param":	{
	
	/*--------------------------------------*/
	/*Renseignement des valeurs du formulaire*/
	if (file_exists("../../_INCLUDE/config_sql.inc.php"))
		{
		require_once ("../../_INCLUDE/config_sql.inc.php");		
		$host = SQL_server;$port = SQL_port;$user = SQL_user;$mdp = SQL_pass;$dbname = SQL_base;
		$db = connexion ($host,$port,$user,$mdp,$dbname);	
	
		foreach ($rub as $key => $val)
			{
			$query = "SELECT 1 FROM information_schema.schemata WHERE schema_name = '".$key."';";
			$schema = pg_query($db,$query);
			$row = pg_fetch_row($schema);
			
			if ($row[0] == "1") 		{$rub_ok[$key] = 't';$desc[$key] = " bloque";}
			elseif (file_exists("../../_DATA/bdd_codex_archi_".$key.".sql") == TRUE) 	
										{$rub_ok[$key] = 'f';$desc[$key] = "";}
			else 						{$rub_ok[$key] = 'f';$desc[$key] = " bloque";}
			}
		}
	else
		{
		require_once ("../../_INCLUDE/config_sql.inc.example.php");	
		foreach ($rub  as $key => $val)	{$rub_ok[$key] = 'f'; $desc[$key] = "";}
		}
		
	echo ("<div id=\"fiche\" >");
	echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");
	echo ("<center><input type=\"hidden\" name=\"action\" value=\"install-set\" />");
	if (!file_exists("../../_INCLUDE/config_sql.inc.php"))
	{
	//------------------------------------------------------------------------------ EDIT LR GRP1
			echo ("<div id=\"radio1\">");    
			echo ("<fieldset style=\"width: 50%;\"><LEGEND>Connexion au serveur de base de données</LEGEND>");
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 800px;\">");
						metaform_text ("Hôte","",50,"","host",SQL_server);
						metaform_text ("Port","",25,"","port",5432);
						metaform_text ("Utilisateur admin","",50,"","user",SQL_admin_user);
						metaform_pw ("Mot de passe admin","",50,"","mdp",SQL_admin_pass);
					echo ("</td></tr></table>");	
				echo ("</fieldset>");
	//------------------------------------------------------------------------------ EDIT LR GRP2 
			echo ("<fieldset  style=\"width: 50%;\"><LEGEND> Création de la base de données </LEGEND>");
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 800px;\">");
						metaform_text ("Nom de la base","",50,"","dbname",SQL_base);
						metaform_text ("Utilisateur codex","",50,"","user_codex",SQL_user);
						metaform_pw ("Mot de passe codex","",20,"","mdp_codex",SQL_pass);
					echo ("</td></tr></table>");	
				echo ("</fieldset>");
	}
	//------------------------------------------------------------------------------ EDIT LR GRP3
			echo ("<fieldset style=\"width: 50%;\"><LEGEND> Choix des rubriques à installer </LEGEND>");
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 800px;\">");
					$rub_ok["refnat"] = 't';
					foreach ($rub as $key => $val)
						{
						if (file_exists("../../_DATA/bdd_codex_archi_".$key.".sql") == FALSE) {$desc[$key] = " bloque";}
						metaform_bool ($val,$desc[$key],$key,$rub_ok[$key]);
						// metaform_bool ($val,$desc[$key],$key."_data",$rub_ok[$key]);
						echo ("<BR>");
						}
					echo ("</td></tr></table>");	
				echo ("</fieldset>");
			echo ("</div>");
		echo ("</div></center>");
		echo ("<center><button id=\"install-button\">Lancer l'installation</button></center>");
	echo ("</form>");
	}
	break;
/*-------------------------------------------------------------------------------------*/
/*Réalisation de l'installation--------------------------------------------------------*/
case "install-set":	{
	echo ("<div id=\"fiche\" >");
	if (isset($_POST["host"]) AND isset($_POST["port"]) AND isset($_POST["user"]) AND isset($_POST["mdp"]) AND isset($_POST["dbname"]) AND isset($_POST["user_codex"]) AND isset($_POST["mdp_codex"]))
		{$host = $_POST["host"];$port = $_POST["port"];$user = $_POST["user"];$mdp = $_POST["mdp"];$dbname = $_POST["dbname"];$user_codex = $_POST["user_codex"];$mdp_codex = $_POST["mdp_codex"];}
	elseif (file_exists("../../_INCLUDE/config_sql.inc.php"))
		{require_once ("../../_INCLUDE/config_sql.inc.php");	$host = SQL_server;$port = SQL_port;$user = SQL_admin_user;$mdp = SQL_admin_pass;$dbname = SQL_base; $user_codex = SQL_user;$mdp_codex = SQL_pass;}
	else
		echo ("Problème de connexion<button id=\"return-button\">retour au menu</button></center>");
	
	$conn_admin = connexion ($host,$port,$user,$mdp,"postgres");

	if ($conn_admin)
		{
		echo ("connexion établie<BR>"); 
		
		/*------------------*/
		/*Création de la BDD*/
		$result = pg_query($conn_admin,"SELECT 1 FROM pg_database WHERE datname = '$dbname';");
		$bd_test = pg_fetch_row($result); 
		if ($bd_test[0] == null)
			{
			$result = pg_query($conn_admin,"CREATE DATABASE $dbname ENCODING = 'UTF8' LC_COLLATE = 'French_France.1252' LC_CTYPE = 'French_France.1252';");
			echo ("La base de données $dbname a été créée<BR>"); 
			}
		else
			echo ("La base de données $dbname existait déjà<BR>"); 
		
		/*-------------------------------*/
		/*Création de l'utilisateur CODEX*/
		$conn_codex = connexion ($host,$port,$user,$mdp,$dbname);
		$result = pg_query($conn_codex,"SELECT 1 FROM pg_roles WHERE rolname='$user_codex';");
		$user_test = pg_fetch_row($result); 
		if ($user_test[0] == null)		
			{
			$result = pg_query($conn_codex,"CREATE USER $user_codex PASSWORD '$mdp_codex';");
			echo ("L'utilisateur $user_codex a été créé<BR>"); 
			}
		else
			echo ("L'utilisateur $user_codex existait déjà<BR>"); 
		
		/*-------------------*/	
		/*Structure de la BDD*/
		/*Rubrique application*/
		$key = 'applications';
		$query = "SELECT 1 FROM information_schema.schemata WHERE schema_name = '".$key."';";
		$schema = pg_query($conn_codex,$query);
		$row = pg_fetch_row($schema);
		if ($row[0] != "1")
			{
			$archi = "../../_DATA/bdd_codex_archi_$key.sql";
			$data = "../../_DATA/bdd_codex_data_$key.sql";
			$query = create_query($archi,$user_codex);
			$query .= create_query($data,$user_codex);
			$query .= "INSERT INTO applications.utilisateur(id_user, id_cbn, nom, prenom, login, pw, niveau_lr, niveau_eee, niveau_lsi, niveau_catnat, niveau_refnat) VALUES ('ADMI1',16,'admin','admin','admin','admin',255,255,255,255,255);";
			$query .= create_query("../../_DATA/bdd_codex_referentiels.sql",$user_codex);
			}
		
		/*les autres rubriques*/
		foreach ($rub as $key => $val)
			{
			if (isset($_POST[$key]))
				{
				if ($_POST[$key] == 'TRUE')
					{
					$archi = "../../_DATA/bdd_codex_archi_$key.sql";
					$data = "../../_DATA/bdd_codex_data_$key.sql";
					$query = create_query($archi,$user_codex);
					$query .= create_query($data,$user_codex);
					$query .= "INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES ($pos, '$key', $pos ,'saisie.png', '$val', '', 1, '../$key/index.php', 0);";
					$query .= "ALTER SCHEMA $key OWNER TO $user_codex";
					$result = pg_query($conn_codex,$query);
					echo ("L'architecture de la $val a été implémentée<BR>"); 
					}
				else
					echo ("---<BR>");
				}
				else
					echo ("L'architecture de la $val existait déjà<BR>"); 
			$pos ++;
			}

			
		/*------------------------------------------*/
		/*parametrage du ficher de conf sql_connect*/
		if (!file_exists("../../_INCLUDE/config_sql.inc.php"))
			{
			$sql_file = file_get_contents("../../_INCLUDE/config_sql.inc.example.php");
			$sql_file = str_replace("localhost",$_POST["host"],$sql_file);
			$sql_file = str_replace("5432",$_POST["port"],$sql_file);
			$sql_file = str_replace("user_codex",$_POST["user_codex"],$sql_file);
			$sql_file = str_replace("codex_user",$_POST["mdp_codex"],$sql_file);
			$sql_file = str_replace("postgres",$_POST["user"],$sql_file);
			$sql_file = str_replace("test",$_POST["mdp"],$sql_file);
			$sql_file = str_replace("codex",$_POST["dbname"],$sql_file);
			file_put_contents("../../_INCLUDE/config_sql.inc.php",$sql_file);
			}
	
		
		
		/*Bouton finalisation de l'install*/
		echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");			
		echo ("<input type=\"hidden\" name=\"action\" value=\"install-finish\" />");
		echo ("<input type=\"hidden\" name=\"host\" value=\"$host\" />");
		echo ("<input type=\"hidden\" name=\"port\" value=\"$port\" />");
		echo ("<input type=\"hidden\" name=\"user\" value=\"$user\" />");
		echo ("<input type=\"hidden\" name=\"mdp\" value=\"$mdp\" />");
		echo ("<input type=\"hidden\" name=\"dbname\" value=\"$dbname\" />");
		echo ("<input type=\"hidden\" name=\"user_codex\" value=\"$user_codex\" />");
		echo ("<input type=\"hidden\" name=\"mdp_codex\" value=\"$mdp_codex\" />");
		echo ("<center><button id=\"install-finish-button\">Fin de l'installation</button></center>");
		echo ("</form>");
		echo ("<center><button id=\"return-button\">Retour à  l'installation</button></center>");
		}
	else
		{
		echo ("Problèmes de connexion<BR>");
		echo ("<center><button id=\"return-button\">retour au menu</button></center>");
		}
	echo ("</div>");
	}
	break;	

case "install-finish":	{
	// fopen("../../_INCLUDE/install-ok.txt","w+");
	header("Location: ../../index.php");

	}
	break;
}


function connexion ($host,$port,$user,$mdp,$dbname) {
	$connexion = "host=$host port=$port user=$user password=$mdp dbname=$dbname";
	$conn = pg_connect($connexion);
	return $conn;
	}

function create_query($sql,$user_codex) {
	$query = file_get_contents($sql);
	$query = str_replace("pg_user",$user_codex,$query);
	$query = str_replace("postgres",$user_codex,$query);
	return $query;
}	
?>
	