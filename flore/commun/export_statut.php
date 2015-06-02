<?php
//------------------------------------------------------------------------------//
//  commun/export_statut.php                                                    //
//                                                                              //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
require_once ("../../_INCLUDE/constants.inc.php");

//------------------------------------------------------------------------------ PARMS.
$nom_fichier=$_GET['f']; 
if (strstr ($nom_fichier,".") == false) $nom_fichier.=".zip";

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){
	$( "a.download").button({text:true});
});
</script> 

<?php
//------------------------------------------------------------------------------ MAIN

echo ("<p align=center><img src=\"../../_GRAPH/check.png\" border=\"0\" />");
echo ("<br>");
echo ("<font size=4>Export terminé</font><br>");
echo ("<br><a class=download href=\"../commun/download.php?f=".EXPORT_PATH.$nom_fichier."\" target=\"_blank\" >"."Télécharger le fichier"."</a>");


?>

