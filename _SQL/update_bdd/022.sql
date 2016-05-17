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
UPDATE referentiels.champs SET description_longue=description WHERE description_longue IS NULL;

-- Refnat
UPDATE referentiels.champs SET description='Id' WHERE rubrique_champ='refnat'AND nom_champ='uid';
UPDATE referentiels.champs SET description='Cd_nom' WHERE rubrique_champ='refnat'AND nom_champ='cd_nom';
UPDATE referentiels.champs SET description='Cd_ref' WHERE rubrique_champ='refnat'AND nom_champ='cd_ref';
UPDATE referentiels.champs SET description='Nom Complet' WHERE rubrique_champ='refnat'AND nom_champ='nom_complet';
UPDATE referentiels.champs SET description='Rang' WHERE rubrique_champ='refnat'AND nom_champ='rang';
UPDATE referentiels.champs SET description='Groupe' WHERE rubrique_champ='refnat'AND nom_champ='group2_inpn';
UPDATE referentiels.champs SET description='v2' WHERE rubrique_champ='refnat'AND nom_champ='pres_v2';
UPDATE referentiels.champs SET description='v3' WHERE rubrique_champ='refnat'AND nom_champ='pres_v3';
UPDATE referentiels.champs SET description='v4' WHERE rubrique_champ='refnat'AND nom_champ='pres_v4';
UPDATE referentiels.champs SET description='v5' WHERE rubrique_champ='refnat'AND nom_champ='pres_v5';
UPDATE referentiels.champs SET description='v6' WHERE rubrique_champ='refnat'AND nom_champ='pres_v6';
UPDATE referentiels.champs SET description='v7' WHERE rubrique_champ='refnat'AND nom_champ='pres_v7';
UPDATE referentiels.champs SET description='v8' WHERE rubrique_champ='refnat'AND nom_champ='pres_v8';
UPDATE referentiels.champs SET description='Modif' WHERE rubrique_champ='refnat'AND nom_champ='modif';

-- Catnat
UPDATE referentiels.champs SET description='Endem.' WHERE rubrique_champ='catnat'AND nom_champ='endemisme';
UPDATE referentiels.champs SET description='Ind. rareté' WHERE rubrique_champ='catnat'AND nom_champ='rarete';
UPDATE referentiels.champs SET description='Cd_ref' WHERE rubrique_champ='catnat'AND nom_champ='cd_ref';

-- Lr
UPDATE referentiels.champs SET description='Nb. maille' WHERE rubrique_champ='lr'AND nom_champ='nbm5_post1990_est';

-- eee
UPDATE referentiels.champs SET description='Cd_ref' WHERE rubrique_champ='eee'AND nom_champ='cd_ref';
UPDATE referentiels.champs SET description='FR' WHERE rubrique_champ='eee'AND nom_champ_synthese='presence';
UPDATE referentiels.champs SET description='Invas.' WHERE rubrique_champ='eee'AND nom_champ_synthese='invav';
UPDATE referentiels.champs SET description='Lavergne' WHERE rubrique_champ='eee'AND nom_champ_synthese='lavergne';
UPDATE referentiels.champs SET description='Risq. intro.' WHERE rubrique_champ='eee'AND nom_champ='ind_a';
UPDATE referentiels.champs SET description='Risq. propa.' WHERE rubrique_champ='eee'AND nom_champ='ind_b';
UPDATE referentiels.champs SET description='Risq. impact' WHERE rubrique_champ='eee'AND nom_champ='ind_c';
UPDATE referentiels.champs SET description='Weber' WHERE rubrique_champ='eee'AND nom_champ='ind_tot';
UPDATE referentiels.champs SET description='Evaluation' WHERE rubrique_champ='eee'AND nom_champ='eval_tot';
UPDATE referentiels.champs SET description='Fiab.' WHERE rubrique_champ='eee'AND nom_champ='fiab_tot';
UPDATE referentiels.champs SET description='Liste', description_longue = 'appartenance à une liste EEE' WHERE rubrique_champ='eee'AND nom_champ='liste_eval';
UPDATE referentiels.champs SET description='Esp. émerg.' WHERE rubrique_champ='eee'AND nom_champ='carac_emerg';
UPDATE referentiels.champs SET description='Esp. inva.' WHERE rubrique_champ='eee'AND nom_champ='carac_avere';
UPDATE referentiels.champs SET description='Exp.' WHERE rubrique_champ='eee'AND nom_champ='eval_expert';
UPDATE referentiels.champs SET description='Doc GBIF' WHERE rubrique_champ='eee'AND nom_champ='gbif_url';

UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "6%" }' WHERE rubrique_champ='eee'AND pos=0;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "20%" }' WHERE rubrique_champ='eee'AND pos=1;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "5%" }' WHERE rubrique_champ='eee'AND pos=2;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }' WHERE rubrique_champ='eee'AND pos=3;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }' WHERE rubrique_champ='eee'AND pos=4;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }' WHERE rubrique_champ='eee'AND pos=5;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }' WHERE rubrique_champ='eee'AND pos=6;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }' WHERE rubrique_champ='eee'AND pos=7;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "4%" }' WHERE rubrique_champ='eee'AND pos=8;
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "eval","sWidth": "6%"}' WHERE rubrique_champ='eee'AND pos=9;
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "eval","sWidth": "8%"}' WHERE rubrique_champ='eee'AND pos=10;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "6%" }' WHERE rubrique_champ='eee'AND pos=11;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "5%" }' WHERE rubrique_champ='eee'AND pos=12;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "5%" }' WHERE rubrique_champ='eee'AND pos=13;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }' WHERE rubrique_champ='eee'AND pos=14;
UPDATE referentiels.champs SET jvs_desc_column='{ "sWidth": "3%" }' WHERE rubrique_champ='eee'AND pos=15;
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%","bSortable": false }' WHERE rubrique_champ='eee'AND pos=16;
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%","bSortable": false }' WHERE rubrique_champ='eee'AND pos=17;
UPDATE referentiels.champs SET jvs_desc_column='{ "sClass": "center","sWidth": "3%","bSortable": false }' WHERE rubrique_champ='eee'AND pos=18;

UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=0;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=1;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "select", "values": ["ES","SSES","VAR","SVAR","FO","SSFO"] }' WHERE rubrique_champ='eee'AND pos=2;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "select", "values": ["oui","non"] }' WHERE rubrique_champ='eee'AND pos=3;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "select", "values": ["oui","non"] }' WHERE rubrique_champ='eee'AND pos=4;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=5;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=6;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=7;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=8;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=9;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "select", "values" : [{ "value": "not_null", "label": "évalué"},{ "value": "Insuffisamment documenté", "label": "Insuffisamment documenté"},{ "value": "FAIBLE", "label": "FAIBLE"},{ "value": "INTERMEDIAIRE", "label": "INTERMEDIAIRE"},{ "value": "FORT", "label": "FORT"}] }' WHERE rubrique_champ='eee'AND pos=10;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=11;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "select", "values" : [{ "value": "pcpl", "label": "principale"},{ "value": "annexe", "label": "annexe"}] }' WHERE rubrique_champ='eee'AND pos=12;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "select", "values" : [{ "value": "emerg", "label": "emmergent"},{ "value": "non_emerg", "label": "nom_emergent"}] }' WHERE rubrique_champ='eee'AND pos=13;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "select", "values" : [{ "value": "avere_local", "label": "localement"},{ "value": "avere_ailleurs", "label": "ailleurs"},{ "value": "non_avere", "label": "non avere"}] }' WHERE rubrique_champ='eee'AND pos=14;
UPDATE referentiels.champs SET jvs_filter_column='{ "type": "text" }' WHERE rubrique_champ='eee'AND pos=15;

-- Lsi
UPDATE referentiels.champs SET description='Id' WHERE rubrique_champ='lsi'AND nom_champ='id';
UPDATE referentiels.champs SET description='Sujet' WHERE rubrique_champ='lsi'AND nom_champ='id_subject';
UPDATE referentiels.champs SET description='Titre' WHERE rubrique_champ='lsi'AND nom_champ='title';
UPDATE referentiels.champs SET description='Résumé' WHERE rubrique_champ='lsi'AND nom_champ='abstract';
UPDATE referentiels.champs SET description='Mots-clé' WHERE rubrique_champ='lsi'AND nom_champ='libelle_tag';
UPDATE referentiels.champs SET description='Lien 1' WHERE rubrique_champ='lsi'AND nom_champ='link';
UPDATE referentiels.champs SET description='Lien 2' WHERE rubrique_champ='lsi'AND nom_champ='link_2';
UPDATE referentiels.champs SET description='Date', description_longue='date de la création du billet' WHERE rubrique_champ='lsi'AND nom_champ='date';


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'022',
	--- Numéro du dernier commit (à modifier)
	'9f7353eee5c023e029be566bddca364e05f67576', 
	--- Description de la modif BDD (à modifier)
	'Metamodele description referentiel.champ améliorée',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();