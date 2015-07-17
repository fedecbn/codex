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
                // if ($niveau == 255) 
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
        echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
        echo ("<input type=\"hidden\" name=\"uid\" id=\"uid\" value=\"".pg_result($result,0,"uid")."\">");
		echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_catnat_1']."</LEGEND>");
				echo ("<label class=\"preField\">Code REF.</label>
				<input type=\"text\" name=\"cd_ref\" id=\"cd_ref\" size=\"10\" disabled value=\"".pg_result($result,0,"cd_ref")."\" />  ");
                echo ("<label class=\"preField\">Nom scientifique</label>
				<input type=\"text\" name=\"nom_sci\" id=\"nom_sci\" style=\"width:30em;\" maxlength=\"250\" disabled value=\"".pg_result($result,0,"nom_sci")."\" />");
                metaform_sel ("Rang","","disabled",$rang,"cd_rang",pg_result($result,0,"cd_rang"));
                echo ("<br>");
                metaform_text ("Nom vernaculaire","","","disabled style=width:50em;","nom_verna",pg_result($result,0,"nom_vern"));
				echo ("<br><label class=\"preField\">Commentaires généraux</label>
				<textarea name=\"commentaire\" style=\"width:70em;\" rows=\"2\" >".pg_result($result,0,"commentaire")."</textarea><br><br>");		
				metaform_bout_new ("Taxon hybride?","","disabled","hybride",pg_result($result,0,"hybride"));
        echo ("</fieldset>");
/*------------------------------------------------------------------------------ EDIT catnat GRP2*/
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_catnat_2']."</LEGEND>");
            /*----------------*/
			/*Statuts Nationaux*/
			/*----------------*/
			echo ("<table border=1 width=\"300\">");
			echo ("<tr valign=center >");
			echo ("<th></th>");
			/*en-tête*/
			echo ("<th style=\" text-align: center;	vertical-align: center;\">National</th>");
			echo ("<th style=\" text-align: center;	vertical-align: center;\">National (calculé)</th>");
			echo ("<th style=\" text-align: center;	vertical-align: center;\">National (Expertise Liste Rouge)</th>");
			/*valeurs*/
			foreach ($ref['statut'] as $type_stt => $lib_stt)	{
				echo ("<tr valign=top>");
				echo ("<td style=\" text-align: center;	vertical-align: center;\">$lib_stt</td>");
				/*Statut NAT*/
				echo ("<td>");
				if ($type_stt == 'RAR') {metaform_text ("Rar","no_lab","","style=width:5em; disabled","rar",$res_stt_fr[$type_stt]);}
				else {metaform_sel ("","no_lab","style = \"width:60px;\"",$liste_statut[$type_stt],$type_stt,$res_stt_fr[$type_stt]);}
				echo ("</td>");
				/*Statut Nat Calculé*/
				echo ("<td>");
				if ($type_stt == 'RAR' OR $type_stt == 'INDI') {metaform_text ("Rar","no_lab","","style=width:5em; disabled","rar",$res_stt_fr_cal[$type_stt]);}
				else {metaform_sel ("","no_lab","disabled style = \"width:60px;\"",$liste_statut[$type_stt],$type_stt,$res_stt_fr_cal[$type_stt]);}
				echo ("</td>");
				/*Statut From Liste rouge*/
				echo ("<td>");
				if ($type_stt == 'INDI' OR $type_stt == 'PRES' OR $type_stt == 'RAR') {metaform_text ("Rar","no_lab","","style=width:5em; disabled","rar",$res_stt_fr_lr[$type_stt]);}
				else {metaform_sel ("","no_lab","disabled style = \"width:60px;\"",$liste_statut[$type_stt],$type_stt,$res_stt_fr_lr[$type_stt]);}
				echo ("</td>");
				}
			echo("</tr>");	
			echo("</table><br>");
			
			/*----------------*/
			/*Status régionaux*/
			/*----------------*/
			echo ("<table border=1 width=\"1200\">");
			echo ("<tr valign=center >");
			echo ("<th></th>");			
			/*en-tête*/
			foreach ($ref['region'] as $id_reg => $region)	{
					echo ("<th style=\" text-align: center;	vertical-align: center;\">$region</th>");
					}
			/*valeurs*/
			foreach ($ref['statut'] as $type_stt => $lib_stt)	{
				echo ("<tr valign=top>");	
				echo ("<td style=\" text-align: center;	vertical-align: center;\">$lib_stt</td>");
				foreach ($ref['region'] as $id_reg => $region)	{
					if (empty($res_stt[$type_stt][$id_reg])) {
						echo ("<td>");
						if ($type_stt == 'RAR') {metaform_text ("Rar","no_lab","","style=width:5em; disabled","rar","");}
						else {metaform_sel ("","no_lab","style = \"width:60px;\"",$liste_statut[$type_stt],$type_stt."_".$id_reg,"");}
						echo ("</td>");
					} else {
						echo ("<td>");
						if ($type_stt == 'RAR') {metaform_text ("Rar","no_lab","","style=width:5em; disabled","rar",$res_stt[$type_stt][$id_reg]);}
						else {metaform_sel ("","no_lab","style = \"width:60px;\"",$liste_statut[$type_stt],$type_stt."_".$id_reg,$res_stt[$type_stt][$id_reg]);}
						echo ("</td>");
						}
					}
				}
			echo("</tr>");
			echo("</table><br>");
        echo ("</fieldset>");
		
/*------------------------------------------------------------------------------ EDIT catnat GRP3*/
        echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_catnat_3']."</LEGEND>");
		
		$path = "../../_GRAPH/carte/";
		foreach ($ref['statut'] as $type_stt => $lib_stt)	{
			/*Récupération des fichiers existants*/
			$stt = strtolower($type_stt);
			$files = scandir("../../_GRAPH/carte/$stt");
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
			if ($carte != '')	{
				echo ("<a href=\"$path_carte\"><img src=\"$path_carte_thumb\" alt=\"Pas de carte disponible\"></a>");
			} else {
				echo ("<table><tr><td>Pas de carte $type_stt  pour ce taxon</td></tr></table>");
			}
		} 
        echo ("</fieldset>");
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

