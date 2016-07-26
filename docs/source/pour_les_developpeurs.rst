##################################
Pour les développeurs
##################################

Bienvenue sur le Wiki du Codex pour les développeurs

******************************************************
Architecture du Codex
******************************************************
Voici la description du contenu de chaque dossier :

* .git : dossier git permettant le versionnement de l'application
* _DATA : contient les données à importer ou les données exportées (dossier EXPORTS). Aujourd'hui, les autres dossiers (alp, als, bal...) sont/peuvent être utilisés par la rubrique "Interaction avec le hub". Leur création n'est pas automatique (fonction à ajouter lors de la création d'une nouvelle ligne dans cette rubrique).
* _GRAPH : contient toutes les images utilisées par le codex.
* _INCLUDE : contient toutes les librairies/éléments nécessaires au fonctionnement du codex

   * css : tous les CSS (NB : toute la configuration du css est majoritairement géré par eval.css)
   * font : tous les éléments de polices
   * js : tous les javascripts externes (jquery,datatable,wysiwyg...) et les javascripts maison.
   
      * gestion.js : (obsolète) ancien fichier javascript qui rassemblait tous les fichier suivant
      * fiche.js : boutons et interactions avec les fiches (génériques aux rubriques)
      * functions.js : fonctions génériques javascripts (export, suppression, validation...)
      * interact.js : boutons et interactions avec les tableaux de synthèse (génériques aux rubriques)
      * liste.js : interaction avec la liste
	
   * admin.lang.php : Gestion de la traduction anglais / français ($lang)
   * common.lang.php : Définition des variables de label + italien ($lang)
   * config_sql.inc.php : Paramètre de connexion aux bases de données + data path
   * connector.php : Controleur d'accès
   * constants.inc.php : Gestion des constantes
   * fonctions.inc.php : Fonctions php utilisées par le Codex.
   
* _SQL : fichiers SQL d'installation + fichier de mise à jour de la base avec les nouvelles versions de l'outil (update_bdd)
* docs : source et build de la documentation (produite avec Sphinx)
* flore : rubriques du codex. 
  
   * les rubriques catnat, eee, fsd, hub, lr,lsi, refnat, syntaxa sont des rubriques thématiques. Elles ont été généralisé mais ne sont pas toutes au même niveau de généralisation. Elles comprennent : 
   * commun.inc.php : 
   
      * initialise et fait le lien avec toutes les bibliothèques nécessaire (_INCLUDE)
      * définit un certain nombre de constantes
      * détermine les requêtes SQL globales (requête du tableau de synthèse, requête d'export, requête de discussion...)
      * label spécifiques (boutons ajouter, titres...)
      * construction des en-tête de colonne
	
   * del.php : utilisé lors de suppression
   * index.php : interface principale
   * liste.php (et parfois liste_user) = json avec toutes les données du tableau de synthèse
   * submit.php : utilisé lors de l'enregistrement
   * Les autres rubriques :
   
      * la rubrique bug est obsolète (pas maintenu), 
      * la rubrique commun est peu utilisée (devrait être ajouté à _INCLUDE), 
      * la rubrique default est une rubrique type,
      * la rubrique module-admin est spécial (non généralisé)
   
* .gitignore: les éléments à ne pas sauvegarder lors du versionnement
* README.md : description de l'application.


******************************************************
Comment créer une nouvelle rubrique?
******************************************************
Aujourd'hui, le processus de création de rubrique est encore manuel.
Une des améliorations possible serait que l'administration des rubriques soient directement intérefacées dans le codex (dans la partie administration).

Actuellement, pour créer une nouvelle rubrique il faut :

* lancez les scripts sql du fichier _DATA/fonctions.sql. Ce script créé plusieurs fonction pl/pgsql pour créer des rubriques.
* utilisez la fonction new_rubrique en choisissant le nom de la rubrique que vous souhaitez créer (ex : SELECT * FROM new_rubrique('toto'); ==> un nouveau schema 'toto' est créé)
* dupliquez le dossier "defaut" et renommez-le avec le nom du schéma créé ce dessus (ex : 'toto'). ATTENTION : le nom doit être exactement identique.

************************************************************************************************************
Comment paramétrer les tableaux de synthèse?
************************************************************************************************************


******************************************************
Comment gérer les fiches?
******************************************************


******************************************************
Comment ajouter de nouveaux onglets?
******************************************************