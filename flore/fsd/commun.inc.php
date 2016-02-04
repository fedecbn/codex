<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "fsd";
$name_page = "Format standard de données";
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

$query_liste = " SELECT count(*) OVER() AS total_count, ddd.* FROM fsd.ddd WHERE VERSION = 3 ";
	
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

$lang['fr']['commentaire']="Liste des champs";
$lang['it']['commentaire']="";

//------------------------------------------------------------------------------ CHAMPS du module

/*récupération des champs*/
$query = "SELECT nom_champ,description,description_longue FROM referentiels.champs WHERE rubrique_champ = '$id_page' AND pos IS NOT NULL ORDER BY pos";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

While ($row = pg_fetch_row($result)) 
	{
	$langliste['fr'][$id_page][]= $row[1];
	$langliste['fr'][$id_page.'-popup'][]= $row[2];
	}


//------------------------------------------------------------------------------ FONCTIONS du module

?>
