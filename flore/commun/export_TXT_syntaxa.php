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
foreach($_POST as $key => $val) echo '$_POST["'.$key.'"]='.$val.'<br />';
//------------------------------------------------------------------------------ PARMS.
//tous ces paramètres sont dans _INCLUDE/js/gestion.js dans la fonction: exportFunc qui est elle même utilisée quand on clique sur le bouton d'export (export-TXT-button dans gestion.js)
if (isset($_POST['t']) & !empty($_POST['t'])) $titre=$_POST['t'];
if (isset($_POST['f']) & !empty($_POST['f'])) $nom_fichier=$_POST['f'];
if (isset($_POST['q']) & !empty($_POST['q'])) $query=stripslashes ($_POST['q']);
//if (isset($_POST['i']) & !empty($_POST['i'])) $pk=stripslashes ($_POST['i']);
$pk="\"codeEnregistrementSyntax\"";


//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
$_POST['select']=str_replace('%5B%5D','',$_POST['select']);
//$id=str_replace('id%5B%5D=','',$_POST['select']);

//$_POST["f"]=Liste_fiches_ADMI1.txt
//$_POST["q"]=SELECT * FROM syntaxa.st_syntaxon AS t where
//$_POST["i"]=t.uid
//$_POST["select"]=id%5B%5D=CBIG_syntaxon_3964&id%5B%5D=CBIG_syntaxon_3965

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
