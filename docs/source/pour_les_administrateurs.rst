##############################
Pour les administrateurs
##############################
Bienvenue sur le Wiki du Codex pour les administrateurs. Cette documentation est pour objectif de donner des éléments de compréhension pour faciliter l'installation et la manipulation de l'outil Codex par des administrateurs souhaitant s'en emparer.

******************************************************
Pourquoi utiliser l'outil Codex?
******************************************************
L'outil Codex est une application web permettant le partage et l'évolution de données de manière centralisée, collaborative et en conservant l'historique. On peut comparer l'outil avec google-sheets (tableur en ligne collaboratif) avec les avantages (et inconvénients ^^) de pouvoir gérer une **base de données relationnelle** derrière l'application (import/export de données, traitement des données...) et de manipuler du **javascript** pour faciliter la gestion des formulaires.

De plus, l'outil possède des fonctionnalités supplémentaires : 
- la gestion des droits d'accès (gestion de compte et de différents niveaux de droits),
- la gestion d'un historique des modifications (vision globale *et spécifique en développement*),
- la remonté de bugs en interne à l'application (*garder dans les prochaines version ou centraliser sur github?*),
- un système de notification permettant de prévenir au besoin des utilisateurs quand cela est nécessaire (récupération du mot de passe, modification sur certaines fiches...)

************************************************************************************************************
Qu'est ce qu'il y a derrière l'outil Codex
************************************************************************************************************
L'outil est une plateforme web développé en php utilisant des librairies javascript (jQuery, dataTable) connecté à un serveur de données PostgreSQL.


************************************************************************************************************
Comment installer l'outil codex?
************************************************************************************************************
==========================
Pré-requis
==========================
  * Apache (minimum 2.4.9)
  * Php (minimum 5.5 min)
  * Postgresql (minimum 9.1 )

====================================================
Mise en oeuvre
====================================================
  - Téléchargez le contenu du repository en local (ou sur votre serveur),
  - Lancez votre serveur web si vous travaillez en local,
  - Vérifiez la configuration du serveur web
  
    - activez les extensions php_pgsql et php_pdo_pgsql
    - XXX

  - accédez à la racine du projet. Vous serez redirigé automatiquement sur la page ./flore/home/install.php.,
  - suivez les instructions et cliquez sur "lancez l'installation". La base de données sera créée et l'outil paramétré.

NB : vous pouvez avoir un problème de memory_limit_size ==> allez dans php.ini et augmenter là.

************************************************************************************************************
Gestion des utilisateurs
************************************************************************************************************
====================================================
Créer un utilisateur
====================================================
Un administrateur peut créer simplement un utilisateur à partir de du bouton "Ajouter" de l'onglet "Utilisateur" dans la partie "Administration". Il peut également faire le choix de charger une liste d'utilisateur directement dans la base de données.

====================================================
Les droits utilisateurs
====================================================
Le niveau de droit dépend du rôle de l'utilisateur. Voici un tableau qui résume les rôles proposés et les droits correspondants.

================     ================================================================================================================================================================================================
Rôle                 Droits correspondants
================     ================================================================================================================================================================================================
Pas d'accès          l'utilisateur n'a pas accès à la rubrique concernée (la rubrique ne s'affiche pas)
Lecteur              l'utilisateur a accès à la rubrique concernée en lecture (il ne peut pas interagir)
Participant          l'utilisateur a les droits "Lecteur" + la possibilité de laisser des commentaires dans les fiches
Évaluateur           L'utilisateur a les droits "participant" + la possibilité de participer aux évaluations, ajouter des actualités dans la LSI (droits d'édition)
================     ================================================================================================================================================================================================

====================================================
Les référents
====================================================
Un référent est un utilisateur qui a des droits d'administration supplémentaires. Il peut ajouter des comptes utilisateurs pour l'organisme auquel il appartient. Il peut également modifier les droits d'accès des utilisateurs qui le souhaitent. Pour ce faire, il peut donner un niveau de droit inférieur ou égal au sien (par exemple, un "référent" sur la rubrique "Liste rouge" qui a un rôle de participant sur cette rubrique peut nommer d'autres "utilisateur" en tant que "participant", "Lecteur" ou peut également couper l'accès ("Pas d'accès").

************************************************************************************************************
Charger des données dans une rubrique
************************************************************************************************************

************************************************************************************************************
Comment remonter les bugs et nouvelles demandes?
************************************************************************************************************
Il est préconisé d'utiliser la page Github du Codex pour faire remonter les bugs et nouvelles demandes

************************************************************************************************************
Mettre à jour le codex avec les derniers développements
************************************************************************************************************
Le développement du Codex se fait continuellement. Ainsi, il peut être intéressant de mettre à jour celui-ci pour profiter des dernières fonctionnalités et des dernières correstions de bugs.
Pour se faire, 2 étapes sont nécessaires :
  
  - Mettre à jour le code
  - Mettre à jour la base de données
  
=================================
Mise à jour du code
=================================
Il est conseillé d'utiliser git et github pour rester faciliter les mises à jour de l'outil.
Ainsi, un simple "git pull" permet de mettre à jour le code dans sa dernière version.

=================================
Mise à jour de la base de données
=================================
La base de données peut subir des modifications  entre 2 mises à jour de l'outil.
Pour chaque modification nécessitant une mise  jour de la base de données, un fichier SQL sera disponible dans le dossier "_SQL/update_bdd".
La table "application.update_bdd" recence les dernières mises à jours qui ont été appliquées à la base de données.
Pour s'assurer que les mises à jour ont bien été réalisée :

  * Vérifiez le numéro de la dernière mise à jour dans la table "application.update_bdd"
  * Comparez avec le plusgrand numéro présent dans le dossier "_SQL/update_bdd"
  
Il vous faudra alors lancer tous les fichiers SQL dont le nom se situe entre ces deux numéros.
