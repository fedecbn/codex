CREATE OR REPLACE FUNCTION update_bdd() RETURNS varchar AS $BODY$ BEGIN

--- 1. Code permettant la mise à jour
CREATE TABLE applications.update_bdd (
	id varchar,
	commit varchar,
	date date,
	CONSTRAINT updt_pk PRIMARY KEY (id)
);
INSERT INTO applications.update_bdd VALUES ('0','initial commit', NOW());

--- 2. Pour le suivi des mises à jours
INSERT INTO applications.update_bdd VALUES ('001','8285659184f39475917be396aaffb600287cc01c', '2016-03-18');

RETURN 'OK';END;$BODY$ LANGUAGE plpgsql;SELECT * FROM update_bdd();