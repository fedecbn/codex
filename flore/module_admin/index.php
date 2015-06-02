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
$niveau=$_SESSION['niveau'];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];
$lang_select=$_COOKIE['lang_select'];

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
if ($niveau == 255) { echo ("<li><a href=\"#text\">".$lang[$lang_select]['text']."</a></li>");}
if ($niveau == 255) { echo ("<li><a href=\"#user\">".$lang[$lang_select]['user']."</a></li>");}     // SU
if ($niveau >= 128) { echo ("<li><a href=\"#suivi\">".$lang[$lang_select]['suivi']."</a></li>");}
if ($niveau == 255) { echo ("<li><a href=\"#log\">".$lang[$lang_select]['log']."</a></li>");  }      // SU
echo ("</ul>");
echo ("<input type=\"hidden\" id=\"niveau\" value=\"".$niveau."\" />");

//------------------------------------------------------------------------------ #Text
echo ("<div id=\"text\">");
    if ($niveau == 255) {
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
    if ($niveau == 255) {
    } 
echo ("</div>");
//------------------------------------------------------------------------------ #Utilisateur
echo ("<div id=\"user\">");
    if ($niveau == 255) {
        $id_page="admin-user";
        echo ("<div id=\"titre2\">");
            echo ($lang[$lang_select]["titre_".$id_page]);
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
        echo ("<button id=\"".$id_page."-add-button\">".$lang[$lang_select]['ajouter']."</button> ");
        echo ("</div>");
        echo ("<div id=\"".$id_page."-dialog\"></div>");
        aff_table ($id_page."-liste",true,false);
    } 
echo ("</div>");
//------------------------------------------------------------------------------ #Suivi des modifications
echo ("<div id=\"suivi\">");
    if ($niveau >= 128) {
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
    if ($niveau == 255) {
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

echo ("</div>");
//------------------------------------------------------------------------------
echo ("</div>");
echo ("</div>");

echo ("<br /></div>");
echo ("<div></body></html>");
pg_close ($db);

//------------------------------------------------------------------------------ FONCTIONS

?>
