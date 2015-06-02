<?php
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
$rang= array(''=>'','ES'=>'ES','SSES'=>'SSES','VAR'=>'VAR','SVAR'=>'SVAR','FO'=>'FO','SSFO'=>'SSFO','CAR'=>'CAR');

echo ("<fieldset><LEGEND>Taxonomie</LEGEND>");
		metaform_text ("Code NOM.","","","style=width:10em;","cd_nom","");
		metaform_text ("Famille","","","style=width:30em;","famille","");
		metaform_text ("Nom scientifique","","","style=width:30em;","nom_complet","");
		metaform_text ("Nom(s) vernaculaire(s)","","","style=width:51em;","nom_vern","");
		metaform_sel ("Rang","","",$rang,"rang","");
		metaform_bout ("Taxon hybride?","","hybride","");
echo ("</fieldset>");

echo ("<fieldset><LEGEND>Rubrique</LEGEND>");
		metaform_bool ("Rub. CATNAT","","catnat","f");
		metaform_bool ("Rub. Liste rouge","","liste_rouge","f");
		metaform_bool ("Rub Liste EEE","","eee","f");
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
?>
