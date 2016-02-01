<?php
//------------------------------------------------------------------------------//
//  module_admin/user-form.php                                                  //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  15/08/14 - Aj $user_level                                     //
//------------------------------------------------------------------------------//
include("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$table="utilisateur";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
// $db=sql_connect (SQL_base);
// if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
//------------------------------------------------------------------------------ CONSTANTES du module
// /*récupération des rubriques*/
$query = "SELECT id_module, titre FROM applications.rubrique ORDER BY pos";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
While ($row = pg_fetch_row($result)) {$rubrique[$row[0]] = $row[1];$i++;}

/*référents et  niveau de droits*/
$query="SELECT * FROM applications.utilisateur WHERE id_user= '".$_GET["id_user"]."';";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($query),false);
$ref['all'] = 'f';$niveau['all'] = 0;
foreach ($rubrique as $key => $val)
	{
	$ref[$key]= pg_result ($result,0,"ref_".$key) != null ? pg_result ($result,0,"ref_".$key) : 'f';
	$ref['all'] = $ref['all'] = 't' OR $ref['ref_'.$key] = 't' ? 't' : 'f';
	$niveau[$key]= pg_result ($result,0,"niveau_".$key) != null ? pg_result ($result,0,"niveau_".$key) : 0;
	$niveau['all'] = max($niveau['all'],$niveau['niveau_'.$key]);
	$blocked[$key]= ($ref[$key] == 't' OR $niveau[$key] >= 255) ? "" : "disabled";
	}

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){
	$("#form1").validate({
		rules: {
			prenom: {
				required: true,
                minlength: 2
			},
			nom: {
				required: true,
                minlength: 3
			},
			login: {
				required: true,
                minlength: 2
			},
			pw: {
				required: true,	
                minlength: 3
			},
			niveau_lr: {
				required: true,
                digits: true
			},
			niveau_eee: {
				required: true,
                digits: true
			},
			niveau_catnat: {
				required: true,
                digits: true
			},
			niveau_refnat: {
				required: true,
                digits: true
			},
			niveau_lsi: {
				required: true,
                digits: true
			},
			niveau_fsd: {
				required: true,
                digits: true
			},
		},
		messages: {
			prenom: { required: "",	minlength: ""},
			nom: { required: "",	minlength: ""},
			login: { required: "",	minlength: ""},
			pw: { required: "",	minlength: ""},
			niveau: {
				required: "",
                digits: "Valeur numérique"
			}
		}
	}); 
});
</script> 
<?php
//------------------------------------------------------------------------------ REF.
$cbn[0]="";
$query="SELECT * FROM referentiels.cbn;";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
    $cbn[$row["id_cbn"]]=$row["lib_cbn"];
pg_free_result ($result);

/*id_cbn du USER*/
$query="SELECT id_cbn FROM applications.utilisateur WHERE id_user = '".$_GET["id_user"]."'";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
$row = pg_fetch_row($result);
$id_cbn = $row[0];



//------------------------------------------------------------------------------ MAIN
//------------------------------------------------------------------------------ EDIT
echo ("<form method=\"POST\" id=\"form1\" name=\"add\" action=\"#\" >");
if (isset($_GET['id']) & !empty($_GET['id']))                                  
{
    $id=$_GET['id'];
    $query="SELECT * FROM ".SQL_schema_app.".".$table." WHERE id_user='".$id."'";
		
//if (DEBUG) echo $query;
    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
    if (pg_num_rows ($result)) {
        echo ("<fieldset><LEGEND> Utilisateur </LEGEND>");
        echo ("<label class=\"preField\">Code</label><input type=\"text\" size=\"7\" maxlength=\"6\" value=\"".$id."\" readonly disabled style=\"background-color:F0F0F0;\"/><br>");
        echo ("<label class=\"preField\">Prénom*, Nom*</label><input type=\"text\" name=\"prenom\" id=\"prenom\" size=\"20\" maxlength=\"60\" value=\"".pg_result($result,0,"prenom")."\" /> <input type=\"text\" name=\"nom\" id=\"nom\" size=\"20\" maxlength=\"60\" value=\"".pg_result($result,0,"nom")."\" /><br>");
        echo ("<label class=\"preField\">Login*, Mot de passe* </label>");
		
		if ($id == $_GET["id_user"] OR $niveau['all'] >= 255) echo ("<input type=\"text\" name=\"login\" id=\"login\" size=\"20\" maxlength=\"70\" value=\"".pg_result($result,0,"login")."\" /> ");
			else echo ("<input disabled style=\"background-color:F0F0F0;\" type=\"text\" name=\"login\" id=\"login\" size=\"20\" maxlength=\"70\" value=\"".pg_result($result,0,"login")."\" /> ");
		if ($id == $_GET["id_user"] OR $niveau['all'] >= 255) echo ("<input type=\"text\" name=\"pw\" id=\"pw\" size=\"20\" maxlength=\"20\" value=\"".pg_result($result,0,"pw")."\" /><br>");
			else echo("<input disabled style=\"background-color:F0F0F0;\" type=\"text\" name=\"pw\" id=\"pw\" size=\"20\" value=\"---privé---\" /><br>");
       		
	    echo ("<label class=\"preField\">Email</label><input type=\"text\" name=\"email\" id=\"email\" style=\"width:30em;\" maxlength=\"70\" value=\"".pg_result($result,0,"email")."\" /><br>");
        echo ("<label class=\"preField\">Site WEB</label><input type=\"text\" name=\"web\" id=\"web\" style=\"width:30em;\" maxlength=\"55\" value=\"".pg_result($result,0,"web")."\" /><br>");
        echo ("<label class=\"preField\">Tél. fixe, portable</label><input type=\"text\" name=\"tel_bur\" id=\"tel_bur\" size=\"20\" maxlength=\"20\" value=\"".pg_result($result,0,"tel_bur")."\" /> <input type=\"text\" name=\"tel_port\" id=\"tel_port\" size=\"20\" maxlength=\"20\"  value=\"".pg_result($result,0,"tel_port")."\" /><br>");
        
		echo ("<label class=\"preField\">Institution</label><select name=\"id_cbn\" >");
		if ($id_cbn == 16)	{
			foreach ($cbn as $key => $value) echo ("<option value=\"$key\" ".($key == pg_result($result,0,"id_cbn") ? "SELECTED" : "").">".$value."</option>");
			} else {echo ("<option value=\"$id_cbn\" SELECTED>".$cbn[$id_cbn]."</option>");}
        echo ("</select><br>");

	   /*Gestion des droits*/		
		foreach ($rubrique as $id_rub => $nom_rub) {
			echo ("<label class=\"preField\">$nom_rub</label><select ".$blocked[$id_rub]." name=\"niveau_".$id_rub."\" >");
			foreach ($user_level as $key => $value) 
				echo ("<option ".($niveau[$id_rub] >= $key ? "" : "disabled")." value=\"$key\" ".($key == pg_result($result,0,"niveau_".$id_rub."") ? "SELECTED" : "").">".$value."</option>");
			echo ("</select>");
			// if ($ref[$id_rub] == 't' OR $niveau[$id_rub] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_".$id_rub."\" id=\"ref_".$id_rub."\" value=\"true\" "); if (pg_result($result,0,"ref_".$id_rub."") == "t") echo "checked/>"; else echo "/>";}
			if ($niveau[$id_rub] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_".$id_rub."\" id=\"ref_".$id_rub."\" value=\"true\" "); if (pg_result($result,0,"ref_".$id_rub."") == "t") echo "checked/>"; else echo "/>";}
			echo ("<br>");
			}
				
        echo ("<label class=\"preField\">Description</label><textarea name=\"descr\" id=\"descr\" style=\"width:30em;\" rows=\"1\">".pg_result($result,0,"descr")."</textarea>");
        echo ("</fieldset>");
    }
    else die ("ID ".$id." > Pas de résultats !");
} 
//------------------------------------------------------------------------------ MAIN
//------------------------------------------------------------------------------ ADD
else 
{                                                                    
        echo ("<fieldset><LEGEND> Utilisateur </LEGEND>");
        echo ("<label class=\"preField\">Prénom*, Nom*</label><input type=\"text\" name=\"prenom\" id=\"prenom\" size=\"20\" maxlength=\"40\" /> <input type=\"text\" name=\"nom\" id=\"nom\" size=\"20\" maxlength=\"20\" /><br>");
        echo ("<label class=\"preField\">Login*, Mot de passe* </label><input type=\"text\" name=\"login\" id=\"login\" size=\"20\" maxlength=\"70\" /> <input type=\"text\" name=\"pw\" id=\"pw\" size=\"20\" maxlength=\"20\" /><br>");
        echo ("<label class=\"preField\">Email</label><input type=\"text\" name=\"email\" id=\"email\" style=\"width:30em;\" maxlength=\"70\" /><br>");
        echo ("<label class=\"preField\">Site WEB</label><input type=\"text\" name=\"web\" id=\"web\" style=\"width:30em;\" maxlength=\"55\" /><br>");
        echo ("<label class=\"preField\">Tél. fixe, portable</label><input type=\"text\" name=\"tel_bur\" id=\"tel_bur\" size=\"20\" maxlength=\"20\" /> <input type=\"text\" name=\"tel_port\" id=\"tel_port\" size=\"20\" maxlength=\"20\" /><br>");
        echo ("<label class=\"preField\">Institution</label><select name=\"id_cbn\" >");
		if ($id_cbn == 16)	{
			foreach ($cbn as $key => $value) echo ("<option value=\"$key\">".$value."</option>");
			} else {echo ("<option value=\"$id_cbn\" SELECTED>".$cbn[$id_cbn]."</option>");}
        echo ("</select><br>");
       
	   /*Gestion des droits*/
		foreach ($rubrique as $id_rub => $nom_rub) {
			echo ("<label class=\"preField\">$nom_rub</label><select ".$blocked[$id_rub]." name=\"niveau_".$id_rub."\" >");
			foreach ($user_level as $key => $value) 
				echo ("<option ".($niveau[$id_rub] >= $key ? "" : "disabled")." value=\"$key\" >".$value."</option>");
			echo ("</select>");
			// if ($ref[$id_rub] == 't' OR $niveau[$id_rub] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_".$id_rub."\" id=\"ref_".$id_rub."\" value=\"true\"/>");}
			if ($niveau[$id_rub] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_".$id_rub."\" id=\"ref_".$id_rub."\" value=\"true\"/>");}
			echo ("<br>");
			}

        echo ("<label class=\"preField\">Description</label><textarea name=\"descr\" id=\"descr\" style=\"width:30em;\" rows=\"1\" ></textarea>");
        echo ("</fieldset>");
}
echo ("</form>");
?>
