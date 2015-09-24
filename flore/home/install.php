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
$rub = array (
	"applications" =>"Base de l'outil",
	"liste_rouge" =>"Rubrique Référentiel National",
	"eee" =>"Rubrique Liste Espèce Exotique Envahissante",
	"catnat" =>"Rubrique Catalogue National",
	"refnat" =>"Rubrique Référentiel National",
	"lsi" =>"Rubrique Lettre Système d'Information"
	);

switch ($action)
{
/*-------------------------------------------------------------------------------------*/
/*Formulaire d'installation------------------------------------------------------------*/
default :
case "install-param":	{
	
	/*--------------------------------------*/
	/*Renseignement des valeurs du formulaire*/
	if (file_exists("../../_INCLUDE/install-ok.txt"))
		{
		require_once ("../../_INCLUDE/config_sql.inc.php");		
		$host = SQL_server;$port = SQL_port;$user = SQL_user;$mdp = SQL_pass;$dbname = SQL_base;
		$db = connexion ($host,$port,$user,$mdp,$dbname);	
	
		foreach ($rub  as $key => $val)
			{
			$query = "SELECT 1 FROM information_schema.schemata WHERE schema_name = '".$key."';";
			$schema = pg_query($db,$query);
			$row = pg_fetch_row($schema);
			if ($row[0] == "1") 
				{
				$rub_ok[$key] = 't';
				$desc[$key] = " bloque";
				}
			else 
				{
				$rub_ok[$key] = 'f';
				$desc[$key] = "";
				}
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
	if (!file_exists("../../_INCLUDE/install-ok.txt"))
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
					$rub_ok["applications"] = 't';
					foreach ($rub as $key => $val)
						{
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
	elseif (file_exists("../../_INCLUDE/install-ok.txt"))
		{require_once ("../../_INCLUDE/config_sql.inc.php");	$host = SQL_server;$port = SQL_port;$user = SQL_user;$mdp = SQL_pass;$dbname = SQL_base;}
	else
		echo ("Problème de connexion<button id=\"return-button\">retour au menu</button></center>");
	
	$conn_admin = connexion ($host,$port,$user,$mdp,"postgres");

	if ($conn_admin)
		{
		echo ("connexion établie<BR>"); 
		
		/*------------------*/
		/*Création de la BDD*/
		$conn_codex = connexion ($host,$port,$user,$mdp,$dbname);
		if (!$conn_codex)
			{
			$result = pg_query($conn_admin,"CREATE DATABASE $dbname ENCODING = 'UTF8' LC_COLLATE = 'French_France.1252' LC_CTYPE = 'French_France.1252';");
			echo ("La base de données $dbname a été créée<BR>"); 
			}
		else
			echo ("La base de données $dbname existait déjà<BR>"); 
		
		/*-------------------------------*/
		/*Création de l'utilisateur CODEX*/
		$conn_codex = connexion ($host,$port,$user,$mdp,$dbname);
		if (!pg_query($conn_codex,"SELECT 1 FROM pg_roles WHERE rolname='$user_codex';"))		
			{
			$result = pg_query($conn_codex,"CREATE USER $user_codex PASSWORD $mdp_codex;");
			echo ("L'utilisateur $user_codex a été créé<BR>"); 
			}
		else
			echo ("L'utilisateur $user_codex existait déjà<BR>"); 
		
		/*-------------------*/	
		/*Structure de la BDD*/
		foreach ($rub as $key => $val)
			{
			if ($_POST[$key] == 't')
				{
				$sql = "../../_DATA/bdd_codex_archi_$key.sql";
				$query = create_schema($sql,$user_codex);
				// $result = pg_query($conn_codex,$query);
				echo ("L'architecture de la $valeur a été implémentée<BR>"); 
				}
			else
				echo ("L'architecture de la $valeur existait déjà ou n'a pas été selectionnée<BR>"); 
			}
		
		
		/*----------------------------*/
		/*Intégration des référentiels*/
		$result = pg_query($conn_codex,"SELECT cd_ref FROM refnat.taxrefv80_utf8 LIMIT 1");
		$row = pg_fetch_row($result);			
		if (empty($row))
			{
			// $query = create_data($user_codex);
			// $result = pg_query($conn_codex,$query);
			echo ("Les référentiels de la base de données $dbname ont été implémentés<BR>"); 
			}
		else
			echo ("Les référentiels de la base de données $dbname avaient déjà été implémentés<BR>"); 
			
			
		/*------------------------------------------*/
		/*parametrage du ficher de conf sql_connect*/
		if (!file_exists("../../config_sql.inc.php"))
			{
			copy ("../../config_sql.inc.example.php","../../config_sql.inc.php");
			$sql_file = file_get_contents("../../config_sql.inc.php");
			$sql_file = str_replace("localhost",$host,$sql_file);
			$sql_file = str_replace("5432",$port,$sql_file);
			$sql_file = str_replace("user_codex",$user_codex,$sql_file);
			$sql_file = str_replace("codex_user",$mdp_codex,$sql_file);
			$sql_file = str_replace("postgres",$user,$sql_file);
			$sql_file = str_replace("admin_pass",$mdp,$sql_file);
			$sql_file = str_replace("codex",$dbname,$sql_file);
			}
		
		
		/*Bouton finalisation de l'install*/
		echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");			
		echo ("<center><input type=\"hidden\" name=\"action\" value=\"install-finish\" />");
		echo ("<button id=\"install-finish-button\">Fin de l'installation</button></center>");
		echo ("</form>");
		}
	else
		{
		echo ("Problèmes de connexion<BR>");
		echo ("<button id=\"return-button\">retour au menu</button></center>");
		}
	echo ("</div>");
	}
	break;	

case "install-finish":	{
	fopen("../../_INCLUDE/install-ok.txt","w+");
	header("Location: ../../index.php");
	}
	break;
}


function connexion ($host,$port,$user,$mdp,$dbname) {
	$connexion = "host=$host port=$port user=$user password=$mdp dbname=$dbname";
	$conn = pg_connect($connexion);
	return $conn;
	}

function create_schema($sql,$user_codex) {
	$archi = file_get_contents($sql);
	$query = str_replace("postgres",$user_codex,$archi);
	return $query;
}	
?>
	