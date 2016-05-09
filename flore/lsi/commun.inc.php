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
$ouinon_txt=array("Non","Oui");
$id_rub = "liste_rouge";

$niveau=$_SESSION['niveau'];
$table="news";
$aColumns = array('id','libelle_subject','title','abstract','libelle_tag','link','link_2','date');
$sIndexColumn = 'id';
$bool_txt=array(""=>"","f"=>"","t"=>"<b>Oui</b>");

$niveau=$_SESSION['niveau_lsi'];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];
$lang_select=$_COOKIE['lang_select'];

//------------------------------------------------------------------------------ QUERY du module
$query_liste = "
SELECT count(*) OVER() AS total_count,news.id,news.id_subject,title,abstract,string_agg(libelle_tag,' / ') as libelle_tag,link,link_2,date
FROM lsi.news 
LEFT JOIN lsi.coor_news_tag ON news.id=coor_news_tag.id
LEFT JOIN lsi.tag ON coor_news_tag.id_tag=tag.id_tag  
LEFT JOIN lsi.subject ON news.id_subject=subject.id_subject 
WHERE 1=1 ";

$group_by = "GROUP BY news.id,news.id_subject,title,abstract,link,link_2,date ";

$query_export =  "SELECT  n.id,libelle_subject,title,abstract,libelle_tag,link,date
				FROM lsi.news AS n 
				LEFT JOIN lsi.coor_news_tag nt ON n.id=nt.id
				LEFT JOIN lsi.tag t ON nt.id_tag=t.id_tag  
				LEFT JOIN lsi.subject s ON n.id_subject=s.id_subject";
$id_export = "n.id";
				
				
$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page.", utilisateur.ref_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";

//------------------------------------------------------------------------------ VOCABULAIRE du module
$lang['fr']['groupe_lsi_1']="Ajout de news";
$lang['it']['groupe_lsi_1']="";

$lang['fr']['lsi']="News";
$lang['it']['lsi']="";

$lang['fr']['liste_lsi']="Les news";
$lang['it']['liste_lsi']="";

$lang['fr']['add_lsi']="Ajouter une news";
$lang['it']['add_lsi']="";

$lang['fr']['edit_lsi']="Modifier une news";
$lang['it']['edit_lsi']="";

$lang['fr']['voir_lsi']="Consulter une news";
$lang['it']['voir_lsi']="";


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
