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


--- Ajout d'une colonne indi_cal au schema lr, table taxons
select 1 into test_schema from information_schema.schemata where schema_name='lr';
CASE 
WHEN test_schema =1 THEN 	ALTER TABLE lr.taxons DROP COLUMN IF EXISTS indi_cal;
			ALTER TABLE  lr.taxons ADD COLUMN indi_cal character varying;
--			RETURN NEXT 'la colonne indi_cal a été ajoutée à taxons';
			
ELSE 			--RETURN NEXT 'la colonne indi_cal a été ajoutée à taxons';
END CASE;

--remplissage de la colonne si le schema catnat existe aussi
select 1 into test_schema from information_schema.schemata where schema_name='catnat';
CASE
WHEN test_schema =1 THEN      update lr.taxons set indi_cal= ( select indi_cal from catnat.statut_nat where statut_nat.uid=taxons.uid);
			--RETURN NEXT 'la colonne indi_cal a été remplie à partir du schema catnat';
ELSE 			--RETURN NEXT 'la colonne indi_cal n''a pas pu être remplie car le schema catnat n''existe pas';
END CASE;

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN /*NEXT*/ 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'025',
	--- Numéro du dernier commit (à modifier)
	'a6cc0e851d0165306c271ec731662414e2cd62a4', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : ajout d''un champ indi_cal à la table lr.taxons et remplissage avec les valeurs de la colonne indi_cal de catnat.statut_nat ',
	--- Date (à ne pas modifier)
	NOW());
RETURN /*NEXT*/ 'OK';
ELSE RETURN /*NEXT*/ 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();