<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
/*référents*/
$ref['all']=isset ($_SESSION['ref']) ? $_SESSION['ref'] : 0;
$ref['lr']=isset ($_SESSION['ref_lr']) ? $_SESSION['ref_lr'] : 0;
$ref['eee']=isset ($_SESSION['ref_eee']) ? $_SESSION['ref_eee'] : 0;
$ref['lsi']=isset ($_SESSION['ref_lsi']) ? $_SESSION['ref_lsi'] : 0;
$ref['refnat']=isset ($_SESSION['ref_refnat']) ? $_SESSION['ref_refnat'] : 0;
$ref['catnat']=isset ($_SESSION['ref_catnat']) ? $_SESSION['ref_catnat'] : 0;
$ref['fsd']=isset ($_SESSION['ref_fsd']) ? $_SESSION['ref_fsd'] : 0;
$niveau['all']=isset ($_SESSION['niveau']) ? $_SESSION['niveau'] : 0;
$niveau['lr']=isset ($_SESSION['niveau_lr']) ? $_SESSION['niveau_lr'] : 0;
$niveau['eee']=isset ($_SESSION['niveau_eee']) ? $_SESSION['niveau_eee'] : 0;
$niveau['lsi']=isset ($_SESSION['niveau_lsi']) ? $_SESSION['niveau_lsi'] : 0;
$niveau['refnat']=isset ($_SESSION['niveau_refnat']) ? $_SESSION['niveau_refnat'] : 0;
$niveau['catnat']=isset ($_SESSION['niveau_catnat']) ? $_SESSION['niveau_catnat'] : 0;
$niveau['fsd']=isset ($_SESSION['niveau_fsd']) ? $_SESSION['niveau_fsd'] : 0;
$id_user = $_SESSION['id_user'];
// echo $id_user;

$rub = array('lr' => 'Niveau LR','eee' => 'Niveau EEE','catnat' => 'Niveau CATNAT','refnat' => 'Niveau REF NAT','lsi' => 'Niveau LSI','fsd' => 'Niveau FSD');	


// var_dump($ref);
// var_dump($niveau);
//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module
 
?>
