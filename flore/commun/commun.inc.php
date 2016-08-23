<?php
//------------------------------------------------------------------------------//
//   commun/commun.inc.php                                                      //
//                                                                              //
//  Banque de semences ‘VANDA’                                                  //
//                                                                              //
//  Version 1.00  13/07/12 - DariaNet                                           //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
session_start ();
if (file_exists("../../_INCLUDE/config_sql.inc.php") == TRUE)	require_once ("../../_INCLUDE/config_sql.inc.php"); else require_once ("../../_INCLUDE/config_sql.inc.example.php");
require_once ("../../_INCLUDE/constants.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");
require_once ("../../_INCLUDE/common.lang.php");
require_once ("module.lang.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$etape_txt=array("","pré-eval","éval","post-éval");
global $lang;
global $langliste;

//------------------------------------------------------------------------------ PATHS du module
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ SQL
$query_liste["user"] = "SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,
CASE WHEN utilisateur_role.lecteur = TRUE THEN 'lecteur ' ELSE '' END || 
CASE WHEN utilisateur_role.participant = TRUE THEN 'participant ' ELSE ''  END || 
CASE WHEN utilisateur_role.evaluateur = TRUE THEN 'evaluateur ' ELSE ''  END || 
CASE WHEN utilisateur_role.gestionnaire = TRUE THEN 'gestionnaire ' ELSE ''  END || 
CASE WHEN utilisateur_role.validateur = TRUE THEN 'validateur ' ELSE ''  END || 
CASE WHEN utilisateur_role.administrateur = TRUE THEN 'administrateur ' ELSE ''  END
as niveau, 
CASE WHEN utilisateur_role.referent = TRUE THEN 'referent' END as referent
FROM applications.utilisateur
JOIN applications.utilisateur_role ON utilisateur.id_user = utilisateur_role.id_user
WHERE utilisateur_role.no_acces IS FALSE AND rubrique = ";


//------------------------------------------------------------------------------ FONCTIONS du module
$not_home = substr($_SERVER["PHP_SELF"],strlen($_SERVER["PHP_SELF"])-15) == '/home/index.php' ? false : true;
$not_install = substr($_SERVER["PHP_SELF"],strlen($_SERVER["PHP_SELF"])-17) == '/home/install.php' ? false : true;
if ($_SESSION['EVAL_FLORE'] != "ok" 
	AND $not_home
	AND $not_install
	) require ("../commun/access_expired.php");
?>
