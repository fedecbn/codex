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
-- user_codex = 'pg_user';
----------------------------------------------------

--- 1. Code permettant la mise à jour


--- modification du referentiel pour le schema syntaxa
select 1 into test_schema from information_schema.schemata where schema_name='syntaxa';
CASE 
WHEN test_schema =1 THEN 	DROP TABLE IF EXISTS syntaxa.st_cortege_floristique cascade;
							CREATE TABLE syntaxa.st_cortege_floristique(
							"idCortegeFloristique" serial not null,
							"codeEnregistrementSyntaxon" text,
							"idRattachementReferentiel" text,
							"typeTaxon" text,
							"code_referentiel" text,
							"version_referentiel" text,
							"cd_ref" text,
							"nom_complet" text,
							"rqTaxon" text
							);
							-- ddl-end --
							COMMENT ON TABLE syntaxa.st_cortege_floristique IS 'Cortège floristique qui accompagne le syntaxon';
							COMMENT ON COLUMN syntaxa.st_cortege_floristique."idCortegeFloristique" IS 'identifiant unique du taxon dans le cortège floristique';
							COMMENT ON COLUMN syntaxa.st_cortege_floristique."codeEnregistrementSyntaxon" IS 'code de l''enregistrement du syntaxon';
							COMMENT ON COLUMN syntaxa.st_cortege_floristique."idRattachementReferentiel" IS 'identifiant du rattachement au référentiel';
							COMMENT ON COLUMN syntaxa.st_cortege_floristique."typeTaxon" IS 'indique si le taxon est caractéristique ou différentiel';
							grant all on TABLE syntaxa."st_cortege_floristique_idCortegeFloristique_seq" TO user_codex;
							GRANT ALL PRIVILEGES ON syntaxa.st_cortege_floristique TO user_codex;
							-- RETURN NEXT 'la table referentiels.champs_ref a été modifiée pour avoir l'accès aux régions dans le module syntaxa indépendamment de l'installation du module eee';
			
ELSE 			--RETURN NEXT 'la colonne indi_cal a été ajoutée à taxons';
END CASE;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN /*NEXT*/ 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'028',
	--- Numéro du dernier commit (à modifier)
	'484dc5581bd02360fe7daf791867560e3271ed4f', 
	--- Description de la modif BDD (à modifier)
	'Rub syntaxa : modification de la table syntaxa.st_cortege_floristique pour avoir une clef primaire de type serial not null ',
	--- Date (à ne pas modifier)
	NOW());
RETURN /*NEXT*/ 'OK';
ELSE RETURN /*NEXT*/ 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();


