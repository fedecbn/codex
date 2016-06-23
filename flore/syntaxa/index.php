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
include ("commun.inc.php");
/*Droit page*/ 
$base_file = substr(basename(__FILE__),0,-4); 
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]); 

if ($droit_page) { 
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

//var_dump($ref);
//$table = pg_fetch_array($result); var_dump($table);
//$colname = pg_field_name($result, 1);
//$val= pg_fetch_result($result,"\"codeEnregistrementSyntax\"" ); echo $val;

/*Droits*/
$typ_droit='d2';$rubrique=$id_page;$onglet = 'syntaxa';
$droit = ref_droit($id_user,$typ_droit,$rubrique,$onglet);

//var_dump($droit);
//var_dump($droit_page);
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

<!-- Utilise le jquery validation plugin pour obliger le remplissage de certaines cases du formulaire avant l'enregistrement--> 
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
			idCatalogue2: {
				required: true,
                minlength: 2
			},
			libelleCatalogue2: {
				required: true,
                minlength: 2
			},
			idTerritoireObligatoire: {
				required: true
			},
			
/*			niveau_fsd: {
				required: true,
                digits: true
			},
*/
		},
		messages: {
			nomSyntaxon: { required: "Le nom du syntaxon est obligatoire",	minlength: ""},
			auteurSyntaxon: { required: "L'auteur du syntaxon est obligatoire",	minlength: "La longueur minimale est de 2"},
			idCatalogue2: { required: "L'identifiant du catalogue est obligatoire",	minlength: "La longueur minimale est de 2"},
			libelleCatalogue2: { required: "Le libellé du catalogue est obligatoire",	minlength: "La longueur minimale est de 2"},
			idTerritoireObligatoire: { required: "Le choix d'un CBN d'appartenance est obligatoire"},
/*			niveau: {
				required: "",
                digits: "Valeur numérique"
			}
*/
		}
	}); 
});

</script> 

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
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"$export_id\" />"); /*---- #Utilisé dans export_TXT.php*/
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />"); /*---- #Utilisé dans export_TXT.php*/
            echo ("<div style=\"float:right;\">");
                if ($droit['add_fiche']) echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
                if ($droit['export_fiche']) echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($droit['del_fiche']) echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
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
/*A faire: Ajouter L'autocomplétion*/
include ("../syntaxa/add_fiche.php"); /*renvoi vers le formulaire php d'ajout de fiche*/
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
            if ($droit['save_fiche']) echo ("<button id=\"enregistrer1-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
            if ($droit['retour_fiche']) echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
		echo ("</div>");
		if (isset($_GET['id']) & !empty($_GET['id'])) { 
            $id="'".$_GET['id']."'";
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
			
			
        /*-----------------REQUETES UTILISEES POUR RENVOYER LE RESULTAT DES TABLES AYANT DEJA DES DONNEES-------------*/
		
            //QUERY QUI RENVOI LE RESULTAT DE LA TABLE DE SYNTAXONS	
			$query_syntaxon= $query_module.$id.";";
			//echo $query_syntaxon;
			$result_syntaxon=pg_query ($db,$query_syntaxon) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_syntaxon),false);
			$numrows = pg_numrows($result_syntaxon);
			//for($i = 0; $i < $numrows; $i++) { $row = pg_fetch_array($result, $i);echo $row["codeEnregistrementSyntax"];}			

			//QUERY QUI RENVOI LES REFERENCES BIBLIO POUR CHAQUE SYNTAXON
			$query_biblio= $query_module_biblio.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_biblio=pg_query($db,$query_biblio) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_biblio),false);
			//for($i = 0; $i < $numrows; $i++) { $row = pg_fetch_array($result, $i);echo $row["codeEnregistrementSyntax"];}	
			
			//QUERY QUI RENVOIENT LES CORRESPONDANCES PHYTOSOCIOLOGIE et HABITATS POUR CHAQUE SYNTAXON
						//PVF1
			$query_pvf1= $query_module_correspondance_pvf1.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_pvf1=pg_query($db,$query_pvf1) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_pvf1),false);
			
						//PVF2
			$query_pvf2= $query_module_correspondance_pvf2.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_pvf2=pg_query($db,$query_pvf2) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_pvf2),false);
			
						//HIC
			$query_hic= $query_module_correspondance_hic.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_hic=pg_query($db,$query_hic) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_hic),false);
					//organisation en tableau utilisable par la fonction metaform_sel_multi de type codeHIC => libHIC (ex: 'DEP_971' => string 'Guadeloupe' (length=10)) 
					while ($row_hic=pg_fetch_array ($result_hic,NULL,PGSQL_ASSOC))
					$output_hic[$row_hic["codeHIC"]]=$row_hic["libHIC"];
					$result_hic_enregistre = $output_hic;
					//var_dump($result_hic_enregistre);
					
						//EUNIS			
			$query_eunis= $query_module_correspondance_eunis.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_eunis=pg_query($db,$query_eunis) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_eunis),false);
					//organisation en tableau utilisable par la fonction metaform_sel_multi de type codeEUNIS => libEUNIS (ex: 'DEP_971' => string 'Guadeloupe' (length=10)) 
					while ($row_eunis=pg_fetch_array ($result_eunis,NULL,PGSQL_ASSOC))
					$output_eunis[$row_eunis["codeEUNIS"]]=$row_eunis["libEUNIS"];
					$result_eunis_enregistre = $output_eunis;
					//var_dump($result_eunis_enregistre);
			
			
			
			//QUERY CHOROLOGIE et STATUTS DE PRESENCE
			//toutes les lignes enregistrées dans st_chorologie pour ce syntaxon
			$query_chorologie= $query_module_chorologie.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_chorologie=pg_query($db,$query_chorologie) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_chorologie),false);
			
			//toutes les lignes du type territoire "DEP" enregistrées dans st_chorologie pour ce syntaxon
			$where= "and \"code_type_territoire\"='DEP'";
			$query_departement= $query_module_chorologie.$id.$where.";";
			$result_departement=pg_query($db,$query_departement) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_departement),false);
					//organisation en tableau utilisable par la fonction metaform_sel_multi de type idTerritoire => libelle_territoire (ex: 'DEP_971' => string 'Guadeloupe' (length=10)) 
					while ($row_dep=pg_fetch_array ($result_departement,NULL,PGSQL_ASSOC))
					$output_dep[$row_dep["idTerritoire"]]=$row_dep["libelle_territoire"];
					$result_departement_enregistre = $output_dep;
					//var_dump($result_departement_enregistre);
		
			//var_dump(pg_fetch_array ($result_departement,NULL,PGSQL_ASSOC));
			
			//toutes les lignes du type territoire "RA" enregistrées dans st_chorologie pour ce syntaxon
			$where= "and \"code_type_territoire\"='RA'";
			$query_region_agr= $query_module_chorologie.$id.$where.";";
			$result_region_agr=pg_query($db,$query_region_agr) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_region_agr),false);
					//organisation en tableau utilisable par la fonction metaform_sel_multi de type idTerritoire => libelle_territoire (ex: 'RA_234' => string 'LEVEZOU' (length=7)) 
					while ($row=pg_fetch_array ($result_region_agr,NULL,PGSQL_ASSOC))
					$output2[$row["idTerritoire"]]=$row["libelle_territoire"];
					$result_region_agr_enregistre = $output2;
					//var_dump($result_region_agr_enregistre);
			
			
			
			$query9 =$query_liste_statuts_cbn.$id.";";
			$result9=pg_query ($db,$query9) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
			$liste_statut_presence = pg_fetch_all($result9);
			//var_dump($liste_statut_presence);
			//var_dump(pg_fetch_array($result9));
			
			//QUERY BIBLIO
			$query_biblio= $query_module_biblio.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_biblio=pg_query($db,$query_biblio) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_biblio),false);
			
			//QUERY ETAGES VEGETATION
			$query_etage_veg= $query_module_etage_vegetation.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_etage_veg=pg_query($db,$query_etage_veg) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_etage_veg),false);
			
			//organisation en tableau utilisable par la fonction metaform_sel_multi de type codeEtageVeg => libEtageVeg (ex: 'L' => string 'littoral' (length=10)) 
					while ($row=pg_fetch_array ($result_etage_veg,NULL,PGSQL_ASSOC))
					$output3[$row["codeEtageVeg"]]=$row["libEtageVeg"];
					$result_etage_veg_enregistre = $output3;
					//var_dump($result_etage_veg);
					
			//QUERY ETAGES BIOCLIMATIQUES
			$query_etage_bioclim= $query_module_etage_bioclim.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_etage_bioclim=pg_query($db,$query_etage_bioclim) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_etage_veg),false);
			
			//organisation en tableau utilisable par la fonction metaform_sel_multi de type codeEtageVeg => libEtageVeg (ex: 'L' => string 'littoral' (length=10)) 
					while ($row=pg_fetch_array ($result_etage_bioclim,NULL,PGSQL_ASSOC))
					$output4[$row["codeEtageBioclim"]]=$row["libEtageBioclim"];
					$result_etage_bioclim_enregistre = $output4;
					//var_dump($result_etage_bioclim);

			//QUERY CORTEGE FLORISTIQUE
			$query_cortege_flo= $query_module_cortege_floristique.$id.";";				
			//utilisation de pg_numrow pour s'assurer que la table est pleine et ne rien afficher si pas pleine
			$result_cortege_flo=pg_query($db,$query_cortege_flo) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result_cortege_flo),false);
			
			//organisation en tableau utilisable par la fonction metaform_sel_multi de type idRattachementReferentiel => nom_complet_taxon_referentiel (ex: 'TAXREF_5_1000' => string 'Procellaria glacialis Linnaeus, 1761' (length=10)) 
					while ($row=pg_fetch_array ($result_cortege_flo,NULL,PGSQL_ASSOC))
					$output5[$row["idRattachementReferentiel"]]=$row["nom_complet_taxon_referentiel"];
					$result_cortege_flo_enregistre = $output5;
					//var_dump($result_etage_bioclim);

			


			// Loop through rows in the result set
			for($i = 0; $i < $numrows2; $i++) { $row = pg_fetch_array($result_biblio, $i);echo $row["codeEnregistrement"];}
			

			
            if (pg_num_rows ($result_syntaxon)) {
			
			echo ("<br><br>");
				
			echo("<input type=\"hidden\" name=\"zone\" id=\"zone1\" value=\"gl\">");
			
			echo ("<div id=\"radio2\">"); 
			echo ("<input type=\"hidden\" name=\"etape\" id=\"etape2\" value=\"2\">");
			//echo ("<input type=\"hidden\" name=\"codeEnregistrementSyntax\" id=\"codeEnregistrementSyntax\" value=\"".pg_result($result,0,"codeEnregistrementSyntax")."\">");
	
	
	
	
	//------------------------------------------------------------------------------ EDIT fieldset1
	//----------Attention la fonction pg_fetch_result() is case sensitive donc faire attention aux noms de colonnes avec majuscule en les encadrant avec \"\"
//var_dump($ref);
//var_dump(pg_result($result,0,"\"salinite\""));
//var_dump(pg_result($result,0,"\"rangSyntaxon\""));
//var_dump($ref[$champ_ref["salinite"]]);
//var_dump($ref[$champ_ref["temperature"]]);
//var_dump($ref['st_ref_type_synonymie']);
//var_dump($ref[$champ_ref["idCritiqueSyntax"]]);
//var_dump($ref["st_ref_critique"]);
//var_dump($aColumnsTot['syntaxa']['idCritique']);
//var_dump($aColumnsTot['syntaxa']['idCritiqueSyntax']);
//var_dump($aColumnsTot['syntaxa']['exposition']);
//var_dump($aColumnsTot['syntaxa']);
//$identite = array('nom' => 'blabla','nom' => 'blibli', 'prenom' => 'Hugo','age' => 19, 'estEtudiant' => true); var_dump($identite['nom']);


			echo ("<table border=0 width=\"100%\"><tr valign=top ><td width=50%>");
//                    echo ("<fieldset style=\"width:670px;\" ><LEGEND> Habitat </LEGEND>");
            echo ("<fieldset ><LEGEND> Nomenclature </LEGEND>");
				metaform_sel ("Catalogue","",30,$ref[$champ_ref["idCatalogue"]],"idCatalogue",pg_result($result_syntaxon,0,"\"idCatalogue\""), pg_fetch_result(pg_query ($db,$query_description."'idCatalogue'".";"),0,"description" ));			
				metaform_text ("<b>Code de l'enregistrement*</b>"," ",30,"width:30em;","codeEnregistrementSyntax",sql_format_quote(pg_result($result_syntaxon,0,"\"codeEnregistrementSyntax\"" ),'undo_text'), pg_fetch_result(pg_query ($db,$query_description."'codeEnregistrementSyntax'".";"),0,"description" ));
				echo ("<br>");
				metaform_text ("Identifiant du syntaxon"," ",30,"width:30em;","idSyntaxon",pg_result($result_syntaxon,0,"\"idSyntaxon\""), pg_fetch_result(pg_query ($db,$query_description."'idSyntaxon'".";"),0,"description" ));		
				metaform_text ("Identifiant du syntaxon retenu"," ",30,"width:30em;","idSyntaxonRetenu",pg_result($result_syntaxon,0,"\"idSyntaxonRetenu\""), pg_fetch_result(pg_query ($db,$query_description."'idSyntaxonRetenu'".";"),0,"description" ));							
				//metaform_text ("Code de l'enregistrement"," ",20,"<br>","codeEnregistrementSyntax",sql_format_quote(pg_result($result_syntaxon,0,"\"$colname1\"" ),'undo_text'));
				metaform_text ("Nom du syntaxon","",30,"width:30em;","nomSyntaxon",pg_result($result_syntaxon,0,"\"nomSyntaxon\""), pg_fetch_result(pg_query ($db,$query_description."'nomSyntaxon'".";"),0,"description" ));
				metaform_text ("Auteur du syntaxon","",30,"width:30em;","auteurSyntaxon",sql_format_quote(pg_result($result_syntaxon,0,"\"auteurSyntaxon\"" ),'undo_text'), pg_fetch_result(pg_query ($db,$query_description."'auteurSyntaxon'".";"),0,"description" ));
				metaform_text ("Nom complet du syntaxon"," bloque",30,"width:30em;","nomCompletSyntaxon",pg_result($result_syntaxon,0,"\"nomCompletSyntaxon\""), pg_fetch_result(pg_query ($db,$query_description."'nomCompletSyntaxon'".";"),0,"description" ));
				metaform_text ("Nom raccourcit"," ",30,"width:30em;","nomSyntaxonRaccourci",pg_result($result_syntaxon,0,"\"nomSyntaxonRaccourci\""), pg_fetch_result(pg_query ($db,$query_description."'nomSyntaxonRaccourci'".";"),0,"description" ));
				metaform_sel ("Type de synonymie","",30,$ref[$champ_ref['typeSynonymie']],"typeSynonymie",pg_result($result_syntaxon,0,"\"typeSynonymie\""), pg_fetch_result(pg_query ($db,$query_description."'typeSynonymie'".";"),0,"description" ));
				metaform_text ("Nom syntaxon retenu"," ",30,"width:30em;","nomSyntaxonRetenu",pg_result($result_syntaxon,0,"\"nomSyntaxonRetenu\""), pg_fetch_result(pg_query ($db,$query_description."'nomSyntaxonRetenu'".";"),0,"description" ));
				$tooltip=pg_fetch_result(pg_query ($db,$query_description."'rqNomenclaturale'".";"),0,"description" );
				//style=\"width:70em;\"
				metaform_text_area ("Remarque nomenclaturale","",57,50,"","rqNomenclaturale",sql_format_quote(pg_result($result_syntaxon,0,"\"rqNomenclaturale\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'rqNomenclaturale'".";"),0,"description" ));
				metaform_sel ("Rang syntaxon","","",$ref[$champ_ref["rangSyntaxon"]],"rangSyntaxon",pg_result($result_syntaxon,0,"\"rangSyntaxon\""), pg_fetch_result(pg_query ($db,$query_description."'rangSyntaxon'".";"),0,"description" ));
				//metaform_text ("Nom syntaxon sup","",30,"width:30em;","nomSyntaxonSup",pg_result($result_syntaxon,0,"\"nomSyntaxonRetenu\""), pg_fetch_result(pg_query ($db,$query_description."'nomSyntaxonRetenu'".";"),0,"description" ));
				metaform_text ("Nom français","",30,"width:30em;","nomFrancaisSyntaxon",sql_format_quote(pg_result($result_syntaxon,0,"\"nomFrancaisSyntaxon\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'nomFrancaisSyntaxon'".";"),0,"description" ));
				metaform_text_area ("Diagnose courte","",57,50,"","diagnoseCourteSyntaxon",sql_format_quote(pg_result($result_syntaxon,0,"\"diagnoseCourteSyntaxon\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'diagnoseCourteSyntaxon'".";"),0,"description" ));
				metaform_sel ("Typicité","",30,$ref[$champ_ref["idCritiqueSyntax"]],"idCritique",pg_result($result_syntaxon,0,"\"idCritique\""), pg_fetch_result(pg_query ($db,$query_description."'idCritique'".";"),0,"description" ));
				metaform_text ("Remarque typicité","",30,"width:30em;","rqCritique",pg_result($result_syntaxon,0,"\"rqCritique\""), pg_fetch_result(pg_query ($db,$query_description."'rqCritique'".";"),0,"description" ));
				

            echo ("</fieldset>");
			
		/*------------------------------------------------------------------------------ EDIT fieldset2*/
			echo ("<fieldset  ><LEGEND> Bibliographie </LEGEND>");
                /*On utilise ici le résultat de la query_biblio pour avoir accès à la table st_biblio*/
			
				$num_rows_biblio = pg_num_rows($result_biblio);
				if ($num_rows_biblio > 0) {
				metaform_text_area ("Libellé de la ressource","",57,50,"","libPublication",sql_format_quote(pg_result($result_biblio,0,"\"libPublication\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'libPublication'".";"),0,"description" ));	
				metaform_text_url ("url de la ressource","",20,"","urlPublication",pg_result($result_biblio,0,"\"urlPublication\""), pg_fetch_result(pg_query ($db,$query_description."'urlPublication'".";"),0,"description" ));
				metaform_text ("Identifiant de la ressource","",20,"","codePublication",pg_result($result_biblio,0,"\"codePublication\""), pg_fetch_result(pg_query ($db,$query_description."'codePublication'".";"),0,"description" ));
				}
				else {
					metaform_text_area ("Libellé de la ressource","",57,50,"","libPublication",'', pg_fetch_result(pg_query ($db,$query_description."'libPublication'".";"),0,"description" ));
					metaform_text_url ("url de la ressource","",20,"","urlPublication",'', pg_fetch_result(pg_query ($db,$query_description."'urlPublication'".";"),0,"description" ));
					metaform_text ("Identifiant de la ressource","",20,"","codePublication",'', pg_fetch_result(pg_query ($db,$query_description."'codePublication'".";"),0,"description" ));
				}
				echo ("</fieldset>");
					
				
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
				metaform_text ("Nom du syntaxon","","30em","","nomSyntaxon",pg_result($result,0,"\"nomSyntaxon\""), pg_fetch_result(pg_query ($db,$query_description."'nomSyntaxon'".";"),0,"description" ));
				echo ("</fieldset>");
				echo ("</td></tr></table>");
	
*/	
	
            echo ("</fieldset>");
		/*------------------------------------------------------------------------------ EDIT fieldset3*/
            echo ("<fieldset><LEGEND> Fichier rattaché (photo numérique) </LEGEND>");
			   /* echo ("<a><input type=\"file\" name=\"file_image\" /></a>");
               /* $list_photos=scandir (PNM_PHOTO_PATH);
                $list_photos[0]=$list_photos[1]="";
                metaform_sel2 ("Fichier rattaché","","style=width:30em;","<br>",$list_photos,"PHOTO",mysql_result($result,0,"PHOTO"));*/
            echo ("</fieldset>");
		/*------------------------------------------------------------------------------ EDIT fieldset4*/
            echo ("</td><td width=50%>");
			echo ("<fieldset><LEGEND> Correspondances </LEGEND>");
			echo ("<br>PHYTOSOCIOLOGIE <hr>");

		
			$num_rows_pvf1 = pg_num_rows($result_pvf1);
			$num_rows_pvf2 = pg_num_rows($result_pvf2);
			
			if ($num_rows_pvf1 > 0) {
			//echo pg_result($result_pvf1,0,"\"idRattachementPVF\"");
			metaform_sel ("Rattachement PVF 1","",30,$ref['liste_pvf1'],"idRattachementPVF1",pg_result($result_pvf1,0,"\"idRattachementPVF\""), pg_fetch_result(pg_query ($db,$query_description."'idRattachementPVF'".";"),0,"description" ));			
			} else 
			{
			metaform_sel ("PVF 1","",30,$ref['liste_pvf1'],"idRattachementPVF1","", pg_fetch_result(pg_query ($db,$query_description."'idRattachementPVF'".";"),0,"description" ));
			}
			echo "<br>";
			
			if ($num_rows_pvf2 > 0) {
			//echo pg_result($result_pvf2,0,"\"idRattachementPVF\"");
			metaform_sel (" Rattachement PVF 2","",30,$ref['liste_pvf2'],"idRattachementPVF2",pg_result($result_pvf2,0,"\"idRattachementPVF\""), pg_fetch_result(pg_query ($db,$query_description."'idRattachementPVF'".";"),0,"description" ));	
			//dans le cas où les tables sont vides (pas d'enregistrement il faut faire une condition sinon l'affichage des données pose problème car le pg_result ne renvoi rien
			} else {
				metaform_sel ("PVF 2","",30,$ref['liste_pvf2'],"idRattachementPVF2","", pg_fetch_result(pg_query ($db,$query_description."'idRattachementPVF'".";"),0,"description" ));
			}

			
	
			echo ("<br>HABITATS<hr>");

			$num_rows_hic = pg_num_rows($result_hic);
			if ($num_rows_hic > 0) {
			//var_dump( $result_hic_enregistre);
			metaform_sel_multi ("Rattachement HIC","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic, this.form.hic_select);'",$ref[$champ_ref['codeHIC']],"hic","",pg_fetch_result(pg_query ($db,$query_description."'codeHIC'".";"),0,"description" ));
            metaform_sel_multi ("HIC sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic_select, this.form.hic);'",$result_hic_enregistre,"hic_select","");
			} else {
					metaform_sel_multi ("Rattachement HIC","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic, this.form.hic_select);'",$ref[$champ_ref['codeHIC']],"hic","",pg_fetch_result(pg_query ($db,$query_description."'codeHIC'".";"),0,"description" ));
					metaform_sel_multi ("HIC sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.hic_select, this.form.hic);'","","hic_select","");
			}
			echo "<br>";

/* 			$num_rows_eunis = pg_num_rows($result_eunis);
			echo "num_rows_eunis"; var_dump ($num_rows_eunis);
			if ($num_rows_eunis > 0) {
			//var_dump( $result_eunis_enregistre);
			metaform_sel_multi ("Rattachement EUNIS","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis, this.form.eunis_select);'",$ref[$champ_ref['codeEUNIS']],"eunis","",pg_fetch_result(pg_query ($db,$query_description."'codeEUNIS'".";"),0,"description" ));
            metaform_sel_multi ("EUNIS sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis_select, this.form.eunis);'",$result_eunis_enregistre,"eunis_select","");
			} else {
					metaform_sel_multi ("Rattachement EUNIS","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis, this.form.eunis_select);'",$ref[$champ_ref['codeEUNIS']],"eunis","",pg_fetch_result(pg_query ($db,$query_description."'codeEUNIS'".";"),0,"description" ));
					metaform_sel_multi ("EUNIS sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.eunis_select, this.form.eunis);'","","eunis_select","");
			}
			echo "<br>"; */
			
			

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
			/*répartition territoire et générale*/		
			
			metaform_text_area ("Répartition générale","",57,50,"","repartitionGenerale",sql_format_quote(pg_result($result_syntaxon,0,"\"repartitionGenerale\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'repartitionGenerale'".";"),0,"description" ));
			metaform_text_area ("Répartition territoire","",57,50,"","repartitionTerritoire",sql_format_quote(pg_result($result_syntaxon,0,"\"repartitionTerritoire\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'repartitionTerritoire'".";"),0,"description" ));
			echo "<br>";
			
			/*chorologie départementale et autres territoires (table multivariée)*/
			
/*			$num_rows = pg_num_rows($result_chorologie);
			if ($num_rows > 0) {
			echo ("<BR><BR>");
			echo ("<table class = \"basic_table\">");
			echo ("<tr><td colspan=2>Statuts de présence enregistrés pour ce syntaxon</td></tr>");
			echo ("<tr><td><b>Libellé territoire</b></td><td><b>Statut de présence</b></td></tr>");
			foreach ($liste_statut_presence as $key => $val)
				echo ("<tr><td>".$val["libelle_territoire"]."</td><td>".$val["statutChorologie"]."</td></tr>");
			echo ("</table>");
			}
*/		
			
			$num_rows_dep = pg_num_rows($result_departement);
//			$num_rows_rag = pg_num_rows($result_region_agr);
			if ($num_rows_dep > 0) {
			metaform_sel_multi ("Présence départementale","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement, this.form.departement_select);'",$ref['liste_departement'],"departement","",pg_fetch_result(pg_query ($db,$query_description."'idTerritoire'".";"),0,"description" ));
            metaform_sel_multi ("Départements sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement_select, this.form.departement);'",$result_departement_enregistre,"departement_select","");
			} else {
					metaform_sel_multi ("Présence départementale","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement, this.form.departement_select);'",$ref['liste_departement'],"departement","",pg_fetch_result(pg_query ($db,$query_description."'idTerritoire'".";"),0,"description" ));
					metaform_sel_multi ("Départements sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.departement_select, this.form.departement);'","","departement_select","");
			}
			echo "<br>";
			
/*			if ($num_rows_rag > 0) {
			metaform_sel_multi ("Présence région agricole","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole, this.form.region_agricole_select);'",$ref['liste_region_agricole'],"region_agricole","",pg_fetch_result(pg_query ($db,$query_description."'idTerritoire'".";"),0,"description" ));
            metaform_sel_multi ("Région agricole sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole_select, this.form.region_agricole);'",$result_region_agr_enregistre,"region_agricole_select","");
			 } else {
					echo "<br>";
					metaform_sel_multi ("Présence région agricole","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole, this.form.region_agricole_select);'",$ref['liste_region_agricole'],"region_agricole","",pg_fetch_result(pg_query ($db,$query_description."'idTerritoire'".";"),0,"description" ));
					metaform_sel_multi ("Région agricole sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.region_agricole_select, this.form.region_agricole);'","","region_agricole_select","");
			 }
*/
			
			echo ("</fieldset>");

		/*------------------------------------------------------------------------------ EDIT fieldset6*/
		
            
					echo ("<fieldset><LEGEND>Phénologie, physionomie, écologie</LEGEND>");
					
			/*écologie générale*/		
			
			metaform_text_area ("Description écologie","",57,50,"","descriptionEcologie",sql_format_quote(pg_result($result_syntaxon,0,"\"descriptionEcologie\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'descriptionEcologie'".";"),0,"description" ));
			
			echo ("<table><tr><td width=33%>");
			metaform_sel ("Type physionomique)","",30,$ref[$champ_ref['typePhysionomique']],"typePhysionomique",pg_result($result_syntaxon,0,"\"typePhysionomique\""), pg_fetch_result(pg_query ($db,$query_description."'typePhysionomique'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_text ("Type biologique dominant","",30,"width=100%","typeBiologiqueDom",sql_format_quote(pg_result($result_syntaxon,0,"\"typeBiologiqueDom\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'typeBiologiqueDom'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_text ("Aire minimale d'expression (m2)","",30,"width=100%","aireMinimale",sql_format_quote(pg_result($result_syntaxon,0,"\"aireMinimale\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'aireMinimale'".";"),0,"description" ));
			echo ("</td></tr></table>"); 
			echo ("<br>");
			
			
			echo ("<table><tr><td width=33%>");
			metaform_text_area ("Remarque phénologie","",57,50,"","rqPhenologie",sql_format_quote(pg_result($result_syntaxon,0,"\"rqPhenologie\""),'undo'), pg_fetch_result(pg_query ($db,$query_description."'rqPhenologie'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_sel ("Début de période optimale","",30,$ref[$champ_ref['periodeDebObsOptimale']],"periodeDebObsOptimale",pg_result($result_syntaxon,0,"\"periodeDebObsOptimale\""), pg_fetch_result(pg_query ($db,$query_description."'periodeDebObsOptimale'".";"),0,"description" ));
			echo ("</td><td width=33%>");
			metaform_sel ("Fin de période optimale","",30,$ref[$champ_ref['periodeFinObsOptimale']],"periodeFinObsOptimale",pg_result($result_syntaxon,0,"\"periodeFinObsOptimale\""), pg_fetch_result(pg_query ($db,$query_description."'periodeFinObsOptimale'".";"),0,"description" ));
			echo ("</td></tr></table>"); 
			echo ("<br>");
						

						
			echo ("<table><tr><td width=50%>");
			metaform_sel ("Humidité principale","",30,$ref[$champ_ref['humiditePrincipale']],"humiditePrincipale",pg_result($result_syntaxon,0,"\"humiditePrincipale\""), pg_fetch_result(pg_query ($db,$query_description."'humiditePrincipale'".";"),0,"description" ));
			echo ("</td><td width=50%>");
			metaform_sel ("Humidité secondaire","",30,$ref[$champ_ref['humiditeSecondaire']],"humiditeSecondaire",pg_result($result_syntaxon,0,"\"humiditeSecondaire\""), pg_fetch_result(pg_query ($db,$query_description."'humiditeSecondaire'".";"),0,"description" ));
			echo ("</td></tr></table>");
			echo ("<br>");
			
			echo ("<table><tr><td width=50%>");
			metaform_sel ("Ph principal","",30,$ref[$champ_ref['phPrincipal']],"phPrincipal",pg_result($result_syntaxon,0,"\"phPrincipal\""), pg_fetch_result(pg_query ($db,$query_description."'phPrincipal'".";"),0,"description" ));
			echo ("</td><td width=50%>");
			metaform_sel ("Ph secondaire","",30,$ref[$champ_ref['phSecondaire']],"phSecondaire",pg_result($result_syntaxon,0,"\"phSecondaire\""), pg_fetch_result(pg_query ($db,$query_description."'phPrincipal'".";"),0,"description" ));
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
						metaform_sel_tableau (""," no_lab","width:5em;",$ref[$champ_ref[$champ_valence]],$champ_valence,pg_result($result_syntaxon,0,"\"$champ_valence\""), pg_fetch_result(pg_query ($db,$query_description."'$champ_valence'".";"),0,"description" ));
						echo ("</td>");
					}
			echo ("</tr>");
			echo("</table><br>");
			
			/*Etagement*/
			echo ("<br>ETAGEMENT <hr>");
			$num_rows_etag = pg_num_rows($result_etage_veg);
			if ($num_rows_etag > 0) {
			metaform_sel_multi ("Etages de végétation","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_veg, this.form.etage_veg_select);'",$ref[$champ_ref['codeEtageVeg']],"etage_veg","",pg_fetch_result(pg_query ($db,$query_description."'codeEtageVeg'".";"),0,"description" ));
            metaform_sel_multi ("Etages de végétation sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_veg_select, this.form.etage_veg);'",$result_etage_veg_enregistre,"etage_veg_select","");
			} else {
					metaform_sel_multi ("Etages de végétation","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_veg, this.form.etage_veg_select);'",$ref[$champ_ref['codeEtageVeg']],"etage_veg","",pg_fetch_result(pg_query ($db,$query_description."'codeEtageVeg'".";"),0,"description" ));
					metaform_sel_multi ("Etages de végétation sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_veg_select, this.form.etage_veg);'","","etage_veg_select","");
			}
			echo "<br>";
			
			echo "<br>";
			$num_rows_etag_bioclim = pg_num_rows($result_etage_bioclim);
			if ($num_rows_etag_bioclim > 0) {
			metaform_sel_multi ("Etages bioclimatiques","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_bioclim, this.form.etage_bioclim_select);'",$ref[$champ_ref['codeEtageBioclim']],"etage_bioclim","",pg_fetch_result(pg_query ($db,$query_description."'codeEtageBioclim'".";"),0,"description" ));
            metaform_sel_multi ("Etages bioclimatiques sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_bioclim_select, this.form.etage_bioclim);'",$result_etage_bioclim_enregistre,"etage_bioclim_select","");
			} else {
					metaform_sel_multi ("Etages bioclimatiques","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_bioclim, this.form.etage_bioclim_select);'",$ref[$champ_ref['codeEtageBioclim']],"etage_bioclim","",pg_fetch_result(pg_query ($db,$query_description."'codeEtageBioclim'".";"),0,"description" ));
					metaform_sel_multi ("Etages bioclimatiques sélectionné(s)","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.etage_bioclim_select, this.form.etage_bioclim);'","","etage_bioclim_select","");
			}
			echo "<br>";

			/*Cortège floristique*/
			echo ("<br>CORTEGE FLORISTIQUE <hr>");
			
			echo "<br>";
			$num_rows_cortege_flo = pg_num_rows($result_cortege_flo);
			if ($num_rows_cortege_flo > 0) {
			metaform_sel_multi ("Cortège floristique","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.cortege_flo, this.form.cortege_flo_select);'",$ref[$champ_ref['idRattachementReferentiel']],"cortege_flo","",pg_fetch_result(pg_query ($db,$query_description."'nom_complet_taxon_referentiel'".";"),0,"description" ));
            metaform_sel_multi ("Cortège floristique sélectionné","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.cortege_flo_select, this.form.cortege_flo);'",$result_cortege_flo_enregistre,"cortege_flo_select","");
			} else {
					metaform_sel_multi ("Cortège floristique","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.cortege_flo, this.form.cortege_flo_select);'",$ref[$champ_ref['idRattachementReferentiel']],"cortege_flo","",pg_fetch_result(pg_query ($db,$query_description."'nom_complet_taxon_referentiel'".";"),0,"description" ));
					metaform_sel_multi ("Cortège floristique sélectionné","",5,"width: 240px;","OnDblClick='javascript: deplacer( this.form.cortege_flo_select, this.form.cortege_flo);'","","cortege_flo_select","");
			}
			echo "<br>";
			
			echo ("</fieldset>");
			echo ("<hr>");
	/* ----------------------------------------------------------------------------- EDIT SAVE*/
			echo ("<div style=\"float:right;\"><br>");
				if ($droit['save_fiche']) echo ("<button id=\"enregistrer2-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
				if ($droit['retour_fiche']) echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_taxons']."</button> ");
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

//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>

