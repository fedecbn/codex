<?php
//------------------------------------------------------------------------------//
//  commun/export_statut.php                                                    //
//                                                                              //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
require_once ("commun.inc.php");

//------------------------------------------------------------------------------ PARMS.
$uid=$_GET['uid']; 
$class_valid=$_GET['class_valid']; 
$val_com = isset($_GET['$val_com']) ? $_GET['$val_com'] : null ; 
$id_user = $_SESSION['id_user'];
$db=sql_connect(SQL_base);

//------------------------------------------------------------------------------ INIT JAVASCRIPT
$query = "SELECT etape, version FROM lr.evaluation WHERE uid=$uid ;";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
$row = pg_fetch_assoc($result);

//------------------------------------------------------------------------------ MAIN
if ($class_valid == 'valid') {
	$query = "INSERT INTO lr.validation(uid, etape, version, id_user, validation, val_com, dat_val) VALUES ($uid, '".$row['etape']."', ".$row['version'].", '$id_user', 'valid', null, NOW());";
	echo "validé";
	}
elseif ($class_valid == 'invalid') {
	$query = "INSERT INTO lr.validation(uid, etape, version, id_user, validation, val_com, dat_val) VALUES ($uid, '".$row['etape']."', ".$row['version'].", '$id_user', 'invalid', '$val_com', NOW());";
	echo "invalidé";
	}
elseif ($class_valid == 'valid_chg') {
	$query = "UPDATE lr.validation SET validation='valid', val_com=null,  dat_val=NOW() WHERE uid=$uid AND etape= '".$row['etape']."' AND version=".$row['version']." AND id_user='$id_user';";
	echo "changement = validé";
	}
elseif ($class_valid == 'invalid_chg') {
	$query = "UPDATE lr.validation SET validation='invalid', val_com= '$val_com',  dat_val=NOW() WHERE uid=$uid AND etape='".$row['etape']."' AND version=".$row['version']." AND id_user='$id_user';";
	echo "changement = invalidé";
	}
else {
	$query = "SELECT 1;";
	echo "Rien";
	}
	
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));


?>

