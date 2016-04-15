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
include_once ("commun.inc.php");
/*D1 : Droit accès à la page*/
$base_file = substr(basename(__FILE__),0,-4);
$droit_page = acces($id_page,'d1',$base_file,$_SESSION["droit_user"][$id_page]);
if ($droit_page) {

//------------------------------------------------------------------------------ PARMS.
$id=$_POST['id'];

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ MAIN
if (!empty ($id)) 
{
    $query="UPDATE applications.taxons SET $id_page = false";

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

    $query="UPDATE applications.taxons	SET $id_page = false WHERE ".$where.";";
	$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);

    add_suivi2(1,$id_user,$where,"taxons","uid",$id,null,$id_page,'manuel','suppr');
	add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Suppression multi fiches",$where,"taxons,chorologie,evaluation");
	
	
}
pg_close ($db);
return (true);
//------------------------------------------------------------------------------ SI PAS ACCES 
} else require ("../commun/access_denied.php"); 

?>
