<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../../_INCLUDE/config_sql.inc.php");
require_once ("../../_INCLUDE/constants.inc.php");
require_once ("../../_INCLUDE/fonctions.inc.php");

require_once ("../../_INCLUDE/common.lang.php");
require_once ("../commun/module.lang.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "fsd";
$id_page_2 = "droit";
$title = $lang['fr']['titre_web']." - ".$id_page;
$titre = "Format Standard";

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

if (ON_Server == 'no') $path = 'D:/'; else $path = '/home/export_pgsql/';

//------------------------------------------------------------------------------ QUERY du module
$query_champ = " SELECT * FROM referentiels.champ WHERE id_module = '$id_page'";

$query_liste = " SELECT count(*) OVER() AS total_count, ddd.* FROM fsd.ddd WHERE 1 = 1 ";
	
$query_export = "SELECT * FROM fsd.ddd WHERE 1 = 1";
$export_id = "uid";

$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page.", utilisateur.ref_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";
	
$query_discussion = "
	SELECT prenom||' '||nom||' ('||cd_cbn||') le '||to_char(datetime, 'dd/MM/YYYY')||' à '||to_char(datetime, 'HH24')||'h'||to_char(datetime, 'MI'), commentaire_eval 
	FROM fsd.discussion a JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn 
	WHERE uid = ";

	//------------------------------------------------------------------------------ VOCABULAIRE du module
$lang['fr']['fsd']="Dictionnaire de données";
$lang['it']['fsd']="";

$lang['fr']['liste_fsd']="Dictionnaire de données";
$lang['it']['liste_fsd']="";

$lang['fr']['groupe_fsd_1']="Description Champ";
$lang['it']['groupe_fsd_1']="";

$lang['fr']['groupe_fsd_2']="Description Champ ancienne version";
$lang['it']['groupe_fsd_2']="";

$lang['fr']['liste_champ']="Liste des champs";
$lang['it']['liste_champ']="";

//------------------------------------------------------------------------------ CHAMPS du module
$langliste['fr'][$id_page][]="Id";
$langliste['fr'][$id_page.'-popup'][]="Identifiant";

$langliste['fr'][$id_page][]="Version";
$langliste['fr'][$id_page.'-popup'][]="Version";

$langliste['fr'][$id_page][]="Module";
$langliste['fr'][$id_page.'-popup'][]="Module";

$langliste['fr'][$id_page][]="Sous-module";
$langliste['fr'][$id_page.'-popup'][]="Sous-module";

$langliste['fr'][$id_page][]="Code";
$langliste['fr'][$id_page.'-popup'][]="Code";

$langliste['fr'][$id_page][]="Libellé";
$langliste['fr'][$id_page.'-popup'][]="Libellé";

$langliste['fr'][$id_page][]="Description";
$langliste['fr'][$id_page.'-popup'][]="Description";

$langliste['fr'][$id_page][]="Format";
$langliste['fr'][$id_page.'-popup'][]="Format";

$langliste['fr'][$id_page][]= "Data";
$langliste['fr'][$id_page.'-popup'][]="Obligation DATA";

$langliste['fr'][$id_page][]= "Taxa";
$langliste['fr'][$id_page.'-popup'][]="Obligation TAXA";

$langliste['fr'][$id_page][]= "Sdata";
$langliste['fr'][$id_page.'-popup'][]="Obligation SYNDATA";

$langliste['fr'][$id_page][]= "Staxa";
$langliste['fr'][$id_page.'-popup'][]="Obligation SYNTAXA";

$langliste['fr'][$id_page][]="Voca Ctrl";
$langliste['fr'][$id_page.'-popup'][]="Voca Ctrl";

$langliste['fr'][$id_page][]="Règle";
$langliste['fr'][$id_page.'-popup'][]="Règle Renseignement";

$langliste['fr'][$id_page][]="Evol.";
$langliste['fr'][$id_page.'-popup'][]="Exemple";

$langliste['fr'][$id_page][]="Exemple";
$langliste['fr'][$id_page.'-popup'][]="Exemple";


//------------------------------------------------------------------------------ FONCTIONS du module

?>
