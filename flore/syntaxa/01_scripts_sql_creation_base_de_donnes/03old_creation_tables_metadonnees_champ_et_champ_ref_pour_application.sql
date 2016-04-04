---------------------------------------------------------------------------------------------------
---alimentation de la table referentiels.champs qui est utilisée par l'application pour fonctionner
---pas de champs date ou geom pour le moment
---------------------------------------------------------------------------------------------------
--delete from referentiels.champs where rubrique_champ='syntaxa';
insert into referentiels.champs (rubrique_champ,nom_champ,type,description,table_champ,referentiel, pos,description_longue,export_display,nom_champ_synthese,champ_interface,  modifiable,table_bd)
select
'syntaxa' as rubrique_champ,
 fsd."cd" as nom_champ,
case 
when cle.table_mere is not null then 'val'
when fsd.type_cd ='integer' then 'int' 
when fsd.type_cd ='text' or fsd.type_cd ='date' then 'string' 
else 'string'
end as type,
"commentaire_colonne" as description,
fsd."tbl_name" as table_champ,
cle.table_mere  as referentiel,
null as pos,
null as description_longue,
'FALSE' as export_display,
fsd."cd" as nom_champ_synthese,
fsd."cd" as champ_interface,
'TRUE' as modifiable, 
fsd."tbl_name" as table_bd
from syntaxa.fsd_syntaxa fsd
left outer join 

(select pg_constraint.conname, secondary_table.table_name as table_fille, secondary_table.attname as attribut_fils, primary_table.table_name as table_mere, primary_table.attname as attribut_pere
FROM pg_constraint,
(select attname, table_name, attrelid, attnum FROM pg_attribute JOIN (SELECT c.relname AS table_name, n.nspname, c.oid
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = 'r'::"char"
  ORDER BY c.relname) mtd_liste_table ON pg_attribute.attrelid=mtd_liste_table.oid) secondary_table,
(select attname, table_name, attrelid, attnum FROM pg_attribute JOIN (SELECT c.relname AS table_name, n.nspname, c.oid
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = 'r'::"char"
  ORDER BY c.relname) mtd_liste_table ON pg_attribute.attrelid=mtd_liste_table.oid) primary_table
WHERE conrelid=secondary_table.attrelid
AND confrelid=primary_table.attrelid
AND secondary_table.attnum=any(conkey)
AND primary_table.attnum=any(confkey)
AND pg_constraint.contype='f') cle

on (fsd.tbl_name=cle.table_fille and fsd.cd=cle.attribut_fils) 

;

update referentiels.champs set pos=0 where nom_champ='codeEnregistrementSyntax' and table_champ='st_syntaxon';
update referentiels.champs set pos=1 where nom_champ='idSyntaxon' and table_champ='st_syntaxon';
update referentiels.champs set pos=2 where nom_champ='nomCompletSyntaxon' and table_champ='st_syntaxon';
update referentiels.champs set pos=3 where nom_champ='rangSyntaxon' and table_champ='st_syntaxon';
update referentiels.champs set pos=4 where nom_champ='idSyntaxonRetenu' and table_champ='st_syntaxon';
update referentiels.champs set pos=5 where nom_champ='nomSyntaxonRetenu' and table_champ='st_syntaxon';
update referentiels.champs set pos=7 where nom_champ='idSyntaxonSup' and table_champ='st_syntaxon';


--select nom_champ, pos from referentiels.champs  where table_champ='st_syntaxon' and pos is not null order by pos asc;
--select * from referentiels.champs where rubrique_champ='syntaxa';

--verificationrenvoi liste principale
select nom_champ, pos from referentiels.champs  where table_champ='st_syntaxon' and pos is not null order by pos asc;

SELECT count(*) OVER() AS total_count,* FROM syntaxa.st_syntaxon ORDER BY "st_syntaxon"."nomCompletSyntaxon" asc LIMIT 100



 



/*
--connnaitre les clés primaires et étrangères
select pg_constraint.conname, secondary_table.table_name as table_fille, secondary_table.attname as attribut_fils, primary_table.table_name as table_mere, primary_table.attname as attribut_pere
FROM pg_constraint,
(select attname, table_name, attrelid, attnum FROM pg_attribute JOIN (SELECT c.relname AS table_name, n.nspname, c.oid
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = 'r'::"char"
  ORDER BY c.relname) mtd_liste_table ON pg_attribute.attrelid=mtd_liste_table.oid) secondary_table,
(select attname, table_name, attrelid, attnum FROM pg_attribute JOIN (SELECT c.relname AS table_name, n.nspname, c.oid
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = 'r'::"char"
  ORDER BY c.relname) mtd_liste_table ON pg_attribute.attrelid=mtd_liste_table.oid) primary_table
WHERE conrelid=secondary_table.attrelid
AND confrelid=primary_table.attrelid
AND secondary_table.attnum=any(conkey)
AND primary_table.attnum=any(confkey)
AND pg_constraint.contype='f'
AND secondary_table.table_name='st_correspondance_eunis'

*/




----------------------------------------------------------------------------------------------------------------------
----------alimentation de la table referentiels.champs_ref  qui est utilisée par l'application pour fonctionner
----------------------------------------------------------------------------------------------------------------------

--delete from referentiels.champs_ref where rubrique_ref='syntaxa';

insert into referentiels.champs_ref (nom_ref,cle,valeur,schema,table_ref,orderby,rubrique_ref)
select
cle."table_mere" as nom_ref,
cle."attribut_pere" as cle,
null as valeur,
'syntaxa' as schema,
cle."table_mere" as table_ref,
cle."attribut_pere" as orderby,
'syntaxa' as rubrique_ref
from syntaxa.fsd_syntaxa fsd
inner join 

(select pg_constraint.conname, secondary_table.table_name as table_fille, secondary_table.attname as attribut_fils, primary_table.table_name as table_mere, primary_table.attname as attribut_pere
FROM pg_constraint,
(select attname, table_name, attrelid, attnum FROM pg_attribute JOIN (SELECT c.relname AS table_name, n.nspname, c.oid
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = 'r'::"char"
  ORDER BY c.relname) mtd_liste_table ON pg_attribute.attrelid=mtd_liste_table.oid) secondary_table,
(select attname, table_name, attrelid, attnum FROM pg_attribute JOIN (SELECT c.relname AS table_name, n.nspname, c.oid
   FROM pg_class c
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  WHERE c.relkind = 'r'::"char"
  ORDER BY c.relname) mtd_liste_table ON pg_attribute.attrelid=mtd_liste_table.oid) primary_table
WHERE conrelid=secondary_table.attrelid
AND confrelid=primary_table.attrelid
AND secondary_table.attnum=any(conkey)
AND primary_table.attnum=any(confkey)
AND pg_constraint.contype='f') cle

on (fsd.tbl_name=cle.table_fille and fsd.cd=cle.attribut_fils)
where  cle.table_mere is not null
and cle."attribut_pere"<>'nomSyntaxonRetenu'
and cle."attribut_pere"<>'acronymeOrganisme'
and cle."attribut_pere"<>'libEtageVeg'
group by nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref
;

update referentiels.champs_ref set valeur= cd from syntaxa.fsd_syntaxa fsd where fsd.pos::int=2 and champs_ref.nom_ref=fsd.tbl_name;

--vérification qu'on a bien qu'un seul référentiel ayant le même nom...
--select distinct nom_ref,rubrique_ref, count(*) from referentiels.champs_ref group by nom_ref, rubrique_ref order by count(*) desc;
--select * from referentiels.champs_ref where rubrique_ref='syntaxa';



