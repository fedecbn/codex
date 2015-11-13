<?php
//------------------------------------------------------------------------------//
//   commun/module.lang.php                                                     //
//                                                                              //
//  PNC-Enjeu flore                                                             //
//                                                                              //
//  Version 1.00  24/07/14 - OlGa / CBNMED                                      //
//  Version 1.10  22/08/14 - MaJ aff_table                                      //
//  Version 1.11  31/08/14 - MaJ lr-public-liste                                //
//  Version 1.12  08/09/14 - MaJ lr-liste                                       //
//  Version 1.13  14/09/14 - MaJ lr-liste                                       //
//------------------------------------------------------------------------------//
global $langliste;
$langliste = array(array(array()));

//------------------------------------------------------------------------------ Module atlas_public
$langliste['fr']['lr-public-liste'][]="Famille";
$langliste['fr']['lr-public-liste']['1-popup']="Famille";

//------------------------------------------------------------------------------ Module gestion LR - droit
$langliste['fr']['droit'][]="Code";
$langliste['fr']['droit-popup'][]="";

$langliste['fr']['droit'][]="Prénom";
$langliste['fr']['droit-popup'][]="";

$langliste['fr']['droit'][]="Nom";
$langliste['fr']['droit-popup'][]="";

$langliste['fr']['droit'][]="Institution";
$langliste['fr']['droit-popup'][]="";

$langliste['fr']['droit'][]="Niveau de droit";
$langliste['fr']['droit-popup'][]="";

$langliste['fr']['droit'][]="Référent";
$langliste['fr']['droit-popup'][]="";



//------------------------------------------------------------------------------ Module flore / _base_module
$langliste['fr']['defaut'][]="UID";
$langliste['fr']['defaut-popup'][]="Identifiant unique";

$langliste['fr']['defaut'][]="Texte";
$langliste['fr']['defaut-popup'][]="info_text";

$langliste['fr']['defaut'][]="Réel";
$langliste['fr']['defaut-popup'][]="info_real";

$langliste['fr']['defaut'][]="Entier";
$langliste['fr']['defaut-popup'][]="info_integer";

$langliste['fr']['defaut'][]="Booléen";
$langliste['fr']['defaut-popup'][]="info_bool";


//------------------------------------------------------------------------------ Module flore / _base_module


//------------------------------------------------------------------------------ Module admin / textes
$langliste['fr']['admin-text-liste'][]="Code";
$langliste['fr']['admin-text-liste-popup'][]="Code";

$langliste['fr']['admin-text-liste'][]="Titre";
$langliste['fr']['admin-text-liste-popup'][]="Titre de la zone de texte";

$langliste['fr']['admin-text-liste'][]="Extrait";
$langliste['fr']['admin-text-liste-popup'][]="Extrait de la zone de texte";

$langliste['fr']['admin-text-liste'][]="Langue";
$langliste['fr']['admin-text-liste-popup'][]="Langue";

//------------------------------------------------------------------------------ Module admin / Users
$langliste['fr']['admin-user-liste'][]="Code";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Prénom";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Nom";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Institution";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Email";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Téléphone fixe";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Niveau LR";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Niveau LEEE";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Niveau CAT NAT";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Niveau REF NAT";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Niveau LSI";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="Niveau FSD";
$langliste['fr']['admin-user-liste-popup'][]="";

$langliste['fr']['admin-user-liste'][]="ref LR";
$langliste['fr']['admin-user-liste-popup'][]="Référent rubrique LR";

$langliste['fr']['admin-user-liste'][]="ref EEE";
$langliste['fr']['admin-user-liste-popup'][]="Référent rubrique EEE";

$langliste['fr']['admin-user-liste'][]="ref CATNAT";
$langliste['fr']['admin-user-liste-popup'][]="Référent rubrique CATNAT";

$langliste['fr']['admin-user-liste'][]="ref REFNAT";
$langliste['fr']['admin-user-liste-popup'][]="Référent rubrique REFNAT";

$langliste['fr']['admin-user-liste'][]="ref LSI";
$langliste['fr']['admin-user-liste-popup'][]="Référent rubrique LSI";

$langliste['fr']['admin-user-liste'][]="ref FSD";
$langliste['fr']['admin-user-liste-popup'][]="Référent rubrique FSD";

//------------------------------------------------------------------------------ Module admin / Suivi
$langliste['fr']['admin-suivi-liste'][]="UID";
$langliste['fr']['admin-suivi-liste-popup']['1-popup']="Identifiant unique";

$langliste['fr']['admin-suivi-liste'][]="Utilisateur";
$langliste['fr']['admin-suivi-liste-popup']['2-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Institution";
$langliste['fr']['admin-suivi-liste-popup']['3-popup']="";

$langliste['fr']['admin-suivi-liste'][]="CD REF";
$langliste['fr']['admin-suivi-liste-popup']['4-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Taxon";
$langliste['fr']['admin-suivi-liste-popup']['5-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Rubrique";
$langliste['fr']['admin-suivi-liste-popup']['6-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Type<BR>modif";
$langliste['fr']['admin-suivi-liste-popup']['7-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Manuelle / auto";
$langliste['fr']['admin-suivi-liste-popup']['7-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Champ";
$langliste['fr']['admin-suivi-liste-popup']['7-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Valeur<br>Avant";
$langliste['fr']['admin-suivi-liste-popup']['8-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Valeur<br>Après";
$langliste['fr']['admin-suivi-liste-popup']['9-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Date";
$langliste['fr']['admin-suivi-liste-popup']['10-popup']="";

$langliste['fr']['admin-suivi-liste'][]="Heure";
$langliste['fr']['admin-suivi-liste-popup']['11-popup']="";

$langliste['fr']['admin-suivi-liste'][]="ID";
$langliste['fr']['admin-suivi-liste-popup']['12-popup']="";
//------------------------------------------------------------------------------ Module admin / Logs
$langliste['fr']['admin-log-liste'][]="Rubrique";
$langliste['fr']['admin-log-liste-popup'][]="";

$langliste['fr']['admin-log-liste'][]="User";
$langliste['fr']['admin-log-liste-popup']['2-popup']="";

$langliste['fr']['admin-log-liste'][]="IP";
$langliste['fr']['admin-log-liste-popup']['3-popup']="Adresse IP v4";

$langliste['fr']['admin-log-liste'][]="Descr. 1";
$langliste['fr']['admin-log-liste-popup']['4-popup']="";

$langliste['fr']['admin-log-liste'][]="Descr. 2";
$langliste['fr']['admin-log-liste-popup']['5-popup']="";

$langliste['fr']['admin-log-liste'][]="Tables";
$langliste['fr']['admin-log-liste-popup']['6-popup']="";

$langliste['fr']['admin-log-liste'][]="Date";
$langliste['fr']['admin-log-liste-popup']['7-popup']="";

$langliste['fr']['admin-log-liste'][]="Heure";
$langliste['fr']['admin-log-liste-popup']['8-popup']="";

$langliste['fr']['admin-log-liste'][]="ID";
$langliste['fr']['admin-log-liste-popup']['9-popup']="";

//------------------------------------------------------------------------------ Module Bugs / En-cours
$langliste['fr']['bug-encours-liste'][]="#";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Type";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Date";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Auteur";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Rubrique";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Description";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Statut";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Commentaire";
$langliste['fr']['bug-encours-liste-popup'][]="";

$langliste['fr']['bug-encours-liste'][]="Statut";
$langliste['fr']['bug-encours-liste-popup'][]="";

//------------------------------------------------------------------------------ Module Bugs / Traités
$langliste['fr']['bug-ok-liste'][]="#";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Type";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Date";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Auteur";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Rubrique";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Description";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Statut";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Commentaire";
$langliste['fr']['bug-ok-liste-popup'][]="";

$langliste['fr']['bug-ok-liste'][]="Statut";
$langliste['fr']['bug-ok-liste-popup'][]="";

//------------------------------------------------------------------------------ Module FSD


?>
