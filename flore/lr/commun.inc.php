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
$id_rub = "lr";
$rub[$id_rub] = 'true';
$title = $lang['fr']['titre_web']." - ".$id_page;

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

$onglet = ref_onglet($id_rub);

//------------------------------------------------------------------------------ QUERY du module
$query_module = "
	SELECT t.*,c.*,e.*, f.indi_cal  
	FROM lr.taxons AS t 
	LEFT JOIN lr.chorologie AS c ON c.uid=t.uid 
	LEFT JOIN lr.evaluation AS e ON e.uid=t.uid
	LEFT JOIN catnat.statut_nat AS f ON f.uid = t.uid
	JOIN refnat.taxons a ON a.uid = t.uid 
	WHERE a.$id_rub = TRUE AND t.uid=";

$query_liste = "
	SELECT count(*) OVER() AS total_count,
	chorologie.*,evaluation.*, validation.*,taxons.*
	FROM lr.taxons
	LEFT JOIN lr.chorologie ON chorologie.uid=taxons.uid 
	LEFT JOIN lr.evaluation ON evaluation.uid=taxons.uid  
	LEFT JOIN lr.validation ON validation.uid=taxons.uid  AND evaluation.etape = validation.etape AND evaluation.version = validation.version
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
