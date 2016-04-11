<?php
/*------------------------------------------------------------------ 
-------------------------------------------------------------------- 
 Application Codex                                            
 https://github.com/fedecbn/codex                      
-------------------------------------------------------------------- 
 Page principale          
-------------------------------------------------------------------- 
--------------------------------------------------------------------*/ 
/*------------------------------------------------------------------------------ INITIALISATION*/ 
session_start ();
include ("commun.inc.php");
/*Droit page*/ 
$base_file = substr(basename(__FILE__),0,-4); 
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]); 
 
if ($droit_page) { 

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ PARMS.
$mode = isset($_GET['m']) ? $_GET['m'] : "liste";
if (isset($_GET['o']) & !empty($_GET['o'])) $o=$_GET['o'];
if (isset($_GET['id'])) $title.= "- ".$_GET['id']; else $title.= "- liste";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($id_page);


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

<script type="text/javascript" language="javascript" src="js/commun.js"></script>

<?php
//------------------------------------------------------------------------------ MAIN
// html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");
html_header_2 ("utf-8","table_eval.css","jquery-te-1.4.0.css",$title);
//html_header ("utf-8","","");
echo ("<body>");
echo ("<div id=\"page_consult\" class=\"page_consult\">");

//------------------------------------------------------------------------------ Titre
echo ("<div id=\"header2\">");
    echo ("<div style=\"float:left;\">");
    echo ("<button id=\"home-button\">".$lang[$lang_select]['Retour_menu']."</button>");
    echo ("</div>");
    echo ("<font size=5>".$lang[$lang_select]['titre']." - Rubrique $titre</font>");
echo ("</div>");

echo ("<div id=\"tabs\" style=\" min-height:800px;\">");
echo ("<ul>");
echo ("<li><a href=\"#".$id_page."\">".$lang[$lang_select][$id_page]."</a></li>");
echo ("<li><a href=\"#".$id_page_2."\">".$lang[$lang_select][$id_page_2]."</a></li>");
echo ("<li><a href=\"#fiche\">".$lang[$lang_select]['fiche']."</a></li>");
echo ("</ul>");

echo ("<input type=\"hidden\" id=\"mode\" value=\"".$mode."\" />");

switch ($mode) {
    default:
/*------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS TABLEAU DE SYNTHESE */
/*------------------------------------------------------------------------------------------------------- */
	case "liste" : {
        echo ("<div id=\"$id_page\" >");
            echo ("<div id=\"titre2\">");
                echo ($lang[$lang_select]["liste_$id_page"]);
            echo ("</div>");
            echo ("<input type=\"hidden\" id=\"export-TXT-fichier\" value=\"".$id_page."_".$id_user.".csv\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"$id_export\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />");
            echo ("<div style=\"float:right;\">");
                if ($niveau >= 128) 
                    echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
                echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau >= 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
            aff_table_new ($id_page,true,true);
        echo ("</div>");
//------------------------------------------------------------------------------ #fiche
        echo ("<div id=\"fiche\" >");
        echo ("</div>");
		echo ("<div id=\"droit\" >");
            /*Troisième bandeau*/
            echo ("<div id=\"titre2\">");
                echo "Droit d'utilisation de la rubrique";
            echo ("</div>");
            echo ("<div style=\"float:right;\">");
                // if ($niveau >= 128) 
                    // echo ("<button id=\"to-refnat\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
				// if ($niveau >= 64) 
					// echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                // if ($niveau >= 255) 
                    // echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_new ("droit",false,true);			
        echo ("</div>");

    }
    break;
//------------------------------------------------------------------------------ ADD
    case "add" : {
//------------------------------------------------------------------------------ REF.
        //$subject[0]="";
        $query="SELECT * FROM lsi.subject ORDER BY id_subject;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $subject[$row["id_subject"]]=$row["libelle_subject"];
        pg_free_result ($result);

        //$tag[0]="";
        $query="SELECT * FROM lsi.tag ORDER BY libelle_tag;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $tag[$row["id_tag"]]=$row["libelle_tag"];
        pg_free_result ($result);

//------------------------------------------------------------------------------ ADD
        echo ("<div id=\"liste\" >");
        echo ("</div>");
        echo ("<div id=\"fiche\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['add_lsi']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            echo ("<button id=\"enregistrer1-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
            echo ("<button id=\"retour1-button\">".$lang[$lang_select]['lsi']."</button> ");
        echo ("</div><br><br>");

//------------------------------------------------------------------------------ GRP 1
         echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_lsi_1']."</LEGEND>");
                // echo ("<label class=\"preField\">Titre</label><input type=\"text\" name=\"title\" id=\"title\" size=\"70\" />  ");
				metaform_text ("Titre",null,70,null,"title",null);
				metaform_text ("Date",null,20,null,"date",date("Y-m-d"));
                // echo ("<label class=\"preField\">Date</label><input type=\"text\" name=\"date\" id=\"date\" size=\"20\" value=\"".."\" />  ");
                metaform_sel ("Sujet","","",$subject,"id_subject","");
				echo ("<br><br>");
                echo ("<label class=\"preField\">Extrait</label><textarea name=\"abstract\" id=\"abstract\" cols=\"150\" rows=\"2\" ></textarea>");
				echo ("<br><br>");
                metaform_sel_multi ("TAG","",5,"width: 120px;","OnDblClick='javascript: deplacer( this.form.tag, this.form.tag_select);'",$tag,"tag","");
                metaform_sel_multi ("TAG Selectionné(s)","",5,"width: 120px;","OnDblClick='javascript: deplacer( this.form.tag_select, this.form.tag);'","","tag_select","");
				echo ("<br><br>");
				metaform_text ("Lien hypertexte",null,150,null,"link",null);
				metaform_text ("Lien hypertexte 2",null,150,null,"link_2",null);
        echo ("</fieldset>");

      		
//------------------------------------------------------------------------------
        echo ("<div style=\"float:right;\"><br>");
            echo ("<button id=\"enregistrer2-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
            echo ("<button id=\"retour2-button\">".$lang[$lang_select]['lsi']."</button> ");
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

		echo ("<div id=\"fiche\" >");
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
/*Gestion des niveau de droit*/
if ($niveau <= 64) $desc = " bloque";
if ($niveau <= 64) $disa = "disabled"; else $disa = null;

        //$subject[0]="";
        $query="SELECT * FROM lsi.subject ORDER BY id_subject;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $subject[$row["id_subject"]]=$row["libelle_subject"];
        pg_free_result ($result);

//------------------------------------------------------------------------------ EDIT
        echo ("<div id=\"liste\" >");
        echo ("</div>");
        echo ("<div id=\"fiche\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\">");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['edit_fiche']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            if ($mode == "edit") {
                echo ("<button id=\"enregistrer1-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
                echo ("<button id=\"retour1-button\">".$lang[$lang_select]['lsi']."</button> ");
            } else {
                echo ("<button id=\"retour3-button\">".$lang[$lang_select]['retour']."</button> ");
            }
        echo ("</div><br><br>");
        if (isset($_GET['id']) & !empty($_GET['id'])) {                         // Modifier
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            $query1="SELECT title,abstract,date,link,link_2,n.id_subject as sub,libelle_subject
			FROM lsi.news n LEFT OUTER JOIN lsi.subject s ON s.id_subject = n.id_subject
			WHERE n.id =  ".$id.";";
            $query2="SELECT cnt.id_tag, t.libelle_tag
			FROM lsi.coor_news_tag cnt JOIN lsi.tag t ON cnt.id_tag = t.id_tag
			WHERE cnt.id =  ".$id."
			ORDER BY libelle_tag;";
            $query3="SELECT id_tag, libelle_tag
			FROM lsi.tag t
			WHERE id_tag NOT IN (SELECT id_tag FROM lsi.coor_news_tag cnt WHERE cnt.id =  ".$id.")
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
 				metaform_text ("Titre",null,70,null,"title",sql_format_quote(pg_result($result1,0,"title"),'undo_text'));
				metaform_text ("Date",null,20,null,"date",sql_format_quote(pg_result($result1,0,"date"),'undo_text'));
                metaform_sel ("Sujet","","",$subject,"id_subject",pg_result($result1,0,"sub"));
				echo ("<br>");
				echo ("<label class=\"preField\">Extrait</label><textarea  name=\"abstract\" id=\"abstract\" cols=\"150\" rows=\"2\" />".sql_format_quote(pg_result($result1,0,"abstract"),'undo')."</textarea> ");
                echo ("<br><br>");
                metaform_sel_multi ("TAG","",5,"width: 120px;","OnDblClick='javascript: deplacer( this.form.tag, this.form.tag_select);' ",$tag,"tag","");
				metaform_sel_multi ("TAG Selectionné(s)","",5,"width: 120px;","OnDblClick='javascript: deplacer( this.form.tag_select, this.form.tag);'",$tag_select,"tag_select","");
				echo ("<br><br>");
                metaform_text ("Lien hypertexte",null,150,null,"link",sql_format_quote(pg_result($result1,0,"link"),'undo_text'));
                metaform_text ("Lien hypertexte 2",null,150,null,"link_2",sql_format_quote(pg_result($result1,0,"link_2"),'undo_text'));
		echo ("</fieldset>");

//------------------------------------------------------------------------------
                echo ("<br>");
                echo ("<div style=\"float:right;\">");
                    if ($mode == "edit") {
                        echo ("<button id=\"enregistrer2-edit-button\";>".$lang[$lang_select]['enregistrer']."</button> ");
                        echo ("<button id=\"retour2-button\">".$lang[$lang_select]['lsi']."</button> ");
                    } else {
                        echo ("<button id=\"retour4-button\">".$lang[$lang_select]['retour']."</button> ");
                    }
                echo ("</div>");
                echo ("</form>");
            
		echo ("<div id=\"fiche\" >");
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

//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>

