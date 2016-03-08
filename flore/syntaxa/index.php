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
$id="'".$_GET['id']."'";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
/*Cette fonction récupère toutes les référentiels utiles pour la page. Les référentiels sons stockés dans l'objet $ref*/
ref_colonne_et_valeur ($id_page);

//test DEBUG
//var_dump($ref[$champ_ref['periodeDebObsOptimale']]);
//var_dump($ref['liste_departement']);
//var_dump($ref[$champ_ref['liste_departement']]);
//var_dump($ref['st_geo_sigmafacies']);
//var_dump($ref);

//var_dump($ref[$champ_ref['liste_departement']]);
//var_dump($ref[$champ_ref['idRattachementPVF']]);
//var_dump($champ_ref['liste_region']);
//var_dump($ref);
//var_dump($ref[$champ_ref['typeSynonymie']]);
//$table = pg_fetch_array($result); var_dump($table);
//$colname = pg_field_name($result, 1);
//$colname="codeEnregistrementSyntax";echo $colname;
//$val= pg_fetch_result(pg_query ($db,$query_description."'$colname8'".";"),0,"description" ); echo $val;
//$val= pg_fetch_result(pg_query ($db,$query_description."'$colname1'".";"),0,"description" );echo $val;
//$val= pg_fetch_result($result,"\"codeEnregistrementSyntax\"" ); echo $val;

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
<script type="text/javascript" language="javascript" src="../../flore/syntaxa/js/function.js"></script>
<script type="text/javascript" language="javascript" src="js/liste.js"></script>
<script type="text/javascript" language="javascript" src="js/autocomp.js"></script>


<script type="text/javascript" language="javascript" >
$(document).ready(function(){
	$("#form1").validate({
		rules: {
			nomSyntaxon: {
				required: true,
                minlength: 2
			},
			auteurSyntaxon: {
				required: true,
                minlength: 2
			},
			
/*			niveau_fsd: {
				required: true,
                digits: true
			},
*/
		},
		messages: {
			nomSyntaxon: { required: "",	minlength: ""},
			auteurSyntaxon: { required: "L'auteur du syntaxon est obligatoire",	minlength: "La longueur minimale est de 2"},
/*			niveau: {
				required: "",
                digits: "Valeur numérique"
			}
*/
		}
	}); 
});
</script> 




<script type="text/javascript" language="javascript" src="js/commun.js"></script>

<?php

//-------------------------------------------------------------------------------- INIT CSS

 echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../flore/syntaxa/css/syntaxa.css\" />");
 
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
                if ($niveau >= 128) 
                    echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
                echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau >= 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			
			/*Table des données*/
			aff_table_new ($id_page,true,true);			
		echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
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

/*--------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS MODIFICATION DE FICHE */
/*--------------------------------------------------------------------------------------------------------- */
	case "view" : 
	case "edit" : {
/*------------------------------------------------------------------------------ REF. */


/*------------------------------------------------------------------------------ #Onglet 1*/
        echo ("<div id=\"$id_page\" >");
        echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
        echo ("<div id=\"fiche\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"edit\" action=\"\" >");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#2D8946 >".$lang[$lang_select]['edit_fiche']."</font>");
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
            $id="'".$_GET['id']."'";
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            		
			$query= $query_module.$id.";";
			//echo $query;
			$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
			$numrows = pg_numrows($result);
			//for($i = 0; $i < $numrows; $i++) { $row = pg_fetch_array($result, $i);echo $row["codeEnregistrementSyntax"];}			
			
			$query2= $query_module_biblio.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result2=pg_query($db,$query2) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result2),false);
			//for($i = 0; $i < $numrows; $i++) { $row = pg_fetch_array($result, $i);echo $row["codeEnregistrementSyntax"];}	
			
			$query3= $query_module_correspondance_pvf1.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result3=pg_query($db,$query3) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result3),false);
			
			$query4= $query_module_chorologie.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result4=pg_query($db,$query4) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result4),false);
			

			$query5= $query_module_correspondance_hic.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result5=pg_query($db,$query5) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result5),false);
			
			$query6= $query_module_correspondance_eunis.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result6=pg_query($db,$query6) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result6),false);

			

			// Loop through rows in the result set
			for($i = 0; $i < $numrows2; $i++) { $row = pg_fetch_array($result2, $i);echo $row["codeEnregistrement"];}
			

			
            if (pg_num_rows ($result)) {
			
			echo ("<br><br>");
				
			echo("<input type=\"hidden\" name=\"zone\" id=\"zone1\" value=\"gl\">");
			
			echo ("<div id=\"radio2\">"); 
			echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
			//echo ("<input type=\"hidden\" name=\"codeEnregistrementSyntax\" id=\"codeEnregistrementSyntax\" value=\"".pg_result($result,0,"codeEnregistrementSyntax")."\">");
	
	
	
	
	//------------------------------------------------------------------------------ EDIT fieldset1
	//----------Attention la fonction pg_fetch_result() is case sensitive donc faire attention aux noms de colonnes avec majuscule

					$colname1="codeEnregistrementSyntax";$colname2="nomSyntaxon";$colname3="idSyntaxon";$colname4="auteurSyntaxon";
					$colname5="nomCompletSyntaxon";$colname6="nomSyntaxonRaccourci";$colname7="rqNomenclaturale";$colname8="typeSynonymie";
					$colname9="nomSyntaxonRetenu";$colname10="idSyntaxonRetenu";$colname11="rangSyntaxon";
					$colname12="idSyntaxonSup";
					$colname13="nomFrancaisSyntaxon";$colname14="diagnoseCourteSyntaxon";$colname15="idCritique";$colname16="rqCritique";
					$colname17="libEtageVeg";

		/*	echo ("<table border=0 width=\"100%\">");
			echo ("<tr valign=top ><td width=50%>");*/
			echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=50%>");
//                    echo ("<fieldset style=\"width:670px;\" ><LEGEND> Habitat </LEGEND>");
            echo ("<fieldset ><LEGEND> Nomenclature </LEGEND>");				
				metaform_text ("<b>Code de l'enregistrement*</b>"," ",30,"width:30em;","codeEnregistrementSyntax",sql_format_quote(pg_result($result,0,"\"$colname1\"" ),'undo_text'), pg_fetch_result(pg_query ($db,$query_description."'$colname1'".";"),0,"description" ));
				echo ("<br>");
				metaform_text ("Identifiant du syntaxon"," bloque",30,"width:30em;","idSyntaxon",pg_result($result,0,"\"$colname3\""), pg_fetch_result(pg_query ($db,$query_description."'$colname3'".";"),0,"description" ));		
				metaform_text ("Identifiant du syntaxon retenu"," bloque",30,"width:30em;","idSyntaxonRetenu",pg_result($result,0,"\"$colname10\""), pg_fetch_result(pg_query ($db,$query_description."'$colname10'".";"),0,"description" ));							
				//metaform_text ("Code de l'enregistrement"," ",20,"<br>","codeEnregistrementSyntax",sql_format_quote(pg_result($result,0,"\"$colname1\"" ),'undo_text'));
				metaform_text ("Nom du syntaxon","",30,"width:30em;","nomSyntaxon",pg_result($result,0,"\"$colname2\""), pg_fetch_result(pg_query ($db,$query_description."'$colname2'".";"),0,"description" ));
				metaform_text ("Auteur du syntaxon","",30,"width:30em;","auteurSyntaxon",sql_format_quote(pg_result($result,0,"\"$colname4\"" ),'undo_text'), pg_fetch_result(pg_query ($db,$query_description."'$colname4'".";"),0,"description" ));
				metaform_text ("Nom complet du syntaxon"," bloque",30,"width:30em;","nomCompletSyntaxon",pg_result($result,0,"\"$colname5\""), pg_fetch_result(pg_query ($db,$query_description."'$colname5'".";"),0,"description" ));
				metaform_text ("Nom raccourcit"," bloque",30,"width:30em;","nomSyntaxonRaccourci",pg_result($result,0,"\"$colname6\""), pg_fetch_result(pg_query ($db,$query_description."'$colname6'".";"),0,"description" ));
				metaform_sel ("Type de synonymie","",30,$ref[$champ_ref['typeSynonymie']],"typeSynonymie",pg_result($result,0,"\"$colname8\""), pg_fetch_result(pg_query ($db,$query_description."'$colname8'".";"),0,"description" ));
				metaform_text ("Nom syntaxon retenu"," bloque",30,"width:30em;","nomSyntaxonRetenu",pg_result($result,0,"\"$colname9\""), pg_fetch_result(pg_query ($db,$query_description."'$colname9'".";"),0,"description" ));
				$tooltip=pg_fetch_result(pg_query ($db,$query_description."'$colname7'".";"),0,"description" );
				//style=\"width:70em;\"
				metaform_text_area ("Remarque nomenclaturale","",57,50,"","rqNomenclaturale",pg_result($result,0,"\"$colname7\""), pg_fetch_result(pg_query ($db,$query_description."'$colname7'".";"),0,"description" ));
				metaform_sel ("Rang syntaxon","","",$ref[$champ_ref[$colname11]],"rangSyntaxon",pg_result($result,0,"\"$colname11\""), pg_fetch_result(pg_query ($db,$query_description."'$colname11'".";"),0,"description" ));
				//metaform_text ("Nom syntaxon sup","",30,"width:30em;","nomSyntaxonSup",pg_result($result,0,"\"$colname9\""), pg_fetch_result(pg_query ($db,$query_description."'$colname9'".";"),0,"description" ));
				metaform_text ("Nom français","",30,"width:30em;","idSyntaxonSup",pg_result($result,0,"\"$colname13\""), pg_fetch_result(pg_query ($db,$query_description."'$colname13'".";"),0,"description" ));
				metaform_text_area ("Diagnose courte","",57,50,"","diagnoseCourteSyntaxon",pg_result($result,0,"\"$colname14\""), pg_fetch_result(pg_query ($db,$query_description."'$colname14'".";"),0,"description" ));
				metaform_sel ("Typicité","",30,$ref[$champ_ref['idCritique']],"idCritique",pg_result($result,0,"\"$colname15\""), pg_fetch_result(pg_query ($db,$query_description."'$colname15'".";"),0,"description" ));
				metaform_text ("Remarque typicité","",30,"width:30em;","rqCritiqueCritique",pg_result($result,0,"\"$colname16\""), pg_fetch_result(pg_query ($db,$query_description."'$colname16'".";"),0,"description" ));
				


            echo ("</fieldset>");
			
		/*------------------------------------------------------------------------------ EDIT fieldset2*/
			echo ("<fieldset  ><LEGEND> Bibliographie </LEGEND>");
                /*On utilise ici le résultat de la query_biblio (result2) pour avoir accès à la table st_biblio*/
/*		
					$colname1="idBiblio";$colname3="libPublication";$colname4="urlPublication";
					$colname5="codePublication";
	
			echo ("<fieldset><LEGEND>Bibliographie</LEGEND>");
*/				
/*			 
			 
				echo ("<table border=0 width=\"100%\"><tr valign=top >");
				echo ("<td style=\"width: 350px;\">");
				metaform_text ("Identifiant de la ressource","no_lab",20,"","codeEnregistrementSyntax",sql_format_quote(pg_result($result2,0,"\"$colname1\"" ),'undo_text'));
				echo ("</td><td>");
				metaform_text ("Libellé de la ressource"," no_lab",20,"","idSyntaxon",pg_result($result,0,"\"$colname2\""));
				echo ("</td><td>");		
				metaform_text ("url de la référence"," no_lab",20,"","idSyntaxonRetenu",pg_result($result,0,"\"$colname3\""));				
				echo ("</td></tr></table>");
				echo ("</fieldset>");
*/				
/*
			echo ("<tr valign=top ><td width=50%>");
			echo ("<fieldset><LEGEND>Bibliographie</LEGEND>");
				//echo("<div id=\"p_scents\">");
				//echo(" <p><TABLE BORDER=\"0\"> <caption align=\"left\"> Correspondance des habitats </caption> 
				//<tr valign=top ><th> Typologie </th> <th> Code habitat </th> </tr> 
				//<tr>
				//<th>  <label for=\"p_scnts\"><input type=\"text\" id=\"p_scnt_code\" size=\"20\" name=\"code\" value=\"\" placeholder=\"Valeur de l'input\" /> </label></th> 
				//<th>  <label for=\"p_scnts\"><input type=\"text\" id=\"p_scnt_typo\" size=\"20\" name=\"typo\" value=\"\" placeholder=\"Valeur de l''input\" /> </label></th> 
				//</tr> </TABLE></p> </div>");
				echo("<p colspan=\"4\" align=\"left\"><button type=\"button\" href=\"#\" id=\"addScnt\">Ajouter un habitat</button></p>");
				echo ("</fieldset>");
				echo ("</td>");
				echo ("<td width=50%>");
				echo ("<fieldset><LEGEND>Nomenclature3</LEGEND>");	
				metaform_text ("Nom du syntaxon","","30em","","nomSyntaxon",pg_result($result,0,"\"$colname2\""), pg_fetch_result(pg_query ($db,$query_description."'$colname2'".";"),0,"description" ));
				echo ("</fieldset>");
				echo ("</td></tr></table>");
	
*/	
	
            echo ("</fieldset>");
		/*------------------------------------------------------------------------------ EDIT fieldset3*/
            echo ("<fieldset><LEGEND> Fichier rattaché (photo numérique) </LEGEND>");
               /* $list_photos=scandir (PNM_PHOTO_PATH);
                $list_photos[0]=$list_photos[1]="";
                metaform_sel2 ("Fichier rattaché","","style=width:30em;","<br>",$list_photos,"PHOTO",mysql_result($result,0,"PHOTO"));*/
            echo ("</fieldset>");
		/*------------------------------------------------------------------------------ EDIT fieldset4*/
            echo ("</td><td width=50%>");
			echo ("<fieldset><LEGEND> Correspondances </LEGEND>");
			
			$colname18="idRattachementPVF"; $colname19="codeHIC";$colname20="codeEUNIS";
			
			$num_rows = pg_num_rows($result3);
			if ($num_rows > 0) {
			metaform_sel ("PVF 1","",30,$ref[$champ_ref['idRattachementPVF']],"idRattachementPVF",pg_result($result3,0,"\"$colname18\""), pg_fetch_result(pg_query ($db,$query_description."'$colname18'".";"),0,"description" ));			
			metaform_sel ("PVF 2","",30,$ref[$champ_ref['idRattachementPVF']],"idRattachementPVF",pg_result($result4,0,"\"$colname18\""), pg_fetch_result(pg_query ($db,$query_description."'$colname18'".";"),0,"description" ));	
            metaform_sel_multi ("Rattachement HIC","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic, this.form.hic_select);'",$ref[$champ_ref['codeHIC']],"hic",pg_result($result4,0,"\"$colname19\""),pg_fetch_result(pg_query ($db,$query_description."'$colname19'".";"),0,"description" ));
            metaform_sel_multi ("HIC Selectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic_select, this.form.hic);'",pg_result($result4,0,"\"$colname20\""),"hic_select","");
            echo "<br>";
			metaform_sel_multi ("Rattachement EUNIS","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis, this.form.eunis_select);'",$ref[$champ_ref['codeEUNIS']],"eunis","",pg_fetch_result(pg_query ($db,$query_description."'$colname20'".";"),0,"description" ));
            metaform_sel_multi ("EUNIS Selectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis_select, this.form.eunis);'","","eunis_select","");

			//dans le cas où les tables sont vides (pas d'enregistrement il faut faire une condition sinon l'affichage des données pose problème car le pg_result ne renvoi rien
			} else {
				metaform_sel ("Rattachement PVF 1","",30,$ref['liste_pvf1'],"idRattachementPVF","", pg_fetch_result(pg_query ($db,$query_description."'$colname18'".";"),0,"description" ));
				metaform_sel ("Rattachement PVF 2","",30,$ref['liste_pvf2'],"idRattachementPVF","", pg_fetch_result(pg_query ($db,$query_description."'$colname18'".";"),0,"description" ));
                metaform_sel_multi ("Rattachement HIC","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic, this.form.hic_select);'",$ref[$champ_ref['codeHIC']],"hic","",pg_fetch_result(pg_query ($db,$query_description."'$colname19'".";"),0,"description" ));
				metaform_sel_multi ("HIC sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic_select, this.form.hic);'","","hic_select","");
			    echo "<br>";
				metaform_sel_multi ("Rattachement EUNIS","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis, this.form.eunis_select);'",$ref[$champ_ref['codeEUNIS']],"eunis","",pg_fetch_result(pg_query ($db,$query_description."'$colname20'".";"),0,"description" ));
				metaform_sel_multi ("EUNIS sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis_select, this.form.eunis);'","","eunis_select","");
				//metaform_sel ("Rattachement Eunis","style=width:30em;",10,$ref[$champ_ref['codeEUNIS']],"codeEUNIS","", pg_fetch_result(pg_query ($db,$query_description."'$colname20'".";"),0,"description" ));						

			}
		
			
            echo ("</fieldset>");
			
			
				/* //bout de code a utiliser si on veut aller vers une fiche taxon dans refnat
				echo ("</td><td>");	
					if ($niveau >= 128)
						echo ("<a href = \"../refnat/index.php?m=edit&id=$id\" class=edit id=\"modif_taxon\" ><img src=\"../../_GRAPH/psuiv.gif\" title=\"Accès rapide Refnat\" ></a>"); 
				*/
				//echo ("</td></tr>");
				//echo ("</table>");
				
		/*------------------------------------------------------------------------------ EDIT fieldset5*/

                echo ("<fieldset><LEGEND>Chorologie</LEGEND>");
	
			$colname21="repartitionGenerale";$colname22="repartitionTerritoire";$colname23="idTerritoire";
			
			metaform_text_area ("Répartition générale","",57,50,"","repartitionGenerale",pg_result($result,0,"\"$colname21\""), pg_fetch_result(pg_query ($db,$query_description."'$colname21'".";"),0,"description" ));
			metaform_text_area ("Répartition territoire","",57,50,"","repartitionTerritoire",pg_result($result,0,"\"$colname22\""), pg_fetch_result(pg_query ($db,$query_description."'$colname22'".";"),0,"description" ));
			echo "<br>";
			$num_rows = pg_num_rows($result4);
			if ($num_rows > 0) {
			metaform_sel_multi ("Présence départementale","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement, this.form.departement_select);'",$ref['liste_departement'],"departement",pg_result($result4,0,"\"$colname23\""),pg_fetch_result(pg_query ($db,$query_description."'$colname23'".";"),0,"description" ));
            metaform_sel_multi ("Départements sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement_select, this.form.departement);'",pg_result($result4,0,"\"$colname23\""),"departement_select","");
			echo "<br>";
			metaform_sel_multi ("Présence région agricole","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole, this.form.region_agricole_select);'",$ref['liste_region_agricole'],"region_agricole",pg_result($result4,0,"\"$colname23\""),pg_fetch_result(pg_query ($db,$query_description."'$colname23'".";"),0,"description" ));
            metaform_sel_multi ("Région agricole sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole_select, this.form.region_agricole);'",pg_result($result4,0,"\"$colname23\""),"region_agricole_select","");
			} else {
					metaform_sel_multi ("Présence départementale","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement, this.form.departement_select);'",$ref['liste_departement'],"departement","",pg_fetch_result(pg_query ($db,$query_description."'$colname23'".";"),0,"description" ));
					metaform_sel_multi ("Départements sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement_select, this.form.departement);'","","departement_select","");
						echo "<br>";
					metaform_sel_multi ("Présence région agricole","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole, this.form.region_agricole_select);'",$ref['liste_region_agricole'],"region_agricole","",pg_fetch_result(pg_query ($db,$query_description."'$colname23'".";"),0,"description" ));
					metaform_sel_multi ("Région agricole sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole_select, this.form.region_agricole);'","","region_agricole_select","");
			}

			
			echo ("</fieldset>");
		/*------------------------------------------------------------------------------ EDIT fieldset6*/
		
  $colname24="periodeDebObsOptimale";$colname25= "periodeFinObsOptimale";$colname26="rqPhenologie";$colname27="aireMinimale";$colname28="typeBiologiqueDom";
  $colname29="typePhysionomique";$colname30="rqPhysionomie";$colname31="humiditePrincipale";$colname32="humiditeSecondaire";$colname33="phPrincipal";
  $colname34="phSecondaire";$colname35="climat";$colname36="descriptionEcologie";$colname37="remarqueVariabilite";

            
					echo ("<fieldset><LEGEND>Phénologie, physionomie, écologie</LEGEND>");
					
			metaform_text_area ("Description écologie","",57,50,"","descriptionEcologie",pg_result($result,0,"\"$colname36\""), pg_fetch_result(pg_query ($db,$query_description."'$colname36'".";"),0,"description" ));
			echo ("<table><tr><td width=33%>");
			metaform_sel ("Début de période optimale","",30,$ref[$champ_ref['periodeDebObsOptimale']],"periodeDebObsOptimale",pg_result($result,0,"\"$colname24\""), pg_fetch_result(pg_query ($db,$query_description."'$colname24'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_sel ("Fin de période optimale","",30,$ref[$champ_ref['periodeFinObsOptimale']],"periodeFinObsOptimale",pg_result($result,0,"\"$colname25\""), pg_fetch_result(pg_query ($db,$query_description."'$colname25'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_text_area ("Remarque phénologie","",37,30,"","rqPhenologie",pg_result($result,0,"\"$colname26\""), pg_fetch_result(pg_query ($db,$query_description."'$colname26'".";"),0,"description" ));
			echo ("</td></tr></table>"); 
			echo ("<br>");
						
			echo ("<table><tr><td width=33%>");
			metaform_text ("Type biologique dominant","",30,"width=100%","typeBiologiqueDom",pg_result($result,0,"\"$colname28\""), pg_fetch_result(pg_query ($db,$query_description."'$colname28'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_sel ("Type physionomique)","",30,$ref[$champ_ref['typeSynonymie']],"typeSynonymie",pg_result($result,0,"\"$colname8\""), pg_fetch_result(pg_query ($db,$query_description."'$colname8'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_text ("Aire minimale d'expression","",30,"width=100%","nomSyntaxonRaccourci",pg_result($result,0,"\"$colname6\""), pg_fetch_result(pg_query ($db,$query_description."'$colname6'".";"),0,"description" ));
			echo ("</td></tr></table>"); 
			echo ("<br>");
						
			echo ("<table><tr><td width=33%>");
			metaform_sel ("Humidité principale","",30,$ref[$champ_ref['typeSynonymie']],"typeSynonymie",pg_result($result,0,"\"$colname8\""), pg_fetch_result(pg_query ($db,$query_description."'$colname8'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_sel ("Humidité secondaire","",30,$ref[$champ_ref['typeSynonymie']],"typeSynonymie",pg_result($result,0,"\"$colname8\""), pg_fetch_result(pg_query ($db,$query_description."'$colname8'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			echo ("</td></tr></table>");
			echo ("<br>");
			
			/*table des valences écologiques*/
			$liste_valences = array('trophie'=>'trophie','température'=>'temperature', 'luminosité'=>'luminosite','exposition'=>'exposition','salinité'=>'salinite','neige'=>'neige','continentalité'=>'continentalite','ombroclimat'=>'ombroclimat');
			
			echo ("<table border=1 width=\"1200\">");
			echo ("<th style=\"width:5em;\"></th>");			
			/*en-tête*/
			foreach ($liste_valences as $label_valence => $champ_valence)	{
					echo ("<th style=\" text-align: center;	vertical-align: center; width:5em;\">$label_valence</th>");
					}
			/*valeurs*/
			
				echo ("<tr valign=top>");	
				echo ("<td style=\" text-align: center;	vertical-align: center;\">valences</td>");
				foreach ($liste_valences as $label_valence => $champ_valence)	{
					
						echo ("<td>");
						metaform_sel (""," no_lab","width:5em;",$ref[$champ_ref[$champ_valence]],$champ_valence,pg_result($result,0,"\"$champ_valence\""), pg_fetch_result(pg_query ($db,$query_description."'$champ_valence'".";"),0,"description" ));
						echo ("</td>");
					}
			echo ("</tr>");
			echo("</table><br>");
			
			echo ("</fieldset>");
        echo ("</td></tr></table>");
        echo ("<hr>");


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

