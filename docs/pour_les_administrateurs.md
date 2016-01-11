# Pour les administrateurs

Bienvenue sur le Wiki du Codex pour les administrateurs. Cette documentation est pour objectif de donner des éléments de compréhension pour faciliter l'installation et la manipulation de l'outil Codex par des administrateurs souhaitant s'en emparer.

# Pourquoi utiliser l'outil Codex?
L'outil Codex est une application web permettant le partage et l'évolution de données de manière centralisée, collaborative et en conservant l'historique. On peut comparer l'outil avec google-sheets (tableur en ligne collaboratif) avec les avantages (et inconvénients ^^) de pouvoir gérer une **base de données relationnelle** derrière l'application (import/export de données, traitement des données...) et de manipuler du **javascript** pour faciliter la gestion des formulaires.

De plus, l'outil possède des fonctionnalités supplémentaires : 
- la gestion des droits d'accès (gestion de compte et de différents niveaux de droits),
- la gestion d'un historique des modifications (vision globale *et spécifique en développement*),
- la remonté de bugs en interne à l'application (*garder dans les prochaines version ou centraliser sur github?*),
- un système de notification permettant de prévenir au besoin des utilisateurs quand cela est nécessaire (récupération du mot de passe, modification sur certaines fiches...)

# Qu'est ce qu'il y a derrière l'outil Codex
L'outil est une plateforme web développé en php utilisant des librairies javascript (jQuery, dataTable) connecté à un serveur de données PostgreSQL.


# Comment installer l'outil codex?
## Pré-requis
* Apache (minimum 2.4.9)
* Php (minimum 5.5 min)
* Postgresql (minimum 9.1 )

## Mise en oeuvre
- Téléchargez le contenu du repository en local (ou sur votre serveur),
- Lancez votre serveur web si vous travaillez en local,
- Vérifiez la configuration du serveur web
 - activez les extensions php_pgsql et php_pdo_pgsql
 - XXX
- accédez à la racine du projet. Vous serez redirigé automatiquement sur la page ./flore/home/install.php.,
- suivez les instructions et cliquez sur "lancez l'installation". La base de données sera créée et l'outil paramétré.

NB : vous pouvez avoir un problème de memory_limit_size ==> allez dans php.ini et augmenter là.

# Gestion des utilisateurs
## Créer un utilisateur

## Les droits utilisateurs

## Les référents


# Charger des données dans une rubrique

# Comment remonter un bug?

