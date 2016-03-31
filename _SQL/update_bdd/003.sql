CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS 
$BODY$ BEGIN

--- 1. Code permettant la mise à jour
ALTER TABLE fsd.voca_ctrl ADD COLUMN used boolean DEFAULT FALSE;
UPDATE fsd.voca_ctrl SET used = true 
WHERE "typChamp" = 'cd_refgeo'
OR "typChamp" = 'cd_sensi'
OR "typChamp" = 'cd_validite'
OR "typChamp" = 'confiance_geo'
OR "typChamp" = 'meth_releve'
OR "typChamp" = 'moyen_geo'
OR "typChamp" = 'nature_date'
OR "typChamp" = 'nature_geo'
OR "typChamp" = 'origine_geo'
OR "typChamp" = 'propriete_obs'
OR "typChamp" = 'statut_pop'
OR "typChamp" = 'typ_acteur'
OR "typChamp" = 'typ_ent'
OR "typChamp" = 'typ_geo'
OR "typChamp" = 'typ_jdd'
OR "typChamp" = 'typ_protocole'
OR "typChamp" = 'typ_source'
OR "typChamp" = 'typ_statut';

--- 2. Pour le suivi des mises à jours
INSERT INTO applications.update_bdd (id, commit, descr, date) VALUES (
	--- Numero du fichier (à modifier)
	'003',
	--- Numéro du dernier commit (à modifier)
	'd6b1c1215bc1c79fa78ea9978d60e686ded8de1b', 
	--- Description de la modif BDD (à modifier)
	'Rub FSD : gestion des vocabulaire contrôlé utilisé ou non - afin de garder en mémoire les vocabulaire contrôlé non utilisé',
	--- Date (à ne pas modifier)
	NOW());

RETURN 'OK';END;$BODY$ LANGUAGE plpgsql;
SELECT * FROM update_bdd();