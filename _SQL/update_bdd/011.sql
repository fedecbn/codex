CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
phase = 'test';
-- phase = 'prod';

--- 1. Code permettant la mise à jour
--- Mise à jour de la table referentiels.champ
ALTER TABLE referentiels.champs DROP COLUMN IF EXISTS jvs_desc_column;
ALTER TABLE referentiels.champs ADD COLUMN jvs_desc_column varchar DEFAULT '{ "sWidth": "5%" }';

ALTER TABLE referentiels.champs DROP COLUMN IF EXISTS jvs_filter_column;
ALTER TABLE referentiels.champs ADD COLUMN jvs_filter_column varchar DEFAULT '{ "type": "text" }';

--- Bouton view,edit et checkbox
DELETE FROM referentiels.champs WHERE rubrique_champ='lr' AND (nom_champ='bouton' OR nom_champ='checkbox');
INSERT INTO referentiels.champs (rubrique_champ, nom_champ,  nom_champ_synthese, champ_interface, type,  pos, table_champ, table_bd,export_display, modifiable,description, description_longue) VALUES 
('lr', 'bouton', 'bouton', 'bouton', 'bouton', (SELECT max(pos)+1 FROM referentiels.champs WHERE rubrique_champ='lr') , null, null,  TRUE,  TRUE,  'bouton', 'bouton'),
('lr', 'checkbox', 'checkbox', 'checkbox', 'checkbox', (SELECT max(pos)+1 FROM referentiels.champs WHERE rubrique_champ='lr'), null, null,  TRUE,  TRUE,  'checkbox', 'checkbox');

--- Remplissage
-- LR
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "1", "label": "pré-eval"},{ "value": "2", "label": "éval"},{ "value": "3", "label": "post-éval"}]}' WHERE rubrique_champ='lr' AND nom_champ='etape';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%", "sClass": "valid" }',jvs_filter_column='{ "type": "select", "values": [{ "value": 1, "label": "à réaliser"},{ "value": 2, "label": "en cours"},{ "value": 3, "label": "réalisée"}]}' WHERE rubrique_champ='lr' AND nom_champ='avancement';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "9%" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='famille';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "20%", "sClass": "nom_taxon" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='nom_sci';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }',jvs_filter_column='{ "type": "select", "values": [{ "value": 1, "label": "ES"},{ "value": 2, "label": "SSES"},{ "value": 3, "label": "VAR"},{ "value": 4, "label": "SVAR"},{ "value": 5, "label": "FO"},{ "value": 6, "label": "SSFO"}]}' WHERE rubrique_champ='lr' AND nom_champ='id_rang';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }',jvs_filter_column='{ "type": "select", "values": [{ "value": 1, "label": "Indigène"},{ "value": 2, "label": "Cryptogène"},{ "value": 3, "label": "Exotique"}] }' WHERE rubrique_champ='lr' AND nom_champ='id_indi';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }',jvs_filter_column='{ "type": "select", "values": [{ "value": true, "label": "Oui"},{ "value": false, "label": "Non"}] }' WHERE rubrique_champ='lr' AND nom_champ='endemisme';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='aoo4';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='aoo_precis';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='nbloc_precis';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='nbm5_post1990_est';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%", "sClass": "uicn" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "not_zero", "label": "évalué"},{ "value": "0", "label": "non évalué"},{ "value": "1", "label": "RE"},{ "value": "2", "label": "CR*"},{ "value": "3", "label": "CR"},{ "value": "4", "label": "EN"},{ "value": "5", "label": "VU"},{ "value": "6", "label": "NT"},{ "value": "7", "label": "LC"},{ "value": "8", "label": "DD"},{ "value": "9", "label": "NE"},{"value": "10", "label": "NA"}]}' WHERE rubrique_champ='lr' AND nom_champ='cat_a';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%", "sClass": "uicn" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "not_zero", "label": "évalué"},{ "value": "0", "label": "non évalué"},{ "value": "1", "label": "RE"},{ "value": "2", "label": "CR*"},{ "value": "3", "label": "CR"},{ "value": "4", "label": "EN"},{ "value": "5", "label": "VU"},{ "value": "6", "label": "NT"},{ "value": "7", "label": "LC"},{ "value": "8", "label": "DD"},{ "value": "9", "label": "NE"},{"value": "10", "label": "NA"}]}' WHERE rubrique_champ='lr' AND nom_champ='cat_b';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%", "sClass": "uicn" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "not_zero", "label": "évalué"},{ "value": "0", "label": "non évalué"},{ "value": "1", "label": "RE"},{ "value": "2", "label": "CR*"},{ "value": "3", "label": "CR"},{ "value": "4", "label": "EN"},{ "value": "5", "label": "VU"},{ "value": "6", "label": "NT"},{ "value": "7", "label": "LC"},{ "value": "8", "label": "DD"},{ "value": "9", "label": "NE"},{"value": "10", "label": "NA"}]}' WHERE rubrique_champ='lr' AND nom_champ='cat_c';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%", "sClass": "uicn" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "not_zero", "label": "évalué"},{ "value": "0", "label": "non évalué"},{ "value": "1", "label": "RE"},{ "value": "2", "label": "CR*"},{ "value": "3", "label": "CR"},{ "value": "4", "label": "EN"},{ "value": "5", "label": "VU"},{ "value": "6", "label": "NT"},{ "value": "7", "label": "LC"},{ "value": "8", "label": "DD"},{ "value": "9", "label": "NE"},{"value": "10", "label": "NA"}]}' WHERE rubrique_champ='lr' AND nom_champ='cat_d';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%", "sClass": "uicn" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "not_zero", "label": "évalué"},{ "value": "0", "label": "non évalué"},{ "value": "1", "label": "RE"},{ "value": "2", "label": "CR*"},{ "value": "3", "label": "CR"},{ "value": "4", "label": "EN"},{ "value": "5", "label": "VU"},{ "value": "6", "label": "NT"},{ "value": "7", "label": "LC"},{ "value": "8", "label": "DD"},{ "value": "9", "label": "NE"},{"value": "10", "label": "NA"}]}' WHERE rubrique_champ='lr' AND nom_champ='cat_fin';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%"}',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='just_fin';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%", "sClass": "uicn" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "not_zero", "label": "évalué"},{ "value": "0", "label": "non évalué"},{ "value": "1", "label": "RE"},{ "value": "2", "label": "CR*"},{ "value": "3", "label": "CR"},{ "value": "4", "label": "EN"},{ "value": "5", "label": "VU"},{ "value": "6", "label": "NT"},{ "value": "7", "label": "LC"},{ "value": "8", "label": "DD"},{ "value": "9", "label": "NE"},{"value": "10", "label": "NA"}]}' WHERE rubrique_champ='lr' AND nom_champ='cat_euro';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "2%", "sClass": "uicn" }',jvs_filter_column='{ "type": "select", "values": [{ "value": "not_zero", "label": "évalué"},{ "value": "0", "label": "non évalué"},{ "value": "1", "label": "RE"},{ "value": "2", "label": "CR*"},{ "value": "3", "label": "CR"},{ "value": "4", "label": "EN"},{ "value": "5", "label": "VU"},{ "value": "6", "label": "NT"},{ "value": "7", "label": "LC"},{ "value": "8", "label": "DD"},{ "value": "9", "label": "NE"},{"value": "10", "label": "NA"}]}' WHERE rubrique_champ='lr' AND nom_champ='cat_synt_reg';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='nb_reg_evalue';
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "5%" }',jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='lr' AND nom_champ='notes';

UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%","bSortable": false }',jvs_filter_column=null WHERE rubrique_champ='lr' AND nom_champ='bouton';
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%","bSortable": false }',jvs_filter_column=null WHERE rubrique_champ='lr' AND nom_champ='checkbox';

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'011',
	--- Numéro du dernier commit (à modifier)
	'5e054ad8854fdff2755ed06e0235b609e2f4cd5b', 
	--- Description de la modif BDD (à modifier)
	'Pilotage de la description des tableaux de synthèse et filtres par la base de donnée',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();