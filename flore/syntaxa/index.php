<?php
//------------------------------------------------------------------------------//
//  index.php                                                   				//
//                                                                              //
//  Application WEB 'Codex'                                                      //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  13/08/14 - MaJ schémas                                        //
//  Version 1.03  21/08/14 - MaJ droits                                         //
//  Version 1.10  01/09/14 - MaJ form v2                                        //
//  Version 1.11  10/09/14 - MaJ form labels                                    //
//  Version 2.00  29/04/15 - Généralisation                                    //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start ();
include ("commun.inc.php");
if ($_SESSION['EVAL_FLORE'] != "ok") require ("../commun/access_denied.php");

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ PARMS.
$mode = isset($_GET['m']) ? $_GET['m'] : "liste";
if (isset($_GET['o']) & !empty($_GET['o'])) $o=$_GET['o'];
$id="'".$_GET['id']."'";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
/*Cette fonction récupère toutes les référentiels utiles pour la page. Les référentiels sons stockés dans l'objet $ref*/
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

<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/gestion.js"></script>
<script type="text/javascript" language="javascript" src="js/liste.js"></script>
<script type="text/javascript" language="javascript" src="js/autocomp.js"></script>

<?php
// /*------------------------------------------------------------------------------ MAIN*/
html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");
/*html_header ("utf-8","","");*/
echo ("<body>");
echo ("<div id=\"page_consult\" class=\"page_consult\">");

/*------------------------------------------------------------------------------ Titre*/
/*Premier bandeau*/
echo ("<div id=\"header2\">");
    echo ("<div style=\"float:left;\">");
    echo ("<button id=\"home-button\">".$lang[$lang_select]['Retour_menu']."</button>");
    echo ("</div>");
    echo ("<font size=5>".$lang[$lang_select]['titre']."</font>");
echo ("</div>");

/*Deuxième bandeau : les onglets*/
echo ("<div id=\"tabs\" style=\" min-height:800px;\">");
echo ("<ul>");
echo ("<li><a href=\"#".$id_page."\">".$lang[$lang_select][$id_page]."</a></li>");
echo ("<li><a href=\"#".$id_page_2."\">".$lang[$lang_select][$id_page_2]."</a></li>");
echo ("<li><a href=\"#fiche\">".$lang[$lang_select]['fiche']."</a></li>");
echo ("</ul>");

echo ("<input type=\"hidden\" id=\"mode\" value=\"".$mode."\" />");

switch ($mode) {
/*------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS TABLEAU DE SYNTHESE */
/*------------------------------------------------------------------------------------------------------- */
    case "liste" : {
/*------------------------------------------------------------------------------ #Onglet 1*/
        echo ("<div id=\"".$id_page."\" >");
            /*Troisième bandeau*/
			echo ("<div id=\"titre2\">");
                echo ($lang[$lang_select]["liste_taxons"]);
            echo ("</div>");
            echo ("<input type=\"hidden\" id=\"export-TXT-fichier\" value=\"Liste_fiches_".$id_user.".txt\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"t.uid\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />");
            echo ("<div style=\"float:right;\">");
                if ($niveau >= 128) 
                    echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
                echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau >= 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			
			/*Table des données*/
			aff_table_new ($id_page,true,true);			
		echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
        echo ("<div id=\"fiche\" >");
        echo ("</div>");
    }
    break;

/*------------------------------------------------------------------------------ #CAS AJOUT D'UNE FICHE */
	case "add" : {
/*Ajouter L'autocomplétion*/
include ("../commun/add_fiche.php");
    }
    break;

/*--------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS MODIFICATION DE FICHE */
/*--------------------------------------------------------------------------------------------------------- */
	case "view" : 
	case "edit" : {
/*------------------------------------------------------------------------------ REF. */


/*------------------------------------------------------------------------------ #Onglet 1*/
        echo ("<div id=\"$id_page\" >");
        echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
        echo ("<div id=\"fiche\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['edit_fiche']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            if ($mode == "edit") {
                echo ("<button id=\"enregistrer1-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
                echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
            } else {
                echo ("<button id=\"retour3-button\">".$lang[$lang_select]['retour']."</button> ");
            }
		echo ("</div>");
		if (isset($_GET['id']) & !empty($_GET['id'])) { 
            $id="'".$_GET['id']."'";
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            		
			$query= $query_module.$id.";";
			//echo $query;
			$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
			
			$query2= $query_module_biblio.$id.";";
			//echo $query;
			$result2=pg_query ($db,$query2) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
			
			
			//$table = pg_fetch_array($result);
			//var_dump($table);
			//$colname = pg_field_name($result, 1);
			//$colname="codeEnregistrementSyntax";
			//echo $colname;
			//$val= pg_fetch_result(pg_query ($db,$query_description."'$colname1'".";"),0,"description" );
			//echo $val;
			//$val= pg_fetch_result($result2,"\"codeEnregistrement\"" );
			//echo $val;

			
            if (pg_num_rows ($result)) {
			
			echo ("<br><br>");
				
			echo("<input type=\"hidden\" name=\"zone\" id=\"zone1\" value=\"gl\">");
			
			echo ("<div id=\"radio2\">"); 
			echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
			//echo ("<input type=\"hidden\" name=\"codeEnregistrementSyntax\" id=\"codeEnregistrementSyntax\" value=\"".pg_result($result,0,"codeEnregistrementSyntax")."\">");

	/*------------------------------------------------------------------------------ EDIT fieldset1*/
	/*----------Attention la fonction pg_fetch_result() is case sensitive donc faire attention aux noms de colonnes avec majuscule*/

					$colname1="idBiblio";$colname3="libPublication";$colname4="urlPublication";
					$colname5="codePublication";
	
			 echo ("<fieldset><LEGEND>Nomenclature</LEGEND>");
			 
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 350px;\">");
				metaform_text ("Code de l'enregistrement"," ",20,"","codeEnregistrementSyntax",sql_format_quote(pg_result($result,0,"\"$colname1\"" ),'undo_text'), pg_fetch_result(pg_query ($db,$query_description."'$colname1'".";"),0,"description" ));
				echo ("</td><td>");
				metaform_text ("Identifiant du syntaxon"," bloque",20,"","idSyntaxon",pg_result($result,0,"\"$colname3\""), pg_fetch_result(pg_query ($db,$query_description."'$colname3'".";"),0,"description" ));
				echo ("</td><td>");		
				metaform_text ("Identifiant du syntaxon retenu"," bloque",20,"","idSyntaxonRetenu",pg_result($result,0,"\"$colname10\""), pg_fetch_result(pg_query ($db,$query_description."'$colname10'".";"),0,"description" ));				
				echo ("</td></tr></table>");
				
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 800px;\">");					
					//metaform_text ("Code de l'enregistrement"," ",20,"","codeEnregistrementSyntax",sql_format_quote(pg_result($result,0,"\"$colname1\"" ),'undo_text'));
					metaform_text ("Nom du syntaxon","",100,"","nomSyntaxon",pg_result($result,0,"\"$colname2\""), pg_fetch_result(pg_query ($db,$query_description."'$colname2'".";"),0,"description" ));
					metaform_text ("Auteur du syntaxon","",100,"","auteurSyntaxon",sql_format_quote(pg_result($result,0,"\"$colname4\"" ),'undo_text'), pg_fetch_result(pg_query ($db,$query_description."'$colname4'".";"),0,"description" ));
					metaform_text ("Nom complet du syntaxon"," bloque",100,"","nomCompletSyntaxon",pg_result($result,0,"\"$colname5\""), pg_fetch_result(pg_query ($db,$query_description."'$colname5'".";"),0,"description" ));
					metaform_text ("Nom raccourcit"," bloque",100,"","nomSyntaxonRaccourci",pg_result($result,0,"\"$colname6\""), pg_fetch_result(pg_query ($db,$query_description."'$colname6'".";"),0,"description" ));
					metaform_sel ("Type de synonymie","",100,$ref[$champ_ref['typeSynonymie']],"typeSynonymie",pg_result($result,0,"\"$colname8\""), pg_fetch_result(pg_query ($db,$query_description."'$colname8'".";"),0,"description" ));
					metaform_text ("Nom syntaxon retenu"," bloque",100,"","nomSyntaxonRetenu",pg_result($result,0,"\"$colname9\""), pg_fetch_result(pg_query ($db,$query_description."'$colname9'".";"),0,"description" ));
				echo ("</td></tr></table>");
				
				$tooltip=pg_fetch_result(pg_query ($db,$query_description."'$colname7'".";"),0,"description" );
				echo ("<br><label title= \"$tooltip\" class=\"preField\">Remarque nomenclaturale</label><textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"\"$colname7\""),'undo_hmtl')."</textarea><br><br>");
				
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("</td><td style=\"width:300px;\">");				
					//metaform_text ("Code REF."," bloque",8,"","cd_ref",pg_result($result,0,"cd_ref"));
					metaform_sel ("Rang syntaxon","","",$ref[$champ_ref[$colname11]],"rangSyntaxon",pg_result($result,0,"\"$colname11\""), pg_fetch_result(pg_query ($db,$query_description."'$colname11'".";"),0,"description" ));
				/* //bout de code a utiliser si on veut aller vers une fiche taxon dans refnat
				echo ("</td><td>");	
					if ($niveau >= 128)
						echo ("<a href = \"../refnat/index.php?m=edit&id=$id\" class=edit id=\"modif_taxon\" ><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Refnat\" ></a>"); 
				*/
				echo ("</td></tr></table>");
				echo ("</fieldset>");
	/*------------------------------------------------------------------------------ EDIT fieldset2*/
	
		
					$colname1="codeEnregistrementSyntax";$colname2="nomSyntaxon";$colname3="idSyntaxon";$colname4="auteurSyntaxon";
					$colname5="nomCompletSyntaxon";$colname6="nomSyntaxonRaccourci";$colname7="rqNomenclaturale";$colname8="typeSynonymie";
					$colname9="nomSyntaxonRetenu";$colname10="idSyntaxonRetenu";$colname11="rangSyntaxon";
					$colname12="idSyntaxonSup";$colname13="nomFrancaisSyntaxon";$colname14="diagnoseCourteSyntaxon";$colname15="idCritique";$colname16="rqCritique";
	
			 echo ("<fieldset><LEGEND>Bibliographie</LEGEND>");
			 
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 350px;\">");
				metaform_text ("Code de l'enregistrement"," bloque",20,"","codeEnregistrementSyntax",sql_format_quote(pg_result($result,0,"\"$colname1\"" ),'undo_text'));
				echo ("</td><td>");
				metaform_text ("Identifiant du syntaxon"," bloque",20,"","idSyntaxon",pg_result($result,0,"\"$colname3\""));
				echo ("</td><td>");		
				metaform_text ("Identifiant du syntaxon retenu"," bloque",20,"","idSyntaxonRetenu",pg_result($result,0,"\"$colname10\""));				
				echo ("</td></tr></table>");
				
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 800px;\">");					
					metaform_text ("Code de l'enregistrement"," bloque",20,"","codeEnregistrementSyntax",sql_format_quote(pg_result($result,0,"\"$colname1\"" ),'undo_text'));
					metaform_text ("Nom du syntaxon","",100,"","nomSyntaxon",pg_result($result,0,"\"$colname2\""));
					metaform_text ("Auteur du syntaxon","",100,"","auteurSyntaxon",sql_format_quote(pg_result($result,0,"\"$colname4\"" ),'undo_text'));
					metaform_text ("Nom complet du syntaxon"," bloque",100,"","nomCompletSyntaxon",pg_result($result,0,"\"$colname5\""));
					metaform_text ("Nom raccourcit"," bloque",100,"","nomSyntaxonRaccourci",pg_result($result,0,"\"$colname6\""));
					metaform_sel ("Type de synonymie","",100,$ref[$champ_ref['typeSynonymie']],"typeSynonymie",pg_result($result,0,"\"$colname8\""));
					metaform_text ("Nom syntaxon retenu"," bloque",100,"","nomSyntaxonRetenu",pg_result($result,0,"\"$colname9\""));
				echo ("</td></tr></table>");
				
				echo ("<br><label class=\"preField\">Remarque nomenclaturale</label><textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"\"$colname7\""),'undo_hmtl')."</textarea><br><br>");
				
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("</td><td style=\"width:300px;\">");				
					//metaform_text ("Code REF."," bloque",8,"","cd_ref",pg_result($result,0,"cd_ref"));
					metaform_sel ("Rang syntaxon","","",$ref[$champ_ref[$colname11]],"rangSyntaxon",pg_result($result,0,"\"$colname11\""));
				/* //bout de code a utiliser si on veut aller vers une fiche taxon dans refnat
				echo ("</td><td>");	
					if ($niveau >= 128)
						echo ("<a href = \"../refnat/index.php?m=edit&id=$id\" class=edit id=\"modif_taxon\" ><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Refnat\" ></a>"); 
				*/
				echo ("</td></tr></table>");
				echo ("</fieldset>");

	/* ----------------------------------------------------------------------------- EDIT SAVE*/
			echo ("<div style=\"float:right;\"><br>");
				if ($mode == "edit") {
					echo ("<button id=\"enregistrer2-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
					echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
				} else {
					echo ("<button id=\"retour4-button\">".$lang[$lang_select]['retour']."</button> ");
				}
				echo ("</div>");
				echo ("</form>");
				} else fatal_error ("ID ".$id." > Vide !",false);
			} else fatal_error ("ID ".$id." > Vide !",false);
			echo ("</div>");

			echo ("<div id=\"exit-confirm\" title=\"Retour\">");
				echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>".$lang[$lang_select]['retour_dialog']."</p>");
			echo ("</div>");

			echo ("<div id=\"enregistrer-dialog\">");
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

