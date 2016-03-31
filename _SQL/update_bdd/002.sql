CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ BEGIN

--- 1. Code permettant la mise à jour
ALTER TABLE applications.update_bdd ADD COLUMN descr varchar;



--- 2. Pour le suivi des mises à jours
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'002',
	--- Numéro du dernier commit (à modifier)
	'd6b1c1215bc1c79fa78ea9978d60e686ded8de1b', 
	--- Description de la modif BDD (à modifier)
	'Ajout de la description lors de la mise à jour de la base de donnée',
	--- Date (à ne pas modifier)
	NOW());

RETURN 'OK';END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();