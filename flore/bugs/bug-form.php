<?php
//------------------------------------------------------------------------------//
//  bugs/bugs-form.php                                                          //
//                                                                              //
//  Version 1.00  26/08/11 - DariaNet                                           //
//  Version 1.01  11/06/14 - Aj statut 'concertation'                           //
//  Version 1.02  14/09/14 - MaJ UTF-8                                          //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT.
include ("commun.inc.php");


//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){

 	$("#form1").validate({
		rules: {
			statut: {
				required: true,
			},
		},
		messages: {
			statut: {
				required: "",
			}
		}
	});
});
</script> 
<?php
//------------------------------------------------------------------------------ REF
/*ne fonctionne pas*/
// $niveau=$_SESSION['niveau'];
// if ($niveau >= 255) $desc = null; else $desc = " bloque";
$desc = " bloque";

//------------------------------------------------------------------------------ MAIN
echo ("<form method=\"POST\" id=\"form1\" name=\"add\" action=\"#\" >");

if (isset($_GET['id']) & !empty($_GET['id']))                                   // EDIT
{
    $id=$_GET['id'];
     $query="SELECT b.id_bug, b.id_user, to_char(date_bug, 'DD/MM/YYYY') as date_bug, b.id_rubrique , b.descr, b.cat, b.statut, b.statut_descr, u.nom,u.prenom
		FROM applications.bug AS b
		LEFT JOIN applications.utilisateur AS u ON b.id_user=u.id_user
		WHERE id_bug=".$id;

    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
	$arr=pg_fetch_array($result, NULL, PGSQL_ASSOC);
    
	list ($a,$m,$j) = explode("-",$arr["date_bug"]);
    $date_bug=$j."/".$m."/".$a;
	
	
	if (pg_num_rows ($result)) {
        echo ("<fieldset><LEGEND> Bug ou remarque </LEGEND>");
		echo ("<label class=\"preField_calc\">Type</label>");
		echo ("<select id=\"cat\" name=\"cat\"  readonly disabled>");
		for ($i=0;$i<sizeof ($cat_txt);$i++)
            echo ("<option value=\"$i\" ".($i == pg_result($result,0,"cat") ? "SELECTED" : "").">".$cat_txt[$i]."</option>");
        echo ("</select><br>");
        // echo ("<label class=\"preField\">Date</label><input type=\"text\" size=\"10\" maxlength=\"10\" value=\"".$date_bug."\" readonly /><br>");
		metaform_text ("Date",$desc,10,null,"date",$arr["date_bug"]);
        // echo ("<label class=\"preField\">Auteur</label><input type=\"text\" size=\"40\" value=\"".$arr["nom"]." ".$arr["prenom"]."\" readonly /><br>"); 
        metaform_text ("Auteur",$desc,40,"","auteur",$arr["nom"]." ".$arr["prenom"]);

        echo ("<label class=\"preField_calc\">Rubrique</label><select id=\"id_rubrique\" name=\"id_rubrique\"  readonly disabled>");
        for ($i=0;$i<sizeof ($rubriques_txt);$i++)
            echo ("<option value=\"$i\" ".($i == pg_result($result,0,"id_rubrique") ? "SELECTED" : "").">".$rubriques_txt[$i]."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Description</label><textarea name=\"descr\" id=\"descr\" style=\"width:30em;\" rows=\"2\">".pg_result($result,0,"descr")."</textarea><br>");
        echo ("</fieldset>");
        echo ("<fieldset><LEGEND> Gestion (ADMIN.)</LEGEND>");
        echo ("<label class=\"preField\">Statut</label><select id=\"statut\" name=\"statut\" >");
        for ($i=0;$i<sizeof ($statut_txt);$i++)
            echo ("<option value=\"$i\" ".($i == pg_result($result,0,"statut") ? "SELECTED" : "").">".$statut_txt[$i]."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Commentaire</label><textarea name=\"statut_descr\" id=\"statut_descr\" style=\"width:30em;\" rows=\"2\" >".pg_result($result,0,"statut_descr")."</textarea><br>");
        echo ("</fieldset>");
    }
    else die ("ID ".$id." > Pas de résultats !");
} 
echo ("</form>");

?>
