<?php
//------------------------------------------------------------------------------//
//  module_gestion/lr-del.php                                                   //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  15/08/14 - MaJ tables                                         //
//------------------------------------------------------------------------------//

session_start();
include_once ("commun.inc.php");

//------------------------------------------------------------------------------ PARMS.
$id=$_POST['id'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id)) 
{
    $query="	
	DELETE FROM catnat.statut_nat WHERE uid = $id;
	DELETE FROM catnat.taxons_nat WHERE uid = $id;
	DELETE FROM eee.evaluation WHERE uid = $id;
	DELETE FROM eee.taxons WHERE uid = $id;
	DELETE FROM liste_rouge.chorologie WHERE uid = $id;
	DELETE FROM liste_rouge.evaluation WHERE uid = $id;
	DELETE FROM liste_rouge.taxons WHERE uid = $id;
	DELETE FROM refnat.taxons WHERE uid = $id;
	";

	// INSERT INTO 
	// INSERT INTO (uid) VALUES ($uid);
	// INSERT INTO liste_rouge.chorologie(uid) VALUES ($uid);
	// INSERT INTO liste_rouge.evaluation(uid) VALUES ($uid);

    $result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
		
   	add_suivi2(1,$id_user,$id,"taxons",'uid',$id,null,$id_page,'manuel','suppr');

	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression fiche",$id,"taxons,chorologie,evaluation");
	
	
} elseif (strlen($_POST['select']) > 0) {
    $pairs=explode ("&",$_POST['select']);
    foreach ($pairs as $key=>$value){
        $id = ltrim ($value,"id=");
		$where .= "uid=".$id." OR ";
		add_suivi2(1,$id_user,$id,'taxons_nat','uid',$id,null,'catnat','manuel','suppr');
		}
    $where=rtrim ($where,"OR ");

	    $query="
	DELETE FROM catnat.statut_nat WHERE $where;
	DELETE FROM catnat.taxons_nat WHERE $where;
	DELETE FROM eee.evaluation WHERE $where;
	DELETE FROM eee.taxons WHERE $where;
	DELETE FROM liste_rouge.chorologie WHERE $where;
	DELETE FROM liste_rouge.evaluation WHERE $where;
	DELETE FROM liste_rouge.taxons WHERE $where;
	DELETE FROM refnat.taxons WHERE $where;
	";

    // $query="UPDATE refnat.taxons	SET $id_page = false WHERE ".$where.";";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);

    add_suivi2(1,$id_user,$where,"taxons","uid",$id,null,$id_page,'manuel','suppr');
	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"taxons,chorologie,evaluation");
	
	
}
pg_close ($db);
return (true);

?>
