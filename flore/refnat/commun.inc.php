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
require_once ("desc.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ CONSTANTES du module
$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];
$title = $lang['fr']['titre_web']." - ".$id_page;

$lang_select=$_COOKIE['lang_select'];

$onglet = ref_onglet($id_page);

//------------------------------------------------------------------------------ QUERY du module
$query_module = "
SELECT t.* 
	FROM refnat.taxons t 
	WHERE t.uid=";

$query_liste = "
SELECT count(*) OVER() AS total_count,*
	FROM refnat.taxons
	WHERE 1=1 ";
	
$query_export = "
SELECT t.* 
	FROM refnat.taxons t 
	WHERE 1=1 ";
$export_id = "t.uid";

$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page.", utilisateur.ref_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";
	
$query_discussion = "
	SELECT prenom||' '||nom||' ('||cd_cbn||') le '||to_char(datetime, 'dd/MM/YYYY')||' à '||to_char(datetime, 'HH24')||'h'||to_char(datetime, 'MI'), commentaire_eval 
	FROM refnat.discussion a JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn 
	WHERE uid = ";

//------------------------------------------------------------------------------ VOCABULAIRE du module
$lang['fr']['refnat_1']="Ajouter";
$lang['it']['refnat_1']="";

$lang['fr']['refnat']="Evolution TAXREF";
$lang['it']['refnat']="";

$lang['fr']['refnat_2']="Rechercher";
$lang['it']['refnat_2']="";

$lang['fr']['add_refnat']="Ajouter un taxon";
$lang['it']['add_refnat']="";

$lang['fr']['edit_refnat']="Modifier un taxon";
$lang['it']['edit_refnat']="";

$lang['fr']['voir_refnat']="Consulter une fiche taxon";
$lang['it']['voir_refnat']="";


//------------------------------------------------------------------------------ CHAMPS du module

foreach ($onglet["id"] as $val)
	{
	$query = "SELECT nom_champ,description,description_longue FROM referentiels.champs 
	WHERE rubrique_champ = '$val' AND pos IS NOT NULL 
	ORDER BY pos";
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