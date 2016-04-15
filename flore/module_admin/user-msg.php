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

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){

	$("#form1").validate({
		rules: {
			id_page: {
				required: true,
                minlength: 3
			},
		},
		messages: {
			id_page: { required: "",	minlength: ""}
		}
	});

//------------------------------------------------------------------------------ Editeur wysiwyg

    $(".editor").jqte({
        linktypes: ["URL site WEB", "Adresse email", "Image"]
    });

});
</script> 
<?php
//------------------------------------------------------------------------------ REF.
$select = $_GET['id'];

//------------------------------------------------------------------------------ MAIN

if (!empty ($select))
	{
	echo ("<form method=\"POST\" id=\"form1\" name=\"add\" action=\"#\" >");	
	echo ("<fieldset><LEGEND> Sujet </LEGEND>");
	echo ("<input type=\"text\" name=\"sujet\" id=\"sujet\" size=\"90\" maxlength=\"90\" value = \"[Codex] \" /><br>");
	echo ("</fieldset>");
	echo ("<textarea name=\"msg-txt\" class=\"editor\" id=\"msg-txt\" ></textarea>");
	echo ("</form>");	
	}
else 
	{
	echo ("Veuillez séléctionner au minimum un utilisateur");
	}

?>
