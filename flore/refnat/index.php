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
/*Tailles des cases*/
$etude = array (
0 => 13,
1 => 12,
2=> 4
);
	
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
                if ($niveau > 64) 
                    echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
                echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau == 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			
			/*Table des données*/
			aff_table_new ($id_page,true,true);			
		echo ("</div>");
//------------------------------------------------------------------------------ #deuxieme onglet (DROIT)
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
                // if ($niveau == 255) 
                    // echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_new ("droit",false,true);			
        echo ("</div>");
    }
    break;

/*------------------------------------------------------------------------------ #CAS AJOUT D'UNE FICHE */
	case "add" : {
/*------------------------------------------------------------------------------ #Onglet 1*/
echo ("<div id=\"$id_page\" >");
echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
echo ("<div id=\"fiche\" >");
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
	echo ("<fieldset><LEGEND>Rubrique</LEGEND>");
			metaform_bool ("Rub. CATNAT","","catnat","f");
			metaform_bool ("Rub. Liste rouge","","liste_rouge","f");
			metaform_bool ("Rub Liste EEE","","eee","f");
	echo ("</fieldset>");

	/*------------------------------------------------------------------------------ EDIT fieldset2*/
	/*Requete référentiels*/
	$flag = 0;

	
	/*Nomenclature*/
	$select_fcbn[0] = "'' as cd_nom,'' as  cd_ref,'' as  lb_nom,'' as  lb_auteur,'' as  nom_complet,'' as  nom_valide,'' as  nom_vern,'' as  nom_vern_eng";
	
	/*Taxonomie*/
	$select_fcbn[1] = "'' as  cd_taxsup,'' as  rang,'' as  regne,'' as  phylum,'' as  classe,'' as  ordre,'' as  famille";
	
	/*Répartition*/
	$select_fcbn[2] = "'' as  fr,'' as  gf,'' as  mar,'' as  gua,'' as  sm,'' as  sb,'' as  spm,'' as  may,'' as  epa,'' as  reu,'' as  taaf,'' as  pf,'' as  nc,'' as  wf,'' as  cli,'' as  habitat";

	echo ("<fieldset><LEGEND>Correspondance avec TAXREF</LEGEND>");
	foreach ($etude as $num => $length)
		{
		$requete = "SELECT $select_fcbn[$num] FROM refnat.taxons v8 LIMIT 1";
		// echo "<BR>$requete";
		$result=pg_query ($db,$requete) or die ("Erreur pgSQL : ".$requete);
		$entete=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
		
			/*Tableau Nomenclature*/
			echo ("<table border=1 width=\"1200\"><tr valign=center >");
			/*entete de colonne*/
			foreach ($entete as $field => $val) echo ("<th style=\" text-align: center;	vertical-align: center;\">$field</th>");
			echo("</tr>");
			echo("<tr>");
			/*premiere ligne*/
			foreach ($entete as $field => $val)
				{
					echo ("<td style=\"text-align: center;\">");
					$field_inteface = $field;
					metaform_text ($field,"no_lab","","style=\"width:".$length."em;\" ",$field_inteface,$val);
					echo ("</td>");
				}
				$row_plus = $entete;
				echo("</tr>");
			
			echo("</table><br>");					
		}
	echo ("</fieldset>");		

/*------------------------------------------------------------------------------ EDIT fieldset3*/
	echo ("<fieldset><LEGEND>Informations supplémentaires</LEGEND>");
			metaform_bool ("Hybride","","hybride","f");
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
if ($niveau <= 64) $desc = "bloque";
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
				echo ("<BR>");
				metaform_bool ("Rubrique Liste rouge",$desc,"liste_rouge",pg_result($result,0,"liste_rouge"));
				echo ("<BR>");
				metaform_bool ("Rubrique Liste EEE",$desc,"eee",pg_result($result,0,"eee"));
				echo ("<BR>");
			echo("</td><td valign=\"top\">");
				echo ("Informations supplémentaires sur le taxon : <BR>");
				metaform_bout ("Hybride",$desc,"hybride",$hybride);
				echo ("</td></tr></table>");
		echo ("</fieldset>");
		
	/*------------------------------------------------------------------------------ EDIT fieldset2*/
	/*Requete référentiels*/
	$cd_nom = pg_result($result,0,"cd_nom");
	$hybride = pg_result($result,0,"hybride");
	$flag = 0;
	
	/*Nomenclature*/
	$select_fcbn[0] = $select1[0] = $select2[0] = $select3[0] = $select4[0] = " ,cd_nom::text, cd_ref::text, lb_nom, lb_auteur, nom_complet, nom_valide, nom_vern, nom_vern_eng";
	
	/*Taxonomie*/
	$select_fcbn[1] = $select1[1] = $select2[1] = $select3[1] =", cd_taxsup::text, rang, regne, phylum, classe, ordre, famille";
	$select4[1] = ", '-' as cd_taxsup, rang, regne, phylum, classe, ordre, famille";
	
	/*Répartition*/
	$select_fcbn[2] = $select1[2] = $select2[2] = ", fr, gf, mar, gua, sm, sb, spm, may, epa, reu, taaf, pf, nc, wf, cli, habitat::text";
	$select3[2] = ", fr, gf, mar, gua, smsb as sm, smsb as sb, spm, may, epa, reu, taaf, pf, nc, wf, cli, habitat";
	// $select4[2] = ", fr, 'non prévu dans cette version' as gf, mar, gua, smsb as sm, smsb as sb, spm, may, 'non prévu dans cette version' as habitat,'non prévu dans cette version' as epa, reu, taaf, 'non prévu dans cette version' as pf, 'non prévu dans cette version' as nc, 'non prévu dans cette version' as wf, 'non prévu dans cette version' as cli";
	$select4[2] = ", fr, '-' as gf, mar, gua, smsb as sm, smsb as sb, spm, may, '-' as habitat,'-' as epa, reu, taaf, '-' as pf, '-' as nc, '-' as wf, '-' as cli";

	
	
	echo ("<fieldset><LEGEND>Correspondance avec TAXREF</LEGEND>");
	foreach ($etude as $num => $length)
		{
		$requete = "SELECT * FROM (SELECT 'vRéseauCBN' as version $select_fcbn[$num] FROM refnat.taxons v8 WHERE uid = '$id'	UNION ALL SELECT 'v8' as version $select1[$num] FROM refnat.taxrefv80_utf8 v8 WHERE cd_nom = '$cd_nom'	UNION ALL SELECT 'v7' as version $select1[$num] FROM refnat.taxrefv70_utf8 v7 WHERE cd_nom = '$cd_nom' UNION ALL SELECT 'v6' as version $select1[$num] FROM refnat.taxrefv60_utf8 v6 WHERE cd_nom = '$cd_nom' UNION ALL SELECT 'v5' as version $select1[$num] FROM refnat.taxrefv50_utf8 v5 WHERE cd_nom = '$cd_nom' UNION ALL SELECT 'v4' as version $select2[$num] FROM refnat.taxrefv40_utf8 v4 WHERE cd_nom = '$cd_nom' UNION ALL SELECT 'v3' as version $select3[$num] FROM refnat.taxrefv30_utf8 v3 WHERE cd_nom = '$cd_nom' UNION ALL SELECT 'v2' as version $select4[$num] FROM refnat.taxrefv20_utf8 v2 WHERE cd_nom = '$cd_nom') as analyse_cd_nom ORDER BY version ASC";

		$result=pg_query ($db,$requete) or die ("Erreur pgSQL : ".$requete);
		$entete=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
		// var_dump($entete);
		
		if (!empty($entete))
			{
			
			/*Tableau Nomenclature*/
			echo ("<table width=\"1200\"><tr valign=center style=\"border-bottom:1pt solid #D0C5AA;\">");
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
						if ($field_inteface == 'version') {echo $val;} else {metaform_text ($field," no_lab bloque","","style=\"width:".$length."em;\" ",$field_inteface,$val);}
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
						if ($field_inteface == 'version') {echo $row[$field];} else {metaform_text ($field," no_lab bloque","","style=\"width:".$length."em;$diff\" ",$field_inteface,$row[$field]);}
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

//------------------------------------------------------------------------------ FONCTIONS

?>

