<?php
//------------------------------------------------------------------------------//
//  /index.php                                                                  //
//                                                                              //
//  Version 1.00  13/07/12 - OlGa (CBNMED)                                      //
//------------------------------------------------------------------------------//

if (!file_exists("_INCLUDE/config_sql.inc.php"))
	header("Location: flore/home/install.php");
else
	header("Location: flore/home");
exit;

?>

