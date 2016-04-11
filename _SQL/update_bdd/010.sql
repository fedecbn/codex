CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
UPDATE applications.droit SET onglet='eee' WHERE onglet='eval_nat';
UPDATE applications.droit SET onglet='eee_reg' WHERE onglet='eval_reg';
UPDATE applications.droit SET onglet='fsd' WHERE onglet='ddd';


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'010',
	--- Numéro du dernier commit (à modifier)
	'7c1a1d88139fb4433a1a9de792f56ef45abcfdc7', 
	--- Description de la modif BDD (à modifier)
	'Correction table applications.droit pour correspondre avec les onglets',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();