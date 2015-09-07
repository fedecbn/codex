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

<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/gestion.js"></script>
<script type="text/javascript" language="javascript" src="js/liste.js"></script>
<script type="text/javascript" language="javascript" src="js/autocomp.js"></script>

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
                    echo ("<button id=\"to-refnat\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
					echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau >= 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
                if ($niveau >= 512) 
                    echo ("<button id=\"maj-from-taxa-button\"> ".$lang[$lang_select]['maj_taxa']."</button>&nbsp;&nbsp;");        
			echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_new ($id_page,true,true);			
			// aff_table ($id_page."-liste",true,true);			
		echo ("</div>");
/*------------------------------------------------------------------------------ #fiche*/
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
            // aff_table ($id_page."-liste",true,true);
        echo ("</div>");    }
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
/*Région*/
$query_modif = "SELECT id_reg, nom_reg, type_statut, id_statut, nom_statut
  FROM catnat.statut_reg WHERE uid = ".$id; 
$result_modif=pg_query ($db,$query_modif) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_modif),false);
while ($row = pg_fetch_assoc($result_modif))
		$res_stt[$row['type_statut']][$row['id_reg']] = $row['id_statut'];

/*National*/
$query_france = "SELECT 
cd_indi, lr, rarete, presence,
CASE WHEN endemisme = true THEN 1 WHEN endemisme = false THEN 2 ELSE 0 END as endemisme, 
indi_cal, lr_cal, rarete_cal, presence_cal,
CASE WHEN endemisme_cal = 'oui' THEN 1 WHEN endemisme_cal = 'non' THEN 2 ELSE 0 END as endemisme_cal,
indi_lr, lr_lr
FROM catnat.statut_nat
LEFT JOIN referentiels.indigenat ON indi = lib_indi WHERE uid = ".$id; 
$result_france=pg_query ($db,$query_france) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_modif),false);
while ($row = pg_fetch_assoc($result_france))	{
		/*Statuts nationaux*/
		$res_stt_fr['INDI'] = $row['cd_indi'];
		$res_stt_fr['LR'] = $row['lr'];
		$res_stt_fr['RAR'] = $row['rarete'];
		if ($row['endemisme'] == 1) {$res_stt_fr['END'] = 'oui';} elseif ($row['endemisme'] == 2) {$res_stt_fr['END'] = 'non';} else {$res_stt_fr['END'] = '';} 
		$res_stt_fr['PRES'] = $row['presence'];
		/*Statuts régionaux*/
		$res_stt_fr_cal['INDI'] = $row['indi_cal'];
		$res_stt_fr_cal['LR'] = $row['lr_cal'];
		$res_stt_fr_cal['RAR'] = $row['rarete_cal'];
		if ($row['endemisme_cal'] == 1) {$res_stt_fr_cal['END'] = 'oui';} elseif ($row['endemisme_cal'] == 2) {$res_stt_fr_cal['END'] = 'non';} else {$res_stt_fr_cal['END'] = '';} 
		$res_stt_fr_cal['PRES'] = $row['presence_cal'];
		/*Statuts from rubrique LR*/
		$res_stt_fr_lr['INDI'] = $row['indi_lr'];
		$res_stt_fr_lr['LR'] = $row['lr_lr'];
		$res_stt_fr_lr['RAR'] = 'RAS';
		if ($row['endemisme_lr'] == 't') {$res_stt_fr_lr['END'] = 'oui';} elseif ($row['endemisme_lr'] == 'f') {$res_stt_fr_lr['END'] = 'non';} else {$res_stt_fr_lr['END'] = '';} 
		$res_stt_fr_lr['PRES'] = 'RAS';
		}


$liste_statut['INDI'] = $ref['indigenat'];
/*var_dump($res_stt_fr);*/
$liste_statut['LR'] = $ref['categorie_final'];
// $liste_statut['END'] = array('','oui','non');
// $liste_statut['PRES'] = array('','oui','non');
$liste_statut['END'] = array(''=>'','oui'=>'oui','non'=>'non');
$liste_statut['PRES'] = array(''=>'','Pr'=>'Pr','Nr'=>'Nr','Ab'=>'Ab','E'=>'E','D'=>'D');


/*Gestion des niveau de droit*/
if ($niveau <= 64) $desc = " bloque"; else $desc = null;
if ($niveau <= 64) $disa = "disabled"; else $disa = null;

/*------------------------------------------------------------------------------ EDIT catnat EN TETE*/
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

/*------------------------------------------------------------------------------ EDIT catnat GRP1*/
		echo ("<div id=\"radio2\">");    
        echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_lr_1']."</LEGEND>");
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 800px;\">");
					metaform_text ("Nom scientifique"," bloque",100,"","nom_sci",sql_format_quote(pg_result($result,0,"nom_sci"),'undo_text'));
					metaform_text ("Nom vernaculaire"," bloque",100,"","nom_vern",sql_format_quote(pg_result($result,0,"nom_vern"),'undo_text'));
					metaform_bout ("Taxon hybride?"," bloque","","hybride",pg_result($result,0,"hybride"));
				echo ("</td><td style=\"width:300px;\">");	
					metaform_text ("Code REF."," bloque",8,"","cd_ref",sql_format_quote(pg_result($result,0,"cd_ref"),'undo_text'));
					metaform_sel ("Rang"," bloque","",$ref[$champ_ref['cd_rang']],"cd_rang",pg_result($result,0,"cd_rang"));
				echo ("</td><td>");	
					if ($niveau >= 128)
						echo ("<a href = \"../refnat/index.php?m=edit&id=$id\" class=edit id=\"modif_taxon\" ><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Refnat\" ></a>"); 
				echo ("</td></tr></table>");
			echo ("<br><label class=\"preField\">Commentaires sur le taxon</label><textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".sql_format_quote(pg_result($result,0,"commentaire"),'undo_hmtl')."</textarea><br><br>");
			echo ("</fieldset>");
			echo ("</div>"); 
/*------------------------------------------------------------------------------ EDIT catnat GRP2*/
       echo ("<div id=\"radio2\">");
       echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_catnat_2']."</LEGEND>");
            /*----------------*/
			/*Statuts Nationaux*/
			/*----------------*/
			echo ("<table border=1 width=\"300\">");
			echo ("<th></th>");
			/*en-tête*/
			echo ("<th style=\" text-align: center;	vertical-align: center;\">National</th>");
			echo ("<th style=\" text-align: center;	vertical-align: center;\">National (calculé)</th>");
			echo ("<th style=\" text-align: center;	vertical-align: center;\">National (Expertise Liste Rouge)</th>");
			/*valeurs*/
			foreach ($ref['statut'] as $type_stt => $lib_stt)	{
				echo ("<tr valign=top>");
				echo ("<td style=\" text-align: center;	vertical-align: center;\">$lib_stt</td>");
				/*Statut national*/
				echo ("<td>");
				if ($type_stt == 'RAR') {metaform_text (""," no_lab $desc","","width:5.5em;",$type_stt,sql_format_quote($res_stt_fr[$type_stt],'undo_text'));}
				else {metaform_sel (""," no_lab $desc","width:5em;",$liste_statut[$type_stt],$type_stt,$res_stt_fr[$type_stt]);}
				echo ("</td>");
				/*Statut ,ational Calculé*/
				echo ("<td>");
				if ($type_stt == 'RAR' OR $type_stt == 'INDI') {metaform_text (""," no_lab bloque","","width:5.5em;",$type_stt,sql_format_quote($res_stt_fr_cal[$type_stt],'undo_text'));}
				else {metaform_sel (""," no_lab bloque","width:5em;",$liste_statut[$type_stt],$type_stt,$res_stt_fr_cal[$type_stt]);}
				echo ("</td>");
				/*Statut national expert déterminé dans la rubrique Liste rouge*/
				echo ("<td>");
				if ($type_stt == 'INDI' OR $type_stt == 'PRES' OR $type_stt == 'RAR') {metaform_text (""," no_lab bloque","","width:5.5em;",$type_stt,sql_format_quote($res_stt_fr_lr[$type_stt],'undo_text'));}
				else {metaform_sel (""," no_lab bloque","width:5em;",$liste_statut[$type_stt],$type_stt,$res_stt_fr_lr[$type_stt]);}
				echo ("</td>");
				echo("</tr>");
				}
			echo("</table><br>");
			
			/*----------------*/
			/*Status régionaux*/
			/*----------------*/
			echo ("<table border=1 width=\"1200\">");
			echo ("<th style=\"width:5em;\"></th>");			
			/*en-tête*/
			foreach ($ref['region'] as $id_reg => $region)	{
					echo ("<th style=\" text-align: center;	vertical-align: center; width:5em;\">$region</th>");
					}
			/*valeurs*/
			foreach ($ref['statut'] as $type_stt => $lib_stt)	{
				echo ("<tr valign=top>");	
				echo ("<td style=\" text-align: center;	vertical-align: center;\">$lib_stt</td>");
				foreach ($ref['region'] as $id_reg => $region)	{
					if (empty($res_stt[$type_stt][$id_reg])) {
						echo ("<td>");
						if ($type_stt == 'RAR') {metaform_text ("Rar"," no_lab bloque","","width:5.5em;","rar","");}
						else {metaform_sel (""," no_lab bloque","width:5em;",$liste_statut[$type_stt],$type_stt."_".$id_reg,"");}
						echo ("</td>");
					} else {
						echo ("<td>");
						if ($type_stt == 'RAR') {metaform_text ("Rar"," no_lab bloque","","width:5.5em;","rar",sql_format_quote($res_stt[$type_stt][$id_reg],'undo_text'));}
						else {metaform_sel (""," no_lab bloque","width:5em;",$liste_statut[$type_stt],$type_stt."_".$id_reg,$res_stt[$type_stt][$id_reg]);}
						echo ("</td>");
						}
					}
				echo ("</tr>");
				}
			echo("</table><br>");
        echo ("</fieldset>");
        echo ("</div>");		
/*------------------------------------------------------------------------------ EDIT catnat GRP3*/
        echo ("<div id=\"radio2\">");
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_catnat_3']."</LEGEND>");
		
		$path = "../../_GRAPH/carte/";
		foreach ($ref['statut'] as $type_stt => $lib_stt)	{
			/*Récupération des fichiers existants*/
			$stt = strtolower($type_stt);
			$stt_path = $path.$stt;
			if (file_exists($stt_path))
				{
				$files = scandir($stt_path);
				foreach ($files as $key => $val){
					if(strpos($val,'thumb')) {
						$res = explode('_',$val);
						$cd_ref = explode('.',$res[3]);
						$coor_carte[$stt][$cd_ref[0]] = $val;
						}
					}
				$id_ref = pg_result($result,0,"cd_ref");
				// /*var_dump($coor_carte['lr']);*/
				$carte = $coor_carte[$stt][$id_ref];
				$path_carte = $path.$stt."/".str_replace('_thumb','',$carte);
				$path_carte_thumb = $path.$stt."/".$carte;
				}
			if ($carte != '')	{
				echo ("<a href=\"$path_carte\"><img src=\"$path_carte_thumb\" alt=\"Pas de carte disponible\"></a>");
			} else {
				echo ("<table><tr><td>Pas de carte $type_stt  pour ce taxon</td></tr></table>");
			}
		} 
        echo ("</fieldset>");
        echo ("</div>");
		
//------------------------------------------------------------------------------ EDIT LR GRP4
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

/* ------------------------------------------------------------------------------ EDIT catnat SAVE*/
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
        // echo ("</div>");

        echo ("<div id=\"exit-confirm\" title=\"Retour\">");
            echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>".$lang[$lang_select]['retour_dialog']."</p>");
        echo ("</div>");

        echo ("<div id=\"enregistrer-dialog\">");
            echo ("<center><img src=\"../../_GRAPH/check.png\"  /><br>".$lang[$lang_select]['enregistrer_dialog']."</center>");
        echo ("</div>");
    }
    break;

	case "maj"	: {
/*------------------------------------------------------------------------------ EDIT catnat EN TETE*/
	echo ("<div id=\"$id_page\" >");
	echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
	echo ("<div style=\"float:right;\">");
		echo ("<button id=\"retour3-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
	echo ("</div>");
	
	echo ("<div id=\"maj\" >");
		/*connexion au si_flore_national_v3 pour récupérer le taxa*/
		$db2=sql_connect_admin (SQL_taxa);
		if (!$db2) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);
		$result = pg_query ($db2,$recup_taxa) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		if ($result != FALSE) echo ("<BR>- Taxa exporté"); else echo ("Problème d'export");
		pg_free_result ($result);
		
		/*Application du nouveau taxa*/
		$db=sql_connect_admin (SQL_base);
		if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);
		$result = pg_query ($db,$import_taxa) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		if ($result != FALSE) echo ("<BR>- Taxa importé"); else echo ("Problème d'import");
		pg_free_result ($result);
		
		$result = pg_query ($db,$maj_from_taxa) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		if ($result != FALSE) echo ("<BR>- CATNAT mis à jour"); else echo ("Problème d'export");
		pg_free_result ($result);

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

