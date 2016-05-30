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
DROP TABLE IF EXISTS refnat.taxrefv90_utf8;
CREATE TABLE refnat.taxrefv90_utf8
(
  ogc_fid serial NOT NULL,
  regne character varying,
  phylum character varying,
  classe character varying,
  ordre character varying,
  famille character varying,
  group1_inpn character varying,
  group2_inpn character varying,
  cd_nom character varying,
  cd_taxsup character varying,
  cd_sup character varying,
  cd_ref character varying,
  rang character varying,
  lb_nom character varying,
  lb_auteur character varying,
  nom_complet character varying,
  nom_complet_html character varying,
  nom_valide character varying,
  nom_vern character varying,
  nom_vern_eng character varying,
  habitat character varying,
  fr character varying,
  gf character varying,
  mar character varying,
  gua character varying,
  sm character varying,
  sb character varying,
  spm character varying,
  may character varying,
  epa character varying,
  reu character varying,
  taaf character varying,
  pf character varying,
  nc character varying,
  wf character varying,
  cli character varying,
  url character varying,
  CONSTRAINT taxrefv90_utf8_pk PRIMARY KEY (ogc_fid)
);
GRANT ALL ON TABLE refnat.taxrefv90_utf8 TO pg_user;

DROP TABLE IF EXISTS refnat.taxref_changes_90_utf8;
CREATE TABLE refnat.taxref_changes_90_utf8
(
  ogc_fid serial NOT NULL,
  cd_nom character varying,
  num_version_init character varying,
  num_version_final character varying,
  champ character varying,
  valeur_init character varying,
  valeur_final character varying,
  type_change character varying,
  CONSTRAINT taxref_changes_90_utf8_pk PRIMARY KEY (ogc_fid)
);
GRANT ALL ON TABLE refnat.taxref_changes_90_utf8 TO pg_user;

--- Insertion des données
TRUNCATE refnat.taxrefv90_utf8;
-- COPY refnat.taxrefv90_utf8 (regne, phylum, classe, ordre, famille, group1_inpn, group2_inpn, cd_nom, cd_taxsup, cd_sup, cd_ref, rang, lb_nom, lb_auteur, nom_complet, nom_complet_html, nom_valide, nom_vern, nom_vern_eng, habitat, fr, gf, mar, gua, sm, sb, spm, may, epa, reu, taaf, pf, nc, wf, cli, url) FROM '/home/export_pgsql/TAXREFv90.txt' CSV HEADER ENCODING 'UTF-8' DELIMITER E'\t';
COPY refnat.taxrefv90_utf8 (regne, phylum, classe, ordre, famille, group1_inpn, group2_inpn, cd_nom, cd_taxsup, cd_sup, cd_ref, rang, lb_nom, lb_auteur, nom_complet, nom_complet_html, nom_valide, nom_vern, nom_vern_eng, habitat, fr, gf, mar, gua, sm, sb, spm, may, epa, reu, taaf, pf, nc, wf, cli, url) FROM 'D:/tmp/TAXREFv90.txt' CSV HEADER ENCODING 'UTF-8' DELIMITER E'\t';
TRUNCATE refnat.taxref_changes_90_utf8;
-- COPY refnat.taxref_changes_90_utf8 (cd_nom, num_version_init, num_version_final, champ, valeur_init, valeur_final, type_change) FROM '/home/export_pgsql/TAXREF_CHANGES.txt' CSV HEADER ENCODING 'UTF-8' DELIMITER E'\t';
COPY refnat.taxref_changes_90_utf8 (cd_nom, num_version_init, num_version_final, champ, valeur_init, valeur_final, type_change) FROM 'D:/tmp/TAXREF_CHANGES.txt' CSV HEADER ENCODING 'UTF-8' DELIMITER E'\t';
--- Suppression de la faune
DELETE FROM refnat.taxrefv90_utf8 WHERE regne = 'Animalia' OR regne = 'Protozoa' OR regne = 'Bacteria' OR regne IS NULL;
DELETE FROM refnat.taxrefv40_utf8 WHERE regne = '';
DELETE FROM refnat.taxons WHERE regne = 'Animalia' OR regne = 'Protozoa' OR regne = 'Bacteria' OR regne IS NULL;

--- Ajout d'une colonne cd_sup
ALTER TABLE refnat.taxrefv90_utf8 DROP COLUMN IF EXISTS cd_sup;
ALTER TABLE refnat.taxrefv90_utf8 ADD COLUMN cd_sup integer;

ALTER TABLE refnat.taxons DROP COLUMN IF EXISTS cd_sup;
ALTER TABLE refnat.taxons ADD COLUMN cd_sup integer;

--- Ajout des taxons manquants
ALTER TABLE refnat.taxons DROP COLUMN IF EXISTS pres_v9;
ALTER TABLE refnat.taxons ADD COLUMN pres_v9 boolean DEFAULT FALSE;

DELETE FROM refnat.taxons WHERE pres_v2 = FALSE AND pres_v3 = FALSE AND pres_v4 = FALSE AND pres_v5 = FALSE AND pres_v6 = FALSE AND pres_v7 = FALSE AND pres_v8 = FALSE AND pres_v9 = TRUE;
INSERT INTO refnat.taxons (cd_nom, cd_ref, cd_taxsup, cd_sup, rang, regne, phylum, classe, ordre, famille,  lb_nom, lb_auteur, nom_complet,  nom_valide, nom_vern, nom_vern_eng, fr, gf, mar, gua, sm, sb, spm, may, epa, reu, taaf, pf, nc, wf, cli, habitat)
SELECT a.cd_nom::integer, a.cd_ref::integer, a.cd_taxsup::integer, a.cd_sup::integer, a.rang, a.regne, a.phylum, a.classe, a.ordre, a.famille, a.lb_nom, a.lb_auteur, a.nom_complet, a.nom_valide, a.nom_vern, a.nom_vern_eng, a.fr, a.gf, a.mar, a.gua, a.sm, a.sb, a.spm, a.may, a.epa, a.reu, a.taaf, a.pf, a.nc, a.wf, a.cli, CASE WHEN a.habitat = '' THEN NULL ELSE a.habitat::integer END as habitat
FROM refnat.taxrefv90_utf8 a LEFT OUTER JOIN refnat.taxons z ON a.cd_nom::integer = z.cd_nom WHERE z.cd_nom IS NULL; 

--- mise à jour présence dans taxref REFNAT
ALTER TABLE refnat.taxons ALTER pres_v2 SET DEFAULT FALSE;
ALTER TABLE refnat.taxons ALTER pres_v3 SET DEFAULT FALSE;
ALTER TABLE refnat.taxons ALTER pres_v4 SET DEFAULT FALSE;
ALTER TABLE refnat.taxons ALTER pres_v5 SET DEFAULT FALSE;
ALTER TABLE refnat.taxons ALTER pres_v6 SET DEFAULT FALSE;
ALTER TABLE refnat.taxons ALTER pres_v7 SET DEFAULT FALSE;
ALTER TABLE refnat.taxons ALTER pres_v8 SET DEFAULT FALSE;
ALTER TABLE refnat.taxons ALTER pres_v9 SET DEFAULT FALSE;

UPDATE refnat.taxons SET pres_v2 = FALSE WHERE pres_v2 IS NULL;
UPDATE refnat.taxons SET pres_v3 = FALSE WHERE pres_v3 IS NULL;
UPDATE refnat.taxons SET pres_v4 = FALSE WHERE pres_v4 IS NULL;
UPDATE refnat.taxons SET pres_v5 = FALSE WHERE pres_v5 IS NULL;
UPDATE refnat.taxons SET pres_v6 = FALSE WHERE pres_v6 IS NULL;
UPDATE refnat.taxons SET pres_v7 = FALSE WHERE pres_v7 IS NULL;
UPDATE refnat.taxons SET pres_v8 = FALSE WHERE pres_v8 IS NULL;
UPDATE refnat.taxons SET pres_v9 = FALSE WHERE pres_v9 IS NULL;

UPDATE refnat.taxons SET pres_v2 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv20_utf8);
UPDATE refnat.taxons SET pres_v3 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv30_utf8);
UPDATE refnat.taxons SET pres_v4 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv40_utf8);
UPDATE refnat.taxons SET pres_v5 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv50_utf8);
UPDATE refnat.taxons SET pres_v6 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv60_utf8);
UPDATE refnat.taxons SET pres_v7 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv70_utf8);
UPDATE refnat.taxons SET pres_v8 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv80_utf8);
UPDATE refnat.taxons SET pres_v9 = TRUE WHERE cd_nom IN (SELECT cd_nom::integer FROM refnat.taxrefv90_utf8);

-- Mise à jour des taxons en v9
UPDATE refnat.taxons a SET 
	cd_ref = z.cd_ref::integer, cd_taxsup= z.cd_taxsup::integer, rang= z.rang, regne= z.regne , phylum= z.phylum , classe= z.classe , ordre= z.ordre , famille= z.famille , group1_inpn= z.group1_inpn ,group2_inpn= z.group2_inpn , 
	lb_nom= z.lb_nom , lb_auteur= z.lb_auteur , nom_complet= z.nom_complet , nom_complet_html= z.nom_complet_html , nom_valide= z.nom_valide , nom_vern= z.nom_vern , nom_vern_eng= z.nom_vern_eng , habitat= z.habitat::integer , 
	fr= z.fr , gf= z.gf , mar= z.mar , gua= z.gua , sm= z.sm , spm= z.spm , may= z.may , epa= z.epa , reu= z.reu , taaf= z.taaf , pf= z.pf , nc= z.nc ,wf= z.wf , cli= z.cli, url= z.url
       FROM 
(SELECT * FROM refnat.taxrefv90_utf8) as z WHERE a.cd_nom = z.cd_nom::integer
AND pres_v2 = FALSE AND pres_v3 = FALSE AND pres_v4 = FALSE AND pres_v5 = FALSE AND pres_v6 = FALSE AND pres_v7 = FALSE AND pres_v8 = FALSE AND pres_v9 = TRUE;

-- Tableau de synthèse
DELETE FROM referentiels.champs WHERE rubrique_champ = 'refnat' AND nom_champ = 'pres_v9';

UPDATE referentiels.champs SET pos = 14 WHERE rubrique_champ = 'refnat' AND nom_champ = 'modif';
UPDATE referentiels.champs SET pos = 15 WHERE rubrique_champ = 'refnat' AND nom_champ = 'bouton';
UPDATE referentiels.champs SET pos = 16 WHERE rubrique_champ = 'refnat' AND nom_champ = 'checkbox';

INSERT INTO referentiels.champs(rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, 
description_longue, export_display, nom_champ_synthese,champ_interface, modifiable, table_bd, jvs_desc_column, 
jvs_filter_column)
VALUES ('refnat','pres_v9','bool','v9','taxons',null,14, 
'Taxon présent dans taxref v9', TRUE, 'pres_v9', 'pres_v9', FALSE, 'taxons', '{ "sWidth": "5%" }',
'{ "type": "text" }');

UPDATE referentiels.champs SET pos = 15 WHERE rubrique_champ = 'refnat' AND nom_champ = 'modif';
UPDATE referentiels.champs SET pos = 16 WHERE rubrique_champ = 'refnat' AND nom_champ = 'bouton';
UPDATE referentiels.champs SET pos = 17 WHERE rubrique_champ = 'refnat' AND nom_champ = 'checkbox';

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'024',
	--- Numéro du dernier commit (à modifier)
	'cc5fcbd43a242fcf9a6918839816fc4d4d8d9e00', 
	--- Description de la modif BDD (à modifier)
	'Rub Refnat : Création des tables taxref v9 et mise à jour refnat',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();