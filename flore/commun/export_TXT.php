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
define ("DEBUG",true);
if (DEBUG) foreach($_POST as $key => $val) echo '$_POST["'.$key.'"]='.$val.'<br />'; //ici on affiche dans firebug les variable $_POST

//------------------------------------------------------------------------------ PARMS.
//les paramètres sont ceux de la fonction exportFunc utilisée dans le bouton #export-TXT-button. Les valeurs sont définies dans index.php et commun.inc.php
if (isset($_POST['t']) & !empty($_POST['t'])) $titre=$_POST['t']; 
if (isset($_POST['f']) & !empty($_POST['f'])) $nom_fichier=$_POST['f']; //le nom de fichier correspond à l'id export-TXT-fichier dans index.php (qui appelle les cariables globales $id_page et $id_user) 
if (isset($_POST['q']) & !empty($_POST['q'])) $query=stripslashes ($_POST['q']); //la query correspond à l'id export-TXT-query de type hidden qui se retrouve dans index.php (qui appelle une query de commun.inc.php)
if (isset($_POST['i']) & !empty($_POST['i'])) $pk=stripslashes ($_POST['i']); //l'identifiant correspond à l'id export-TXT-query-id de type hidden qui se retrouve dans index.php (qui appelle une query de commun.inc.php)

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
$_POST['select']=str_replace('%5B%5D','',$_POST['select']); //permet de supprimer des caractères spéciaux générés pour le xml (ajaxSubmit)
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

export_txt ($nom_fichier,$query2); //fonction contenue dans functions.inc.php


//------------------------------------------------------------------------------ FONCTIONS
?>
