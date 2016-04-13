<?php
//------------------------------------------------------------------------------//
//  commun/export_statut.php                                                    //
//                                                                              //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
require_once ("commun.inc.php");

//------------------------------------------------------------------------------ PARMS.
$id=$_GET['id']; 
$class_valid=$_GET['class_valid']; 
$val_com = isset($_GET['$val_com']) ? $_GET['$val_com'] : null ; 
$id_user = $_SESSION['id_user'];
$db=sql_connect(SQL_base);

foreach($id as $uid) {
//------------------------------------------------------------------------------ INIT JAVASCRIPT
$query = "SELECT evaluation.etape, evaluation.version, validation FROM lr.evaluation 
LEFT JOIN lr.validation ON evaluation.uid = validation.uid
WHERE evaluation.uid=$uid ;";
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
$row = pg_fetch_assoc($result);

//------------------------------------------------------------------------------ MAIN
if ($class_valid == 'valid') {
	if ($row['validation'] == null) $query = "INSERT INTO lr.validation(uid, etape, version, id_user, validation, val_com, dat_val) VALUES ($uid, '".$row['etape']."', ".$row['version'].", '$id_user', 'valid', null, NOW());";
	if ($row['validation'] == 'invalid') 	$query = "UPDATE lr.validation SET validation='valid', val_com=null,  dat_val=NOW() WHERE uid=$uid AND etape= '".$row['etape']."' AND version=".$row['version']." AND id_user='$id_user';";
	echo "<BR>$uid validé";
	}
elseif ($class_valid == 'invalid') {
	if ($row['validation'] == null) $query = "INSERT INTO lr.validation(uid, etape, version, id_user, validation, val_com, dat_val) VALUES ($uid, '".$row['etape']."', ".$row['version'].", '$id_user', 'invalid', '$val_com', NOW());";
	if ($row['validation'] == 'valid') $query = "UPDATE lr.validation SET validation='invalid', val_com= '$val_com',  dat_val=NOW() WHERE uid=$uid AND etape='".$row['etape']."' AND version=".$row['version']." AND id_user='$id_user';";
	echo "<BR>$uid invalidé";
	}
// elseif ($class_valid == 'valid_chg') {
	// $query = "UPDATE lr.validation SET validation='valid', val_com=null,  dat_val=NOW() WHERE uid=$uid AND etape= '".$row['etape']."' AND version=".$row['version']." AND id_user='$id_user';";
	// echo "changement = validé";
	// }
// elseif ($class_valid == 'invalid_chg') {
	// $query = "UPDATE lr.validation SET validation='invalid', val_com= '$val_com',  dat_val=NOW() WHERE uid=$uid AND etape='".$row['etape']."' AND version=".$row['version']." AND id_user='$id_user';";
	// echo "changement = invalidé";
	// }
else {
	$query = "SELECT 1;";
	echo "<BR>$uid Rien";
	}
	
$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".pg_result_error ($result));
}

?>

