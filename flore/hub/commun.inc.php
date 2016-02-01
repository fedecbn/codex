<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "hub";
$id_page_2 = "droit";
$name_page = "Hub - interface de gestion des données du réseau";

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

$query_module = ""; /*Directement dans index.php*/

$query_liste = "
SELECT count(*) OVER() AS total_count,*
	FROM public.bilan 
	WHERE 1 = 1 ";
	

$query_export = "
SELECT * 
	FROM hub.bilan
	WHERE 1 = 1	";

//------------------------------------------------------------------------------ VOCABULAIRE du module
$lang['fr'][$id_page]="Hub";

$lang['fr']['titre']="Hub";

$lang['fr']['groupe_1']="Actions";

$lang['fr']['groupe_2']="Log";

$lang['fr']['import']="Lancer un import";

$lang['fr']['export']="Lancer un export";

$lang['fr']['bilan']="Rafraîchir le bilan sur les données";


//------------------------------------------------------------------------------ CHAMPS du module
$langliste['fr'][$id_page][]="uid";
$langliste['fr'][$id_page.'-popup'][]="Code du CBN";

$langliste['fr'][$id_page][]="CBN";
$langliste['fr'][$id_page.'-popup'][]="Trigramme du CBN";

$langliste['fr'][$id_page][]="nb relevé";
$langliste['fr'][$id_page.'-popup'][]="Nombre de relevés";

$langliste['fr'][$id_page][]="nb Observation";
$langliste['fr'][$id_page.'-popup'][]="Nombre d'observations";

$langliste['fr'][$id_page][]="nb taxon (data)";
$langliste['fr'][$id_page.'-popup'][]="Nombre de taxons (data)";

$langliste['fr'][$id_page][]="nb taxon (taxa)";
$langliste['fr'][$id_page.'-popup'][]="Nombre de taxons (taxa)";

//------------------------------------------------------------------------------ FONCTIONS du module

?>