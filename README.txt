Pour installer le CODEX sur un poste en local
1- clonez le depot git
git clone ssh://[USER]@94.23.218.10:10022/home/gitsrc/codex.git [OUTPUT_PATH]
git clone ssh://oliviergavotto@94.23.218.10:10022/home/gitsrc/codex.git oliviergavotto

2- cr�ez la base de donn�es en local
CREATE DATABASE codex WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'French_France.1252' LC_CTYPE = 'French_France.1252';

3- connectez vous � la base codex et appliquez les modifications n�cessaire � cette base de donn�es gr�ce au fichier _DATA/bdd_codex.sql

4- transformez config_sql.inc.example.php en config_sql.inc.php (lieu de gestion des param�tre de connexion)