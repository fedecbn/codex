<?php
//------------------------------------------------------------------------------//
//  index.php                                                    //
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
//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($id_page);
// $ref['etape'] = array(0 =>"",1=>"pré-eval",2=>"éval",3=>"post-éval");
// $ref['endemisme'] = array("" =>"",f=>"NON",t=>"<b>OUI</b>");

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
                    echo ("<button id=\"to-refnat\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
				if ($niveau >= 64) 
					echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau == 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_new ($id_page,true,true);			
            // aff_table ($id_page."-liste",true,true);
        echo ("</div>");
//------------------------------------------------------------------------------ #fiche
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

	//------------------------------------------------------------------------------ EDIT LR
    case "view" : 
    case "edit" : {
//------------------------------------------------------------------------------ REF. LR
/*Récupération des référentiels ==> ref_champ ($table,$index,$valeur,$orderby)*/
// include ("./lr-ref.php");		
/*Gestion des niveau de droit*/

//------------------------------------------------------------------------------ EDIT LR EN TETE
        echo ("<div id=\"$id_page\" >");
        echo ("</div>");
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
        if (isset($_GET['id']) & !empty($_GET['id'])) {                         // Modifier
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            		
			$query= $query_module.$id.";";

            $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
            if (pg_num_rows ($result)) {
			$hybride = pg_result($result,0,"hybride");
			$exotique = pg_result($result,0,"id_indi");
			if ($hybride == 't' or $exotique == '3')		/*Gestion des hybrides et exotiques*/
			{$extra = "disabled";}
		else
			{$extra = "";}

		if (pg_result($result,0,"etape") == null) {$etape = 1;}
		else {$etape =pg_result($result,0,"etape");}
		
		
		
		
        echo ("<br>");
        echo ("<center>");
   	    echo ("<div id=\"radio1\">");                                         
            echo ("Etape 
                <input type=\"radio\" name=\"etape\" id=\"etape1\" value=\"1\" ".($etape==1 ? "checked=\"true\"" : "")."><label for=\"etape1\">Pré-évaluation</label>
                <input type=\"radio\" name=\"etape\" id=\"etape2\" value=\"2\" ".($etape==2 ? "checked=\"true\"" : "")."><label for=\"etape2\">Évaluation</label>
                <input type=\"radio\" name=\"etape\" id=\"etape3\" value=\"3\" ".($etape==3 ? "checked=\"true\"" : "")."><label for=\"etape3\">Post-évaluation</label><br>");
        echo ("</div>");
        echo ("</center>");
//------------------------------------------------------------------------------ EDIT LR GRP1
		echo ("<div id=\"radio2\">");    
        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_lr_1']."</LEGEND>");
				echo ("<table border=0 width=\"100%\"><tr valign=top ><td style=\"width: 800px;\">");
					echo ("<label class=\"preField\">Code REF.</label><input type=\"text\" disabled name=\"cd_ref\" id=\"cd_ref\" size=\"10\" value=\"".pg_result($result,0,"cd_ref")."\" />  ");
					echo ("<label class=\"preField\">Nom scientifique</label><input type=\"text\" disabled name=\"nom_sci\" id=\"nom_sci\" style=\"width:30em;\" maxlength=\"250\" value=\"".pg_result($result,0,"nom_sci")."\" />  ");
					echo ("</td><td>");					
                metaform_sel ("Rang","","disabled",$ref[$champ_ref['id_rang']],"id_rang",pg_result($result,0,"id_rang"));
				echo ("</td></tr><tr><td style=\"width: 800px;\">");
					echo ("<br>");
                metaform_text ("Nom vernaculaire","","","disabled style=width:50em;","nom_vern",pg_result($result,0,"nom_vern"));
				echo ("</td><td align=\"left\">");					
				echo ("<br>");
					metaform_bout_new ("Taxon hybride?","","disabled","hybride",pg_result($result,0,"hybride"));
				echo ("</td></tr></table>");
			echo ("</fieldset>");
			echo ("</div>"); 
//------------------------------------------------------------------------------ EDIT LR GRP2
   	    echo ("<div id=\"radio2\">");    
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_2']."</LEGEND>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=33%>");
                echo ("<br>");
                metaform_sel ("Statut d'indigénat","","",$ref[$champ_ref['id_indi']],"id_indi",pg_result($result,0,"id_indi"));
                metaform_text_calc ("Statut d'indigénat - calculé","",8,"","indi_cal",pg_result($result,0,"indi_cal"));
                metaform_bout ("Endémique en métropole","","endemisme",pg_result($result,0,"endemisme"));
                metaform_bout ("Taxon en limite d'aire","","limite_aire",pg_result($result,0,"limite_aire"));
                metaform_bout ("Taxon en aire disjointe","","aire_disjointe",pg_result($result,0,"aire_disjointe"));
                metaform_bout ("Sous-observé en métropole","","sous_obs",pg_result($result,0,"sous_obs"));
            echo ("</td><td width=33%>");
                echo ("<br>");
                metaform_text_calc ("AOO (1 km²) - calculé","",5,"","aoo1",pg_result($result,0,"aoo1"));
                metaform_text_calc ("AOO (4 km²) - calculé","",5,"","aoo4",pg_result($result,0,"aoo4"));
                metaform_precis_plage ("AOO Expert","",5,$ref[$champ_ref['id_aoo']],"aoo_precis","id_aoo",pg_result($result,0,"aoo_precis"),pg_result($result,0,"id_aoo"));
                metaform_precis_plage ("Nb de localités>=1990","",5,$ref[$champ_ref['id_nbloc']],"nbloc_precis","id_nbloc",pg_result($result,0,"nbloc_precis"),pg_result($result,0,"id_nbloc"));
                metaform_bout ("Fragment Sév","","fragmt_sev",pg_result($result,0,"fragmt_sev"));
                metaform_bout ("Déclin cont AOO","","declin_cont_ii",pg_result($result,0,"declin_cont_ii"));
                metaform_bout ("Déclin cont Nb Loc","","declin_cont_iv",pg_result($result,0,"declin_cont_iv"));
                metaform_bout ("Fluct extrême AOO","","fluct_extrem_ii",pg_result($result,0,"fluct_extrem_ii"));
                metaform_bout ("Fluct extrême Nb Loc","","fluct_extrem_iv",pg_result($result,0,"fluct_extrem_iv"));
            echo ("</td><td width=33%>");
                echo ("<h4>Nombre de maille(s)</h4>");
                metaform_text (" >=1990 Expert","",5,"","nbm5_post1990_est",pg_result($result,0,"nbm5_post1990_est"));
                metaform_text_calc (" observé >=1990 - calculé","",5,"","nbm5_post1990",pg_result($result,0,"nbm5_post1990"));
                metaform_text_calc (" observé >=2000 - calculé","",5,"","nbm5_post2000",pg_result($result,0,"nbm5_post2000"));
                metaform_text_calc (" observé total - calculé","",5,"","nbm5_total",pg_result($result,0,"nbm5_total"));
                echo ("<h4>Nombre de commune(s)</h4>");
                metaform_text_calc (" observé >=1990 - calculé","",5,"","nbcommune",pg_result($result,0,"nbcommune"));
            echo ("</td></tr></table><br>");
        echo ("</fieldset>");
//------------------------------------------------------------------------------ EDIT LR GRP3
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_3']."</LEGEND>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=33%>");
                echo ("<br>");
                metaform_precis_plage ("Nb Ind","",5,$ref[$champ_ref['id_nbindiv']],"nbindiv_precis","id_nbindiv",pg_result($result,0,"nbindiv_precis"),pg_result($result,0,"id_nbindiv"));
                metaform_bout ("Pop Transfront","","pop_transfront",pg_result($result,0,"pop_transfront"));
                metaform_bout ("Immigration","","immigration",pg_result($result,0,"immigration"));
            echo ("</td><td width=33%>");
                echo ("<br>");
                metaform_precis_plage ("Réduction effectif","",5,$ref[$champ_ref['id_reduc_eff']],"reduc_eff_precis","id_reduc_eff",pg_result($result,0,"reduc_eff_precis"),pg_result($result,0,"id_reduc_eff"));
                metaform_bout ("Déclin cont Nb sous Pop","","declin_cont_i",pg_result($result,0,"declin_cont_i"));
                metaform_bout ("Déclin cont Nb Ind","","declin_cont_v",pg_result($result,0,"declin_cont_v"));
                metaform_bout ("Déclin cont Habitat","","declin_cont_iii",pg_result($result,0,"declin_cont_iii"));
                metaform_sel ("Tendance Pop","","",$ref[$champ_ref['id_tendance_pop']],"id_tendance_pop",pg_result($result,0,"id_tendance_pop"));
            echo ("</td><td width=33%>");
                echo ("<br>");
                metaform_bout ("Fluct extrêm Nb sous Pop","","fluct_extrem_iii",pg_result($result,0,"fluct_extrem_iii"));
                metaform_bout ("Fluct extrêm Nb Ind","","fluct_extrem_v",pg_result($result,0,"fluct_extrem_v"));
            echo ("</td></tr></table><br>");
        echo ("</fieldset>");
//------------------------------------------------------------------------------ EDIT LR GRP4
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_4']."</LEGEND>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie A","",$extra,$ref[$champ_ref['cat_a']],"cat_a",pg_result($result,0,"cat_a"));
                metaform_text ("Justification du critère A","",10,$extra,"just_a",pg_result($result,0,"just_a"));
                metaform_sel ("Catégorie A1","",$extra,$ref[$champ_ref['cat_a1']],"cat_a1",pg_result($result,0,"cat_a1"));
                metaform_sel ("Justification du critère A1","",$extra,$ref[$champ_ref['crit_a1']],"crit_a1",pg_result($result,0,"crit_a1"));
                echo ("<br>");
                metaform_sel ("Catégorie A2, A3 ou A4","",$extra,$ref[$champ_ref['cat_a234']],"cat_a234",pg_result($result,0,"cat_a234"));
                metaform_sel ("Justification du critère A2","",$extra,$ref[$champ_ref['crit_a2']],"crit_a2",pg_result($result,0,"crit_a2"));
                metaform_sel ("Justification du critère A3","",$extra,$ref[$champ_ref['crit_a3']],"crit_a3",pg_result($result,0,"crit_a3"));
                metaform_sel ("Justification du critère A4","",$extra,$ref[$champ_ref['crit_a4']],"crit_a4",pg_result($result,0,"crit_a4"));
            echo ("</td><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie B2","",$extra,$ref[$champ_ref['cat_b']],"cat_b",pg_result($result,0,"cat_b"));
                metaform_text ("Justification du critère B2","",10,$extra,"just_b",pg_result($result,0,"just_b"));
            echo ("</td><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie C","",$extra,$ref[$champ_ref['cat_c']],"cat_c",pg_result($result,0,"cat_c"));
                metaform_text ("Justification du critère C","",10,$extra,"just_c",pg_result($result,0,"just_c"));
                metaform_sel ("Catégorie C1","",$extra,$ref[$champ_ref['cat_c1']],"cat_c1",pg_result($result,0,"cat_c1"));
                metaform_sel ("Justification du critère C1","",$extra,$ref[$champ_ref['crit_c1']],"crit_c1",pg_result($result,0,"crit_c1"));
                echo ("<br>");
                metaform_sel ("Catégorie C2","",$extra,$ref[$champ_ref['cat_c2']],"cat_c2",pg_result($result,0,"cat_c2"));
                metaform_sel ("Justification du critère C2","",$extra,$ref[$champ_ref['crit_c2']],"crit_c2",pg_result($result,0,"crit_c2"));
            echo ("</td><td width=290>");
                echo ("<br>");
                metaform_sel ("Catégorie D","",$extra,$ref[$champ_ref['cat_d']],"cat_d",pg_result($result,0,"cat_d"));
                metaform_text ("Justification du critère D","",10,$extra,"just_d",pg_result($result,0,"just_d"));
                echo ("<br>");
                metaform_sel ("Catégorie D1","",$extra,$ref[$champ_ref['cat_d1']],"cat_d1",pg_result($result,0,"cat_d1"));
                metaform_text ("Justification du critère D1","",10,$extra,"crit_d1",pg_result($result,0,"crit_d1"));
                echo ("<br>");
                metaform_sel ("Catégorie D2","",$extra,$ref[$champ_ref['cat_d2']],"cat_d2",pg_result($result,0,"cat_d2"));
                metaform_text ("Justification du critère D1","",26,$extra,"crit_d2",pg_result($result,0,"crit_d2"));
				metaform_bout ("Menace directe","","menace",pg_result($result,0,"menace"));
            echo ("</td><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie E","",$extra,$ref[$champ_ref['cat_e']],"cat_e",pg_result($result,0,"cat_e"));
                metaform_text ("Justification du critère E","",10,$extra,"just_e",pg_result($result,0,"just_e"));
            echo ("</td></tr></table>");
            echo ("<hr>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=250>");
                echo ("<br>");
               metaform_text_calc ("Catégorie Préced","",10,"","cat_preced",$ref['categorie_final'][pg_result($result,0,"cat_preced")]);
                metaform_text_calc ("Critère(s) Préced","",10,"","just_preced",pg_result($result,0,"just_preced"));
            echo ("</td><td width=250>");
                echo ("<br>");
               metaform_text_calc ("Catégorie EU","",10,"","cat_euro",$ref['categorie_final'][pg_result($result,0,"cat_euro")]);
                metaform_text_calc ("Critère(s) EU","",10,"","just_euro",pg_result($result,0,"just_euro"));
            echo ("</td><td width=100>");
				echo ("<br>");
	            metaform_text_calc ("Cat synthèse régionale","",10,"","cat_synt_reg",$ref['categorie_final'][pg_result($result,0,"cat_synt_reg")]);
	            // metaform_text_calc ("Crit synthèse régionale","",10,"","just_synt_reg",$ref['categorie_final'][pg_result($result,0,"just_synt_reg")]);
				echo ("<label class=\"preField_calc\">Crit synthèse régionale</label><textarea name=\"just_synt_reg\" size=10 readonly disabled cols=\"50\" rows=\"1\" style=\"height: 27px;background-color:#EFEFEF\">".pg_result($result,0,"just_synt_reg")."</textarea><br><br>");
            echo ("</td><td width=100>");
				echo ("<br>");
	            metaform_text_calc ("Nb région(s) taxon présent","",10,"","nb_reg_presence",pg_result($result,0,"nb_reg_presence"));
	            metaform_text_calc ("Nb région(s) taxon évalué","",10,"","nb_reg_evalue",pg_result($result,0,"nb_reg_evalue"));
            echo ("</td></tr><tr valign=top ><td width=250>");
                metaform_sel ("<b>Catégorie initiale</b>","",$extra,$ref[$champ_ref['cat_ini']],"cat_ini",pg_result($result,0,"cat_ini"));
                metaform_text ("Critère(s) initiale","",10,$extra,"just_ini",pg_result($result,0,"just_ini"));
            echo ("</td><td width=250>");
                metaform_sel ("<b>Catégorie fin</b>","",$extra,$ref[$champ_ref['cat_fin']],"cat_fin",pg_result($result,0,"cat_fin"));
                metaform_text ("Critère(s) fin","",10,$extra,"just_fin",pg_result($result,0,"just_fin"));
            echo ("</td></tr></table><br>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=250>");
                metaform_sel ("Ajustement","",$extra,$ref[$champ_ref['cd_ajustmt']],"cd_ajustmt",pg_result($result,0,"cd_ajustmt"));
            echo ("</td><td width=250>");
                metaform_sel ("Changement de Catégorie","",$extra,$ref[$champ_ref['id_raison_ajust']],"id_raison_ajust",pg_result($result,0,"id_raison_ajust"));
            echo ("</td></tr></table><br>");
            echo ("<label class=\"preField\">Notes</label><textarea name=\"notes\" style=\"width:60em;\" rows=\"2\" >".pg_result($result,0,"notes")."</textarea><br><br>");

            echo ("<center>");
                 echo ("<input type=\"radio\" name=\"valid\" id=\"valid1\" value=\"FALSE\" checked=\"true\" ".(pg_result($result,0,"valid")=="f" ? "checked=\"true\"" : "")." ><label for=\"valid1\">Evaluation non validée</label>
                <input type=\"radio\" name=\"valid\" id=\"valid2\" value=\"TRUE\" ".(pg_result($result,0,"valid")=="t" ? "checked=\"true\"" : "")." ><label for=\"valid2\">Evaluation validée</label><br>");
            echo ("</center>");

        echo ("</fieldset>");
        echo ("</div>");
//------------------------------------------------------------------------------ EDIT LR GRP FIN
                echo ("<br>");
                echo ("<div style=\"float:right;\">");
				if ($mode == "edit") {
					echo ("<button id=\"enregistrer2-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
                        echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
                    } else {
                        echo ("<button id=\"retour4-button\">".$lang[$lang_select]['retour']."</button> ");
                    }
                echo ("</div>");
                echo ("<br><label class=\"preField\">Commentaires</label><textarea name=\"commentaire\" style=\"width:60em;\" rows=\"2\" >".pg_result($result,0,"commentaire")."</textarea><br><br>");
                echo ("</form>");
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

