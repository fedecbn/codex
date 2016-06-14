<?php
//------------------------------------------------------------------------------//
//   commun.inc.php                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//------------------------------------------------------------------------------//
                                                      
//------------------------------------------------------------------------------ CONFIG du module
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

$query_module = "
SELECT t.* 
	FROM syntaxa.st_syntaxon t 
	WHERE t.\"codeEnregistrementSyntax\"=";

$query_module_biblio = "
SELECT t.* 
	FROM syntaxa.st_biblio t 
	WHERE t.\"codeEnregistrement\"=";	
	
$query_module_correspondance_pvf1 = "
SELECT t.*
	FROM syntaxa.st_correspondance_pvf t
	WHERE t.\"versionReferentiel\"='v1' and t.\"codeEnregistrementSyntaxon\"=";	
	
$query_module_correspondance_pvf2 = "
SELECT t.*
	FROM syntaxa.st_correspondance_pvf t
	WHERE t.\"versionReferentiel\"='v2' and t.\"codeEnregistrementSyntaxon\"=";	
	
$query_module_correspondance_hic = "
SELECT t.\"codeHIC\", ref.\"libHIC\",t.\"typeEnregistrement\"
	FROM syntaxa.st_correspondance_hic t
	inner join 
	(select * from  syntaxa.st_ref_hic) ref
	on t.\"codeHIC\"=ref.\"codeHIC\" 
	WHERE t.\"codeEnregistrement\"=";	
	
	
$query_module_correspondance_eunis = "
SELECT t.\"codeEUNIS\", ref.\"libEUNIS\",t.\"typeEnregistrement\"
	FROM syntaxa.st_correspondance_eunis t
	inner join 
	(select * from  syntaxa.st_ref_eunis) ref
	on t.\"codeEUNIS\"=ref.\"codeEUNIS\" 
	WHERE t.\"codeEnregistrement\"=";	
	
$query_module_chorologie = "
SELECT ch.\"idTerritoire\", li.\"libelle_territoire\" FROM syntaxa.st_chorologie ch
inner join 
(select * from  syntaxa.liste_geo) li
on ch.\"idTerritoire\"=li.\"id_territoire\" 
WHERE \"codeEnregistrement\" = ";
	
$query_module_etage_vegetation = "
SELECT t.\"codeEtageVeg\", li.\"libEtageVeg\" 
FROM syntaxa.st_etage_veg t
inner join 
(select * from  syntaxa.st_ref_etage_veg) li
on t.\"codeEtageVeg\"=li.\"codeEtageVeg\" 
WHERE t.\"codeEnregistrement\"=";	

$query_module_etage_bioclim = "
SELECT t.\"codeEtageBioclim\", li.\"libEtageBioclim\" 
FROM syntaxa.st_etage_bioclim t
inner join 
(select * from  syntaxa.st_ref_etage_bioclim) li
on t.\"codeEtageBioclim\"=li.\"codeEtageBioclim\" 
WHERE t.\"codeEnregistrement\"=";	

$query_module_biblio = "
SELECT t.\"codePublication\", t.\"libPublication\",t.\"urlPublication\"
FROM syntaxa.st_biblio t
WHERE t.\"codeEnregistrement\"=";	


//requete qui va chercher les commentaires sur les champs dans les tables système de postgresql (la description)
$query_description=
"SELECT  CASE WHEN col_description(oid, ordinal_position) is null THEN '' ELSE col_description(oid, ordinal_position) END as description
		FROM 	(SELECT columns.table_name AS table_name, columns.column_name AS nom_colonne,columns.ordinal_position FROM information_schema.columns
					ORDER BY columns.ordinal_position
				) sub
		
		JOIN (SELECT c.relname AS table_name, n.nspname, c.oid
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  ORDER BY c.relname) as mtd_liste_table USING(table_name)
  where oid in (SELECT c.oid FROM pg_class c LEFT JOIN pg_namespace n ON n.oid = c.relnamespace LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
WHERE c.relkind = ANY(CASE WHEN n.nspname = 'dgi' OR n.nspname = 'public' THEN array['r'] ELSE array['r','v'] END) AND c.relname NOT LIKE 'geometry%'
AND c.relname NOT LIKE 'temp_%' AND c.relname <> 'views' AND n.nspname IN ('syntaxa') )
and sub.table_name not in ('fsd_syntaxa','st_serie_petitegeoserie')
and sub.nom_colonne=";
//"SELECT champs.description FROM referentiels.champs WHERE rubrique_champ = 'syntaxa' and table_champ <>'st_serie_petitegeoserie' and table_champ not like 'st_ref%' and champs.nom_champ=";

$query_liste_statuts_cbn=
"SELECT li.\"libelle_territoire\", ch.\"statutChorologie\"  FROM syntaxa.st_chorologie ch
inner join 
(select \"id_territoire\", \"libelle_territoire\", \"code_type_territoire\" from  syntaxa.liste_geo order by \"code_type_territoire\"='CBN' asc ) as li 
on ch.\"idTerritoire\"=li.\"id_territoire\" 
WHERE \"codeEnregistrement\" = ";


$query_liste = "
SELECT count(*) OVER() AS total_count,*
	FROM syntaxa.st_syntaxon
	";
	
$query_export = "
SELECT t.* 
	FROM defaut.uid t 
	JOIN applications.taxons a ON a.uid = t.uid 
	WHERE a.defaut = TRUE ";

//$tables = array ('st_syntaxon','st_etage_bioclim','st_etage_veg','st_chorologie','st_correspondance_eunis','st_correspondance_hic','st_correspondance_pvf');

if (!isset($_POST["etape"])) {$etape = 1;}
else {$etape = $_POST["etape"];}

	
// ------------------------------------------------------------------------------ Vocabulaire du module
$lang['fr']['syntaxa']="Liste des syntaxons";



$lang['fr']['titre']="Codex - Rubrique Catalogue des végétations";

$lang['fr']['liste_taxons']="Liste des syntaxons";

 $langliste['fr']['syntaxa'][]="Code enregistrement";
 $langliste['fr']['syntaxa-popup'][]="Identifiant unique du Syntaxon dans le catalogue partagé ";

 $langliste['fr']['syntaxa'][]="Identifiant syntaxon";
 $langliste['fr']['syntaxa-popup'][]="Identifiant du syntaxon dans le catalogue d'origine";

 $langliste['fr']['syntaxa'][]="Nom scientifique syntaxon";
 $langliste['fr']['syntaxa-popup'][]="Nom complet du syntaxon";

 $langliste['fr']['syntaxa'][]="Rang syntaxon retenu";
 $langliste['fr']['syntaxa-popup'][]="Rang du syntaxon";

 $langliste['fr']['syntaxa'][]="Identifiant syntaxon retenu";
 $langliste['fr']['syntaxa-popup'][]="Identifiant du syntaxon retenu dans le catalogue d'origine";

 $langliste['fr']['syntaxa'][]="Nom scientifique syntaxon retenu";
 $langliste['fr']['syntaxa-popup'][]="Nom complet du syntaxon retenu";

 $langliste['fr']['syntaxa'][]="Identifiant syntaxon supérieur";
 $langliste['fr']['syntaxa-popup'][]="Identifiant du syntaxon supérieur dans le catalogue d'origine";



/*foreach ($onglet["id"] as $val)
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
	*/

	

//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 


?>