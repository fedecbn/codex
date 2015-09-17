<?php
//------------------------------------------------------------------------------//
//  module_admin/index.php                                                      //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  13/08/14 - MaJ schémas                                        //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
include("commun.inc.php");
if ($_SESSION['EVAL_FLORE'] != "ok") require ("../commun/access_denied.php");

//------------------------------------------------------------------------------ VAR.
// $niveau=$_SESSION['niveau'];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];
$lang_select=$_COOKIE['lang_select'];
$mode = isset($_GET['m']) ? $_GET['m'] : "general";

//----------------------------------------------------------------------------- PARMS.
if (isset($_GET['action']) & !empty($_GET['action']))
   $action=$_GET['action'];
elseif (isset($_POST['action']) & !empty($_POST['action']))
   $action=$_POST['action'];    

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
$mois_txt=array("","Jan","Fév","Mar","Avr","Mai","Jun","Jui","Aou","Sep","Oct","Nov","Déc");
$log_event_txt=array("(Tous)","Information","Erreur","Sécurité","Système");

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-ui.custom.min.js"></script>

<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.dataTables.columnFilter.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.form.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.validate.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-te-1.4.0.min.js"></script>

<script type="text/javascript" language="javascript" src="js/admin.js"></script>

<?php
//------------------------------------------------------------------------------ MAIN
html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");
echo ("<body>");
echo ("<div id=\"page_consult\" class=\"page_consult\">");

//------------------------------------------------------------------------------ Boutons
echo ("<div id=\"header2\">");
    echo ("<div style=\"float:left;\">");
    echo ("<button id=\"home-button\">".$lang[$lang_select]['Retour_menu']."</button>");
    echo ("</div>");
    echo ("<font size=5>".$lang[$lang_select]['Admin']."</font>");
echo ("</div>");

echo ("<div id=\"tabs\" style=\"min-height:800px;\">");
echo ("<ul>");
if ($niveau['all'] >= 255) 	{ echo ("<li><a href=\"#text\">".$lang[$lang_select]['text']."</a></li>");}
if ($niveau['all'] >= 1) 	{ echo ("<li><a href=\"#user\">".$lang[$lang_select]['user']."</a></li>");}
if ($niveau['all'] >= 128) 	{ echo ("<li><a href=\"#suivi\">".$lang[$lang_select]['suivi']."</a></li>");}
if ($niveau['all'] >= 255) 	{ echo ("<li><a href=\"#log\">".$lang[$lang_select]['log']."</a></li>");  }
echo ("</ul>");
echo ("<input type=\"hidden\" id=\"niveau\" value=\"".$niveau['all']."\" />");
echo ("<input type=\"hidden\" id=\"mode\" value=\"".$mode."\" />");

switch ($mode) {
    case "general" : {

//------------------------------------------------------------------------------ #Text
echo ("<div id=\"text\">");
    if ($niveau['all'] >= 255) {
    $id_page="admin-text";
    echo ("<div id=\"titre2\">");
        echo ($lang[$lang_select]["titre_".$id_page]);
    echo ("</div>");
    echo ("<div id=\"".$id_page."-dialog\"></div>");
    aff_table ($id_page."-liste",true,false);
	}
echo ("</div>");
//------------------------------------------------------------------------------ #Stat
echo ("<div id=\"stat\">");
    if ($niveau['all'] >= 255) {
    } 
echo ("</div>");
//------------------------------------------------------------------------------ #Utilisateur
echo ("<div id=\"user\">");
    if ($niveau['all'] >= 1) {
        $id_page="admin-user";
        echo ("<div id=\"titre2\">");
            echo ($lang[$lang_select]["titre_".$id_page]);
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
		if ($ref['all'] === 't' OR $niveau['all'] > 255) echo ("<button name = \"$id_user\" id=\"".$id_page."-add-button\">".$lang[$lang_select]['ajouter']."</button> ");
        if ($niveau['all'] >= 512) echo ("<button id=\"mdp-button\">".$lang[$lang_select]['mdp']."</button> ");
		echo ("</div>");
        echo ("<div id=\"".$id_page."-dialog\"></div>");
        aff_table ($id_page."-liste",true,false);
    } 
echo ("</div>");
//------------------------------------------------------------------------------ #Suivi des modifications
echo ("<div id=\"suivi\">");
    if ($niveau['all'] >= 128) {
        $id_page="admin-suivi";
        echo ("<div id=\"titre2\">");
            echo ($lang[$lang_select]["titre_".$id_page]);
        echo ("</div>");
        echo ("<input type=\"hidden\" id=\"".$id_page."-export-TXT-fichier\" value=\"Suivi_modifications_".$id_user.".txt\" />");
        echo ("<input type=\"hidden\" id=\"".$id_page."-export-TXT-titre\" value=\"Suivi des modificatuions\" />");
        echo ("<input type=\"hidden\" id=\"".$id_page."-export-TXT-query-id\" value=\"id_suivi\" />");
        echo ("<input type=\"hidden\" id=\"".$id_page."-export-TXT-query\" value=\"SELECT s.etape,u.nom,u.prenom,c.lib_cbn as CBN,lt.cd_ref as CDREF,lt.nom_scien as taxon,ch.rubrique_champ as Rubrique,s.type_modif as Modification,s.methode as Methode,ch.description as Description, s.libelle_1 as Valeur_1,s.libelle_2 as Valeur_2, extract(day from s.datetime)||'/'||extract(year from s.datetime)||'/'||extract(day from s.datetime) as date, extract(hour from s.datetime)||':'||extract(minute from s.datetime) as heure 
		 FROM ".SQL_schema_app.".suivi AS s 
		 LEFT JOIN ".SQL_schema_app.".utilisateur AS u ON u.id_user=s.id_user 
		 LEFT JOIN ".SQL_schema_ref.".cbn AS c ON c.id_cbn=u.id_cbn 
		 LEFT JOIN ".SQL_schema_ref.".champs AS ch ON s.champ=ch.champ_interface AND s.tables = ch.table_champ AND s.rubrique=ch.rubrique_champ
		 LEFT JOIN ".SQL_schema_app.".liste_taxon AS lt ON lt.uid=s.uid AND lt.rubrique_taxon=ch.rubrique_champ WHERE \" />");
        echo ("<div style=\"float:right;\">");
            echo ("<button id=\"".$id_page."-export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
        echo ("</div><br><br>");
        echo ("<div id=\"".$id_page."-dialog\"></div>");
        aff_table ($id_page."-liste",false,true);
    } 
echo ("</div>");
//------------------------------------------------------------------------------ #Log
echo ("<div id=\"log\">");
    if ($niveau['all'] >= 255) {
        $id_page="admin-log";
        echo ("<div id=\"titre2\">");
            echo ($lang[$lang_select]["titre_".$id_page]);
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            echo ("<button id=\"".$id_page."-del-button\">".$lang[$lang_select]['del']."</button> ");
        echo ("</div>");
        echo ("<div id=\"".$id_page."-dialog\"></div>");
        aff_table ($id_page."-liste",true,false);
    } 
echo ("</div>");
	}
	break;
//------------------------------------------------------------------------------ #Envoi des mots de passes (Super Admin)
	 case "mdp" : {
	
	$query = "SELECT a.id_user, lib_cbn, nom, prenom, login, pw, tel_bur, tel_port, email, web, descr, aze.lr,qsd.eee,wxc.refnat,zer.catnat,sdf.lsi
	    FROM applications.utilisateur a
		JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn
		JOIN (SELECT id_user, lib as lr FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lr = cd) as aze ON aze.id_user = a.id_user
		JOIN (SELECT id_user, lib as eee FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_eee = cd) as qsd ON qsd.id_user = a.id_user
		JOIN (SELECT id_user, lib as refnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_refnat = cd) as wxc ON wxc.id_user = a.id_user
		JOIN (SELECT id_user, lib as catnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_catnat = cd) as zer ON zer.id_user = a.id_user
		JOIN (SELECT id_user, lib as lsi FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lsi = cd) as sdf ON sdf.id_user = a.id_user
		;
		";
	 
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	
	$sujet = "[FCBN] Accès à la plateforme CODEX";
	while ($row = pg_fetch_array($result))
		{
		$row['nom'] = $row['nom'] == null? $row['nom']= "<i>--vide--</i>":$row['nom'];
		$row['prenom'] = $row['prenom'] == null? $row['prenom']= "<i>--vide--</i>":$row['prenom'];
		$row['lib_cbn'] = $row['lib_cbn'] == null? $row['lib_cbn']= "<i>--vide--</i>":$row['lib_cbn'];
		$row['tel_bur'] = $row['tel_bur'] == null? $row['tel_bur']= "<i>--vide--</i>":$row['tel_bur'];
		$row['tel_port'] = $row['tel_port'] == null? $row['tel_port']= "<i>--vide--</i>":$row['tel_port'];
		$row['descr'] = $row['descr'] == null? $row['descr']= "<i>--vide--</i>":$row['descr'];
		$row['email'] = $row['email'] == null? $row['email']= "<i>--vide--</i>":$row['email'];
		$row['refnat'] = $row['refnat'] == null? $row['refnat']= "<i>--vide--</i>":$row['refnat'];
		$row['catnat'] = $row['catnat'] == null? $row['catnat']= "<i>--vide--</i>":$row['catnat'];
		$row['lr'] = $row['lr'] == null? $row['lr']= "<i>--vide--</i>":$row['lr'];
		$row['eee'] = $row['eee'] == null? $row['eee']= "<i>--vide--</i>":$row['eee'];
		$row['lsi'] = $row['lsi'] == null? $row['lsi']= "<i>--vide--</i>":$row['lsi'];
		
		$message_html = "<html><head></head><body>
			---CECI EST UN MAIL AUTOMATIQUE---
		<br>----MERCI DE NE PAS Y REPONDRE----
			<br><br>Bonjour,
			<br><br> Vous trouverez ci-joint vos identifiants personnalisés de connexion pour accéder à l'outil Codex, ainsi que la description des informations de votre profil.
			<br> Pour accéder directement à l'outil, veuillez suivre ce lien : <a href=\"codex.fcbn.fr\">codex.fcbn.fr</a>
			<br> Retrouvez également la liste des outils de la FCBN à l'adresse suivante : <a href=\"services.fcbn.fr\">services.fcbn.fr</a>
			<br> Si vous notez une erreur dans vos informations personnelles, merci d'envoyer un mail à <a href=\"mailto:informatique@fcbn.fr\">informatique@fcbn.fr</a> à ce sujet.
			
			<br><br>Retrouvez la note d’information qui présente l'outil au lien suivant : <a href = \"".str_replace("www.","",$_SERVER["SERVER_NAME"])."/flore/home/150915_Note_ouverture_Codex.pdf\">".str_replace("www.","",$_SERVER["SERVER_NAME"])."/flore/home/150915_Note_ouverture_Codex.pdf</a>
			
			<br><br><b>Identifiants de connexion</b>
			<table cellpadding=\"5\" border =\"solid 1px black\">
			<tr><td> Login </td><td>".$row['login']."</td></tr>
			<tr><td> MdP </td><td>".$row['pw']."</td></tr>
			</table>
			
			<br><br> <b>Informations professionnelles</b>
			<table cellpadding=\"5\" border =\"solid 1px black\">
			<tr><td> Nom </td><td>".$row['nom']."</td></tr>
			<tr><td> Prénom </td><td>".$row['prenom']."</td></tr>
			<tr><td> CBN </td><td>".$row['lib_cbn']."</td></tr>
			<tr><td> Tel bureau </td><td>".$row['tel_bur']."</td></tr>
			<tr><td> Tel portable </td><td>".$row['tel_port']."</td></tr>
			<tr><td> Email </td><td>".$row['email']."</td></tr>
			<tr><td> Description </td><td>".$row['descr']."</td></tr>
			</table>
			
			<br><br> <b> Droit d'accès</b>
			<table cellpadding=\"5\" border =\"solid 1px black\">
			<tr><td> Rôle pour la rubrique \"Référentiel national\" </td><td>".$row['refnat']."</td></tr>
			<tr><td> Rôle pour la rubrique \"Catalogue national\" </td><td>".$row['catnat']."</td></tr>
			<tr><td> Rôle pour la rubrique \"Liste rouge\" </td><td>".$row['lr']."</td></tr>
			<tr><td> Rôle pour la rubrique \"Liste EEE\" </td><td>".$row['eee']."</td></tr>
			<tr><td> Rôle pour la rubrique \"Lettre Système d'information et géomatique\" </td><td>".$row['lsi']."</td></tr>
			</table>
			<br><br> Cordialement,
			<br><br> Thomas Milon
			
			</body></html>";
		
		// echo $message_html;
		envoi_mail($row['email'], $sujet, $message_html, "");
		}
	 }
	 break;
}
echo ("</div>");
//------------------------------------------------------------------------------
echo ("</div>");
echo ("</div>");

echo ("<br /></div>");
echo ("<div></body></html>");
pg_close ($db);

//------------------------------------------------------------------------------ FONCTIONS

?>