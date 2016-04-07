CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
UPDATE applications.utilisateur_role SET gestionnaire = TRUE WHERE administrateur = TRUE;
UPDATE applications.utilisateur_role SET evaluateur = TRUE WHERE gestionnaire = TRUE;
UPDATE applications.utilisateur_role SET participant = TRUE WHERE evaluateur = TRUE;
UPDATE applications.utilisateur_role SET lecteur = TRUE WHERE participant = TRUE;

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'007',
	--- Numéro du dernier commit (à modifier)
	'40e83e4f1c038f3f3b5fcd9f378692a6df86a69e', 
	--- Description de la modif BDD (à modifier)
	'Gestion des droits : completer le tableau (hierarchie entre lecteur, participant, evaluateur...)',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();