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
$title = "Codex - LSI";
$ouinon_txt=array("Non","Oui");
$id_page="lsi";
$id_page_2 = "droit";
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


$query_liste = "
SELECT count(*) OVER() AS total_count,news.id,news.id_subject,title,abstract,string_agg(libelle_tag,' / ') as libelle_tag,link,link_2,date
FROM lsi.news 
LEFT JOIN lsi.coor_news_tag ON news.id=coor_news_tag.id
LEFT JOIN lsi.tag ON coor_news_tag.id_tag=tag.id_tag  
LEFT JOIN lsi.subject ON news.id_subject=subject.id_subject 
WHERE 1=1 ";

$group_by = "GROUP BY news.id,news.id_subject,title,abstract,link,link_2,date ";

$query_export =  "SELECT id,libelle_subjet,title,abstract,libelle_tag,link,date
				FROM lsi.news AS n 
				LEFT JOIN lsi.coor_news_tag nt ON n.id=nt.id
				LEFT JOIN lsi.tag t ON nt.id_tag=t.id_tag  
				LEFT JOIN lsi.subject s ON n.id_subject=s.id_subject";
				
$query_user = "
	SELECT count(*) OVER() AS total_count,utilisateur.id_user,utilisateur.prenom,utilisateur.nom,utilisateur.id_cbn,utilisateur.niveau_".$id_page."
	FROM applications.utilisateur
	WHERE utilisateur.niveau_".$id_page." <> 0";

//------------------------------------------------------------------------------ PATHS du module

//------------------------------------------------------------------------------ FONCTIONS du module

?>
