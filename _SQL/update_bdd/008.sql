CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','refnat',null,'form','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','catnat',null,'form','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','eee',null,'form','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','lr',null,'form','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','lsi',null,'form','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','fsd',null,'form','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','hub',null,'form','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d1','syntaxa',null,'form','lecteur');

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'008',
	--- Numéro du dernier commit (à modifier)
	'f4e3372d2bd4c36323669239c0a59346f39baacd', 
	--- Description de la modif BDD (à modifier)
	'Gestion des droits : ajout de droits pour l acces aux fichiers form.php',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();