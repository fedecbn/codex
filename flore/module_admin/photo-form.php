<?php
header('Content-Type: text/html; charset=ISO-8859-1');
//------------------------------------------------------------------------------//
//  module_admin/photo-form.php                                                 //
//                                                                              //
//  Banque de semences VANDA                                                    //
//                                                                              //
//  Version 1.00  10/04/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

include("commun.inc.php");

//include ("../../_INCLUDE/config_sql.inc.php");

//------------------------------------------------------------------------------ VAR.
$publi_txt=array("0"=>"Non","1"=>"Flore","2"=>"Scan","3"=>"Zoom");

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ REF.

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){
	$("#form1").validate({
		rules: {
			id: {
				required: true,
                digits: true
			},
		},
		messages: {
			id: { required: "",	digits: ""}
		}
	}); 

//------------------------------------------------------------------------------ UI / Qtips

    $('a[title]').qtip({
        position: {
            corner: {
                target: 'topRight',
                tooltip: 'bottomLeft'
            }
        },
        style: { 
            name: 'green'
        }
    })

});
</script> 
<?php
//------------------------------------------------------------------------------ MAIN
echo ("<form method=\"POST\" id=\"form1\" name=\"add\" action=\"#\" >");
if (isset($_GET['id']) & !empty($_GET['id']))                                   // EDIT
{
    $id=$_GET['id'];
    $query="SELECT * FROM ".SQL_base_photo.".addinfo_images WHERE id=".$id.";";
    $result=mysql_query($query,$db) or die ("Erreur mySQL : ".mysql_error($db));
    if (mysql_num_rows($result)==1) {
        echo ("<fieldset><LEGEND> Métadonnée # ".$id." </LEGEND>");
        echo ("<label class=\"preField\">Id</label><input type=\"text\" name=\"id\" id=\"id\" size=\"10\" maxlength=\"10\" value=\"".mysql_result($result,0,"id")."\" readonly /><br>");

        echo ("<label class=\"preField\">Code réf. TAXREF</label><input type=\"text\" name=\"CD_REF\" id=\"CD_REF\" size=\"10\" maxlength=\"10\" value=\"".mysql_result($result,0,"CD_REF")."\" /><br>");
        echo ("<label class=\"preField\">Nom complet</label><input type=\"text\" name=\"NOM_COMPLET\" id=\"NOM_COMPLET\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"NOM_COMPLET")."\" /><br>");
        echo ("<label class=\"preField\">Famille</label><input type=\"text\" name=\"FAMILLE\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"FAMILLE")."\" /><br>");
        echo ("<label class=\"preField\">Code du lot</label><input type=\"text\" name=\"ID_LOT\" size=\"10\" maxlength=\"10\" value=\"".mysql_result($result,0,"ID_LOT")."\" /><br>");
        echo ("<label class=\"preField\">Date</label><input type=\"text\" name=\"DATE_PV\" id=\"DATE_PV\" size=\"10\" maxlength=\"10\" value=\"".mysql_result($result,0,"DATE_PV")."\" /><br>");
        echo ("<label class=\"preField\">Auteur</label><input type=\"text\" name=\"AUTEUR\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"AUTEUR")."\" /><br>");
        echo ("<label class=\"preField\">Code INSEE</label><input type=\"text\" name=\"INSEE\" size=\"5\" maxlength=\"5\" value=\"".mysql_result($result,0,"INSEE")."\" /><br>");
        echo ("<label class=\"preField\">Commune</label><input type=\"text\" name=\"COMMUNE\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"COMMUNE")."\" /><br>");
        echo ("<label class=\"preField\">Lieu-dit</label><input type=\"text\" name=\"LIEUDIT\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"LIEUDIT")."\" /><br>");

        echo ("<label class=\"preField\">Objet de la photo</label><input type=\"text\" name=\"OBJET\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"OBJET")."\" /><br>");
        echo ("<label class=\"preField\">Support original</label><input type=\"text\" name=\"SUPP_ORIG\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"SUPP_ORIG")."\" /><br>");
        echo ("<label class=\"preField\">Cadrage</label><input type=\"text\" name=\"CADRAGE\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"CADRAGE")."\" /><br>");
        echo ("<label class=\"preField\">Forme des graines</label><input type=\"text\" name=\"FORME\" style=\"width:30em;\" maxlength=\"200\" value=\"".mysql_result($result,0,"FORME")."\" /><br>");

        echo ("<label class=\"preField\">Source</label>");
        echo ("<select name=\"SOURCE\" >");
        foreach ($source_txt as $key => $value) { 
            echo ("<option value=\"$value\" ");
            if ($value==mysql_result($result,0,"SOURCE")) echo ("SELECTED");
            echo (">".$value."</option>");
        }
        echo ("</select><br>");

        echo ("<label class=\"preField\">Publication WEB</label>");
        echo ("<select name=\"PUBLI\" >");
        foreach ($publi_txt as $key => $value) { 
            echo ("<option value=\"$key\" ");
            if ($key==mysql_result($result,0,"PUBLI")) echo ("SELECTED");
            echo (">".$value."</option>");
        }
        echo ("</select><br>");
        echo ("</fieldset>");
    } else die ("ID ".$id." > Pas de résultats !");
} else {                                                                        // ADD
        echo ("<fieldset><LEGEND> Métadonnée </LEGEND>");
        echo ("<label class=\"preField\">Id</label><input type=\"text\" name=\"id\" id=\"id\" size=\"10\" maxlength=\"10\" /><br>");

        echo ("<label class=\"preField\">Code réf. TAXREF</label><input type=\"text\" name=\"CD_REF\" id=\"CD_REF\" size=\"10\" maxlength=\"10\" /><br>");
        echo ("<label class=\"preField\">Nom complet</label><input type=\"text\" name=\"NOM_COMPLET\" id=\"NOM_COMPLET\" style=\"width:30em;\" maxlength=\"200\" /><br>");
        echo ("<label class=\"preField\">Famille</label><input type=\"text\" name=\"FAMILLE\" style=\"width:30em;\" maxlength=\"200\" /><br>");
        echo ("<label class=\"preField\">Code du lot</label><input type=\"text\" name=\"ID_LOT\" size=\"10\" maxlength=\"10\" /><br>");
        echo ("<label class=\"preField\">Date</label><input type=\"text\" name=\"DATE_PV\" id=\"DATE_PV\" size=\"10\" maxlength=\"10\" /><br>");
        echo ("<label class=\"preField\">Auteur</label><input type=\"text\" name=\"AUTEUR\" style=\"width:30em;\" maxlength=\"200\" /><br>");
        echo ("<label class=\"preField\">Code INSEE</label><input type=\"text\" name=\"INSEE\" size=\"5\" maxlength=\"5\" /><br>");
        echo ("<label class=\"preField\">Commune</label><input type=\"text\" name=\"COMMUNE\" style=\"width:30em;\" maxlength=\"200\" /><br>");
        echo ("<label class=\"preField\">Lieu-dit</label><input type=\"text\" name=\"LIEUDIT\" style=\"width:30em;\" maxlength=\"200\" /><br>");

        echo ("<label class=\"preField\">Objet de la photo</label><input type=\"text\" name=\"OBJET\" style=\"width:30em;\" maxlength=\"200\" /><br>");
        echo ("<label class=\"preField\">Support original</label><input type=\"text\" name=\"SUPP_ORIG\" style=\"width:30em;\" maxlength=\"200\" /><br>");
        echo ("<label class=\"preField\">Cadrage</label><input type=\"text\" name=\"CADRAGE\" style=\"width:30em;\" maxlength=\"200\" /><br>");
        echo ("<label class=\"preField\">Forme des graines</label><input type=\"text\" name=\"FORME\" style=\"width:30em;\" maxlength=\"200\" /><br>");

        echo ("<label class=\"preField\">Source</label>");
        echo ("<select name=\"SOURCE\" >");
        foreach ($source_txt as $key => $value) 
            echo ("<option value=\"$value\">".$value."</option>");
        echo ("</select><br>");

        echo ("<label class=\"preField\">Publication WEB</label>");
        echo ("<select name=\"PUBLI\" >");
        foreach ($publi_txt as $key => $value) 
            echo ("<option value=\"$key\">".$value."</option>");
        echo ("</select><br>");

        echo ("</fieldset>"); 
}
echo ("</form>");
?>
