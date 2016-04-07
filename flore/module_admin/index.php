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

//------------------------------------------------------------------------------ VAR.
// $niveau=$_SESSION['niveau'];
$id_user=$_SESSION['id_user'];
$id=$_SESSION['id'];
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
	echo ("<div style=\"float:right;\">");
		echo ("<button name = \"$id_user\" id=\"".$id_page."-add-button\">".$lang[$lang_select]['ajouter']."</button> ");
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
        if ($niveau['all'] >= 255) echo ("<button id=\"mdp-button\">Envoi mot de passe</button> ");
        if ($niveau['all'] >= 255) echo ("<button id=\"msg-button\">Envoi message</button> ");
		echo ("</div>");
        echo ("<div id=\"".$id_page."-dialog\"></div>");
        aff_table ($id_page."-liste",true,true);
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

	$sujet = "[FCBN] Accès à la plateforme CODEX";
	$select = $_GET['select'];
	
	if (!empty ($select) AND strpos($select,'&') == null) 
	{
	$query = "SELECT a.id_user, lib_cbn, nom, prenom, login, pw, tel_bur, tel_port, email, web, descr, aze.lr,qsd.eee,wxc.refnat,zer.catnat,sdf.lsi,xcv.fsd,ref_lr, ref_eee, ref_lsi, ref_catnat, ref_refnat,ref_fsd
	    FROM applications.utilisateur a
		JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn
		JOIN (SELECT id_user, lib as lr FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lr = cd) as aze ON aze.id_user = a.id_user
		JOIN (SELECT id_user, lib as eee FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_eee = cd) as qsd ON qsd.id_user = a.id_user
		JOIN (SELECT id_user, lib as refnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_refnat = cd) as wxc ON wxc.id_user = a.id_user
		JOIN (SELECT id_user, lib as catnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_catnat = cd) as zer ON zer.id_user = a.id_user
		JOIN (SELECT id_user, lib as lsi FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lsi = cd) as sdf ON sdf.id_user = a.id_user
		JOIN (SELECT id_user, lib as fsd FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_fsd = cd) as xcv ON xcv.id_user = a.id_user
		WHERE a.id_user = '$select';
		";
		
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	$row = pg_fetch_array($result);
	$message_html = msg_pw($row);	
	envoi_mail($row['email'], $sujet, $message_html, "");
	
	} elseif (strlen($select) > 0) {
		$pairs=explode ("&",$select);
		foreach ($pairs as $key=>$value){
			$id = ltrim ($value,"id=");
			$where .= "a.id_user='".$id."' OR ";
			}
		$where=rtrim ($where,"OR ");

		$query = "SELECT a.id_user, lib_cbn, nom, prenom, login, pw, tel_bur, tel_port, email, web, descr, aze.lr,qsd.eee,wxc.refnat,zer.catnat,sdf.lsi,xcv.fsd,ref_lr, ref_eee, ref_lsi, ref_catnat, ref_refnat,ref_fsd
			FROM applications.utilisateur a
			JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn
			JOIN (SELECT id_user, lib as lr FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lr = cd) as aze ON aze.id_user = a.id_user
			JOIN (SELECT id_user, lib as eee FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_eee = cd) as qsd ON qsd.id_user = a.id_user
			JOIN (SELECT id_user, lib as refnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_refnat = cd) as wxc ON wxc.id_user = a.id_user
			JOIN (SELECT id_user, lib as catnat FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_catnat = cd) as zer ON zer.id_user = a.id_user
			JOIN (SELECT id_user, lib as lsi FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_lsi = cd) as sdf ON sdf.id_user = a.id_user
			JOIN (SELECT id_user, lib as fsd FROM applications.utilisateur a JOIN referentiels.user_ref z ON niveau_fsd = cd) as xcv ON xcv.id_user = a.id_user
			WHERE $where;
			";
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
		
		while ($row = pg_fetch_array($result))
			{
			$message_html = msg_pw($row);
			envoi_mail($row['email'], $sujet, $message_html, "");
			}
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