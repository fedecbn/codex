-- modif BDD (application.pres et application.rub)
CREATE OR REPLACE FUNCTION new_rubrique (id_module varchar,titre_module varchar, utilisateur varchar) RETURNS varchar AS  
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
UPDATE applications.utilisateur SET niveau_'||id_module||' = 255 , ref_'||id_module||' = TRUE WHERE id_user = '''||utilisateur||''';

--- Nouveau schema
CREATE SCHEMA '||id_module||';
CREATE TABLE '||id_module||'.base
(
  uid integer NOT NULL,
  info_text character varying,
  info_real real,
  info_int integer,
  info_bool boolean,
  CONSTRAINT '||id_module||'_pkey PRIMARY KEY (uid)
) WITH (OIDS=FALSE);
ALTER TABLE '||id_module||'.base OWNER TO pg_user;
';

RETURN 'OK';
END;$BODY$ LANGUAGE plpgsql;



-- modif BDD (application.pres et application.rub)
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

RETURN 'OK';
END;$BODY$ LANGUAGE plpgsql;