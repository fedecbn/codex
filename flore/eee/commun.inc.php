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
$title = $lang['fr']['titre_web']." - ".$id_page;

$onglet = array(
	"id" => array (
		"eee",
		"eee_reg",
		"droit"
		),
	"name" => array (
		"Eval Nationale",
		"Eval Régionales",
		"Utilisateurs"
		),
	"sstitre" => array (
		"Liste des taxons",
		"Liste des taxons",
		"Liste des droits"
		)
	);

$query_liste["eee"] = "	SELECT total_count, taxons.cd_ref, taxons.nom_sci, taxons.lib_rang, presence, invav, liste_eval, carac_emerg, carac_avere, lavergne, ind_a, ind_b, ind_c, ind_tot, gbif_url, eval_tot,eval_expert,round(100*fiab_tot)||'%' as fiab_tot, taxons.uid FROM
	(SELECT count(*) OVER() AS total_count,taxons.cd_ref,taxons.nom_sci,taxons.lib_rang,taxons.nom_verna,gbif_url,taxons.uid
	FROM eee.taxons) as taxons
	LEFT OUTER JOIN 
	(SELECT uid,liste_eval, carac_emerg, carac_avere,ind_A,ind_B,ind_C,ind_tot,eval_tot,eval_expert,fiab_tot
	FROM eee.evaluation) as evaluation
	ON evaluation.uid=taxons.uid
	LEFT OUTER JOIN
	(SELECT DISTINCT uid, 'oui' as presence
	FROM eee.statut_natio WHERE statut = 'pres') as two
	ON taxons.uid = two.uid
	LEFT OUTER JOIN 
	(SELECT DISTINCT uid, 'oui' as invav
	FROM eee.statut_natio WHERE statut = 'invav') as three
	ON taxons.uid = three.uid
	LEFT OUTER JOIN 
	(SELECT DISTINCT uid, 'oui' as lavergne
	FROM eee.statut_natio WHERE statut = 'lavergne') as four
	ON taxons.uid = four.uid
	LEFT OUTER JOIN 
	(SELECT DISTINCT uid, 'oui' as indigene_eu
	FROM eee.statut_inter si JOIN eee.pays p ON si.idp = p.idp WHERE statut = 'indig' AND continent = 'Europe') as five
	ON taxons.uid = five.uid 
	JOIN refnat.taxons a ON a.uid = taxons.uid 
	WHERE a.$id_page = TRUE ";
$query_liste["eee_reg"] = " SELECT count(*) OVER() AS total_count, taxons.nom_complet, evaluation_regional.* FROM eee.evaluation_regional JOIN refnat.taxons ON evaluation_regional.uid = taxons.uid  WHERE 1 = 1";


$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ QUERY du module
$query_module = "
	SELECT * FROM eee.taxons t
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_page = TRUE AND t.uid=";

	
// $query_liste = "
	// SELECT total_count, taxons.cd_ref, taxons.nom_sci, taxons.lib_rang, presence, invav, liste_eval, carac_emerg, carac_avere, lavergne, ind_a, ind_b, ind_c, ind_tot, gbif_url, eval_tot,eval_expert,round(100*fiab_tot)||'%' as fiab_tot, taxons.uid FROM
	// (SELECT count(*) OVER() AS total_count,taxons.cd_ref,taxons.nom_sci,taxons.lib_rang,taxons.nom_verna,gbif_url,taxons.uid
	// FROM eee.taxons) as taxons
	// LEFT OUTER JOIN 
	// (SELECT uid,liste_eval, carac_emerg, carac_avere,ind_A,ind_B,ind_C,ind_tot,eval_tot,eval_expert,fiab_tot
	// FROM eee.evaluation) as evaluation
	// ON evaluation.uid=taxons.uid
	// LEFT OUTER JOIN
	// (SELECT DISTINCT uid, 'oui' as presence
	// FROM eee.statut_natio WHERE statut = 'pres') as two
	// ON taxons.uid = two.uid
	// LEFT OUTER JOIN 
	// (SELECT DISTINCT uid, 'oui' as invav
	// FROM eee.statut_natio WHERE statut = 'invav') as three
	// ON taxons.uid = three.uid
	// LEFT OUTER JOIN 
	// (SELECT DISTINCT uid, 'oui' as lavergne
	// FROM eee.statut_natio WHERE statut = 'lavergne') as four
	// ON taxons.uid = four.uid
	// LEFT OUTER JOIN 
	// (SELECT DISTINCT uid, 'oui' as indigene_eu
	// FROM eee.statut_inter si JOIN eee.pays p ON si.idp = p.idp WHERE statut = 'indig' AND continent = 'Europe') as five
	// ON taxons.uid = five.uid 
	// JOIN refnat.taxons a ON a.uid = taxons.uid 
	// WHERE a.$id_page = TRUE ";

$query_export = "
	SELECT *
	FROM eee.taxons AS t  
	LEFT JOIN eee.evaluation AS e ON e.uid=t.uid 
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_page = TRUE
	";
$export_id = "t.uid";

$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page.",utilisateur.ref_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";

$query_discussion = "
	SELECT prenom||' '||nom||' ('||cd_cbn||') le '||to_char(datetime, 'dd/MM/YYYY')||' à '||to_char(datetime, 'HH24')||'h'||to_char(datetime, 'MI'), commentaire_eval 
	FROM eee.discussion a JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn 
	WHERE uid = ";

//------------------------------------------------------------------------------ CHAMPS du module
$rang= array(''=>'','ES'=>'ES','SSES'=>'SSES','VAR'=>'VAR','SVAR'=>'SVAR','FO'=>'FO','SSFO'=>'SSFO','CAR'=>'CAR');
$fiab = array (1=> "fiab1",2=> "fiab2",3=> "fiab3",4=> "fiab4",5=> "fiab5",6=> "fiab6",7=> "fiab7",8=> "fiab8",9=> "fiab9",10=> "fiab10",11=> "fiab11",12=> "fiab12",13=> "fiab13");
$liste_eval= array(''=>'','pcpl'=>'liste principale','annexe'=>'liste annexe');
$carac_emerg= array(''=>'','emerg'=>'emmergent','non_emerg'=>'non emmergent');
$carac_avere= array(''=>'','avere_local'=>'avérée localement','avere_ailleurs'=>'avérée ailleurs','non_avere'=>'non avérée');
$region_biogeo= array('gl','za','zc','zm');
$statut= array('pres','indig','invav','lavergne');

//------------------------------------------------------------------------------ VOCABUALIRE du module
$lang['fr']['eee']="Liste EEE";
$lang['it']['eee']="";

$lang['fr']['eee_reg']="Listes EEE régionales";
$lang['it']['eee_reg']="";

$lang['fr']['groupe_eee_1']="Identification";
$lang['it']['groupe_eee_1']="";

$lang['fr']['groupe_eee_2']="A. Risques d'introduction et d'installation (Biogéographie)";
$lang['it']['groupe_eee_2']="";

$lang['fr']['groupe_eee_3']="B. Risques de propagation (Naturalisaion et dynamisme)";
$lang['it']['groupe_eee_3']="";

$lang['fr']['groupe_eee_4']="C. Risques d'impact (comportement ailleurs et habitats colonisés)";
$lang['it']['groupe_eee_4']="";

$lang['fr']['groupe_eee_5']="D. Evaluation nationale";
$lang['it']['groupe_eee_5']="";

$lang['fr']['groupe_eee_6']="E. Evaluation par région biogéographique";
$lang['it']['groupe_eee_6']="";


//------------------------------------------------------------------------------ CHAMPS du module
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

//------------------------------------------------------------------------------ FONCTIONS du module
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 
?>
