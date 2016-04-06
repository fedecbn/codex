CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
DROP TABLE IF EXISTS applications.onglet;
CREATE TABLE applications.onglet (
id_rubrique character varying,
rubrique character varying,
onglet character varying,
nom character varying,
ss_titre character varying,
CONSTRAINT utilisateur_droit_pk PRIMARY KEY (id_rubrique,onglet)
);
GRANT ALL ON TABLE applications.onglet TO pg_user;

-- REFNAT
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'refnat'), 'refnat','taxref','Evolution TAXREF','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'refnat'), 'refnat','droit','Utilisateurs','Utilisateurs de la rubrique');

-- CATNAT
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'catnat'), 'catnat','statuts','Catalogue National','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'catnat'), 'catnat','droit','Utilisateurs','Utilisateurs de la rubrique');

-- Liste rouge
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lr'), 'lr','eval','Evaluation','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lr'), 'lr','valid','Validation','Liste des évaluations');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lr'), 'lr','droit','Utilisateurs','Utilisateurs de la rubrique');

-- Liste eee
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'eee'), 'eee','eval_nat','Eval Nationale','Liste des taxons');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'eee'), 'eee','eval_reg','Eval Régionale','Liste des évaluations');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'eee'), 'eee','droit','Utilisateurs','Utilisateurs de la rubrique');

-- LSI
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lsi'), 'lsi','news','News','Liste des actualités');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'lsi'), 'lsi','droit','Utilisateurs','Utilisateurs de la rubrique');

-- FSD
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','ddd','Dictionnaire de données','Liste des champs');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','meta','META','Format standard de données - META');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','data','DATA','Format standard de données - DATA');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','taxa','TAXA','Format standard de données - TAXA');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'fsd'), 'fsd','droit','Utilisateurs','Utilisateurs de la rubrique');

-- Hub
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'hub'), 'hub','bilan','Etat du Hub','Liste des CBN');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'hub'), 'hub','droit','Utilisateurs','Utilisateurs de la rubrique');

-- Module_admin
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','text','Rubriques','Liste des rubriques');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','user','Utilisateurs','Liste des utilisateurs');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','suivi','Suivi des modif','Liste des modifications');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'module_admin'), 'module_admin','log','Logs','Listes des logs');

-- Bugs
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'bugs'), 'bugs','tab-new','Nouveaux / En cours','Liste des bugs');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'bugs'), 'bugs','tab-ok','Traités','Liste des bugs');

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