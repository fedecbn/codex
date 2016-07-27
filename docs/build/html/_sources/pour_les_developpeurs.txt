##################################
Pour les développeurs
##################################

Bienvenue sur le Wiki du Codex pour les développeurs

******************************************************
L'architecture fichier
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

=============================================
Mise à jour de l'architecture fichier
=============================================

Le Codex est un projet libre de droit, déposé sur github (http://github.com/fedecbn/codex). La mise à jour des fichiers se fait directement par l'utilisation de de git (git pull).

******************************************************
La Base de données
******************************************************

=============================
Le schema application
=============================

Le schema application est le schema utilisé par l'application pour faire la gestion des rubriques, des onglets, des utlisateurs des droits...

	`bug`

`(obsolète)` Table rassemblant tous les bugs remontés par les utilisateurs.

	`droit`
	
Table rassemblant les règles de gestion des droit. La gestion des droits est basée sur un système de rôle non hierarchisé : un rôle (`colonne role`) à accès à un objet (`colonne objet`), présent dans un onglet (`colonne onglet`) d'une rubrique particulière (`colonne rubrique`). Ces droits sont classé par type (`colonne typ_droit`), décrit dans le chapitre :ref:`nvx-droit`.

	`log`

Table rassemblant les logs généraux de l'application selon les utilisateurs (`colonne id_user` = identifiant de l'utilisateur, référentiel = applications.utilisateur).

	`onglet`

Table rassemblant la description (`colonne nom` pour le nom de l'onglet, `colonne ss_titre` pour le sous-titre de l'onglet) des différents onglets de chaque rubrique

	`pres`

Table rassemblant les textes d'en-tête (`colonne page` = 'header') et de pied de page (`colonne page` = 'footer') de la page d'acceuil (`colonne pres`)	en fonction du module (`colonne id_module`).

	`rubrique`

Table rassemblant les informations nécessaire pour l'affichage du bouton d'accès au rubrique : son identifiant (`colonne id_module`), sa position les unes par rapport aux autres (`colonne pos`), son icone de représentation (`colonne icone`), son chemin d'accès vers les fichiers (`colonne link`), son type (`colonne typ` - 'list' = rubrique classique, 'admin' = rubrique d'administration).

	`suivi`

Table rassemblant toutes les modifications réalisé dans une rubrique. A chaque enregistrement, cette table historise les valeurs anciennes et nouvelles de chaque table.

	`update_bdd`

Table rassemblant l'historique des mises à jour de la base de données. Ce système, permettant de mettre à jour la base en même temps que les mises à jour logiciels est décrit dans le chapitre :ref:`maj-bdd`.

	`utilisateur`

Table rassemblant tous les utilisateurs, leur identifiant (`colonne id_user`), leur cbn (`colonne id_cbn`), leur nom et prénom. Les colonnes `ref` et `niveau` étaient utilisées pour la gestion des droits. Ces colonnes sont obsolètes.

	`utilisateur_role`
	
Table rassemblant les rôles de chaque utilisateurs (`colonne id_user`) pour chaque rubrique (`colonne rubrique`). Chacune des autres colonnes correspondent aux rôles disponible pour cette rubrique.
	
=============================
Les schemas "rubrique"
=============================

Afin d'avoir une approche le plus modulaire possible, chaque rubrique possède son schema propre de base de données. l'architecture de ces schemas (tables, champs...) sont propre à chaque rubrique SAUF pour certaines tables, qui sont générique à chaque rubrique et que l'on retourve dans chaque schema (ayant subit une généralisation) :

	`discussion`

Table rassemblant les éléments de discussion réalisé au niveau des fiches. En bas de chaque fiche, il est possible, pour un utilisateur avec le rôle de "participant", d'ajouter un commentaire spécifique à la fiche. Dans ce cas, ce commentaire sera enregistrer dans la table `discussion` et sera affiché en bas de la fiche. Un projet de développement est de sortir centraliser ces discussions dans le schema `application`

=============================
Le schema référentiel
=============================

Le schema `référentiel` rassemble les référentiels utilisés par les rubriques. La majorité de ces référentiels ont été implémenté pour la rubrique "liste rouge" (schema `lr`). Un développement à prévoir est de rappatrier ces référetiels au sein même du schéma, pour plus de modularité. 2 tables extrèmement importantes sont présentent dans ce schema :

	`champs`
	
Table rassemblant la description de toutes les tables de toute les rubriques. Cette table permet de renseigner toutes les informations nécessaire à l'application pour afficher et gérer les champs de ces rubriques à travers, notamment, son typage personnalisé (`colonne type`), son libellé court (`colonne description`) et long (`colonne description_longue`), le référentiel auquel il est rattaché (`colonne referentiel`), sa position dans le tableau de synthèse (`colonne pos`), la taille et style de la colonne (`colonne jvs_desc_column`) et les paramètre de filtrage de la colonne (`colonne jvs_filter_column`).
	
	`champs_ref`

Table rassemblant les informations correspondantes aux référentiels utilisés par les champs. On y retrouve le nom du référentiel (`colonne nom_ref` - ce nom est totalement arbitraire), le système de clé-valeur du référentiel (`colonne cle` et `colonne valeur`), ainsi que l'endroit où le référentiel se trouve (`colonne schema` et colonne `table_ref`).
	

.. _maj-bdd:

=============================================
Mise à jour de la base de données
=============================================

La mise à jour de la base de données n'est pas automatique avec la mise à jour du code. Un procédure parallèle doit être géré à chaque mise à jour de la base.

Le fonctionnement est le suivant : 

* Création d'un fichier sql : Lors d'un développement nécesitant la mise à jour de la base de données, cette modification doit êter scripté en sql ET générique (applicable à toute les situations possibles). Ce fichier doit être inspiré des fichiers précédents.

A POURSUIVRE

Cette procédure manuelle pourrait être automatisé à chaque nouveau fichier sql ajouté (détection d'un nouveau fichier par rapport à l'historique des mise à jour).

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

.. _nvx-droit:

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