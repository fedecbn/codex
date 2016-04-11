CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
phase = 'test';
-- phase = 'prod';

--- 1. Code permettant la mise à jour
--- Mise à jour de la table évaluation pour ajouter les versions de l'évaluation
ALTER TABLE lr.evaluation DROP COLUMN IF EXISTS version;
ALTER TABLE lr.evaluation ADD COLUMN version integer DEFAULT 1;
DELETE FROM referentiels.champs WHERE rubrique_champ = 'lr' AND nom_champ = 'version' AND table_champ = 'evaluation';
INSERT INTO referentiels.champs (rubrique_champ, nom_champ,  nom_champ_synthese, champ_interface, type,  pos, table_champ, table_bd,export_display, modifiable,description, description_longue) VALUES 
('lr', 'version', 'version', 'version', 'int', null, 'evaluation', 'evaluation',  TRUE,  TRUE,  'Version évaluation', 'Version étape évaluation');

--- tables validation
DROP TABLE IF EXISTS lr.validation;
CREATE TABLE lr.validation (id serial NOT NULL,uid integer,etape varchar,version integer,id_user varchar,validation varchar,val_com varchar,dat_val timestamp,CONSTRAINT val_pk PRIMARY KEY (id));
GRANT ALL ON TABLE lr.validation TO pg_user;

DROP TABLE IF EXISTS lr.presence_tag;
CREATE TABLE lr.presence_tag (uid integer NOT NULL,typ_geo varchar,cd_geo varchar,CONSTRAINT presence_tag_pk PRIMARY KEY (uid,typ_geo,cd_geo));
GRANT ALL ON TABLE lr.presence_tag TO pg_user;

DROP TABLE IF EXISTS lr.validation_globale;
CREATE TABLE lr.validation_globale (uid integer NOT NULL,nbval int,nbvalcbn int,listval varchar,listvalcbn varchar,nbinval int,nbinvalcbn int,listinval varchar,listinvalcbn varchar,nbpot int,nbpotcbn int,listpot varchar,listpotcbn varchar,CONSTRAINT validation_globale_pk PRIMARY KEY (uid));
GRANT ALL ON TABLE lr.validation_globale TO pg_user;

--- description tables validation
DELETE FROM referentiels.champs WHERE rubrique_champ = 'valid_lr' AND (table_champ = 'validation' OR table_champ = 'presence_tag' OR table_champ = 'validation_globale');
INSERT INTO referentiels.champs (rubrique_champ, nom_champ,  nom_champ_synthese, champ_interface, type,  pos, table_champ, table_bd,export_display, modifiable,description, description_longue) VALUES 
('valid_lr', 'uid', 'uid', 'uid', 'int', null, 'validation', 'validation',  TRUE,  TRUE,  'Identifiant unique', 'Identifiant unique du taxon'),
('valid_lr', 'etape', 'etape', 'etape', 'string', null, 'validation', 'validation',  TRUE,  TRUE,  'Etape évaluation', 'Etape évaluation - pré-évaluation, évaluation, post-évaluation'),
('valid_lr', 'version', 'version', 'version', 'int', null, 'validation', 'validation',  TRUE,  TRUE,  'Version évaluation', 'Version étape évaluation'),
('valid_lr', 'id_user', 'id_user', 'id_user', 'string', null, 'validation', 'validation',  TRUE,  TRUE,  'Code utilisateur', 'Identifiant utilisateur'),
('valid_lr', 'validation', 'validation', 'validation', 'string', null, 'validation', 'validation',  TRUE,  TRUE,  'validation', 'validation evaluation'),
('valid_lr', 'val_com', 'val_com', 'val_com', 'string', null, 'validation', 'validation',  TRUE,  TRUE,  'commentaire', 'commentaire validation evaluation'),
('valid_lr', 'dat_val', 'dat_val', 'dat_val', 'date', null, 'validation', 'validation',  TRUE,  TRUE,  'date', 'date validation evaluation'),

('valid_lr', 'uid', 'uid', 'uid', 'int', null, 'presence_tag', 'presence_tag',  TRUE,  TRUE,  'Identifiant unique', 'Identifiant unique du taxon'),
('valid_lr', 'typ_geo', 'typ_geo', 'typ_geo', 'string', null, 'presence_tag', 'presence_tag',  TRUE,  TRUE,  'type geo', 'type objet geo'),
('valid_lr', 'cd_geo', 'cd_geo', 'cd_geo', 'string', null, 'presence_tag', 'presence_tag',  TRUE,  TRUE,  'code geo', 'objet geo presence taxon'),

('valid_lr', 'uid', 'uid', 'uid', 'int', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Identifiant unique', 'Identifiant unique du taxon'),
('valid_lr', 'nbval', 'nbval', 'nbval', 'int', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Nb val', 'Nombre validation propre'),
('valid_lr', 'nbvalcbn', 'nbvalcbn', 'nbvalcbn', 'int', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Nb val CBN', 'Nombre validation CBN'),
('valid_lr', 'listval', 'listval', 'listval', 'string', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Liste val', 'Liste des utilisateurs ayant validé'),
('valid_lr', 'listvalcbn', 'listvalcbn', 'listvalcbn', 'string', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Liste val CBN', 'Liste des CBN ayant validé'),
('valid_lr', 'nbinval', 'nbinval', 'nbinval', 'int', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Nb inval', 'Nombre invalidation propre'),
('valid_lr', 'nbinvalcbn', 'nbinvalcbn', 'nbinvalcbn', 'int', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Nb inval CBN', 'Nombre invalidation CBN'),
('valid_lr', 'lisintval', 'lisintval', 'lisintval', 'string', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Liste inval', 'Liste des utilisateurs ayant invalidé'),
('valid_lr', 'listinvalcbn', 'listinvalcbn', 'listinvalcbn', 'string', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Liste inval CBN', 'Liste des CBN ayant invalidé'),
('valid_lr', 'nbpot', 'nbpot', 'nbpot', 'int', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Nb val', 'Nombre validation potentiel'),
('valid_lr', 'nbpotcbn', 'nbpotcbn', 'nbpotcbn', 'int', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Nb val CBN', 'Nombre validation potentiel CBN'),
('valid_lr', 'listpot', 'listpot', 'listpot', 'string', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Liste val', 'Liste des utilisateurs dont la validation est attendue'),
('valid_lr', 'listpotcbn', 'listpotcbn', 'listpotcbn', 'string', null, 'validation_globale', 'validation_globale',  TRUE,  TRUE,  'Liste val CBN', 'Liste des CBN dont la validation est attendue')
;

-- Bouton validation_rapide
DELETE FROM referentiels.champs WHERE rubrique_champ = 'lr' AND  nom_champ = 'bouton_valid';
INSERT INTO referentiels.champs (rubrique_champ, nom_champ,  nom_champ_synthese, champ_interface, type,  pos, table_champ, table_bd,export_display, modifiable,description, description_longue,jvs_desc_column,jvs_filter_column) VALUES 
('lr', 'bouton_valid', 'bouton_valid', 'bouton_valid', 'bouton', 23 , null, null,  TRUE,  TRUE,  '', 'Validation rapide','{ "sClass": "center","sWidth": "5%","bSortable": false }',null);

UPDATE referentiels.champs SET description='Fiche',description_longue='Accès à la fiche' WHERE rubrique_champ='lr' AND nom_champ='bouton';
UPDATE referentiels.champs SET description='<input type=checkbox class=liste-all value=1 >',description_longue='' WHERE rubrique_champ='lr' AND nom_champ='checkbox';
DELETE FROM referentiels.champs WHERE rubrique_champ = 'lr' AND  nom_champ = 'validation';
INSERT INTO referentiels.champs (rubrique_champ, nom_champ,  nom_champ_synthese, champ_interface, type,  pos, table_champ, table_bd,export_display, modifiable,description, description_longue,jvs_desc_column,jvs_filter_column) VALUES 
('lr', 'validation', 'validation', 'validation', 'val', 21, 'validation', 'validation',  TRUE,  TRUE,  'valid.', 'Validation evaluation','{ "sWidth": "5%" }','{ "type": "select", "values": [{ "value": "valid", "label": "Validé"},{ "value": "invalid", "label": "Invalidé"},{ "value" : "is_null", "label": "Non validé"}]}');

-- Positions
UPDATE referentiels.champs SET pos=24 WHERE rubrique_champ='lr' AND nom_champ='checkbox';
UPDATE referentiels.champs SET pos=22 WHERE rubrique_champ='lr' AND nom_champ='bouton';

--- Onglet valid_lr
UPDATE applications.onglet SET onglet='valid_lr' WHERE onglet='valid';


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'013',
	--- Numéro du dernier commit (à modifier)
	'5e054ad8854fdff2755ed06e0235b609e2f4cd5b', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : Validation',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();