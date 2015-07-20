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
$id=$_GET['id'];

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
//------------------------------------------------------------------------------ MAIN
html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");
//html_header ("utf-8","","");
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
                    echo ("<button id=\"to-refnat\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
                echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau == 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_new ($id_page,true,true);			
			// aff_table ($id_page."-liste",true,true);			
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
/*Ajouter L'autocomplétion*/
include ("../commun/add_fiche.php");
    }
    break;

/*--------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS MODIFICATION DE FICHE */
/*--------------------------------------------------------------------------------------------------------- */
	case "view" : 
	case "edit" : {
//------------------------------------------------------------------------------ REF. EEE

		/*Statut internationaux*/
		$query="SELECT idp, pays FROM eee.pays ORDER BY pays;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			$pays[$row["idp"]]=$row["pays"];
		pg_free_result ($result);
		foreach ($statut as $val_stat)
			{
			/*l'edit*/
			$query="SELECT p.idp, pays FROM eee.statut_inter si LEFT JOIN eee.pays p ON si.idp = p.idp WHERE uid = $id and statut = '$val_stat';";
			$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
			while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
				$pays_statut_edit[$val_stat][$row["idp"]]=$row["pays"];
			pg_free_result ($result);
			/*le reste*/
			if (empty($pays_statut_edit[$val_stat])) {$pays_statut_reste[$val_stat] = $pays;}
			else {$pays_statut_reste[$val_stat] = array_diff($pays,$pays_statut_edit[$val_stat]);}
			}

		/*Statut nationaux*/			
        $query="SELECT idr, region FROM eee.region r ORDER BY region;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $region[$row["idr"]]=$row["region"];
		pg_free_result ($result);
		foreach ($statut as $val_stat)
			{
			/*l'edit*/
			$query="SELECT r.idr, region FROM eee.region r JOIN eee.statut_natio sn ON sn.idr = r.idr WHERE uid = $id AND statut = '$val_stat';";
			$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
			while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
				$region_statut_edit[$val_stat][$row["idr"]]=$row["region"];
			pg_free_result ($result);
			/*le reste*/
			if (empty($region_statut_edit[$val_stat])) {$region_statut_reste[$val_stat] = $region;}
			else {$region_statut_reste[$val_stat] = array_diff($region,$region_statut_edit[$val_stat]);}
			}
		
		/*Question réponses et evaluation*/
		$query="SELECT t.uid, r.idq, r.zone, lr.code_question, lr.libelle_court_reponse, lr.indicateur
		FROM eee.taxons AS t 
		JOIN eee.reponse AS r ON t.uid = r.uid
		JOIN eee.liste_reponse lr ON lr.idq = r.idq
		WHERE t.uid= $id;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{
			$lib_reponse_edit[$row['code_question']][$row['idq']] = $row['libelle_court_reponse'];
			$eval_temp[$row['code_question']][$row['idq']] = $row['indicateur'];
			}
		pg_free_result ($result);
		
		/*Réponses*/
		$query="SELECT code_question
		FROM eee.liste_reponse;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        if (!is_null($eval_temp))
			{
			while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
				{
				if ($eval_temp[$row['code_question']] != null) $eval[$row['code_question']] = max($eval_temp[$row['code_question']]);		/*Récupèrer le maximum pour le critère évalué*/
				else $eval[$row['code_question']] = null;
				}
			$eval["ag"] = $eval["ag1"]+$eval["ag2"]+$eval["ag3"]+$eval["ag4"];
			$eval["bg"] = $eval["bg5"]+$eval["bg6"]+$eval["bg7"]+$eval["bg8"];
			$eval["cg"] = $eval["cg9"]+$eval["cg10"]+$eval["cg11"]+$eval["cg12"];
			$eval["tot"] = $eval["ag"]+$eval["bg"]+$eval["cg"];
			}
       
	   pg_free_result ($result);

        $query="SELECT code_question,idq, libelle_court_reponse FROM eee.liste_reponse ORDER BY code_question,code_eval;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            {
			$lib_reponse[$row['code_question']][$row['idq']] = $row['libelle_court_reponse'];
			if (!isset($lib_reponse_edit[$row['code_question']][$row['idq']])) {$lib_reponse_reste[$row['code_question']][$row['idq']] = $lib_reponse[$row['code_question']][$row['idq']];}
			}
        pg_free_result ($result);

		/*sources*/
		$query="SELECT uid,ids,contenu,fiabilite FROM eee.source WHERE uid= $id;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{
            $fiab_result[$row['ids']] = $row['fiabilite'];
            $ids_result[$row['ids']] = $row['contenu'];
			}
			pg_free_result ($result);

		$query="SELECT ids FROM ".SQL_schema_eee.".liste_source ORDER BY ids;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $ids[$row['ids']] = "ids".$row['ids'];
			// $fiab_result[$row['ids']] = isset($fiab_result[$row['ids']])?$fiab_result[$row['ids']]:0;
        pg_free_result ($result);

		
		/*Argumentaire*/
		$query="SELECT uid,ida,contenu FROM eee.argument WHERE uid= $id;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $ida_result[$row['ida']] = $row['contenu'];
        pg_free_result ($result);

        $query="SELECT ida FROM ".SQL_schema_eee.".liste_argument ORDER BY ida;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $ida[$row['ida']] = "ida".$row['ida'];
        pg_free_result ($result);

		/*Evaluation*/
		$query="SELECT liste_eval, carac_emerg, carac_avere, eval_expert FROM ".SQL_schema_eee.".evaluation WHERE uid= $id;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            {$liste_eval_base = $row['liste_eval'];
            $carac_emerg_base = $row['carac_emerg'];
            $carac_avere_base = $row['carac_avere'];			
            $eval_expert = $row['eval_expert'];}			
        pg_free_result ($result);

/*Gestion des niveau de droit*/
if ($niveau <= 64) $desc = " bloque"; else $desc = null;
if ($niveau <= 64) $disa = "disabled"; else $disa = null;

		
//------------------------------------------------------------------------------ EDIT EEE EN TETE
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
		if (isset($_GET['id']) & !empty($_GET['id'])) {                         // Modifier
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
		
//------------------------------------------------------------------------------ EDIT LR GRP1
		echo ("<div id=\"radio2\">");    
        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_lr_1']."</LEGEND>");
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 800px;\">");
					metaform_text ("Nom scientifique"," bloque",100,"","nom_sci",pg_result($result,0,"nom_sci"));
					metaform_text ("Nom vernaculaire"," bloque",100,"","nom_vern",pg_result($result,0,"nom_vern"));
					metaform_bout ("Taxon hybride?"," bloque","","hybride",pg_result($result,0,"hybride"));
				echo ("</td><td>");	
					metaform_text ("Code REF."," bloque",8,"","cd_ref",pg_result($result,0,"cd_ref"));
					metaform_sel ("Rang"," bloque","",$ref[$champ_ref['lib_rang']],"lib_rang",pg_result($result,0,"lib_rang"));
				echo ("</td><td>");	
					if ($niveau >= 128)
						echo ("<a href = \"../refnat/index.php?m=edit&id=$id\" class=edit id=\"modif_taxon\" ><img src=\"../../_GRAPH/mini/edit-icon.png\" title=\"Modifier\" ></a>"); 
				echo ("</td></tr></table>");
			echo ("<br><label class=\"preField\">Commentaires sur le taxon</label><textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"commentaire"),'undo')."</textarea><br><br>");
			echo ("</fieldset>");
			echo ("</div>"); 
//------------------------------------------------------------------------------ EDIT EEE GRP2
 		echo ("<div id=\"radio2\">");
		echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_eee_2']."</LEGEND>");
            echo ("<table border=0 width=\"1200\">");
			echo ("<tr valign=top>");
				echo ("<td><h3 style=\"width: 190px;margin-left:165px;margin-right:35px;\">Liste de choix</h3></td>");
				echo ("<td><h3 style=\"width: 190px;margin-right:25px\">Choix réalisés</h3></td><");
				echo ("<td><h3 style=\"width: 330px;margin-right:30px\">Sources</h3></td>");
				echo ("<td><h3 style=\"width: 100px;margin-right:5px\">Fiabilité</h3></td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Présence à l'internationale",$desc,5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.pays_pres, this.form.pays_pres_select);'",$pays_statut_reste['pres'],"pays_pres","");
 				echo("</td><td>");
                metaform_sel_multi ("Présence à l'internationale"," no_lab $desc",5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.pays_pres_select, this.form.pays_pres);'",$pays_statut_edit['pres'],"pays_pres_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Présence à l'internationale"," no_lab $desc","10","50","height:80px;",$ids[1],$ids_result[1]);
				echo("</td><td>");
                metaform_bout_plus ("Présence à l'internationale"," no_lab $desc",$fiab[1],$fiab_result[1]);	// mettre le bon ids?				
				echo("</td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Indigène à l'internationale",$desc,5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.pays_indi, this.form.pays_indi_select);'",$pays_statut_reste['indig'],"pays_indi","");
 				echo("</td><td>");
                metaform_sel_multi ("Indigène à l'internationale"," no_lab $desc",5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.pays_indi_select, this.form.pays_indi);'",$pays_statut_edit['indig'],"pays_indi_select","");echo ("<br>");
 				echo("</td><td>");
                metaform_text_area ("Indigène à l'internationale"," no_lab $desc","10","50","height:80px;",$ids[2],$ids_result[2]);
 				echo("</td><td>");
                metaform_bout_plus ("Indigène à l'internationale"," no_lab $desc",$fiab[2],$fiab_result[2]);				
 				echo("</td></tr>");
			// echo ("<tr valign=top >");
				// echo ("<td><h4>France</h4></td>");			  
				// echo ("<td><h4>les régions concernés</h4></td>");
				// echo ("<td><h4>Source</h4></td>");
				// echo ("<td><h4>Fiabilité</h4></td></tr>");			
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Présence en France",$desc,5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.reg_pres, this.form.reg_pres_select);'",$region_statut_reste['pres'],"reg_pres","");
                echo("</td><td>");
				metaform_sel_multi ("Présence en France"," no_lab $desc",5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.reg_pres_select, this.form.reg_pres);'",$region_statut_edit['pres'],"reg_pres_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Présence en France"," no_lab $desc","10","50","height:80px;",$ids[3],$ids_result[3]);
				echo("</td><td>");
				metaform_bout_plus ("Présence en France"," no_lab $desc",$fiab[3],$fiab_result[3]);		
				echo("</td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Indigène en France",$desc,5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.reg_indi, this.form.reg_indi_select);'",$region_statut_reste['indig'],"reg_indi","");
				echo("</td><td>");
                metaform_sel_multi ("Indigène en France"," no_lab $desc",5,"width: 190px;","OnDblClick='javascript: deplacer( this.form.reg_indi_select, this.form.reg_indi);'",$region_statut_edit['indig'],"reg_indi_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Indigène en France"," no_lab $desc","10","50","height:80px;",$ids[4],$ids_result[4]);
				echo("</td><td>");
                metaform_bout_plus ("Indigène en France"," no_lab $desc",$fiab[4],$fiab_result[4]);				
				echo("</td></tr></table><br>");
        echo ("</fieldset>");
		echo ("</div>");
//------------------------------------------------------------------------------ EDIT EEE GRP3
		echo ("<div id=\"radio2\">");
		echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_eee_3']."</LEGEND>");
            echo ("<table border=0 width=\"100%\">");
			echo ("<tr valign=top>");
				echo ("<td><h3 style=\"margin-left:165px;margin-right:35px;\">Liste de choix</h3></td>");
				echo ("<td><h3 style=\"margin-right:25px\">Choix réalisés</h3></td><");
				echo ("<td><h3 style=\"margin-right:30px\">Argumentations</h3></td>");
				echo ("<td><h3 style=\"margin-right:30px\">Sources</h3></td>");
				echo ("<td><h3 style=\"margin-right:5px\">Fiabilité</h3></td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Viabilité des graines et reproduction",$desc,5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.viab_graine, this.form.viab_graine_select);'",$lib_reponse_reste['bg5'],"viab_graine","");
 				echo("</td><td>");
                metaform_sel_multi ("Viabilité des graines et reproduction"," no_lab $desc",5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.viab_graine_select, this.form.viab_graine);'",$lib_reponse_edit['bg5'],"viab_graine_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Viabilité des graines et reproduction"," no_lab $desc","10","50","height:80px;",$ida[5],$ida_result[5]);
				echo("</td><td>");
                metaform_text_area ("Viabilité des graines et reproduction"," no_lab $desc","10","50","height:80px;",$ids[5],$ids_result[5]);
				echo("</td><td>");
                metaform_bout_plus ("Viabilité des graines et reproduction"," no_lab $desc",$fiab[5],$fiab_result[5]);	// mettre le bon ids?				
				echo("</td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Croissance végétative",$desc,6,"width: 250px;","OnDblClick='javascript: deplacer( this.form.croiss_veg, this.form.croiss_veg_select);'",$lib_reponse_reste['bg6'],"croiss_veg","");
 				echo("</td><td>");
                metaform_sel_multi ("Croissance végétative"," no_lab $desc",6,"width: 250px;","OnDblClick='javascript: deplacer( this.form.croiss_veg_select, this.form.croiss_veg);'",$lib_reponse_edit['bg6'],"croiss_veg_select","");echo ("<br>");
 				echo("</td><td>");
                metaform_text_area ("Croissance végétative"," no_lab $desc","10","50","height:80px;",$ida[6],$ida_result[6]);
				echo("</td><td>");
                metaform_text_area ("Croissance végétative"," no_lab $desc","10","50","height:80px;",$ids[6],$ids_result[6]);
 				echo("</td><td>");
                metaform_bout_plus ("Croissance végétative"," no_lab $desc",$fiab[6],$fiab_result[6]);				
 				echo("</td></tr>");	
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Mode dispersion",$desc,7,"width: 250px;","OnDblClick='javascript: deplacer( this.form.mod_disp, this.form.mod_disp_select);'",$lib_reponse_reste['bg7'],"mod_disp","");
                echo("</td><td>");
				metaform_sel_multi ("Mode dispersion"," no_lab $desc",7,"width: 250px;","OnDblClick='javascript: deplacer( this.form.mod_disp_select, this.form.mod_disp);'",$lib_reponse_edit['bg7'],"mod_disp_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Mode dispersion"," no_lab $desc","10","50","height:80px;",$ida[7],$ida_result[7]);
				echo("</td><td>");
                metaform_text_area ("Mode dispersion"," no_lab $desc","10","50","height:80px;",$ids[7],$ids_result[7]);
				echo("</td><td>");
				metaform_bout_plus ("Mode dispersion"," no_lab $desc",$fiab[7],$fiab_result[7]);		
				echo("</td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Type biologique",$desc,7,"width: 250px;","OnDblClick='javascript: deplacer( this.form.type_bio, this.form.type_bio_select);'",$lib_reponse_reste['bg8'],"type_bio","");
				echo("</td><td>");
                metaform_sel_multi ("Type biologique"," no_lab $desc",7,"width: 250px;","OnDblClick='javascript: deplacer( this.form.type_bio_select, this.form.type_bio);'",$lib_reponse_edit['bg8'],"type_bio_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Type biologique"," no_lab $desc","10","50","height:80px;",$ida[8],$ida_result[8]);
				echo("</td><td>");
                metaform_text_area ("Type biologique"," no_lab $desc","10","50","height:80px;",$ids[8],$ids_result[8]);
				echo("</td><td>");
                metaform_bout_plus ("Type biologique"," no_lab $desc",$fiab[8],$fiab_result[8]);				
				echo("</td></tr></table><br>");
        echo ("</fieldset>");
		echo ("</div>");

			//------------------------------------------------------------------------------ EDIT EEE GRP4
        echo ("<div id=\"radio2\">");
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_eee_4']."</LEGEND>");
            echo ("<table border=0 width=\"100%\">");
			echo ("<tr valign=top>");
				echo ("<td><h3 style=\"margin-left:165px;margin-right:35px;\">Liste de choix</h3></td>");
				echo ("<td><h3 style=\"margin-right:25px\">Choix réalisés</h3></td><");
				echo ("<td><h3 style=\"margin-right:30px\">Sources</h3></td>");
				echo ("<td><h3 style=\"margin-right:270px\">Fiabilité</h3></td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Statut \"invasive avérée\" à l'international",$desc,5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.st_nvav_inter, this.form.st_nvav_inter_select);'",$pays_statut_reste['invav'],"st_nvav_inter","");
 				echo("</td><td>");
                metaform_sel_multi ("Statut \"invasive avérée\" à l'international"," no_lab $desc",5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.st_nvav_inter_select, this.form.st_nvav_inter);'",$pays_statut_edit['invav'],"st_nvav_inter_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Statut \"invasive avérée\" à l'international"," no_lab $desc","10","50","height:80px;",$ids[9],$ids_result[9]);
				echo("</td><td>");
                metaform_bout_plus ("Statut \"invasive avérée\" à l'international"," no_lab $desc",$fiab[9],$fiab_result[9]);	// mettre le bon ids?				
				echo("</td></tr>");
			// echo ("<tr valign=top>");
				// echo ("<td><h4>France</h4></td>");			  
				// echo ("<td><h4>les régions concernés</h4></td>");
				// echo ("<td><h4>Sources</h4></td>");
				// echo ("<td><h4>Fiabilité</h4></td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Statut \"invasive avérée\" en France",$desc,5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.st_nvav_fr, this.form.st_nvav_fr_select);'",$region_statut_reste['invav'],"st_nvav_fr","");
 				echo("</td><td>");
                metaform_sel_multi ("Statut \"invasive avérée\" en France"," no_lab $desc",5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.st_nvav_fr_select, this.form.st_nvav_fr);'",$region_statut_edit['invav'],"st_nvav_fr_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Statut \"invasive avérée\" en France"," no_lab $desc","10","50","height:80px;",$ids[10],$ids_result[10]);
 				echo("</td><td>");
                metaform_bout_plus ("Statut \"invasive avérée\" en France"," no_lab $desc",$fiab[10],$fiab_result[10]);				
 				echo("</td></tr>");	
			echo ("<tr valign=top>");
				echo ("<td><h3 style=\"margin-left:165px;margin-right:35px;\">Liste de choix</h3></td>");
				echo ("<td><h3 style=\"margin-right:25px\">Choix réalisés</h3></td><");
				echo ("<td><h3 style=\"margin-right:30px\">Argumentations</h3></td>");
				echo ("<td><h3 style=\"margin-right:30px\">Sources</h3></td>");
				echo ("<td><h3 style=\"margin-right:5px\">Fiabilité</h3></td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Taxonomie",$desc,5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.taxo, this.form.taxo_select);'",$lib_reponse_reste['cg10'],"taxo","");
                echo("</td><td>");
				metaform_sel_multi ("Taxonomie"," no_lab $desc",5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.taxo_select, this.form.taxo);'",$lib_reponse_edit['cg10'],"taxo_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Taxonomie"," no_lab $desc","10","50","height:80px;",$ida[11],$ida_result[11]);
				echo("</td><td>");
                metaform_text_area ("Taxonomie"," no_lab $desc","10","50","height:80px;",$ids[11],$ids_result[11]);
				echo("</td><td>");
				metaform_bout_plus ("Taxonomie"," no_lab $desc",$fiab[11],$fiab_result[11]);		
				echo("</td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Habitat de l'espèce",$desc,5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.habt, this.form.habt_select);'",$lib_reponse_reste['cg11'],"habt","");
				echo("</td><td>");
                metaform_sel_multi ("Habitat de l'espèce"," no_lab $desc",5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.habt_select, this.form.habt);'",$lib_reponse_edit['cg11'],"habt_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Habitat de l'espèce"," no_lab $desc","10","50","height:80px;",$ida[12],$ida_result[12]);
				echo("</td><td>");
                metaform_text_area ("Habitat de l'espèce"," no_lab $desc","10","50","height:80px;",$ids[12],$ids_result[12]);
				echo("</td><td>");
                metaform_bout_plus ("Habitat de l'espèce"," no_lab $desc",$fiab[12],$fiab_result[12]);				
				echo("</td></tr>");
			echo ("<tr valign=top >");
				echo("<td>");
				metaform_sel_multi ("Densité de la population",$desc,5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.dens_pop, this.form.dens_pop_select);'",$lib_reponse_reste['cg12'],"dens_pop","");
				echo("</td><td>");
                metaform_sel_multi ("Densité de la population"," no_lab $desc",5,"width: 250px;","OnDblClick='javascript: deplacer( this.form.dens_pop_select, this.form.dens_pop);'",$lib_reponse_edit['cg12'],"dens_pop_select","");echo ("<br>");
				echo("</td><td>");
                metaform_text_area ("Densité de la population"," no_lab $desc","10","50","height:80px;",$ida[13],$ida_result[13]);
				echo("</td><td>");
                metaform_text_area ("Densité de la population"," no_lab $desc","10","50","height:80px;",$ids[13],$ids_result[13]);
				echo("</td><td>");
                metaform_bout_plus ("Densité de la population"," no_lab $desc",$fiab[13],$fiab_result[13]);				
				echo("</td></tr></table><br>");
        echo ("</fieldset>");
			echo ("</div>");
			
//------------------------------------------------------------------------------ EDIT EEE GRP5
        echo ("<div id=\"radio2\">");
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_eee_5']."</LEGEND>");
            echo ("<table border=0");
			echo ("<tr valign=top>");
				echo ("<td width = \"300\"><h3 style=\"margin-left:165px;margin-right:20px;\">Indicateurs</h3>");
				metaform_text ("Question A1"," bloque","15","","indct_a1",$eval["ag1"]); 				
				metaform_text ("Question A2"," bloque","15","","indct_a2",$eval["ag2"]); 				
				metaform_text ("Question A3"," bloque","15","","indct_a3",$eval["ag3"]);			
				metaform_text ("Question A4"," bloque","15","","indct_a4",$eval["ag4"]);				
				metaform_text ("Sous-total A"," bloque","15","","ss_tot_a",$eval["ag"]);
				echo ("<br>");				
				metaform_text ("Question B5"," bloque","15","","indct_b5",$eval["bg5"]); 				
				metaform_text ("Question B6"," bloque","15","","indct_b6",$eval["bg6"]); 				
				metaform_text ("Question B7"," bloque","15","","indct_b7",$eval["bg7"]); 				
				metaform_text ("Question B8"," bloque","15","","indct_b8",$eval["bg8"]); 				
				metaform_text ("Sous-total B"," bloque","15","","ss_tot_b",$eval["bg"]);
				echo ("<br>");								
				metaform_text ("Question C9"," bloque","15","","indct_c9",$eval["cg9"]); 				
				metaform_text ("Question C10"," bloque","15","","indct_c10",$eval["cg10"]); 				
				metaform_text ("Question C11"," bloque","15","","indct_c11",$eval["cg11"]); 				
				metaform_text ("Question C12"," bloque","15","","indct_c12",$eval["cg12"]); 				
				metaform_text ("Sous-total C"," bloque","15","","ss_tot_c",$eval["cg"]); 
				echo ("<br>");					
				metaform_text ("Total"," bloque","15","","tot_indct",$eval["ag"]+$eval["bg"]+$eval["cg"]); 				
				echo("</td><td width = \"150\" align=\"center\">");
				echo ("<h3 style=\"margin-left:25px;margin-right:25px;\">Risques</h3>");
					if ($eval["ag"] <=5){$eval_a = 'FAIBLE';} else {$eval_a = 'FORT';}
					metaform_text_area (""," no_lab bloque","10","50","height:133;width:100;resize:none;","eval_a",$eval_a);	
					echo ("<br>");	
					if ($eval["ag"] <=7){$eval_b = 'FAIBLE';} else {$eval_b = 'FORT';}
					metaform_text_area (""," no_lab bloque","10","50","height:133;width:100;resize:none;","eval_b",$eval_b);	
					echo ("<br>");	
					if ($eval["ag"] <=6){$eval_c = 'FAIBLE';} else {$eval_c = 'FORT';}
					metaform_text_area (""," no_lab bloque","10","50","height:133;width:100;resize:none;","eval_c",$eval_b);	
					echo ("<br>");	
					if ($eval["tot"] <=20){$eval_tot = 'FAIBLE';}elseif ($tot["ind_tot"] > 20 AND $tot["ind_tot"] <= 27){$eval_tot = 'INTERMEDIAIRE';}else{$eval_tot = 'FORT';}
				metaform_text_area (""," no_lab bloque","10","50","height:30;width:100;resize:none;","eval_tot",$eval_tot);																		
			echo("</td><td width = \"400\" align=\"center\">");
				echo ("<h3 style=\"margin-left:30px;margin-right:30px;\">Argumentation</h3>");
                metaform_text_area ("Argumentation"," no_lab $desc","10","50","height:133;",$ida[14],$ida_result[14]);										
				echo ("<br>");
                metaform_text_area ("Argumentation"," no_lab $desc","10","50","height:133;",$ida[15],$ida_result[15]);										
				echo ("<br>");
                metaform_text_area ("Argumentation"," no_lab $desc","10","50","height:133;",$ida[16],$ida_result[16]);										
				echo ("<br><br>
				<br>");									
			echo("</td><td width = \"400\" align=\"left\">");
				// echo ("<h3>Niveau de fiabilité de l'évaluation</h3>");
				// metaform_text_area (""," no_lab bloque","10","50","height:133;width:100;resize:none;","fiaba","");
				// echo ("<br>");
                // metaform_text_area (""," no_lab bloque","10","50","height:133;width:100;resize:none;","fiabb","");
				// echo ("<br>");
                // metaform_text_area (""," no_lab bloque","10","50","height:133;width:100;resize:none;","fiabc","");										
				// echo ("<br>");
                // metaform_text_area (""," no_lab","10","50","height:30;width:100;resize:none;","fiabtot","");
				echo ("<h3 style=\"margin-right:40px;\">Evaluation globale de l'espèce</h3>");
				echo ("A l'issu de l'évaluation, comment l'espèce est-elle considérée?");
				metaform_text_area ("A l'issu de l'évaluation, le taxon est considéré de la manière suivante"," no_lab $desc","10","50","height:200;","eval_expert",$eval_expert);		
				echo ("<h3 style=\"margin-right:40px\">Statuts de l'espèce</h3>");
				metaform_sel ("Le taxon appartient à la ",$desc,"",$liste_eval,"liste_eval",$liste_eval_base);
				echo ("<br>");
				metaform_sel ("Le taxon est",$desc,"",$carac_emerg,"carac_emerg",$carac_emerg_base);
				echo ("<br>");
				metaform_sel ("Caractère envahissant",$desc,"",$carac_avere,"carac_avere",$carac_avere_base);
				echo ("<br><br><br><br><br><br><br>");
			echo("</td></tr></table><br>");
		    echo ("</fieldset>");
			echo ("</div>");

//------------------------------------------------------------------------------ EDIT EEE GRP6
		/*
		echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_eee_6']."</LEGEND>");
			echo ("<table border=0");
			echo ("<tr valign=top>");
				echo ("<td width = \"300\"><h3 align=\"right\">Zone Atlantique</h3>");
					metaform_text ("Question A1","","15","readonly","indct_za_a1",""); 				
					metaform_text ("Question A2","","15","readonly","indct_za_a2",""); 				
					metaform_text ("Question A3","","15","readonly","indct_za_a3","");			
					metaform_text ("Question A4","","15","readonly","indct_za_a4","");				
					metaform_text ("Sous-total A","","15","readonly","ss_tot_za_a","");
					metaform_text ("Evaluation A","","15","readonly","eval_za_a","");	
					echo ("<br>");				
					metaform_text ("Question B5","","15","readonly","indct_za_b5",""); 				
					metaform_text ("Question B6","","15","readonly","indct_za_b6",""); 				
					metaform_text ("Question B7","","15","readonly","indct_za_b7",""); 				
					metaform_text ("Question B8","","15","readonly","indct_za_b8",""); 				
					metaform_text ("Sous-total B","","15","readonly","ss_tot_za_b","");
					metaform_text ("Evaluation B","","15","readonly","eval_za_b","");
					echo ("<br>");								
					metaform_text ("Question C9","","15","readonly","indct_za_c9",""); 				
					metaform_text ("Question C10","","15","readonly","indct_za_c10",""); 				
					metaform_text ("Question C11","","15","readonly","indct_za_c11",""); 				
					metaform_text ("Question C12","","15","readonly","indct_za_c12",""); 				
					metaform_text ("Sous-total C","","15","readonly","ss_tot_za_c",""); 
					metaform_text ("Evaluation C","","15","readonly","eval_za_c","");
					echo ("<br>");					
					metaform_text ("Total","","15","readonly","tot_za_indct",""); 				
					metaform_text ("Evaluation Total","","15","readonly","eval_za_tot","");
				echo("</td>");
				echo ("<td width = \"150\" align=\"center\"><h3>Zone continetale</h3>");
					metaform_text (""," no_lab","15","readonly","indct_zc_a1",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_a2",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_a3","");			
					metaform_text (""," no_lab","15","readonly","indct_zc_a4","");				
					metaform_text (""," no_lab","15","readonly","ss_tot_zc_a","");
					metaform_text (""," no_lab","15","readonly","eval_zc_a","");	
					echo ("<br>");				
					metaform_text (""," no_lab","15","readonly","indct_zc_b5",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_b6",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_b7",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_b8",""); 				
					metaform_text (""," no_lab","15","readonly","ss_tot_zc_b","");
					metaform_text (""," no_lab","15","readonly","eval_zc_b","");
					echo ("<br>");								
					metaform_text (""," no_lab","15","readonly","indct_zc_c9",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_c10",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_c11",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zc_c12",""); 				
					metaform_text (""," no_lab","15","readonly","ss_tot_zc_c",""); 
					metaform_text (""," no_lab","15","readonly","eval_zc_c","");
					echo ("<br>");					
					metaform_text (""," no_lab","15","readonly","tot_zc_indct",""); 	
					metaform_text (""," no_lab","15","readonly","eval_zc_tot","");				
				echo("</td>");
				echo ("<td width = \"200\" align=\"center\"><h3>Zone méditéranéenne</h3>");
					metaform_text (""," no_lab","15","readonly","indct_zm_a1",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_a2",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_a3","");			
					metaform_text (""," no_lab","15","readonly","indct_zm_a4","");				
					metaform_text (""," no_lab","15","readonly","ss_tot_zm_a","");
					metaform_text (""," no_lab","15","readonly","eval_zm_a","");
					echo ("<br>");				
					metaform_text (""," no_lab","15","readonly","indct_zm_b5",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_b6",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_b7",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_b8",""); 				
					metaform_text (""," no_lab","15","readonly","ss_tot_zm_b","");
					metaform_text (""," no_lab","15","readonly","eval_zm_b","");
					echo ("<br>");								
					metaform_text (""," no_lab","15","readonly","indct_zm_c9",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_c10",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_c11",""); 				
					metaform_text (""," no_lab","15","readonly","indct_zm_c12",""); 				
					metaform_text (""," no_lab","15","readonly","ss_tot_zm_c",""); 
					metaform_text (""," no_lab","15","readonly","eval_zm_c","");
					echo ("<br>");					
					metaform_text (""," no_lab","15","readonly","tot_zc_indct","");
					metaform_text (""," no_lab","15","readonly","eval_zm_tot","");				
				echo("</td><td width = \"400\" align=\"center\">");
					echo ("<h3>Argumentation</h3>");
					metaform_text_area (""," no_lab","10","50","style=\"height:163;\"",$ida[17],$ida_result[17]);										
					echo ("<br>");
					metaform_text_area (""," no_lab","10","50","style=\"height:163;\"",$ida[18],$ida_result[18]);										
					echo ("<br>");
					metaform_text_area (""," no_lab","10","50","style=\"height:163;\"",$ida[19],$ida_result[19]);										
					echo ("<br><br><br><br>");									
				echo("</td><td width = \"300\" align=\"center\">");
					echo ("<h3>Niveau de fiabilité de l'évaluation</h3>");
					metaform_text_area (""," no_lab","10","50","style=\"height:163;width:100;resize:none;\"","fiaba_zb","");
					echo ("<br>");
					metaform_text_area (""," no_lab","10","50","style=\"height:163;width:100;resize:none;\"","fiabb_zb","");
					echo ("<br>");
					metaform_text_area (""," no_lab","10","50","style=\"height:163;width:100;resize:none;\"","fiabc_zb","");										
					echo ("<br>");
					metaform_text_area (""," no_lab","10","50","style=\"height:30;width:100;resize:none;\"","fiabtot_zb","");
					echo ("<br>");						
				echo("</td></tr></table><br>");
		    echo ("</fieldset>");
        echo ("</div>");

		*/

//------------------------------------------------------------------------------ EDIT LR GRP6
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

