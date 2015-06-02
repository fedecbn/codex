<?php
//------------------------------------------------------------------------------//
//  module_admin/admin_stats_m.php                                              //
//                                                                              //
//  Banque de semences 'VANDA'                                                  //
//                                                                              //
//  Version 1.00  13/07/12 - DariaNet                                           //
//  Version 1.10  05/08/12 - MaJ tables SQL                                     //
//  Version 1.11  11/04/14 - MaJ query                                          //
//------------------------------------------------------------------------------//

//----------------------------------------------------------------------------- INIT PHP
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/JpGraph/jpgraph.php");
require_once ("../../_INCLUDE/JpGraph/jpgraph_bar.php");

//------------------------------------------------------------------------------ VAR.
if (isset($_GET["a"]) & !empty($_GET["a"])) {
    $m=$_GET["m"];
    $a=$_GET["a"];
} else {
    $m=date("n");
    $a=date("Y");
}
$mois_txt=array("","janvier","février","mars","avril","mai","juin","juilliet","aout","septembre","octobre","novembre","décembre");

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or fatal_error ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base,$db) or fatal_error ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ REF.

//------------------------------------------------------------------------------ MAIN
$query="SELECT DAY(datetimeEvent) AS j,COUNT(id_log) AS nbre_log FROM app_log WHERE EVENT=3 AND YEAR(datetimeEvent)=".$a." AND MONTH(datetimeEvent)=".$m." GROUP BY DAY(datetimeEvent)";
$result=mysql_query($query,$db) or die ("Erreur mySQL : ".mysql_error($db)); 
while ($row=mysql_fetch_array($result,MYSQL_ASSOC)) { 
    $j=$row["j"]-1;
    $x[$j]=$j+1;
    $y1[$j]=$row["nbre_log"];
} 
/*
for ($j=1;$j<=date("t",mktime(0,0,0,$m,1,$a));$j++) {                           // Tous les jours du mois sélectionné
    $query="SELECT count(id_log) AS nbre FROM app_log WHERE event=3 AND YEAR(datetimeEvent)=".$a." AND MONTH(datetimeEvent)=".$m." AND DAY(datetimeEvent)=".$j;        
    $result=mysql_query($query,$db) or die ('Erreur SQL !<br />'.$query.'<br />'.mysql_error($db));
    $y[$j-1]=mysql_result($result,0,"nbre");
//    echo ($j." ,".$y[$j]."<br>");
} 
*/
mysql_close ($db);

//------------------------------------------------------------------------------ Génération du graph.
$graph = new Graph(800,280);
$graph->SetMargin(60,40,40,60);
$graph->SetBox(false);
$graph->SetMarginColor('white');
$graph->SetColor('white');
$graph->SetScale("textlin");

$graph->xaxis->SetTickLabels($x);
$graph->xaxis->title->SetColor("gray5");
$graph->xaxis->SetColor("gray5","gray5");
$graph->yaxis->title->SetColor("gray5");
$graph->yaxis->SetColor("gray5","gray5");
 
$graph->legend->SetLayout(LEGEND_HOR);
$graph->legend->Pos(0.05,0.97,"left","bottom");
 
$b1plot = new BarPlot($y1);
$b1plot->SetFillColor("red@0.4");
$b1plot->SetShadow();
$b1plot->value->SetColor("gray5"); 
$b1plot->value->SetFormat('%d');
$b1plot->value->Show();
$b1plot->SetLegend("Connections");
$graph->Add ($b1plot);
 
$graph->title->Set($mois_txt[$m]." ".$a);
$graph->title->SetColor("gray7");
$graph->xaxis->title->Set("Jours");
//$graph->yaxis->title->Set("Connections");
$graph->Stroke();

?>
