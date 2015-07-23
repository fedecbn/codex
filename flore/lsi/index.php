<?php
//------------------------------------------------------------------------------//
//  module_gestion/index.php                                                    //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  13/08/14 - MaJ schémas                                        //
//  Version 1.03  21/08/14 - MaJ droits                                         //
//  Version 1.10  01/09/14 - MaJ form v2                                        //
//  Version 1.11  10/09/14 - MaJ form labels                                    //
//------------------------------------------------------------------------------//
//------------------------------------------------------------------------------ INIT.
session_start ();
include ("commun.inc.php");
if ($_SESSION['EVAL_FLORE'] != "ok") require ("../commun/access_denied.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau_lsi'];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];
$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ PARMS.
$mode = isset($_GET['m']) ? $_GET['m'] : "liste";
if (isset($_GET['o']) & !empty($_GET['o'])) $o=$_GET['o'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
$ouinon_txt=array("Non","Oui");
$id_page="lsi";

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-ui.custom.min.js"></script>

<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.dataTables.columnFilter.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.form.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.validate.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-te-1.4.0.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/icheck.min.js"></script>

<script type="text/javascript" language="javascript" src="js/gestion.js"></script>
<script type="text/javascript" language="javascript" src="js/liste.js"></script>

<?php
//------------------------------------------------------------------------------ MAIN
html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");
//html_header ("utf-8","","");
echo ("<body>");
echo ("<div id=\"page_consult\" class=\"page_consult\">");

//------------------------------------------------------------------------------ Titre
echo ("<div id=\"header2\">");
    echo ("<div style=\"float:left;\">");
    echo ("<button id=\"home-button\">".$lang[$lang_select]['Retour_menu']."</button>");
    echo ("</div>");
    echo ("<font size=5>".$lang[$lang_select]['titre']."</font>");
echo ("</div>");

echo ("<div id=\"tabs\" style=\" min-height:800px;\">");
echo ("<ul>");
echo ("<li><a href=\"#lsi\">".$lang[$lang_select]['lsi']."</a></li>");
// echo ("<li><a href=\"#evee\">".$lang[$lang_select]['evee']."</a></li>");
echo ("<li><a href=\"#fiche\">".$lang[$lang_select]['fiche']."</a></li>");
echo ("</ul>");

echo ("<input type=\"hidden\" id=\"mode\" value=\"".$mode."\" />");

switch ($mode) {
//------------------------------------------------------------------------------ #LR
    default:
	case "liste" : {
        echo ("<div id=\"$id_page\" >");
            echo ("<div id=\"titre2\">");
                echo ($lang[$lang_select]["liste_$id_page"]);
            echo ("</div>");
            echo ("<input type=\"hidden\" id=\"".$id_page."-export-TXT-fichier\" value=\"Liste_fiches_".$id_user.".txt\" />");
            echo ("<input type=\"hidden\" id=\"".$id_page."-export-TXT-query-id\" value=\"t.uid\" />");
            echo ("<input type=\"hidden\" id=\"".$id_page."-export-TXT-query\" value=\" SELECT id,libelle_subjet,title,abstract,libelle_tag,link,date
				FROM ".SQL_schema_lsi.".news AS n 
				LEFT JOIN ".SQL_schema_lsi.".coor_news_tag nt ON n.id=nt.id
				LEFT JOIN ".SQL_schema_lsi.".tag t ON nt.id_tag=t.id_tag  
				LEFT JOIN ".SQL_schema_lsi.".subject s ON n.id_subject=s.id_subject \" />");
            echo ("<div style=\"float:right;\">");
                if ($niveau >= 128) 
                    echo ("<button id=\"".$id_page."-add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
                echo ("<button id=\"".$id_page."-export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau >= 255) 
                    echo ("<button id=\"".$id_page."-del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"".$id_page."-dialog\"></div>");
            aff_table ($id_page."-liste",true,true);
        echo ("</div>");
//------------------------------------------------------------------------------ #fiche
        echo ("<div id=\"fiche_lsi\" >");
        echo ("</div>");
    }
    break;
//------------------------------------------------------------------------------ ADD
    case "add" : {
//------------------------------------------------------------------------------ REF.
        //$subject[0]="";
        $query="SELECT * FROM ".SQL_schema_lsi.".subject ORDER BY id_subject;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $subject[$row["id_subject"]]=$row["libelle_subject"];
        pg_free_result ($result);

        //$tag[0]="";
        $query="SELECT * FROM ".SQL_schema_lsi.".tag ORDER BY libelle_tag;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $tag[$row["id_tag"]]=$row["libelle_tag"];
        pg_free_result ($result);

//------------------------------------------------------------------------------ ADD
        echo ("<div id=\"liste\" >");
        echo ("</div>");
        echo ("<div id=\"fiche_lsi\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['add_lsi']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            echo ("<button id=\"enregistrer1-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
            echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_lsi']."</button> ");
        echo ("</div><br><br>");

//------------------------------------------------------------------------------ GRP 1
         echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_lsi_1']."</LEGEND>");
                echo ("<label class=\"preField\">Titre</label><input type=\"text\" name=\"title\" id=\"title\" size=\"70\" />  ");
                echo ("<label class=\"preField\">Date</label><input type=\"text\" name=\"date\" id=\"date\" size=\"20\" value=\"".date("Y-m-d")."\" />  ");
                metaform_sel ("Sujet","","",$subject,"id_subject","");
				echo ("<br><br>");
                echo ("<label class=\"preField\">Extrait</label><textarea name=\"abstract\" id=\"abstract\" style=\"width:75em;\" rows=\"2\" ></textarea>");
				echo ("<br><br>");
                metaform_sel_multi ("TAG","","multiple size=5 style=\"width: 120px;\"  OnDblClick='javascript: deplacer( this.form.tag, this.form.tag_select);'",$tag,"tag","");
                metaform_sel_multi ("TAG Selectionné(s)","","multiple size=5 style=\"width: 120px;\"  OnDblClick='javascript: deplacer( this.form.tag_select, this.form.tag);'","","tag_select","");
				echo ("<br><br>");
				metaform_text ("Lien hypertexte","","","style=width:75em;","link","");
				metaform_text ("Lien hypertexte 2","","","style=width:75em;","link_2","");
        echo ("</fieldset>");

      		
//------------------------------------------------------------------------------
        echo ("<div style=\"float:right;\"><br>");
            echo ("<button id=\"enregistrer2-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
            echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_lsi']."</button> ");
        echo ("</div>");
        echo ("</form>");
        
		
		echo ("</div>");

        echo ("<div id=\"exit-confirm\" title=\"Retour\">");
            echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>".$lang[$lang_select]['retour_dialog']."</p>");
        echo ("</div>");

        echo ("<div id=\"enregistrer-dialog\">");
            echo ("<center><img src=\"../../_GRAPH/check.png\"  /><br>".$lang[$lang_select]['enregistrer_dialog']."</center>");
        echo ("</div><BR><BR>");

		//------------------------------------------------------------------------------ GRP 2

		echo ("<div id=\"fiche_lsi2\" >");
		echo ("<fieldset><LEGEND>Ajouter un tag</LEGEND>");
				echo ("<form method=\"POST\" id=\"form_add\" class=\"form_add\" name=\"edit_add\" action=\"\">");
				echo ("<label class=\"preField\">ajout d'un tag</label><input type=\"text\" name=\"tag_plus\" id=\"tag_plus\" size=\"70\" />  ");
				echo ("<input type=\"hidden\" name=\"go_tag_plus\" id=\"go_tag_plus\" size=\"70\" />  ");
				echo ("<input type=\"submit\" id=\"tag_submit\">  ");
				echo ("</form> ");
				if (isset($_POST['go_tag_plus']))
					{
					$query = "INSERT INTO lsi.tag (libelle_tag) VALUES ('".$_POST['tag_plus']."')";
					$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
					}
        echo ("</fieldset>");    
        echo ("</div>");	
	}
    break;
//------------------------------------------------------------------------------ EDIT
    case "view" : 
    case "edit" : {
//------------------------------------------------------------------------------ REF.
        //$subject[0]="";
        $query="SELECT * FROM ".SQL_schema_lsi.".subject ORDER BY id_subject;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $subject[$row["id_subject"]]=$row["libelle_subject"];
        pg_free_result ($result);

//------------------------------------------------------------------------------ EDIT
        echo ("<div id=\"liste\" >");
        echo ("</div>");
        echo ("<div id=\"fiche_lsi\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\">");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['edit_fiche']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            if ($mode == "edit") {
                echo ("<button id=\"enregistrer1-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
                echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_lsi']."</button> ");
            } else {
                echo ("<button id=\"retour3-button\">".$lang[$lang_select]['retour']."</button> ");
            }
        echo ("</div><br><br>");
        if (isset($_GET['id']) & !empty($_GET['id'])) {                         // Modifier
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            $query1="SELECT title,abstract,date,link,link_2,n.id_subject as sub,libelle_subject
			FROM ".SQL_schema_lsi.".news n
			LEFT OUTER JOIN ".SQL_schema_lsi.".subject s ON s.id_subject = n.id_subject
			WHERE n.id =  ".$id.";";
            $query2="SELECT cnt.id_tag, t.libelle_tag
			FROM ".SQL_schema_lsi.".coor_news_tag cnt JOIN ".SQL_schema_lsi.".tag t ON cnt.id_tag = t.id_tag
			WHERE cnt.id =  ".$id."
			ORDER BY libelle_tag;";
            $query3="SELECT id_tag, libelle_tag
			FROM ".SQL_schema_lsi.".tag t
			WHERE id_tag NOT IN (SELECT id_tag
			FROM ".SQL_schema_lsi.".coor_news_tag cnt
			WHERE cnt.id =  ".$id.")
			ORDER BY libelle_tag;";
			// echo $query2."<BR>".$query3;
			$result1=pg_query ($db,$query1) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result1),false);
			$result2=pg_query ($db,$query2) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result2),false);
			while ($row=pg_fetch_array ($result2,NULL,PGSQL_ASSOC))
				$tag_select[$row["id_tag"]]=$row["libelle_tag"];
			pg_free_result ($result2);
			$result3=pg_query ($db,$query3) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result3),false);
			while ($row=pg_fetch_array ($result3,NULL,PGSQL_ASSOC))
				$tag[$row["id_tag"]]=$row["libelle_tag"];
			pg_free_result ($result3);
if (pg_num_rows ($result1)) {
        echo ("<br>");

//------------------------------------------------------------------------------
        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_lsi_1']."</LEGEND>");
                echo ("<label class=\"preField\">Titre</label><input type=\"text\" name=\"title\" id=\"title\" size=\"70\" value=\"".pg_result($result1,0,"title")."\" />  ");
                echo ("<label class=\"preField\">Date</label><input type=\"text\" name=\"date\" id=\"date\" size=\"20\" value=\"".pg_result($result1,0,"date")."\" />  ");
                metaform_sel ("Sujet","","",$subject,"id_subject",pg_result($result1,0,"sub"));
				echo ("<br><br>");
				echo ("<label class=\"preField\">Extrait</label><textarea  name=\"abstract\" id=\"abstract\" style=\"width:75em;\" rows=\"2\" />".pg_result($result1,0,"abstract")."</textarea> ");
                echo ("<br><br>");
                metaform_sel_multi ("TAG","","multiple size=5 style=\"width: 120px;\" OnDblClick='javascript: deplacer( this.form.tag, this.form.tag_select);' ",$tag,"tag","");
                metaform_sel_multi ("TAG selectionné(s)","","multiple size=5 style=\"width: 120px;\" OnDblClick='javascript: deplacer( this.form.tag_select, this.form.tag);' ",$tag_select,"tag_select","");			            			            
				echo ("<br><br>");
                metaform_text ("Lien hypertexte","","","style=width:75em;","link",pg_result($result1,0,"link"));
                metaform_text ("Lien hypertexte 2","","","style=width:75em;","link_2",pg_result($result1,0,"link_2"));
 

		echo ("</fieldset>");

//------------------------------------------------------------------------------
                echo ("<br>");
                echo ("<div style=\"float:right;\">");
                    if ($mode == "edit") {
                        echo ("<button id=\"enregistrer2-edit-button\";>".$lang[$lang_select]['enregistrer']."</button> ");
                        echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_lsi']."</button> ");
                    } else {
                        echo ("<button id=\"retour4-button\">".$lang[$lang_select]['retour']."</button> ");
                    }
                echo ("</div>");
                echo ("</form>");
            
		echo ("<div id=\"fiche_lsi\" >");
		echo ("<fieldset><LEGEND>Ajouter un tag</LEGEND>");
				echo ("<form method=\"POST\" id=\"form_add\" class=\"form_add\" name=\"edit\" action=\"\">");
				echo ("<label class=\"preField\">ajout d'un tag</label><input type=\"text\" name=\"tag_plus\" id=\"tag_plus\" size=\"70\" />  ");
				echo ("<input type=\"hidden\" name=\"go_tag_plus\" id=\"go_tag_plus\" size=\"70\" />  ");
				echo ("<input type=\"submit\" id=\"tag_submit\">  ");
				echo ("</form> ");
				if (isset($_POST['go_tag_plus']))
					{
					$query = "INSERT INTO tag (libelle_tag) VALUES ('".$_POST['tag_plus']."')";
					$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
					}
        echo ("</fieldset>");    
        echo ("</div>");	

		
			} else fatal_error ("ID ".$id." > Pas de résultats !",false);
        } else fatal_error ("ID ".$id." > Vide !",false);
        echo ("</div>");

        echo ("<div id=\"exit-confirm\" title=\"Retour\">");
            echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>".$lang[$lang_select]['retour_dialog']."</p>");
        echo ("</div>");

        echo ("<div id=\"enregistrer-dialog\">");                                       // Form
            echo ("<center><img src=\"../../_GRAPH/check.png\"  /><br>".$lang[$lang_select]['enregistrer_dialog']."</center>");
        echo ("</div>");
    }
    break;
}

//------------------------------------------------------------------------------
echo ("</div>");                                                                // tabs
echo ("</div>");                                                                // page_consult
echo ("</body></html>");
pg_close ($db);

//------------------------------------------------------------------------------ FONCTIONS

?>

