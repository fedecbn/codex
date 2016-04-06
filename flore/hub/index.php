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
$id=$_GET['id'];
if (isset($_GET['id'])) $title.= "- ".$_GET['id']; else $title.= "- liste";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
$db2=sql_connect_hub(SQL_base_hub);
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

<script type="text/javascript" language="javascript" src="js/commun.js"></script>

<?php
// /*------------------------------------------------------------------------------ MAIN*/
html_header_2 ("utf-8","table_eval.css","jquery-te-1.4.0.css",$title);
/*html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");*/
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
	foreach ($onglet["id"] as $key => $val)
		echo ("<li><a href=\"#".$val."\">".$onglet["name"][$key]."</a></li>");
	echo ("<li><a href=\"#fiche\">".$lang[$lang_select]['fiche']."</a></li>");
echo ("</ul>");

echo ("<input type=\"hidden\" id=\"mode\" value=\"".$mode."\" />");

switch ($mode) {
/*------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS TABLEAU DE SYNTHESE */
/*------------------------------------------------------------------------------------------------------- */
    case "liste" : {
/*------------------------------------------------------------------------------ #Onglet 1*/
        echo ("<div id=\"".$onglet["id"][0]."\" >");
            echo ("<div id=\"titre2\">".$onglet["sstitre"][0]."</div>");
            echo ("<input type=\"hidden\" id=\"export-TXT-fichier\" value=\"".$onglet["id"][0]."_".$id_user.".txt\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"t.uid\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />");
            echo ("<div style=\"float:right;\">");
                if ($niveau >= 255) 
                    echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
					echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau >= 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			
			/*Table des données*/
			/*aff_table_new ($id_page,true,true);*/
			aff_table_reborn ("onglet0",$onglet["id"][0]);	
		echo ("</div>");
/*------------------------------------------------------------------------------ #Utilisateurs*/
        echo ("<div id=\"".$onglet["id"][1]."\" >");
            /*Troisième bandeau*/
            echo ("<div id=\"titre2\">".$onglet["sstitre"][1]."</div>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_reborn ("user",$onglet["id"][1]);		
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
	case "edit" : 
	case "bilan" : {
/*------------------------------------------------------------------------------ #Onglet 1*/
        echo ("<div id=\"$id_page\" >");
        echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
        echo ("<div id=\"fiche\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");

/*------------------------------------------------------------------------------ #Onglet Fiche*/

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['edit_fiche']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            if ($mode == "edit") {
                echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
            } else {
                echo ("<button id=\"retour3-button\">".$lang[$lang_select]['retour']."</button> ");
            }
		echo ("</div>");
		if (isset($_GET['id']) & !empty($_GET['id'])) { 
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            		
			$query= "SELECT lib_cbn FROM public.bilan WHERE uid = $id;";
			$result=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

            if (pg_num_rows ($result)) {
				/*Identifiant du CBN*/
				$row = pg_fetch_row($result);
				$schema = $row[0];
		
			echo ("<br><br>");
			
			foreach ($bouton as $val)
				echo ("<div id=\"".$val["id"]."-dialog\"></div>");
						
			echo("<input type=\"hidden\" name=\"zone\" id=\"zone1\" value=\"gl\">");
			echo ("<div id=\"radio2\">"); 
			echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
			echo ("<input type=\"hidden\" name=\"uid\" id=\"uid\" value=\"$id\">");
	/*------------------------------------------------------------------------------ EDIT fieldset1*/
		echo ("<div id=\"radio3\">");    
        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_1']."</LEGEND>");
		/*droits*/			
		$query= "SELECT id_cbn FROM applications.utilisateur WHERE id_user = '".$id_user."';";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		$row = pg_fetch_row($result);$id_cbn = $row[0];	
		/*Partie boutons*/
		$test_cbn = $id_cbn == $id ? true : false;
		les_boutons($bouton1,$niveau,$lang,$schema,$test_cbn);
		les_boutons($bouton2,$niveau,$lang,$schema,$test_cbn);
		les_boutons($bouton3,$niveau,$lang,$schema,$test_cbn);
			echo ("</fieldset>");
		echo ("</div>");    			
			
	/*------------------------------------------------------------------------------ EDIT fieldset2*/
		echo ("<div id=\"radio3\">");    
		/*Récupération des jeux des données*/
		$query= "SELECT * FROM ".$schema.".temp_metadonnees";
		$result1=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		
		$query= "SELECT * FROM ".$schema.".metadonnees";
		$result2=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

			
		/*Récupération du bilan*/
		$query= "SELECT * FROM public.bilan WHERE lib_cbn = '".$schema."'";
		$result3=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_2']."</LEGEND>");
				echo ("<table class=\"basic_table\" width=\"100%\">");
				// echo ("<th colspan=4 border=1>Partie temporaire</th><th colspan=4>Partie propre</th>");
				echo ("<tr><td>Nb relevés</td><td>Nb Obs</td><td>Nb Taxons (data)</td><td>Nb Taxons (taxa)</td><td>Nb relevés</td><td>Nb Obs</td><td>Nb Taxons (data)</td><td>Nb Taxons (taxa)</td></tr>");
				echo ("<tr><td colspan=4><b>Partie temporaire</b></td><td colspan=4><b>Partie propre</b></td></tr>");
				echo ("<tr><td colspan=4>");
				while ($row = pg_fetch_row($result1)) echo ("- Jdd ".$row[2]." :  ".$row[1]." -  ".$row[3]."<BR>");
				echo ("</td><td colspan=4>");
				while ($row = pg_fetch_row($result2)) echo ("- Jdd ".$row[2]." :  ".$row[1]." -  ".$row[3]."<BR>");
				echo ("</td></tr>");
				while ($row = pg_fetch_row($result3))
					echo ("<tr><td>".$row[7]."</td><td>".$row[8]."</td><td>".$row[9]."</td><td>".$row[10]."</td><td>".$row[2]."</td><td>".$row[3]."</td><td>".$row[4]."</td><td>".$row[5]."</td></tr>");
				echo ("</table>");
			echo ("</fieldset>");
		echo ("</div>");    	
		
	/*------------------------------------------------------------------------------ EDIT fieldset2*/
		echo ("<div id=\"radio3\">");    
		/*Récupération du zz_log*/
		$query= "SELECT * FROM ".$schema.".zz_log ORDER BY date_log DESC, typ_log ASC";
		$result=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		
        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_3']."</LEGEND>");
				echo ("<table class=\"basic_table\" width=\"100%\">");
				echo ("<tr><td>Action</td><td>Log</td><td>Table</td><td>Champ</td><td>Nb Occurence</td><td>Date</td></tr>");
				while ($row = pg_fetch_row($result))
					echo ("<tr><td><b>".$row[3]."</b></td><td>".$row[4]."</td><td>".$row[1]."</td><td>".$row[2]."</td><td>".$row[5]."</td><td>".substr($row[6],0,-4)."</td></tr>");
				echo ("</table>");
			echo ("</fieldset>");
		echo ("</div>");    	
	/* ----------------------------------------------------------------------------- EDIT SAVE*/
			echo ("<div style=\"float:right;\"><br>");
				if ($mode == "edit") {
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

