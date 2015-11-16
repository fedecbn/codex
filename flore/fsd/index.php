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
if ($niveau <= 64) $desc = " bloque"; else $disa = $desc;
if ($niveau <= 64) $disa = "disabled"; else $disa = null;

$format = array("string"=>"string","float"=>"float","integer"=>"integer","booleen"=>"booleen","date"=>"date");
$oblig = array(""=>"","Oui"=>"Oui","Oui si"=>"Oui si","Non"=>"Non","NSP"=>"NSP");

// /*------------------------------------------------------------------------------ MAIN*/
html_header_2 ("utf-8","table_eval.css","jquery-te-1.4.0.css",$title);

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
                echo ($lang[$lang_select]["liste_champ"]);
            echo ("</div>");
            echo ("<input type=\"hidden\" id=\"export-TXT-fichier\" value=\"".$id_page."_".$id_user.".csv\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query-id\" value=\"$export_id\" />");
            echo ("<input type=\"hidden\" id=\"export-TXT-query\" value=\"$query_export\" />");
            echo ("<div style=\"float:right;\">");
				if ($niveau >= 128) 
                    echo ("<button id=\"add-button\">".$lang[$lang_select]['ajouter']."</button>&nbsp;&nbsp;");
				if ($niveau >= 128) 
					echo ("<button id=\"export-TXT-button\">".$lang[$lang_select]['export']." (TXT)</button>&nbsp;&nbsp;");
                if ($niveau >= 255) 
                    echo ("<button id=\"del-button\"> ".$lang[$lang_select]['del']."</button>&nbsp;&nbsp;");
                if ($niveau >= 512) 
                    echo ("<button id=\"figer-version-button\"> ".$lang[$lang_select]['maj_taxa']."</button>&nbsp;&nbsp;");
			echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_new ($id_page,true,true);						
		echo ("</div>");
/*------------------------------------------------------------------------------ #fiche*/
        echo ("<div id=\"droit\" >");
            /*Troisième bandeau*/
            echo ("<div id=\"titre2\">");
                echo "Droit d'utilisation de la rubrique";
            echo ("</div>");
            echo ("<div style=\"float:right;\">");
            echo ("</div><br><br>");
            echo ("<div id=\"dialog\"></div>");
			/*Table des données*/
			aff_table_new ("droit",false,true);			
        echo ("</div>");    }
    break;

/*------------------------------------------------------------------------------ #CAS AJOUT D'UNE FICHE */
	case "add" : {
/*------------------------------------------------------------------------------ REF. */
/*Gestion des niveau de droit*/
	$query = "SELECT max(version) as version FROM fsd.ddd;";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $version = $row['version'];
        pg_free_result ($result);
		
	/*voca_ctrl*/
	$query = "SELECT DISTINCT \"typChamp\" FROM fsd.voca_ctrl ORDER BY \"typChamp\";";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	$voca_ctrl[null] = null;while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            {$voca_ctrl[$row['typChamp']] = $row['typChamp'];$i++;}
	pg_free_result ($result);
	
	$i = 0;

/*------------------------------------------------------------------------------ ADD  EN TETE*/
        echo ("<div id=\"$id_page\" >");
        echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
        echo ("<div id=\"fiche\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"add\" action=\"\" >");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['add_fiche']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            if ($mode == "add") {
                echo ("<button id=\"enregistrer1-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
                echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_champ']."</button> ");
            } else {
                echo ("<button id=\"retour3-button\">".$lang[$lang_select]['retour']."</button> ");
            }
		echo ("</div>");
            echo ("<input type=\"hidden\" name=\"type\" value=\"champ\" />");
			echo ("<br><br>");

//------------------------------------------------------------------------------ ADD
		echo ("<div id=\"radio2\">");    
			/*modules*/
			$query = "SELECT DISTINCT modl FROM fsd.ddd WHERE version = $version ORDER BY modl;";
			$resulte=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($rowe=pg_fetch_array ($resulte,NULL,PGSQL_ASSOC))
					{$modl[$rowe['modl']] = $rowe['modl'];}
			pg_free_result ($resulte);
			
			/*SSmodules*/
			$query = "SELECT DISTINCT ssmodl FROM fsd.ddd WHERE version = $version ORDER BY ssmodl;";
			$resulte=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($rowe=pg_fetch_array ($resulte,NULL,PGSQL_ASSOC))
					{$ssmodl[$rowe['ssmodl']] = $rowe['ssmodl'];}
			pg_free_result ($resulte);
			
			
			/*autre_champ*/
			$autre_chp = null;
			$query = "SELECT DISTINCT cd, uid FROM fsd.ddd WHERE version = $version - 1 ORDER BY cd ;";
			// echo $query;
			$resultat=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($ligne=pg_fetch_array ($resultat,NULL,PGSQL_ASSOC))
				$autre_chp[$ligne['uid']] = $ligne['cd'];
			pg_free_result ($resultat);
			

			echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_fsd_1']."</LEGEND>"); 
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 40%;\">");
						metaform_text ("Version FSD"," bloque",10,"","version_bloque",$version);
						echo ("<input type=\"hidden\" name=\"version\" id=\"version\" value=\"$version\" />");
						metaform_sel ("Module",null,null,$modl,"modl",null);
						metaform_sel ("Sous-module",null,null,$ssmodl,"ssmodl",null);
						metaform_text ("Code du champ",null,40,"","cd",null);
						metaform_text ("Libellé du champ",null,40,"","lib",null);
					echo "<BR>";
						metaform_sel ("Format",null,null,$format,"format",null);
						metaform_text ("Taille",null,10,"","taille",null);
						metaform_sel ("Vocabulaire contrôlé",null,null,$voca_ctrl,"vocaCtrl",null);
					echo "<BR>";
						metaform_sel ("Obligatoire (Data)",null,null,$oblig,"oData",null);
						metaform_sel ("Obligatoire (Taxa)",null,null,$oblig,"oTaxa",null);
						metaform_sel ("Obligatoire (Syntdata)",null,null,$oblig,"oSynData",null);
						metaform_sel ("Obligatoire (Syntaxa)",null,null,$oblig,"oSynTaxa",null);
					echo "<BR>";
						metaform_text ("Exemple 1",null,20,"","ex1",null);
						metaform_text ("Exemple 2",null,20,"","ex2",null);
					echo ("</td><td style=\"width:60%;\">");
						echo ("<label class=\"preField\">Description</label>");
						echo ("<textarea name=\"descr\" $disa style=\"width:80%;$gris\" rows=\"3\" ></textarea><br><br>");

						echo ("<label class=\"preField\">Objectif du partage</label>");
						echo ("<textarea name=\"obj\" $disa style=\"width:80%;$gris\" rows=\"3\" ></textarea><br><br>");
						
						echo ("<label class=\"preField\">Règles de renseignement</label>");
						echo ("<textarea name=\"regleRens\" $disa style=\"width:80%;$gris\" rows=\"3\" ></textarea><br><br>");


						$jvs1 = "OnDblClick='javascript: deplacer( this.form.id_from_to, this.form.id_from);'"; 
						$jvs2 = "OnDblClick='javascript: deplacer( this.form.id_from, this.form.id_from_to);'"; 
						metaform_sel_multi ("Champ(s) d'origine",null,5,"width: 190px;$gris",$jvs1,$autre_chp,"id_from_to",null);
						metaform_sel_multi ("Champ(s) d'origine"," no_lab",5,"width: 190px;$gris",$jvs2,null,"id_from",null);	

					echo "<BR><BR>";
					metaform_text ("champ SINP",$bloq,20,"","lien_sinp",null);
						
					echo ("</td></tr></table>");
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 100%;\">");
						echo "<BR>";
						echo ("<label class=\"preField\">Evolutions à apporter?</label>");
						echo ("<textarea name=\"discussion\" $disa style=\"width:80%;$gris\" rows=\"4\" ></textarea><br><br>");
					echo ("</td></tr></table>");
				echo ("</fieldset>");
			

/* ------------------------------------------------------------------------------ ADD SAVE*/
        echo ("<div style=\"float:right;\"><br>");
			if ($mode == "add") {
				echo ("<button id=\"enregistrer2-add-button\">".$lang[$lang_select]['enregistrer']."</button> ");
				echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_champ']."</button> ");
			} else {
				echo ("<button id=\"retour4-button\">".$lang[$lang_select]['retour']."</button> ");
			}
			echo ("</div>");
			echo ("</form>");
			
        echo ("<div id=\"exit-confirm\" title=\"Retour\">");
            echo ("<p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>".$lang[$lang_select]['retour_dialog']."</p>");
        echo ("</div>");

        echo ("<div id=\"enregistrer-dialog\">");
            echo ("<center><img src=\"../../_GRAPH/check.png\"  /><br>".$lang[$lang_select]['enregistrer_dialog']."</center>");
        echo ("</div>");
    }
    break;

/*--------------------------------------------------------------------------------------------------------- */
/*------------------------------------------------------------------------------ #CAS MODIFICATION DE FICHE */
/*--------------------------------------------------------------------------------------------------------- */
	case "view" : 
	case "edit" : {
/*------------------------------------------------------------------------------ REF. */
/*Gestion des niveau de droit*/
if ($niveau <= 64) $desc = " bloque"; else $desc = null;
if ($niveau <= 64) $disa = "disabled"; else $disa = null;

	$query = "SELECT max(version) as version FROM fsd.ddd;";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $version = $row['version'];
        pg_free_result ($result);
		
	/*voca_ctrl*/
	$query = "SELECT DISTINCT \"typChamp\" FROM fsd.voca_ctrl ORDER BY \"typChamp\";";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	$voca_ctrl[null] = null;while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            {$voca_ctrl[$row['typChamp']] = $row['typChamp'];$i++;}
	pg_free_result ($result);
	
	$i = 0;

/*------------------------------------------------------------------------------ EDIT  EN TETE*/
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
                echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_champ']."</button> ");
            } else {
                echo ("<button id=\"retour3-button\">".$lang[$lang_select]['retour']."</button> ");
            }
		echo ("</div>");
		if (isset($_GET['id']) & !empty($_GET['id'])) {                         // Modifier
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            echo ("<input type=\"hidden\" name=\"type\" value=\"champ\" />");
			
			$query = "WITH RECURSIVE hierarchie (uid, version, modl, ssmodl, cd, lib, descr, format, taille, \"oData\", \"vocaCtrl\", \"regleRens\", ex1, ex2, discussion, \"oTaxa\", \"oSynData\", \"oSynTaxa\", obj, lien_sinp, id_from) AS (
				SELECT a.*, z.id_from as id_from
				FROM fsd.ddd a
				LEFT JOIN fsd.lien_champs z ON a.uid = z.uid
				WHERE a.uid = $id
				UNION
				SELECT t1.*, t3.id_from as id_from
				FROM fsd.ddd t1
				LEFT JOIN fsd.lien_champs t3 ON t1.uid = t3.uid
				INNER JOIN hierarchie t2 ON t2.id_from = t1.uid
				)
			SELECT uid, version, modl, ssmodl, cd, lib, descr, format, taille, \"oData\", \"vocaCtrl\", \"regleRens\", ex1, ex2, discussion, \"oTaxa\", \"oSynData\", \"oSynTaxa\", obj, lien_sinp FROM hierarchie GROUP BY uid, version, modl, ssmodl, cd, lib, descr, format, taille, \"oData\", \"vocaCtrl\", \"regleRens\", ex1, ex2, discussion, \"oTaxa\", \"oSynData\", \"oSynTaxa\", obj, lien_sinp ORDER BY version DESC;";
            $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

			if (pg_num_rows ($result)) {
			
			echo ("<br><br>");

//------------------------------------------------------------------------------ Edit
		echo ("<div id=\"radio2\">");    
       
	   while ($row = pg_fetch_assoc($result))
			{
			$version = $row["version"];
			
			/*modules*/
			$query = "SELECT DISTINCT modl FROM fsd.ddd WHERE version = $version ORDER BY modl;";
			$resulte=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($rowe=pg_fetch_array ($resulte,NULL,PGSQL_ASSOC))
					{$modl[$rowe['modl']] = $rowe['modl'];}
			pg_free_result ($resulte);
			
			/*SSmodules*/
			$query = "SELECT DISTINCT ssmodl FROM fsd.ddd WHERE version = $version ORDER BY ssmodl;";
			$resulte=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($rowe=pg_fetch_array ($resulte,NULL,PGSQL_ASSOC))
					{$ssmodl[$rowe['ssmodl']] = $rowe['ssmodl'];}
			pg_free_result ($resulte);
			
			
			/*autre_champ*/
			$autre_chp = null;
			$query = "SELECT DISTINCT cd, uid FROM fsd.ddd WHERE version = ".$row["version"]."-1 ORDER BY cd ;";
			// echo $query;
			$resultat=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($ligne=pg_fetch_array ($resultat,NULL,PGSQL_ASSOC))
				$autre_chp[$ligne['uid']] = $ligne['cd'];
			pg_free_result ($resultat);
			
			$query = "SELECT id_from FROM fsd.lien_champs WHERE uid = ".$row["uid"].";";
			// echo $query;
			$resultat=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($ligne=pg_fetch_array ($resultat,NULL,PGSQL_ASSOC))
				$id_from[$ligne['id_from']] = $autre_chp[$ligne['id_from']];
			pg_free_result ($resultat);
			
			if ($i > 0 OR $niveau <= 64) $bloq = " bloque"; else $bloq = "";
			if ($i > 0 OR $niveau <= 64) $disa = " disabled"; else $disa = "";
			if ($i > 0) $gris = " background-color:#EFEFEF"; else $gris = "";
			
			if ($i == 0)
				{
				echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_fsd_1']."</LEGEND>"); 
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 40%;\">");
						metaform_text ("Version FSD"," bloque",10,"","version",$row["version"]);
						echo ("<input type=\"hidden\" name=\"version\" id=\"version\" value=\"".$row["version"]."\" />");
						metaform_sel ("Module",$bloq,null,$modl,"modl",$row["modl"]);
						metaform_sel ("Sous-module",$bloq,null,$ssmodl,"ssmodl",$row["ssmodl"]);
						metaform_text ("Code du champ",$bloq,40,"","cd",sql_format_quote($row["cd"],"undo"));
						metaform_text ("Libellé du champ",$bloq,40,"","lib",sql_format_quote($row["lib"],"undo"));
					echo "<BR>";
						metaform_sel ("Format",$bloq,null,$format,"format",$row["format"]);
						metaform_text ("Taille",$bloq,10,"","taille",sql_format_quote($row["taille"],"undo"));
						metaform_sel ("Vocabulaire contrôlé",$bloq,null,$voca_ctrl,"vocaCtrl",$row["vocaCtrl"]);
					echo "<BR>";
						metaform_sel ("Obligatoire (Data)",$bloq,null,$oblig,"oData",$row["oData"]);
						metaform_sel ("Obligatoire (Taxa)",$bloq,null,$oblig,"oTaxa",$row["oTaxa"]);
						metaform_sel ("Obligatoire (Syntdata)",$bloq,null,$oblig,"oSynData",$row["oSynData"]);
						metaform_sel ("Obligatoire (Syntaxa)",$bloq,null,$oblig,"oSynTaxa",$row["oSynTaxa"]);
					echo "<BR>";
						metaform_text ("Exemple 1",$bloq,20,"","ex1",sql_format_quote($row["ex1"],"undo"));
						metaform_text ("Exemple 2",$bloq,20,"","ex2",sql_format_quote($row["ex2"],"undo"));
					echo ("</td><td style=\"width:60%;\">");
						echo ("<label class=\"preField\">Description</label>");
						echo ("<textarea name=\"descr\" $disa style=\"width:80%;$gris\" rows=\"3\" >".sql_format_quote($row["descr"],"undo")."</textarea><br><br>");

						echo ("<label class=\"preField\">Objectif du partage</label>");
						echo ("<textarea name=\"obj\" $disa style=\"width:80%;$gris\" rows=\"3\" >".sql_format_quote($row["obj"],"undo")."</textarea><br><br>");
						
						echo ("<label class=\"preField\">Règles de renseignement</label>");
						echo ("<textarea name=\"regleRens\" $disa style=\"width:80%;$gris\" rows=\"3\" >".sql_format_quote($row["regleRens"],"undo")."</textarea><br><br>");


						$jvs1 = "OnDblClick='javascript: deplacer( this.form.id_from_to_$i, this.form.id_from_$i);'";
						$jvs2 = "OnDblClick='javascript: deplacer( this.form.id_from_$i, this.form.id_from_to_$i);'";
						metaform_sel_multi ("Champ(s) d'origine",null,5,"width: 190px;$gris",$jvs1,$autre_chp,"id_from_to_$i",null);
						metaform_sel_multi ("Champ(s) d'origine"," no_lab",5,"width: 190px;$gris",$jvs2,$id_from,"id_from_$i",null);	

						echo "<BR><BR>";

						metaform_text ("champ SINP",$bloq,20,"","lien_sinp",sql_format_quote($row["lien_sinp"],"undo"));
						
					echo ("</td></tr></table>");
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 100%;\">");
						echo "<BR>";
						if ($i > 0) echo ("<label class=\"preField_calc\">Evolutions à apporter?</label>"); else echo ("<label class=\"preField\">Evolutions à apporter?</label>");
						echo ("<textarea name=\"discussion\" $disa style=\"width:80%;$gris\" rows=\"4\" >".sql_format_quote($row["discussion"],"undo")."</textarea><br><br>");
					echo ("</td></tr></table>");
				echo ("</fieldset>");				
				}
			elseif ($i > 0) 
				{
				echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_fsd_1']."</LEGEND>"); 
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 40%;\">");
						metaform_text ("Version FSD"," bloque",10,"","version_stay",$row["version"]);
						metaform_sel ("Module",$bloq,null,$modl,"modl_stay",$row["modl"]);
						metaform_sel ("Sous-module",$bloq,null,$ssmodl,"ssmodl_stay",$row["ssmodl"]);
						metaform_text ("Code du champ",$bloq,40,"","cd_stay",sql_format_quote($row["cd"],"undo"));
						metaform_text ("Libellé du champ",$bloq,40,"","lib_stay",sql_format_quote($row["lib"],"undo"));
					echo "<BR>";
						metaform_sel ("Format",$bloq,null,$format,"format_stay",$row["format"]);
						metaform_text ("Taille",$bloq,10,"","taille_stay",sql_format_quote($row["taille"],"undo"));
						metaform_sel ("Vocabulaire contrôlé",$bloq,null,$voca_ctrl,"vocaCtrl_stay",$row["vocaCtrl"]);
					echo "<BR>";
						metaform_sel ("Obligatoire (Data)",$bloq,null,$oblig,"oDat_staya",$row["oData"]);
						metaform_sel ("Obligatoire (Taxa)",$bloq,null,$oblig,"oTaxa_stay",$row["oTaxa"]);
						metaform_sel ("Obligatoire (Syntdata)",$bloq,null,$oblig,"oSynData_stay",$row["oSynData"]);
						metaform_sel ("Obligatoire (Syntaxa)",$bloq,null,$oblig,"oSynTaxa_stay",$row["oSynTaxa"]);
					echo "<BR>";
						metaform_text ("Exemple 1",$bloq,20,"","ex1_stay",sql_format_quote($row["ex1"],"undo"));
						metaform_text ("Exemple 2",$bloq,20,"","ex2_stay",sql_format_quote($row["ex2"],"undo"));
					echo ("</td><td style=\"width:60%;\">");
						echo ("<label class=\"preField_calc\">Description</label>");
						echo ("<textarea name=\"descr_stay\" $disa style=\"width:80%;$gris\" rows=\"3\" >".sql_format_quote($row["descr"],"undo")."</textarea><br><br>");

						echo ("<label class=\"preField_calc\">Objectif du partage</label>");
						echo ("<textarea name=\"obj_stay\" $disa style=\"width:80%;$gris\" rows=\"3\" >".sql_format_quote($row["obj"],"undo")."</textarea><br><br>");
						
						echo ("<label class=\"preField_calc\">Règles de renseignement</label>");
						echo ("<textarea name=\"regleRens_stay\" $disa style=\"width:80%;$gris\" rows=\"3\" >".sql_format_quote($row["regleRens"],"undo")."</textarea><br><br>");

						metaform_sel_multi ("Champ(s) d'origine",null,5,"width: 190px;$gris",null,$autre_chp,"id_from_to_$i",null);
						metaform_sel_multi ("Champ(s) d'origine"," no_lab",5,"width: 190px;$gris",null,$id_from,"id_from_$i",null);	

						echo "<BR><BR>";

						metaform_text ("champ SINP",$bloq,20,"","lien_SINP_stay",sql_format_quote($row["lien_sinp"],"undo"));

					echo ("</td></tr></table>");
					
					echo ("<table border=0 width=\"100%\"><tr valign=top >");
					echo ("<td style=\"width: 100%;\">");
						echo "<BR>";
						echo ("<label class=\"preField_calc\">Evolutions à apporter?</label>");
						echo ("<textarea name=\"discussion_stay\" $disa style=\"width:80%;$gris\" rows=\"4\" >".sql_format_quote($row["discussion"],"undo")."</textarea><br><br>");
					echo ("</td></tr></table>");
				echo ("</fieldset>");
				}
			$i++;
			}
//------------------------------------------------------------------------------ EDIT Discussion
        echo ("<div id=\"radio2\">");
		echo ("<fieldset><LEGEND> ".$lang[$lang_select]['groupe_lr_5']."</LEGEND>");
			/*requete discussion*/
			$query= $query_discussion.$id.";";
			$discussion=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($query),false);
			if ($niveau < 64) echo ("<label class=\"preField_calc\">Discussion sur la fiche</label>"); else echo ("<label class=\"preField\">Réactions sur le champ</label>");
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
				echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_champ']."</button> ");
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

	case "vocactrl"	: {
/*Gestion des niveau de droit*/
if ($niveau <= 64) $desc = " bloque"; else $desc = null;
if ($niveau <= 64) $disa = "disabled"; else $disa = null;

/*------------------------------------------------------------------------------ EDIT  EN TETE*/
        echo ("<div id=\"$id_page\" >");
        echo ("</div>");
/*------------------------------------------------------------------------------ #Onglet Fiche*/
        echo ("<div id=\"fiche\" >");
        echo ("<form method=\"POST\" id=\"form1\" class=\"form1\" name=\"vocactrl\" action=\"\" >");

        echo ("<div style=\"float:left;\">");
            echo ("<font size=5 color=#008C8E >".$lang[$lang_select]['edit_fiche']."</font>");
        echo ("</div>");
        echo ("<div style=\"float:right;\">");
            if ($mode == "vocactrl") {
                echo ("<button id=\"enregistrer1-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
                echo ("<button id=\"retour1-button\">".$lang[$lang_select]['liste_champ']."</button> ");
            } else {
                echo ("<button id=\"retour3-button\">".$lang[$lang_select]['retour']."</button> ");
            }
		echo ("</div>");
		if (isset($_GET['id']) & !empty($_GET['id'])) {
            $id=$_GET['id'];
            echo ("<input type=\"hidden\" name=\"id\" value=\"".$id."\" />");
            echo ("<input type=\"hidden\" name=\"type\" value=\"vocactrl\" />");
			
			/*voca_ctrl*/
			$query = "SELECT * FROM fsd.voca_ctrl WHERE \"typChamp\" = '$id';";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			// while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
					// {$voca_ctrl[$row['typChamp']] = $row['typChamp'];$i++;}
			
			if (pg_num_rows ($result)) {
			
			echo ("<br><br>");

//------------------------------------------------------------------------------ Edit
		echo ("<div id=\"radio2\">");    
		echo ("<fieldset><LEGEND>".$lang[$lang_select]['groupe_fsd_1']."</LEGEND>");
		$bloq = " no_lab";
		$disa = "";
		$gris = "";
		$i=0;
		echo "<BR>";
		metaform_text ("Code du champ",null,40,"","typChamp",sql_format_quote($id,"undo"));
		echo "<BR><BR>";
		echo ("<table border=0 width=\"50%\">");
		echo ("<tr valign=top ><td style=\"width: 20%;\">Code de l'attribut");
		echo ("</td><td style=\"width:40%;\">Libellé de l'attribut");
		echo ("</td><td style=\"width:60%;\">Description de l'attribut");
		while ($row = pg_fetch_assoc($result))
			{
			echo ("<input type=\"hidden\" name=\"id_$i\" value=\"".$row["id"]."\" />");
			echo ("<tr valign=top ><td style=\"width: 20%;\">");
				metaform_text ("Code de l'attribut",$bloq,20,"","cdChamp_$i",sql_format_quote($row["cdChamp"],"undo"));
			echo ("</td><td style=\"width:40%;\">");
				metaform_text ("Libellé de l'attribut",$bloq,40,"","libChamp_$i",sql_format_quote($row["libChamp"],"undo"));
			echo ("</td><td style=\"width:60%;\">");
				// echo ("<label class=\"preField\">Evolutions à apporter?</label>");
				echo ("<textarea name=\"descChamp_$i\" id=\"descChamp_$i\" $disa style=\"$gris\" rows=\"2\"  cols=\"50\" >".sql_format_quote($row["descChamp"],"undo")."</textarea><br><br>");
			echo ("</td></tr>");
			$i++;
			}
			echo ("<input type=\"hidden\" name=\"nb\" value=\"$i\" />");
			/*Ligne vide suplémentaire*/			
			echo ("<tr valign=top ><td style=\"width: 20%;\">");
				metaform_text ("Code de l'attribut",$bloq,20,"","cdChamp",null);
			echo ("</td><td style=\"width:40%;\">");
				metaform_text ("Libellé de l'attribut",$bloq,40,"","libChamp",null);
			echo ("</td><td style=\"width:60%;\">");
				echo ("<textarea name=\"descChamp\" $disa id=\"descChamp\" style=\"$gris\" rows=\"2\"  cols=\"50\" >".sql_format_quote($row["descChamp"],"undo")."</textarea><br><br>");
			echo ("</td></tr>");
			echo ("</table></fieldset>");
			}
/* ------------------------------------------------------------------------------ EDIT catnat SAVE*/
        echo ("<div style=\"float:right;\"><br>");
			if ($mode == "vocactrl") {
				echo ("<button id=\"enregistrer2-edit-button\">".$lang[$lang_select]['enregistrer']."</button> ");
				echo ("<button id=\"retour2-button\">".$lang[$lang_select]['liste_champ']."</button> ");
			} else {
				echo ("<button id=\"retour4-button\">".$lang[$lang_select]['retour']."</button> ");
			}
			echo ("</div>");
			echo ("</form>");
			} else fatal_error ("ID ".$id." > Vide !",false);
		
    
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

echo ("</body></html>");
pg_close ($db);

//------------------------------------------------------------------------------ FONCTIONS

?>

