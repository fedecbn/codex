<?php
//------------------------------------------------------------------------------//
//  _INCLUDE/doanload.php                                                       //
//                                                                              //
//                                                                              //
//  Version 1.00  15/04/12 - OlGa                                               //
//  Version 1.01  17/08/12 - MaJ path                                           //
//  Version 1.02  11/06/14 -                                                    //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ PARMS.
$fullPath=$_GET['f'];

//------------------------------------------------------------------------------ MAIC

if (!is_file ($fullPath) || !is_readable ($fullPath)) {
    header ("HTTP/1.1 404 Not Found");
    exit ();
}

header ('Pragma: no-cache');
header ('Cache-Control: no-cache, must-revalidate');
header ('Expires: 0');
header ('Content-Transfer-Encoding: binary');
header ('Content-Length: '.filesize ($fullPath));
header ('Content-Type: application/octetstream; name="'.basename($fullPath).'"');
header ('Content-Disposition: attachment; filename="'. basename($fullPath).'"');
readfile ($fullPath);

exit ();
?>

