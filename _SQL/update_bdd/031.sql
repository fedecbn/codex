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
phase = 'test';
--phase = 'prod';
---## user_codex est l'utilisateur du codex (décommentez la ligne suivante si besoin) ##--
user_codex = 'pg_user';
----------------------------------------------------

--- 1. Code permettant la mise à jour


--- modification du referentiel pour le schema syntaxa
select 1 into test_schema from information_schema.schemata where schema_name='syntaxa';
CASE 
WHEN test_schema =1 THEN 	DROP TABLE IF EXISTS syntaxa.st_ref_geomorpho cascade;

							CREATE TABLE syntaxa.st_ref_geomorpho
							(
							  "idGeomorphologie" serial NOT NULL, -- identifiant du taxon géomorphologique
							  "domaine" text, 
							  "taxon" text,
							  "sous_taxon" text, 
							  id_tri serial NOT NULL
							)
							WITH (
							  OIDS=FALSE
							);
							ALTER TABLE syntaxa.st_ref_geomorpho
							  OWNER TO user_codex;
							GRANT ALL ON TABLE syntaxa.st_ref_geomorpho TO user_codex;
							COMMENT ON TABLE syntaxa.st_ref_geomorpho
							  IS 'Référentiel géomorphologique';
							COMMENT ON COLUMN syntaxa.st_ref_geomorpho."idGeomorphologie" IS 'identifiant de la géomorphologie';
							COMMENT ON COLUMN syntaxa.st_ref_geomorpho."domaine" IS 'domaine géomorphologique';
							COMMENT ON COLUMN syntaxa.st_ref_geomorpho."taxon" IS 'taxon géomorphologique';
							COMMENT ON COLUMN syntaxa.st_ref_geomorpho."sous_taxon" IS 'sous-taxon géomorphologique';
							COMMENT ON COLUMN syntaxa.st_ref_geomorpho.id_tri IS 'Colonne de tri pour les menus déroulants de l''application codex ,0 correspond à non indiqué';


							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage meso  littoral','slikke (vase)');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage meso  littoral','schorre (herbu) ');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage meso  littoral','plage');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage supra littoral','Falaise');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage supra littoral','lido/cordon');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage supra littoral','Grau');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage supra littoral','Etang littoral');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('littoral','Etage supra littoral','lagune');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Embouchure','Estuaire');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Embouchure','Delta');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','lit majeur');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','lit mineur');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','meandre');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','Cone de déjection');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','tresses');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','levée');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','chenal , bras mort');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('fleuves et rivières','Dynamique alluviale','terrasse alluviale');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('Eaux stagnantes','non végétalisées','lac');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('Eaux stagnantes','non végétalisées','mare');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('Eaux stagnantes','Végétalisées','marais');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('Eaux stagnantes','Végétalisées','Tourbière');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('Eaux stagnantes','Végétalisées','polder');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('Eolien','','dune');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('Eolien','','loess');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','moraines');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','lacs proglaciaires');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','chenal proglaciaire');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','Couloir avalanche');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','cone avalanche');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','Ligne des neiges permanente');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','cirques de névé');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('glaciers, neige','','pavage');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','clapiers');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','pergélisol');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','couche active');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','pipkrake, aiguilles de glace');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','fentes de gel');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','cercles de pierre');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','ostioles');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','tufur');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','terrrassettes');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','Grezes');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','glacier rocheux');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('periglaciaire','','eboulis');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','lapiaz');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','dolines');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','polje');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','Tuf/travertins');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','resurgences');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','mesa');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','neck');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','cones scories');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','Tors');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','Tafoni');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','chaos de boules');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','Arène');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','Arène à blocs Heads');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('lithologie et tectonique','','Arène litées');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('anthropique','','terrassettes');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('anthropique','','terrasses de culture');
							INSERT INTO syntaxa.st_ref_geomorpho("domaine","taxon" ,"sous_taxon") VALUES ('anthropique','','pieds de vache');


							DELETE FROM referentiels.champs_ref where nom_ref='st_ref_geomorpho';
							INSERT INTO referentiels.champs_ref ( nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref, where_champ, where_value) VALUES ( 'st_ref_geomorpho', 'idGeomorphologie', 'sous_taxon', 'syntaxa', 'st_ref_geomorpho', 'id_tri', 'syntaxa', NULL, NULL);


							-- RETURN NEXT 'la table referentiels.champs_ref a été modifiée pour avoir l'accès aux régions dans le module syntaxa indépendamment de l'installation du module eee';
			
ELSE 			--RETURN NEXT 'la colonne indi_cal a été ajoutée à taxons';
END CASE;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN /*NEXT*/ 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'031',
	--- Numéro du dernier commit (à modifier)
	'4dd1403c2d19af277da6f1256dfbc3f6597d0918', 
	--- Description de la modif BDD (à modifier)
	'Rub syntaxa : mise à jour de la table de référentiel géomorphologique ',
	--- Date (à ne pas modifier)
	NOW());
RETURN /*NEXT*/ 'OK';
ELSE RETURN /*NEXT*/ 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();


