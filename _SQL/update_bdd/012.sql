CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ 
DECLARE phase varchar;
BEGIN
--- pour tester la fonction
-- phase = 'test';
phase = 'prod';

--- 1. Code permettant la mise à jour
--- Mise à jour du tableau de synthèse
UPDATE referentiels.champs SET pos=null WHERE rubrique_champ='lr' AND nom_champ='cd_ref';
UPDATE referentiels.champs SET pos=0 WHERE rubrique_champ='lr' AND nom_champ='etape';
UPDATE referentiels.champs SET pos=1 WHERE rubrique_champ='lr' AND nom_champ='avancement';
UPDATE referentiels.champs SET pos=2 WHERE rubrique_champ='lr' AND nom_champ='famille';

UPDATE referentiels.champs SET description_longue=description WHERE rubrique_champ='lr' AND pos IS NOT NULL;
UPDATE referentiels.champs SET description='Etape' WHERE rubrique_champ='lr' AND nom_champ='etape';
UPDATE referentiels.champs SET description='Famille' WHERE rubrique_champ='lr' AND nom_champ='famille';
UPDATE referentiels.champs SET description='CD_REF', description_longue = 'Code du taxon de référence' WHERE rubrique_champ='lr' AND nom_champ='CD_REF';
UPDATE referentiels.champs SET description='Nom scien', description_longue = 'Nom scientifique du taxon' WHERE rubrique_champ='lr' AND nom_champ='nom_sci';
UPDATE referentiels.champs SET description='Rang', description_longue = 'Rang taxonomique du taxon' WHERE rubrique_champ='lr' AND nom_champ='id_rang';
UPDATE referentiels.champs SET description='Indig.', description_longue = 'Statut indigénat du taxon en métropole' WHERE rubrique_champ='lr' AND nom_champ='id_indi';
UPDATE referentiels.champs SET description='Endém', description_longue = 'Endémisme du taxon en métropole' WHERE rubrique_champ='lr' AND nom_champ='endemisme';
UPDATE referentiels.champs SET description='AOO', description_longue = 'Zone occupation estimée après 1990_2x2' WHERE rubrique_champ='lr' AND nom_champ='aoo4';
UPDATE referentiels.champs SET description='AOO tot', description_longue = 'Zone occupation ajustée après 1990 pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes' WHERE rubrique_champ='lr' AND nom_champ='aoo_precis';
UPDATE referentiels.champs SET description='Nb loc.', description_longue = 'Nb de localités >= 1990' WHERE rubrique_champ='lr' AND nom_champ='nbloc_precis';
UPDATE referentiels.champs SET description='Nb mailles >1990', description_longue = 'Nombre de mailles 5km²>=1990 ajustée pour prendre en compte Lorraine, Alsace, Corse, Aquitaine, Poitou Charentes' WHERE rubrique_champ='lr' AND nom_champ='nbm5_post1990_est';
UPDATE referentiels.champs SET description='Cat<br>A', description_longue = 'Catégorie la plus élevée selon le critère A' WHERE rubrique_champ='lr' AND nom_champ='cat_a';
UPDATE referentiels.champs SET description='Cat<br>B2', description_longue = 'Catégorie la plus élévee selon le critère B2' WHERE rubrique_champ='lr' AND nom_champ='cat_b';
UPDATE referentiels.champs SET description='Cat<br>C', description_longue = 'Catégorie la plus élévee selon le critère C' WHERE rubrique_champ='lr' AND nom_champ='cat_c';
UPDATE referentiels.champs SET description='Cat<br>D', description_longue = 'Catégorie la plus élévee selon le critère D' WHERE rubrique_champ='lr' AND nom_champ='cat_d';
UPDATE referentiels.champs SET description='Cat<br>Fin', description_longue = 'Catégorie proposée pour la Liste rouge nationale après ajustement' WHERE rubrique_champ='lr' AND nom_champ='cat_fin';
UPDATE referentiels.champs SET description='Crit<br>Fin', description_longue = 'Critère(s) proposé(s) pour la Liste rouge nationale' WHERE rubrique_champ='lr' AND nom_champ='just_fin';
<<<<<<< HEAD
UPDATE referentiels.champs SET description='Cat<br>EU', description_longue = 'Catégorie UICN à l échelle de l Europe géographique' WHERE rubrique_champ='lr' AND nom_champ='cat_euro';
=======
UPDATE referentiels.champs SET description='Cat<br>EU', description_longue = 'Catégorie UICN à l échelle de l Europe géographique' WHERE rubrique_champ='lr' AND nom_champ='cat_euro';
>>>>>>> f1ca3f027cb594485f6733cad78a2e8585f764c1
UPDATE referentiels.champs SET description='Cat<br>Reg', description_longue = 'Synthèse des Catégories UICN issue des évaluations régionales' WHERE rubrique_champ='lr' AND nom_champ='cat_synt_reg';
UPDATE referentiels.champs SET description='Nb<br>reg', description_longue = 'Nombre de régions ayant une évaluation régionale pour ce taxon' WHERE rubrique_champ='lr' AND nom_champ='nb_reg_evalue';
UPDATE referentiels.champs SET description='Note', description_longue = 'Notes explicative évaluation' WHERE rubrique_champ='lr' AND nom_champ='notes';
UPDATE referentiels.champs SET description='Avancement', description_longue = 'Avancement évaluation' WHERE rubrique_champ='lr' AND nom_champ='avancement';


--- 2. Pour le suivi des mises à jours
CASE phase 
WHEN 'test' THEN RETURN 'Test OK';
WHEN 'prod' THEN
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'012',
	--- Numéro du dernier commit (à modifier)
	'5e054ad8854fdff2755ed06e0235b609e2f4cd5b', 
	--- Description de la modif BDD (à modifier)
	'Rub LR : réorganisation tableau de synthese et ajout',
	--- Date (à ne pas modifier)
	NOW());
RETURN 'OK';
ELSE RETURN 'Verifier la phase dans le code';
END CASE;

END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();