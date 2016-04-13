CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
--mise à jour des sequences pour la table applications.rubrique
PERFORM setval('applications.rubrique_id_rubrique_seq ', COALESCE((SELECT MAX(id_rubrique)+1 FROM applications.rubrique), 1), false);
PERFORM setval('applications.pres_id_pres_seq ', COALESCE((SELECT MAX(id_pres)+1 FROM applications.pres), 1), false);

-- Ajout de la rubrique Syntaxa dans les tables
DELETE FROM applications.rubrique WHERE id_module = 'syntaxa';
INSERT INTO applications.rubrique(id_module, pos, icone, titre, descr, niveau, link, lang)
    VALUES ('syntaxa', (SELECT max(pos+1) FROM applications.rubrique), 'saisie.png', 'Catalogue des végétations', '', 1, '../syntaxa/index.php', 0);
DELETE FROM applications.pres WHERE id_module = 'syntaxa';
INSERT INTO applications.pres(id_module, page, titre, pres, lang)   VALUES ('syntaxa', 'header', 'Catalogue des végétations', '<hr><p align="center"><b><span style="font-size:18px;">Rubriques Végétations</span></b><br></p><p align="center">Cette rubrique contient les catalogues de végétation, séries et géoséries<br></p>', 0);
INSERT INTO applications.pres(id_module, page, titre, pres, lang)   VALUES ('syntaxa', 'footer', 'Catalogue des végétations', '<p align="center">---<br></p>', 0);

-- Ajout de la rubrique module_admin et bugs
DELETE FROM applications.rubrique WHERE id_module = 'module_admin';
INSERT INTO applications.rubrique(id_module, pos, icone, titre, descr, niveau, link, lang)
    VALUES ('module_admin', (SELECT max(pos+1) FROM applications.rubrique), null, 'Administration', '', 1, '../module_admin/index.php', 0);
DELETE FROM applications.pres WHERE id_module = 'module_admin';
INSERT INTO applications.pres(id_module, page, titre, pres, lang)   VALUES ('module_admin', 'header', 'Module administration', '', 0);
INSERT INTO applications.pres(id_module, page, titre, pres, lang)   VALUES ('module_admin', 'footer', 'Module administration', '<p align="center">---<br></p>', 0);
	
DELETE FROM applications.rubrique WHERE id_module = 'bugs';
INSERT INTO applications.rubrique(id_module, pos, icone, titre, descr, niveau, link, lang)
    VALUES ('bugs', (SELECT max(pos+1) FROM applications.rubrique), null, 'bugs', '', 1, '../bugs/index.php', 0);
DELETE FROM applications.pres WHERE id_module = 'bugs';
INSERT INTO applications.pres(id_module, page, titre, pres, lang)   VALUES ('bugs', 'header', 'Bugs', '', 0);
INSERT INTO applications.pres(id_module, page, titre, pres, lang)   VALUES ('bugs', 'footer', 'Bugs', '<p align="center">---<br></p>', 0);
	
-- Différenciation entre les rubriques admin et liste des rubriques
ALTER TABLE applications.rubrique DROP COLUMN IF EXISTS typ ;
ALTER TABLE applications.rubrique ADD COLUMN typ varchar DEFAULT 'list';
UPDATE applications.rubrique SET typ = 'admin' WHERE id_module = 'bugs' OR id_module = 'module_admin' ;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'004',
	--- Numéro du dernier commit (à modifier)
	'40c2c01b7bf49f966183ee46879596cb5155e3df', 
	--- Description de la modif BDD (à modifier)
	'Gestion des rubriques : ajout de syntaxa et description des rubriques d administration',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();