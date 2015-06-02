<?php
//------------------------------------------------------------------------------//
//  module_admin/admin_stats_a.php                                              //
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
    $a=$_GET["a"];
} else {
    $a=date("Y");
}
$mois_txt=array("Jan","Fév","Mar","Avr","Mai","Jun","Jui","Aou","Sep","Oct","Nov","Déc");

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=mysql_connect(SQL_server,SQL_user,SQL_pass) or fatal_error ("Impossible de se connecter : ".mysql_error());
$db_selected=mysql_select_db(SQL_base,$db) or fatal_error ("Impossible d'utiliser la base : ".mysql_error());

//------------------------------------------------------------------------------ MAIN
$query="SELECT MONTH(datetimeEvent) AS m,COUNT(id_log) AS nbre_log FROM app_log WHERE EVENT=3 AND YEAR(datetimeEvent)=".$a." GROUP BY MONTH(datetimeEvent);";
$result=mysql_query($query,$db) or die ("Erreur mySQL : ".mysql_error($db)); 
while ($row=mysql_fetch_array($result,MYSQL_ASSOC)) { 
    $m=$row["m"]-1;
    $x[$m]=$mois_txt[$m];
    $y1[$m]=$row["nbre_log"];
} 
mysql_close($db);

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

$b1plot->value->SetColor("black"); 
$b1plot->SetLegend("Connections");
$graph->Add($b1plot);
 
$graph->title->Set("Année ".$a);
$graph->title->SetColor("gray7");
$graph->xaxis->title->Set("Mois");
//$graph->yaxis->title->Set("Connections");
  
$graph->Stroke();

?>
