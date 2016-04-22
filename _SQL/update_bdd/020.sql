CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
DECLARE user_codex varchar;
BEGIN
----------------------------------------------------
------VARIABLES A DÉFINIR---------------------------
---## Pour tester la fonction. Une fois que vous souhaiter enregistrer la modif dans la table update_bdd, mettre la phase en "prod" ##--
-- phase = 'test';
phase = 'prod';
---## user_codex est l'utilisateur du codex (décommentez la ligne suivante si besoin) ##--
-- user_codex = 'pg_user';
----------------------------------------------------

--- 1. Code permettant la mise à jour
--- onglet
UPDATE applications.onglet SET onglet = 'hub' WHERE rubrique = 'hub' AND onglet = 'bilan';
UPDATE applications.onglet SET onglet = 'eee' WHERE rubrique = 'eee' AND onglet = 'eval_nat';
UPDATE applications.onglet SET onglet = 'catnat' WHERE rubrique = 'catnat' AND onglet = 'statuts';
UPDATE applications.onglet SET onglet = 'refnat' WHERE rubrique = 'refnat' AND onglet = 'taxref';
UPDATE applications.onglet SET onglet = 'lsi' WHERE rubrique = 'lsi' AND onglet = 'news';
UPDATE applications.onglet SET onglet = 'fsd' WHERE rubrique = 'fsd' AND onglet = 'ddd';


--- droit
UPDATE applications.droit SET onglet = 'hub' WHERE rubrique = 'hub' AND onglet = 'bilan' AND typ_droit = 'd2';
UPDATE applications.droit SET onglet = 'eee' WHERE rubrique = 'eee' AND onglet = 'eval_nat' AND typ_droit = 'd2';
UPDATE applications.droit SET onglet = 'catnat' WHERE rubrique = 'catnat' AND onglet = 'statuts' AND typ_droit = 'd2';
UPDATE applications.droit SET onglet = 'refnat' WHERE rubrique = 'refnat' AND onglet = 'taxref' AND typ_droit = 'd2';
UPDATE applications.droit SET onglet = 'lsi' WHERE rubrique = 'lsi' AND onglet = 'news' AND typ_droit = 'd2';
UPDATE applications.droit SET onglet = 'fsd' WHERE rubrique = 'fsd' AND onglet = 'ddd' AND typ_droit = 'd2';

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'020',
	--- Numéro du dernier commit (à modifier)
	'36ea6ae02278f3f46e4ddc236d6049e6ec2651ad', 
	--- Description de la modif BDD (à modifier)
	'Debug : droit vs onglets',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();