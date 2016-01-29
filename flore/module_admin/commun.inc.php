<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

$query_rub = "SELECT id_module FROM applications.rubrique ORDER BY pos";
//------------------------------------------------------------------------------ CONSTANTES du module
/*récupération des rubriques*/
$result=pg_query ($db,$query_rub) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
While ($row = pg_fetch_row($result)) $rubrique[$row[0]] = $row[0];

/*référents et  niveau de droits*/
foreach ($rubrique as $val)
	{
	$ref[$val]=isset ($_SESSION['ref_'.$val]) ? $_SESSION['ref_'.$val] : 0;
	$niveau[$val]=isset ($_SESSION['niveau_'.$val]) ? $_SESSION['niveau_'.$val] : 0;
	$blocked[$val]= ($ref[$val] == 't' OR $niveau[$val] >= 255) ? "" : "disabled";
	}
$niveau['all']=isset ($_SESSION['niveau']) ? $_SESSION['niveau'] : 0;
$ref['all']=isset ($_SESSION['ref']) ? $_SESSION['ref'] : 0;

$id_user = $_SESSION['id_user'];

// $rub = array('lr' => 'Niveau LR','eee' => 'Niveau EEE','catnat' => 'Niveau CATNAT','refnat' => 'Niveau REF NAT','lsi' => 'Niveau LSI','fsd' => 'Niveau FSD');	

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module
 
?>
