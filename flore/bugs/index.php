<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr" >
<?php
//------------------------------------------------------------------------------//
//  bugs/index.php                                                              //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  13/08/14 - MaJ schémas                                        //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
session_start();
include("commun.inc.php");

//------------------------------------------------------------------------------ VAR.
$niveau=$_SESSION['niveau'];
$id_user=$_SESSION['id_user'];
$config=$_SESSION['id_config'];
$lang_select=$_COOKIE['lang_select'];

//----------------------------------------------------------------------------- PARMS.
if (isset($_GET['action']) & !empty($_GET['action']))
   $action=$_GET['action'];
elseif (isset($_POST['action']) & !empty($_POST['action']))
   $action=$_POST['action'];    

//------------------------------------------------------------------------------ CONNEXION SERVEUR PostgreSQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);

//------------------------------------------------------------------------------ REF.

//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery-ui.custom.min.js"></script>

<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.dataTables.columnFilter.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.form.js"></script>
<script type="text/javascript" language="javascript" src="../../_INCLUDE/js/jquery.validate.min.js"></script>

<script type="text/javascript" language="javascript" src="js/bugs.js"></script>
<?php

//------------------------------------------------------------------------------ MAIN
html_header ("utf-8","table_eval.css","");
echo ("<body>");
echo ("<div id=\"page_consult\" class=\"page_consult\">");

//------------------------------------------------------------------------------ Boutons
echo ("<div id=\"header2\">");
    echo ("<div style=\"float:left;\">");
    echo ("<button id=\"home-button\">".$lang[$lang_select]['Retour_menu']."</button>");
    echo ("</div>");
    echo ("<font size=5>".$lang[$lang_select]['titre_bug']."</font>");
echo ("</div>");

echo ("<div id=\"tabs\" style=\"min-height:300px;\">");
echo ("<ul>");
echo ("<li><a href=\"#tab-new\">".$lang[$lang_select]['titre_bug_new']."</a></li>");
echo ("<li><a href=\"#tab-ok\">".$lang[$lang_select]['titre_bug_ok']."</a></li>");
echo ("</ul>");

//------------------------------------------------------------------------------ #Nouveaux / En cours
echo ("<div id=\"tab-new\" style=\"margin:0;padding:5;min-height:700px;\">");
    echo ("<form method=\"POST\" id=\"form2\" name=\"add\" action=\"index.php\" >");
    echo ("<input type=\"hidden\" name=\"action\" value=\"add\" />");

    echo ("<fieldset><LEGEND> ".$lang[$lang_select]['titre_bug_new']." </LEGEND>");
    echo ("<label class=\"preField\">Type</label><select id=\"cat\" name=\"cat\" >");
         for ($i=1;$i<sizeof ($cat_txt);$i++)
             echo ("<option value=\"$i\">".$cat_txt[$i]."</option>");
    echo ("</select><br>");
    if ($niveau >= 255) {
        $query="SELECT id_user,CONCAT(prenom,' ',nom) AS user FROM ".SQL_schema_app.".utilisateur ORDER BY prenom,nom;";
        $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
            $user[$row["id_user"]]=$row["user"];
        pg_free_result ($result);
        
        echo ("<label class=\"preField\">Auteur</label><select name=\"id_user\" >");
        foreach ($user as $key => $value) 
            echo ("<option value=\"$key\" ".($key == $id_user ? "SELECTED" : "")." >".$value."</option>");
        echo ("</select><br>");
    } else 
        echo ("<input type=\"hidden\" name=\"id_user\" value=\"".$id_user."\" />");
    echo ("<label class=\"preField\">Rubrique</label><select id=\"id_rubrique\" name=\"id_rubrique\" >");
    for ($i=1;$i<sizeof ($rubriques_txt);$i++)
        echo ("<option value=\"$i\">".$rubriques_txt[$i]."</option>");
    echo ("</select><br>");
    echo ("<label class=\"preField\">Description</label><textarea name=\"descr\" cols=\"80\" rows=\"3\" ></textarea><br><br>");
    echo ("<center><button id=\"valid-button\">OK</button>");
    echo ("</fieldset>");
    echo ("</form>");

    switch ($action)
    {
        default: {
        }
        break;
        case "add": {
            $query="INSERT INTO ".SQL_schema_app.".bug (";
            foreach ($_POST as $field => $val) 
                if ($field!="action" ) $query.=$field.",";
            $query.="date_bug) VALUES (";
            foreach ($_POST as $field => $val) 
				{
				if ($field == "descr" ) $query.=sql_format_quote ($val,'do').",";
                elseif ($field!="action" ) $query.=sql_format ($val).",";
				}
            $query.="NOW())";                            
// echo $query;
            $result=pg_query ($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
        }
        break;
    }
    $id_page="bug-encours";
    echo ("<div id=\"".$id_page."-dialog\"></div>");
    aff_table ($id_page."-liste",true,false);
echo ("</div>");
//------------------------------------------------------------------------------ #Traités
echo ("<div id=\"tab-ok\" style=\"margin:0;padding:5;min-height:700px;\">");
    $id_page="bug-ok";
    echo ("<div id=\"".$id_page."-dialog\"></div>");
    aff_table ($id_page."-liste",true,false);
echo ("</div>");
//------------------------------------------------------------------------------
echo ("</div>");
echo ("</div>");

echo ("<br /></div>");
echo ("<div></body></html>");
pg_close ($db);

//------------------------------------------------------------------------------ FONCTIONS

?>
