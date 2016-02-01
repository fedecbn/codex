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
$id = $_GET['id'] != null ? $_GET['id'] : null;
$cbn_name = $_GET['name'] != null ? $_GET['name'] : null;

// $path = "/home/hub/".$cbn_name;
$path = "../../_DATA/".$cbn_name;
$files = scandir($path );
$typejdd = array (
	"data" => "data",
	"taxa" => "taxa",
	"hybride" => "hybride"
	);
	
//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
// $db=sql_connect (SQL_base);
// if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.
//------------------------------------------------------------------------------ CONSTANTES du module
// /*récupération des rubriques*/
/*référents et  niveau de droits*/

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){
	$("#form1").validate({
		rules: {
			jdd: {
				required: true,
                minlength: 2
			},
		},
		messages: {
			jdd: { required: "",	minlength: ""}
			}
		}
	)}); 
</script> 
<?php
//------------------------------------------------------------------------------ REF.
if (isset($_GET['id']) & !empty($_GET['id']))  
{
//------------------------------------------------------------------------------ MAIN
//------------------------------------------------------------------------------ EDIT
echo ("<form method=\"POST\" id=\"form1\" name=\"add\" action=\"#\" >");
if (isset($_GET['id']) & !empty($_GET['id']))                                  
	{
    $id=$_GET['id'];
		
	echo ("<fieldset><LEGEND> Utilisateur </LEGEND>");
		metaform_sel ("Type de jeu de données",null,null,$typejdd,"typ_jdd","data");
    echo ("</fieldset>");
    }
    else die ("> Pas de résultats !");
}
//------------------------------------------------------------------------------ MAIN
//------------------------------------------------------------------------------ ADD
else die ("> Pas de résultats !");
echo ("</form>");
?>
