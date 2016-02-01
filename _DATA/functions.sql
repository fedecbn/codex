------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--- new_rubrique
--- Description : Fonction permettant d'initialiser une nouvelle rubrique du Codex
--- Variables :
--- o id_module : identifiant pour le module (par exemple : 'lr' - nb : sera utilisé comme nom du schema et du répertoire pour la rubrique)
--- o titre_module : titre du module (par exemple : 'Liste rouge')
--- o utilisateur_codex : Utilisateur dans le codex (par défaut 'admin')
--- o utilisateur_bdd : Utilisateur utilisé par la base de données (par défaut 'user_codex')
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION new_rubrique (id_module varchar,titre_module varchar, utilisateur_codex varchar, utilisateur_bdd varchar) RETURNS varchar AS  
$BODY$  
DECLARE maxpos int;
BEGIN
SELECT max(pos) INTO maxpos FROM applications.rubrique;

EXECUTE '
--- ajout de la rubrique dans le schema application
INSERT INTO applications.pres(id_module, page, titre, pres, lang) VALUES ('''||id_module||''', ''header'', '''||titre_module||''', null, 0);
INSERT INTO applications.pres(id_module, page, titre, pres, lang) VALUES ('''||id_module||''', ''footer'', '''||titre_module||''', ''---'', 0);
INSERT INTO applications.rubrique("id_module", "pos", "icone", "titre", "descr", "niveau", "link", "lang")
    VALUES ('''||id_module||''', '||maxpos+1||', ''saisie.png'', '''||titre_module||''', null, 1, ''../'||id_module||'/index.php'', 0);

---nouvelles colonnes dans les droits
ALTER TABLE applications.utilisateur ADD COLUMN niveau_'||id_module||' smallint DEFAULT 0;
ALTER TABLE applications.utilisateur ADD COLUMN ref_'||id_module||' boolean DEFAULT FALSE;
';

EXECUTE'UPDATE applications.utilisateur SET niveau_'||id_module||' = 255 , ref_'||id_module||' = TRUE WHERE id_user = '''||utilisateur_codex||''';';

EXECUTE '
--- Nouveau schema
CREATE SCHEMA '||id_module||' AUTHORIZATION '||utilisateur_bdd||';
CREATE TABLE '||id_module||'.base
(
  uid integer NOT NULL,
  info_text character varying,
  info_real real,
  info_int integer,
  info_bool boolean,
  CONSTRAINT '||id_module||'_pkey PRIMARY KEY (uid)
) WITH (OIDS=FALSE);
ALTER TABLE '||id_module||'.base OWNER TO '||utilisateur_bdd||';
';

SELECT max(pos) + 1 INTO maxpos FROM referentiels.champs WHERE rubrique_champ = 'utilisateur' AND nom_champ LIKE 'niveau_%';
EXECUTE '
--- nouvelles colonnes - niveau de droit - référentiels
INSERT INTO referentiels.champs(rubrique_champ, nom_champ, type, description, table_champ, pos, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd, referentiel)
						VALUES (''utilisateur'', ''niveau_'||id_module||''', ''val'', ''Droit '||id_module||''', ''utilisateur'', '||maxpos||', FALSE, ''niveau_'||id_module||''', ''niveau_'||id_module||''', FALSE, ''utilisateur'', ''droit'');

--- nouvelles colonnes - référent - référentiels
INSERT INTO referentiels.champs(rubrique_champ, nom_champ, type, description, table_champ, pos, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd)
						VALUES (''utilisateur'', ''ref_'||id_module||''', ''bool'', ''Ref '||id_module||''', ''utilisateur'', '||maxpos+1||', FALSE, ''ref_'||id_module||''', ''ref_'||id_module||''', FALSE, ''utilisateur'');
';

RETURN 'OK';
END;$BODY$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--- drop_rubrique
--- Description : Fonction permettant de supprimer une rubrique du Codex
--- Variables :
--- o id_module : identifiant pour le module (par exemple : 'lr' - nb : sera utilisé comme nom du schema et du répertoire pour la rubrique)
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION drop_rubrique (id_module varchar) RETURNS varchar AS  
$BODY$  
DECLARE maxpos int;
BEGIN
SELECT max(pos) INTO maxpos FROM applications.rubrique;

EXECUTE '
--- ajout de la rubrique dans le schema application
DELETE FROM applications.pres WHERE id_module = '''||id_module||''';
DELETE FROM applications.rubrique WHERE id_module = '''||id_module||''';

---nouvelles colonnes dans les droits
ALTER TABLE applications.utilisateur DROP COLUMN niveau_'||id_module||';
ALTER TABLE applications.utilisateur DROP COLUMN ref_'||id_module||';

--- Nouveau schema
DROP SCHEMA '||id_module||' CASCADE;
';


EXECUTE '
--- nouvelles colonnes dans le suivi des droits - référentiels
DELETE FROM referentiels.champs WHERE rubrique_champ = ''droit_'||id_module||''' AND nom_champ = ''niveau_'||id_module||''';
DELETE FROM referentiels.champs_ref WHERE nom_ref = ''droit_'||id_module||''';
';

RETURN 'OK';
END;$BODY$ LANGUAGE plpgsql;