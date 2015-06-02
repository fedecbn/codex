<?php
//------------------------------------------------------------------------------//
//  home/logout.php                                                             //
//                                                                              //
//  Livre rouge de la flore menacée de France                                   //
//                                                                              //
//  Version 1.00  06/11/07 - OlGa                                               //
//  Version 1.02  18/05/09 - redirection                                        //
//  Version 1.03  10/02/11 - redirection JS                                     //
//  Version 1.04  17/04/11 - MaJ redirection                                    //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
$_SESSION=array();
session_destroy();
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<body>
<?php
?>
<script language=javascript>
opener = self;
self.close();
window.location.replace ('index.php');				
</script>
</body>
</html>
