<?php
//------------------------------------------------------------------------------//
//  home/index.php                                                              //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  13/08/14 - MaJ schémas                                        //
//  Version 1.02  18/08/14 - MaJ login-form                                     //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
include ("commun.inc.php");
define ("DEBUG",false);

//------------------------------------------------------------------------------ PARMS.
$action=isset ($_POST['action']) ? $_POST['action'] : "";

if (!isset ($_COOKIE["lang_select"])) {                                          // FR par défaut
    setcookie ("lang_select", "fr", 0,"/"); 
    $lang_select="fr";
} 
else
    $lang_select=$_COOKIE['lang_select'];
 

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL ".SQL_server,false);

//------------------------------------------------------------------------------ VAR.
/*récupération des rubriques*/
$result=pg_query ($db,$query_rub) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
$i=0;
While ($row = pg_fetch_row($result)) {$rubrique[$i] = $row[0];$i++;}

foreach ($rubrique as $key => $val)
	{
	$ref[$val]=isset ($_SESSION['ref_'.$val]) ? $_SESSION['ref_'.$val] : 0;
	$niveau[$val]=isset ($_SESSION['niveau_'.$val]) ? $_SESSION['niveau_'.$val] : 0;
	}
$niveau['all']=isset ($_SESSION['niveau']) ? $_SESSION['niveau'] : 0;
$ref['all']=isset ($_SESSION['ref']) ? $_SESSION['ref'] : 0;

$id_user=$_SESSION['id_user'];

// $niveau=isset ($_SESSION['niveau']) ? $_SESSION['niveau'] : 0;
// $niveau_lr=isset ($_SESSION['niveau_lr']) ? $_SESSION['niveau_lr'] : 0;
// $niveau_eee=isset ($_SESSION['niveau_eee']) ? $_SESSION['niveau_eee'] : 0;
// $niveau_lsi=isset ($_SESSION['niveau_lsi']) ? $_SESSION['niveau_lsi'] : 0;
// $niveau_refnat=isset ($_SESSION['niveau_refnat']) ? $_SESSION['niveau_refnat'] : 0;
// $niveau_catnat=isset ($_SESSION['niveau_catnat']) ? $_SESSION['niveau_catnat'] : 0;
// $ref['all']=isset ($_SESSION['ref']) ? $_SESSION['ref'] : 0;
// $ref['lr']=isset ($_SESSION['ref_lr']) ? $_SESSION['ref_lr'] : 0;
// $ref['eee']=isset ($_SESSION['ref_eee']) ? $_SESSION['ref_eee'] : 0;
// $ref['lsi']=isset ($_SESSION['ref_lsi']) ? $_SESSION['ref_lsi'] : 0;
// $ref['refnat']=isset ($_SESSION['ref_refnat']) ? $_SESSION['ref_refnat'] : 0;
// $ref['catnat']=isset ($_SESSION['ref_catnat']) ? $_SESSION['ref_catnat'] : 0;




//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.validate.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.cookie.js"></script>

<script type="text/javascript" language="javascript" src="js/home.js"></script>

<?php
//------------------------------------------------------------------------------ MAIN
html_header ("utf-8","","");
echo ("<body>");
switch ($action)
{
    default :
    case "photo": {
        echo ("<div id=\"page\"><div id=\"page2\">");
        echo ("<div id=\"header\">");
//        echo ("<img src=\"../../_GRAPH/theme/header.png\" border=\"0\" >");
        echo ("</div>");
        echo ("</div>");
//        echo ("<img src=\"../../_GRAPH/theme/home2.png\" border=\"0\" >");
        echo ("<div lang=\"fr\">");
        echo ("<div class=\"narrowcolumn\">");
//        echo ("<img src=\"../../_GRAPH/theme/home4.png\" border=\"0\" align=right >");
  		echo ("<div class=\"post\">");
if (DEBUG) echo ("<br>Cookie = ".$lang_select." ");
if (DEBUG) echo ("<br>Niveau = ".$niveau['all']." ");
            if ($niveau['all'] == 0) {
				echo ("<h1 lang=\"fr\">".EVAL_NOM."</h1>");
				echo ("<div style=\"text-align: center;\" ><img src=\"../../_GRAPH/Dracocephalum_austriacum_L._cbna_JVE.jpg\" width=\"300\" height=\"453\" border=\"0\"></div>");
				aff_pres ("home","public_header",FR,false);
				}
			else
				aff_pres ("home","home_header",FR,false);
            echo ("<br/>");
			
		foreach ($rubrique as $key => $val)
			menu_rubrique ($niveau[$val],$val);
			
			// menu_rubrique ($niveau_refnat,"refnat");
			// menu_rubrique ($niveau_catnat,"catnat");
			// menu_rubrique ($niveau_lr,"lr");
			// menu_rubrique ($niveau_eee,"eee");
			// menu_rubrique ($niveau_lsi,"lsi");

			// echo ("<br/>");
            
			aff_pres ("home","home_footer",FR,false);
			
			if ($id_user == 'JEGE4' OR $id_user == 'ALDE2' OR $id_user == 'CYTA1' OR $id_user == 'DOGU9' OR $id_user == 'PASP1' OR $id_user == 'GIBA6' OR $id_user == 'THVE4' OR $id_user == 'OLGA' OR $id_user == 'ELHA9' OR $id_user == 'JELE6' OR $id_user == 'ANJU3' OR $id_user == 'THMI5')
				{
				echo ("<form method=\"POST\" id=\"form1\" name=\"loginform\" action=\"index.php\" >");
					echo ("<center><input type=\"hidden\" name=\"action\" value=\"maj_data\" />");
					echo ("<button id=\"maj_data_fr\">Import HUB Agregation</button></center>");
				echo ("</form>");
				}
				
			echo ("</div>");                                                    // post
            echo ("</div>");                                                    // narrowcolumn

			
            echo ("<div id=\"sidebar\">");
            echo ("<br><br>");
            if ($_SESSION['EVAL_FLORE'] != "ok") {
                echo ("<form method=\"POST\" id=\"form1\" name=\"loginform\" action=\"index.php\" >");
                echo ("<center><input type=\"hidden\" name=\"action\" value=\"valid\" />");
                echo ($lang['fr']['Utilisateur']."<br><input type=\"text\" name=\"user_login\" id=\"login\" size=\"20\" maxlength=\"100\" class=\"required\" /><br><br>");
                echo ($lang['fr']['pass']."<input type=\"password\" name=\"user_pw\" id=\"pw\" size=\"20\" maxlength=\"100\" class=\"required\" /><br><br>");
                echo ("<button id=\"valider_fr\">Login</button></center>");
                echo ("</form>");
				echo ("<center><br>Contacts :<br>");
				echo ("<br>");
				echo ("<b>Fédération des Conservatoires botaniques nationaux</b><br><br>");
				echo ("<a href=\"http://www.fcbn.fr/\" target=\"_blank\">www.fcbn.fr</a><br>");
				echo ("<br>");
					echo ("<form method=\"POST\" id=\"mail1\" name=\"mail\" action=\"#\" >");
					echo ("<input type=\"hidden\" name=\"action\" id=\"action\" value=\"mdp\" />");
					// echo ("<input type=\"submit\" value=\"récuperer mon mot de passe\" />");
					echo ("<button id=\"envoi-mdp\" style = \"font-size:10px;\">récuperer mon mot de passe</button></center>");
					echo ("</form>");
				echo ("</center>");
				echo ("<br>");            
			}  else {                                                           // Session OK
    			echo ("<center>");
                if ($nom != "") echo ("<b>".$prenom." ".$nom."</b><br>");
    			echo ("<br>".$lang['fr']['login']."</center>");
                echo ("<br><center><a href=\"logout.php\" ><img src=\"../../_GRAPH/".ICONES_SET."/logout.png\" border=\"0\" /><br>".$lang['fr']['logout']."</a></center>");
            }
            echo ("<br><center>");
//            echo ("<img src=\"../../_GRAPH/theme/home3.png\" width=20 height=600 border=\"0\" align=left >");

			if ($niveau['all'] >=1)  {
                echo ("<br><a href=\"../module_admin/index.php\" ><img src=\"../../_GRAPH/".ICONES_SET."/admin.png\" border=\"0\" /><br>".$lang['fr']['Admin']."</a></p>");
            }
            if ($niveau['all'] >=1)  {
                echo ("<br><a href=\"../bugs/index.php\" ><img src=\"../../_GRAPH/".ICONES_SET."/bugs.png\" border=\"0\" /><br>".$lang['fr']['bugs']."</a></p>");
				echo ("<br>");
			}
			
            echo ("</div>");                                                    // sidebar
            // echo ("<div class=\"whidecolumn\">");
            echo ("</form>");
            // echo ("</div>");                                                    // whidecolumn
        echo ("</div>");
     
        if ($action == "photo") {
            add_log ("log",1,"",getenv("REMOTE_ADDR"),"Photothèque","","");
            echo ("<script language=\"javascript\" type=\"text/javascript\">");
            echo ("window.open ( \"../../phototheque/index.php\")");
            echo ("</script>");
        }
    }
    break;
    case "valid": {
        $user_login=$_POST['user_login'];
        $user_pw=$_POST['user_pw'];
        if (!empty ($user_login) && !empty ($user_pw)) {
            foreach ($rubrique as $key => $val) 
				{
				$sql_niveau .= 'niveau_'.$val.',';
				$sql_ref .= 'ref_'.$val.',';
				}
			$query="SELECT $sql_niveau $sql_ref id_user
			FROM applications.utilisateur 
			WHERE login=".sql_format ($user_login)." AND pw=".sql_format ($user_pw).";";
            $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
            if (pg_num_rows ($result)) {
                $_SESSION['EVAL_FLORE']="ok";
                /*niveau de droit*/
				 foreach ($rubrique as $key => $val) 
					$_SESSION['niveau_'.$val]=pg_result ($result,0,"niveau_".$val);
				// $_SESSION['niveau_lr']=pg_result ($result,0,"niveau_lr");
                // $_SESSION['niveau_eee']=pg_result ($result,0,"niveau_eee");
                // $_SESSION['niveau_lsi']=pg_result ($result,0,"niveau_lsi");
                // $_SESSION['niveau_catnat']=pg_result ($result,0,"niveau_catnat");
                // $_SESSION['niveau_refnat']=pg_result ($result,0,"niveau_refnat");
				$_SESSION['niveau'] = max($_SESSION['niveau_lr'],$_SESSION['niveau_eee'],$_SESSION['niveau_lsi'],$_SESSION['niveau_catnat'],$_SESSION['niveau_refnat']);
				/*niveau référents*/
				foreach ($rubrique as $key => $val) 
					$_SESSION['ref_'.$val]=pg_result ($result,0,"ref_".$val);
				// $_SESSION['ref_lr']=pg_result ($result,0,"ref_lr");
                // $_SESSION['ref_eee']=pg_result ($result,0,"ref_eee");
                // $_SESSION['ref_lsi']=pg_result ($result,0,"ref_lsi");
                // $_SESSION['ref_catnat']=pg_result ($result,0,"ref_catnat");
                // $_SESSION['ref_refnat']=pg_result ($result,0,"ref_refnat");
				if (($_SESSION['ref_lr'] == 't') OR ($_SESSION['ref_eee'] == 't') OR ($_SESSION['ref_lsi'] == 't') OR ($_SESSION['ref_catnat'] == 't') OR ($_SESSION['ref_refnat'] == 't')) $_SESSION['ref']= 't'; else $_SESSION['ref']= 'f';
			   /*id user*/
				$_SESSION['id_user']=pg_result ($result,0,"id_user");
				add_log ("log",3,pg_result($result,0,"id_user"),getenv("REMOTE_ADDR"),"Login",$user_login,"");
                die ("<meta HTTP-equiv=\"refresh\" content=0;url=index.php />");
            } else {
                echo ("<div id=\"page\"><div id=\"page2\">");
                echo ("<div id=\"header\">");
//                echo ("<img src=\"../../_GRAPH/theme/header_atlas_11.jpg\" border=\"0\" >");
                echo ("</div>");
                echo ("</div>");
//                echo ("<img src=\"../../_GRAPH/theme/home2.png\" border=\"0\" >");
                echo ("<div lang=\"fr\">");
//                echo ("<div class=\"narrowcolumn\">");
          		echo ("<div class=\"post\">");
                echo ("<br><br><br>");
				echo ("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0 .7em;\">"); 
					echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: .3em;\"></span>"); 
					echo ("<strong>ERREUR:</strong> Utilisateur inconnu ou mot de passe invalide.</p>");
				echo ("</div>");
                echo ("<br><br><br>");
                echo ("<center><a href=\"index.php\" ><img src=\"../../_GRAPH/".ICONES_SET."/retour.png\" border=\"0\" /><br>Retour</a></center><br><br>");
                echo ("</div>");                                                // whidecolumn
                add_log ("log",3,$user_login,getenv("REMOTE_ADDR"),"Erreur de login",$user_login,"");
            //echo ("</div>");                                                    // post
            echo ("</div>");                                                    // narrowcolumn
            }
        } else {
            echo ("<div id=\"page\"><div id=\"page2\">");
            echo ("<div id=\"header\">");
            echo ("<img src=\"../../_GRAPH/theme/header_atlas_11.jpg\" border=\"0\" >");
            echo ("</div>");
            echo ("</div>");
            echo ("<img src=\"../../_GRAPH/theme/home2.png\" border=\"0\" >");
            echo ("<div lang=\"fr\">");
            echo ("<div class=\"narrowcolumn\">");
      		echo ("<div class=\"post\">");
            echo ("<br><br><br>");
			echo ("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0 .7em;\">"); 
				echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: .3em;\"></span>"); 
				echo ("<strong>ERREUR:</strong> Utilisateur inconnu ou mot de passe invalide.</p>");
			echo ("</div>");
            echo ("<br><br><br>");
            echo ("<center><a href=\"index.php\" ><img src=\"../../_GRAPH/".ICONES_SET."/retour.png\" border=\"0\" /><br>Retour</a></center><br><br>");
            echo ("</div>");                                                        // whidecolumn
            add_log ("log",3,$id_user,getenv("REMOTE_ADDR"),"Erreur de login",$user_login,"");
            echo ("</div>");                                                    // post
            echo ("</div>");                                                    // narrowcolumn
        }
	}
    break;
    case "notice" :
    case "contact" : {
        aff_titre ();
        echo ("<div id=\"page_main\">");
        echo ("<div class=\"whidecolumn\">");
        echo ("<div lang=\"fr\">");
            aff_page ($action,FR);
            echo ("<center><a href=\"index.php\" ><img src=\"../../_GRAPH/".ICONES_SET."/retour.png\" border=\"0\" /><br>".$lang['fr']['retour']."</a></center><br><br>");
        echo ("</div>");                                                        // whidecolumn
        echo ("<div lang=\"it\">");
            aff_page ($action,IT);
            echo ("<center><a href=\"index.php\" ><img src=\"../../_GRAPH/".ICONES_SET."/retour.png\" border=\"0\" /><br>".$lang['it']['retour']."</a></center><br><br>");
        echo ("</div>");                                                        // whidecolumn
        echo ("</div>");                                                        // whidecolumn
	}
	 break;
	 
    case "mdp" : {
	echo ("<div id=\"page\">");
        echo ("<div lang=\"fr\">");
        echo ("<div class=\"narrowcolumn\">");
			echo ("<h1 lang=\"fr\">".EVAL_NOM."</h1>");
				echo ("<form method=\"POST\" id=\"mail1\" name=\"mail\" action=\"#\" >");
				echo ("<input type=\"hidden\" name=\"action\" id=\"action\" value=\"mdp-ok\" />");
				echo ("<input type=\"text\" name=\"mail\" id=\"mail\" size = \"40\" value=\"\" />");
				// echo ("<input type=\"submit\" value=\"récuperer mon mot de passe\" />");
				echo ("<BR>");
				echo ("<button id=\"envoi-mdp\" >Renvoyer les mot de passe</button></center>");
				echo ("</form>");

				// echo("<a class=admin-user-mdp id=\"\" name=\"\"><img src=\"../../_GRAPH/mini/email1.png\" title=\"Envoyer\" ></a>");            
				echo ("</div>");                                                    // post
            echo ("</div>");                                                    // narrowcolumn
		echo ("<div class=\"whidecolumn\">");
		echo ("</div>");
   echo ("</div>");
   }
	break;
	
    case "mdp-ok" : {
	echo ("<div id=\"page\">");
        echo ("<div lang=\"fr\">");
        echo ("<div class=\"narrowcolumn\">");
			echo ("<h1 lang=\"fr\">".EVAL_NOM."</h1>");
	
			$sujet = "[FCBN] Accès à la plateforme CODEX";
			$mail = $_POST['mail'];
			if (!empty ($mail)) 
				{
				$query = "SELECT a.id_user, lib_cbn, nom, prenom, login, pw, tel_bur, tel_port, email, web, descr, aze.lr,qsd.eee,wxc.refnat,zer.catnat,sdf.lsi, ref_lr, ref_eee, ref_lsi, ref_catnat, ref_refnat
					FROM applications.utilisateur a
					JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn
					JOIN (SELECT id_user, lib as lr FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lr = cd) as aze ON aze.id_user = a.id_user
					JOIN (SELECT id_user, lib as eee FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_eee = cd) as qsd ON qsd.id_user = a.id_user
					JOIN (SELECT id_user, lib as refnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_refnat = cd) as wxc ON wxc.id_user = a.id_user
					JOIN (SELECT id_user, lib as catnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_catnat = cd) as zer ON zer.id_user = a.id_user
					JOIN (SELECT id_user, lib as lsi FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lsi = cd) as sdf ON sdf.id_user = a.id_user
					WHERE a.email = '$mail';
					";
				
				$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
				$row = pg_fetch_array($result);
				if (count($row['id_user']) == 1)
					{
					$message_html = msg_pw($row);	
					envoi_mail($row['email'], $sujet, $message_html, "");
					echo ("Un mail vous a été envoyé à cette adresse avec vos identifiants");
					echo ("<form method=\"POST\" id=\"mail1\" name=\"mail\" action=\"#\" >");
					echo ("<button id=\"accueil\" >Retour à l'accueil</button></center>");
					echo ("</form>");
					}
				else
					{
					echo ("Adresse mail erronée");
					echo ("<form method=\"POST\" id=\"mail1\" name=\"mail\" action=\"#\" >");
					echo ("<input type=\"hidden\" name=\"action\" id=\"action\" value=\"mdp-ok\" />");
					echo ("<input type=\"text\" name=\"mail\" id=\"mail\" size = \"40\" value=\"\" />");
					// echo ("<input type=\"submit\" value=\"récuperer mon mot de passe\" />");
					echo ("<BR>");
					echo ("<button id=\"envoi-mdp\" >Renvoyer les mot de passe</button></center>");
					echo ("</form>");
					}
				}
			else
				{
				echo ("Veuillez rentrer une adresse mail");
				echo ("<form method=\"POST\" id=\"mail1\" name=\"mail\" action=\"#\" >");
				echo ("<input type=\"hidden\" name=\"action\" id=\"action\" value=\"mdp-ok\" />");
				echo ("<input type=\"text\" name=\"mail\" id=\"mail\" size = \"40\" value=\"\" />");
				// echo ("<input type=\"submit\" value=\"récuperer mon mot de passe\" />");
				echo ("<BR>");
				echo ("<button id=\"envoi-mdp\" >Renvoyer les mot de passe</button></center>");
				echo ("</form>");
				}

				echo ("</div>");                                                    // post
            echo ("</div>");                                                    // narrowcolumn
		echo ("<div class=\"whidecolumn\">");
		echo ("</div>");
   echo ("</div>");
   }
	break;

   case "maj_data" : {
	echo ("<div id=\"page\">");
        echo ("<div lang=\"fr\">");
        echo ("<div class=\"narrowcolumn\">");
			echo ("<h1 lang=\"fr\">".EVAL_NOM."</h1>");
			if ($id_user == 'JEGE4' OR $id_user == 'ALDE2' OR $id_user == 'CYTA1' OR $id_user == 'DOGU9' OR $id_user == 'PASP1' OR $id_user == 'GIBA6' OR $id_user == 'THVE4' OR $id_user == 'OLGA' OR $id_user == 'ELHA9' OR $id_user == 'JELE6' OR $id_user == 'ANJU3' OR $id_user == 'THMI5')
				{
				echo ("<form method=\"POST\" id=\"mail1\" name=\"mail\" action=\"#\" >");
				echo ("<input type=\"hidden\" name=\"action\" id=\"action\" value=\"maj_data-ok\" />");
				echo ("<input type=\"text\" name=\"cbn\" id=\"cbn\" size = \"40\" value=\"XXX\" />exemple : ALP");
				echo ("<BR>");
				echo ("<button id=\"envoi_maj\" >Lancer l'import</button></center>");
				echo ("</form>");
				}
				echo ("</div>");                                                    // post
            echo ("</div>");                                                    // narrowcolumn
		echo ("<div class=\"whidecolumn\">");
		echo ("</div>");
   echo ("</div>");
   }
	break;	
	
	 case "maj_data-ok" : {
	 	echo ("<div id=\"page\">");
        echo ("<div lang=\"fr\">");
        echo ("<div class=\"narrowcolumn\">");
			echo ("<h1 lang=\"fr\">".EVAL_NOM."</h1>");
			if ($id_user == 'JEGE4' OR $id_user == 'ALDE2' OR $id_user == 'CYTA1' OR $id_user == 'DOGU9' OR $id_user == 'PASP1' OR $id_user == 'GIBA6' OR $id_user == 'THVE4' OR $id_user == 'OLGA' OR $id_user == 'ELHA9' OR $id_user == 'JELE6' OR $id_user == 'ANJU3' OR $id_user == 'THMI5')
				{
				// echo ("<form method=\"POST\" id=\"mail1\" name=\"mail\" action=\"#\" >");
				// echo ("<input type=\"hidden\" name=\"action\" id=\"action\" value=\"maj_data-ok\" />");
				/*connexion en admin*/
				$db2=sql_connect_hub(SQL_base_hub);
				/*requete*/
				$query = "SELECT * FROM import_temp_hub('CBN_".$_POST['cbn']."','/home/hub/".$_POST['cbn']."/import/');";
				$result=pg_query ($db2,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
				echo ("Import réalisé");
				echo ("<button id=\"envoi_maj\" >retour</button></center>");
				echo ("</form>");
				}		
				echo ("</div>");                                                    // post
            echo ("</div>");                                                    // narrowcolumn
		echo ("<div class=\"whidecolumn\">");
		echo ("</div>");
   echo ("</div>");
	}
	break;	
}
echo ("<table width=\"100%\"><tr>");
echo ("<td align=center><img src=\"../../_GRAPH/logos/logo_FCBN.gif\" border=\"0\" /></td>");
echo ("</tr></table><br>");
footer ();
echo ("</div>");                                                                // page
echo ("</body></html>");
pg_close ($db);

//------------------------------------------------------------------------------ FONCTIONS

?>
