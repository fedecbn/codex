CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
DECLARE user_codex varchar;
DECLARE tableau_array varchar[];
DECLARE rub varchar;
BEGIN
----------------------------------------------------
------VARIABLES A DÉFINIR---------------------------
---## Pour tester la fonction. Une fois que vous souhaiter enregistrer la modif dans la table update_bdd, mettre la phase en "prod" ##--
phase = 'test';
-- phase = 'prod';
---## user_codex est l'utilisateur du codex (décommentez la ligne suivante si besoin) ##--
-- user_codex = 'pg_user';
----------------------------------------------------

tableau_array = ARRAY['refnat','hub','eee','catnat','fsd','syntaxa','lsi','eee_reg','data','taxa','meta'];
FOREACH rub IN ARRAY tableau_array LOOP
EXECUTE 'DELETE FROM referentiels.champs WHERE rubrique_champ='''||rub||''' AND (nom_champ=''bouton'' OR nom_champ=''checkbox'');';
EXECUTE 'INSERT INTO referentiels.champs (rubrique_champ, nom_champ,  nom_champ_synthese, champ_interface, type,  pos, table_champ, table_bd,export_display, modifiable,description, description_longue,jvs_desc_column) VALUES  
('''||rub||''', ''bouton'', ''bouton'', ''bouton'', ''bouton'', (SELECT max(pos)+1 FROM referentiels.champs WHERE rubrique_champ='''||rub||''') , null, null,  TRUE,  TRUE,  ''Fiche'', ''Accès à la fiche'',''{ "sClass": "center","sWidth": "3%","bSortable": false }''), 
('''||rub||''', ''checkbox'', ''checkbox'', ''checkbox'', ''checkbox'', (SELECT max(pos)+2 FROM referentiels.champs WHERE rubrique_champ='''||rub||'''), null, null,  TRUE,  TRUE,  ''<input type=checkbox class=liste-all value=1 >'', ''Selectionner tout'',''{ "sClass": "center","sWidth": "3%","bSortable": false }''); 
';
END LOOP;

--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'021',
	--- Numéro du dernier commit (à modifier)
	'1a64ecddb26d2654270a53b95900dada3d358cad', 
	--- Description de la modif BDD (à modifier)
	'update_bdd : generalisation des droits boutons tableau de synthèse',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();