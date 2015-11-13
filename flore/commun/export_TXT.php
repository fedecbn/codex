<?php
//------------------------------------------------------------------------------//
//  commun/export_TXT.php                                                       //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("commun.inc.php");

//------------------------------------------------------------------------------ PARMS.
if (isset($_POST['t']) & !empty($_POST['t'])) $titre=$_POST['t'];
if (isset($_POST['f']) & !empty($_POST['f'])) $nom_fichier=$_POST['f'];
if (isset($_POST['q']) & !empty($_POST['q'])) $query=stripslashes ($_POST['q']);
if (isset($_POST['i']) & !empty($_POST['i'])) $pk=stripslashes ($_POST['i']);

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (strlen ($_POST['select']) > 0) {                                            // Sélection ?
    $sWhere = "( "; 
    $pairs = explode("&",$_POST['select']);
    foreach( $pairs as $key=>$value)
        $sWhere .= $pk."=".sql_format(ltrim ($value,"id="))." OR ";
    
    $sWhere=rtrim ($sWhere,"OR ");
    $sWhere .= " ) "; 
    $query2= "$query AND $sWhere";
    // echo "export_TXT > sWhere=".$sWhere;
} else {                                                                        // Liste totale
    $query2=$query;
}
echo "export_TXT > sql=".$query2."<br>";
export_txt ($nom_fichier,$query2);

//------------------------------------------------------------------------------ FONCTIONS
?>
