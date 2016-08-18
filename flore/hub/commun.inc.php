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

$lang_select=$_COOKIE['lang_select'];

$onglet = ref_onglet($id_page);

$bouton1 = array (
		array ("id" => "import","titre"=>"Import de données","text" => "Dernier import : ","niveau" => 128,"cbn"=>true),
		array ("id" => "import_taxon","titre"=>"Import liste taxon","text" => "Dernier import : ","niveau" => 1,"cbn"=>true),
		array ("id" => "export","titre"=>"Export de données","text" => "Dernier export : ","niveau" => 1,"cbn"=>false),
		array ("id" => "bilan","titre"=>"Rafraichir le bilan","text" => "Dernier bilan :","niveau" => 1,"cbn"=>false)
		);
$bouton2 = array (
		array ("id" => "verif","titre"=>"Vérifier conformité","text" => "Dernière vérification : ","niveau" => 128,"cbn"=>true),
		array ("id" => "diff","titre"=>"Analyser  différences","text" => "Dernière analyse : ","niveau" => 128,"cbn"=>true),
		array ("id" => "push","titre"=>"Pousser les données","text" => "Dernier push : ","niveau" => 128,"cbn"=>true),
		array ("id" => "pull","titre"=>"Tirer les données","text" => "Dernier pull : ","niveau" => 128,"cbn"=>true),
		array ("id" => "publicate","titre"=>"Publier les données","text" => "Dernière publication : ","niveau" => 128,"cbn"=>true)
		);
$bouton3 = array (
		
		array ("id" => "clear","titre"=>"Vider -partie temp","text" => "Dernier nettoyage : ","niveau" => 128,"cbn"=>true),
		array ("id" => "del","titre"=>"Vider -partie propre","text" => "Dernier nettoyage : ","niveau" => 128,"cbn"=>true),
		array ("id" => "log","titre"=>"Vider les logs","text" => "Dernier nettoyage","niveau" => 128,"cbn"=>true)
		);

$bouton = array_merge($bouton1,$bouton2,$bouton3);
	
//------------------------------------------------------------------------------ Querys
$query_module = ""; /*Directement dans index.php*/

$query_liste[$id_page] = "
SELECT count(*) OVER() AS total_count,*
	FROM public.bilan 
	WHERE 1 = 1 ";
	
$query_liste["user"] = $query_liste["user"]."'".$id_page."' ";

$query_user = "
SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page.", utilisateur.ref_".$id_page."
FROM applications.utilisateur
WHERE utilisateur.niveau_".$id_page." <> 0";


$query_export = "
SELECT * 
	FROM hub.bilan
	WHERE 1 = 1	";

//------------------------------------------------------------------------------ VOCABULAIRE du module
$lang['fr'][$id_page]="Hub";

$lang['fr']['titre']="Hub";

$lang['fr']['groupe_1']="Actions";

$lang['fr']['groupe_2']="Bilan";

$lang['fr']['groupe_3']="Log";

foreach ($bouton as $val)
	$lang['fr'][$val["id"]]=$val["titre"];

//------------------------------------------------------------------------------ CHAMPS du module

foreach ($onglet["id"] as $key => $val)
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