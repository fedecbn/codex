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
WHEN test_schema =1 THEN 	delete from syntaxa.referentiel_taxo where version_referentiel = '5' or version_referentiel = '' or version_referentiel = '8' ;
--			RETURN NEXT 'la table referentiels.champs_ref a été modifiée pour avoir l'accès aux régions dans le module syntaxa indépendamment de l'installation du module eee';
			
ELSE 			--RETURN NEXT 'la colonne indi_cal a été ajoutée à taxons';
END CASE;


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN /*NEXT*/ 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'027',
	--- Numéro du dernier commit (à modifier)
	'59c030fc067b48b0f597b2d5a745f9b16c94c972', 
	--- Description de la modif BDD (à modifier)
	'Rub syntaxa : modification de la table syntaxa.referentiel_taxo pour n''avoir que la version 7 du référentiel taxref ',
	--- Date (à ne pas modifier)
	NOW());
RETURN /*NEXT*/ 'OK';
ELSE RETURN /*NEXT*/ 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();


