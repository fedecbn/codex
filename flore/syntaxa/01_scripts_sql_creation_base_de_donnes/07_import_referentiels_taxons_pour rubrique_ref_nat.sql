-------------------------------------------------------------------------
------- export des tables de référentiel depuis le codex d'origine
------------------------------------------------------------------------

copy refnat.taxref_changes_30_utf8 to '/home/export_pgsql/refnat/taxref_changes_30_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxref_changes_40_utf8 to '/home/export_pgsql/refnat/taxref_changes_40_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxref_changes_50_utf8 to '/home/export_pgsql/refnat/taxref_changes_50_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxref_changes_60_utf8 to '/home/export_pgsql/refnat/taxref_changes_60_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxref_changes_70_utf8 to '/home/export_pgsql/refnat/taxref_changes_70_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxref_changes_80_utf8 to '/home/export_pgsql/refnat/taxref_changes_80_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxons to '/home/export_pgsql/refnat/taxons.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.discussion to '/home/export_pgsql/refnat/discussion.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxrefv20_utf8 to '/home/export_pgsql/refnat/taxrefv20_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxrefv30_utf8 to '/home/export_pgsql/refnat/taxrefv30_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxrefv40_utf8 to '/home/export_pgsql/refnat/taxrefv40_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxrefv50_utf8 to '/home/export_pgsql/refnat/taxrefv50_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxrefv60_utf8 to '/home/export_pgsql/refnat/taxrefv60_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxrefv70_utf8 to '/home/export_pgsql/refnat/taxrefv70_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';
copy refnat.taxrefv80_utf8 to '/home/export_pgsql/refnat/taxrefv80_utf8.csv' with csv header delimiter E'\t' encoding 'utf8';

---------------------------------
-----creation de la table de log
----------------------------------


CREATE TABLE public.zz_log( "libSchema" character varying, "libTable" character varying, "libChamp" character varying, "typLog" character varying, "libLog" character varying, "nbOccurence" character varying, date date) WITH (OIDS=FALSE);
ALTER TABLE public.zz_log  OWNER TO postgres;
  
  
-------------------------------------------------------
--- Création des référentiels dans le codex en local
-------------------------------------------------------
CREATE OR REPLACE FUNCTION codex_ref(typAction varchar, path varchar = '/home/export_pgsql/refnat/') RETURNS  setof zz_log AS 
$BODY$
DECLARE out zz_log%rowtype;
DECLARE flag1 integer;
DECLARE flag2 integer;
DECLARE champFonction varchar;
DECLARE libTable varchar;
DECLARE delimitr varchar;
DECLARE structure varchar;
BEGIN
--- Output
out."libSchema" := '-';out."libTable" := '-';out."libChamp" := '-';out."typLog" := 'codex_ref';out."nbOccurence" := 1; SELECT CURRENT_TIMESTAMP INTO out."date";
---Variables
DROP TABLE IF  EXISTS public.ref_meta;CREATE TABLE public.ref_meta(id varchar, delimitr varchar, structure varchar, CONSTRAINT ref_meta_pk PRIMARY KEY(id));
INSERT INTO public.ref_meta VALUES

('taxref_changes_30_utf8','\t','("ogc_fid" serial not null,"cd_nom" character varying,"num_version_init" character varying,"num_version_final" character varying,"champ" character varying,"valeur_init" character varying,"valeur_final" character varying,"type_change" character varying, CONSTRAINT taxref_changes_30_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxref_changes_40_utf8','\t','("ogc_fid" serial not null,"cd_nom" character varying,"num_version_init" character varying,"num_version_final" character varying,"champ" character varying,"valeur_init" character varying,"valeur_final" character varying,"type_change" character varying, CONSTRAINT taxref_changes_40_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxref_changes_50_utf8','\t','("ogc_fid" serial not null,"cd_nom" character varying,"num_version_init" character varying,"num_version_final" character varying,"champ" character varying,"valeur_init" character varying,"valeur_final" character varying,"type_change" character varying, CONSTRAINT taxref_changes_50_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxref_changes_60_utf8','\t','("ogc_fid" serial not null,"cd_nom" character varying,"num_version_init" character varying,"num_version_final" character varying,"champ" character varying,"valeur_init" character varying,"valeur_final" character varying,"type_change" character varying, CONSTRAINT taxref_changes_60_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxref_changes_70_utf8','\t','("ogc_fid" serial not null,"cd_nom" character varying,"num_version_init" character varying,"num_version_final" character varying,"champ" character varying,"valeur_init" character varying,"valeur_final" character varying,"type_change" character varying, CONSTRAINT taxref_changes_70_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxref_changes_80_utf8','\t','("ogc_fid" serial not null,"cd_nom" character varying,"num_version_init" character varying,"num_version_final" character varying,"champ" character varying,"valeur_init" character varying,"valeur_final" character varying,"type_change" character varying, CONSTRAINT taxref_changes_80_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxons','\t','("uid" serial NOT NULL,"cd_nom" integer, "cd_ref" integer, "cd_taxsup" integer,"rang" character varying,"regne" character varying,"phylum" character varying,"classe" character varying,"ordre" character varying, "famille" character varying,"group1_inpn" character varying,"group2_inpn" character varying,"lb_nom" character varying,"lb_auteur" character varying,"nom_complet" character varying,"nom_complet_html" character varying,"nom_valide" character varying,"nom_vern" character varying,"nom_vern_eng" character varying,"habitat" integer,"fr" character varying,"gf" character varying,"mar" character varying,"gua" character varying,"sm" character varying,"spm" character varying,"may" character varying,"epa" character varying,"reu" character varying,"taaf" character varying,"pf" character varying,"nc" character varying,"wf" character varying,"cli" character varying,"url" character varying,"hybride" boolean,"lr" boolean DEFAULT false,"catnat" boolean DEFAULT false,"eee" boolean DEFAULT false,"pres_v2" boolean, "pres_v3" boolean,"pres_v4" boolean,"pres_v5" boolean,"pres_v6" boolean,"pres_v7" boolean,"pres_v8" boolean,"modif" boolean,"sb" character varying,CONSTRAINT taxons_pkey PRIMARY KEY (uid))'),
('discussion','\t','("id_discussion" serial not null,"uid" integer NOT NULL,"id_user" character varying(10) NOT NULL,"nom" character varying,"prenom" character varying,"id_cbn" smallint,"commentaire_eval" character varying,"datetime" timestamp without time zone, CONSTRAINT id_discussion_pkey PRIMARY KEY (id_discussion))'),
('taxrefv20_utf8','\t','("ogc_fid" integer, "regne" character varying, "phylum" character varying, "classe" character varying, "ordre" character varying, "famille" character varying, cd_nom character varying, lb_nom character varying, lb_auteur character varying, nom_complet character varying, cd_ref character varying, nom_valide character varying, rang character varying, nom_vern character varying, nom_vern_eng character varying, fr character varying, mar character varying, gua character varying, smsb character varying, gf character varying, spm character varying, reu character varying, may character varying, taaf character varying, nom_complet_sans_date character varying, CONSTRAINT refv20_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxrefv30_utf8','\t','(ogc_fid integer, regne character varying, phylum character varying, classe character varying, ordre character varying, famille character varying, cd_nom character varying, cd_taxsup character varying, cd_ref character varying, rang character varying, lb_nom character varying, lb_auteur character varying, nom_valide character varying, nom_vern character varying, nom_vern_eng character varying, habitat character varying, fr character varying, gf character varying, mar character varying, gua character varying, smsb character varying, spm character varying, may character varying, epa character varying, reu character varying, taaf character varying, nc character varying, wf character varying, pf character varying, cli character varying, nom_complet character varying, nom_complet_sans_date character varying, CONSTRAINT taxrefv30_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxrefv40_utf8','\t','(ogc_fid integer, regne character varying, phylum character varying, classe character varying, ordre character varying, famille character varying, cd_nom character varying, cd_taxsup character varying, cd_ref character varying, rang character varying, lb_nom character varying, lb_auteur character varying, nom_complet character varying, nom_valide character varying, nom_vern character varying, nom_vern_eng character varying, habitat character varying, fr character varying, gf character varying, mar character varying, gua character varying, sm character varying, sb character varying, spm character varying, may character varying, epa character varying, reu character varying, taaf character varying, pf character varying, nc character varying, wf character varying, cli character varying, aphia_id character varying, nom_complet_sans_date character varying, CONSTRAINT taxrefv40_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxrefv50_utf8','\t','(ogc_fid integer, regne character varying, phylum character varying, classe character varying, ordre character varying, famille character varying, cd_nom character varying, cd_taxsup character varying, cd_ref character varying, rang character varying, lb_nom character varying, lb_auteur character varying, nom_complet character varying, nom_valide character varying, nom_vern character varying, nom_vern_eng character varying, habitat character varying, fr character varying, gf character varying, mar character varying, gua character varying, sm character varying, sb character varying, spm character varying, may character varying, epa character varying, reu character varying, taaf character varying, pf character varying, nc character varying, wf character varying, cli character varying, url character varying, nom_complet_sans_date character varying, CONSTRAINT taxrefv50_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxrefv60_utf8','\t','(ogc_fid integer, regne character varying, phylum character varying, classe character varying, ordre character varying, famille character varying, cd_nom character varying, cd_taxsup character varying, cd_ref character varying, rang character varying, lb_nom character varying, lb_auteur character varying, nom_complet character varying, nom_valide character varying, nom_vern character varying, nom_vern_eng character varying, habitat character varying, fr character varying, gf character varying, mar character varying, gua character varying, sm character varying, sb character varying, spm character varying, may character varying, epa character varying, reu character varying, taaf character varying, pf character varying, nc character varying, wf character varying, cli character varying, url character varying, nom_complet_sans_date character varying, CONSTRAINT taxrefv60_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxrefv70_utf8','\t','(ogc_fid integer, regne character varying, phylum character varying, classe character varying, ordre character varying, famille character varying, group1_inpn character varying, group2_inpn character varying, cd_nom character varying, cd_taxsup character varying, cd_ref character varying, rang character varying, lb_nom character varying, lb_auteur character varying, nom_complet character varying, nom_valide character varying, nom_vern character varying, nom_vern_eng character varying, habitat character varying, fr character varying, gf character varying, mar character varying, gua character varying, sm character varying, sb character varying, spm character varying, may character varying, epa character varying, reu character varying, taaf character varying, pf character varying, nc character varying, wf character varying, cli character varying, url character varying, nom_complet_sans_date character varying, CONSTRAINT taxrefv70_utf8_pk PRIMARY KEY (ogc_fid))'),
('taxrefv80_utf8','\t','(ogc_fid integer, regne character varying, phylum character varying, classe character varying, ordre character varying, famille character varying, group1_inpn character varying, group2_inpn character varying, cd_nom character varying, cd_taxsup character varying, cd_ref character varying, rang character varying, lb_nom character varying, lb_auteur character varying, nom_complet character varying, nom_valide character varying, nom_vern character varying, nom_vern_eng character varying, habitat character varying, fr character varying, gf character varying, mar character varying, gua character varying, sm character varying, sb character varying, spm character varying, may character varying, epa character varying, reu character varying, taaf character varying, pf character varying, nc character varying, wf character varying, cli character varying, url character varying, nom_complet_html character varying, nom_complet_sans_date character varying, CONSTRAINT taxrefv80_utf8_pk PRIMARY KEY (ogc_fid))')
;

--- Commandes 
CASE WHEN typAction = 'drop' THEN	--- Suppression
	EXECUTE 'SELECT DISTINCT 1 FROM information_schema.schemata WHERE schema_name = ''refnat''' INTO flag1;
	CASE WHEN flag1 = 1 THEN DROP SCHEMA IF EXISTS refnat CASCADE; out."libLog" := 'Shema ref supprimé';RETURN next out;
	ELSE out."libLog" := 'Schéma refnat inexistant';RETURN next out;END CASE;
WHEN typAction = 'delete' THEN	--- Suppression
	EXECUTE 'SELECT DISTINCT 1 FROM information_schema.schemata WHERE schema_name = ''refnat''' INTO flag1;
	CASE WHEN flag1 = 1 THEN
		FOR libTable IN EXECUTE 'SELECT id FROM public.ref_meta'
		LOOP EXECUTE 'SELECT DISTINCT 1 FROM pg_tables WHERE schemaname = ''refnat'' AND tablename = '''||libTable||''';' INTO flag2;
		CASE WHEN flag2 = 1 THEN 
			EXECUTE 'DROP TABLE refnat."'||libTable||'" CASCADE';  out."libLog" := 'Table '||libTable||' supprimée';RETURN next out;
		ELSE out."libLog" := 'Table '||libTable||' inexistante';
		END CASE;
		END LOOP;
	ELSE out."libLog" := 'Schéma ref inexistant';RETURN next out;END CASE;
WHEN typAction = 'create' THEN	--- Creation
	EXECUTE 'SELECT DISTINCT 1 FROM information_schema.schemata WHERE schema_name =  ''refnat''' INTO flag1;
	CASE WHEN flag1 = 1 THEN out."libLog" := 'Schema refnat déjà créés';RETURN next out;ELSE CREATE SCHEMA "ref"; out."libLog" := 'Schéma ref créés';RETURN next out;END CASE;
	--- Tables
	FOR libTable IN EXECUTE 'SELECT id FROM public.ref_meta'
		LOOP EXECUTE 'SELECT DISTINCT 1 FROM pg_tables WHERE schemaname = ''refnat'' AND tablename = '''||libTable||''';' INTO flag2;
		CASE WHEN flag2 = 1 THEN 
			out."libLog" := libTable||' a déjà été créée' ;RETURN next out;
		ELSE EXECUTE 'SELECT structure FROM public.ref_meta WHERE id = '''||libTable||'''' INTO structure;
		EXECUTE 'SELECT delimitr FROM public.ref_meta WHERE id = '''||libTable||'''' INTO delimitr;
		EXECUTE 'CREATE TABLE refnat.'||libTable||' '||structure||';'; out."libLog" := libTable||' créée';RETURN next out;
		EXECUTE 'COPY refnat.'||libTable||' FROM '''||path||''||libTable||'.csv'' HEADER CSV DELIMITER E'''||delimitr||''' ENCODING ''UTF8'';';
		out."libLog" := libTable||' : données importées';RETURN next out;
		END CASE;
		END LOOP;
WHEN typAction = 'update' THEN	--- Mise à jour
	EXECUTE 'SELECT DISTINCT 1 FROM information_schema.schemata WHERE schema_name =  ''refnat''' INTO flag1;
	CASE WHEN flag1 = 1 THEN out."libLog" := 'Schema refnat déjà créés';RETURN next out;ELSE CREATE SCHEMA "ref"; out."libLog" := 'Schéma ref créés';RETURN next out;END CASE;
	FOR libTable IN EXECUTE 'SELECT id FROM public.ref_meta'
		LOOP 
		EXECUTE 'SELECT DISTINCT 1 FROM pg_tables WHERE schemaname = ''refnat'' AND tablename = '''||libTable||''';' INTO flag2;
		EXECUTE 'SELECT delimitr FROM public.ref_meta WHERE id = '''||libTable||'''' INTO delimitr;
		CASE WHEN flag2 = 1 THEN
			EXECUTE 'TRUNCATE refnat.'||libTable;
			EXECUTE 'COPY refnat.'||libTable||' FROM '''||path||''||libTable||'.csv'' HEADER CSV DELIMITER E'''||delimitr||''' ENCODING ''UTF8'';';
			out."libLog" := 'Mise à jour de la table '||libTable;RETURN next out;
		ELSE out."libLog" := 'Les tables doivent être créée auparavant : SELECT * FROM codex_ref(''create'',path)';RETURN next out;
		END CASE;
	END LOOP;
ELSE out."libLog" := 'Action non reconnue';RETURN next out;
END CASE;
--- DROP TABLE public.ref_meta;
--- Log
EXECUTE 'INSERT INTO "public".zz_log ("libSchema","libTable","libChamp","typLog","libLog","nbOccurence","date") VALUES ('''||out."libSchema"||''','''||out."libTable"||''','''||out."libChamp"||''','''||out."typLog"||''','''||out."libLog"||''','''||out."nbOccurence"||''','''||out."date"||''');';
END;$BODY$ LANGUAGE plpgsql;

----------------------------------------
--lancement de la fonction en local
-----------------------------------------

select * from codex_ref('update', 'F:\refnat\')


