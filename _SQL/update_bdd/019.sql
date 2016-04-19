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
--- onglet : syntaxa
DELETE FROM  applications.onglet WHERE rubrique = 'syntaxa';
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'syntaxa'), 'syntaxa','syntaxa','Catalogues','Liste des catalogues');
INSERT INTO applications.onglet VALUES ((SELECT id_rubrique FROM applications.rubrique WHERE id_module = 'syntaxa'), 'syntaxa','droit','Utilisateurs','Utilisateurs de la rubrique');

--- droit
DELETE FROM applications.droit WHERE typ_droit = 'd2' AND rubrique = 'rubrique';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','view_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','edit_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','del_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','validate_fiche','validateur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','save_fiche','participant');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','export_fiche','lecteur');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','add_fiche','gestionnaire');
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES ('d2','syntaxa','syntaxa','retour_fiche','lecteur');


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'019',
	--- Numéro du dernier commit (à modifier)
	'57e4e7181f3412dd0d69898489e5c53b0efb97f4', 
	--- Description de la modif BDD (à modifier)
	'Rub syntaxa : droit d2',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();