<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<?php
//------------------------------------------------------------------------------//
//  module_atlas_public/fiche_taxon.php                                         //
//                                                                              //
//  Application WEB 'Atlas'                                                     //
//  URL : www.atlas.cbnmled.fr                                                  //
//                                                                              //
//  Version 1.00  24/06/14 - OlGa / CBNMED                                      //
//  Version 1.01  27/06/14 - MaJ mise en page                                   //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start ();
include ("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau'];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];
$user_instit=$_SESSION['user_instit'];
$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ PARMS.
if (isset($_GET['id']) & !empty($_GET['id'])) $id=$_GET['id'];

//------------------------------------------------------------------------------ DEF.

//------------------------------------------------------------------------------ VAR.
$table="atlas11";

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.lightbox-0.5.js"></script>

<script type="text/javascript" language="javascript" src="js/fiche_taxon.js"></script>
<?php
//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect (SQL_server,SQL_user,SQL_pass) or fatal_error ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db (SQL_base,$db) or fatal_error ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ MAIN
html_header ("iso-8859-1","","");
echo ("<body>");
echo ("<div id=\"page\">");
echo ("<img src=\"../../_GRAPH/theme/home1.png\" align=left border=\"0\" >");
echo ("<div class=\"fiche\">");
echo ("<font size=2><center>Atlas de la Flore patrimoniale de l'Aude - Projet SINP</center></font>");
echo ("<input type=\"hidden\" id=\"fiche-id\" value=\"".$id."\" />");
aff_atlas11 ($id);
echo ("<br><center><button id=\"export-PDF-button\"><u>E</u>xporter en PDF</button> <button id=\"close-button\"><u>F</u>ermer</button></center><br>");
echo ("<div id=\"fiche-export-dialog\" ></div>");
echo ("</div>");                                                                // page
footer ();
echo ("</div>");                                                                // page
echo ("</body></html>");
mysql_close ($db);
//------------------------------------------------------------------------------ FONCTIONS

function aff_atlas11 ($id) {
global $db,$db_selected,$table;

$ouinon_txt=array ("Non","Oui");

$typef_txt=array("",
                "Priorité",
                "PNA",
                "Ancien",
                "A voir",
                "Messicole",
                "Orchidée",
                "Rudérale");

$choro_txt=array("",
                "choro 1",
                "choro 2");

$biolo_txt=array("",
                "Chaméphyte",
                "Géophyte",
                "Hélophyte",
                "Hémicryptophyte",
                "Hydrophyte",
                "Phanérophyte",
                "Thérophyte",
                "Phanérophyte lianeuse",
                "Géophyte rhizomateuse",
                "Nanophanérophyte");

$strat_txt=array("",
                "S",
                "SR",
                "R",
                "RC",
                "C",
                "SC",
                "CSR");

$cycle_txt=array("",
                "Annuel",
                "Vivace polycarpique",
                "Vivace monocarpique",
                "Annuel à Vivace polycarpique",
                "Vivace monocarpique à Vivace polycarpique");

$geol_txt=array("",
                "Calcicole stricte",
                "Préf. Calcaire",
                "Préf. Silice",
                "Silicicole stricte",
                "Indifférent");

$znieff_txt=array("",
                "Déterminante",
                "Déterminante à critère (rudérale et messicole)",
                "Déterminante Massif Central",
                "Déterminante Pyrénées",
                "Remarquable");

$tabl_txt=array("",
                "Négligeable",
                "Ponctuelle",
                "Forte");

    $query="SELECT * FROM ".$table." WHERE id_atlas=".$id;
    $result=mysql_query($query,$db) or fatal_error ("Erreur mySQL : ".mysql_error($db));
    $carte = mysql_result($result,0,"id_atlas").".jpg";
    $carte2 = mysql_result($result,0,"id_atlas")."_carte11.jpg";
//    $image1 = mysql_result($result,0,"image1");
//    $image2 = mysql_result($result,0,"image2");
    $image3 = mysql_result($result,0,"image3");
    $image4 = mysql_result($result,0,"image4");
    $image5 = mysql_result($result,0,"image5");
    $image6 = mysql_result($result,0,"image6");
    $image1t = mysql_result($result,0,"image1t");
    $image2t = mysql_result($result,0,"image2t");
    $image3t = mysql_result($result,0,"image3t");
    $image4t = mysql_result($result,0,"image4t");
    $image5t = mysql_result($result,0,"image5t");
    $image6t = mysql_result($result,0,"image6t");
    echo ("<div class=\"bloc3\">");
    echo ("<h5>".mysql_result($result,0,"taxon_atlas")."</h5>");

    echo ("<table class=admin width=\"100%\" border=0><tr valign=top><td>");
    if (strlen (mysql_result($result,0,"syno"))>0) echo ("Synonymes : ".mysql_result($result,0,"syno")."<br><br>");
    echo ("<font size=4><i>".mysql_result($result,0,"famille")."</i></font>");
//    echo ("<b>Nom vernaculaire  : </b><h4>".mysql_result($result,0,"nom_fr")."</h4>");
    echo ("<h4>".mysql_result($result,0,"nom_fr")."</h4>");
    echo (mysql_result($result,0,"comm_choro")."<br>");

    if (strlen (mysql_result($result,0,"descr"))>0) echo ("<div class=\"bloc_txt\"><cite>Description</cite>".mysql_result($result,0,"descr")."</div>");
    if (strlen (mysql_result($result,0,"biolo"))>0) echo ("<b>Type biologique : </b>".$biolo_txt[mysql_result($result,0,"biolo")]."<br>");
    if (strlen (mysql_result($result,0,"pheno"))>0) echo ("<b>Floraison  : </b>".mysql_result($result,0,"pheno")."<br>");
    echo ("<br>");

    echo ("<font size=4>Aire de répartition</font><br>");
    if (strlen (mysql_result($result,0,"choro"))>0) echo ("<b>Type chorologique  : </b>".mysql_result($result,0,"choro")."<br>");
    echo ("<br>");
    if (strlen (mysql_result($result,0,"repart_gl"))>0) echo ("<div class=\"bloc_txt\"><cite>Générale</cite>".mysql_result($result,0,"repart_gl")."</div>");
    if (strlen (mysql_result($result,0,"repart_dep"))>0) echo ("<div class=\"bloc_txt\"><cite>Aude</cite>".mysql_result($result,0,"repart_dep")."</div><br>");

    echo ("Nombre de communes de présence<br /><table class=fiche width=\"500\"><tr class=\"fiche\">");
    echo ("<th>Observations</th>");
    echo ("<th>avant 1990</th>");
    echo ("<th>après 1990</th>");
    echo ("<th>total</th>");
    echo ("</tr><tr>");
    echo ("<td class=\"admin2\">Aude</td>");
    echo ("<td class=\"admin2\">".mysql_result($result,0,"aude_inf90")."</td>");
    echo ("<td class=\"admin2\">".mysql_result($result,0,"aude_rec")."</td>");
    echo ("<td class=\"admin2\">".mysql_result($result,0,"aude_tot")."</td>");
    echo ("</tr><tr>");
    echo ("<td class=\"admin2\">LR</td>");
    echo ("<td class=\"admin2\">".mysql_result($result,0,"lr_inf90")."</td>");
    echo ("<td class=\"admin2\">".mysql_result($result,0,"lr_rec")."</td>");
    echo ("<td class=\"admin2\">".mysql_result($result,0,"lr_tot")."</td>");
    echo ("</tr></table>");

    echo ("<br>");
    if (strlen (mysql_result($result,0,"ecologie"))>0) echo ("<div class=\"bloc_txt\"><cite>Ecologie</cite>".mysql_result($result,0,"ecologie")."</div><br>");

    if (strlen (mysql_result($result,0,"geol"))>0) echo ("<b>Géologie : </b>".$geol_txt[mysql_result($result,0,"geol")]."<br>");
    echo ("<b>Étage de végétation : </b>");
    if (mysql_result($result,0,"etage_coll")) echo ("Collinéen ");
    if (mysql_result($result,0,"etage_meso")) echo ("Mésoméditerranéen ");
    if (mysql_result($result,0,"etage_mont")) echo ("Montagnard ");
    if (mysql_result($result,0,"etage_suba")) echo ("Subalpin ");
    if (mysql_result($result,0,"etage_alpi")) echo ("Alpin ");
    echo ("<br><br>");

    if (strlen (mysql_result($result,0,"conserv"))>0) echo ("<div class=\"bloc_txt\"><cite>Conservation et menaces</cite>".mysql_result($result,0,"conserv")."</div>");

    echo ("Menaces récurrentes<br /><table class=fiche width=\"500\"><tr class=\"fiche\">");
    echo ("<th>Aménagements<br>urbanisation</th>");
    echo ("<th>Dynamique<br>naturelle</th>");
    echo ("<th>Usages</th>");
    echo ("<th>Loisirs</th>");
    echo ("<th>Cueillette</th>");
    echo ("</tr><tr>");
    echo ("<td class=\"admin2\">".$tabl_txt[mysql_result($result,0,"amen")]."</td>");
    echo ("<td class=\"admin2\">".$tabl_txt[mysql_result($result,0,"dyna")]."</td>");
    echo ("<td class=\"admin2\">".$tabl_txt[mysql_result($result,0,"usages")]."</td>");
    echo ("<td class=\"admin2\">".$tabl_txt[mysql_result($result,0,"loisir")]."</td>");
    echo ("<td class=\"admin2\">".$tabl_txt[mysql_result($result,0,"cueill")]."</td>");
    echo ("</tr></table><br />");
    echo ("<b>Vulnérabilité dans l'Aude : </b>".$ouinon_txt[mysql_result($result,0,"vul_dep")]."<br><br>");
    echo ("<div class=\"bloc_txt\"><cite>Statuts</cite>");
    if (mysql_result($result,0,"dh")==1) echo ("DH (Directive Habitat)<br>");
    if (mysql_result($result,0,"cb")==1) echo ("CB (Convention de Berne)<br>");
    if (mysql_result($result,0,"pn")==1) echo ("PN (Protection Nationale)<br>");
    if (mysql_result($result,0,"pr")==1) echo ("PR (Protection Régionale)<br>");
    if (mysql_result($result,0,"lr1")==1) echo ("Lr1 (Livre Rouge tome 1)<br>");
    if (mysql_result($result,0,"lr2")==1) echo ("Lr2 (Livre Rouge tome 2)<br>");
    if (mysql_result($result,0,"pna")==1) echo ("PNA (Plan National d'Action)<br>");
    if (mysql_result($result,0,"scap")==1) echo ("SCAP (Stratégie Création Aire Protégée)<br>");
    if (mysql_result($result,0,"znieff")>0) echo ("ZNIEFF LR - ".$znieff_txt[mysql_result($result,0,"znieff")]."<br>");
    if (mysql_result($result,0,"ens")==1) echo ("ENS Aude<br>");
    if (mysql_result($result,0,"ss")==1) echo ("Sans statut<br>");
    echo ("<br>".mysql_result($result,0,"comm_statuts")."</div>");
    if (strlen (mysql_result($result,0,"compl"))>0) echo ("<div class=\"bloc_txt\"><cite>Compléments</cite>".mysql_result($result,0,"compl")."</div>");
    echo ("<br />");
    if (mysql_result($result,0,"fiche_type") == "6" ) 
        echo ("<b>Auteurs : </b>F. Arabia, D. Barreau, G. Coirié, B. Le Roux, J.M. Lewin, J. Sanègre, D. Vizcaino, C. Plassart<br>");
    else
        echo ("<b>Auteurs : </b>F. Andrieu, D. Barreau, C. Plassart, E. Thys<br>");
    echo ("<b>Date de rédaction : </b>15 mars 2014<br>");
    echo ("<br /><br />");
    echo ("</td><td width=400 align=center>");

//------------------------------------------------------------------------------ Cartes & Photos
//echo ATLAS11_CARTES_PATH.$carte;
    if (file_exists (ATLAS11_CARTES_PATH.$carte)) {
        aff_image_lightBox (ATLAS11_CARTES_PATH.$carte,350,350,ATLAS11_CARTES_PATH.$carte,"",$image1t);
        echo $image1t."<br>"; 
    }
    if (file_exists (ATLAS11_CARTES_PATH.$carte2)) {
        aff_image_lightBox (ATLAS11_CARTES_PATH.$carte2,350,350,ATLAS11_CARTES_PATH.$carte2,"",$image2t);
        echo $image2t."<br><br>"; 
    }
    if (file_exists (ATLAS11_PHOTOS_PATH.$image3)) {
        aff_image_lightBox (ATLAS11_PHOTOS_PATH.$image3,350,350,ATLAS11_PHOTOS_PATH.$image3,"",$image3t);
        echo $image3t."<br>"; 
    }
    if (file_exists (ATLAS11_PHOTOS_PATH.$image4)) {
        aff_image_lightBox (ATLAS11_PHOTOS_PATH.$image4,350,350,ATLAS11_PHOTOS_PATH.$image4,"",$image4t);
        echo $image4t."<br>"; 
    }
    if (file_exists (ATLAS11_PHOTOS_PATH.$image5)) {
        aff_image_lightBox (ATLAS11_PHOTOS_PATH.$image5,350,350,ATLAS11_PHOTOS_PATH.$image5,"",$image5t);
        echo $image5t."<br>"; 
    }
    if (file_exists (ATLAS11_PHOTOS_PATH.$image6)) {
        aff_image_lightBox (ATLAS11_PHOTOS_PATH.$image6,350,350,ATLAS11_PHOTOS_PATH.$image6,"",$image6t);
        echo $image6t; 
    }
    echo ("</td></tr></table>");
}

//------------------------------------------------------------------------------ FONCTIONS
function aff_image_lightBox ($image,$max_larg,$max_haut,$lien,$align,$titre) {
    list ($larg,$haut)=@getimagesize($image);
    if ($larg==0 || $haut==0) return;
    $x_ratio = $max_larg / $larg;
    $y_ratio = $max_haut / $haut;
    if(($larg <= $max_larg) && ($haut <= $max_haut)){
        $tn_larg = $larg;
        $tn_haut = $haut;
        }elseif (($x_ratio * $haut) < $max_haut){
            $tn_haut = ceil($x_ratio * $haut);
            $tn_larg = $max_larg;
        }else{
            $tn_larg = ceil($y_ratio * $larg);
            $tn_haut = $max_haut;
    }
//  echo ("image (".$larg.",".$haut.")<br>");
//  echo ("convert (".$tn_larg.",".$tn_haut.")<br>");
    echo ("<div id=\"lightbox\">");
        if (strlen ($lien)>0) echo ("<a href=\"".$lien."\" title=\"".$titre."\"  ><img src=\"".$image."\" width=\"".$tn_larg."\" height=\"".$tn_haut."\" border=\"0\" align=\"".$align."\" title=\"".$titre."\" rel=\"".$titre."\" /></a>");
        else echo ("<img src=\"".$image."\" width=\"".$tn_larg."\" height=\"".$tn_haut."\" border=\"0\" align=\"".$align."\" title=\"".$titre."\" />");
    echo ("</div>");    
}

?>
