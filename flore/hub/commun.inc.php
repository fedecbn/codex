<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "defaut";
$id_page_2 = "defaut_2";
$name_page = "Rubrique Test";

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

$query_module = "
SELECT t.* 
	FROM defaut.base t 
	JOIN applications.taxons a ON a.uid = t.uid 
	WHERE a.defaut = TRUE AND t.uid=";

$query_liste = "
SELECT count(*) OVER() AS total_count,*
	FROM defaut.base
	JOIN applications.taxons a ON base.uid = a.uid
	WHERE a.defaut = TRUE ";
	
$query_export = "
SELECT t.* 
	FROM defaut.uid t 
	JOIN applications.taxons a ON a.uid = t.uid 
	WHERE a.defaut = TRUE ";

// ------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>