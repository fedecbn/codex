CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE id_rubrique varchar;
DECLARE id_onglet varchar;
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
---------------------------------------------
-- Création des nouvealles tables pour la gestion des droits
-- Si un rôle est ajouté, il suffit de rajouter une colonne à cette table
---------------------------------------------
DROP TABLE IF EXISTS applications.utilisateur_role;
CREATE TABLE applications.utilisateur_role (
id_user character varying NOT NULL,
rubrique character varying NOT NULL,
no_acces boolean DEFAULT FALSE,
lecteur boolean DEFAULT FALSE,
participant boolean DEFAULT FALSE,
evaluateur boolean DEFAULT FALSE,
gestionnaire boolean DEFAULT FALSE,
validateur boolean DEFAULT FALSE,
administrateur boolean DEFAULT FALSE,
referent boolean DEFAULT FALSE,
CONSTRAINT user_role_pk PRIMARY KEY (id_user,rubrique)
);
GRANT ALL ON TABLE applications.utilisateur_role TO pg_user;
---------------------------------------------
-- C'est ici que l'on fait le lien entre le rôle et le droit (booleen = ce type d'utilisateur a ce type de droit pour cet objet dans cette rubrique).
---------------------------------------------
DROP TABLE IF EXISTS applications.droit;
CREATE TABLE applications.droit (
id_droit serial NOT NULL,
typ_droit character varying NOT NULL,
rubrique character varying NOT NULL,
onglet character varying,
objet character varying,
role character varying NOT NULL,
CONSTRAINT droit_pk PRIMARY KEY (id_droit)
);
GRANT ALL ON TABLE applications.droit TO pg_user;
---------------------------------------------
--- Transfert des droits anciens vers le nouveau modèle
---------------------------------------------
FOR id_rubrique IN SELECT id_module FROM applications.rubrique WHERE typ = 'list' AND id_module <> 'syntaxa' LOOP
EXECUTE '
INSERT INTO applications.utilisateur_role (id_user, rubrique) SELECT id_user, '''||id_rubrique||''' FROM applications.utilisateur;
UPDATE applications.utilisateur_role SET no_acces = TRUE WHERE rubrique = '''||id_rubrique||''' AND id_user IN (SELECT id_user FROM applications.utilisateur WHERE niveau_'||id_rubrique||' =0); 
UPDATE applications.utilisateur_role SET lecteur = TRUE WHERE rubrique = '''||id_rubrique||''' AND id_user IN (SELECT id_user FROM applications.utilisateur WHERE niveau_'||id_rubrique||' =1); 
UPDATE applications.utilisateur_role SET participant = TRUE WHERE rubrique = '''||id_rubrique||''' AND id_user IN (SELECT id_user FROM applications.utilisateur WHERE niveau_'||id_rubrique||' =64); 
UPDATE applications.utilisateur_role SET evaluateur = TRUE WHERE rubrique = '''||id_rubrique||''' AND id_user IN (SELECT id_user FROM applications.utilisateur WHERE niveau_'||id_rubrique||' =128); 
UPDATE applications.utilisateur_role SET gestionnaire = TRUE WHERE rubrique = '''||id_rubrique||''' AND id_user IN (SELECT id_user FROM applications.utilisateur WHERE niveau_'||id_rubrique||' =255); 
UPDATE applications.utilisateur_role SET administrateur = TRUE WHERE rubrique = '''||id_rubrique||''' AND id_user IN (SELECT id_user FROM applications.utilisateur WHERE niveau_'||id_rubrique||' =512); 
UPDATE applications.utilisateur_role SET referent = TRUE WHERE rubrique = '''||id_rubrique||''' AND id_user IN (SELECT id_user FROM applications.utilisateur WHERE ref_'||id_rubrique||' IS TRUE); 
';
END LOOP;
INSERT INTO applications.utilisateur_role (id_user, rubrique,lecteur) SELECT id_user, 'home', true FROM applications.utilisateur;
INSERT INTO applications.utilisateur_role (id_user, rubrique,lecteur) SELECT id_user, 'module_admin', true FROM applications.utilisateur;
INSERT INTO applications.utilisateur_role (id_user, rubrique,lecteur) SELECT id_user, 'bugs', true FROM applications.utilisateur;


---------------------------------------------
--- Droit d1 : Accès à la page
---------------------------------------------
FOR id_rubrique IN SELECT id_module FROM applications.rubrique WHERE typ = 'list' LOOP EXECUTE '
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES (''d1'','''||id_rubrique||''',null,''index'',''lecteur'');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES (''d1'','''||id_rubrique||''',null,''submit'',''participant'');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES (''d1'','''||id_rubrique||''',null,''del'',''gestionnaire'');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES (''d1'','''||id_rubrique||''',null,''liste'',''lecteur'');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES (''d1'','''||id_rubrique||''',null,''commun.inc'',''lecteur'');
'; END LOOP;
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','home',null,'index','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','module_admin',null,'index','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','bugs',null,'index','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','home',null,'install','administrateur');

---------------------------------------------
--- Droit d2 : affichage d'objets
-- d2 : les rubriques
---------------------------------------------
FOR id_rubrique IN SELECT id_module FROM applications.rubrique WHERE typ = 'list' LOOP EXECUTE '
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES (''d2'','''||id_rubrique||''',null,''affichage_rubrique'',''lecteur'');
'; END LOOP;
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','module_admin','affichage_rubrique','index','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','bug','id_page','affichage_rubrique','lecteur');

---------------------------------------------
-- d2 : les bouton de colonnes et d'en-tête
---------------------------------------------
-- REFNAT
id_rubrique = 'refnat';id_onglet='taxref';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');

-- CATNAT
id_rubrique = 'catnat';id_onglet='statuts';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','to-refnat','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','maj-from-taxa-button','gestionnaire');

-- Liste rouge
id_rubrique = 'lr';id_onglet='eval';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','to-refnat','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
id_rubrique = 'lr';id_onglet='valid';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');

-- Liste EEE
id_rubrique = 'eee';id_onglet='eval_nat';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','to-refnat','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
id_rubrique = 'eee';id_onglet='eval_reg';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','to-refnat','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');

--- LSI
id_rubrique = 'lsi';id_onglet='news';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');

--- FSD
id_rubrique = 'fsd';id_onglet='ddd';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
id_rubrique = 'fsd';id_onglet='meta';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
id_rubrique = 'fsd';id_onglet='data';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
id_rubrique = 'fsd';id_onglet='taxa';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');

--- Hub
id_rubrique = 'hub';id_onglet='bilan';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','import','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','import_taxon','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','bilan','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','verif','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','diff','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','push','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','pull','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','clear','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','log','evaluateur');

--- module_admin
id_rubrique = 'module_admin';id_onglet='user';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','mdp-button','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','msg-button','administrateur');
id_rubrique = 'module_admin';id_onglet='text';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','administrateur');

--- bugs
id_rubrique = 'bugs';id_onglet='new-tab';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','edit_fiche','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','del_fiche','administrateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','save_fiche','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','export_fiche','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','add_fiche','evaluateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','retour_fiche','lecteur');


---------------------------------------------
-- d2 : les onglets des tableaux de synthèse
---------------------------------------------
id_rubrique = 'refnat';id_onglet='taxref';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'refnat';id_onglet='droit';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'catnat';id_onglet='statuts';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'catnat';id_onglet='droit';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'lr';id_onglet='eval';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'lr';id_onglet='valid';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'lr';id_onglet='droit';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'eee';id_onglet='eval_nat';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'eee';id_onglet='eval_reg';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'eee';id_onglet='droit';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'lsi';id_onglet='news';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'lsi';id_onglet='droit';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'fsd';id_onglet='ddd';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'fsd';id_onglet='meta';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'fsd';id_onglet='data';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'fsd';id_onglet='taxa';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'fsd';id_onglet='droit';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'hub';id_onglet='bilan';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'hub';id_onglet='droit';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'module_admin';id_onglet='text';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','administrateur');
id_rubrique = 'module_admin';id_onglet='user';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'module_admin';id_onglet='suivi';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','evaluateur');
id_rubrique = 'module_admin';id_onglet='log';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','administrateur');
id_rubrique = 'bugs';id_onglet='tab-new';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');
id_rubrique = 'bugs';id_onglet='tab-ok';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','affichage','lecteur');

---------------------------------------------
-- Droit d3 : filtrer le contenus des tableaux de synthèses pour affichage
---------------------------------------------
--- id_rubrique = 'module_admin';id_onglet='user';INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2',''||id_rubrique||'',''||id_onglet||'','filtre_cbn','lecteur');


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'005',
	--- Numéro du dernier commit (à modifier)
	'40c2c01b7bf49f966183ee46879596cb5155e3df', 
	--- Description de la modif BDD (à modifier)
	'Gestion des droits d accès : nouvelles tables = utilistateur_droits et table droits. Migration de la partie droit de la table utilisateur vers utilistateur_droit',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();