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
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
/*
$ref_institut[0]="";
$query="SELECT CODINSTIT,LIBINSTIT FROM ".SQL_schema_ref.".institut ORDER BY LIBINSTIT;";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
    $ref_institut[$row["CODINSTIT"]]=$row["LIBINSTIT"];
pg_free_result ($result);
*/
$query="SELECT id_user,niveau_lr,niveau_eee,niveau_lsi,niveau_catnat,niveau_refnat,ref_lr,ref_eee,ref_lsi,ref_catnat,ref_refnat 
FROM applications.utilisateur WHERE id_user= '".$_GET["id_user"]."';";
// echo $query;
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($query),false);
if (pg_num_rows ($result)) {
	/*niveau de droit*/
	$niveau['lr']=pg_result ($result,0,"niveau_lr");
	$niveau['eee']=pg_result ($result,0,"niveau_eee");
	$niveau['lsi']=pg_result ($result,0,"niveau_lsi");
	$niveau['catnat']=pg_result ($result,0,"niveau_catnat");
	$niveau['refnat']=pg_result ($result,0,"niveau_refnat");
	$niveau['all'] = max($niveau['lr'],$niveau['eee'],$niveau['lsi'],$niveau['catnat'],$niveau['refnat']);
	/*niveau référents*/
	$ref['lr']=pg_result ($result,0,"ref_lr");
	$ref['eee']=pg_result ($result,0,"ref_eee");
	$ref['lsi']=pg_result ($result,0,"ref_lsi");
	$ref['catnat']=pg_result ($result,0,"ref_catnat");
	$ref['refnat']=pg_result ($result,0,"ref_refnat");
	if (($ref['lr'] == 't') OR ($ref['eee'] == 't') OR ($ref['lsi'] == 't') OR ($ref['catnat'] == 't') OR ($ref['refnat'] == 't')) $ref['all']= 't'; else $ref['all']= 'f';
	
	$blocked['lr']= ($ref['lr'] == 't' OR $niveau['lr'] >= 255) ? "" : "disabled";
	$blocked['eee']= ($ref['eee'] == 't' OR $niveau['eee'] >= 255) ? "" : "disabled";
	$blocked['lsi']= ($ref['lsi'] == 't' OR $niveau['lsi'] >= 255) ? "" : "disabled";
	$blocked['catnat']= ($ref['catnat'] == 't' OR $niveau['catnat'] >= 255) ? "" : "disabled";
	$blocked['refnat']= ($ref['refnat'] == 't' OR $niveau['refnat'] >= 255) ? "" : "disabled";
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
$query="SELECT * FROM ".SQL_schema_ref.".cbn;";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
    $cbn[$row["id_cbn"]]=$row["lib_cbn"];
pg_free_result ($result);


//------------------------------------------------------------------------------ MAIN
echo ("<form method=\"POST\" id=\"form1\" name=\"add\" action=\"#\" >");
if (isset($_GET['id']) & !empty($_GET['id']))                                   // EDIT
{
    $id=$_GET['id'];
    $query="SELECT * FROM ".SQL_schema_app.".".$table." WHERE id_user='".$id."'";
//if (DEBUG) echo $query;
    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
    if (pg_num_rows ($result)) {
        echo ("<fieldset><LEGEND> Utilisateur </LEGEND>");
        echo ("<label class=\"preField\">Code</label><input type=\"text\" size=\"7\" maxlength=\"6\" value=\"".$id."\" readonly/><br>");
        echo ("<label class=\"preField\">Prénom*, Nom*</label><input type=\"text\" name=\"prenom\" id=\"prenom\" size=\"20\" maxlength=\"20\" value=\"".pg_result($result,0,"prenom")."\" /> <input type=\"text\" name=\"nom\" id=\"nom\" size=\"20\" maxlength=\"20\" value=\"".pg_result($result,0,"nom")."\" /><br>");
        echo ("<label class=\"preField\">Login*, Mot de passe* </label><input type=\"text\" name=\"login\" id=\"login\" size=\"20\" maxlength=\"20\" value=\"".pg_result($result,0,"login")."\" /> <input type=\"text\" name=\"pw\" id=\"pw\" size=\"20\" maxlength=\"20\" value=\"".pg_result($result,0,"pw")."\" /><br>");
        echo ("<label class=\"preField\">Email</label><input type=\"text\" name=\"email\" id=\"email\" style=\"width:30em;\" maxlength=\"70\" value=\"".pg_result($result,0,"email")."\" /><br>");
        echo ("<label class=\"preField\">Site WEB</label><input type=\"text\" name=\"web\" id=\"web\" style=\"width:30em;\" maxlength=\"55\" value=\"".pg_result($result,0,"web")."\" /><br>");
        echo ("<label class=\"preField\">Tél. fixe, portable</label><input type=\"text\" name=\"tel_bur\" id=\"tel_bur\" size=\"20\" maxlength=\"20\" value=\"".pg_result($result,0,"tel_bur")."\" /> <input type=\"text\" name=\"tel_port\" id=\"tel_port\" size=\"20\" maxlength=\"20\"  value=\"".pg_result($result,0,"tel_port")."\" /><br>");
        echo ("<label class=\"preField\">Institution</label><select name=\"id_cbn\" >");
        foreach ($cbn as $key => $value) 
            echo ("<option value=\"$key\" ".($key == pg_result($result,0,"id_cbn") ? "SELECTED" : "").">".$value."</option>");
        echo ("</select><br>");
		
		
		
        echo ("<label class=\"preField\">Niveau LR</label><select ".$blocked['lr']." name=\"niveau_lr\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" ".($key == pg_result($result,0,"niveau_lr") ? "SELECTED" : "").">".$value."</option>");
        echo ("</select>");
        if ($ref['lr'] == 't' OR $niveau['lr'] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_lr\" id=\"ref_lr\" value=\"true\" "); if (pg_result($result,0,"ref_lr") == "t") echo "checked/>"; else echo "/>";}
        echo ("<br>");
        echo ("<label class=\"preField\">Niveau EEE</label><select ".$blocked['eee']." name=\"niveau_eee\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" ".($key == pg_result($result,0,"niveau_eee") ? "SELECTED" : "").">".$value."</option>");
        echo ("</select>");
        if ($ref['eee'] == 't' OR $niveau['eee'] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_eee\" id=\"ref_eee\" value=\"true\" "); if (pg_result($result,0,"ref_eee") == "t") echo "checked/>"; else echo "/>";}
        echo ("<br>");
        echo ("<label class=\"preField\">Niveau CAT_NAT</label><select ".$blocked['catnat']." name=\"niveau_catnat\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" ".($key == pg_result($result,0,"niveau_catnat") ? "SELECTED" : "").">".$value."</option>");
        echo ("</select>");
        if ($ref['catnat'] == 't' OR $niveau['catnat'] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_catnat\" id=\"ref_catnat\" value=\"true\" "); if (pg_result($result,0,"ref_catnat") == "t") echo "checked/>"; else echo "/>";}
        echo ("<br>");
        echo ("<label class=\"preField\">Niveau REF NAT</label><select ".$blocked['refnat']." name=\"niveau_refnat\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" ".($key == pg_result($result,0,"niveau_refnat") ? "SELECTED" : "").">".$value."</option>");
        echo ("</select>");
		if ($ref['refnat'] == 't' OR $niveau['refnat'] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_refnat\" id=\"ref_refnat\" value=\"true\" "); if (pg_result($result,0,"ref_refnat") == "t") echo "checked/>"; else echo "/>";}
        echo ("<br>");
        echo ("<label class=\"preField\">Niveau LSI</label><select ".$blocked['lsi']." name=\"niveau_lsi\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" ".($key == pg_result($result,0,"niveau_lsi") ? "SELECTED" : "").">".$value."</option>");
        echo ("</select>");
        if ($ref['lsi'] == 't' OR $niveau['lsi'] >= 255) {echo (" Référent? <input type=\"checkbox\" name=\"ref_lsi\" id=\"ref_lsi\" value=\"true\" "); if (pg_result($result,0,"ref_lsi") == "t") echo "checked/>"; else echo "/>";}
        echo ("<br>");
        echo ("<label class=\"preField\">Description</label><textarea name=\"descr\" id=\"descr\" style=\"width:30em;\" rows=\"1\">".pg_result($result,0,"descr")."</textarea>");
        echo ("</fieldset>");
    }
    else die ("ID ".$id." > Pas de résultats !");
} else {                                                                        // ADD
        echo ("<fieldset><LEGEND> Utilisateur </LEGEND>");
        echo ("<label class=\"preField\">Prénom*, Nom*</label><input type=\"text\" name=\"prenom\" id=\"prenom\" size=\"20\" maxlength=\"20\" /> <input type=\"text\" name=\"nom\" id=\"nom\" size=\"20\" maxlength=\"20\" /><br>");
        echo ("<label class=\"preField\">Login*, Mot de passe* </label><input type=\"text\" name=\"login\" id=\"login\" size=\"20\" maxlength=\"20\" /> <input type=\"text\" name=\"pw\" id=\"pw\" size=\"20\" maxlength=\"20\" /><br>");
        echo ("<label class=\"preField\">Email</label><input type=\"text\" name=\"email\" id=\"email\" style=\"width:30em;\" maxlength=\"70\" /><br>");
        echo ("<label class=\"preField\">Site WEB</label><input type=\"text\" name=\"web\" id=\"web\" style=\"width:30em;\" maxlength=\"55\" /><br>");
        echo ("<label class=\"preField\">Tél. fixe, portable</label><input type=\"text\" name=\"tel_bur\" id=\"tel_bur\" size=\"20\" maxlength=\"20\" /> <input type=\"text\" name=\"tel_port\" id=\"tel_port\" size=\"20\" maxlength=\"20\" /><br>");
        echo ("<label class=\"preField\">Institution</label><select name=\"id_cbn\" >");
        foreach ($cbn as $key => $value) 
            echo ("<option value=\"$key\" >".$value."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Niveau LR</label><select name=\"niveau_lr\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" >".$value."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Niveau EEE</label><select name=\"niveau_eee\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" >".$value."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Niveau CAT NAT</label><select name=\"niveau_catnat\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" >".$value."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Niveau REF NAT</label><select name=\"niveau_refnat\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" >".$value."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Niveau LSI</label><select name=\"niveau_lsi\" >");
        foreach ($user_level as $key => $value) 
            echo ("<option value=\"$key\" >".$value."</option>");
        echo ("</select><br>");
        echo ("<label class=\"preField\">Description</label><textarea name=\"descr\" id=\"descr\" style=\"width:30em;\" rows=\"1\" ></textarea>");
        echo ("</fieldset>");
}
echo ("</form>");
?>
