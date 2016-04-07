<?php
/*------------------------------------------------------------------
--------------------------------------------------------------------
 Application Codex		                               			  
 https://github.com/fedecbn/codex					   			  
--------------------------------------------------------------------
 Paramètres de la rubrique         
--------------------------------------------------------------------
--------------------------------------------------------------------*/
/*------------------------------------------------------------------------------ INITIALISATION*/ 
require_once ("../commun/commun.inc.php");
$id_page = $_SESSION['page'] = "fsd";
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ CONSTANTES du module

$name_page = "Format standard de données";	/*utilisé?*/
$title = $lang['fr']['titre_web']." - ".$id_page;
$titre = "Format Standard"; /*utilisé?*/

$onglet = array(
	"id" => array (
		"fsd",
		"meta",
		"data",
		"taxa",
		"droit"
		),
	"name" => array (
		"Dictionnaire de données",
		"META",
		"DATA",
		"TAXA",
		"Utilisateurs"
		),
	"sstitre" => array (
		"Liste des champs",
		"Format standard de données - META",
		"Format standard de données - DATA",
		"Format standard de données - TAXA",
		"Liste des droits"
		)
	);

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ QUERY du module
$query_champ = " SELECT * FROM referentiels.champ WHERE id_module = '$id_page'";

$query_liste["fsd"] = " SELECT count(*) OVER() AS total_count, ddd.* FROM fsd.ddd WHERE version = 3 AND (\"oData\" = 'Oui' OR \"oData\" = 'Oui si'  OR \"oTaxa\" = 'Oui' OR \"oTaxa\" = 'Oui si')";
$query_liste["meta"] = " SELECT count(*) OVER() AS total_count, formats.* FROM fsd.formats WHERE typ_jdd = 'meta'";
$query_liste["data"] = " SELECT count(*) OVER() AS total_count, formats.* FROM fsd.formats WHERE typ_jdd = 'data'";
$query_liste["taxa"] = " SELECT count(*) OVER() AS total_count, formats.* FROM fsd.formats WHERE typ_jdd = 'taxa'";
// $query_liste["droit"] = " SELECT count(*) OVER() AS total_count, formats.* FROM fsd.formats";
	
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
// $lang['fr']['fsd']="Dictionnaire de données";
// $lang['it']['fsd']="";

// $lang['fr']['data']="DATA";
// $lang['it']['data']="";

// $lang['fr']['liste_fsd']="Dictionnaire de données";
// $lang['it']['liste_fsd']="";

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
foreach ($onglet["id"] as $val)
	{
	$query = "SELECT nom_champ,description,description_longue FROM referentiels.champs WHERE rubrique_champ = '$val' AND pos IS NOT NULL ORDER BY pos";
	$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);

	While ($row = pg_fetch_row($result)) 
		{
		$langliste['fr'][$val][]= $row[1];
		$langliste['fr'][$val.'-popup'][]= $row[2];
		}
	}

//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 
?>
