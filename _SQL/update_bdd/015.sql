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
--- Mise à jour de la table évaluation pour ajouter les versions de l'évaluation
DELETE FROM referentiels.champs WHERE  rubrique_champ='lr' AND nom_champ='val_com';
INSERT INTO referentiels.champs (rubrique_champ, nom_champ,  nom_champ_synthese, champ_interface, type,  pos, table_champ, table_bd,export_display, modifiable,description, description_longue,jvs_desc_column,jvs_filter_column) VALUES 
('lr', 'val_com', 'val_com', 'val_com', 'string', 22 , 'evaluation', 'evaluation',  TRUE,  TRUE,  'Com.', 'Commentaire validation','{ "sWidth": "5%" }','{ "type": "text" }');

UPDATE referentiels.champs SET pos=22 WHERE rubrique_champ='lr' AND nom_champ='val_com';
UPDATE referentiels.champs SET pos=23 WHERE rubrique_champ='lr' AND nom_champ='bouton';
UPDATE referentiels.champs SET pos=24 WHERE rubrique_champ='lr' AND nom_champ='bouton_valid';
UPDATE referentiels.champs SET pos=25 WHERE rubrique_champ='lr' AND nom_champ='checkbox';

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'015',
	--- Numéro du dernier commit (à modifier)
	'c14a5377abc28e27661172ce3359a80feeec2c7c', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : Ajout de la colomme Commentaire validation',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();