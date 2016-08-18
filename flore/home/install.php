<?php
//------------------------------------------------------------------------------//
//  /index.php                                                                  //
//                                                                              //
//  Version 1.00  13/07/12 - OlGa (CBNMED)                                      //
//------------------------------------------------------------------------------//
session_start ();
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
			mdp:  { required: "",	minlength: ""}
		}
	}); 
	
	$("#install-button")
        .button({
            text: true
        });
	
	$("#desinstall-button")
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
ignore_user_abort(true);
html_header_2 ("utf-8","table_eval.css","jquery-te-1.4.0.css","Installation de Codex");
/*-------------------------------------------------------------------------------------*/
/*En-tête------------------------------------------------------------------------------*/
echo ("<body>");
echo ("<div id=\"header2\">");
    echo ("<font size=5> Installation de l'outil Codex </font>");
echo ("</div>");

/*-------------------------------------------------------------------------------------*/
/*Variables----------------------------------------------------------------------------*/
$action=isset ($_POST['action']) ? $_POST['action'] : ""; //variable permettant de définir le case en cours
$dir = scandir("../"); //récupération du nom des rubriques
/*suppression des rubriques non concernées*/
$less = array ('bugs', 'home', 'module_admin','commun','index.php','.','..');
foreach ($less as $element)
	unset($dir[array_search($element, $dir)]);

foreach ($dir  as $key => $val)
	{
	/*Récupération des noms des pages*/
	include ("../$val/desc.inc.php");
	$rub[$val] = $name_page;
	/*pour la création du compte admin*/
	// $nvx[$val] = "niveau_".$val;
	// $nvx_cpt[$val] = "255";
	// $ref[$val] = "ref_".$val;
	// $ref_cpt[$val] = "TRUE";
	}
/*pour la création du compte admin suite*/
// $nvx_admin = implode(",", $nvx);
// $nvx_admin_cpt = implode(",", $nvx_cpt);
// $ref_admin = implode(",", $ref);
// $ref_admin_cpt = implode(",", $ref_cpt);
// $query_admin =	"INSERT INTO applications.utilisateur(id_user, id_cbn, nom, prenom, login, pw, $nvx_admin , $ref_admin) VALUES ('ADMI1',16,'admin','admin','admin','admin',$nvx_admin_cpt, $ref_admin_cpt);";

//attention  ici pour l'accès à la rubrique refnat on a encore l'ancienne gestion des droits avec les niveaux 255 qui devraient être remplacés par le système des droits d1,d2, d3
$query_admin = "INSERT INTO applications.utilisateur(id_user, id_cbn, nom, prenom, login, pw, ref_refnat, niveau_refnat, ref_lr, niveau_lr, ref_catnat, niveau_catnat) VALUES ('ADMI1',16,'admin','admin','admin','admin','true','255', 'true','255', 'true','255');";
	
// $query_admin .=	"INSERT INTO applications.utilisateur_droit(id_user, id_cbn, nom, prenom, login, pw) VALUES ('ADMI1',16,'admin','admin','admin','admin');";
	
$pos = 0; //initialisation d'un variable de position de la rubrique dans la liste

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
		require_once ("../../_INCLUDE/config_sql.inc.php"); //récupération des variables de connexion à la base dans le fichier config_sql.inc.php		
		$host = SQL_server;$port = SQL_port;$user = SQL_user;$mdp = SQL_pass;$dbname = SQL_base;
		$db = connexion ($host,$port,$user,$mdp,$dbname);	

		// var_dump($_SESSION["droit_user"]);
		/*D1 : Droit accès à la page*/
		$base_file = substr(basename(__FILE__),0,-4); //récupère le nom du fichier install.php sans le suffixe .php
		$id_page = "home";
		$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
		if ($droit_page) {                           //seul l'administrateur à les droits d'installation (bdd table applications.droit)

		
			foreach ($rub as $key => $val)
				{
				$query = "SELECT 1 FROM information_schema.schemata WHERE schema_name = '".$key."';";  //vérification de l'existence du schema associé à la rubrique dans la base de données codex
				$schema = pg_query($db,$query);
				$row = pg_fetch_row($schema);
				
				if ($row[0] == "1") 
					{$rub_ok[$key] = 't';$desc[$key] = " bloque";}

				elseif (file_exists("../".$key."/sql/archi.sql")) //vérification de l'existence du fichier qui défini l'architecture du schéma associé à la rubrique	

					{$rub_ok[$key] = 'f';$desc[$key] = "";}
				else 	{$rub_ok[$key] = 'f';$desc[$key] = " bloque";}
				}
		//------------------------------------------------------------------------------ SI PAS ACCES 
			} else require ("../commun/access_denied.php"); 

		}
	else
		{
		require_once ("../../_INCLUDE/config_sql.inc.example.php");	
		foreach ($rub  as $key => $val)	
			{

			if (file_exists("../".$key."/sql/archi.sql"))

				{$rub_ok[$key] = 'f'; $desc[$key] = "";}
			else {$rub_ok[$key] = 'f'; $desc[$key] = " bloque";}
			}
		}
		
	echo ("<div id=\"fiche\" >");
	echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");
	echo ("<center><input type=\"hidden\" name=\"action\" value=\"install-set\" />"); //au lancement du formulaire (bouton "lancer l'installation") on se redirige dans le case install-set
	if (!file_exists("../../_INCLUDE/config_sql.inc.php"))
	{
	//------------------------------------------------------------------------------ EDIT LR GRP1
			echo ("<div id=\"radio1\">");    
			echo ("<fieldset style=\"width: 50%;\"><LEGEND>Connexion au serveur de base de données</LEGEND>");
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 800px;\">");
						metaform_text ("Hôte","",50,"","host","localhost");
						metaform_text ("Port","",25,"","port",5432);
						metaform_text ("Utilisateur admin","",50,"","user","postgres");
						metaform_pw ("Mot de passe admin","",50,"","mdp",null);
					echo ("</td></tr></table>");	
				echo ("</fieldset>");
	//------------------------------------------------------------------------------ EDIT LR GRP2 
			echo ("<fieldset  style=\"width: 50%;\"><LEGEND> Création de la base de données </LEGEND>");
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 800px;\">");
						metaform_text ("Nom de la base","",50,"","dbname","codex");
						metaform_text ("Utilisateur codex","",50,"","user_codex",null);
						metaform_pw ("Mot de passe codex","",20,"","mdp_codex",null);
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
						// if (file_exists("../../_SQL/bdd_codex_archi_".$key.".sql") == FALSE) $desc[$key] = " bloque";
						metaform_bool ($val,$desc[$key],$key,$rub_ok[$key]);
						// metaform_bool ($val,$desc[$key],$key."_data",$rub_ok[$key]);
						if ($key=='refnat')
							 {echo "  * <i>L'installation de cette rubrique est <b>>à 2 minutes</b>, soyez patients</i>";}
						elseif  ($key=='lr' or $key=='eee' or $key=='catnat')
							{echo "  * <i>L'installation de la rubrique Référentiel National est <b>nécessaire</b> pour cette rubrique</i>";}
						else
							{echo "";}
						echo ("<BR>");
						}
					echo ("</td></tr></table>");	
				echo ("</fieldset>");
			echo ("</div>");
		echo ("</div></center>");
		echo ("<center><button id=\"install-button\">Lancer l'installation</button></center>");
	echo ("</form>");
	
	/*Desinstallation*/
	if (file_exists("../../_INCLUDE/config_sql.inc.php"))
		{	
		echo ("<form method=\"POST\" id=\"form2\" class=\"form2\" name=\"desinstall\" action=\"\" >");
			echo ("<input type=\"hidden\" name=\"action\" value=\"desinstall\" />");
			echo ("<BR><BR><center><button id=\"desinstall-button\">Désinstaller</button><BR>Attention, opération non réversible (supprime la base de données).</center> ");
		echo ("</form>");		
		}

	}
	break;
/*-------------------------------------------------------------------------------------*/
/*Réalisation de l'installation--------------------------------------------------------*/
case "install-set":	{
	echo ("<div id=\"fiche\" >");
	//foreach($_POST as $key => $val) echo '$_POST["'.$key.'"]='.$val.'<br />'; //en mode DEBUG affiche la valeur des $_POST
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
		if ($bd_test[0] == false)
			{
			$result = pg_query($conn_admin,"CREATE DATABASE $dbname ENCODING = 'UTF8';");
			echo ("La base de données $dbname a été créée<BR>"); 
			}
		else
			echo ("La base de données $dbname existait déjà<BR>"); 
		
		/*-------------------------------*/
		/*Création de l'utilisateur CODEX*/
		$conn_codex = connexion ($host,$port,$user,$mdp,$dbname);
		$result = pg_query($conn_codex,"SELECT 1 FROM pg_roles WHERE rolname='$user_codex';");
		$user_test = pg_fetch_row($result); 
		if ($user_test[0] == false)		
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
			//$archi = "../../_SQL/bdd_codex_archi_$key.sql";
			//$data = "../../_SQL/bdd_codex_data_$key.sql";
			$archi = "../../flore/home/sql/archi_applications.sql";
			$data = "../../flore/home/sql/data_applications.sql";
			$query = create_query($archi,$user_codex);
			$query .= create_query($data,$user_codex);
			$query .= $query_admin;
			$query .= create_query("../../flore/home/sql/archi_referentiels.sql",$user_codex);
			$query .= create_query("../../flore/home/sql/data_referentiels.sql",$user_codex);
			//$query .= create_query("../../_SQL/bdd_codex_archi_referentiels.sql",$user_codex);
			//$query .= create_query("../../_SQL/bdd_codex_data_referentiels.sql",$user_codex);
			$result = pg_query($conn_codex,$query);
			}
		/*Ajout des droits pour la rubrique home*/
		$query = "SELECT 1 FROM applications.utilisateur_role WHERE id_user = 'ADMI1' and rubrique='home';";
		$result = pg_query($conn_codex,$query);
		$row = pg_fetch_row($result);
		
		if ($row[0] != "1")
			{  
		$query = "INSERT INTO applications.utilisateur_role VALUES ('ADMI1', 'home', false, true, true, true, true, true, true, true);";
		$result = pg_query($conn_codex,$query);
			}
		
		/*les autres rubriques*/
		foreach ($rub as $key => $val)
			{
			if (isset($_POST[$key]))
				{
				if ($_POST[$key] == 'TRUE') //si le bouton radio a été coché en "Oui"
					{
//					if ($key == 'refnat' or $key == 'syntaxa' or $key == 'lr' or $key == 'catnat' or $key == 'eee')
//					{
						//decompresser les fichiers zip dans le dossier sql qui contient soit les .csv soit les .sql par défaut la fonction overwrite est activée
						//attention il faut avoir les droits d'écriture dans le dossier du codex
						foreach (glob("../$key/sql/*.zip") as $filename) 
						{
							$zip = new ZipArchive;
							//var_dump($zip);
							//if ($zip->open("../$key/sql/taxons.zip") === TRUE) {
								if ($zip->open("$filename") === TRUE) 
								{
							    $zip->extractTo("../$key/sql/");
							    $zip->close();
							    //echo 'ok <br>';
								} else 
								{
							   // echo 'échec <br>';
								}
							    //echo "$filename <br>";
						}
						/*creation du schema de la rubrique $key et du squelette de ses tables*/	
						$archi = "../$key/sql/archi.sql";
						$query = create_query($archi,$user_codex);
						$result = pg_query($conn_codex,$query);
						
						/*import des données en base à partir des fichiers sql (sauf fichier archi.sql)*/
						$query="";
						foreach (glob("../$key/sql/*.sql") as $filename) 
							{
							if (strpos($filename, 'archi') === false) 
								{
								//$query .= create_query($data,$user_codex);  //cette requête faisait planter l'installation car remplacer sur un fichier trop lourd est gourmand en mémoire
								$query .= file_get_contents($filename); //pour tous les fichiers .sql sauf archi.sql
								} 														 
							}

						/*import des données en base à partir des fichiers .csv avec COPY FROM*/
						//on peut tester si on est sous windows ou linux pour respecter slash et antislash mais a priori avec realpath ça fonctionne
						set_time_limit(0);
						foreach (glob("../$key/sql/*.csv") as $filename) 
							{   //renvoit le chemin relatif des fichiers csv du dossier
							//echo realpath($filename). "<br>";      ///renvoi le chemin absolu des fichiers csv du dossier et respecte les slash pour le copy from
							$data_csv=realpath($filename); //echo "le fichier csv du copy from est=". $data_csv;
							$nom_table=rtrim(basename("$filename",".csv").PHP_EOL);
							$query_verif = "SELECT 1 FROM information_schema.tables WHERE table_schema = '".$key."' and table_name='".$nom_table."';";
							//echo $query_verif."<br>";
							$verif = pg_query($conn_codex,$query_verif);
							$row_verif = pg_fetch_row($verif);
							//var_dump($row_verif);
								if ($row_verif[0] == false)
								{
								//echo "la table ".$nom_table." n'existe pas dans la base, le fichier csv ne doit pas être importé <br>";
								} 
								else 
								{
								$query .= "COPY $key.$nom_table from '$data_csv' CSV HEADER encoding 'UTF8' DELIMITER E'\t'  ;";
								$requete="COPY $key.$nom_table from '$data_csv' CSV HEADER encoding 'UTF8' DELIMITER E'\t'  ;";
								//echo "requete csv=".$requete."<br>";
								}		    
							}
									
						/*finalisation de la query*/
						$query .= "INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES ($pos, '$key', $pos ,'saisie.png', '$val', '', 1, '../$key/index.php', 0);";				
						$query .= "INSERT INTO applications.utilisateur_role VALUES ('ADMI1', '$key', false, true, true, true, true, true, true, true);";
						$query .= "ALTER SCHEMA $key OWNER TO $user_codex";
						$result = pg_query($conn_codex,$query);
						echo ("L'architecture de la $val a été implémentée avec la nouvelle méthode<BR>"); 
//					} else {
//						$archi = "../../_SQL/bdd_codex_archi_$key.sql";
//						$data = "../../_SQL/bdd_codex_data_$key.sql";
//						$query = create_query($archi,$user_codex);
//						$query .= create_query($data,$user_codex);
//						$query .= "INSERT INTO applications.rubrique (id_rubrique, id_module, pos, icone, titre, descr, niveau, link, lang) VALUES ($pos, '$key', $pos ,'saisie.png', '$val', '', 1, '../$key/index.php', 0);";				
//						$query .= "INSERT INTO applications.utilisateur_role VALUES ('ADMI1', '$key', false, true, true, true, true, true, true, true);";
//						$query .= "ALTER SCHEMA $key OWNER TO $user_codex";
//						$result = pg_query($conn_codex,$query);
//						echo ("L'architecture de la $val a été implémentée avec l'ancienne méthode<BR>"); 
//						}
					}
						
				else
					echo ("---<BR>");
				}
				else
					echo ("La rubrique $val ne peut être installée, le fichier d'installation archi.sql est manquant <BR>"); 
			$pos ++;
			}

			
		/*------------------------------------------*/
		/*parametrage du ficher de conf config_sql.inc.php*/
		if (!file_exists("../../_INCLUDE/config_sql.inc.php"))
			{
			$sql_file = file_get_contents("../../_INCLUDE/config_sql.inc.example.php");
			$sql_file = str_replace("(\"SQL_server\", \"\")","(\"SQL_server\", \"".$_POST["host"]."\")",$sql_file);
			$sql_file = str_replace("(\"SQL_port\", \"\")","(\"SQL_port\", \"".$_POST["port"]."\")",$sql_file);
			$sql_file = str_replace("(\"SQL_user\", \"\")","(\"SQL_user\", \"".$_POST["user_codex"]."\")",$sql_file);
			$sql_file = str_replace("(\"SQL_pass\", \"\")","(\"SQL_pass\", \"".$_POST["mdp_codex"]."\")",$sql_file);
			$sql_file = str_replace("(\"SQL_admin_user\", \"\")","(\"SQL_admin_user\", \"".$_POST["user"]."\")",$sql_file);
			$sql_file = str_replace("(\"SQL_admin_pass\", \"\")","(\"SQL_admin_pass\", \"".$_POST["mdp"]."\")",$sql_file);
			$sql_file = str_replace("(\"SQL_base\", \"\")","(\"SQL_base\", \"".$_POST["dbname"]."\")",$sql_file);
			
			/*Ajout à erme de la mise à jour des séquences lors de l'import de données avec UID*/
			/*SELECT setval('refnat.taxons_uid_seq', COALESCE((SELECT MAX(uid)+1 FROM refnat.taxons), 1), false);*/
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

case "desinstall":	{
	require_once ("../../_INCLUDE/config_sql.inc.php"); //récupération des variables de connexion à la base dans le fichier config_sql.inc.php		
	$host = SQL_server;$port = SQL_port;$user = SQL_admin_user;$mdp = SQL_admin_pass;$dbname = SQL_base; $user_codex = SQL_user;$mdp_codex = SQL_pass;
	$conn_pg = connexion ($host,$port,$user,$mdp,"postgres");
	$query = "DROP DATABASE $dbname;";
	$result = pg_query($conn_pg,$query);
	unlink("../../_INCLUDE/config_sql.inc.php");
	header("Location: install.php");
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
	$query = str_replace("user_codex",$user_codex,$query);
	return $query;
}	
?>
	