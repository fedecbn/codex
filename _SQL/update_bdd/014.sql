CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
--- Mise à jour de la table évaluation pour ajouter les versions de l'évaluation
GRANT ALL ON SEQUENCE lr.validation_id_seq  TO pg_user;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'014',
	--- Numéro du dernier commit (à modifier)
	'9230ad6ffc3a01c6bab9461464ebd6513822e88a', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : Droit sur la séquence de validation',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();