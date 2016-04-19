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
--- Debug table ref
UPDATE referentiels.champs SET table_bd = 'validation', table_champ = 'validation' WHERE rubrique_champ = 'lr' AND nom_champ = 'val_com';
UPDATE referentiels.champs SET jvs_desc_column = '{ "sWidth": "4%"}' WHERE rubrique_champ = 'lr' AND nom_champ = 'just_fin';

--- Changement etape et avancement talbe evaluation
ALTER TABLE lr.validation RENAME version TO version_val;
ALTER TABLE lr.validation RENAME etape TO etape_val;

UPDATE referentiels.champs SET nom_champ = 'avancement_val' WHERE rubrique_champ = 'valid_lr' AND nom_champ = 'avancement' AND table_bd = 'validation';
UPDATE referentiels.champs SET nom_champ = 'etape_val' WHERE rubrique_champ = 'valid_lr' AND nom_champ = 'etape' AND table_bd = 'validation';

--- MIse à zero des etape et avancement
UPDATE lr.evaluation SET etape = 1 WHERE etape IS null;
UPDATE lr.evaluation SET avancement = 1 WHERE avancement IS null;

--- Correction onglet lr
UPDATE applications.droit SET onglet = 'lr' WHERE onglet = 'eval' AND rubrique = 'lr';
UPDATE applications.onglet SET onglet = 'lr' WHERE onglet = 'eval' AND rubrique = 'lr';

--- ajout de droits pour la gestion de l'avancement et des étapes
DELETE FROM applications.droit WHERE objet = 'clore_version_fiche' OR  objet = 'open_version_fiche' OR  objet = 'clore_etape_fiche';
INSERT INTO applications.droit (typ_droit, rubrique,onglet,objet,role) VALUES 
('d2','lr','lr','clore_version_fiche','gestionnaire'),
('d2','lr','lr','open_version_fiche','gestionnaire'),
('d2','lr','lr','clore_etape_fiche','gestionnaire')
;


--- droits utilisateurs
UPDATE applications.utilisateur_role SET no_acces = FALSE, lecteur = TRUE WHERE rubrique = 'syntaxa' AND id_user = 'THMI5';
UPDATE applications.utilisateur_role SET no_acces = FALSE, lecteur = TRUE,participant = TRUE, evaluateur = TRUE, gestionnaire = TRUE, administrateur = TRUE WHERE rubrique = 'syntaxa' AND id_user = 'ANJU3';
INSERT INTO applications.utilisateur_role (id_user,rubrique,lecteur,participant,evaluateur,gestionnaire,administrateur) VALUES ('ANJU3','syntaxa',TRUE,TRUE,TRUE,TRUE,TRUE);
INSERT INTO applications.utilisateur_role (id_user,rubrique,lecteur,participant,evaluateur,gestionnaire,administrateur) VALUES ('THMI','syntaxa',TRUE,TRUE,TRUE,TRUE,TRUE);

UPDATE applications.utilisateur_role SET no_acces = FALSE, validateur = TRUE WHERE rubrique = 'lr' AND id_user = 'THMI5';
UPDATE applications.utilisateur_role SET no_acces = FALSE, validateur = TRUE WHERE rubrique = 'lr' AND id_user = 'THMI';
UPDATE applications.utilisateur_role SET no_acces = FALSE, validateur = TRUE WHERE rubrique = 'lr' AND id_user = 'JOGO';
UPDATE applications.utilisateur_role SET no_acces = FALSE, validateur = TRUE WHERE rubrique = 'lr' AND id_user = 'JOGO5';

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'018',
	--- Numéro du dernier commit (à modifier)
	'', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : amélioration de la gestion de l avancement',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();