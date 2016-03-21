<?php
//------------------------------------------------------------------------------//
//   _INCLUDE/fonctions.inc.php                                                 //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d'aide à l'évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  13/08/14 - MaJ schémas                                        //
//  Version 1.02  18/08/14 - MaJ menu_rubrique                                  //
//  Version 1.03  22/08/14 - MaJ aff_table                                      //
//  Version 1.04  01/09/14 - Aj MétaForm                                        //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ FONCTIONS GLOBALES

function html_header ($charset,$css1,$css2) {
    echo ("<head><title>Dispositif de partage des connaissances et d'expertises du réseau des CBN</title>");
    echo ("<link rel=\"shortcut icon\" href=\"../../_GRAPH/icone.ico\" type=\"image/x-icon\" />");
    echo ("<meta http-equiv=\"Content-type\" content=\"text/html; charset=".$charset."\" />");
    echo ("<meta http-equiv=\"Content-Script-Type\" content=\"text/javascript\" />");
    echo ("<meta http-equiv=\"Content-Style-Type\" content=\"text/css\" />");
    echo ("<meta name=\"author\" content=\"DARIANET\" />");
    echo ("<meta name=\"editor\" content=\"PSPad\" />");
    echo ("<meta name=\"description\" content=\"Dispositif de partage des connaissances et d'expertises du réseau des CBN\">");
    
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/eval.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../flore/syntaxa/css/syntaxa.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/pepper-grinder/jquery-ui.min.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/pepper-grinder/jquery-ui.theme.min.css\" />");
//    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/jquery.lightbox-0.5.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/square/aero.css\" />");

    if ($css1 != "") echo ("<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"../../_INCLUDE/css/".$css1."\"  />");
    if ($css2 != "") echo ("<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"../../_INCLUDE/css/".$css2."\"  />");
    echo ("</head>");
}

function html_header_2 ($charset,$css1,$css2,$title) {
    echo ("<head><title>$title</title>");
    echo ("<link rel=\"shortcut icon\" href=\"../../_GRAPH/icone.ico\" type=\"image/x-icon\" />");
    echo ("<meta http-equiv=\"Content-type\" content=\"text/html; charset=".$charset."\" />");
    echo ("<meta http-equiv=\"Content-Script-Type\" content=\"text/javascript\" />");
    echo ("<meta http-equiv=\"Content-Style-Type\" content=\"text/css\" />");
    echo ("<meta name=\"author\" content=\"DARIANET\" />");
    echo ("<meta name=\"author\" content=\"FCBN\" />");
    echo ("<meta name=\"editor\" content=\"PSPad\" />");
    echo ("<meta name=\"description\" content=\"Dispositif de partage des connaissances et d'expertises du réseau des CBN\">");
    
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/eval.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../flore/syntaxa/css/syntaxa.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/pepper-grinder/jquery-ui.min.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/pepper-grinder/jquery-ui.theme.min.css\" />");
//    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/jquery.lightbox-0.5.css\" />");
    echo ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../_INCLUDE/css/square/aero.css\" />");

    if ($css1 != "") echo ("<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"../../_INCLUDE/css/".$css1."\"  />");
    if ($css2 != "") echo ("<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"../../_INCLUDE/css/".$css2."\"  />");
    echo ("</head>");
}

function footer () {
}

function menu_rubrique ($niveau,$module){
    global $db;
	
	$ref_niveau = array(
		0 => 'pas d\'accès',
		1 => 'lecteur',
		64 => 'participant',
		128 => 'évaluateur',
		255 => 'administrateur'
		);
	
    echo ("<div lang=\"fr\" id=\"rubriques\"><center><ul>");
    $query="SELECT * FROM applications.rubrique WHERE id_module='".$module."' ORDER BY pos;";
    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
    while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC)) {
        if ($niveau >= $row["niveau"] ) {
            aff_pres ($module,"header",FR,false);
            echo ("<li><div class=\"icon\"><a href=\"".$row['link']."\"><img src=\"../../_GRAPH/".ICONES_SET."/".$row['icone']."\" align=left width=\"48\" height=\"48\" border=\"0\" /></a></div>");
            echo ("<a href=\"".$row["link"]."\"><strong>".$row["titre"]."</strong>".$row["descr"]."</a></li>");
			echo ("Droits d'accès à cette rubrique : <b> $ref_niveau[$niveau] </b>");
		   aff_pres ($module,"footer",FR,false);
		}
    } 
    echo ("</ul></div>");
    pg_free_result ($result);
}

function CleanFiles ($dir)
{
    $t=time();
    $h=opendir($dir);
    while($file=readdir($h))
    {
        if(substr($file,0,3)=='tmp' and substr($file,-4)=='.pdf')
        {
            $path=$dir.'/'.$file;
            if($t-filemtime($path)>3600)
                @unlink($path);
        }
    }
    closedir($h);
}

function microtime_float ()
{
    list ($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}

function error ($msg)
{
    echo ("<br /><center><img src=\"../../_GRAPH/cancel.png\" border=\"0\" /><b> ".$msg."</b></center><br />");
}

function fatal_error ($msg,$log)
{
    echo ("<center><br /><img src=\"../../_GRAPH/bomb.png\" border=\"0\" /><b> ".$msg."</b><br /><br />");
    echo ("<br><br><a href=\"javascript: history.go(-1)\"><img src=\"../../_GRAPH/top.gif\" border=\"0\" /></a></center>");
    echo ("<br /></div></div>");
    echo ("<div></body></html>");
    if ($log) add_log ($log,2,$_SESSION['id_users'],getenv("REMOTE_ADDR"),"FATAL ERROR",$msg,"");
    die ();
}

function export_txt ($nom_fichier,$query) {
	// include ("../../_INCLUDE/fonctions.inc.php");
    global $db, $ref, $aColumnsTot,$champ_ref;
	$page = $_SESSION['page'];
	ref_colonne_et_valeur ($page);
	$ref_col = $aColumnsTot[$page] ;

	/*récupération des référentiels (correspondace des noms de colonnes et de valeurs*/
	/* if (strpos($query,'liste_rouge') !== false) {
		
		include ("../module_lr/lr-ref.php");
		$ref_col = $aColumnsTot['lr'] ;
		}
	else if (strpos($query,'eee') !== false) {
		ref_colonne_et_valeur ('eee');
		include('../module_eee/eee-ref.php');
		$ref_col = $aColumnsTot['eee'];
		var_dump($ref_col);
		}
		
		
	if (!empty(strpos($query,'refnat'))) include('../module_refnat/refnat-ref.php');
	if (!empty(strpos($query,'catnat'))) include('../module_catnat/catnat-ref.php');
	if (!empty(strpos($query,'lsi'))) include('../module_lsi/lsi-ref.php');
	*/
	
    $result = pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($rResultTotal)); 
    $nb_result = pg_num_rows ($result); 
    $info = pg_fetch_assoc ($result);
    if ($nb_result>0) {
        $file = EXPORT_PATH.$nom_fichier;
        $fp=fopen ($file,"w");                                                  //  Ouvre le fichier en écriture
        if ($fp!=FALSE)
        {
            $col=$ligne="";
            foreach ($info as $column => $value) {
                if (!empty($ref_col[$column])) $col.=$ref_col[$column]['description']."\t";
				else $col.=$column."\t";
					
				if ($value == "t") $value = "Oui";
				if ($value == "f") $value = "Non";	
				
				if (!empty($ref[$champ_ref[$column]])) $ligne.="\"".filter ($ref[$champ_ref[$column]][$value])."\"\t";
				else $ligne.="\"".filter ($value)."\"\t";
            }
			
			/*Encodage si nécessaire*/
			// $col = utf8_decode($col);
			// $col = utf8_encode($col);
			// $ligne = utf8_decode($ligne);
			// $ligne = utf8_encode($ligne);
			/*Ecriture dans le fichier*/
            fwrite ($fp,$col."\n");                                             //  1ere ligne = noms des champs
            fwrite ($fp,$ligne."\n");                                           //  2eme ligne = 1ere ligne de données
           
			while ($row=pg_fetch_assoc ($result)) {
				$ligne="";
				foreach ($row as $column => $value) {
					if ($value == "t") $value = "Oui";
					if ($value == "f") $value = "Non";
						
					if (!empty($ref[$champ_ref[$column]])) $ligne.="\"".filter($ref[$champ_ref[$column]][$value])."\"\t";
					else $ligne.="\"".filter($value)."\"\t";
					
				}
				/*Encodage si nécessaire*/
				// $ligne = utf8_decode($ligne);
				// $ligne = utf8_encode($ligne);
				/*Ecriture dans le fichier*/
				fwrite ($fp,$ligne."\n");
			}
            fclose ($fp);                                                        //  Ferme le fichier
        // } else echo ("<br /><img src=\"../../_GRAPH/cancel.png\" border=\"0\" /><b> ".utf8_decode("Impossible de créer le fichier : ".$nom_fichier)."</b><br /><br />");
        } else echo ("<br /><img src=\"../../_GRAPH/cancel.png\" border=\"0\" /><b> Impossible de créer le fichier : $nom_fichier </b><br /><br />");
    // } else echo ("<br><br><p align=\"center\"><img src=\"../../_GRAPH/warning.png\" width=\"16\" height=\"16\" border=\"0\" /> <b>".utf8_decode("Pas de résultats trouvés.")."</b></p>");
    } else echo ("<br><br><p align=\"center\"><img src=\"../../_GRAPH/warning.png\" width=\"16\" height=\"16\" border=\"0\" /> <b> Pas de résultats trouvés </b></p>");
}


function export_txt_2 ($nom_fichier,$tome,$titre1,$titre2,$query,$champs) {
    global $db,$db_selected;
    $time_start=microtime_float();

    $result=mysql_query($query,$db) or fatal_error ("Erreur mySQL : ".mysql_error($db),true);
    $nb_result = mysql_num_rows($result);
    if ($nb_result>0) {
        $file = CSV_PATH.$nom_fichier;
        $fp=fopen ($file,"w");                                                  //       ouvre le fichier en écriture
        if ($fp!=FALSE)
        {
            fwrite ($fp,NOM_BDD."\n");
            fwrite ($fp,$tome."\n");
            fwrite ($fp,$titre1."\n");
            fwrite ($fp,$titre2."\n\n");
            fwrite ($fp,$champs."\n");
            while ($row = mysql_fetch_row($result)) {
                $ligne="";
                for ($i=0;$i<sizeof($row);$i++)
                    $ligne.=$row[$i]."\t";
                fwrite ($fp,$ligne."\n");
            }
            fclose($fp);                                                        //      ferme le fichier
            echo ("<center><table border=\"0\" cellpadding=\"2\">");
            echo ("<tr><td align=\"right\">Nom de la base :</td><td><b>".NOM_BDD."</b></td></tr>");
//            echo ("<tr><td align=\"right\">Path :</td><td><b>".CSV_PATH."</b></td></tr>");
            echo ("<tr><td align=\"right\">Titre :</td><td><b>".$titre1."</b></td></tr>");
            echo ("<tr><td align=\"right\">Titre :</td><td><b>".$titre2."</b></td></tr>");
//            echo ("<tr><td align=\"right\"><br></td></tr>");
            echo ("<tr><td align=\"right\">Nom du fichier :</td><td><b>".$nom_fichier."</b></td></tr>");
            echo ("<tr><td align=\"right\">Format du fichier :</td><td><b>CSV (texte)</b></td></tr>");
            echo ("<tr><td align=\"right\">Séparateur :</td><td><b>TAB</b></td></tr>");
//            echo ("<tr><td align=\"right\">Nombre de pages :</td><td><b>".$page."</b></td></tr>");
            echo ("<tr><td align=\"right\">Nombre de lignes :</td><td><b>".$nb_result."</b></td></tr>");
            echo ("<tr><td align=\"right\">Durée d'éxécution :</td><td><b>".number_format (microtime_float()-$time_start,3)." sec.</b></td></tr></table>");
            echo ("<br><img src=\"../../_GRAPH/ok.png\" border=\"0\" /><b> OK.</b>");
//            echo ("<br><br><a href=\"".utf8_encode($file)."\" target=\"_blank\"><img src=\"../../_GRAPH/b2_download.gif\"  width=\"160\" height=\"26\" border=\"0\" /></a>");
		    echo ("<br><br><a href=\"".utf8_encode($file)."\" target=\"_blank\" >Télécharger le fichier</a>");

        }
        else
            echo ("<br /><img src=\"../../_GRAPH/cancel.png\" border=\"0\" /><b> Impossible de créer le fichier !</b><br /><br />");
    }
    else echo ("<br><br><p align=\"center\"><img src=\"../../_GRAPH/warning.png\" width=\"16\" height=\"16\" border=\"0\" /> <b>Pas de résultats trouvés</b></p>");
}

function ref_champ ($schema,$name_ref,$table,$index,$valeur,$order)
	{
	global $db;
	global $ref;
	if (!isset($ref[$name_ref])) 
		{
		if ($order != "") {$orderby = "ORDER BY ".$order;} else {$orderby = "";}
		$query="SELECT * FROM $schema.".$table." ".$orderby;
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			$output[$row[$index]]=$row[$valeur];
		pg_free_result ($result);
		$ref[$name_ref] = $output;
		$ref[$index] = $output;
		}
	return $ref;
	}

function ref_colonne_et_valeur ($rubrique)	{
	// define ("DEBUG",true);
	// unset($aColumns);
	global $db, $ref, $aColumns, $aColumnsExp, $aColumnsTot, $aColumnsSub, $champ_ref;
// "\"$colname18\""
//------------------------------------------------------------------------------ Récupération des valeurs référentiels
	$query = "SELECT nom_champ,table_champ,champ_interface, schema, nom_ref, table_ref, cle, valeur,orderby, champs_ref.where_champ, champs_ref.where_value FROM referentiels.champs RIGHT JOIN referentiels.champs_ref ON referentiel = nom_ref WHERE rubrique_ref = '$rubrique'";
	// if (DEBUG) echo "<BR> $query";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);unset($query);
	while ($row = pg_fetch_assoc ($result)) {
		// if (DEBUG) echo "<BR> champ : ".$row['nom_champ'];
		if (!isset($ref[$row['nom_ref']])) {
			if ($row['orderby'] != "") {$orderby = "ORDER BY \"".$row['orderby']."\"";} else {$orderby = "";}
			if ($row['where_champ'] != "" OR $row['where_value'] != "") {$where = "WHERE \"".$row['where_champ']."\" = '".$row['where_value']."'";} else {$where = "";}
			$query="SELECT * FROM ".$row['schema'].".".$row['table_ref']." $where $orderby";
			// if (DEBUG) echo "<BR> $query";
			$result2=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result2),false);unset($query);
			// if (DEBUG) echo "<BR> lelel";
			while ($ligne=pg_fetch_array ($result2,NULL,PGSQL_ASSOC))
				$output[$ligne[$row['cle']]]=$ligne[$row['valeur']];
			$ref[$row['nom_ref']] = $output;
			pg_free_result ($result2);
			unset ($output);
			}
		/*champ à sevoir sur le suivi*/	
		if (!isset($champ_ref[$row['champ_interface']])) {		
			$champ_ref[$row['champ_interface']] = $row['nom_ref'];	
			}
		}
		pg_free_result ($result);
		
		// var_dump($ref);
		// echo "<br><br>";
		// var_dump($champ_ref);
	
//------------------------------------------------------------------------------ Récupération des champs de synthèse
	$query = "SELECT * FROM referentiels.champs WHERE rubrique_champ = '$rubrique' AND pos IS NOT NULL ORDER by pos ";
	// if (DEBUG) echo "<BR> $query";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);unset($query);
	while ($row = pg_fetch_assoc ($result)) {
		if (!isset($aColumns[$rubrique][$row["nom_champ_synthese"]])) {
			$aColumns[$rubrique][$row["nom_champ_synthese"]] = $row;
			}
		}
	pg_free_result ($result);

//------------------------------------------------------------------------------ Récupération des champs d'export
	$query = "SELECT * FROM referentiels.champs WHERE rubrique_champ = '$rubrique' ORDER by pos";
	// if (DEBUG) echo "<BR> $query";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);unset($query);
	while ($row = pg_fetch_assoc ($result)) {
			if (!isset($aColumnsTot[$rubrique][$row["champ_interface"]])) {
				$aColumnsTot[$rubrique][$row["champ_interface"]] = $row;
			}
		}
	$aColumnsExp = $aColumnsTot;
	pg_free_result ($result);
//------------------------------------------------------------------------------ Récupération des champs de requête (submit)
	}

	
	
function mono_table ($value)	{
	if (is_array($value))	{
		if (sizeof($value) == 1)	{
			$x = array_keys($value);
			$key = array_shift($x);
			$new_value = $value[$key];
			} else {
			$new_value = implode($value,',');
			}
		}
	else
		$new_value = $value;

	return $new_value;
	}

function check_modif($val1,$val2,$field) {
	global $aColumnsTot;
	$type = $aColumnsTot[$_SESSION['page']][$field]['type'];
			
	$val1 = mono_table($val1);
	$val2 = mono_table($val2);
	
	if ($type == 'int' OR $type == 'bool')	{
		if ($val1 === null)  $test1='empty'; else $test1='filled'; 
		if ($val2 === null)  $test2='empty'; else $test2='filled'; 
		}
	else if ($type == 'string')	{
		if ($val1 == '')  $test1='empty'; else $test1='filled'; 
		if ($val2 == '')  $test2='empty'; else $test2='filled'; 
		}
	else if ($type == 'val')	{	/*Différence entre valeur numeric ==0 et valeur string =='0'*/
		if ($val1 === '0' OR $val1 === 0)  {$test1='empty';} else {$test1='filled';}
		if ($val2 === '0' OR $val2 === 0)  {$test2='empty';} else {$test2='filled';} 
		}
	else {
		if ($val1 == null)  {$test1='empty';} else {$test1='filled';}
		if ($val2 == null)  {$test2='empty';} else {$test2='filled';}
	}
	
	// if ($val1 == '0' OR $val1 == null OR $val1 == 'NULL' or $val1 == '') $test1='empty'; 
	// if ($val2 == '0' OR $val2 == null  OR $val2 == 'NULL' or $val2 == '') $test2='empty'; 
	// if ($val1 != '0' AND $val1 != null  AND $val1 != 'NULL' AND $val1 != '') $test1='filled'; 
	// if ($val2 != '0' AND $val2 != null AND $val2 != 'NULL' AND $val2 != '') $test2='filled'; 
	
	// if (!empty(array_diff($val1,$val2)))	
	if ($val1 != $val2)	{
		if ($test1 == 'empty' AND $test2 == 'filled') 
			$modif = 'ajout';
		else if ($test1 == 'filled' AND $test2 == 'filled') 
			$modif = 'modif';
		else if ($test1 == 'filled' AND $test2 == 'empty') 
			$modif = 'suppr';
		else if ($test1 == 'empty' AND $test2 == 'empty') 
			$modif = 'vide';
		// echo "<BR> val1 $test1 et val2 $test2 donne $modif";
		}
	else {$modif = 'identiques';}

	return $modif;
	}

function add_suivi2 ($etape,$id_user,$uid,$table,$champ,$valeur_1,$valeur_2,$rubrique,$methode,$type_modif) {
    define ("DEBUG",true);
	global $db, $ref, $champ_ref;
	// var_dump($ref[$champ_ref[$champ]]);
	// var_dump($champ_ref[$champ]);
	// var_dump($ref);
	
	/*Cas des tables mono index*/
	if (is_array($valeur_1) AND sizeof($valeur_1)==1)
		$valeur_1 = mono_table($valeur_1);
	if (is_array($valeur_2) AND sizeof($valeur_2)==1)
		$valeur_2 = mono_table($valeur_2);
	
	/*valeur_1 = VALEUR INITIALE*/
	// var_dump($valeur_1);
	if (($valeur_1 == null) OR (!empty($valeur_1)))
		{
		$valeur_1 = null;
		$libelle1 = null;
		if (DEBUG) echo "<BR> libelle_1 Unique $champ : vide";
		} else {
		if (is_array($valeur_1) AND sizeof($valeur_1)>1)	{							/*Cas de valeur multiple*/
			if (isset($ref[$champ_ref[$champ]])) {										/*Récupération des référentiels*/
					foreach ($valeur_1 as $val)
						$lib1[$val] = $ref[$champ_ref[$champ]][$val];
					$libelle1 = implode(',',$lib1);
					if (DEBUG) echo "<BR> libelle_ref_1 Multi $champ : ".$libelle1;
			} else { 
				$libelle1 = implode(',',$valeur_1);
				if (DEBUG) echo "<BR> libelle_1 Multi $champ : ".$libelle1;		
				}
		$valeur_1 = implode(',',$valeur_1);
		if (DEBUG) echo "<BR> valeur_1 Multi $champ : ".var_dump($valeur_1);
		} else {																		/*Cas de valeur unique*/
		if (isset($ref[$champ_ref[$champ]])) {											/*Récupération des référentiels*/
				$libelle1 = $ref[$champ_ref[$champ]][$valeur_1];		
				if (DEBUG) echo "<BR> libelle_ref_1 Unique $champ : ".$libelle1;
				} else {
				$libelle1 = $valeur_1;
				if (DEBUG) echo "<BR> libelle_1 Unique $champ : ".$libelle1;
				}
			if (DEBUG) echo "<BR> valeur_1 Unique $champ : ".$valeur_1;
			}
		}

	// /*idem valeur_2*/		
	if (is_array($valeur_2) AND sizeof($valeur_2)>1)	{							/*Cas de valeur multiple*/
		if (isset($ref[$champ_ref[$champ]])) {										/*Récupération des référentiels*/
				foreach ($valeur_2 as $val)
					$lib2[$val] = $ref[$champ_ref[$champ]][$val];
				$libelle2 = implode(',',$lib2);
				if (DEBUG) echo "<BR> libelle_ref_2 Multi $champ : ".$libelle2;
		} else { 
		$libelle2 = implode(',',$valeur_2);
		if (DEBUG) echo "<BR> libelle_2 Multi $champ : ".$libelle2;				
		}
	$valeur_2 = implode(',',$valeur_2);
	if (DEBUG) echo "<BR> valeur_2 Multi $champ : ".var_dump($valeur_2);
	} else {																		/*Cas de valeur unique*/
	if (isset($ref[$champ_ref[$champ]])) {											/*Récupération des référentiels*/
			$libelle2 = $ref[$champ_ref[$champ]][$valeur_2];		
			if (DEBUG) echo "<BR> libelle_ref_2 Unique $champ : ".$libelle2;
			} else {
			$libelle2 = $valeur_2;
			if (DEBUG) echo "<BR> libelle_2 Unique $champ : ".$libelle2;
			}
		if (DEBUG) echo "<BR> valeur_2 Unique $champ : ".$valeur_2;
		}
			
	if ($libelle1 === "TRUE") $libelle1="OUI"; 
	if ($libelle1 === "FALSE") $libelle1="NON"; 
	if ($libelle2 === "TRUE") $libelle2="OUI"; 
	if ($libelle2 === "FALSE") $libelle2="NON"; 

	if ($libelle1 == '0' OR $libelle1 == null OR $libelle1 == 'NULL' or $libelle1 == '') $libelle1='-'; 
	if ($libelle2 == '0' OR $libelle2 == null  OR $libelle2 == 'NULL' or $libelle2 == '') $libelle2='-'; 
	
	$query="INSERT INTO ".SQL_schema_app.".suivi (etape,id_user,uid,tables,champ,valeur_1,valeur_2,datetime,rubrique,methode,type_modif,libelle_1,libelle_2) VALUES  
	(".$etape.",'".$id_user."',".$uid."::varchar,'".$table."','".$champ."',".sql_format_quote ($valeur_1,'do').",".sql_format_quote ($valeur_2,'do').",NOW(),'".$rubrique."','".$methode."','".$type_modif."',".sql_format_quote($libelle1,'do').",".sql_format_quote($libelle2,'do').");";
	// echo "<BR> $query";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
	
}


//------------------------------------------------------------------------------ CMS
function aff_pres ($module,$page,$lang,$cadre) {
    global $db;

    $query="SELECT * FROM ".SQL_schema_app.".pres WHERE id_module='".$module."' AND page='".$page."' AND lang=".$lang.";";
//echo $query;
    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
    if (pg_num_rows ($result)) {
        if ($cadre) {
            if (pg_result($result,0,"titre") != "")
                echo ("<fieldset class=\"form1\"><LEGEND align=top>". pg_result($result,0,"titre") ."</LEGEND>");
            else
                echo ("<fieldset class=\"form1\"></LEGEND>");
        }
        echo "<p align=justify>".pg_result ($result,0,"pres")."</p>";
        pg_free_result ($result);
        if ($cadre) echo ("</fieldset>");
     }
}

function aff_page ($id,$lang) {
    global $db;

    $query="SELECT * FROM ".SQL_schema_app.".pres WHERE id_content='".$id."' AND lang=".$lang.";";
    $result=mysql_query($query,$db) or fatal_error ("aff_page > Erreur mySQL : ".mysql_error($db),false);
    if (pg_num_rows ($result)) {
        if (pg_result($result,0,"descr") != "")
            echo ("<h2>". pg_result($result,0,"pres") ."</h2><br>");
        echo pg_result ($result,0,"content");
        mysql_free_result ($result);
     }
}

function aff_table2 ($id_liste,$actions,$check) {
    include ("../catnat-ref.php");		

	$query="SELECT * FROM ".SQL_schema_app.".pres WHERE id_module='".$module."' AND page='".$page."' AND lang=".$lang.";";
    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
	while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))

    $nbre_col=count($langliste[$lang_select][$id_liste]);
    echo ("<table id=\"".$id_liste."\" class=\"display\" ><thead><tr>");
    for ($i=1;$i<=$nbre_col;$i++) 
        echo ("<th></th>");
    echo ("</tr><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"".$id_liste."-all\" value=\"1\" ></a></th>");
    echo ("</tr></thead><tfoot><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"".$id_liste."-all\" value=\"1\" ></a></th>");
    echo ("</tr></tfoot><tbody></tbody></table><br><br>");
}


function aff_table ($id_liste,$actions,$check) {
    global $lang_select,$langliste;

    $nbre_col=count($langliste[$lang_select][$id_liste]);
    echo ("<table id=\"".$id_liste."\" class=\"display\" ><thead><tr>");
    for ($i=1;$i<=$nbre_col;$i++) 
        echo ("<th></th>");
    echo ("</tr><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"".$id_liste."-all\" value=\"1\" ></a></th>");
    echo ("</tr></thead><tfoot><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"".$id_liste."-all\" value=\"1\" ></a></th>");
    echo ("</tr></tfoot><tbody></tbody></table><br><br>");
}

function aff_table_new ($id_liste,$actions,$check) {
    global $lang_select,$langliste;

    $nbre_col=count($langliste[$lang_select][$id_liste]);
    if ($id_liste == 'droit')
		echo ("<table id=\"user-liste\" class=\"display\" ><thead><tr>");
	else
		echo ("<table id=\"data-liste\" class=\"display\" ><thead><tr>");
    for ($i=1;$i<=$nbre_col;$i++) 
        echo ("<th></th>");
    echo ("</tr><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"liste-all\" value=\"1\" ></a></th>");
    echo ("</tr></thead><tfoot><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"liste-all\" value=\"1\" ></a></th>");
    echo ("</tr></tfoot><tbody></tbody></table><br><br>");
}

function aff_table_reborn ($id_onglet,$id_liste,$actions = true,$check = true) {
    global $lang_select,$langliste;

    $nbre_col=count($langliste[$lang_select][$id_liste]);
	echo ("<table id=\"".$id_onglet."-liste\" class=\"display\" ><thead><tr>");
    for ($i=1;$i<=$nbre_col;$i++) 
        echo ("<th></th>");
    echo ("</tr><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"liste-all\" value=\"1\" ></a></th>");
    echo ("</tr></thead><tfoot><tr>");
    for ($i=0;$i<$nbre_col;$i++) 
        echo ("<th><a title=\"".$langliste[$lang_select][$id_liste.'-popup'][$i]."\">".$langliste[$lang_select][$id_liste][$i]."</a></th>");
    if ($actions) echo ("<th></th>");
    if ($check) echo ("<th><a><input type=\"checkbox\" class=\"liste-all\" value=\"1\" ></a></th>");
    echo ("</tr></tfoot><tbody></tbody></table><br><br>");
}


//------------------------------------------------------------------------------ MétaForm

/*function metaform_text ($label,$descr,$long,$style,$champ,$val)
{
	
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label class=\"preField_calc\">".$label."</label>");
		else echo ("<label class=\"preField\">".$label."</label>");

	if (!isset($extra)) $extra = "";		
	// if (strpos($descr,"bloque") != false) {$bloc .= " readonly disabled";$extra .= "background-color:#EFEFEF";}
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}
	echo ("<input type=\"text\" name=\"".$champ."\" id=\"".$champ."\" size=\"".$long."\" value=\"".$val."\" $extra style=\"$style\"/>");
    echo ("<br>");
}*/

function metaform_text ($label,$descr,$long,$style,$champ,$val,$tooltip='')
{
	
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\" id=\"label_".$champ."\">".$label."</label>");
		elseif (strpos($descr,"not_display") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField\" id=\"label_".$champ."\" style=\"$style\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\" id=\"label_".$champ."\">".$label."</label>");

	if (!isset($extra)) $extra = "";		
	// if (strpos($descr,"bloque") != false) {$bloc .= " readonly disabled";$extra .= "background-color:#EFEFEF";}
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}
	echo ("<input type=\"text\" name=\"".$champ."\" id=\"".$champ."\"  size=\"".$long."\" value=\"".$val."\" $extra style=\"$style\"/>");
    echo ("<br>");
}


function metaform_pw ($label,$descr,$long,$style,$champ,$val,$tooltip='')
{
	
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");

	if (!isset($extra)) $extra = "";		
	// if (strpos($descr,"bloque") != false) {$bloc .= " readonly disabled";$extra .= "background-color:#EFEFEF";}
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}
	echo ("<input type=\"password\" name=\"".$champ."\" id=\"".$champ."\" size=\"".$long."\" value=\"".$val."\" $extra style=\"$style\"/>");
    echo ("<br>");
}


function metaform_text_area ($label,$descr,$row,$cols,$style,$champ,$val,$tooltip='')
{
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");

	if (!isset($extra)) $extra = "";	
	// if (strpos($descr,"bloque") !== false) {$extra .= " readonly disabled";$style .= "background-color:#EFEFEF";}	
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}	
    echo ("<textarea name=\"".$champ."\" id=\"".$champ."\" row=\"".$row."\" cols=\"".$cols."\" value=\"".$val."\" $extra style=\"$style\" />".$val."</textarea>");
    echo ("<br>");
}

function metaform_sel ($label,$descr,$style,$liste,$champ,$val,$tooltip='')
{
	/*Retrouver pourquoi cette ligne*/
	// if ($val == '1') {$class = 'oui';} elseif ($val == '2') {$class = 'non';} else {$class = $val;}
	$class = $val;
	
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");

	if (!isset($extra)) $extra = "";		
	// if (strpos($descr,"bloque") != false) {$bloc .= " readonly disabled";}	
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled ";}	
	if (strpos($descr,"bloque") !== false AND $val == null) {$extra .= " class=\"bloque\"";}	
	echo ("<select class=\"$liste[$val]\" name=\"".$champ."\" id=\"".$champ."\" $extra style=\"$style\" onchange=\"this.className=this.options[this.selectedIndex].className\"/>");
	
    foreach ($liste as $key => $value) {
       echo ("<option class=\"$value\" value=\"$key\" ".($key == $val ? "SELECTED" : "")." >".$value."</option>");
	}
    
	echo ("</select><br>");
}

function metaform_check ($label,$descr,$style,$liste,$champ,$liste_reponse,$tooltip='')
{
	if (strpos($descr,"no_lab") === false)
	if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
	else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");

	if (!isset($extra)) $extra = "";				
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled ";}	
	if (strpos($descr,"bloque") !== false AND $liste_reponse == null) {$extra .= " class=\"bloque\"";}	
	if ($liste_reponse == null) $liste_reponse = array(null);
	
    foreach ($liste as $key => $value) 
		{
		$checked = array_key_exists($key,$liste_reponse) ? "checked" : "";
		echo ("<br><input type=\"checkbox\" id=\"".$champ."[]\" name=\"".$champ."[]\" value=\"$key\" style=\"$style\" style=\"$style\" $extra $checked >$value");
		}
}

function metaform_sel_multi ($label,$descr,$size,$style,$extra,$liste,$champ,$val,$tooltip='')
{
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");
	
	// if (strpos($descr,"bloque") !== false) {$extra .= " readonly disabled";$style .= "background-color:#EFEFEF";}	
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}	
	echo ("<select name=\"".$champ."[]\" id=\"".$champ."\" size = $size multiple  $extra style=\"$style\" />");
    if ($liste != "")
		{
		foreach ($liste as $key => $value) 
			echo ("<option value=\"$key\" selected>".$value."</option>");
		}
		echo ("</select>");	
}


function metaform_bout_new ($label,$descr,$extra,$champ,$val,$tooltip='')
{
	if ($descr == 'bloque') {
		echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		echo ("<input type=\"radio\" $extra disabled name=\"".$champ."\" id=\"".$champ."1\" value=\"TRUE\" ".($val=='t' ? "checked=\"true\"" : "")."><label for=\"".$champ."1\">Oui</label>
        <input type=\"radio\" $extra disabled name=\"".$champ."\" id=\"".$champ."2\" value=\"FALSE\" ".($val=='f' ? "checked=\"true\"" : "")."><label for=\"".$champ."2\">Non</label>
        <input type=\"radio\" $extra disabled name=\"".$champ."\" id=\"".$champ."3\" value=\"\" ".($val==null ? "checked=\"true\"" : "")."><label for=\"".$champ."3\">?</label><br>");
	}
	else if ($descr != 'no_lab') {
		echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");
		echo ("<input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."1\" value=\"TRUE\" ".($val=='t' ? "checked=\"true\"" : "")."><label for=\"".$champ."1\">Oui</label>
        <input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."2\" value=\"FALSE\" ".($val=='f' ? "checked=\"true\"" : "")."><label for=\"".$champ."2\">Non</label>
        <input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."3\" value=\"\" ".($val==null ? "checked=\"true\"" : "")."><label for=\"".$champ."3\">?</label><br>");
	} else {
    echo ("<input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."1\" value=\"TRUE\" ".($val=='t' ? "checked=\"true\"" : "")."><label for=\"".$champ."1\">Oui</label>
        <input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."2\" value=\"FALSE\" ".($val=='f' ? "checked=\"true\"" : "")."><label for=\"".$champ."2\">Non</label>
        <input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."3\" value=\"\" ".($val==null ? "checked=\"true\"" : "")."><label for=\"".$champ."3\">?</label><br>");
	}
}

function metaform_bout ($label,$descr,$champ,$val,$tooltip='')
{
	if (strpos($descr,'no_lab') ===false AND strpos($descr,'bloque') !== false)	$entete = "<label title=\"".$tooltip."\" class=\"preField_calc\">$label</label>";
	elseif (strpos($descr,'no_lab') === false)							$entete = "<label title=\"".$tooltip."\" class=\"preField\">$label</label>";
	else														$entete = "";
		
	if (strpos($descr,'bloque') !== false) $extra = ' disabled ';
	else 						 $extra = '';
	
	echo ("
		$entete
		<input type=\"radio\" $extra name=\"$champ\" id=\"".$champ."1\" value=\"TRUE\" ".($val=='t' ? "checked=\"true\"" : "")."><label for=\"".$champ."1\">Oui</label>
        <input type=\"radio\" $extra name=\"$champ\" id=\"".$champ."2\" value=\"FALSE\" ".($val=='f' ? "checked=\"true\"" : "")."><label for=\"".$champ."2\">Non</label>
        <input type=\"radio\" $extra name=\"$champ\" id=\"".$champ."3\" value=\"\" ".($val==null ? "checked=\"true\"" : "")."><label for=\"".$champ."3\">?</label><br>
		");

}

function metaform_bool ($label,$descr,$champ,$val,$tooltip='')
{
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");
	
	if (!isset($extra)) $extra = "";
	// if (strpos($descr,"bloque") !== false) {$extra .= " readonly disabled";$style .= "background-color:#EFEFEF";}	
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}	
	if (!isset($style)) $style = "";
	echo ("	<input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."1\" value=\"TRUE\" style=\"$style\" ".($val=='t' ? "checked=\"true\"" : "")."><label for=\"".$champ."1\">Oui</label>
			<input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."2\" value=\"FALSE\" style=\"$style\" ".($val=='f' ? "checked=\"true\"" : "")."><label for=\"".$champ."2\">Non</label>");
}


function metaform_bool_appared ($label,$descr,$extra,$style,$champ,$val,$tooltip='')
{
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");
	
	// if (strpos($descr,"bloque") !== false) {$extra .= " readonly disabled";$style .= "background-color:#EFEFEF";}	
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}	
	echo ("	<input type=\"radio\" $extra name=\"".$champ."\" id=\"".$champ."1\" value=\"TRUE\" style=\"$style\" ".($val=='t' ? "checked=\"true\"" : "")."><label for=\"".$champ."1\">Oui</label>
			<input type=\"radio\" name=\"".$champ."\" id=\"".$champ."2\" value=\"FALSE\" style=\"$style\" ".($val=='f' ? "checked=\"true\"" : "")."><label for=\"".$champ."2\">Non</label>");
}

function metaform_bout_plus ($label,$descr,$champ,$val,$tooltip='')
{
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false) echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");
	
	// if (strpos($descr,"bloque") !== false) {$extra .= " readonly disabled";$style .= "background-color:#EFEFEF";}	
	if (strpos($descr,"bloque") !== false) {$extra .= " disabled class=\"bloque\"";}	
	if (!isset($extra)) $extra = "";
    echo (" <input type=\"radio\" $extra name=\"$champ\" id=\"".$champ."1\" value=\"-1\" style=\"$style\" ".($val== -1 ? "checked=\"true\"" : "")."><label for=\"".$champ."1\">-</label>
			<input type=\"radio\" $extra name=\"$champ\" id=\"".$champ."2\" value=\"\" style=\"$style\" ".($val== null ? "checked=\"true\"" : "")."><label for=\"".$champ."2\">0</label>
			<input type=\"radio\" $extra name=\"$champ\" id=\"".$champ."3\" value=\"1\" style=\"$style\" ".($val== 1 ? "checked=\"true\"" : "")."><label for=\"".$champ."3\">+</label>");
}

function metaform_precis_plage ($label,$descr,$long,$liste,$champ_pr,$champ_pl,$val_pr,$val_pl,$tooltip='')
{
	if (strpos($descr,"no_lab") === false)
		if (strpos($descr,"bloque") !== false)
			echo ("<label title=\"".$tooltip."\" class=\"preField_calc\">".$label."</label>");
		else
			echo ("<label title=\"".$tooltip."\" class=\"preField\">".$label."</label>");
		
	if (strpos($descr,"bloque") !== false)
		{
		echo ("<label class=\"preField_calc\">".$label."</label>");
		// echo ("<input type=\"text\" name=\"".$champ_pr."\" id=\"".$champ_pr."\" size=\"".$long."\" value=\"".$val_pr."\" readonly disabled style=\"background-color:#EFEFEF\"/> 
		echo ("<input type=\"text\" name=\"".$champ_pr."\" id=\"".$champ_pr."\" size=\"".$long."\" value=\"".$val_pr."\" class=\"bloque\" disabled style=\"background-color:#EFEFEF\"/> 
			<select name=\"".$champ_pl."\" id=\"".$champ_pl."\" disabled>");
		foreach ($liste as $key => $value) 
			echo ("<option value=\"$key\" ".($key == $val_pl ? "SELECTED" : "").">".$value."</option>");
		echo ("</select><br>");
		} else {
		echo ("<input type=\"text\" name=\"".$champ_pr."\" id=\"".$champ_pr."\" size=\"".$long."\" value=\"".$val_pr."\" /> 
			<select name=\"".$champ_pl."\" id=\"".$champ_pl."\" >");
		foreach ($liste as $key => $value) 
			echo ("<option value=\"$key\" ".($key == $val_pl ? "SELECTED" : "").">".$value."</option>");
		echo ("</select><br>");
	}
}

function sql_connect ($base) {
    global $db;

    if ($base != "") {
        $db=pg_connect ("host=".SQL_server." port=".SQL_port." user=".SQL_user." password=".SQL_pass." dbname=".$base);
        return ($db);
    }
    else
        return (false);
}

function sql_connect_admin ($base) {
    global $db;
	
    if ($base != "") {
        $db=pg_connect ("host=".SQL_server." port=".SQL_port." user=".SQL_admin_user." password=".SQL_admin_pass." dbname=".$base);
        return ($db);
    }
    else
        return (false);
}

function sql_connect_hub ($base) {
    global $db2;
	
    if ($base != "") {
        $db2=pg_connect ("host=".SQL_server." port=".SQL_port_hub." user=".SQL_admin_user." password=".SQL_admin_pass." dbname=".$base);
        return ($db2);
    }
    else
        return (false);
}


function sql_assoc ($query,$back) {
    global $db;
	if (DEBUG) echo "<br>$query";
    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);unset($query);
    if ($back)	{
		for ($i=0; $i<pg_num_fields($result);$i++)	{
			$colname = pg_field_name($result,$i);
			$ligne[$colname] = pg_fetch_all_columns($result,$i);
			}
		}
	else
		$ligne = array();
	pg_free_result ($result);
	return $ligne;
	}


function frt ($field,$value) {
	/*Cette fonction a pour objectif de transformer les valeur passer dans les formulaire depuis des champ text en valeurs adapté pour la base de données
	De plus il utilise la fonction sql_format_quote pour s'occuper des soucis potentiels d'apostrophe et de guillemets
	Par exemple, un champ texte vide sera transformé de '' en null */
	
	global $aColumnsTot;
	$type = $aColumnsTot[$_SESSION['page']][$field]['type'];
	echo "<BR> type $type";
	if($type == 'string' AND $value == '')
		$value = "NULL";
	else if($type == 'string')
		$value = sql_format_quote($value,'do');
    else if($type == 'int' AND $value == null)	{
		$value = pg_escape_string ($value);
		$value = "NULL";
		}
	else if($type == 'int')
		$value = $value;
    else if($type == 'val')
		$value = $value;
    else if($type == 'bool' AND $value == 'oui')
		$value = "true";
    else if($type == 'bool' AND $value == 'non')
		$value = "false";
    else if($type == 'bool' AND $value == null)
		$value = "NULL";
    else if($type == 'bool' AND $value == 0)
		$value = "NULL";
    else if($type == 'bool')
		$value = $value;
	else 
		$value = $value;
	return ($value);
}


function sql_format_quote ($value,$do) {
		if ($do == 'undo_hmtl') $do = 'undo_html';
		$value = str_replace ("\t"," ",$value);
		$value = rtrim($value,"'");
		if(strpos($value,"'") !== false)	{
			// echo "<BR> la valeur : $value ";
			if ($do == 'do')	{
				$value = str_replace("'","\'",$value);
				// echo "sans quote : $value ";
				}
			else if ($do == 'undo' OR $do == 'undo_html' OR $do == 'undo_table' OR $do == 'undo_text' OR $do == 'undo_list')	{
				$value = str_replace("\'","'",$value);
				// echo "avec quote : $value ";
				}
		}
		if(strpos($value,'"') !== false)	{
			// echo "<BR> la valeur : $value ";
			if ($do == 'do')	{
				$value = str_replace('"','\"',$value);
				// echo "sans quote : $value ";
				}
			else if ($do == 'undo' OR $do == 'undo_html')	{
				$value = str_replace('\"','"',$value);
				// echo "avec quote : $value ";
				}
			else if ($do == 'undo_text' OR $do == 'undo_list')	{
				$value = str_replace('\"','&quot;',$value);
				}
		}
		if ($do == 'do')	{
			if  (pg_escape_string ($value) != null)
				{$value = "'" . pg_escape_string ($value) . "'";
				$value = str_replace ("<BR>","\n",$value);}
			else
				$value = 'null';
		}
		else if ($do == 'undo_html' OR $do == 'undo_table' OR $do == 'undo_list') {
			$value = str_replace ("\n","<BR>",$value);
			$value = str_replace (CHR(13).CHR(10),"<BR>",$value);
		}
	return ($value);
}

function sql_format_utf8 ($value) {
    $value = str_replace (CHR(13).CHR(10)," ",$value);
    $value = str_replace ("\n"," ",$value);
    if (get_magic_quotes_gpc()) {
        $value = stripslashes($value);
    }
    if (!is_numeric($value)) {
        $value = "'" . pg_escape_string ($value) . "'";
    }
    return (utf8_decode($value));
}

function sql_format ($value) {
    $value = str_replace (CHR(13).CHR(10)," ",$value);
    $value = str_replace ("\n"," ",$value);
    if (get_magic_quotes_gpc()) {
        $value = stripslashes ($value);
    }
    $value = "'".pg_escape_string ($value)."'";
    return ($value);
}

function sql_format_num ($value) {
    $value = str_replace (CHR(13).CHR(10)," ",$value);
    $value = str_replace ("\n"," ",$value);
    if (get_magic_quotes_gpc()) {
        $value = stripslashes ($value);
    }
    $value = pg_escape_string ($value);
    if ($value == "") $value="NULL";
    return ($value);
}

function sql_format_bool ($value) {
    if ($value == "") $value="NULL";
    return ($value);
}

function pg_cleanse ($value){
    if (is_numeric($value)){
        return pg_escape_bytea($value);
    }
    if (is_string($value)){
        return ("'".pg_escape_string(trim($value))."'");
    }
    if (is_null ($value)) {
        return null;
    }
    return ($value);
}

function add_log ($table,$id_type,$id_user,$ip,$descr1,$descr2,$tables) {
    global $db;

    $query="INSERT INTO ".SQL_schema_app.".".$table." (event,id_user,ip,descr1,descr2,tables,datetime_event) VALUES (".$id_type.",'".$id_user."','".$ip."',".sql_format ($descr1).",".sql_format ($descr2).",".sql_format ($tables).",NOW());";
    $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
}

function update_multi($query,$statut,$id_att,$att_sel,$table,$id)
	{
	global $db;
    if (!empty($query))
		{
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		$i=0;
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{
			$att[$i]=$row["$id_att"];
			$i++;
			}
		}
		
	/*déclaration quand la variable est vide*/
	$att = empty($att) ? array() : $att;
	$att_sel = empty($att_sel) ? array() : $att_sel;
    // echo "<br>".$query;

	if ($table == "eee.reponse") {$att3 = 'zone';} 
	else {$att3 = 'statut';}
	
	$query = "";
	$supp = array_diff($att, $att_sel);
	$add = array_diff($att_sel,$att);
	
	// echo "$statut 1 :<BR>";var_dump($att);
	// echo "$statut 2 :<BR>";var_dump($att_sel);
	// echo "supp :<BR>";var_dump($supp);
	// echo "add :<BR>";var_dump($add);
	
	if (!empty($supp))		/*Suppression*/
		{
		foreach ($supp as $field => $val)
			$query= $query."DELETE FROM $table WHERE (uid,$id_att,$att3) = ($id,$val,'$statut'); ";
		// echo "<br>".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		}
	if (!empty($add))		/*Ajout*/
		{
		foreach ($add as $field => $val)
			$query= $query."INSERT INTO $table VALUES ($val,'$statut',$id); ";
		// echo "<br>".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		}
		/*Log*/
		add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Saisie edit fiche",$id,"eee");
    pg_free_result ($result);	
	}

function add_multi_3($db,$add,$uid,$table,$statut)
	{
	$query = "";
	if (!empty($add))
		{
		foreach ($add as $val)
			{
			$query= $query."INSERT INTO $table VALUES ($uid,$val,'$statut'); ";
			}
		if (!empty($query))
			{
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			}
		}
	echo "<br>".$query;
	pg_free_result ($result);
	}
//------------------------------------------------------------------------------ FONCTIONS SQL

function sql_table_exist ($table)
{
    global $db;

    $query='SHOW TABLES LIKE \''.$table.'\'';
    $result=mysql_query ($query,$db) or die ('Erreur SQL !<br />'.$query.'<br />'.mysql_error());
  	return mysql_num_rows ($result);
}

function sql_rapport ($titre,$table,$numargs,$id,$time_start)
{
    echo ("<br /><div class=\"bloc2\">");
    echo ("<h3>-= ".$titre." =-</h3>");
    echo ("<center>");
    echo ("Serveur : <b>".SQL_server."</b><br>");
    echo ("Base : <b>".SQL_base."</b><br>");
    echo ("Table : <b>".$table."</b><br>");
    echo ("1 enregistrement de <b>".$numargs."</b> données<br>");
    echo ("ID de l'enregistrement : <b>".$id."</b><br>");
    echo ("Durée d'éxécution : <b>".number_format (microtime_float()-$time_start,3)." sec.</b><br>");
    echo ("<br><img src=\"../../_GRAPH/ok.png\" border=\"0\" /><b> OK.</b><br>");
    echo ("<br><br><a href=\"javascript: history.go(-2)\"><img src=\"../../_GRAPH/b2_retour.gif\"  width=\"100\" height=\"26\" border=\"0\" /></a></div>");
}

function filter_column($colonne) {
$sLimit = "";                                                                   // Paging
if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".pg_escape_string( $_GET['iDisplayLength'] )." OFFSET ".pg_escape_string( $_GET['iDisplayStart'] );

	
$sOrder = "";                                                                   // Paging
if ( isset( $_GET['iSortCol_0'] ) )                                             // ORDER BY
	{
	$sOrder="ORDER BY ";  
		foreach ($colonne as $key => $val )	{
			if	($val['pos'] == $_GET['iSortCol_0'])	{
				if (!empty($val['table_bd'])) $table = "\"".$val['table_bd']."\"."; else $table ="";
				if ( $_GET[ 'bSortable_'.intval($_GET['iSortCol_0']) ] == "true" ) {
					$sOrder .= $table."\"".$val['nom_champ_synthese']."\" ".pg_escape_string( $_GET['sSortDir_0']);
				}
			}
		}
	}
if ($sOrder=="ORDER BY ") $sOrder="";

$sWhere = "";$sHaving = "";															  // FILTRE
foreach ($colonne as $key => $val )                                       // columnFilter v2.1
{
	/*cas particulier*/
	if ($val['nom_champ_synthese'] == 'libelle_tag' AND $_GET['sSearch_'.$val['pos']] != null)
		$sHaving = "HAVING string_agg(libelle_tag,' / ') ::text ILIKE '%".pg_escape_string($_GET['sSearch_'.$val['pos']])."%' ";
    elseif ( $_GET['bSearchable_'.$val['pos']] == "true" && $_GET['sSearch_'.$val['pos']] != '' )
	{
	if (!empty($val['table_bd'])) $table = "\"".$val['table_bd']."\"."; else $table ="";
	
	$champ = "\"".$val['nom_champ_synthese']."\"";
	
		if (pg_escape_string($_GET['sSearch_'.$val['pos']]) == 'not_null') {
			$sWhere .= " AND ".$table.$champ." IS NOT NULL ";
			if ($val['type'] == 'int') $sWhere .= " AND ".$table.$champ." <> 0";
		}
		elseif (pg_escape_string($_GET['sSearch_'.$val['pos']]) == 'is_null') {
			$sWhere .= " AND ".$table.$champ." = IS NULL";
			}
		elseif (pg_escape_string($_GET['sSearch_'.$val['pos']]) == 'not_zero') {
			$sWhere .= " AND ".$table.$champ." <> 0";
		}
		elseif ($val['type'] == 'val') {
        	$sWhere .= " AND ".$table.$champ." ='".pg_escape_string($_GET['sSearch_'.$val['pos']])."' ";
     	}
		elseif ($val['type'] == 'string') {
        	$sWhere .= " AND ".$table.$champ."::text ILIKE '%".pg_escape_string($_GET['sSearch_'.$val['pos']])."%' ";
		}
		elseif ($val['type'] == 'bool') {
        	$sWhere .= " AND ".$table.$champ." = ".pg_escape_string($_GET['sSearch_'.$val['pos']])." ";
		}
		elseif ($val['type'] == 'int') {
			if (pg_escape_string($_GET['sSearch_'.$val['pos']]) == '>' OR pg_escape_string($_GET['sSearch_'.$val['pos']]) == '<' OR pg_escape_string($_GET['sSearch_'.$val['pos']]) == '=' ) {
				$sWhere .= "";
				}
			else if ((strpos($_GET['sSearch_'.$val['pos']],"<") === 0) OR (strpos($_GET['sSearch_'.$val['pos']],">") === 0) OR (strpos($_GET['sSearch_'.$val['pos']],"=") === 0)) {
				$sWhere .= " AND ".$table.$champ." ".pg_escape_string($_GET['sSearch_'.$val['pos']]);
				}
			else	{
			$sWhere .= " AND ".$table.$champ."::text ILIKE '%".pg_escape_string($_GET['sSearch_'.$val['pos']])."%' ";
			}
		}
		else {
        	$sWhere .= " AND ".$table.$champ."::text ILIKE '%".pg_escape_string($_GET['sSearch_'.$val['pos']])."%' ";
    	}
	}
}
$output = array('sLimit'=>$sLimit,'sOrder'=>$sOrder,'sWhere'=>$sWhere,'sHaving'=>$sHaving);
return $output;
}


function filter_column_post($colonne) {
$sLimit = "";                                                                   // Paging
if ( isset( $_POST['iDisplayStart'] ) && $_POST['iDisplayLength'] != '-1' )
	$sLimit = "LIMIT ".pg_escape_string( $_POST['iDisplayLength'] )." OFFSET ".pg_escape_string( $_POST['iDisplayStart'] );

	
$sOrder = "";                                                                   // Paging
if ( isset( $_POST['iSortCol_0'] ) )                                             // ORDER BY
	{
	$sOrder="ORDER BY ";  
		foreach ($colonne as $key => $val )	{
			if	($val['pos'] == $_POST['iSortCol_0'])	{
				if (!empty($val['table_bd'])) $table = "\"".$val['table_bd']."\"."; else $table ="";
				if ( $_POST[ 'bSortable_'.intval($_POST['iSortCol_0']) ] == "true" ) {
					$sOrder .= $table."\"".$val['nom_champ_synthese']."\" ".pg_escape_string( $_POST['sSortDir_0']);
				}
			}
		}
	}
if ($sOrder=="ORDER BY ") $sOrder="";

$sWhere = "";$sHaving = "";															  // FILTRE
foreach ($colonne as $key => $val )                                       // columnFilter v2.1
{
	/*cas particulier*/
	if ($val['nom_champ_synthese'] == 'libelle_tag' AND $_POST['sSearch_'.$val['pos']] != null)
		$sHaving = "HAVING string_agg(libelle_tag,' / ') ::text ILIKE '%".pg_escape_string($_POST['sSearch_'.$val['pos']])."%' ";
    elseif ( $_POST['bSearchable_'.$val['pos']] == "true" && $_POST['sSearch_'.$val['pos']] != '' )
	{
	if (!empty($val['table_bd'])) $table = "\"".$val['table_bd']."\"."; else $table ="";
	
	$champ = "\"".$val['nom_champ_synthese']."\"";
	
		if (pg_escape_string($_POST['sSearch_'.$val['pos']]) == 'not_null') {
			$sWhere .= " AND ".$table.$champ." IS NOT NULL ";
			if ($val['type'] == 'int') $sWhere .= " AND ".$table.$champ." <> 0";
		}
		elseif (pg_escape_string($_POST['sSearch_'.$val['pos']]) == 'is_null') {
			$sWhere .= " AND ".$table.$champ." = IS NULL";
			}
		elseif (pg_escape_string($_POST['sSearch_'.$val['pos']]) == 'not_zero') {
			$sWhere .= " AND ".$table.$champ." <> 0";
		}
		elseif ($val['type'] == 'val') {
        	$sWhere .= " AND ".$table.$champ." ='".pg_escape_string($_POST['sSearch_'.$val['pos']])."' ";
     	}
		elseif ($val['type'] == 'string') {
        	$sWhere .= " AND ".$table.$champ."::text ILIKE '%".pg_escape_string($_POST['sSearch_'.$val['pos']])."%' ";
		}
		elseif ($val['type'] == 'bool') {
        	$sWhere .= " AND ".$table.$champ." = ".pg_escape_string($_POST['sSearch_'.$val['pos']])." ";
		}
		elseif ($val['type'] == 'int') {
			if (pg_escape_string($_POST['sSearch_'.$val['pos']]) == '>' OR pg_escape_string($_POST['sSearch_'.$val['pos']]) == '<' OR pg_escape_string($_POST['sSearch_'.$val['pos']]) == '=' ) {
				$sWhere .= "";
				}
			else if ((strpos($_POST['sSearch_'.$val['pos']],"<") === 0) OR (strpos($_POST['sSearch_'.$val['pos']],">") === 0) OR (strpos($_POST['sSearch_'.$val['pos']],"=") === 0)) {
				$sWhere .= " AND ".$table.$champ." ".pg_escape_string($_POST['sSearch_'.$val['pos']]);
				}
			else	{
			$sWhere .= " AND ".$table.$champ."::text ILIKE '%".pg_escape_string($_POST['sSearch_'.$val['pos']])."%' ";
			}
		}
		else {
        	$sWhere .= " AND ".$table.$champ."::text ILIKE '%".pg_escape_string($_POST['sSearch_'.$val['pos']])."%' ";
    	}
	}
}
$output = array('sLimit'=>$sLimit,'sOrder'=>$sOrder,'sWhere'=>$sWhere,'sHaving'=>$sHaving);
return $output;
}

function add_and_modif_taxon ($in,$mod,$uid_modif)
{
/*$in corresponds aux infos du taxons à enregistrer*/
global $db;
$range = array(0=>"",1=>"ES",2=>"SSES",3=>"VAR",4=>"SVAR",5=>"FO",6=>"SSFO");
$rang_plus = str_replace ('\'', '', $in["rang"]);
$id_rang = array_search($rang_plus,$range) ? array_search($rang_plus,$range) : 0 ;
// echo $range[$rang_plus];

$catnat = $in["catnat"];$lr=$in["lr"];$eee = $in["eee"];

$cd_nom=$in["cd_nom"];$cd_ref=$in["cd_ref"];$lb_nom=$in["lb_nom"];$lb_auteur=$in["lb_auteur"];$nom_complet=$in["nom_complet"];$nom_valide=$in["nom_valide"];$nom_vern=$in["nom_vern"];$nom_vern_eng=$in["nom_vern_eng"];$cd_taxsup=$in["cd_taxsup"];$rang=$in["rang"];$regne=$in["regne"];$phylum=$in["phylum"];$classe=$in["classe"];$ordre=$in["ordre"];$famille=$in["famille"];$fr=$in["fr"];
$gf=$in["gf"];$mar=$in["mar"];$gua=$in["gua"];$sm=$in["sm"];$sb=$in["sb"];$spm=$in["spm"];$may=$in["may"];$epa=$in["epa"];$reu=$in["reu"];$taaf=$in["taaf"];$pf=$in["pf"];$nc=$in["nc"];$wf=$in["wf"];$cli=$in["cli"];$habitat=$in["habitat"];$hybride = $in["hybride"];


if ($mod == 'add')
	{
	/*Création centralisée du taxons*/
	$query="INSERT INTO refnat.taxons
	(cd_nom, cd_ref, lb_nom, lb_auteur, nom_complet, nom_valide, nom_vern, nom_vern_eng, cd_taxsup, rang, regne, phylum, classe, ordre, famille, fr, gf, mar, gua, sm, sb, spm, may, epa, reu, taaf, pf ,nc ,wf , cli, habitat, hybride,catnat,lr,eee) 
	VALUES 
	($cd_nom, $cd_ref, $lb_nom, $lb_auteur, $nom_complet, $nom_valide, $nom_vern, $nom_vern_eng, $cd_taxsup, $rang, $regne, $phylum, $classe, $ordre, $famille, $fr, $gf, $mar, $gua, $sm, $sb, $spm, $may, $epa, $reu, $taaf, $pf ,$nc ,$wf , $cli, $habitat, $hybride,$catnat,$lr,$eee) RETURNING uid;";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	$uid=pg_result($result,0,"uid");
	echo $query;

	/*Synchronisation des autres rubriques*/
	$query = "";
	if ($catnat == 'TRUE') {
	$query .= "
	INSERT INTO catnat.taxons_nat(uid,famille,cd_ref,nom_sci,nom_vern,cd_rang,hybride) VALUES ($uid,$famille,$cd_ref,$nom_complet,$nom_vern,$rang,$hybride);
	INSERT INTO catnat.statut_nat (uid) VALUES ($uid);
	";}
	if ($eee == 'TRUE'){

	$query .= "
	INSERT INTO eee.taxons(uid,cd_ref,nom_sci,nom_verna,lib_rang) VALUES ($uid,$cd_ref,$nom_complet,$nom_vern,$rang);
	INSERT INTO eee.evaluation(uid) VALUES ($uid);
	";}
	if ($lr == 'TRUE'){
	$query .= "
	INSERT INTO lr.taxons(uid,famille,cd_ref,nom_sci,nom_vern,id_rang,hybride) VALUES ($uid,$famille,$cd_ref,$nom_complet,$nom_vern,$id_rang,$hybride);
	INSERT INTO lr.chorologie(uid) VALUES ($uid);
	INSERT INTO lr.evaluation(uid,etape,avancement) VALUES ($uid,1,1);
	";}
	
	if ($query != "") $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	}
else
	{
	/*Synchronisation des autres rubriques*/
	$query = "";
	if ($catnat == 'TRUE'){
		$select="SELECT uid FROM catnat.taxons_nat WHERE uid = $uid_modif;";
		$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".$select);
		$uid=pg_result($result,0,"uid");
		
		if ($uid != null) {
			$query .= "
			UPDATE catnat.taxons_nat SET famille=$famille,cd_ref=$cd_ref,nom_sci=$nom_complet,nom_vern=$nom_vern,cd_rang=$rang,hybride=$hybride WHERE uid=$uid_modif;
			";
		} else {	
			$query .= "
			INSERT INTO catnat.taxons_nat(uid,famille,cd_ref,nom_sci,nom_vern,cd_rang,hybride) VALUES ($uid_modif,$famille,$cd_ref,$nom_complet,$nom_vern,$rang,$hybride);
			INSERT INTO catnat.statut_nat (uid) VALUES ($uid_modif);
			";
		}
	}

	if ($eee == 'TRUE'){
		$select="SELECT uid FROM eee.taxons WHERE uid = $uid_modif;";
		$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".$select);
		$uid=pg_result($result,0,"uid");
		
		if ($uid != null) {
			$query .= "
			UPDATE eee.taxons SET cd_ref=$cd_ref,nom_sci=$nom_complet,nom_verna=$nom_vern,lib_rang=$rang WHERE uid=$uid_modif;
			";
		} else {	
			$query .= "
			INSERT INTO eee.taxons(uid,cd_ref,nom_sci,nom_verna,lib_rang) VALUES ($uid_modif,$cd_ref,$nom_complet,$nom_vern,$rang);
			INSERT INTO eee.evaluation(uid) VALUES ($uid_modif);
			";
		}
	}

	if ($lr == 'TRUE'){
		$select="SELECT uid FROM lr.taxons WHERE uid = $uid_modif;";
		$result=pg_query ($db,$select) or die ("Erreur pgSQL : ".$select);
		$uid=pg_result($result,0,"uid");
		
		if ($uid != null) {
			$query .= "
			UPDATE lr.taxons SET famille=$famille,cd_ref=$cd_ref,nom_sci=$nom_complet,nom_vern=$nom_vern,id_rang=$id_rang,hybride=$hybride WHERE uid=$uid_modif;
			";
		} else {	
			$query .= "
			INSERT INTO lr.taxons(uid,famille,cd_ref,nom_sci,nom_vern,id_rang,hybride) VALUES ($uid_modif,$famille,$cd_ref,$nom_complet,$nom_vern,$id_rang,$hybride);
			INSERT INTO lr.chorologie(uid) VALUES ($uid_modif);
			INSERT INTO lr.evaluation(uid,etape,avancement) VALUES ($uid_modif,1,1);
			";
		}
	}

	if ($query != "") $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
	}
	// echo $query;
return $uid;
}

function envoi_mail($destinataires, $sujet_mail, $contenu_mail, $options="")
{
	////	INITIALISATION
	global $trad, $infos_trad;
	if(empty($options["message_alert"]))								$options["message_alert"] = "oui";
	if(empty($options["header_footer"]))								$options["header_footer"] = "oui";
	if(empty($options["accuse_reception"]))								$options["accuse_reception"] = "non";
	if(empty($options["afficher_dest_message"]))						$options["afficher_dest_message"] = "non";
	if(empty($options["expediteur_noreply"]))							$options["expediteur_noreply"] = "non";
	if(empty($options["envoi_fichiers"]) or control_upload()==false)	$options["envoi_fichiers"] = "non";
	$frontiere = "-----=".uniqid(mt_rand());

	////	EXPEDITEUR
/**/if(isset($_SESSION["user"]["nom"]) and $options["expediteur_noreply"]=="non")	{ $expediteur_nom = auteur($_SESSION["user"]);	$expediteur_adresse = $_SESSION["user"]["mail"]; }
	else																			{ $expediteur_nom = "no-reply";			$expediteur_adresse = "noreply@".str_replace("www.","",$_SERVER["SERVER_NAME"]); }

	////	DESTINATAIRES
	if(is_array($destinataires)==false)		$destinataires = array($destinataires);
/**/foreach($destinataires as $dest_key => $dest_tmp){
/**/	if(is_numeric($dest_tmp))	{ $mail_tmp = user_infos($dest_tmp,"mail");   if($mail_tmp!="") $destinataires[$dest_key] = $mail_tmp; }
/**/}
	$destinataires_txt = implode(",", array_unique($destinataires));
	$destinataire_php = (count($destinataires)>1)  ?  ""  :  $destinataires_txt;

	////	HEADERS
	$header = "From: ".$expediteur_nom."<".$expediteur_adresse.">\n".
			  "MIME-Version: 1.0\n";
	$bcc_to = ($options["afficher_dest_message"]=="oui")  ?  "To: "  :  "Bcc: ";
	if(count($destinataires)>1)		$header .= $bcc_to.$destinataires_txt."\n";
	if($options["accuse_reception"]=="oui")   $header .= "Disposition-notification-to: ".$_SESSION["user"]["mail"]."\n";
	if($options["envoi_fichiers"]=="oui")	{ $header .= "Content-Type: multipart/mixed; boundary=\"".$frontiere."\"\n"; }
	else									{ $header .= "Content-Type: text/html; charset=UTF-8\n"; }

	////	MESSAGE HTML
	$message_html = "<html>\n<head>\n<title>\n</title>\n</head>\n<body>\n";
/**/if($options["header_footer"]=="oui" and isset($_SESSION["user"]["nom"]))	$message_html .= $trad["divers"]["mail_envoye_par"]." ".auteur($_SESSION["user"])." (".$_SESSION["espace"]["nom"].") :<br /><br />";
	$message_html .= wordwrap($contenu_mail);
/**/if($options["header_footer"]=="oui")										$message_html .= "<br /><br /><a href=\"".$_SESSION["agora"]["adresse_web"]."\" target=\"_blank\">".$_SESSION["agora"]["nom"]."</a><br />";
	$message_html .= "</body>\n</html>\n\n";

	////	MESSAGE HTML ?  MESSAGE HTML + FICHIERS JOINTS ?
	if($options["envoi_fichiers"]!="oui")	{ $message = $message_html; }
	else
	{
		// Séparation du message html avec les fichiers
		$message  = "--".$frontiere."\n";
		$message .= "Content-Type: text/html; charset=UTF-8\n\n";
		$message .= $message_html."\n\n";
		// ajout de chaque fichier
		foreach($_FILES as $fichier)
		{
			if($fichier["error"]==0) {
				$message .= "--".$frontiere."\n";
				$message .= "Content-Type: ".$fichier["type"]."; name=\"".$fichier["name"]."\"\n";
				$message .= "Content-Transfer-Encoding: BASE64\n";
				$message .= "Content-Disposition:attachment; filename=\"".$fichier["name"]."\"\n\n";
				$message .= chunk_split(base64_encode(file_get_contents($fichier["tmp_name"])))."\n\n";
			}
		}
		$message .= "--".$frontiere."--";
	}

	////	ENVOI DU MAIL + RAPPORT D'ENVOI SI DEMANDE
	$message_envoye = mail($destinataire_php, suppr_carac_spe($sujet_mail,"faible"), $message, $header);
	if($options["message_alert"]=="oui") {
		if($message_envoye==true)	alert("le(s) mail(s) a/ont été envoyé(s)");
		else						alert("le(s) mail(s) n'a/ont <b>pas</b> été envoyé(s)");
	}
	return $message_envoye;
}

function suppr_carac_spe($text, $etendue="moyen", $carac_remplace="_")
{
	// Remplace les caractères de l'alphabet
	$text = str_replace(array("à","â","ä"), "a", $text);
	$text = str_replace(array("é","è","ê","ë"), "e", $text);
	$text = str_replace(array("ï","ì"), "i", $text);
	$text = str_replace(array("ô","ö"), "o", $text);
	$text = str_replace(array("ù","û","ü"), "u", $text);
	$text = str_replace("ç", "c", $text);
	// Remplace les ponctuations et autres caractères spéciaux
	if($etendue!="faible")
	{
		$carac_spe_autorise = ($etendue=="moyen")  ?  array("-",".","_","'")  :  array("-",".","_");
		for($i=0; $i<strlen($text); $i++){
			if(preg_match("/[0-9a-z]/i",$text[$i])==false and in_array($text[$i],$carac_spe_autorise)==false)	$text[$i] = $carac_remplace;
		}
		$text = str_replace($carac_remplace.$carac_remplace, $carac_remplace, $text);
	}
	return trim($text,$carac_remplace);
}

function alert($text_alerte, $onload=true)
{
	echo "<script type=\"text/javascript\">  ".($onload==true?"onLoad=":"")." alert(\"".$text_alerte."\");  </script>";
}


function msg_pw($variable)
{
	foreach ($variable as $key => $val)
		if ($val == null) $variable[$key] = "<i>--vide--</i>";
	
	$tab_ref = array ('ref_lr','ref_eee','ref_lsi','ref_catnat','ref_refnat');
	foreach ($tab_ref as $key => $value)
		if ($variable[$value] === 't') $variable[$value] = "<td> Vous êtes référent sur cette rubrique </td>"; else $variable[$value] = "";
	
	$note = "150921_Note_Codex.pdf";
	// $note = "150915_Note_ouverture_Codex.pdf";
	
	$message = "<html><head></head><body>
			---CECI EST UN MAIL AUTOMATIQUE---
		<br>----MERCI DE NE PAS Y REPONDRE----
			<br><br>Bonjour,
			<br><br> Vous trouverez ci-joint vos identifiants personnalisés de connexion pour accéder à l'outil Codex, ainsi que la description des informations de votre profil.
			<br> Pour accéder directement à l'outil, veuillez suivre ce lien : <a href=\"codex.fcbn.fr\">codex.fcbn.fr</a>
			<br> Retrouvez également la liste des outils de la FCBN à l'adresse suivante : <a href=\"services.fcbn.fr\">services.fcbn.fr</a>
			<br> Si vous notez une erreur dans vos informations personnelles, merci d'envoyer un mail à <a href=\"mailto:informatique@fcbn.fr\">informatique@fcbn.fr</a> à ce sujet.
			
			<br><br>Retrouvez la note d’information qui présente l'outil au lien suivant : <a href = \"".str_replace("www.","",$_SERVER["SERVER_NAME"])."/flore/home/".$note."\">".str_replace("www.","",$_SERVER["SERVER_NAME"])."/flore/home/".$note."</a>
			
			<br><br><b>Identifiants de connexion</b>
			<table cellpadding=\"5\" border =\"solid 1px black\">
			<tr><td> Login </td><td>".$variable['login']."</td></tr>
			<tr><td> MdP </td><td>".$variable['pw']."</td></tr>
			</table>
			
			<br><br> <b>Informations professionnelles</b>
			<table cellpadding=\"5\" border =\"solid 1px black\">
			<tr><td> Nom </td><td>".$variable['nom']."</td></tr>
			<tr><td> Prénom </td><td>".$variable['prenom']."</td></tr>
			<tr><td> CBN </td><td>".$variable['lib_cbn']."</td></tr>
			<tr><td> Tel bureau </td><td>".$variable['tel_bur']."</td></tr>
			<tr><td> Tel portable </td><td>".$variable['tel_port']."</td></tr>
			<tr><td> Email </td><td>".$variable['email']."</td></tr>
			<tr><td> Description </td><td>".$variable['descr']."</td></tr>
			</table>
			
			<br><br> <b> Droit d'accès</b>
			<table cellpadding=\"5\" border =\"solid 1px black\">
			<tr><td> Rôle pour la rubrique \"Référentiel national\" </td><td>".$variable['refnat']."</td>".$variable['ref_refnat']."</tr>
			<tr><td> Rôle pour la rubrique \"Catalogue national\" </td><td>".$variable['catnat']."</td>".$variable['ref_catnat']."</tr>
			<tr><td> Rôle pour la rubrique \"Liste rouge\" </td><td>".$variable['lr']."</td>".$variable['ref_lr']."</tr>
			<tr><td> Rôle pour la rubrique \"Liste EEE\" </td><td>".$variable['eee']."</td>".$variable['ref_eee']."</tr>
			<tr><td> Rôle pour la rubrique \"Lettre Système d'information et géomatique\" </td><td>".$variable['lsi']."</td>".$variable['ref_lsi']."</tr>
			</table>
			<br><br> Cordialement,
			<br><br> Thomas Milon
			
			</body></html>";
				
			return $message;
			}




/*USELESS?*/
function convert_txt ($txt) {
    $out=trim (html_entity_decode(strip_tags($txt)));
    $out2=str_replace ("&rsquo;","'",$out);
    $out3=str_replace ("&ndash;","-",$out2);
    return ($out3);
}

/*USELESS?*/
function filter ($str) {
    $str = str_replace ("\n", "", $str);
    $str = str_replace ("\r\n", "", $str);
    // $str = str_replace ("\r", "", $str); 
    $str = str_replace ("\\\"", "\"", $str); 
    $str = str_replace ("\\'", "'", $str); 
    return ($str);
}

/*USELESS?*/
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

function les_boutons($array_bouton,$niveau,$lang,$schema,$test_cbn) {
		$db2=sql_connect_hub(SQL_base_hub);
		echo ("<div style=\"float:left;\" >");  
		foreach ($array_bouton as $val)	{
				echo ("<table border=0 width=\"100%\" id=\"action_bdd\">");
				if ($niveau >= 255 OR ($niveau >= $val["niveau"] AND ($val["cbn"] == FALSE OR ($val["cbn"] == TRUE AND $test_cbn))))
					{
					/*Récupération de la date de dernière réalisation*/
					$query= "SELECT max(date_log) FROM public.zz_log WHERE typ_log = 'hub_".$val["id"]."' AND lib_schema = '$schema';";
					$result=pg_query ($db2,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
					$row = pg_fetch_row($result);
					/*Button*/
					echo ("<tr valign=top ><td style=\"width: 150px;\">");
					echo ("<button id=\"".$val["id"]."_button\" value=\"".$val["id"]."\" name=\"".$schema."\">".$lang['fr'][$val["id"]]."</button> ");
					echo ("</td><td>");		
					metaform_text ($val["text"]," bloque",15,"",$val["id"],substr($row[0],0,-4));	/*dernière réalisation*/
					echo ("</td></tr>");
					}
					echo ("</table>");
				}
			echo ("</div>");
			}

?>
