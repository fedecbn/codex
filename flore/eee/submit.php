<?php
/*------------------------------------------------------------------
--------------------------------------------------------------------
 Application Codex		                               			  
 https://github.com/fedecbn/codex					   			  
--------------------------------------------------------------------
 Interface avec la base de données (modification et ajout)         
--------------------------------------------------------------------
--------------------------------------------------------------------*/
/*------------------------------------------------------------------------------ INITIALISATION*/ session_start();
include ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

define ("DEBUG",FALSE);

//------------------------------------------------------------------------------ PARMS.
$id = isset($_POST['id']) ? $_POST['id'] : "";

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

/*référentiel sources et argumentation*/
$query="SELECT ids FROM eee.liste_source ORDER BY ids;";
if (DEBUG) echo "<br>$query";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);unset($query);
while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
	$ids[$row['ids']] = "ids".$row['ids'];
pg_free_result ($result);unset($query);

$query="SELECT ida FROM eee.liste_argument ORDER BY ida;";
if (DEBUG) echo "<br>$query";
$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);unset($query);
while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
	$ida[$row['ida']] = "ida".$row['ida'];
pg_free_result ($result);unset($query);

global $aColumns, $ref, $champ_ref ;
ref_colonne_et_valeur ('eee');

if (!empty ($id))  {                                                            // EDIT
	if ($niveau >= 128)	/*Seulement les évaluateurs et au dessus*/
		{	
		// /*Statuts internationaux*/
		// $statut = array('pres'=>$_POST['pays_pres_select'],'indig'=>$_POST['pays_indi_select'],'invav'=>$_POST['st_nvav_inter_select']);
		// foreach ($statut as $stt => $val_2)	{
			// $query = "SELECT t.uid, st.idp,st.statut, p.pays, p.region_biogeo FROM eee.taxons AS t JOIN eee.statut_inter st ON t.uid = st.uid JOIN eee.pays p ON st.idp = p.idp WHERE t.uid=$id AND st.statut = '".$stt."';";
			// $ligne = sql_assoc ($query,true);
			// $modif = check_modif($ligne['idp'],$val_2,"idp_".$stt);
			// if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($_POST["etape"],$id_user,$id,"statut_inter_".$stt,"idp_".$stt,$ligne['idp'],$val_2,'eee','manuel',$modif);
			// update_multi($query,$stt,"idp",$val_2,"eee.statut_inter",$id);
			// unset($ligne);
			// }
		// unset($val_2);

		// /*Statuts nationaux*/
		// $statut_natio = array ("pres"=>$_POST["reg_pres_select"], "indig"=>$_POST["reg_indi_select"], "invav"=>$_POST["st_nvav_fr_select"]);
		// foreach ($statut_natio as $stt => $val_2)	{
			// $query="SELECT t.uid, sn.idr,sn.statut, r.region, r.region_biogeo FROM eee.taxons AS t JOIN eee.statut_natio sn ON t.uid = sn.uid JOIN eee.region r ON sn.idr = r.idr WHERE t.uid=".$id." AND sn.statut = '".$stt."';";
			// $ligne = sql_assoc ($query,true);
			// $modif = check_modif($ligne['idr'],$val_2,"idr_".$stt);
			// if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($_POST["etape"],$id_user,$id,"statut_natio_".$stt,"idr_".$stt,$ligne['idr'],$val_2,'eee','manuel',$modif);
			// update_multi($query,$stt,"idr",$val_2,"eee.statut_natio",$id);
			// unset($ligne);
			// }
			// unset($val_2);
		
		/*Sources et fiabilité*/	
		$query="SELECT t.uid, s.ids,s.contenu, s.fiabilite
		FROM eee.taxons AS t JOIN eee.source s ON t.uid = s.uid
		WHERE t.uid=".$id.";";
		if (DEBUG) echo "<br> requete  ".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))	{
			$val_1[$row['ids']] = sql_format_quote($row['contenu'],'do');
			$fiab_1[$row['ids']] = $row['fiabilite'];
			}
		foreach ($ref['liste_source'] as $key => $i)	{
			if ($_POST['ids'.$key] != null) $val_2[$key] = $_POST['ids'.$key];
			if ($_POST['fiab'.$key] != null) $fiab_2[$key] = $_POST['fiab'.$key];
			}

		foreach ($ref['liste_source'] as $key => $i)	{
			$modif = check_modif($val_1[$key],$val_2[$key],"ids".$key);
			if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($_POST["etape"],$id_user,$id,"liste_source_".$key,"ids".$key,$val_1[$key],$val_2[$key],'eee','manuel',$modif);	
			$modif = check_modif($fiab_1[$key],$fiab_2[$key],"fiab".$key);
			if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($_POST["etape"],$id_user,$id,"fiab_".$key,"fiab".$key,$fiab_1[$key],$fiab_2[$key],'eee','manuel',$modif);
			}
		pg_free_result ($result);unset($val_1);unset($val_2);

		/*Sources*/
		$query = "SELECT t.uid, s.ids, s.contenu, s.fiabilite
			FROM eee.taxons t JOIN eee.source s ON t.uid = s.uid
			WHERE t.uid = $id;";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC)) 
				{
				$source[$row["ids"]] = sql_format_quote($row["contenu"],'do');
				$fiabilite[$row["ids"]] = $row["fiabilite"];
				}
		foreach ($ids as $key_st => $val_st)
			{
			$fiab = "fiab".$key_st;
			
			if ($_POST[$val_st] != $source[$key_st] OR $_POST[$fiab] != $fiabilite[$key_st])	{	/*différence*/
				if (empty($source[$key_st]) AND empty($fiabilite[$key_st]))	/*NEW*/
					{
					$query = "INSERT INTO eee.source (uid,ids,contenu,fiabilite) VALUES ($id, $key_st, ".sql_format_quote($_POST[$val_st],'do').", ".frt($fiab,$_POST[$fiab]).");";
					if (DEBUG) echo "<BR>$query";		
					$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);			
					}
				elseif(empty($_POST[$val_st]) AND empty($_POST[$fiab]))	/*SUPPR*/
					{
					$query = "DELETE FROM eee.source WHERE uid = $id AND ids = $key_st";
					if (DEBUG) echo "<BR>$query";
					$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
					}
				else {																										/*Autres cas = modif*/
					$query = "UPDATE eee.source SET (contenu,fiabilite) = (".sql_format_quote($_POST[$val_st],'do').",".frt($fiab,$_POST[$fiab]).") WHERE uid = $id AND ids = $key_st";
					if (DEBUG) echo "<BR>$query";
					$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
					}
				}
			}

			
		/*Argumentation*/	
		$query="SELECT t.uid, a.ida,a.contenu FROM eee.taxons AS t JOIN eee.argument a ON t.uid = a.uid	WHERE t.uid=".$id.";";
		if (DEBUG) echo "<br> requete  ".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))	{
			$val_1[$row['ida']] = sql_format_quote($row['contenu'],'do');
			}
		foreach ($ref['liste_argument'] as $key => $i)	{
			if ($_POST['ida'.$key]  != null) $val_2[$key] = $_POST['ida'.$key];
			}
		foreach ($ref['liste_argument'] as $key => $key)	{
			$modif = check_modif($val_1[$key],$val_2[$key],'ida'.$key);
			if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($_POST["etape"],$id_user,$id,"liste_argument_".$key,"ida".$key,$val_1[$key],$val_2[$key],'eee','manuel',$modif);
			}
		pg_free_result ($result);unset($val_1);unset($val_2);
		
		/*Arguments*/
		$query = "SELECT t.uid, s.ida, s.contenu FROM eee.taxons t JOIN eee.argument s ON t.uid = s.uid WHERE t.uid = $id;";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC)) 
				{$argument[$row["ida"]] = sql_format_quote($row["contenu"],'do');}
		foreach ($ida as $key_st => $val_st)
			{
			if (!empty($_POST[$val_st]) AND empty($argument[$key_st]))
				{
				$query = "INSERT INTO eee.argument (uid,ida,contenu) VALUES ($id, $key_st, ".sql_format_quote($_POST[$val_st],'do').")";	
				$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);			
				}
			elseif(!empty($_POST[$val_st]) AND $_POST[$val_st] != $argument[$key_st])
				{
				$query = "UPDATE eee.argument SET contenu = ".sql_format_quote($_POST[$val_st],'do')." WHERE uid = $id AND ida = $key_st";
				$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
				}
			elseif(empty($_POST[$val_st]) AND !empty($argument[$key_st]))
				{
				$query = "DELETE FROM eee.argument WHERE uid = $id AND ida = $key_st";
				$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
				}
			}
		
		/*NB : la suite de ce SUIVI se trouve après le UPDATE*/
		foreach($ref['liste_question'] as $key => $value)	{
			$query="SELECT t.uid, lr.code_question, r.idq FROM eee.taxons AS t JOIN eee.reponse r ON t.uid = r.uid JOIN eee.liste_reponse lr ON lr.idq=r.idq WHERE lr.code_question = '$key' AND t.uid=".$id.";";
			$ligne = sql_assoc ($query,true);
			$val_1_idq[$key] = $ligne['idq'];
			}
				
		// /*NB : la suite de ce SUIVI se trouve après le UPDATE*/
		$query="SELECT * FROM eee.evaluation WHERE uid=".$id.";";
		if (DEBUG) echo "<br> requete  ".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		$backup=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
		foreach ($backup as $field => $val_1)
			$val_1_eval[$field] = $val_1;
			
	//------------------------------------------------------------------------------ Update
		/*Entrée pour les questions Géo*/	
		// $pays_indi = !empty($_POST["pays_indi_select"]) ? $_POST["pays_indi_select"] : array();
		// $pays_choisis = !empty($_POST["pays_pres_select"]) ? $_POST["pays_pres_select"] : array();
		// $query_ag = array();
		// $query="SELECT p.idq, lr.code_question
		// FROM eee.taxons AS t JOIN eee.reponse p ON t.uid = p.uid JOIN eee.liste_reponse lr ON lr.idq = p.idq
		// WHERE t.uid=".$id.";";
		// $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		// while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			// $reponse[$row['code_question']] = $row['idq'];
		// pg_free_result ($result);
		
		/*question 1*/
		// $query="SELECT idp, pays
		 // FROM eee.pays WHERE pays IN ('Afghanistan', 'Afrique du Sud', 'Albanie', 'Algérie', 'Allemagne', 'Andorre', 'Argentine', 'Australie', 'Autriche', 'Belgique', 'Bolivie', 'Bosnie-Herzégovine', 'Brésil', 'Bulgarie', 'Canada', 'Chili', 'Chine', 'Cisjordanie', 'Colombie', 'Corée du Sud', 'Croatie', 'Danemark', 'Équateur', 'Espagne', 'États-Unis', 'Éthiopie', 'France', 'Grèce', 'Hongrie', 'Île Pitcairn', 'Inde', 'Irak', 'Iran', 'Irlande', 'Israël', 'Italie', 'Japon', 'Kenya', 'Libye', 'Luxembourg', 'Madagascar', 'Maroc', 'Mexique', 'Moldavie', 'Montenegro', 'Norvège', 'Nouvelle-Zélande', 'Ouzbékistan', 'Paraguay', 'Pays-Bas', 'Pérou', 'Pologne', 'Portugal', 'République Tchèque', 'Réunion', 'Roumanie', 'Royaume-Uni', 'Serbie', 'Slovaquie', 'Slovénie', 'Suède', 'Suisse', 'Syrie', 'Tadjikistan', 'Tanzanie', 'Taïwan', 'Territoire Palestinien Occupé', 'Tunisie', 'Ukraine', 'Uruguay', 'Vietnam') ORDER BY idp;";
		// $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		// while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			// $pays_climat[$row['idp']] = $row['idp'];
		// pg_free_result ($result);
		// /*Regle de décision*/
		// $test_climat = array_intersect($pays_choisis,$pays_climat);
		// if (empty($pays_choisis))
			// $idq['ag1'] = null;
		// else if (!empty($test_climat))
			// $idq['ag1'] = 1;
		// else
			// $idq['ag1'] = 2;
		/*Requêtes*/
		// if (empty($reponse['ag1']) AND !empty($pays_choisis))	/*Nouvelle liste de pays*/
			// {$query_ag['ag1'] = "INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag1'].", 'gl');";}
		// elseif (empty($pays_choisis) AND !empty($reponse['ag1']))	/*Supression de tous les pays*/
			// {$query_ag['ag1'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag1'].";";}
		// elseif ($idq['ag1'] != $reponse['ag1'] AND !empty($reponse['ag1']))	/*Modification de la liste des pays*/
			// {$query_ag['ag1'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag1']."; INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag1'].", 'gl');";}
		
		/* question 2 - Indigenat en Europe */
		// $query="SELECT p.idp
		// FROM eee.pays p
		// WHERE continent ='Europe';";
		// $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		// while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			// $europe[$row['idp']] = $row['idp'];
		// pg_free_result ($result);
		/*Regle de décision*/
		// $indi_europe = array_intersect($pays_indi,$europe);
		// if (empty($pays_indi))
			// $idq['ag2'] = null;
		// else if (!empty($indi_europe))
			// $idq['ag2'] = 5;
		// else
			// $idq['ag2'] = 6;
		/*Requêtes*/
		// if (empty($reponse['ag2']) AND !empty($pays_indi))	/*Nouvelle liste de pays*/
			// {$query_ag['ag2'] = "INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag2'].", 'gl');";}
		// elseif (empty($pays_choisis) AND !empty($reponse['ag2']))	/*Supression de tous les pays*/
			// {$query_ag['ag2'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag2'].";";}
		// elseif ($idq['ag2'] != $reponse['ag2']  AND !empty($reponse['ag2']))	/*Modification de la liste des pays*/
			// {$query_ag['ag2'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag2']."; INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag2'].", 'gl');";}

		// /*question 3 - nombre de Pays*/
		// /*Regle de décision*/
		// /* $nb_pays = count($pays_choisis);*/
		// $nb_pays_euro = count(array_intersect($pays_choisis,$europe));
		// if (empty($pays_choisis))
			// $idq['ag3'] = null;
		// else if ($nb_pays_euro <= 1)
			// $idq['ag3'] = 9;
		// elseif ($nb_pays_euro > 1 AND $nb_pays_euro <= 5)
			// $idq['ag3'] = 10;
		// elseif ($nb_pays_euro > 5)
			// $idq['ag3'] = 11;
			
		/*Requêtes*/	
		// if (empty($reponse['ag3']) AND !empty($pays_choisis))	/*Nouvelle liste de pays*/
			// {$query_ag['ag3'] = "INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag3'].", 'gl');";}
		// elseif (empty($pays_choisis) AND !empty($reponse['ag3']))	/*Supression de tous les pays*/
			// {$query_ag['ag3'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag3'].";";}
		// elseif ($idq['ag3'] != $reponse['ag3']  AND !empty($reponse['ag3']))	/*Modification de la liste des pays*/
			// {$query_ag['ag3'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag3']."; INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag3'].", 'gl');";}
		
		/*question 4 - Etendue géographique*/
		// $query="SELECT x_min, x_max, y_min, y_max, st.idp
		// FROM eee.pays p JOIN eee.statut_inter st ON st.idp = p.idp
		// WHERE st.uid=".$id." AND statut = 'pres' ORDER BY x_min, x_max;";
		// $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		// $i=0;
		// while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			// {
			// $xmin[$i] = $row['x_min'];
			// $ymin[$i] = $row['y_min'];
			// $xmax[$i] = $row['x_max'];
			// $ymax[$i] = $row['y_max'];
			// $i++;
			// }
		
		// pg_free_result ($result);
		/*Précalcul*/
		// if (count($xmin) == 0)
			// {$etendu_lat = 0;$etendu_long = 0;}
		// elseif (count($xmin) == 1)
			// {$etendu_lat = $xmax[0] - $xmin[0];	$etendu_long = $ymax[0] - $ymin[0];
			// }
		// else
			// {
			// for ($i = 0; $i < $nb_pays-1; $i++) $diff[$i]= $xmin[$i+1] - $xmax[$i];
			// $diff["last"] = 360 + ($xmin[0] - $xmax[$nb_pays-1]);
			// $etendu_lat = 360 - max($diff);
			// $etendu_long = max($ymax) - min($ymin);
			// }
		// if (DEBUG) echo "les étendues sont de  $etendu_lat en latitude et $etendu_long en longitude <BR>";
		/*Regle de décision*/
		// if ($etendu_lat == 0 AND $etendu_long == 0)
			// $idq['ag4'] = null;
		// else if ($etendu_lat >=15 OR $etendu_long>=15)
			// $idq['ag4'] = 16;
		// else
			// $idq['ag4'] = 15;
		/*Requêtes*/
		// if (empty($reponse['ag4']) AND !empty($pays_choisis))	/*Nouvelle liste de pays*/
			// {$query_ag['ag4'] = "INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag4'].", 'gl');";}
		// elseif (empty($pays_choisis) AND !empty($reponse['ag4']))	/*Supression de tous les pays*/
			// {$query_ag['ag4'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag4'].";";}
		// elseif ($idq['ag4'] != $reponse['ag4']  AND !empty($reponse['ag4']))	/*Modification de la liste des pays*/
			// {$query_ag['ag4'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['ag4']."; INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['ag4'].", 'gl');";}
		
		/* question 9 - EEE inter */
		// $pays_invav = !empty($_POST["st_nvav_inter_select"]) ? $_POST["st_nvav_inter_select"] : array();
		// /*Regle de décision*/
		// if (empty($pays_invav))
			// $idq['cg9'] = null;
		// elseif (count($pays_invav) >=3)
			// $idq['cg9'] = 65;
		// else
			// $idq['cg9'] = 66;
		/*Requêtes*/
		// if (empty($reponse['cg9']) AND !empty($pays_invav))	/*Nouvelle liste de pays*/
			// {$query_ag['cg9'] = "INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['cg9'].", 'gl');";}
		// elseif (empty($pays_invav) AND !empty($reponse['cg9']))	/*Supression de tous les pays*/
			// {$query_ag['cg9'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['cg9'].";";}
		// elseif ($idq['cg9'] != $reponse['cg9']  AND !empty($reponse['cg9']))	/*Modification de la liste des pays*/
			// {$query_ag['cg9'] = "DELETE FROM eee.reponse WHERE uid = $id AND idq = ".$reponse['cg9']."; INSERT INTO eee.reponse(uid,idq, zone) VALUES ($id, ".$idq['cg9'].", 'gl');";}
			
		/*Lancement des requêtes pour les questions 1 à 4 + 9*/
		// foreach ($query_ag as $key => $query)
			// {
			// $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$key." => ".$query);
			// pg_free_result ($result);
			// }


		/*Question_reponses*/
		// $question_reponse = array (
			// "bg5"=>$_POST["viab_graine_select"], 
			// "bg6"=>$_POST["croiss_veg_select"], 
			// "bg7"=>$_POST["mod_disp_select"], 
			// "bg8"=>$_POST["type_bio_select"], 
			// "cg10"=>$_POST["taxo_select"], 
			// "cg11"=>$_POST["habt_select"], 
			// "cg12"=>$_POST["dens_pop_select"]	
			// );
		$question_reponse = array ("ag1", "ag2", "ag3", "ag4", "bg5", "bg6", "bg7", "bg8", "cg10", "cg11", "cg12");
		foreach ($question_reponse as $key)
			{
			$query="SELECT t.uid, r.idq, r.zone
			FROM eee.taxons AS t JOIN eee.reponse AS r ON t.uid = r.uid	JOIN eee.liste_reponse lr ON lr.idq = r.idq
			WHERE t.uid=$id AND lr.code_question = '$key';"; 			
			update_multi($query,$_POST["zone"],"idq",$_POST[$key],"eee.reponse",$id);
			}
		

		/*Fiabilité*/
		$query="SELECT uid, fiab_tot, liste_eval, carac_emerg, carac_avere, eval_expert
		FROM eee.evaluation 
		WHERE uid=$id;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{$uid = $row['uid'];
			$fiab_tot = $row['fiab_tot'];
			$liste_eval = $row['liste_eval'];
			$carac_emerg = $row['carac_emerg'];
			$carac_avere = $row['carac_avere'];
			$eval_expert = $row['eval_expert'];}
		pg_free_result ($result);

			/*requetes*/
		if (empty($uid))
			{$query = "INSERT INTO eee.evaluation (uid) VALUES ($id)";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : $query");
			pg_free_result ($result);
			}
				
			/*requetes*/
		$query	= "
		WITH src_total AS (SELECT count(ids) as nb FROM eee.liste_source),
		src_normal AS (SELECT uid, count(ids) as nb FROM eee.source WHERE contenu IS NOT NULL AND fiabilite = 0 GROUP BY uid),
		src_bonne AS (SELECT uid,count(ids) as nb FROM eee.source WHERE contenu IS NOT NULL AND fiabilite = 1 GROUP BY uid)
		SELECT src_normal.uid, src_normal.nb as nb_normal, src_bonne.nb as nb_bonne, src_total.nb as nb_total
		FROM src_total,src_normal 
		FULL OUTER JOIN src_bonne ON src_normal.uid=src_bonne.uid
		WHERE src_normal.uid = $id OR src_bonne.uid = $id;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{$nb_src_normal = !empty($row['nb_normal'])?$row['nb_normal']:0;
			$nb_src_bonne = !empty($row['nb_bonne'])?$row['nb_bonne']:0;
			$nb_src_total = $row['nb_total'];}
		pg_free_result ($result);
		$query	= "
		WITH qst_total AS (SELECT count(DISTINCT code_question) as nb FROM eee.liste_reponse WHERE code_eval LIKE '%g')
		SELECT count(DISTINCT code_question) as nb_reponse, nb as nb_reponse_total 
		FROM qst_total, eee.liste_reponse lr JOIN eee.reponse r ON r.idq = lr.idq
		WHERE uid = $id GROUP BY nb;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{$nb_rep = !empty($row['nb_reponse'])?$row['nb_reponse']:0;
			$nb_rep_total = $row['nb_reponse_total'];}
		pg_free_result ($result);
		
		// /*Question spéciales diminuant la fiabilité*/
		if ($_POST["bg5"][0] == 21) {$nb_rep = $nb_rep-1;}
		if ($_POST["bg6"][0] == 30) {$nb_rep = $nb_rep-1;}
		if ($_POST["bg7"][0] == 43) {$nb_rep = $nb_rep-1;}
		if ($_POST["cg12"][0] == 90) {$nb_rep = $nb_rep - 1;}
			
		if ($nb_src_total + $nb_rep_total + $nb_src_bonne != 0)
			{
			$fiab_tot_select = ($nb_src_normal + $nb_src_bonne*2 + $nb_rep)/($nb_src_total + $nb_rep_total + $nb_src_bonne);
			$fiab_tot_select = round($fiab_tot_select,2);
		} else {$fiab_tot_select = 0;}

		if ($fiab_tot != $fiab_tot_select)		/*Ajout*/
			{
			if ($fiab_tot_select == null) $fiab_tot_select = 0;
			$query = "UPDATE eee.evaluation SET fiab_tot = $fiab_tot_select WHERE uid = $id";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : $query");
			pg_free_result ($result);
			}

			
		// /*Evaluation*/
		// /*
		// $query="SELECT uid
			// FROM eee.evaluation 
			// WHERE uid=$id;";
		// $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		// while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			// $uid = $row['uid'];
		// pg_free_result ($result);
		// */

		$query="SELECT code_eval, sum(ind) as ind
			FROM
			(SELECT  lr.code_eval, lr.code_question, max(indicateur) as ind
			FROM eee.taxons AS t JOIN eee.reponse p ON t.uid = p.uid JOIN eee.liste_reponse lr ON lr.idq = p.idq
			WHERE t.uid=$id
			GROUP BY lr.code_eval, lr.code_question
			) as one
			GROUP BY code_eval;";
		$result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{$eval[$row["code_eval"]] = $row["ind"];}
		pg_free_result ($result);
		
		$tot["ind_a"] = !empty($eval["ag"]) ? $eval["ag"] : 0;
		$tot["ind_b"] = !empty($eval["bg"]) ? $eval["bg"] : 0;
		$tot["ind_c"] = !empty($eval["cg"]) ? $eval["cg"] : 0;
		$tot["ind_tot"] = $eval["ag"]+$eval["bg"]+$eval["cg"];


		foreach ($tot as $k => $val)
				{
				if ($val == 0) {$val = 'NULL';}
				$query_eval[$k] = "UPDATE eee.evaluation SET $k = $val WHERE uid = $id;";
				}
			/*Evaluation totale*/
			if ($tot["ind_tot"] <=20)
				{$eval_tot = 'FAIBLE';}
			elseif ($tot["ind_tot"] > 20 AND $tot["ind_tot"] <= 27)
				{$eval_tot = 'INTERMEDIAIRE';}
			else
				{$eval_tot = 'FORT';}
			if ($fiab_tot_select <=0.5)
				{$eval_tot = 'Insuffisamment documenté';}
			if ($nb_rep == 0)
				{$eval_tot = NULL;}
			
			$query_eval["eval"] = "UPDATE eee.evaluation SET eval_tot = '$eval_tot' WHERE uid = $id;";
		
		/*Lancement des requêtes pour les evaluation*/
		foreach ($query_eval as $key => $query)
			{
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$key." => ".$query);
			pg_free_result ($result);
			}

		/*statut*/
		if ($liste_eval != $_POST["liste_eval"])
			{
			if ($_POST["liste_eval"] == '') {$_POST["liste_eval"] = NULL;}
			$query = "UPDATE eee.evaluation SET liste_eval = '".$_POST["liste_eval"]."' WHERE uid = $id";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : $query");
			pg_free_result ($result);
			}
		if ($carac_emerg != $_POST["carac_emerg"])
			{
			if ($_POST["carac_emerg"] == '') {$_POST["carac_emerg"] = NULL;}
			$query = "UPDATE eee.evaluation SET carac_emerg = '".$_POST["carac_emerg"]."' WHERE uid = $id";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : $query");
			pg_free_result ($result);
			}
		if ($carac_avere != $_POST["carac_avere"])
			{
			if ($_POST["carac_avere"] == '') {$_POST["carac_avere"] = NULL;}
			$query = "UPDATE eee.evaluation SET carac_avere = '".$_POST["carac_avere"]."' WHERE uid = $id";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : $query");
			pg_free_result ($result);
			}
		if ($eval_expert != $_POST["eval_expert"])
			{
			if ($_POST["eval_expert"] == '') {$_POST["eval_expert"] = NULL;}
			$query = "UPDATE eee.evaluation SET eval_expert = ".sql_format_quote($_POST["eval_expert"],'do')." WHERE uid = $id";
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : $query");
			pg_free_result ($result);
			}

	//------------------------------------------------------------------------------ Suite et Fin du suivi

		/*Reponses*/	
		$question_reponse = array ("ag1", "ag2", "ag3", "ag4", "bg5", "bg6", "bg7", "bg8", "cg10", "cg11", "cg12");
		foreach ($question_reponse as $key)
			if (isset($_POST[$key])) $idq[$key] = $_POST[$key];
			
		// if (isset($_POST["croiss_veg_select"])) $idq["bg6"] = $_POST["croiss_veg_select"];
		// if (isset($_POST["mod_disp_select"])) $idq["bg7"] = $_POST["mod_disp_select"];
		// if (isset($_POST["type_bio_select"])) $idq["bg8"] = $_POST["type_bio_select"];
		// if (isset($_POST["taxo_select"])) $idq["cg10"] = $_POST["taxo_select"];
		// if (isset($_POST["habt_select"])) $idq["cg11"] = $_POST["habt_select"];
		// if (isset($_POST["dens_pop_select"])) $idq["cg12"] = $_POST["dens_pop_select"];

		$val_2 = $idq;
		foreach ($ref['liste_question'] as $key => $val)	{
			$modif = check_modif($val_1_idq[$key],$val_2[$key],$key);
			// echo "<BR> clé : $key";
			if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($_POST["etape"],$id_user,$id,"liste_reponse_".$key,$key,$val_1_idq[$key],$val_2[$key],'eee','manuel',$modif);
			}
		unset($val_1_idq);unset($val_2);


		// /*evaluation*/	
		$champ_eval = array (
			'liste_eval' => $_POST["liste_eval"],
			'carac_emerg' => $_POST["carac_emerg"],
			'carac_avere' => $_POST["carac_avere"],
			'eval_expert' => $_POST["eval_expert"],
			'ind_a' => $tot["ind_a"],
			'ind_b' => $tot["ind_b"],
			'ind_c' => $tot["ind_c"],
			'eval_tot' => $eval_tot,
			'fiab_tot' => $fiab_tot_select
			);
		foreach ($champ_eval as $key => $value)
			if (isset($value)) $val_2[$key] = $value;

		foreach ($champ_eval as $field  => $foo) {
			$modif = check_modif($val_1_eval[$field],$val_2[$field],$field);
			if ($modif != 'vide' AND $modif != 'identiques') add_suivi2($_POST["etape"],$id_user,$id,"evaluation",$field,$val_1_eval[$field],$val_2[$field],'eee','manuel',$modif);
		} 
		unset($val_1_eval);unset($val_2);

	}
	if ($niveau >= 64)	/*Seulement les participants et au dessus*/
		{
		/*Commentaire sur le taxon*/
		$ligne = sql_assoc ("SELECT commentaire FROM eee.taxons WHERE uid= $id;",true);
		foreach ($ligne as $field => $val_1) {
			$val_2 = $_POST[$field];
			$modif = check_modif($val_1,$val_2,$field);
			if ($modif != 'vide' AND $modif != 'identiques') {
				add_suivi2($_POST["etape"],$id_user,$id,"taxons",$field,$val_1,$val_2,'eee','manuel',$modif);	/*Suivi*/
				sql_assoc ("UPDATE eee.taxons SET $field = ".frt($field,$val_2)." WHERE uid=$id;",false);
				}
			}

		/*Commentaire sur la fiche*/
		if (isset($_POST['commentaire_eval']))	{
			if (!empty($_POST['commentaire_eval'])) {
				$result=pg_query ($db,$query_user." AND id_user = '$id_user'") or die ("Erreur pgSQL : ".pg_result_error ($result));
				$user=pg_fetch_array ($result,NULL,PGSQL_ASSOC);
				$insert = "INSERT INTO eee.discussion (uid,id_user,nom,prenom,id_cbn,commentaire_eval,datetime) 
				VALUES ($id,'$user[id_user]','$user[nom]','$user[prenom]',$user[id_cbn],".sql_format_quote($_POST[commentaire_eval],'do').",NOW())";
				// echo $insert;
				$result=pg_query ($db,$insert) or die ("Erreur pgSQL : ".pg_result_error ($result));
				add_suivi2($etape,$id_user,$id,"discussion","commentaire_eval","",sql_format_quote($_POST[commentaire_eval],'do'),$id_page,'manuel',"ajout");
				}
			}
		}	
    } else {                                                                    
//------------------------------------------------------------------------------	
//------------------------------------------------------------------------------ ADD.
/*Nothing ==> go Refnat*/
}

/*
if (!DEBUG) {
    echo ("<script language=\"javascript\" type=\"text/javascript\">");
    echo ("window.location.replace ( \"index.php\")");
    echo ("</script>");
}
*/
pg_close ($db);

return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
