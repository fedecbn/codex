CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
DECLARE user_codex varchar;
DECLARE test_schema integer;
BEGIN
----------------------------------------------------
------VARIABLES A DÉFINIR---------------------------
---## Pour tester la fonction. Une fois que vous souhaiter enregistrer la modif dans la table update_bdd, mettre la phase en "prod" ##--
-- phase = 'test';
phase = 'prod';
---## user_codex est l'utilisateur du codex (décommentez la ligne suivante si besoin) ##--
user_codex = 'pg_user';
----------------------------------------------------

--- 1. Code permettant la mise à jour
--- modification du referentiel champ pour l'affichage des drtois utilisateurs
DELETE FROM referentiels.champs WHERE rubrique_champ = 'user';
INSERT INTO referentiels.champs (rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd, jvs_desc_column, jvs_filter_column) VALUES 
('user', 'niveau', 'val', 'Niveau de droit', 'utilisateur_role', null, 4, 'Niveau de droit', false, 'niveau', 'niveau', false, 'utilisateur', '{ "sWidth": "5%" }', '{ "type": "text" }'),
('user', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, 'Code utilisateur', false, 'id_user', 'id_user', false, 'utilisateur', '{ "sWidth": "5%" }', '{ "type": "text" }'),
('user', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, 'Prénom', false, 'prenom', 'prenom', false, 'utilisateur', '{ "sWidth": "5%" }', '{ "type": "text" }'),
('user', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, 'Nom', false, 'nom', 'nom', false, 'utilisateur', '{ "sWidth": "5%" }', '{ "type": "text" }'),
('user', 'referent', 'bool', 'Référent LSI', 'utilisateur_role', NULL, 5, 'Référent LSI', false, 'referent', 'referent', false, 'utilisateur', '{ "sWidth": "5%" }', '{ "type": "text" }'),
('user', 'id_cbn', 'val', 'Institution', 'utilisateur', 'id_cbn', 3, 'Institution', false, 'id_cbn', 'id_cbn', false, 'utilisateur', '{ "sWidth": "5%" }', '{ "type": "text" }');

DELETE FROM referentiels.champs_ref WHERE nom_ref = 'cbn_droit';
INSERT INTO referentiels.champs_ref (nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref, where_champ, where_value) VALUES 
('id_cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'user', NULL, NULL);

--- Gestion de la position des onglets
ALTER TABLE applications.onglet DROP COLUMN IF EXISTS pos;
ALTER TABLE applications.onglet ADD COLUMN pos integer;
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'lr' AND onglet = 'lr';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'lr' AND onglet = 'droit';
UPDATE applications.onglet SET pos = 3 WHERE rubrique = 'lr' AND onglet = 'valid';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'hub' AND onglet = 'hub';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'hub' AND onglet = 'droit';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'eee' AND onglet = 'eee';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'eee' AND onglet = 'eval_reg';
UPDATE applications.onglet SET pos = 3 WHERE rubrique = 'eee' AND onglet = 'droit';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'catnat' AND onglet = 'catnat';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'catnat' AND onglet = 'droit';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'syntaxa' AND onglet = 'syntaxa';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'syntaxa' AND onglet = 'droit';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'module_admin' AND onglet = 'log';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'module_admin' AND onglet = 'suivi';
UPDATE applications.onglet SET pos = 3 WHERE rubrique = 'module_admin' AND onglet = 'text';
UPDATE applications.onglet SET pos = 4 WHERE rubrique = 'module_admin' AND onglet = 'user';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'bugs' AND onglet = 'tab-new';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'bugs' AND onglet = 'tab-ok';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'refnat' AND onglet = 'refnat';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'refnat' AND onglet = 'droit';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'lsi' AND onglet = 'lsi';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'lsi' AND onglet = 'droit';
UPDATE applications.onglet SET pos = 1 WHERE rubrique = 'fsd' AND onglet = 'fsd';
UPDATE applications.onglet SET pos = 2 WHERE rubrique = 'fsd' AND onglet = 'meta';
UPDATE applications.onglet SET pos = 3 WHERE rubrique = 'fsd' AND onglet = 'data';
UPDATE applications.onglet SET pos = 4 WHERE rubrique = 'fsd' AND onglet = 'taxa';
UPDATE applications.onglet SET pos = 5 WHERE rubrique = 'fsd' AND onglet = 'droit';

--- Droits sur la table région
EXECUTE 'GRANT ALL ON TABLE referentiels.regions TO '||user_codex||';';


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN /*NEXT*/ 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'029',
	--- Numéro du dernier commit (à modifier)
	'd5c5734490539c3b2966d485863625c90c8009c3', 
	--- Description de la modif BDD (à modifier)
	'User : simplification de l affichage des droit utilisateur pour chaque rubrique',
	--- Date (à ne pas modifier)
	NOW());
RETURN /*NEXT*/ 'OK';
ELSE RETURN /*NEXT*/ 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();


