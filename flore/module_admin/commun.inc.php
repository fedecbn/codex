<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
/*récupération des rubriques*/
$query = "SELECT id_module FROM applications.rubrique ORDER BY pos";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
While ($row = pg_fetch_row($result)) $rubrique[$row[0]] = $row[0];

/*référents et  niveau de droits*/
foreach ($rubrique as $key => $val)
	{
	$ref[$key]=isset ($_SESSION['ref_'.$key]) ? $_SESSION['ref_'.$key] : 0;
	$niveau[$key]=isset ($_SESSION['niveau_'.$key]) ? $_SESSION['niveau_'.$key] : 0;
	$blocked[$key]= ($ref[$key] == 't' OR $niveau[$key] >= 255) ? "" : "disabled";
	}
$niveau['all']=isset ($_SESSION['niveau']) ? $_SESSION['niveau'] : 0;
$ref['all']=isset ($_SESSION['ref']) ? $_SESSION['ref'] : 0;

$id_user = $_SESSION['id_user'];

$id_page = $_SESSION['page'] = "module_admin";


//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module
 
 //------------------------------------------------------------------------------ Module admin / textes
$langliste['fr']['admin-text-liste'][]="Code";
$langliste['fr']['admin-text-liste-popup'][]="Code";

$langliste['fr']['admin-text-liste'][]="Titre";
$langliste['fr']['admin-text-liste-popup'][]="Titre de la zone de texte";

$langliste['fr']['admin-text-liste'][]="Extrait";
$langliste['fr']['admin-text-liste-popup'][]="Extrait de la zone de texte";

$langliste['fr']['admin-text-liste'][]="Langue";
$langliste['fr']['admin-text-liste-popup'][]="Langue";

//------------------------------------------------------------------------------ Module admin / Users

/*récupération des champs*/
$query = "SELECT nom_champ,description,description_longue FROM referentiels.champs WHERE rubrique_champ = 'utilisateur' AND pos IS NOT NULL ORDER BY pos";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

While ($row = pg_fetch_row($result)) 
	{
	$langliste['fr']['admin-user-liste'][]= $row[1];
	$langliste['fr']['admin-user-liste-popup'][]= $row[2];
	}


//------------------------------------------------------------------------------ Module admin / Suivi
$langliste['fr']['admin-suivi-liste'][]="UID";
$langliste['fr']['admin-suivi-liste-popup']['1-popup']="Identifiant unique";

$langliste['fr']['admin-suivi-liste'][]="Utilisateur";
$langliste['fr']['admin-suivi-liste-popup']['2-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Institution";
$langliste['fr']['admin-suivi-liste-popup']['3-popup']="";

$langliste['fr']['admin-suivi-liste'][]="CD REF";
$langliste['fr']['admin-suivi-liste-popup']['4-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Taxon";
$langliste['fr']['admin-suivi-liste-popup']['5-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Rubrique";
$langliste['fr']['admin-suivi-liste-popup']['6-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Type<BR>modif";
$langliste['fr']['admin-suivi-liste-popup']['7-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Manuelle / auto";
$langliste['fr']['admin-suivi-liste-popup']['7-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Champ";
$langliste['fr']['admin-suivi-liste-popup']['7-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Valeur<br>Avant";
$langliste['fr']['admin-suivi-liste-popup']['8-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Valeur<br>Après";
$langliste['fr']['admin-suivi-liste-popup']['9-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Date";
$langliste['fr']['admin-suivi-liste-popup']['10-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Heure";
$langliste['fr']['admin-suivi-liste-popup']['11-popup']="";

$langliste['fr']['admin-suivi-liste'][]="ID";
$langliste['fr']['admin-suivi-liste-popup']['12-popup']="";
//------------------------------------------------------------------------------ Module admin / Logs
$langliste['fr']['admin-log-liste'][]="Rubrique";
$langliste['fr']['admin-log-liste-popup'][]="";

$langliste['fr']['admin-log-liste'][]="User";
$langliste['fr']['admin-log-liste-popup']['2-popup']="";

$langliste['fr']['admin-log-liste'][]="IP";
$langliste['fr']['admin-log-liste-popup']['3-popup']="Adresse IP v4";

$langliste['fr']['admin-log-liste'][]="Descr. 1";
$langliste['fr']['admin-log-liste-popup']['4-popup']="";

$langliste['fr']['admin-log-liste'][]="Descr. 2";
$langliste['fr']['admin-log-liste-popup']['5-popup']="";

$langliste['fr']['admin-log-liste'][]="Tables";
$langliste['fr']['admin-log-liste-popup']['6-popup']="";

$langliste['fr']['admin-log-liste'][]="Date";
$langliste['fr']['admin-log-liste-popup']['7-popup']="";

$langliste['fr']['admin-log-liste'][]="Heure";
$langliste['fr']['admin-log-liste-popup']['8-popup']="";

$langliste['fr']['admin-log-liste'][]="ID";
$langliste['fr']['admin-log-liste-popup']['9-popup']="";
?>
