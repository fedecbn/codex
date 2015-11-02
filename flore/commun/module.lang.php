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

//------------------------------------------------------------------------------ Module gestion LR
$langliste['fr']['lr'][]="Etape";
$langliste['fr']['lr-popup'][]="Étapes de l'évaluation";

$langliste['fr']['lr'][]="Famille";
$langliste['fr']['lr-popup'][]="";

$langliste['fr']['lr'][]="CD_REF";
$langliste['fr']['lr-popup'][]="Code du taxon de référence";

$langliste['fr']['lr'][]="Nom scien";
$langliste['fr']['lr-popup'][]="Nom scientifique du taxon";

$langliste['fr']['lr'][]="Rang";
$langliste['fr']['lr-popup'][]="Rang taxonomique du taxon";

// $langliste['fr']['lr'][]="Nom vern";
// $langliste['fr']['lr-popup'][]="Nom vernaculare du taxon";

$langliste['fr']['lr'][]="Indig.";
$langliste['fr']['lr-popup'][]="Statut d'indigénat du taxon en métropole";

$langliste['fr']['lr'][]="Endém";
$langliste['fr']['lr-popup'][]="Endémisme du taxon en métropole";

$langliste['fr']['lr'][]="AOO";
$langliste['fr']['lr-popup'][]="Zone d'occupation estimée après 1990_2x2";

$langliste['fr']['lr'][]="AOO<br>tot";
$langliste['fr']['lr-popup'][]="Zone d'occupation ajustée après 1990 pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes";

$langliste['fr']['lr'][]="Nb loc.";
$langliste['fr']['lr-popup'][]="Nb de localités >= 1990";

$langliste['fr']['lr'][]="Nb mailles<br> >1990";
$langliste['fr']['lr-popup'][]="Nombre de mailles 5km²>=1990 ajustée pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes";

/*
$langliste['fr']['lr'][]="AOO<br>précis";
$langliste['fr']['lr-popup'][]="Zone d'occupation  ajustée après 1990 pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes";

$langliste['fr']['lr'][]="AOO<br>plage";
$langliste['fr']['lr-popup'][]="Zone d'occupation  ajustée après 1990 pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes";

$langliste['fr']['lr'][]="Nb loc.<br>précis";
$langliste['fr']['lr-popup'][]="Nb de localités>=1990";

$langliste['fr']['lr'][]="Nb loc.<br>plage";
$langliste['fr']['lr-popup'][]="Nb de localités>=1990";

$langliste['fr']['lr'][]="Nb mailles >=1990 Expert";
$langliste['fr']['lr-popup'][]="Nombre de mailles 5km²>=1990 ajustée pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes";

$langliste['fr']['lr'][]="Nb mailles >=1990";
$langliste['fr']['lr-popup'][]="Nombre de mailles 5km²>=1990 à partir du SI";
*/
$langliste['fr']['lr'][]="Cat<br>A";
$langliste['fr']['lr-popup'][]="Catégorie la plus élevée selon le critère A";

// $langliste['fr']['lr'][]="Justif<br>A";
// $langliste['fr']['lr-popup'][]="Justification du critère A";

$langliste['fr']['lr'][]="Cat<br>B2";
$langliste['fr']['lr-popup'][]="Catégorie la plus élévee selon le critère B2";

// $langliste['fr']['lr'][]="Justif<br>B2";
// $langliste['fr']['lr-popup'][]="Justification du critère B2";

$langliste['fr']['lr'][]="Cat<br>C";
$langliste['fr']['lr-popup'][]="Catégorie la plus élévee selon le critère C";

// $langliste['fr']['lr'][]="Justif<br>C";
// $langliste['fr']['lr-popup'][]="Justification du critère C";

$langliste['fr']['lr'][]="Cat<br>D";
$langliste['fr']['lr-popup'][]="Catégorie la plus élévee selon le critère D";

// $langliste['fr']['lr'][]="Justif<br>D";
// $langliste['fr']['lr-popup'][]="Justification du critère D";

// $langliste['fr']['lr'][]="Menace";
// $langliste['fr']['lr-popup'][]="Menace directe";

$langliste['fr']['lr'][]="Cat<br>Fin";
$langliste['fr']['lr-popup'][]="Catégorie proposée pour la Liste rouge nationale après ajustement";

$langliste['fr']['lr'][]="Crit<br>Fin";
$langliste['fr']['lr-popup'][]="Critère(s) proposé(s) pour la Liste rouge nationale";

$langliste['fr']['lr'][]="Cat<br>EU";
$langliste['fr']['lr-popup'][]="Catégorie UICN à l'échelle de l'Europe géographique";

$langliste['fr']['lr'][]="Cat<br>Synthèse region";
$langliste['fr']['lr-popup'][]="Synthèse des Catégories UICN issue des évaluations régionales";

$langliste['fr']['lr'][]="Nb region<br>eval";
$langliste['fr']['lr-popup'][]="Nombre de régions ayant une évaluation régionale pour ce taxon";

$langliste['fr']['lr'][]="Note Explic";
$langliste['fr']['lr-popup'][]="Notes explicative l'évaluation";

// $langliste['fr']['lr'][]="Notes";
// $langliste['fr']['lr-popup'][]="Notes concernant l'évaluation";

// $langliste['fr']['lr'][]="Validation";
// $langliste['fr']['lr-popup'][]="";

$langliste['fr']['lr'][]="Avancement";
$langliste['fr']['lr-popup'][]="";

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


//------------------------------------------------------------------------------ Module gestion LSI 
$langliste['fr']['lsi'][]="Id";
$langliste['fr']['lsi-popup'][]="Identifiant";

$langliste['fr']['lsi'][]="Thématique";
$langliste['fr']['lsi-popup'][]="Thématique de la news";

$langliste['fr']['lsi'][]="Titre";
$langliste['fr']['lsi-popup'][]="Titre de la news";

$langliste['fr']['lsi'][]="Extrait";
$langliste['fr']['lsi-popup'][]="Extrait de la news";

$langliste['fr']['lsi'][]="Mots clés";
$langliste['fr']['lsi-popup'][]="Mots clés";

$langliste['fr']['lsi'][]="Lien";
$langliste['fr']['lsi-popup'][]="Lien hypertexte";

$langliste['fr']['lsi'][]="Lien 2";
$langliste['fr']['lsi-popup'][]="Lien hypertexte 2";

$langliste['fr']['lsi'][]="Date";
$langliste['fr']['lsi-popup'][]="Date de publication";

//------------------------------------------------------------------------------ Module flore / _base_module
$langliste['fr']['catnat'][]="CD REF";
$langliste['fr']['catnat-popup'][]="CD REF";

$langliste['fr']['catnat'][]="Famille";
$langliste['fr']['catnat-popup'][]="Famille";

$langliste['fr']['catnat'][]="Nom scientifique";
$langliste['fr']['catnat-popup'][]="Nom scientifique";

$langliste['fr']['catnat'][]="Rang";
$langliste['fr']['catnat-popup'][]="Rang";

$langliste['fr']['catnat'][]="Nom vernaculaire";
$langliste['fr']['catnat-popup'][]="Nom vernaculaire";

$langliste['fr']['catnat'][]="Hybride";
$langliste['fr']['catnat-popup'][]="Hybride";

$langliste['fr']['catnat'][]="Indigénat";
$langliste['fr']['catnat-popup'][]="Indigenat";

$langliste['fr']['catnat'][]="Liste Rouge";
$langliste['fr']['catnat-popup'][]="Liste Rouge";

// $langliste['fr']['catnat'][]="Just Liste Rouge";
// $langliste['fr']['catnat-popup'][]="Justification Liste Rouge";

$langliste['fr']['catnat'][]="Rareté";
$langliste['fr']['catnat-popup'][]="Rareté";

$langliste['fr']['catnat'][]="Endemisme";
$langliste['fr']['catnat-popup'][]="Endemisme";
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

//------------------------------------------------------------------------------ Module flore / eee

// $langliste['fr']['eee'][]="Etape";
// $langliste['fr']['eee-popup'][]="Étapes de l'évaluation";

$langliste['fr']['eee'][]="CD_REF";
$langliste['fr']['eee-popup'][]="Code du taxon de référence";

$langliste['fr']['eee'][]="Nom scientifique ";
$langliste['fr']['eee-popup'][]="Nom scientifique du taxon";

$langliste['fr']['eee'][]="Rang";
$langliste['fr']['eee-popup'][]="Rang taxonomique du taxon";

// $langliste['fr']['eee'][]="Nom vern";
// $langliste['fr']['eee-popup'][]="Nom vernaculare du taxon";

$langliste['fr']['eee'][]="Presence FR";
$langliste['fr']['eee-popup'][]="Présence du taxon en métropole";

$langliste['fr']['eee'][]="EEE FR";
$langliste['fr']['eee-popup'][]="Mention EEE avérée";

$langliste['fr']['eee'][]="Lavergne FR";
$langliste['fr']['eee-popup'][]="Echelle de Lavegne";

$langliste['fr']['eee'][]="Risque d'introduction";
$langliste['fr']['eee-popup'][]="Risques d’introduction et d’installation (Biogéographie)";

$langliste['fr']['eee'][]="Risque de propagation";
$langliste['fr']['eee-popup'][]="Risques de propagation (Naturalisation et dynamisme)";

$langliste['fr']['eee'][]="Risque d'impact";
$langliste['fr']['eee-popup'][]="Risques d’impact (comportement ailleurs et habitats colonisés)";

$langliste['fr']['eee'][]="Score Weber";
$langliste['fr']['eee-popup'][]="Score de Weber";

$langliste['fr']['eee'][]="Evaluation Weber";
$langliste['fr']['eee-popup'][]="Risque global";

$langliste['fr']['eee'][]="Fiabilité Weber";
$langliste['fr']['eee-popup'][]="Fiabilité globale";

$langliste['fr']['eee'][]="Liste Pcp/annexe";
$langliste['fr']['eee-popup'][]="Appartenance à une liste";

$langliste['fr']['eee'][]="Carac. emergent";
$langliste['fr']['eee-popup'][]="Caractère émergent";

$langliste['fr']['eee'][]="Carac. avéré";
$langliste['fr']['eee-popup'][]="Caractère avéré";

$langliste['fr']['eee'][]="Evaluation experte";
$langliste['fr']['eee-popup'][]="Evaluation experte";

$langliste['fr']['eee'][]="Carte GBIF";
$langliste['fr']['eee-popup'][]="Carte GBIF – distribution modélisée";

// $langliste['fr']['eee'][]="uid";
// $langliste['fr']['eee-popup'][]="identifiant unique";

//------------------------------------------------------------------------------ Module flore / _base_module
$langliste['fr']['refnat'][]="Cdnom";
$langliste['fr']['refnat-popup'][]="CD NOM";

$langliste['fr']['refnat'][]="Cdref";
$langliste['fr']['refnat-popup'][]="CD REF";

$langliste['fr']['refnat'][]="Nom complet";
$langliste['fr']['refnat-popup'][]="Nom complet";

$langliste['fr']['refnat'][]="Rang";
$langliste['fr']['refnat-popup'][]="Rang";

$langliste['fr']['refnat'][]="Famille";
$langliste['fr']['refnat-popup'][]="Famille";

$langliste['fr']['refnat'][]="Groupe taxo";
$langliste['fr']['refnat-popup'][]="Groupe taxonomique systématique / fonctionnel";

$langliste['fr']['refnat'][]="Biogéo";
$langliste['fr']['refnat-popup'][]="Statut biogéographique en France métropolitaine";

$langliste['fr']['refnat'][]="v2";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v2";

$langliste['fr']['refnat'][]="v3";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v3";

$langliste['fr']['refnat'][]="v4";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v4";

$langliste['fr']['refnat'][]="v5";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v5";

$langliste['fr']['refnat'][]="v6";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v6";

$langliste['fr']['refnat'][]="v7";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v7";

$langliste['fr']['refnat'][]="v8";
$langliste['fr']['refnat-popup'][]="Présent dans TAXREF v8";

$langliste['fr']['refnat'][]="Modif";
$langliste['fr']['refnat-popup'][]="Proposition de modifications réalisée";


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
$langliste['fr']['fsd'][]="Id";
$langliste['fr']['fsd-popup'][]="Identifiant";

$langliste['fr']['fsd'][]="Version";
$langliste['fr']['fsd-popup'][]="Version";

$langliste['fr']['fsd'][]="Module";
$langliste['fr']['fsd-popup'][]="Module";

$langliste['fr']['fsd'][]="Sous-module";
$langliste['fr']['fsd-popup'][]="Sous-module";

$langliste['fr']['fsd'][]="Code";
$langliste['fr']['fsd-popup'][]="Code";

$langliste['fr']['fsd'][]="Libellé";
$langliste['fr']['fsd-popup'][]="Libellé";

$langliste['fr']['fsd'][]="Description";
$langliste['fr']['fsd-popup'][]="Description";

$langliste['fr']['fsd'][]="Format";
$langliste['fr']['fsd-popup'][]="Format";

$langliste['fr']['fsd'][]= "oDATA";
$langliste['fr']['fsd-popup'][]="Obligation DATA";

$langliste['fr']['fsd'][]= "oTAXA";
$langliste['fr']['fsd-popup'][]="Obligation TAXA";

$langliste['fr']['fsd'][]= "oSYNDATA";
$langliste['fr']['fsd-popup'][]="Obligation SYNDATA";

$langliste['fr']['fsd'][]= "oSYNTAXA";
$langliste['fr']['fsd-popup'][]="Obligation SYNTAXA";

$langliste['fr']['fsd'][]="Voca Ctrl";
$langliste['fr']['fsd-popup'][]="Voca Ctrl";

$langliste['fr']['fsd'][]="Règle Renseignement";
$langliste['fr']['fsd-popup'][]="Règle Renseignement";

$langliste['fr']['fsd'][]="Exemple";
$langliste['fr']['fsd-popup'][]="Exemple";


?>
