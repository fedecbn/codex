--DROP FUNCTION  update_bdd();
CREATE OR REPLACE FUNCTION update_bdd() RETURNS /*setof*/ varchar AS 
$BODY$ 
DECLARE phase varchar;
DECLARE user_codex varchar;
DECLARE test_schema integer;
BEGIN
----------------------------------------------------
------VARIABLES A DÉFINIR---------------------------
---## Pour tester la fonction. Une fois que vous souhaiter enregistrer la modif dans la table update_bdd, mettre la phase en "prod" ##--
--phase = 'test';
phase = 'prod';
---## user_codex est l'utilisateur du codex (décommentez la ligne suivante si besoin) ##--
user_codex = 'pg_user';
----------------------------------------------------

--- 1. Code permettant la mise à jour


--- modification du referentiel pour le schema syntaxa
select 1 into test_schema from information_schema.schemata where schema_name='syntaxa';
CASE 
WHEN test_schema =1 THEN 	DROP TABLE IF EXISTS syntaxa.st_ref_type_taxon cascade;

							CREATE TABLE syntaxa.st_ref_type_taxon
							(
							  "codeTypeTaxon" text NOT NULL, -- code du type de faciès
							  "libTypeTaxon" text, -- libelle du type de faciès
							  "libLongTypeTaxon" text, -- libelle long du type de faciès
							  id_tri serial NOT NULL,
							  CONSTRAINT "codeTypeTaxon_pkey" PRIMARY KEY ("codeTypeTaxon")
							)
							WITH (
							  OIDS=FALSE
							);
							EXECUTE 'ALTER TABLE syntaxa.st_ref_type_taxon OWNER TO '||user_codex||';';
							EXECUTE 'GRANT ALL PRIVILEGES ON syntaxa.st_ref_type_taxon TO '||user_codex||';';
							COMMENT ON TABLE syntaxa.st_ref_type_taxon IS 'Référentiel des types de taxons';
							COMMENT ON COLUMN syntaxa.st_ref_type_taxon."codeTypeTaxon" IS 'code du type de taxon';
							COMMENT ON COLUMN syntaxa.st_ref_type_taxon."libTypeTaxon" IS 'libelle du type de taxon';
							COMMENT ON COLUMN syntaxa.st_ref_type_taxon."libLongTypeTaxon" IS 'libelle long du type de taxon';

							INSERT INTO syntaxa.st_ref_type_taxon ("codeTypeTaxon", "libTypeTaxon", "libLongTypeTaxon", id_tri) VALUES ('cara', 'Caractéristique', 'taxon caractéristique', 1);
							INSERT INTO syntaxa.st_ref_type_taxon ("codeTypeTaxon", "libTypeTaxon", "libLongTypeTaxon", id_tri) VALUES ('diff', 'Différentiel', 'taxon différentiel', 2);
							INSERT INTO syntaxa.st_ref_type_taxon ("codeTypeTaxon", "libTypeTaxon", "libLongTypeTaxon", id_tri) VALUES ('NI', 'non indiqué', 'non indiqué', 0);

							DELETE FROM referentiels.champs where table_champ='st_ref_type_taxon';
							INSERT INTO referentiels.champs (rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd, jvs_desc_column, jvs_filter_column) VALUES ('syntaxa', 'codeTypeTaxon', 'string', 'code du type de taxon', 'st_ref_type_taxon', NULL, NULL, 'code du type de taxon', false, 'codeTypeTaxon', 'codeTypeTaxon', true, 'st_ref_type_taxon', '{ "sWidth": "5%" }', '{ "type": "text" }');
							INSERT INTO referentiels.champs (rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd, jvs_desc_column, jvs_filter_column) VALUES ('syntaxa', 'libTypeTaxon', 'string', 'libelle du type de taxon', 'st_ref_type_taxon', NULL, NULL, 'libelle du type de taxon', false, 'libTypeTaxon', 'libTypeTaxon', true, 'st_ref_type_taxon', '{ "sWidth": "5%" }', '{ "type": "text" }');
							INSERT INTO referentiels.champs (rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd, jvs_desc_column, jvs_filter_column) VALUES ('syntaxa', 'libLongTypeTaxon', 'string', 'libelle long du type de taxon', 'st_ref_type_taxon', NULL, NULL, 'libelle long du type de taxon', false, 'libLongTypeTaxon', 'libLongTypeTaxon', true, 'st_ref_type_taxon', '{ "sWidth": "5%" }', '{ "type": "text" }');

							DELETE FROM referentiels.champs_ref where nom_ref='st_ref_type_taxon';
							INSERT INTO referentiels.champs_ref ( nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref, where_champ, where_value) VALUES ( 'st_ref_type_taxon', 'codeTypeTaxon', 'libTypeTaxon', 'syntaxa', 'st_ref_type_taxon', 'id_tri', 'syntaxa', NULL, NULL);

							UPDATE referentiels.champs set referentiel='st_ref_type_taxon' where nom_champ='typeTaxon';

							-- RETURN NEXT 'la table referentiels.champs_ref a été modifiée pour avoir l'accès aux régions dans le module syntaxa indépendamment de l'installation du module eee';
			
ELSE 			--RETURN NEXT 'la colonne indi_cal a été ajoutée à taxons';
END CASE;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN /*NEXT*/ 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'030',
	--- Numéro du dernier commit (à modifier)
	'4dd1403c2d19af277da6f1256dfbc3f6597d0918', 
	--- Description de la modif BDD (à modifier)
	'Rub syntaxa : ajout d''un référentiel des types de taxons (caractéristique ou différentiel) pour le module cortege floristique ',
	--- Date (à ne pas modifier)
	NOW());
RETURN /*NEXT*/ 'OK';
ELSE RETURN /*NEXT*/ 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();


