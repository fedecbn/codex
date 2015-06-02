<?php
//------------------------------------------------------------------------------//
//  module_admin/text-form.php                                               //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

include("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$table="utilisateur";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ VAR.
$table="pres";
$lang_ico=array('fr.gif','it.gif','en.gif');

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
//------------------------------------------------------------------------------ MAIN
echo ("<form method=\"POST\" id=\"form1\" name=\"add\" action=\"#\" >");
if (isset($_GET['id']) & !empty($_GET['id']))                                   // EDIT
{
    $id=$_GET['id'];
    $query="SELECT * FROM ".SQL_schema_app.".".$table." WHERE id_pres='".$id."';";
//if (DEBUG) echo $query."<br>";
    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
    if (pg_num_rows ($result)) {
        echo ("<img src=\"../../_GRAPH/".$lang_ico[pg_result($result,0,"lang")]."\" >&nbsp;&nbsp;&nbsp;<font size=5 >".pg_result($result,0,"titre")."</font><br>");
        echo ("<textarea name=\"pres\" class=\"editor\" id=\"page_content\" >".pg_result($result,0,"pres")."</textarea>");
    }
    else die ("ID ".$id." > Pas de résultats !");
}
echo ("</form>");
?>

