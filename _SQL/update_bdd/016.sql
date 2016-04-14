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
--- Mise à jour de la table référentiels champs
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%" }' WHERE rubrique_champ='lr' AND nom_champ='validation';
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%" }' WHERE rubrique_champ='lr' AND nom_champ='val_com';
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%" }' WHERE rubrique_champ='lr' AND nom_champ='notes';
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%" }' WHERE rubrique_champ='lr' AND nom_champ='id_indi';
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%" }' WHERE rubrique_champ='lr' AND nom_champ='id_rang';
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%" }' WHERE rubrique_champ='lr' AND nom_champ='endemisme';
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%" }' WHERE rubrique_champ='lr' AND nom_champ='nb_reg_evalue';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "5%" }' WHERE rubrique_champ='lr' AND nom_champ='avancement';
UPDATE referentiels.champs SET description  ='End.' WHERE rubrique_champ='lr' AND nom_champ='endemisme';
UPDATE referentiels.champs SET referentiel='id_indi' WHERE rubrique_champ='lr' AND nom_champ='id_indi';
UPDATE referentiels.champs SET referentiel='id_rang' WHERE rubrique_champ='lr' AND nom_champ='id_rang';


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'016',
	--- Numéro du dernier commit (à modifier)
	'50e75ed5fc3d4da7d10e73a4516fd3f8f4b46bab', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : Mise à jour tableau de synthèse',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();