<?php
//------------------------------------------------------------------------------//
//  /index.php                                                                  //
//                                                                              //
//  Version 1.00  13/07/12 - OlGa (CBNMED)                                      //
//------------------------------------------------------------------------------//

if (!file_exists("_INCLUDE/install-ok.txt"))
	header("Location: flore/home/install.php");
else
	header("Location: flore/home");
exit;

?>

