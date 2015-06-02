<?php
header('Content-Type: text/html; charset=ISO-8859-1'); 
//------------------------------------------------------------------------------//
//  atlas_11/commun/export_PDF.php                                              //
//                                                                              //
//  Application WEB 'Atlas'                                                     //
//  URL : www.atlas.cbnmled.fr                                                  //
//                                                                              //
//  Version 1.00  26/06/14 - OlGa / CBNMED                                      //
//  Version 1.01  27/06/14 - MaJ encodage UTF-8                                 //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
//include ("commun.inc.php");
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/constants.inc.php");
require_once ("../../_INCLUDE/fpdf.php");
define ("DEBUG_EXPORT",false);

//------------------------------------------------------------------------------ VAR.
if (isset($_POST['id']) & !empty($_POST['id'])) $id=$_POST['id'];
$nom_fichier="Export_fiche_atlas11";

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or die ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base,$db) or die ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" >
$(document).ready(function(){

	$( "a.download").button({text: true});

});
</script> 
<?php
//------------------------------------------------------------------------------ MAIN
if ($id != "") {  
    $query="SELECT * FROM atlas11 WHERE id_atlas=".$id;
    if (DEBUG_EXPORT) echo "<br>export_PDF > ID=".$id;
    if (DEBUG_EXPORT) echo "<br>export_PDF > path=".ATLAS11_PDF_PATH;
    if (DEBUG_EXPORT) echo "<br>export_PDF > query=".$query;
    export_PDF ($nom_fichier,$query);
}

//		    echo ("<br><br><a class=download href=\"".utf8_encode($file)."\" target=\"_blank\" >".utf8_decode("Télécharger le fichier")."</a>");
//    echo ("<br><br><a class=download href=\"../../_INCLUDE/download.php?f=".utf8_encode($file)."\" target=\"_blank\" >".utf8_decode("Télécharger le fichier")."</a>");

//------------------------------------------------------------------------------ FONCTIONS

function export_PDF ($fichier,$query) {
    global $db,$db_selected;
    $img=true;

$ouinon_txt=array("Non","Oui");

$redac_txt=array("",
                "CP",
                "DB",
                "FA",
                "JM",
                "BL",
                "ET");

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

$tabl_txt=array("",
                "Négligeable",
                "Ponctuelle",
                "Forte");

$znieff_txt=array("",
                "Déterminante",
                "Déterminante à critère (rudérale et messicole)",
                "Déterminante Massif Central",
                "Déterminante Pyrénées",
                "Remarquable");

    class PDF extends FPDF {
        function Header() {
            $this->SetTextColor(0);
            $this->SetFont("Arial","B",8);
            $this->Cell(0,0,"Atlas de la Flore patrimoniale de l'Aude - Projet SINP",0,0,'C');
        }
        function AjouterChapitre ($titre,$txt) {
            $this->SetTextColor(0);
            if ($titre<>"") $this->TitreChapitre($titre);
            if ($txt<>"") $this->CorpsChapitre($txt);
        }
        function TitreChapitre ($titre) {
            $this->SetFont('Arial','B',11);
            $this->SetFillColor(230);
            $this->Cell(0,6,$titre,0,1,'L',false);
//            $this->Ln(1);
        }
        function CorpsChapitre ($txt) {
            $this->SetFont('Arial','',10);
            $this->MultiCell(100,5,$txt);
            $this->Ln();
        }
        function AjouterInfo ($titre,$value) {
            $this->SetFont('Arial','B',10);
            $this->Cell(10,6,$titre." : ",0,0,'L',false);
            $this->SetFont('Arial','',10);
            $this->Cell(0,6,$value,0,1,'L',false);
            $this->Ln(1);
        }
        function WriteHTML($html) {
            $this->SetFont('Arial','',10);
            $html = str_replace("\n",' ',$html);
            $a = preg_split('/<(.*)>/U',$html,-1,PREG_SPLIT_DELIM_CAPTURE);
            foreach($a as $i=>$e)
            {
                if($i%2==0)
                {
                    if($this->HREF)
                        $this->PutLink($this->HREF,$e);
                    else
                        $this->Write(5,$e);
                } else {
                    if($e[0]=='/')
                        $this->CloseTag(strtoupper(substr($e,1)));
                    else
                    {
                        $a2 = explode(' ',$e);
                        $tag = strtoupper(array_shift($a2));
                        $attr = array();
                        foreach($a2 as $v)
                        {
                            if(preg_match('/([^=]*)=["\']?([^"\']*)/',$v,$a3))
                                $attr[strtoupper($a3[1])] = $a3[2];
                        }
                        $this->OpenTag($tag,$attr);
                    }
                }
            }
        }
        function OpenTag($tag, $attr)
        {
            // Balise ouvrante
            if($tag=='B' || $tag=='I' || $tag=='U')
                $this->SetStyle($tag,true);
            if($tag=='A')
                $this->HREF = $attr['HREF'];
            if($tag=='BR')
                $this->Ln(5);
        }
        function CloseTag($tag) {
            // Balise fermante
            if($tag=='B' || $tag=='I' || $tag=='U')
                $this->SetStyle($tag,false);
            if($tag=='A')
                $this->HREF = '';
        }
        function SetStyle ($tag,$enable) {
            // Modifie le style et sélectionne la police correspondante
            $this->$tag += ($enable ? 1 : -1);
            $style = '';
            foreach(array('B', 'I', 'U') as $s)
            {
                if($this->$s>0)
                    $style .= $s;
            }
            $this->SetFont('',$style);
        }
        function PutLink ($URL,$txt) {
            // Place un hyperlien
            $this->SetTextColor(0,0,255);
            $this->SetStyle('U',true);
            $this->Write(5,$txt,$URL);
            $this->SetStyle('U',false);
            $this->SetTextColor(0);
        }
        function Footer () {
            $this->SetY(-15);                                                   //  Positionnement à 1,5 cm du bas
            $this->SetTextColor(0);
            $this->SetFont('Arial','I',7);
            $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
        }
    }
    $result=mysql_query ($query,$db) or die ("Erreur mySQL : ".mysql_error($db));
    $nb_result=mysql_num_rows ($result);
    if ($nb_result>0) {
        $pdf=new PDF('P','mm','A4');
        $pdf->Open ();
        $pdf->SetTitle (ATLAS11_NOM);
//        $pdf->SetAuthor ($auteur);
        $pdf->AliasNbPages();
        $page=0;
        while ($row = mysql_fetch_array ($result,MYSQL_ASSOC)) {
            if ($row['fiche_type'] != "3" ) {                                   // Ne pas exporter les fiches 'Ancien'
                $carte = $row['id_atlas'].".jpg";
                $carte2 = $row['id_atlas']."_carte11.jpg";
                $image3 = $row["image3"];
                $image4 = $row["image4"];
                $image5 = $row["image5"];
                $image6 = $row["image6"];
                $image1t = $row["image1t"];
                $image2t = $row["image2t"];
                $image3t = $row["image3t"];
                $image4t = $row["image4t"];
                $image5t = $row["image5t"];
                $image6t = $row["image6t"];
//------------------------------------------------------------------------------ page 1
                $pdf->AddPage ('P','A4');

                $pdf->SetXY(10,15);
                $pdf->SetTextColor(0);
                $pdf->SetFont("Arial","I",15);
                $pdf->Cell(0,0,$row['taxon_atlas'],0,0,'C');

                $pdf->SetXY(10,25);
                $pdf->SetFont("Arial","",10);
                if (strlen ($row['syno'])>0) $pdf->MultiCell(0,5,"Synonymes : ".$row['syno']);           
                $pdf->SetFont("Arial","I",12);
                $pdf->MultiCell(0,5,$row['famille'],0);
                $pdf->SetFont("Arial","B",10);
                if (strlen ($row['nom_fr'])>0) $pdf->MultiCell(0,5,$row['nom_fr'],0);
                $pdf->SetFont("Arial","",10);
                $pdf->Ln(3);
                if (strlen ($row['descr'])>0) $pdf->AjouterChapitre ("Description",convert_txt($row['descr']));           
                if (strlen ($row['biolo'])>0) $pdf->WriteHTML("<b>Type biologique : </b>".$biolo_txt[$row['biolo']]."<br>"); 
                if (strlen ($row['cycle'])>0) $pdf->WriteHTML("<b>Cycle de vie : </b>".$cycle_txt[$row['cycle']]."<br>"); 
                if (strlen ($row['pheno'])>0) $pdf->WriteHTML("<b>Floraison : </b>".$row['pheno']."<br>"); 
                $pdf->Ln(3);
                $pdf->Ln(2);
                $pdf->TitreChapitre ("Aire de répartition");
                if (strlen ($row['choro'])>0) $pdf->WriteHTML("<b>Type chorologique : </b>".$row['choro']."<br>"); 
                if (strlen ($row['repart_gl'])>0) $pdf->AjouterChapitre("Générale",convert_txt($row['repart_gl']));              
                if (strlen ($row['repart_dep'])>0) $pdf->AjouterChapitre("Aude",convert_txt($row['repart_dep']));             
//------------------------------------------------------------------------------ page 1 / Photos
                if ($img) {
                    if (file_exists (ATLAS11_CARTES_PATH.$carte2))
                        $yphotos=30;
                    else
                        $yphotos=50;
                    if (file_exists (ATLAS11_CARTES_PATH.$carte)) {
                        $pdf->Image(ATLAS11_CARTES_PATH.$carte,115,$yphotos,null,60);
                        $yphotos+=64;
                    }
                    if (file_exists (ATLAS11_CARTES_PATH.$carte2)) {
                        $pdf->Image(ATLAS11_CARTES_PATH.$carte2,115,$yphotos,null,60);
                        $yphotos+=64;
                    }
                    if ($image3 != "" && file_exists (ATLAS11_PHOTOS_PATH.$image3)) {
                        $size=getimagesize (ATLAS11_PHOTOS_PATH.$image3);
                        $largeur=$size[0];
                        $hauteur=$size[1];
                        $ratio=60/$hauteur;	                                        //hauteur imposée de 60 mm
                        $newlargeur=$largeur*$ratio;
                        $posi=115+(90-$newlargeur)/2;
                        $pdf->Image (ATLAS11_PHOTOS_PATH.$image3,$posi,$yphotos,null,60);
                        $yphotos+=64;
                        if (strlen ($image3t)>0) { 
                            $pdf->SetXY(115,$yphotos-4);
                            $pdf->SetFont("Arial","I",8);
                            $pdf->SetTextColor(70,130,180);
                            $pdf->cell(90,4,$image3t,0,0,'C',false);
                        }
                    }
                    if ($image4 != "" && file_exists (ATLAS11_PHOTOS_PATH.$image4)) {
                        $size=getimagesize (ATLAS11_PHOTOS_PATH.$image4);
                        $largeur=$size[0];
                        $hauteur=$size[1];
                        $ratio=60/$hauteur;	                                        //hauteur imposée de 60 mm
                        $newlargeur=$largeur*$ratio;
                        $posi=115+(90-$newlargeur)/2;
                        $pdf->Image(ATLAS11_PHOTOS_PATH.$image4,$posi,$yphotos,null,60);
                        $yphotos+=64;
                        if (strlen ($image4t)>0) { 
                            $pdf->SetXY(115,$yphotos-4);
                            $pdf->SetFont("Arial","I",8);
                            $pdf->SetTextColor(70,130,180);
                            $pdf->cell(90,4,$image4t,0,0,'C',false);
                        }
                    }
                }           
//------------------------------------------------------------------------------ page 2
                $pdf->AddPage ('P','A4');
                $pdf->SetXY(10,15);
                $pdf->SetTextColor(0);
                $pdf->SetFont("Arial","B",15);
                $pdf->Cell(30,10,$row['taxon_atlas'],0,0,'');
                $pdf->SetXY(10,25);
                $pdf->SetFont("Arial","",10);
    
                $pdf->TitreChapitre ("Nombre de communes de présence");
                $pdf->SetFont("Arial","",8);
                $pdf->cell(25,5,"Observations",1,0,"L",true);           
                $pdf->cell(25,5,"Avant 1990",1,0,"L",true);           
                $pdf->cell(25,5,"Après 1990",1,0,"L",true);           
                $pdf->cell(25,5,"Total",1,1,"L",true);           
                $pdf->cell(25,5,"Aude",1,0,"L",false);           
                $pdf->cell(25,5,$row["aude_inf90"],1,0,"L",false);           
                $pdf->cell(25,5,$row["aude_rec"],1,0,"L",false);           
                $pdf->cell(25,5,$row["aude_tot"],1,1,"L",false);           
                $pdf->cell(25,5,"LR",1,0,"L",false);           
                $pdf->cell(25,5,$row["lr_inf90"],1,0,"L",false);           
                $pdf->cell(25,5,$row["lr_rec"],1,0,"L",false);           
                $pdf->cell(25,5,$row["lr_tot"],1,1,"L",false);           
                $pdf->Ln();
                if (strlen ($row['ecologie'])>0) $pdf->AjouterChapitre("Ecologie",convert_txt($row['ecologie']));           
                if (strlen ($row['geol'])>0) $pdf->WriteHTML("<b>Géologie : </b>".$geol_txt[$row['geol']]."<br>"); 
                $etage_txt="";
                if ($row["etage_coll"]==1) $etage_txt.="Collinéen ";
                if ($row["etage_meso"]==1) $etage_txt.="Mésoméditerranéen ";
                if ($row["etage_mont"]==1) $etage_txt.="Montagnard ";
                if ($row["etage_suba"]==1) $etage_txt.="Subalpin ";
                if ($row["etage_alpi"]==1) $etage_txt.="Alpin ";
                if (strlen ($etage_txt)>0) $pdf->WriteHTML("<b>Etage de végétation : </b>".$etage_txt."<br>"); 
                $pdf->Ln(2);
    
                if (strlen ($row['conserv'])>0) $pdf->AjouterChapitre("Conservation et menaces",convert_txt($row['conserv']));
    
                $pdf->MultiCell(100,5,"Menaces récurrentes",0);           
                $pdf->SetFont("Arial","",8);
                $pdf->cell(25,5,"Aménagements",'LTR',0,"L",true);           
                $pdf->cell(23,5,"Dynamique",'LTR',0,"L",true);           
                $pdf->cell(17,5,"Usages",'LTR',0,"L",true);           
                $pdf->cell(17,5,"Loisirs",'LTR',0,"L",true);           
                $pdf->cell(17,5,"Cueillette",'LTR',1,"L",true);           
                $pdf->cell(25,5,"urbanisation",'LRB',0,"L",true);           
                $pdf->cell(23,5,"naturelle",'LRB',0,"L",true);           
                $pdf->cell(17,5,"",'LRB',0,"L",true);           
                $pdf->cell(17,5,"",'LRB',0,"L",true);           
                $pdf->cell(17,5,"",'LRB',1,"L",true);           
                $pdf->cell(25,5,$tabl_txt[$row["amen"]],1,0,"L",false);           
                $pdf->cell(23,5,$tabl_txt[$row["dyna"]],1,0,"L",false);           
                $pdf->cell(17,5,$tabl_txt[$row["usages"]],1,0,"L",false);           
                $pdf->cell(17,5,$tabl_txt[$row["loisir"]],1,0,"L",false);           
                $pdf->cell(17,5,$tabl_txt[$row["cueill"]],1,1,"L",false);           
                $pdf->Ln();
    
                $pdf->WriteHTML("<b>Vulnérabilité dans l'Aude : ".$ouinon_txt[$row["vul_dep"]]."<br>"); 
    
                $pdf->TitreChapitre ("Statuts");
                $pdf->SetFont("Arial","",10);
                if ($row["dh"]==1) $pdf->MultiCell(0,5,"DH (Directive Habitat)",0);           
                if ($row["cb"]==1) $pdf->MultiCell(0,5,"CB (Convention de Berne)");
                if ($row["pn"]==1) $pdf->MultiCell(0,5,"PN (Protection Nationale)");
                if ($row["pr"]==1) $pdf->MultiCell(0,5,"PR (Protection Régionale)");
                if ($row["lr1"]==1) $pdf->MultiCell(0,5,"Lr1 (Livre Rouge tome 1)");
                if ($row["lr2"]==1) $pdf->MultiCell(0,5,"Lr2 (Livre Rouge tome 2)");
                if ($row["pna"]==1) $pdf->MultiCell(0,5,"PNA (Plan National d Action)");
                if ($row["pna"]==1) $pdf->MultiCell(0,5,"SCAP (Stratégie Création Aire Protégée)");
                if ($row["znieff"] >0 ) $pdf->MultiCell(0,5,"ZNIEFF LR - ".$znieff_txt[$row["znieff"]]);
                if ($row["ens"]==1) $pdf->MultiCell(0,5,"ENS Aude");
                if ($row["ss"]==1) $pdf->MultiCell(0,5,"Sans statut");
                if (strlen ($row['statuts'])>0) $pdf->AjouterChapitre("","statuts");
                $pdf->Ln(1);
    
                if (strlen ($row['compl'])>0) $pdf->AjouterChapitre("Compléments",convert_txt($row['compl']));           
                $pdf->Ln();
                if ($row['fiche_type'] == "6" ) 
                    $pdf->WriteHTML("Auteurs : F. Arabia, D. Barreau, G. Coirié, B. Le Roux, J.M. Lewin, J. Sanègre, D. Vizcaino, C. Plassart<br>"); 
                else
                    $pdf->WriteHTML("Auteurs : F. Andrieu, D. Barreau, C. Plassart, E. Thys<br>");
                $pdf->WriteHTML("Date de rédaction : 15 mars 2014<br>");
//------------------------------------------------------------------------------ page 2 / Logos
                $pdf->SetXY (10,260);
                $pdf->SetFont ("Arial","",8);
                $pdf->cell (100,5,"Opérateurs techniques",0,0,"L",false);           
                $pdf->cell (80,5,"Financeurs",0,1,"L",false);           
                $pdf->Image ("../../_GRAPH/logos/logo_FAC.jpg",10,265,18,null);
                $pdf->Image ("../../_GRAPH/logos/logo_cbnmed2.gif",31,265,18,null);
                $pdf->Image ("../../_GRAPH/logos/logo_SESA.jpg",54,265,18,null);
                $pdf->Image ("../../_GRAPH/logos/logo_Ateliers_Nature.jpg",75,265,30,null);
                $pdf->Image ("../../_GRAPH/logos/logo_UE.gif",110,265,20,null);
                $pdf->Image ("../../_GRAPH/logos/logo_FEDER.jpg",133,265,23,null);
                $pdf->Image ("../../_GRAPH/logos/logo_DREAL_LR.jpg",160,265,18,null);
                $pdf->Image ("../../_GRAPH/logos/logo_CG11.jpg",182,265,20,null);
//------------------------------------------------------------------------------ page 2 / Photos
                if ($img) {
                    $pdf->SetXY(10,40);
                    $yphotos=40;
                    if ($image5 != "" && file_exists (ATLAS11_PHOTOS_PATH.$image5)) {
                        $size=getimagesize (ATLAS11_PHOTOS_PATH.$image5);
                        $largeur=$size[0];
                        $hauteur=$size[1];
                        $ratio=60/$hauteur;	                                        //hauteur imposée de 60 mm
                        $newlargeur=$largeur*$ratio;
                        $posi=115+(90-$newlargeur)/2;
                        $pdf->Image(ATLAS11_PHOTOS_PATH.$image5,$posi,$yphotos,null,60);
                        $yphotos+=64;
                        if (strlen ($image5t)>0) { 
                            $pdf->SetXY(115,$yphotos-4);
                            $pdf->SetFont("Arial","I",8);
                            $pdf->SetTextColor(70,130,180);
                            $pdf->cell(90,4,$image5t,0,0,'C',false);
                        }
                    }           
                    if ($image6 != "" && file_exists (ATLAS11_PHOTOS_PATH.$image6)) {
                        $size=getimagesize (ATLAS11_PHOTOS_PATH.$image6);
                        $largeur=$size[0];
                        $hauteur=$size[1];
                        $ratio=60/$hauteur;	                                        //hauteur imposée de 60 mm
                        $newlargeur=$largeur*$ratio;
                        $posi=115+(90-$newlargeur)/2;
                        $pdf->Image(ATLAS11_PHOTOS_PATH.$image6,$posi,$yphotos,null,60);
                        $yphotos+=64;
                        if (strlen ($image6t)>0) { 
                            $pdf->SetXY(115,$yphotos-4);
                            $pdf->SetFont("Arial","I",8);
                            $pdf->SetTextColor(70,130,180);
                            $pdf->cell(90,4,$image6t,0,0,'C',false);
                        }
                    }           
                }           
                $page++;
            }
        }
        $pdf->Output (ATLAS11_PDF_PATH.$fichier.".pdf",F);
        echo ("<p align=center><br><br>");
        echo ("<font size=4>Export terminé.</font><br><br>");
        echo ("<br><br><a class=download href=\"../commun/download.php?f=".ATLAS11_PDF_PATH.$fichier.".pdf\" target=\"_blank\" >Télécharger le fichier PDF</a>");
    }
    else 
        echo ("<br><br><p align=\"center\"><img src=\"../../_GRAPH/warning.png\" width=\"16\" height=\"16\" border=\"0\" /> <b>Pas de résultats trouvés</b></p>");

}

function convert_txt ($txt) {
    $out=trim (html_entity_decode (strip_tags ($txt)));
    return (str_replace ("&rsquo;","'",$out));
}

function convert_txt2 ($txt) {
    $filtre = array("<p style=\"text-align: justify;\">",
        "<p style=\"text-align: justify;\" class=\"MsoNormal\">",
        "<p class=\"MsoNormal\" style=\"text-align: justify;\">",
        "<p style=\"text-align: justify\">",
        "<p style=\"text-align: justify; \">",
        "<p class=\"especetexte\" style=\"margin-bottom: 0.0001pt; text-align: justify;\">",
        "<p style=\"text-align: justify;\">");

    $txt=str_replace ($filtre,"<p>",$txt);                                       //  Filtre les balises non reconnues par le générateur RTF
    $txt=trim (html_entity_decode(strip_tags($txt,"<strong><em><u><p>")));
//    $txt=str_replace("</p>","<BR>",$txt);
//    $txt=str_replace("<i style=\"\">","<em>",$txt);
//    $txt=str_replace("</i>","</em>",$txt);
//    $txt=str_replace("&rsquo;","'",$txt);
    $txt=str_replace ("'","&#145;",$txt);
    $txt=str_replace ("\"","&#148;",$txt);
    return ($txt);
}

?>
