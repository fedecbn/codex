<script type="text/javascript">
//fonction qui permet de ne faire apparaitre le bouton enregistrer que si un CBN a été choisi (permet la construction de l'identifiant unique)
$(document).ready(function() { 
	// on cache le bouton par défaut 
    $('#enregistrer1-add-button').hide();
	$('#enregistrer2-add-button').hide();

     
    $('select[name="idTerritoire"]').change(function() { // lorsqu'on change de valeur dans la liste du menu déroulant
    var valeur = $(this).val(); // valeur sélectionnée
     
        if(valeur != '') { // si non vide
            if(valeur != 'NI_4') { // si différent de "non indiqué"
				// on montre le bouton
                $('#enregistrer1-add-button').show();
				$('#enregistrer2-add-button').show();
            } else {
				// on cache le bouton
                $('#enregistrer1-add-button').hide();   
				$('#enregistrer2-add-button').hide();   				
            }
        }
    });
 
});

</script>

<script type="text/javascript">
	function concatenatenomcomplet () {
		var nom = $("#nomSyntaxon");
		var pr = nom.val();
		nom.removeClass("error");
        document.getElementById('nomCompletSyntaxon').value=pr;
		return (true);
	}
	
$("#nomCompletSyntaxon").keyup (concatenatenomcomplet);
</script>





<?php
echo ("<div id=\"$id_page\" >");
echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
echo ("<div id=\"fiche\" >");
echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");

echo ("<div style=\"float:left;\">");
	echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['add_fiche']."</font>");
echo ("</div>");
echo ("<div style=\"float:right;\">");
	echo ("<button id=\"enregistrer1-add-button\">".$lang[$lang_select]['enregistrer']." </button> ");
	echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
echo ("</div><br><br>");

echo ("<br><br>");

echo ("<div id=\"radio2\">"); 
echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
/*------------------------------------------------------------------------------ AJOUT Fiche */
/*------------------------------------------------------------------------------ EDIT fieldset1*/
	/*------------------------------------------------------------------------------ EDIT fieldset1*/
echo ("<fieldset><LEGEND>CBN</LEGEND>");
				echo ("<br>");
				echo '<script>concatenatenomcomplet();</script>';
				//metaform_bool_appared ("Importer un seul fichier ",null,$onchange,null,"lonely_file","f");
				metaform_sel ("CBN (auteur principal)*","",30,$ref['liste_cbn'],"idTerritoire","", pg_fetch_result(pg_query ($db,$query_description."'idTerritoire'".";"),0,"description" ));
				metaform_sel ("Présence sur le territoire d'agrément du CBN","",30,$ref[$champ_ref["statutChorologie"]],"statutChorologie","", pg_fetch_result(pg_query ($db,$query_description."'statutChorologie'".";"),0,"description" ));
				//metaform_sel ("Catalogue","",30,$ref[$champ_ref["idCatalogue"]],"idCatalogue",'', pg_fetch_result(pg_query ($db,$query_description."'idCatalogue'".";"),0,"description" ));
				echo ("</fieldset>");

echo ("<fieldset><LEGEND>Syntaxonomie</LEGEND>");
//				metaform_text ("<b>Code de l'enregistrement*</b>"," ",30,"width:30em;","codeEnregistrementSyntax",sql_format_quote(pg_result($result,0,"\"codeEnregistrementSyntax\"" ),'undo_text'), pg_fetch_result(pg_query ($db,$query_description."'codeEnregistrementSyntax'".";"),0,"description" ));
				echo ("<br>");
				metaform_text ("Identifiant du syntaxon"," ",30,"width:30em;","idSyntaxon",'', pg_fetch_result(pg_query ($db,$query_description."'idSyntaxon'".";"),0,"description" ));		
				metaform_text ("Nom scientifique","",30,"width:30em;","nomSyntaxon",'', pg_fetch_result(pg_query ($db,$query_description."'nomSyntaxon'".";"),0,"description" ));
				metaform_text ("Auteur","",30,"width:30em;","auteurSyntaxon",'', pg_fetch_result(pg_query ($db,$query_description."'auteurSyntaxon'".";"),0,"description" ));
				metaform_text ("Nom complet","",30,"width:30em;","nomCompletSyntaxon",'', pg_fetch_result(pg_query ($db,$query_description."'nomCompletSyntaxon'".";"),0,"description" ));

				//				metaform_text ("Nom complet du syntaxon"," ",30,"width:30em;","nomCompletSyntaxon",pg_result($result,0,"\"nomCompletSyntaxon\""), pg_fetch_result(pg_query ($db,$query_description."'nomCompletSyntaxon'".";"),0,"description" ));
				metaform_sel ("Rang syntaxon","","",$ref[$champ_ref["rangSyntaxon"]],"rangSyntaxon",'', pg_fetch_result(pg_query ($db,$query_description."'rangSyntaxon'".";"),0,"description" ));
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