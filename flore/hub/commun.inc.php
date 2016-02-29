<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
require_once ("../commun/commun.inc.php");

//------------------------------------------------------------------------------ CONSTANTES du module
$id_page = $_SESSION['page'] = "hub";
$id_page_2 = "droit";
$name_page = "Hub - interface de gestion des données du réseau";
$title = "Hub";

$niveau=$_SESSION['niveau_'.$id_page];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];

$lang_select=$_COOKIE['lang_select'];

$onglet = array(
	"id" => array ("hub","droit"),
	"name" => array ("Etat du hub","Utilisateurs"),
	"sstitre" => array ("Liste des CBN","Liste des droits")
	);

$bouton1 = array (
		array ("id" => "import","titre"=>"Importer des données","text" => "Dernier import : ","niveau" => 128,"cbn"=>true),
		array ("id" => "import_taxon","titre"=>"Importer des taxon","text" => "Dernier import : ","niveau" => 64,"cbn"=>true),
		array ("id" => "export","titre"=>"Exporter des données","text" => "Dernier export : ","niveau" => 1,"cbn"=>false),
		array ("id" => "bilan","titre"=>"Rafraichir le bilan","text" => "Dernier bilan :","niveau" => 1,"cbn"=>false)
		);
$bouton2 = array (
		array ("id" => "verif","titre"=>"Vérifier la conformité","text" => "Dernière vérification : ","niveau" => 128,"cbn"=>true),
		array ("id" => "diff","titre"=>"Analyser  différences","text" => "Dernière analyse : ","niveau" => 128,"cbn"=>true),
		array ("id" => "push","titre"=>"Pousser les données","text" => "Dernier push : ","niveau" => 128,"cbn"=>true),
		array ("id" => "pull","titre"=>"Tirer les données","text" => "Dernier pull : ","niveau" => 128,"cbn"=>true)
		);
$bouton3 = array (
		
		array ("id" => "clear","titre"=>"Vider -partie temp","text" => "Dernier nettoyage : ","niveau" => 128,"cbn"=>true),
		array ("id" => "del","titre"=>"Vider -partie propre","text" => "Dernier nettoyage : ","niveau" => 128,"cbn"=>true),
		array ("id" => "log","titre"=>"Vider les logs","text" => "Dernier nettoyage","niveau" => 128,"cbn"=>false)
		);

$bouton = array_merge($bouton1,$bouton2,$bouton3);
	
//------------------------------------------------------------------------------ Querys
$query_module = ""; /*Directement dans index.php*/

$query_liste["hub"] = "
SELECT count(*) OVER() AS total_count,*
	FROM public.bilan 
	WHERE 1 = 1 ";

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

?>