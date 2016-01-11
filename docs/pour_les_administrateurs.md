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

# Comment installer l'outil codex?
## Pré-requis
* Apache (min 2.4.9)
* Php (min 5.5 min)
* Postgresql (min 9.1 )

## Mise en oeuvre
Une fois le repository installé en local (ou sur votre serveur), accédez à la racine du projet. Vous serez redirigé sur la page install.php. Suivez les instructions et cliquez sur "lancez l'installation". La base de données sera créée et l'outil paramétré.

NB : vous pouvez avoir un problème de memory_limit_size ==> allez dans php.ini et augmenter là.

# Comment charger des référentiels?

# Comment gérer les utilisateurs et droits d'accès?

# Comment remonter un bug?

