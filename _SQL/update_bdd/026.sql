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


--- modification du referentiel pour le schema catnat
select 1 into test_schema from information_schema.schemata where schema_name='catnat';
CASE 
WHEN test_schema =1 THEN 	update referentiels.champs_ref set cle='id_reg', valeur='nom_reg', schema='referentiels', table_ref='regions' where nom_ref='region' and rubrique_ref='catnat';
--			RETURN NEXT 'la table referentiels.champs_ref a été modifiée pour avoir l'accès aux régions dans le module catnat indépendamment de l'installation du module eee';
			
ELSE 			--RETURN NEXT 'la colonne indi_cal a été ajoutée à taxons';
END CASE;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN /*NEXT*/ 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'026',
	--- Numéro du dernier commit (à modifier)
	'8e909ff30b0950cb71b4bf53404a994b713c7a0d', 
	--- Description de la modif BDD (à modifier)
	'Rub CATNAT : modification de la table referentiels.champs_ref pour que le référentiel des régions pointe vers le schema referentiels et non plus le schema eee (dans le cas où celui ci n''est pas installé) ',
	--- Date (à ne pas modifier)
	NOW());
RETURN /*NEXT*/ 'OK';
ELSE RETURN /*NEXT*/ 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();