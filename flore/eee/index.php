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

<script type="text/javascript" language="javascript" src="js/commun.js"></script>

<?php

//------------------------------------------------------------------------------ MAIN
// html_header ("utf-8","table_eval.css","jquery-te-1.4.0.css");
html_header_2 ("utf-8","table_eval.css","jquery-te-1.4.0.css",$title);
//html_header ("utf-8","","");
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
            echo ("<input type=\"hidden\" id=\"export-TXT-fichier\" value=\"".$onglet["id"][0]."_".$id_user.".csv\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"$export_id\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />");
            echo ("<div style=\"float:right;\">");
                if ($droit['to-refnat']) echo ("<button id=\"to-refnat\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
				if ($droit['export_fiche']) echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($droit['del_fiche']) echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_next ("onglet0",$onglet["id"][0]);	
			// aff_table_new ($id_page,true,true);			
			// aff_table ($id_page."-liste",true,true);			
		echo ("</div>");
//------------------------------------------------------------------------------ #deuxieme onglet
        echo ("<div id=\"".$onglet["id"][1]."\" >");
            echo ("<div id=\"titre2\">".$onglet["sstitre"][1]."</div>");
            echo ("<div style=\"float:right;\">");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_next ("onglet1",$onglet["id"][1]);	
			// aff_table_new ("droit",false,true);			
        echo ("</div>");
//------------------------------------------------------------------------------ #troisieme onglet (DROIT)
        echo ("<div id=\"".$onglet["id"][2]."\" >");
            echo ("<div id=\"titre2\">".$onglet["sstitre"][2]."</div>");
            echo ("<div style=\"float:right;\">");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_next ("user",$onglet["id"][2]);	
			// aff_table_new ("droit",false,true);			
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
	case "eee_reg" : 
	case "edit" : {
//------------------------------------------------------------------------------ REF. EEE
	if ($mode == "eee_reg")
		{
		/*Question réponses et evaluation*/
		$query="SELECT t.uid, t.idq, lr.code_question, lr.libelle_court_reponse, lr.indicateur
		FROM eee.reponse_regional AS t 
		JOIN eee.liste_reponse lr ON lr.idq = t.idq
		WHERE t.uid = $id;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			$lib_reponse_edit[$row['code_question']][$row['idq']] = $row['libelle_court_reponse'];
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
		$query="SELECT t.uid, t.source, lr.coor_ids
		FROM eee.reponse_regional AS t 
		JOIN eee.liste_reponse lr ON lr.idq = t.idq
		WHERE t.uid = $id;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{
            $ids_result[$row['coor_ids']] = $row['source'];
			}
			pg_free_result ($result);
		}
	else
		{
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
		}
		
/*Gestion des niveau de droit*/
if ($niveau <= 64 OR $mode == 'eee_reg') $desc = " bloque"; else $desc = null;
if ($niveau <= 64 OR $mode == 'eee_reg') $disa = "disabled"; else $disa = null;

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
					metaform_bout ("Taxon hybride?"," bloque","hybride",pg_result($result,0,"hybride"));
				echo ("</td><td style=\"width:300px;\">");	
					metaform_text ("Code REF."," bloque",8,"","cd_ref",pg_result($result,0,"cd_ref"));
					metaform_sel ("Rang"," bloque","",$ref[$champ_ref['lib_rang']],"lib_rang",pg_result($result,0,"lib_rang"));
				echo ("</td><td>");	
					if ($niveau >= 128)
						echo ("<a href = \"../refnat/index.php?m=edit&id=$id\" class=edit id=\"modif_taxon\" ><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Refnat\" ></a>"); 
				echo ("</td></tr></table>");
			echo ("<br><label class=\"preField\">Commentaires sur le taxon</label><textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"commentaire"),'undo_html')."</textarea><br><br>");
			echo ("</fieldset>");
			echo ("</div>"); 
			

//------------------------------------------------------------------------------ EDIT EEE GRP2
$questionnaire = array(
			1 => array (
				"code" => "ag",
				"titre" => array(
					1=> "Correspondance climatique",
					2=> "Statut de l'espèce en Europe",
					3=> "Distribution en Europe",
					4=> "Répartition mondiale"
					)
				),
			2 => array (
				"code" => "bg",
				"titre" => array(
					5=> "viabilité des graines et reproduction",
					6=> "Croissance végétative",
					7=> "Mode dispersion",
					8=> "Type biologique"
					)
				),
			3 => array (
				"code" => "cg",
				"titre" => array(
					9=> "Mauvaise herbe agricole ailleurs",
					10=> "Taxonomie",
					11=> "Habitat de l'espèce",
					12=> "Densité de la population"
					)
				)
			);
			
foreach ($questionnaire as $ooo => $info)
	{
	echo ("<div id=\"radio2\">");
	echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_eee_'.$ooo]."</LEGEND>");
	if ($mode !='eee_reg') echo ("<table border=0 width=\"1200\">");
	
	
	echo ("<table border=0 width=\"1200\">");
		echo ("<tr valign=top>");
			echo ("<td><h3 style=\"margin-left:0px;margin-right:35px;\">Questions / Réponses</h3></td>");
			if ($mode !='eee_reg') echo ("<td><h3 style=\"margin-right:30px\">Argumentations</h3></td>");
			echo ("<td><h3 style=\"margin-right:30px\">Sources</h3></td>");
			echo ("<td><h3 style=\"margin-right:5px\">Fiabilité</h3></td></tr>");
	foreach ($info["titre"] as $key => $val) {
	// var_dump($lib_reponse[$info["code"].$key]);
	// var_dump($lib_reponse_edit[$info["code"].$key]);
		echo ("<tr valign=top >");
			echo("<td>");
			metaform_check ($val,$desc,null,$lib_reponse[$info["code"].$key],$info["code"].$key,$lib_reponse_edit[$info["code"].$key]);
			echo("</td><td>");
			if ($mode !='eee_reg') metaform_text_area (null," no_lab $desc","10","50","height:80px;",$ida[$key],sql_format_quote($ida_result[$key],'undo_html'));
			if ($mode !='eee_reg') echo("</td><td>");
			metaform_text_area (null," no_lab $desc","10","50","height:80px;",$ids[$key],sql_format_quote($ids_result[$key],'undo_html'));
			echo("</td><td>");
			metaform_bout_plus (null," no_lab $desc",$fiab[$key],$fiab_result[$key]);				
			echo("</td></tr>");
		}
	echo("</td></tr></table><br>");
	echo ("</fieldset>");
	echo ("</div>");
	}
			
//------------------------------------------------------------------------------ EDIT EEE GRP5
if ($mode != 'eee_reg')
	{
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
                metaform_text_area ("Argumentation"," no_lab $desc","10","50","height:133;",$ida[14],sql_format_quote($ida_result[14],'undo_html'));										
				echo ("<br>");
                metaform_text_area ("Argumentation"," no_lab $desc","10","50","height:133;",$ida[15],sql_format_quote($ida_result[15],'undo_html'));										
				echo ("<br>");
                metaform_text_area ("Argumentation"," no_lab $desc","10","50","height:133;",$ida[16],sql_format_quote($ida_result[16],'undo_html'));										
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
				metaform_text_area ("A l'issu de l'évaluation, le taxon est considéré de la manière suivante"," no_lab $desc","10","50","height:200;","eval_expert",sql_format_quote($eval_expert,'undo_html'));		
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

	}	
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
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 
?>

