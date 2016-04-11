CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
UPDATE applications.droit SET rubrique = 'bugs' WHERE rubrique = 'bug';


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'009',
	--- Numéro du dernier commit (à modifier)
	'8d915007c6ab7289f2d692839370fb69e34e6a9b', 
	--- Description de la modif BDD (à modifier)
	'Correction table applications.droit',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();