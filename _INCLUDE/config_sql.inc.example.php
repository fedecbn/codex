<?php
//------------------------------------------------------------------------------//
//    /_INCLUDE/CONFIG_SQL.INC.PHP                                              //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  13/08/14 - MaJ schémas                                        //
//  Version 1.02  18/08/14 - Aj sql_format_num                                  //
//  Renseigner les paramètre de connexion et remplacer le nom du fichier par confi_sql.inc.php//
//------------------------------------------------------------------------------//

    define ("ON_Server", "no");
    define ("SQL_server", "localhost");
    define ("SQL_port", "5432");
    define ("SQL_user", "user_codex");
    define ("SQL_pass", "codex_user");
    define ("SQL_base", "codex");

	define ("SQL_admin_user", "postgres");
    define ("SQL_admin_pass", "test");
	define ("SQL_taxa", "taxa");
	
    define ("SQL_schema_app", "applications");
    define ("SQL_schema_lr", "liste_rouge");
    define ("SQL_schema_eee", "eee");
    define ("SQL_schema_ref", "referentiels");
    define ("SQL_schema_lsi", "lsi");

//------------------------------------------------------------------------------ FONCTIONS




?>
