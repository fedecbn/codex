##################################
Pour les développeurs
##################################

Bienvenue sur le Wiki du Codex pour les développeurs

******************************************************
Architecture fichier du Codex
******************************************************
Voici la description du contenu de chaque dossier :

	`.git`

dossier git permettant le versionnement de l'application

	`_DATA`
	
contient les données à importer ou les données exportées (dossier EXPORTS). Aujourd'hui, les autres dossiers (alp, als, bal...) sont/peuvent être utilisés par la rubrique "Interaction avec le hub". Leur création n'est pas automatique (fonction à ajouter lors de la création d'une nouvelle ligne dans cette rubrique).

	`_GRAPH`
	
contient toutes les images utilisées par le codex.

	`_INCLUDE`

contient toutes les librairies/éléments nécessaires au fonctionnement du codex

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
   
	`_SQL`
	
fichiers SQL d'installation + fichier de mise à jour de la base avec les nouvelles versions de l'outil (update_bdd)

	`docs`

source et build de la documentation (produite avec Sphinx)

	`flore`

rubriques du codex. Les rubriques catnat, eee, fsd, hub, lr,lsi, refnat, syntaxa sont des rubriques thématiques. Elles ont été généralisé mais ne sont pas toutes au même niveau de généralisation. la rubrique bug est obsolète (pas maintenu), la rubrique commun est peu utilisée (devrait être ajouté à _INCLUDE), la rubrique default est une rubrique type,la rubrique module-admin est spécial (non généralisé). Les rubriques génériques comprennent : 

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
   

	`les autres fichiers`
	
* .gitignore: les éléments à ne pas sauvegarder lors du versionnement
* README.md : description de l'application.

******************************************************
Architecture Base de données du Codex
******************************************************

=============================
Le schema application
=============================

Le schema application est le schema utilisé par l'application pour faire la gestion des rubriques, des onglets, des utlisateurs des droits...

	`bug`

(obsolète) table rassemblant tous les bugs remontés par les utilisateurs.

	`droit`
	
La gestion des droits est basé sur un système non hierarchisé. Le principe	de base

	`xxx`

	`xxx`

	`xxx`

	`xxx`
	
	`xxx`
	
	`xxx`
	
	`xxx`
	
	`xxx`
	
	`xxx`
	
	`xxx`
	
=============================
Les schemas "rubrique"
=============================

=============================
Le schema référentiel
=============================

******************************************************
Comment créer une nouvelle rubrique?
******************************************************
Aujourd'hui, le processus de création de rubrique est encore manuel.
Une des améliorations possible serait que l'administration des rubriques soient directement intérefacées dans le codex (dans la partie administration).

Actuellement, pour créer une nouvelle rubrique il faut :

* lancez les scripts sql du fichier _DATA/fonctions.sql. Ce script créé plusieurs fonction pl/pgsql pour créer des rubriques.
* utilisez la fonction new_rubrique en choisissant le nom de la rubrique que vous souhaitez créer (ex : SELECT * FROM new_rubrique('toto'); ==> un nouveau schema 'toto' est créé)
* dupliquez le dossier "defaut" et renommez-le avec le nom du schéma créé ce dessus (ex : 'toto'). ATTENTION : le nom doit être exactement identique.


******************************************************
Gestion des droits
******************************************************

La gestion des droits est basée sur un système non hierarchisé de rôle pour chaque utilisateur. Chaque rôle a droit ou non d'accéder à des objets dans une rubrique. Ces droits sont classé par type de droit, appelé également niveaux de droits (droit d'accès à une page, droit d'accès à un bouton...).

===============================
Les niveaux de droits
===============================
Les niveaux de droits, ou type de droit, sont une manière de faciliter la gestion globale des droits. On distingue les niveaux suivant  :

* **d1** : droit d'accès aux fichiers. Ce type de droit permet de définir quel role peut accéder à quel fichier fichier. Dans ce cas, l'objet est le fichier,
* **d2** : droit d'accès aux objets de la rubrique. Ce type de droit permet de définir quel rôle peut accéder à quel objet d'une rubrique. Dans ce cas, l'objet peut être un bouton, une image...,
* **d3** : droit d'accès spécifique à l'utilisateur. Ce type de droit permet de définir, en fonction de l'utilisateur, quel accès il possède (ex : dans la partie "administration > utilisateurs", un CBN ne peut voir que les utilisateurs de son CBN),
* **d4** : droit d'accès à une champ. Ce type de droit permet de définir quel rôle peut, dans une fiche, modifier un champ. Dans le cas contraire, le champ sera bloqué,
* **d5** : droit de modification de la base. Ce type de droit permet de définir sur quel rôle a le droit de modifier la base de données (ajout, modification, suppression).

A ce jour, seulement les niveaux de droit d1 et d2 ont été mis en place.

===============================
Les rôles
===============================

Pour chaque rubrique, l'utilisateur possède un ou plusieurs rôles. Le rôle par défaut d'un utilsateur à sa création est "pas d'accès" (en base de donnéées, "pas d'accès" = TRUE). Un utilisateur qui a accès à une rubrique a au moins un rôle activé (en base de données "`nom_du_role` = TRUE") ET la colonne "pas d'acces" = FALSE. La gestion des rôle pour chaque utilisateur est géré, dans la base de données, dans la table **utilisateur_role**.

===============================
Définir les droits
===============================

Au sein de la base de données, la table **droit** fait le lien entre les rôles et les niveaux de droit. Ainsi, il est possible de définir dans cette table quel rôle a accès à quel droit sur tel objet d'une rubrique. Aujourd'hui, la gestion de la définition des droits n'a pas été interfacé avec le codex (gestion direct en base de données).

* Ajouter une règle d'accès

La première étape lors pour définir les droits est de se poser la question de "quel rôle aura le droit de réaliser cette action?". En répondant à cette question, il est alors possible de rajouter une ligne dans la table droit qui correspond à la réponse à cette question. Ensuite, il est possible d'accèder à cette nouvelle règle en utilisant dans le code à la fonction **ref_droit**.

* Ajouter des rôles

La gestion des droits n'étant pas hierarchisée, il est possible d'ajouter des rôles en fonction du besoin dans le cas où les rôles existants ne suffisent pas. Ex : ajout du rôle de validateur. Pour se faire, il est nécessaire d'ajouter une colonne à la table **utilisateur_role** et d'attribuer le rôle correspondant aux utilisateurs. Les règles correspondantes à ce nouveau rôle devront être décrit dans la table **droit**


************************************************************************************************************
Comment paramétrer les tableaux de synthèse?
************************************************************************************************************


******************************************************
Comment gérer les fiches?
******************************************************


******************************************************
Comment ajouter de nouveaux onglets?
******************************************************