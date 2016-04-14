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
--- modif table validation (etape = smallint)
ALTER TABLE lr.validation ADD COLUMN etape_ smallint;
UPDATE lr.validation SET etape = NULL WHERE etape = '';
UPDATE lr.validation SET etape_ = etape::integer; 
ALTER TABLE lr.validation DROP COLUMN etape;
ALTER TABLE lr.validation RENAME etape_ TO etape;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'017',
	--- Numéro du dernier commit (à modifier)
	'a1110df84ae855fc0d83805be6bb3c5dd5d97152', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : modif table validation (etape = smallint)',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();