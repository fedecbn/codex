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

//------------------------------------------------------------------------------ JAVASCRIPT
$descColumns = descColumns($id_page);
$filterColumns = filterColumns($id_page);	
echo ('<input type=\'hidden\' name=\'descColumns\' id=\'descColumns\' value=\''.$descColumns.'\'/>');
echo ('<input type=\'hidden\' name=\'filterColumns\' id=\'filterColumns\' value=\''.$filterColumns.'\'/>');


//------------------------------------------------------------------------------ PARMS.
$mode = isset($_GET['m']) ? $_GET['m'] : "liste";
if (isset($_GET['o']) & !empty($_GET['o'])) $o=$_GET['o'];
if (isset($_GET['id'])) $title.= "- ".$_GET['id']; else $title.= "- liste";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ($id_page);
// $ref['etape'] = array(0 =>"",1=>"pré-eval",2=>"éval",3=>"post-éval");
// $ref['endemisme'] = array("" =>"",f=>"NON",t=>"<b>OUI</b>");

/*Droits*/
$typ_droit='d2';$rubrique=$id_page;$onglet = 'lr';
$droit = ref_droit($id_user,$typ_droit,$rubrique,$onglet);


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
/*------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS TABLEAU DE SYNTHESE */
/*------------------------------------------------------------------------------------------------------- */
    case "liste" : {
        echo ("<div id=\"".$id_page."\" >");
            /*Troisième bandeau*/
            echo ("<div id=\"titre2\">");
                echo ($lang[$lang_select]["liste_taxons"]);
            echo ("</div>");
            echo ("<input type=\"hidden\" id=\"export-TXT-fichier\" value=\"".$id_page."_".$id_user.".csv\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"$export_id\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />");
            echo ("<div style=\"float:right;\">");
                if ($droit['validate_fiche']) echo ("<button id=\"validate-button\"> ".$lang[$lang_select]['validate']."</button>&nbsp;&nbsp;");
                if ($droit['validate_fiche']) echo ("<button id=\"invalidate-button\"> ".$lang[$lang_select]['invalidate']."</button>&nbsp;&nbsp;");
                if ($droit['to-refnat']) echo ("<button id=\"to-refnat\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
				if ($droit['export_fiche']) echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($droit['del_fiche']) echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_next ("data",$id_page);			
            // aff_table ($id_page."-liste",true,true);
        echo ("</div>");
//------------------------------------------------------------------------------ #deuxieme onglet (DROIT)
        echo ("<div id=\"droit\" >");
            /*Troisième bandeau*/
            echo ("<div id=\"titre2\">");
                echo "Droit d'utilisation de la rubrique";
            echo ("</div>");
            echo ("<div style=\"float:right;\">");
                // if ($niveau >= 128)  echo ("<button id=\"to-refnat\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
				// if ($niveau >= 64)  echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                // if ($niveau >= 255)  echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_next ("user","droit");			
            // aff_table ($id_page."-liste",true,true);
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
		
        if (isset($_GET['id']) & !empty($_GET['id'])) {                         // Modifier
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            
			/*requete liste principale*/			
			$query= $query_module.$id.";";

            $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
            if (pg_num_rows ($result)) {
			
		if (pg_result($result,0,"etape") == null) {$etape = 1;}
			else {$etape =pg_result($result,0,"etape");}
		
		if (pg_result($result,0,"avancement") == null) {$avancement = 1;}
			else {$avancement =pg_result($result,0,"avancement");}

		if ($niveau <= 64 OR $avancement == 3) $desc = " bloque"; else $disa = $desc;
		if ($niveau <= 64 OR $avancement == 3) $disa = "disabled"; else $disa = null;
			
		$hybride = pg_result($result,0,"hybride");
		$exotique = pg_result($result,0,"id_indi");
		if ($hybride == 't' or $exotique == 3)		/*Gestion des hybrides et exotiques*/
			{$desc2 .= " bloque";} else	{$desc2 .= $desc;}

		
		echo ("<br><br>");

				
		echo ("<div style=\"float:left;\">");
            if ($droit['clore_version_fiche'] AND ($avancement == 1 OR $avancement == 2)) echo ("<button id=\"clore-version-button\" value=\"$id\" >".$lang[$lang_select]['clore-version']."</button> ");
            if ($droit['open_version_fiche'] AND $avancement == 3) echo ("<button id=\"open-version-button\" value=\"$id\">".$lang[$lang_select]['open-version']."</button> ");
            if ($droit['clore_etape_fiche']) echo ("<button id=\"clore-etape-button\" value=\"$id\">".$lang[$lang_select]['clore-etape']."</button> ");
			$font_size = "1.3em";
			echo "<span style=\"font-size:$font_size;\" >Phase : </span>";
			echo "<span class=\"avancement_$etape\" style=\"font-size:$font_size;\" >".$ref["etape"][$etape]." </span>";
			echo "<span class=\"avancement_$avancement\" style=\"font-size:$font_size;\" >".$ref["avancement"][$avancement]."</span>";
        echo ("</div>");
		
        echo ("<div style=\"float:right;\">");
            if ($droit['save_fiche'] AND ($avancement == 1 OR $avancement == 2)) echo ("<button id=\"enregistrer1-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
            if ($droit['retour_fiche']) echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
        echo ("</div>");

		echo ("<br><br>");
//------------------------------------------------------------------------------ EDIT LR GRP1
		echo ("<div id=\"radio3\">");    
        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_lr_1']."</LEGEND>");
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 800px;\">");
					metaform_text ("Nom scientifique"," bloque",100,"","nom_sci",pg_result($result,0,"nom_sci"));
					metaform_text ("Nom vernaculaire"," bloque",100,"","nom_vern",pg_result($result,0,"nom_vern"));
					metaform_bout ("Taxon hybride?"," bloque","hybride",pg_result($result,0,"hybride"));
				echo ("</td><td style=\"width:300px;\">");	
					metaform_text ("Code REF."," bloque",8,"","cd_ref",pg_result($result,0,"cd_ref"));
					metaform_sel ("Rang"," bloque","",$ref[$champ_ref['id_rang']],"id_rang",pg_result($result,0,"id_rang"));
				echo ("</td><td>");	
					if ($niveau >= 128)
						echo ("<a href = \"../refnat/index.php?m=edit&id=$id\" class=edit id=\"modif_taxon\" ><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Refnat\" ></a>"); 
				echo ("</td></tr></table>");
				if ($niveau <= 64) echo ("<label class=\"preField_calc\">Commentaires sur le taxon</label>"); else echo ("<label class=\"preField\">Commentaires sur le taxon</label>");
				if ($niveau <= 64) echo ("<textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"commentaire"),'undo')."</textarea><br><br>");
						else echo ("<textarea name=\"commentaire\" $disa style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"commentaire"),'undo')."</textarea><br><br>");
			// echo ("<br><label class=\"preField\">Commentaires sur le taxon</label><textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"commentaire"),'undo')."</textarea><br><br>");
			echo ("</fieldset>");
//------------------------------------------------------------------------------ EDIT LR GRP2 
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_2']."</LEGEND>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=33%>");
                echo ("<br>");
                metaform_sel ("Statut d'indigénat",$desc,"",$ref[$champ_ref['id_indi']],"id_indi",pg_result($result,0,"id_indi"));
                metaform_text ("Indigénat Synthèse régions"," bloque",8,"","indi_cal",pg_result($result,0,"indi_cal"));
                metaform_bout ("Endémique en métropole",$desc,"endemisme",pg_result($result,0,"endemisme"));
                metaform_bout ("Taxon en limite d'aire",$desc,"limite_aire",pg_result($result,0,"limite_aire"));
                metaform_bout ("Taxon en aire disjointe",$desc,"aire_disjointe",pg_result($result,0,"aire_disjointe"));
                metaform_bout ("Sous-observé en métropole",$desc,"sous_obs",pg_result($result,0,"sous_obs"));
            echo ("</td><td width=33%>");
                echo ("<br>");
                metaform_text ("AOO (1 km²) - calculé"," bloque",5,"","aoo1",pg_result($result,0,"aoo1"));
                metaform_text ("AOO (4 km²) - calculé"," bloque",5,"","aoo4",pg_result($result,0,"aoo4"));
                metaform_precis_plage ("AOO Expert",$desc,5,$ref[$champ_ref['id_aoo']],"aoo_precis","id_aoo",pg_result($result,0,"aoo_precis"),pg_result($result,0,"id_aoo"));
                metaform_precis_plage ("Nb de localités>=1990",$desc,5,$ref[$champ_ref['id_nbloc']],"nbloc_precis","id_nbloc",pg_result($result,0,"nbloc_precis"),pg_result($result,0,"id_nbloc"));
                metaform_bout ("Fragment Sév",$desc,"fragmt_sev",pg_result($result,0,"fragmt_sev"));
                metaform_bout ("Déclin cont AOO",$desc,"declin_cont_ii",pg_result($result,0,"declin_cont_ii"));
                metaform_bout ("Déclin cont Nb Loc",$desc,"declin_cont_iv",pg_result($result,0,"declin_cont_iv"));
                metaform_bout ("Fluct extrême AOO",$desc,"fluct_extrem_ii",pg_result($result,0,"fluct_extrem_ii"));
                metaform_bout ("Fluct extrême Nb Loc",$desc,"fluct_extrem_iv",pg_result($result,0,"fluct_extrem_iv"));
            echo ("</td><td width=33%>");
                echo ("<h4>Nombre de maille(s)</h4>");
                metaform_text (" >=1990 Expert",$desc,5,"","nbm5_post1990_est",pg_result($result,0,"nbm5_post1990_est"));
                metaform_text (" observé >=1990 - calculé"," bloque",5,"","nbm5_post1990",pg_result($result,0,"nbm5_post1990"));
                metaform_text (" observé >=2000 - calculé"," bloque",5,"","nbm5_post2000",pg_result($result,0,"nbm5_post2000"));
                metaform_text (" observé total - calculé"," bloque",5,"","nbm5_total",pg_result($result,0,"nbm5_total"));
                echo ("<h4>Nombre de commune(s)</h4>");
                metaform_text (" observé >=1990 - calculé"," bloque",5,"","nbcommune",pg_result($result,0,"nbcommune"));
            echo ("</td></tr></table><br>");
        echo ("</fieldset>");
//------------------------------------------------------------------------------ EDIT LR GRP3
		echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_3']."</LEGEND>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=33%>");
                echo ("<br>");
                metaform_precis_plage ("Nb Ind",$desc,5,$ref[$champ_ref['id_nbindiv']],"nbindiv_precis","id_nbindiv",pg_result($result,0,"nbindiv_precis"),pg_result($result,0,"id_nbindiv"));
                metaform_bout ("Pop Transfront",$desc,"pop_transfront",pg_result($result,0,"pop_transfront"));
                metaform_bout ("Immigration",$desc,"immigration",pg_result($result,0,"immigration"));
            echo ("</td><td width=33%>");
                echo ("<br>");
                metaform_precis_plage ("Réduction effectif",$desc,5,$ref[$champ_ref['id_reduc_eff']],"reduc_eff_precis","id_reduc_eff",pg_result($result,0,"reduc_eff_precis"),pg_result($result,0,"id_reduc_eff"));
                metaform_bout ("Déclin cont Nb sous Pop",$desc,"declin_cont_i",pg_result($result,0,"declin_cont_i"));
                metaform_bout ("Déclin cont Nb Ind",$desc,"declin_cont_v",pg_result($result,0,"declin_cont_v"));
                metaform_bout ("Déclin cont Habitat",$desc,"declin_cont_iii",pg_result($result,0,"declin_cont_iii"));
                metaform_sel ("Tendance Pop",$desc,"",$ref[$champ_ref['id_tendance_pop']],"id_tendance_pop",pg_result($result,0,"id_tendance_pop"));
            echo ("</td><td width=33%>");
                echo ("<br>");
                metaform_bout ("Fluct extrêm Nb sous Pop",$desc,"fluct_extrem_iii",pg_result($result,0,"fluct_extrem_iii"));
                metaform_bout ("Fluct extrêm Nb Ind",$desc,"fluct_extrem_v",pg_result($result,0,"fluct_extrem_v"));
            echo ("</td></tr></table><br>");
        echo ("</fieldset>");
//------------------------------------------------------------------------------ EDIT LR GRP4
		echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_4']."</LEGEND>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie A",$desc2,null,$ref[$champ_ref['cat_a']],"cat_a",pg_result($result,0,"cat_a"));
                metaform_text ("Justification du critère A",$desc2,10,null,"just_a",pg_result($result,0,"just_a"));
                metaform_sel ("Catégorie A1",$desc2,null,$ref[$champ_ref['cat_a1']],"cat_a1",pg_result($result,0,"cat_a1"));
                metaform_sel ("Justification du critère A1",$desc2,null,$ref[$champ_ref['crit_a1']],"crit_a1",pg_result($result,0,"crit_a1"));
                echo ("<br>");
                metaform_sel ("Catégorie A2, A3 ou A4",$desc2,null,$ref[$champ_ref['cat_a234']],"cat_a234",pg_result($result,0,"cat_a234"));
                metaform_sel ("Justification du critère A2",$desc2,null,$ref[$champ_ref['crit_a2']],"crit_a2",pg_result($result,0,"crit_a2"));
                metaform_sel ("Justification du critère A3",$desc2,null,$ref[$champ_ref['crit_a3']],"crit_a3",pg_result($result,0,"crit_a3"));
                metaform_sel ("Justification du critère A4",$desc2,null,$ref[$champ_ref['crit_a4']],"crit_a4",pg_result($result,0,"crit_a4"));
            echo ("</td><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie B2",$desc2,null,$ref[$champ_ref['cat_b']],"cat_b",pg_result($result,0,"cat_b"));
                metaform_text ("Justification du critère B2",$desc2,10,null,"just_b",pg_result($result,0,"just_b"));
            echo ("</td><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie C",$desc2,null,$ref[$champ_ref['cat_c']],"cat_c",pg_result($result,0,"cat_c"));
                metaform_text ("Justification du critère C",$desc2,10,null,"just_c",pg_result($result,0,"just_c"));
                metaform_sel ("Catégorie C1",$desc2,null,$ref[$champ_ref['cat_c1']],"cat_c1",pg_result($result,0,"cat_c1"));
                metaform_sel ("Justification du critère C1",$desc2,null,$ref[$champ_ref['crit_c1']],"crit_c1",pg_result($result,0,"crit_c1"));
                echo ("<br>");
                metaform_sel ("Catégorie C2",$desc2,null,$ref[$champ_ref['cat_c2']],"cat_c2",pg_result($result,0,"cat_c2"));
                metaform_sel ("Justification du critère C2",$desc2,null,$ref[$champ_ref['crit_c2']],"crit_c2",pg_result($result,0,"crit_c2"));
            echo ("</td><td width=290>");
                echo ("<br>");
                metaform_sel ("Catégorie D",$desc2,null,$ref[$champ_ref['cat_d']],"cat_d",pg_result($result,0,"cat_d"));
                metaform_text ("Justification du critère D",$desc2,10,null,"just_d",pg_result($result,0,"just_d"));
                echo ("<br>");
                metaform_sel ("Catégorie D1",$desc2,null,$ref[$champ_ref['cat_d1']],"cat_d1",pg_result($result,0,"cat_d1"));
                metaform_text ("Justification du critère D1",$desc2,10,null,"crit_d1",pg_result($result,0,"crit_d1"));
                echo ("<br>");
                metaform_sel ("Catégorie D2",$desc2,null,$ref[$champ_ref['cat_d2']],"cat_d2",pg_result($result,0,"cat_d2"));
                metaform_text ("Justification du critère D2",$desc2,26,null,"crit_d2",pg_result($result,0,"crit_d2"));
				metaform_bout ("Menace directe",$desc2,"menace",pg_result($result,0,"menace"));
            echo ("</td><td width=250>");
                echo ("<br>");
                metaform_sel ("Catégorie E",$desc2,null,$ref[$champ_ref['cat_e']],"cat_e",pg_result($result,0,"cat_e"));
                metaform_text ("Justification du critère E",$desc2,10,null,"just_e",pg_result($result,0,"just_e"));
            echo ("</td></tr></table>");
            echo ("<hr>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=250>");
                echo ("<br>");
				metaform_text ("Catégorie Préced"," bloque",10,"","cat_preced",$ref['categorie_final'][pg_result($result,0,"cat_preced")]);
                metaform_text ("Critère(s) Préced"," bloque",10,"","just_preced",pg_result($result,0,"just_preced"));
            echo ("</td><td width=250>");
                echo ("<br>");
               metaform_text ("Catégorie EU"," bloque",10,"","cat_euro",$ref['categorie_final'][pg_result($result,0,"cat_euro")]);
               metaform_text ("Critère(s) EU"," bloque",10,"","just_euro",pg_result($result,0,"just_euro"));
            echo ("</td><td width=100>");
				echo ("<br>");
	            metaform_text ("Cat synthèse régionale"," bloque",10,"","cat_synt_reg",$ref['categorie_final'][pg_result($result,0,"cat_synt_reg")]);
	            // metaform_text_calc ("Crit synthèse régionale","",10,"","just_synt_reg",$ref['categorie_final'][pg_result($result,0,"just_synt_reg")]);
				echo ("<label class=\"preField_calc\">Crit synthèse régionale</label><textarea name=\"just_synt_reg\" size=10 readonly disabled cols=\"50\" rows=\"1\" style=\"height: 27px;background-color:#EFEFEF\">".pg_result($result,0,"just_synt_reg")."</textarea><br><br>");
            echo ("</td><td width=100>");
				echo ("<br>");
	            metaform_text ("Nb région(s) taxon présent"," bloque",10,"","nb_reg_presence",pg_result($result,0,"nb_reg_presence"));
	            metaform_text ("Nb région(s) taxon évalué"," bloque",10,"","nb_reg_evalue",pg_result($result,0,"nb_reg_evalue"));
            echo ("</td></tr><tr valign=top ><td width=250>");
                metaform_sel ("<b>Catégorie initiale</b>",$desc2,null,$ref[$champ_ref['cat_ini']],"cat_ini",pg_result($result,0,"cat_ini"));
                metaform_text ("Critère(s) initiale",$desc2,10,null,"just_ini",pg_result($result,0,"just_ini"));
            echo ("</td><td width=250>");
                metaform_sel ("<b>Catégorie fin</b>",$desc2,null,$ref[$champ_ref['cat_fin']],"cat_fin",pg_result($result,0,"cat_fin"));
                metaform_text ("Critère(s) fin",$desc2,10,null,"just_fin",pg_result($result,0,"just_fin"));
            echo ("</td><td width=250>");
				if ($niveau <= 64) echo ("<label class=\"preField_calc\">Explication eval</label>"); else echo ("<label class=\"preField\">Explication eval</label>");
				if ($niveau <= 64) echo ("<textarea name=\"notes\" $disa style=\"width:30em;background-color: #EFEFEF;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"notes"),'undo')."</textarea><br><br>");
				else echo ("<textarea name=\"notes\" $disa style=\"width:30em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"notes"),'undo')."</textarea><br><br>");
            echo ("</td></tr></table><br>");
            echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=250>");
                metaform_sel ("Ajustement",$desc2,null,$ref[$champ_ref['cd_ajustmt']],"cd_ajustmt",pg_result($result,0,"cd_ajustmt"));
            echo ("</td><td width=250>");
                metaform_sel ("Changement de Catégorie",$desc2,null,$ref[$champ_ref['id_raison_ajust']],"id_raison_ajust",pg_result($result,0,"id_raison_ajust"));
            echo ("</td></tr></table><br>");
        echo ("</fieldset>");
//------------------------------------------------------------------------------ EDIT LR GRP5
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

/*------------------------------------------------------------------------------ #CAS VALIDATION */
case "validate" : {
include ("../commun/add_fiche.php");

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

