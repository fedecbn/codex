<?php
//------------------------------------------------------------------------------//
//   home/commun.inc.php                                                        //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page='home';
$db=sql_connect (SQL_base);

define ("DEBUG",false);
$id_user=$_SESSION['id_user'];	

$query_rub = "
	SELECT id_module
	FROM applications.rubrique
	WHERE typ = 'list'
	AND id_module <> 'syntaxa'
	ORDER BY pos";

$query_list="SELECT * FROM applications.rubrique 
	WHERE typ = 'list'
	ORDER BY pos;";

/*Récupération des droits utilisateurs*/	
$_SESSION["droit_user"] = recup_droit($id_user);


//------------------------------------------------------------------------------ PATHS du module
$result=pg_query ($db,$query_rub) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
While ($row = pg_fetch_row($result)) $rubrique[$row[0]] = $row[0];

foreach ($rubrique as $key => $val)
	{
	$ref[$val]=isset ($_SESSION['ref_'.$val]) ? $_SESSION['ref_'.$val] : 0;
	$niveau[$val]=isset ($_SESSION['niveau_'.$val]) ? $_SESSION['niveau_'.$val] : 0;
	}
$niveau['all']=isset ($_SESSION['niveau']) ? $_SESSION['niveau'] : 0;
$ref['all']=isset ($_SESSION['ref']) ? $_SESSION['ref'] : 0;


//------------------------------------------------------------------------------ FONCTIONS du module

?>
