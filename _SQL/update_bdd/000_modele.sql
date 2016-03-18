CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS $BODY$ BEGIN

--- 1. Code permettant la mise à jour
-- ex : update...
-- ex : insert...

--- 2. Pour le suivi des mises à jours
--- INSERT INTO applications.update_bdd VALUES (identifiant du fichier,numero du commit précédent, date);
--- ex : INSERT INTO applications.update_bdd VALUES ('001','8285659184f39475917be396aaffb600287cc01c', '2016-03-18');

RETURN 'OK';END;$BODY$ LANGUAGE plpgsql;SELECT * FROM update_bdd();