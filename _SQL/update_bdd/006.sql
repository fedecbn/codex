CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
DECLARE user_codex varchar;
DECLARE test varchar;
BEGIN
----------------------------------------------------
------VARIABLES A DÉFINIR---------------------------
---## Pour tester la fonction. Une fois que vous souhaiter enregistrer la modif dans la table update_bdd, mettre la phase en "prod" ##--
-- phase = 'test';
phase = 'prod';
---## user_codex est l'utilisateur du codex (décommentez la ligne suivante) ##--
-- user_codex = 'pg_user';
----------------------------------------------------

--- 1. Code permettant la mise à jour
CASE WHEN user_codex IS NULL THEN RETURN 'Définir user_codex dans le script'; ELSE

DROP TABLE IF EXISTS applications.onglet;
CREATE TABLE applications.onglet (
id_rubrique character varying,
rubrique character varying,
onglet character varying,
nom character varying,
ss_titre character varying,
CONSTRAINT utilisateur_droit_pk PRIMARY KEY (id_rubrique,onglet)
);
EXECUTE 'GRANT ALL ON TABLE applications.onglet TO '||user_codex;

-- REFNAT
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'refnat'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'refnat'), 'refnat','taxref','Evolution TAXREF','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'refnat'), 'refnat','droit','Utilisateurs','Utilisateurs de la rubrique');
ELSE END CASE;

-- CATNAT
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'catnat'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'catnat'), 'catnat','statuts','Catalogue National','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'catnat'), 'catnat','droit','Utilisateurs','Utilisateurs de la rubrique');
ELSE END CASE;

-- Liste rouge
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'lr'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lr'), 'lr','lr','Evaluation','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lr'), 'lr','valid','Validation','Liste des évaluations');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lr'), 'lr','droit','Utilisateurs','Utilisateurs de la rubrique');
ELSE END CASE;

-- Liste eee
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'eee'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'eee'), 'eee','eval_nat','Eval Nationale','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'eee'), 'eee','eval_reg','Eval Régionale','Liste des évaluations');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'eee'), 'eee','droit','Utilisateurs','Utilisateurs de la rubrique');
ELSE END CASE;

-- LSI
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'lsi'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lsi'), 'lsi','news','News','Liste des actualités');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lsi'), 'lsi','droit','Utilisateurs','Utilisateurs de la rubrique');
ELSE END CASE;

-- FSD
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'fsd'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','ddd','Dictionnaire de données','Liste des champs');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','meta','META','Format standard de données - META');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','data','DATA','Format standard de données - DATA');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','taxa','TAXA','Format standard de données - TAXA');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','droit','Utilisateurs','Utilisateurs de la rubrique');
ELSE END CASE;

-- Hub
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'hub'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'hub'), 'hub','bilan','Etat du Hub','Liste des CBN');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'hub'), 'hub','droit','Utilisateurs','Utilisateurs de la rubrique');
ELSE END CASE;

-- Module_admin
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'module_admin'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','text','Rubriques','Liste des rubriques');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','user','Utilisateurs','Liste des utilisateurs');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','suivi','Suivi des modif','Liste des modifications');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','log','Logs','Listes des logs');
ELSE END CASE;

-- Bugs
SELECT id_rubrique INTO test FROM applications.rubrique WHERE id_module = 'bugs'; 
CASE WHEN test IS NOT NULL THEN
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'bugs'), 'bugs','tab-new','Nouveaux / En cours','Liste des bugs');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'bugs'), 'bugs','tab-ok','Traités','Liste des bugs');
ELSE END CASE;

END CASE;

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'006',
	--- Numéro du dernier commit (à modifier)
	'40c2c01b7bf49f966183ee46879596cb5155e3df', 
	--- Description de la modif BDD (à modifier)
	'Gestion des onglets dans les tableaux de synthèses : table applications.onglets',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();