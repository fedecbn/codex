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
include ("commun.inc.php");
/*Droit page*/ 
$base_file = substr(basename(__FILE__),0,-4); 
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]); 
 
if ($droit_page) { 

//------------------------------------------------------------------------------ VAR.

//------------------------------------------------------------------------------ PARMS.
$mode = isset($_GET['m']) ? $_GET['m'] : "liste";
if (isset($_GET['o']) & !empty($_GET['o'])) $o=$_GET['o'];
$id=$_GET['id'];
if (isset($_GET['id'])) $title.= "- ".$_GET['id']; else $title.= "- liste";

/*Tailles des cases*/
$etude = array (
"Nomenclature" => 10,
"Taxonomie" => 10,
"Répartition"=> 4
);
	
	
	
//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
/*Cette fonction récupère toutes les référentiels utiles pour la page. Les référentiels sons stockés dans l'objet $ref*/
ref_colonne_et_valeur ($id_page);
/*Droits*/
$typ_droit='d2';$rubrique=$id_page;
$droit = ref_droit($id_user,$typ_droit,$rubrique,$id_page);

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
// html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");
html_header_2 ("utf-8","table_eval.css","jquery-te-1.4.0.css",$title);

/*html_header ("utf-8","","");*/
echo ("<body>");
echo ("<div id=\"page_consult\" class=\"page_consult\">");

/*------------------------------------------------------------------------------ Titre*/
/*Premier bandeau*/
echo ("<div id=\"header2\">");
    echo ("<div style=\"float:left;\">");
    echo ("<button id=\"home-button\">".$lang[$lang_select]['Retour_menu']."</button>");
    echo ("</div>");
    echo ("<font size=5>".$lang[$lang_select]['titre']." - Rubrique $titre</font>");
echo ("</div>");

/*Deuxième bandeau : les onglets*/
echo ("<div id=\"tabs\" style=\" min-height:800px;\">");
echo ("<ul>");
  foreach ($onglet["id"] as $key => $val) 
    echo ("<li><a href=\"#".$val."\">".$onglet["nom"][$key]."</a></li>"); 
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
            /*Troisième bandeau*/
			echo ("<div id=\"titre2\">".$onglet["ss_titre"][0]."</div>"); 
            echo ("<input type=\"hidden\" id=\"export-TXT-fichier\" value=\"".$id_page."_".$id_user.".csv\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"$export_id\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />");
            echo ("<div style=\"float:right;\">");
                if ($droit['add_fiche']) echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
				if ($droit['export_fiche']) echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($droit['del_fiche']) echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			
			/*Table des données*/
			aff_table_reborn ("onglet0",$onglet["id"][0]);
			// aff_table_new ($id_page,true,true);			
		echo ("</div>");
//------------------------------------------------------------------------------ #deuxieme onglet (DROIT)
        echo ("<div id=\"".$onglet["id"][1]."\" >");
            /*Troisième bandeau*/
            echo ("<div id=\"titre2\">".$onglet["ss_titre"][1]."</div>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_reborn ("user",$onglet["id"][1]);		
		echo ("</div>");    
    }
    break;

/*------------------------------------------------------------------------------ #CAS AJOUT D'UNE FICHE */
	case "add" : {
/*------------------------------------------------------------------------------ #Onglet 1*/
echo ("<div id=\"$id_page\" >");
echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
echo ("<div id=\"".$onglet["id"][0]."\" >"); 
echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");

echo ("<div style=\"float:left;\">");
	echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['add_fiche']."</font>");
echo ("</div>");
echo ("<div style=\"float:right;\">");
	echo ("<button id=\"enregistrer1-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
	echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
echo ("</div><br><br>");

echo ("<br><br>");

echo ("<div id=\"radio2\">"); 
echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
/*------------------------------------------------------------------------------ AJOUT Fiche */
/*------------------------------------------------------------------------------ EDIT fieldset1*/
	/*------------------------------------------------------------------------------ EDIT fieldset1*/
		echo ("<fieldset><LEGEND>Taxon</LEGEND>");
			echo ("<table><tr><TD style=\"padding-right:20px;\">");
				echo ("Le taxon appartient aux listes suivantes : <BR>");
				metaform_bool ("Rubrique CATNAT",null,"catnat",'f');
				echo ("<BR>");
				metaform_bool ("Rubrique Liste rouge",null,"lr",'f');
				echo ("<BR>");
				metaform_bool ("Rubrique Liste EEE",null,"eee",'f');
				echo ("<BR>");
			echo("</td><td valign=\"top\">");
				echo ("Informations supplémentaires sur le taxon : <BR>");
				metaform_bout ("Hybride",null,"hybride",null);
				echo ("</td></tr></table>");
		echo ("</fieldset>");

	/*------------------------------------------------------------------------------ EDIT fieldset2*/
	/*Requete référentiels*/
	$flag = 0;

	/*Nomenclature*/
	$select_fcbn["Nomenclature"] = "'' as cd_nom,'' as  cd_ref,'' as  lb_nom,'' as  lb_auteur,'' as  nom_complet,'' as  nom_valide,'' as  nom_vern,'' as  nom_vern_eng";
	
	/*Taxonomie*/
	$select_fcbn["Taxonomie"] = "'' as  cd_taxsup,'' as  rang,'' as  regne,'' as  phylum,'' as  classe,'' as  ordre,'' as  famille";
	
	/*Répartition*/
	$select_fcbn["Répartition"] = "'' as  fr,'' as  gf,'' as  mar,'' as  gua,'' as  sm,'' as  sb,'' as  spm,'' as  may,'' as  epa,'' as  reu,'' as  taaf,'' as  pf,'' as  nc,'' as  wf,'' as  cli,'' as  habitat";

	echo ("<fieldset><LEGEND>Correspondance avec TAXREF</LEGEND>");
	foreach ($etude as $num => $length)
		{
		$requete = "SELECT $select_fcbn[$num]";
		// echo "<BR>$requete";
		$result=pg_query ($db,$requete) or die ("Erreur pgSQL : ".$requete);
		$entete=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
		
			/*Tableau Nomenclature*/
			echo ("<table width=\"1200\"><tr align=center style=\"border-bottom:1pt solid #D0C5AA;\"><td>$num</td></tr></table>");
			echo ("<table width=\"1200\"><tr valign=center style=\"border-bottom:1pt solid #D0C5AA;\">");
			/*entete de colonne*/
			foreach ($entete as $field => $val) echo ("<th style=\" text-align: center;	vertical-align: center;\">$field</th>");
			echo("</tr>");
			echo("<tr>");
			/*premiere ligne*/
			foreach ($entete as $field => $val)
				{
					echo ("<td style=\"text-align: center;\">");
					$field_inteface = $field;
					metaform_text ($field," no_lab",""," width:".$length."em;",$field_inteface,sql_format_quote($val,'undo_text'));
					echo ("</td>");
				}
				$row_plus = $entete;
				echo("</tr>");
			
			echo("</table><br>");					
		}
	echo ("</fieldset>");

/*------------------------------------------------------------------------------ SAVE */
echo ("<div style=\"float:right;\"><br>");
	echo ("<button id=\"enregistrer2-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
	echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
echo ("</div>");
echo ("</form>");
echo ("</div>");

echo ("<div id=\"exit-confirm\" title=\"Retour\">");
	echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>".$lang[$lang_select]['retour_dialog']."</p>");
echo ("</div>");

echo ("<div id=\"enregistrer-dialog\">");
	echo ("<center><img src=\"../../_GRAPH/check.png\"  /><br>".$lang[$lang_select]['enregistrer_dialog']."</center>");
echo ("</div>");

    }
    break;

/*--------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS MODIFICATION DE FICHE */
/*--------------------------------------------------------------------------------------------------------- */
	case "view" : 
	case "edit" : {
/*------------------------------------------------------------------------------ REF. */
if ($niveau <= 64) $desc = "bloque"; else $desc = null;
if ($niveau <= 64) $disa = "disabled"; else $disa = null;


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
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            		
			$query= $query_module.$id.";";

			$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
            if (pg_num_rows ($result)) {

			echo ("<br><br>");
				
			echo("<input type=\"hidden\" name=\"zone\" id=\"zone1\" value=\"gl\">");
			
			echo ("<div id=\"radio2\">"); 
			echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
			echo ("<input type=\"hidden\" name=\"uid\" id=\"uid\" value=\"".pg_result($result,0,"uid")."\">");
	/*------------------------------------------------------------------------------ EDIT fieldset1*/
		echo ("<fieldset><LEGEND>Taxon</LEGEND>");
			echo ("<table><tr><TD style=\"padding-right:20px;\">");
				echo ("Le taxon appartient aux listes suivantes : <BR>");
				metaform_bool ("Rubrique CATNAT",$desc,"catnat",pg_result($result,0,"catnat"));
				if ($_SESSION['niveau_catnat'] >= 128 AND pg_result($result,0,"catnat") == 't') 
					echo ("<a class=edit id=\"page_catnat\" href=\"../catnat/index.php?m=edit&id=$id\"><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Catalogue National\"></a>"); 
				echo ("<BR>");
				metaform_bool ("Rubrique Liste rouge",$desc,"lr",pg_result($result,0,"lr"));
				if ($_SESSION['niveau_lr'] >= 128 AND pg_result($result,0,"lr") == 't') 
					echo ("<a class=edit id=\"page_lr\" href=\"../lr/index.php?m=edit&id=$id\"><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Liste rouge\"></a>"); 
				echo ("<BR>");
				metaform_bool ("Rubrique Liste EEE",$desc,"eee",pg_result($result,0,"eee"));
				if ($_SESSION['niveau_eee'] >= 128 AND pg_result($result,0,"eee") == 't') 
					echo ("<a class=edit id=\"page_eee\" href=\"../eee/index.php?m=edit&id=$id\"><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Liste EEE\"></a>"); 
				echo ("<BR>");
			echo("</td><td valign=\"top\">");
				echo ("Informations supplémentaires sur le taxon : <BR>");
				metaform_bout ("Hybride",$desc,"hybride",pg_result($result,0,"hybride"));
				echo ("</td></tr></table>");
		echo ("</fieldset>");
		
	/*------------------------------------------------------------------------------ EDIT fieldset2*/
	/*Requete référentiels*/
	$cd_nom = pg_result($result,0,"cd_nom");
	$hybride = pg_result($result,0,"hybride");
	$flag = 0;
	
	/*Nomenclature*/
	$select_fcbn["Nomenclature"] = $select0["Nomenclature"] = $select1["Nomenclature"] = $select2["Nomenclature"] = $select3["Nomenclature"] = $select4["Nomenclature"] = " ,cd_nom::text, cd_ref::text, lb_nom, lb_auteur, nom_complet, nom_valide, nom_vern, nom_vern_eng";
	
	/*Taxonomie*/
	$select_fcbn["Taxonomie"] = $select0["Taxonomie"] =", cd_sup::text, cd_taxsup::text, rang, regne, phylum, classe, ordre, famille";
	$select1["Taxonomie"] = $select2["Taxonomie"] = $select3["Taxonomie"] =", '-' as cd_sup, cd_taxsup::text, rang, regne, phylum, classe, ordre, famille";
	$select4["Taxonomie"] = ", '-' as cd_sup, '-' as cd_taxsup, rang, regne, phylum, classe, ordre, famille";
	
	/*Répartition*/
	$select_fcbn["Répartition"] = $select0["Répartition"] = $select1["Répartition"] = $select2["Répartition"] = ", fr, gf, mar, gua, sm, sb, spm, may, epa, reu, taaf, pf, nc, wf, cli, habitat::text";
	$select3["Répartition"] = ", fr, gf, mar, gua, smsb as sm, smsb as sb, spm, may, epa, reu, taaf, pf, nc, wf, cli, habitat";
	// $select4["Répartition"] = ", fr, 'non prévu dans cette version' as gf, mar, gua, smsb as sm, smsb as sb, spm, may, 'non prévu dans cette version' as habitat,'non prévu dans cette version' as epa, reu, taaf, 'non prévu dans cette version' as pf, 'non prévu dans cette version' as nc, 'non prévu dans cette version' as wf, 'non prévu dans cette version' as cli";
	$select4["Répartition"] = ", fr, '-' as gf, mar, gua, smsb as sm, smsb as sb, spm, may, '-' as habitat,'-' as epa, reu, taaf, '-' as pf, '-' as nc, '-' as wf, '-' as cli";

	
	
	echo ("<fieldset><LEGEND>Correspondance avec TAXREF</LEGEND>");
	foreach ($etude as $num => $length)
		{
		$requete = "SELECT * FROM (SELECT 'vRéseauCBN' as version $select_fcbn[$num] FROM refnat.taxons v9 WHERE uid = '$id'
		UNION ALL SELECT 'v9' as version $select0[$num] FROM refnat.taxrefv90_utf8 v9 WHERE cd_nom = '$cd_nom'	
		UNION ALL SELECT 'v8' as version $select1[$num] FROM refnat.taxrefv80_utf8 v8 WHERE cd_nom = '$cd_nom'	
		UNION ALL SELECT 'v7' as version $select1[$num] FROM refnat.taxrefv70_utf8 v7 WHERE cd_nom = '$cd_nom' 
		UNION ALL SELECT 'v6' as version $select1[$num] FROM refnat.taxrefv60_utf8 v6 WHERE cd_nom = '$cd_nom' 
		UNION ALL SELECT 'v5' as version $select1[$num] FROM refnat.taxrefv50_utf8 v5 WHERE cd_nom = '$cd_nom' 
		UNION ALL SELECT 'v4' as version $select2[$num] FROM refnat.taxrefv40_utf8 v4 WHERE cd_nom = '$cd_nom' 
		UNION ALL SELECT 'v3' as version $select3[$num] FROM refnat.taxrefv30_utf8 v3 WHERE cd_nom = '$cd_nom'
		UNION ALL SELECT 'v2' as version $select4[$num] FROM refnat.taxrefv20_utf8 v2 WHERE cd_nom = '$cd_nom') 
		as analyse_cd_nom ORDER BY version ASC";

		$result=pg_query ($db,$requete) or die ("Erreur pgSQL : ".$requete);
		$entete=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
		// var_dump($entete);
		
		if (!empty($entete))
			{
			
			/*Tableau*/
			echo ("<table width=\"1200\"><tr align=center style=\"border-bottom:1pt solid #D0C5AA;\"><td><h1>$num</h1></td></tr></table>");
			echo ("<table width=\"1200\"><tr valign=center style=\"border-bottom:3pt solid #D0C5AA;\">");
			/*entete de colonne*/
			foreach ($entete as $field => $val) echo ("<th style=\" text-align: center;	vertical-align: center;\">$field</th>");
			echo("</tr>");
			
			/*premiere ligne*/
			echo("<tr valign=top style=\"border-bottom:1pt solid #D0C5AA;\">");
			foreach ($entete as $field => $val)
				{
					echo ("<td  style=\"text-align: center;\">");
					if ($entete["version"] == "vRéseauCBN")
						{
						$field_inteface = $field;
						echo ("<input type=\"hidden\" id=\"version\" value=\"vRéseauCBN\" />");
						if ($field_inteface == 'version') {echo $val;} else {metaform_text ($field," no_lab $desc","","width:".$length."em; ",$field_inteface,sql_format_quote($val,'undo_text'));}
						} else {
						$field_inteface = $field."_taxref";
						echo $val;
						}					
					echo ("</td>");
				}
				$row_plus = $entete;
				echo("</tr>");
			
			/*reste du tableau*/
			while ($row = pg_fetch_assoc ($result))
				{
				// var_dump($row);
				echo("<tr valign=top style=\"border-bottom:1pt solid #D0C5AA;\">");
				foreach ($row as $field => $val)
					{
					$diff = (($row[$field] == $row_plus[$field]) OR ($field == 'version')) ? "" : "background-color:orange" ;	/*Gestion du changement*/
					
					echo ("<td  style=\"text-align: center; $diff\">");
					if ($row["version"] == "vRéseauCBN")
						{
						$field_inteface = $field;
						echo ("<input type=\"hidden\" id=\"version\" value=\"vRéseauCBN\" />");
						if ($field_inteface == 'version') {echo $row[$field];} else {metaform_text ($field," no_lab $desc","","width:".$length."em;$diff ",$field_inteface,sql_format_quote($row[$field],'undo_text'));}
						} else {
						$field_inteface = $field."_taxref";
						echo $row[$field];
						}
						echo ("</td>");
					}
					echo("</tr>");
				$row_plus = $row;
				}
			
			} else $flag = 1;
			
			echo("</table><br>");		
					
		}
	if ($flag == 1) echo ("Taxon non rattaché à TAXREF");
	echo ("</fieldset>");		


//------------------------------------------------------------------------------ EDIT fieldset3
        echo ("<div id=\"radio2\">");
		echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_5']."</LEGEND>");
			/*requete discussion*/
			$query= $query_discussion.$id.";";
			$discussion=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($query),false);
			if ($niveau < 64) echo ("<label class=\"preField_calc\">Discussion sur la fiche</label>"); else echo ("<label class=\"preField\">Discussion sur la fiche</label>");
			if ($niveau < 64) echo ("<textarea name=\"commentaire_eval\" $disa style=\"width:100em;background-color: #EFEFEF;\" rows=\"4\" ></textarea><br><br>");
			else echo ("<textarea name=\"commentaire_eval\" style=\"width:100em;\" rows=\"4\" ></textarea><br><br>");
			echo "<table>";
			while ($val = pg_fetch_row($discussion)) {
				echo "<tr valign=top style=\"border-bottom:1pt solid #D0C5AA;\">";
				if (empty($val)) echo "<td>Pas de commentaire à ce jour</td>";
				else echo "<td style=\"padding-right: 10px\";>$val[0] :</td><td>".sql_format_quote($val[1],'undo_hmtl')."</td>";
				echo "</tr>";
				}
			echo "</table>";
		echo ("</fieldset>");
        echo ("</div>");

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

//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>

