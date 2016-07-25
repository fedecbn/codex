##################################
Pour les développeurs
##################################

Bienvenue sur le Wiki du Codex pour les développeurs

******************************************************
Architecture du Codex
******************************************************
Voici la description du contenu de chaque dossier :
- .git
- _DATA: contient les données à importer ou les données exportées (dossier EXPORTS). Aujourd'hui, les autres dossiers (alp, als, bal...) sont/peuvent être utilisés par la rubrique "Interaction avec le hub". Leur création n'est pas automatique (fonction à ajouter lors de la création d'une nouvelle ligne dans cette rubrique).
- _GRAPH : contient toutes les images utilisées par le codex.
- _INCLUDE : contient toutes les librairies/éléments nécessaires au fonctionnement du codex
	- css : tous les CSS (NB : toute la configuration du css est majoritairement géré par eval.css)
	- font : tous les éléments de polices
	- js : tous les javascripts externes (jquery,datatable,wysiwyg...) et les javascripts maison.
		- fiche.js : xxx
		- functions.js : xxx
		- gestion.js : xxx
		- interact.js : xxx
		- liste.js : xxx
	- admin.lang.php : Gestion de la traduction anglais / français ($lang)
	- common.lang.php : Définition des variables de label + italien ($lang)
	- config_sql.inc.php : Paramètre de connexion aux bases de données + data path
	- connector.php : Controleur d'accès
	- constants.inc.php : Gestion des constantes
	- fonctions.inc.php : Fonctions php utilisées par le Codex.
- _SQL : xxx
- docs : xxx
- flore : xxx
- .gitignore: xxx
- index.php: xxx
- README.md : xxx

	
******************************************************
Quelques fichiers particuliers
******************************************************

========================================
Fichiers Javascript
========================================
Fichiers maisons :


******************************************************
Comment créer une nouvelle rubrique?
******************************************************
Processus encore manuel qui sera intégrer à terme dans le codex (dans la partie administration)
- lancez les scripts sql du fichier _DATA/fonctions.sql
- utilisez la fonction new_rubrique ==> un nouveau schema est créé
- dupliquez le dossier _base_module et renommez le avec le nom du schéma créé ce dessus.

************************************************************************************************************
Comment paramétrer les tableaux de synthèse?
************************************************************************************************************

******************************************************
Comment gérer les fiches?
******************************************************

******************************************************
Comment ajouter de nouveaux onglets?
******************************************************