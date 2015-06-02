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
include ("../../_INCLUDE/config_sql.inc.php");
include ("../../_INCLUDE/constants.inc.php");

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
    $sWhere = "WHERE ( "; 
    $pairs = explode("&",$_POST['select']);
    foreach( $pairs as $key=>$value)
        $sWhere .= $pk."=".sql_format(ltrim ($value,"id="))." OR ";
    
    $sWhere=rtrim ($sWhere,"OR ");
    $sWhere .= " ) "; 
    $query2=str_replace ("WHERE",$sWhere,$query);
    echo "export_TXT > sWhere=".$sWhere;
} else {                                                                        // Liste totale
    $query2=$query;
}
//echo "export_TXT > sql=".$query2."<br>";
export_txt ($nom_fichier,$query2);

//------------------------------------------------------------------------------ FONCTIONS
function export_txt ($nom_fichier,$query) {
	include ("../../_INCLUDE/fonctions.inc.php");
    global $db, $ref, $aColumnsTot,$champ_ref;
	$page = $_SESSION['page'];
	$page = 'lr';
	ref_colonne_et_valeur ($page);
	$ref_col = $aColumnsTot[$page] ;
	
	
	/*récupération des référentiels (correspondace des noms de colonnes et de valeurs*/
	// if (strpos($query,'liste_rouge') !== false) {
		
		// include ("../module_lr/lr-ref.php");
		// $ref_col = $aColumnsTot['lr'] ;
		// }
	// else if (strpos($query,'eee') !== false) {
		// ref_colonne_et_valeur ('eee');
		// include('../module_eee/eee-ref.php');
		// $ref_col = $aColumnsTot['eee'];
		// var_dump($ref_col);
		// }
		
		
	// if (!empty(strpos($query,'refnat'))) include('../module_refnat/refnat-ref.php');
	// if (!empty(strpos($query,'catnat'))) include('../module_catnat/catnat-ref.php');
	// if (!empty(strpos($query,'lsi'))) include('../module_lsi/lsi-ref.php');
	
    $result = pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($rResultTotal)); 
    $nb_col = pg_num_fields ($result);
    $nb_result = pg_num_rows ($result); 
    $info = pg_fetch_assoc ($result);
    if ($nb_result>0) {
        $file = EXPORT_PATH.$nom_fichier;
        $fp=fopen ($file,"w");                                                  //  Ouvre le fichier en écriture
        if ($fp!=FALSE)
        {
            $col=$ligne="";
            foreach ($info as $column => $value) {
				var_dump($page);
                if (!empty($ref_col[$column]))
					$col.=$ref_col[$column]['description']."\t";
				else
					$col.=$column."\t";
					
				if ($value == "t") $value = "OUI";
				if ($value == "f") $value = "NON";				
				if (!empty($ref[$champ_ref[$column]]))	{
					$ligne.="\"".filter ($ref[$champ_ref[$column]][$value])."\"\t";
					}
				else
					$ligne.="\"".filter ($value)."\"\t";
            }
			$col = utf8_decode($col);
			$ligne = utf8_decode($ligne);
            fwrite ($fp,$col."\n");                                             //  1ere ligne = noms des champs
            fwrite ($fp,$ligne."\n");                                           //  2eme ligne = 1ere ligne de données
           /*Od version : ATTENTION VERIFIER POUR EEE*/ 
			// while ($row=pg_fetch_row ($result)) {
                // $ligne="";
                // for ($i=0;$i<sizeof($row);$i++)
					// var_dump($column[$i]);
                    // if (!empty($ref[$column[$i]]))
						// $ligne.="\"".filter($ref[$column[$i]][$row[$i]])."\"\t";
					// else
					// $ligne.="\"".filter($row[$i])."\"\t";
                // fwrite ($fp,$ligne."\n");
            // }
			while ($row=pg_fetch_assoc ($result)) {
				$ligne="";
				foreach ($row as $column => $value) {
					if ($value == "t") $value = "OUI";
					if ($value == "f") $value = "NON";
					// echo "<BR> la colonne est  $column et la valeur $value<br>";
					if (!empty($ref[$champ_ref[$column]]))	{
						$ligne.="\"".filter($ref[$champ_ref[$column]][$value])."\"\t";
						var_dump($ref[$champ_ref[$column]]);
						// echo "<BR> la valeur exportée est : ".filter($ref[$column][$value])."<br>";
						}
					else
					$ligne.="\"".filter($value)."\"\t";
				}
				$ligne = utf8_decode($ligne);
				fwrite ($fp,$ligne."\n");
			}
            fclose ($fp);                                                        //  Ferme le fichier
        } else echo ("<br /><img src=\"../../_GRAPH/cancel.png\" border=\"0\" /><b> ".utf8_decode("Impossible de créer le fichier : ".$nom_fichier)."</b><br /><br />");
    } else echo ("<br><br><p align=\"center\"><img src=\"../../_GRAPH/warning.png\" width=\"16\" height=\"16\" border=\"0\" /> <b>".utf8_decode("Pas de résultats trouvés.")."</b></p>");
}

function microtime_float () {
    list ($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}

function convert_txt ($txt) {
    $out=trim (html_entity_decode(strip_tags($txt)));
    $out2=str_replace ("&rsquo;","'",$out);
    $out3=str_replace ("&ndash;","-",$out2);
    return ($out3);
}

function filter ($str) {
    $str = str_replace ("\n", "", $str);
    $str = str_replace ("\r\n", "", $str);
    $str = str_replace ("\r", "", $str); 
    return ($str);
}

function coupe_txt ($txt,$max) {
    if(strlen ($txt) >= $max)
    {
        $txt=substr ($txt,0,$max);                                              // Met la portion de chaine dans $chaine
        $espace=strrpos ($txt," ");                                             // position du dernier espace
        if ($espace)
            $txt=substr($txt,0,$espace);
        $txt .= '...';
    }
    return ($txt);
}

?>
