<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr" >
<?php
//------------------------------------------------------------------------------//
//  commun/access_denied.php                                                    //
//                                                                              //
//  Version 1.00  13/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
// $_SESSION = array();
// session_destroy();

//------------------------------------------------------------------------------ MAIN
echo ("<body>");

echo ("<center><br><br><br><br>");
echo ("<a href=\"../index.php\"><img src=\"../../_GRAPH/acces_denied.jpg\" border=\"0\" /></a><br><br>");
echo ("<font color=\"#FF0000\" size=\"3\"><b> Désolé, vous n'avez pas les droits suffisants pour accéder à cette page</b></font><br /><br /><br />");
echo ("<a href=\"../home/index.php\"> Retour au menu </a></center>");

echo ("</body></html>");
die ();

?>
