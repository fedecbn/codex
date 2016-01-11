<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "lr";
$id_page_2 = "droit";
$name_page = "Liste rouge";
$titre = "Liste rouge";
$id_rub = "lr";
$rub[$id_rub] = 'true';
$title = $lang['fr']['titre_web']." - ".$id_page;


$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ QUERY du module
$query_module = "
	SELECT t.*,c.*,e.*, f.indi_cal  
	FROM lr.taxons AS t 
	LEFT JOIN lr.chorologie AS c ON c.uid=t.uid 
	LEFT JOIN lr.evaluation AS e ON e.uid=t.uid
	LEFT JOIN catnat.statut_nat AS f ON f.uid = t.uid
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_rub = TRUE AND t.uid=";

	// CASE taxons.endemisme WHEN true THEN 'oui' WHEN false THEN 'non' ELSE '' END as endemisme,
$query_liste = "
	SELECT count(*) OVER() AS total_count,
	taxons.uid,taxons.famille,taxons.cd_ref,taxons.nom_sci,taxons.id_rang,taxons.id_indi,
	taxons.endemisme,
	chorologie.aoo4,chorologie.aoo_precis,chorologie.id_aoo,chorologie.nbloc_precis,chorologie.id_nbloc,chorologie.nbm5_post1990_est,chorologie.nbm5_post1990,chorologie.nbm5_post2000,chorologie.nbm5_total,chorologie.nbcommune,
	evaluation.etape,evaluation.cat_a,evaluation.just_a,evaluation.cat_b,evaluation.just_b,evaluation.cat_c,evaluation.just_c,evaluation.cat_d,evaluation.just_d,evaluation.menace,evaluation.cat_fin,evaluation.just_fin,evaluation.cat_euro , evaluation.cat_synt_reg,evaluation.nb_reg_presence,evaluation.nb_reg_evalue,evaluation.notes,
	evaluation.avancement
	FROM lr.taxons
	LEFT JOIN lr.chorologie ON chorologie.uid=taxons.uid 
	LEFT JOIN lr.evaluation ON evaluation.uid=taxons.uid  
	LEFT JOIN referentiels.indigenat ON indigenat.id_indi = taxons.id_indi
	JOIN refnat.taxons a ON a.uid = taxons.uid 
	WHERE a.$id_rub = TRUE ";

$query_export = "
SELECT *
	FROM lr.taxons AS t  
	LEFT JOIN lr.chorologie AS c ON c.uid=t.uid 
	LEFT JOIN lr.evaluation AS e ON e.uid=t.uid
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_rub = TRUE;
	";
$export_id = "t.uid";

$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page.", utilisateur.ref_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";

$query_discussion = "
	SELECT prenom||' '||nom||' ('||cd_cbn||') le '||to_char(datetime, 'dd/MM/YYYY')||' à '||to_char(datetime, 'HH24')||'h'||to_char(datetime, 'MI'), commentaire_eval 
	FROM lr.discussion a JOIN referentiels.cbn z ON a.id_cbn = z.id_cbn 
	WHERE uid = ";

$rang= array(''=>'','ES'=>'ES','SSES'=>'SSES','VAR'=>'VAR','SVAR'=>'SVAR','FO'=>'FO','SSFO'=>'SSFO','CAR'=>'CAR');
$tables = array ('taxons','chorologie','evaluation');

//------------------------------------------------------------------------------ VOCABULAIRE du module
$lang['fr'][$id_page]="Liste rouge";
$lang['it'][$id_page]="";

$lang['fr']['titre_lr']="Liste rouge";
$lang['it']['titre_lr']="";

$lang['fr']['groupe_lr_1']="Taxonomie";
$lang['it']['groupe_lr_1']="";

$lang['fr']['groupe_lr_2']="Distribution";
$lang['it']['groupe_lr_2']="";

$lang['fr']['groupe_lr_3']="Population";
$lang['it']['groupe_lr_3']="";

$lang['fr']['groupe_lr_4']="Evaluation";
$lang['it']['groupe_lr_4']="";

$lang['fr']['groupe_lr_5']="Commentaires";
$lang['it']['groupe_lr_5']="";

//------------------------------------------------------------------------------ CHAMPS du module
$langliste['fr'][$id_page][]="Etape";
$langliste['fr'][$id_page.'-popup'][]="Étapes de l'évaluation";

$langliste['fr'][$id_page][]="Famille";
$langliste['fr'][$id_page.'-popup'][]="";

$langliste['fr'][$id_page][]="CD_REF";
$langliste['fr'][$id_page.'-popup'][]="Code du taxon de référence";

$langliste['fr'][$id_page][]="Nom scien";
$langliste['fr'][$id_page.'-popup'][]="Nom scientifique du taxon";

$langliste['fr'][$id_page][]="Rang";
$langliste['fr'][$id_page.'-popup'][]="Rang taxonomique du taxon";

$langliste['fr'][$id_page][]="Indig.";
$langliste['fr'][$id_page.'-popup'][]="Statut d'indigénat du taxon en métropole";

$langliste['fr'][$id_page][]="Endém";
$langliste['fr'][$id_page.'-popup'][]="Endémisme du taxon en métropole";

$langliste['fr'][$id_page][]="AOO";
$langliste['fr'][$id_page.'-popup'][]="Zone d'occupation estimée après 1990_2x2";

$langliste['fr'][$id_page][]="AOO<br>tot";
$langliste['fr'][$id_page.'-popup'][]="Zone d'occupation ajustée après 1990 pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes";

$langliste['fr'][$id_page][]="Nb loc.";
$langliste['fr'][$id_page.'-popup'][]="Nb de localités >= 1990";

$langliste['fr'][$id_page][]="Nb mailles<br> >1990";
$langliste['fr'][$id_page.'-popup'][]="Nombre de mailles 5km²>=1990 ajustée pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes";

$langliste['fr'][$id_page][]="Cat<br>A";
$langliste['fr'][$id_page.'-popup'][]="Catégorie la plus élevée selon le critère A";

$langliste['fr'][$id_page][]="Cat<br>B2";
$langliste['fr'][$id_page.'-popup'][]="Catégorie la plus élévee selon le critère B2";

$langliste['fr'][$id_page][]="Cat<br>C";
$langliste['fr'][$id_page.'-popup'][]="Catégorie la plus élévee selon le critère C";

$langliste['fr'][$id_page][]="Cat<br>D";
$langliste['fr'][$id_page.'-popup'][]="Catégorie la plus élévee selon le critère D";

$langliste['fr'][$id_page][]="Cat<br>Fin";
$langliste['fr'][$id_page.'-popup'][]="Catégorie proposée pour la Liste rouge nationale après ajustement";

$langliste['fr'][$id_page][]="Crit<br>Fin";
$langliste['fr'][$id_page.'-popup'][]="Critère(s) proposé(s) pour la Liste rouge nationale";

$langliste['fr'][$id_page][]="Cat<br>EU";
$langliste['fr'][$id_page.'-popup'][]="Catégorie UICN à l'échelle de l'Europe géographique";

$langliste['fr'][$id_page][]="Cat<br>Synthèse region";
$langliste['fr'][$id_page.'-popup'][]="Synthèse des Catégories UICN issue des évaluations régionales";

$langliste['fr'][$id_page][]="Nb region<br>eval";
$langliste['fr'][$id_page.'-popup'][]="Nombre de régions ayant une évaluation régionale pour ce taxon";

$langliste['fr'][$id_page][]="Note Explic";
$langliste['fr'][$id_page.'-popup'][]="Notes explicative l'évaluation";

$langliste['fr'][$id_page][]="Avancement";
$langliste['fr'][$id_page.'-popup'][]="";




//------------------------------------------------------------------------------ FONCTIONS du module

?>
