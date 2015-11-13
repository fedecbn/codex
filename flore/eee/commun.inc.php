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
$id_page = $_SESSION['page'] = "eee";
$id_page_2 = "droit";
$title = $lang['fr']['titre_web']." - ".$id_page;
$titre = "Listes Espèces Exotique Envahissantes";



$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ QUERY du module
$query_module = "
	SELECT * FROM eee.taxons t
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_page = TRUE AND t.uid=";

	
$query_liste = "
	SELECT total_count, taxons.cd_ref, taxons.nom_sci, taxons.lib_rang, presence, invav, liste_eval, carac_emerg, carac_avere, lavergne, ind_a, ind_b, ind_c, ind_tot, gbif_url, eval_tot,eval_expert,round(100*fiab_tot)||'%' as fiab_tot, taxons.uid FROM
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
// $langliste['fr']['eee'][]="Etape";
// $langliste['fr']['eee-popup'][]="Étapes de l'évaluation";

$langliste['fr']['eee'][]="CD_REF";
$langliste['fr']['eee-popup'][]="Code du taxon de référence";

$langliste['fr']['eee'][]="Nom scientifique ";
$langliste['fr']['eee-popup'][]="Nom scientifique du taxon";

$langliste['fr']['eee'][]="Rang";
$langliste['fr']['eee-popup'][]="Rang taxonomique du taxon";

// $langliste['fr']['eee'][]="Nom vern";
// $langliste['fr']['eee-popup'][]="Nom vernaculare du taxon";

$langliste['fr']['eee'][]="Presence FR";
$langliste['fr']['eee-popup'][]="Présence du taxon en métropole";

$langliste['fr']['eee'][]="EEE FR";
$langliste['fr']['eee-popup'][]="Mention EEE avérée";

$langliste['fr']['eee'][]="Lavergne FR";
$langliste['fr']['eee-popup'][]="Echelle de Lavegne";

$langliste['fr']['eee'][]="Risque d'introduction";
$langliste['fr']['eee-popup'][]="Risques d’introduction et d’installation (Biogéographie)";

$langliste['fr']['eee'][]="Risque de propagation";
$langliste['fr']['eee-popup'][]="Risques de propagation (Naturalisation et dynamisme)";

$langliste['fr']['eee'][]="Risque d'impact";
$langliste['fr']['eee-popup'][]="Risques d’impact (comportement ailleurs et habitats colonisés)";

$langliste['fr']['eee'][]="Score Weber";
$langliste['fr']['eee-popup'][]="Score de Weber";

$langliste['fr']['eee'][]="Evaluation Weber";
$langliste['fr']['eee-popup'][]="Risque global";

$langliste['fr']['eee'][]="Fiabilité Weber";
$langliste['fr']['eee-popup'][]="Fiabilité globale";

$langliste['fr']['eee'][]="Liste Pcp/annexe";
$langliste['fr']['eee-popup'][]="Appartenance à une liste";

$langliste['fr']['eee'][]="Carac. emergent";
$langliste['fr']['eee-popup'][]="Caractère émergent";

$langliste['fr']['eee'][]="Carac. avéré";
$langliste['fr']['eee-popup'][]="Caractère avéré";

$langliste['fr']['eee'][]="Evaluation experte";
$langliste['fr']['eee-popup'][]="Evaluation experte";

$langliste['fr']['eee'][]="Carte GBIF";
$langliste['fr']['eee-popup'][]="Carte GBIF – distribution modélisée";

// $langliste['fr']['eee'][]="uid";
// $langliste['fr']['eee-popup'][]="identifiant unique";


//------------------------------------------------------------------------------ FONCTIONS du module

?>
