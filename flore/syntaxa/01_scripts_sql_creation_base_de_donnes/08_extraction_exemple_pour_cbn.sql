 copy (select "libelleCatalogue","idCatalogue","codeEnregistrementSerieGeoserie","idSerieGeoserie","nomCompletSerieGeoserie", "nomFrancaisSerieGeoserie", "codeTypeSerieGeoserie"  
from syntaxa.st_serie_petitegeoserie g inner join syntaxa.st_catalogue_description c
on g."idCatalogue"=c."identifiantCatalogue"
 limit 3) to 'D:\export_geoserie.csv'  with csv header delimiter ';' encoding 'LATIN1';


  
 copy (select s."codeEnregistrementSerieGeoserie", "idGeosigmafacies","codeFacies","libelleGeoSigmafacies"
from (select * from syntaxa.st_serie_petitegeoserie g limit 3) as g inner join 
syntaxa.st_geo_sigmafacies s on g."codeEnregistrementSerieGeoserie"=s."codeEnregistrementSerieGeoserie") 
to 'D:\export_geosigmafacies.csv'  with csv header delimiter ';' encoding 'LATIN1';

 copy (
 select c.* from (
 select s."codeEnregistrementSerieGeoserie", "idGeosigmafacies","codeFacies","libelleGeoSigmafacies"
from (select * from syntaxa.st_serie_petitegeoserie g limit 3) as g inner join 
syntaxa.st_geo_sigmafacies s on g."codeEnregistrementSerieGeoserie"=s."codeEnregistrementSerieGeoserie") as foo
inner join syntaxa.st_cortege_syntaxonomique as c 
 on foo."idGeosigmafacies"=c."idGeosigmafacies")
 to 'D:\export_cortege_syntaxonomique.csv'  with csv header delimiter ';' encoding 'LATIN1';

 copy (
select "idCatalogue", "codeEnregistrementSyntax","idSyntaxon","nomCompletSyntaxon","idSyntaxonRetenu","nomSyntaxonRetenu","rangSyntaxon" from syntaxa.st_syntaxon)
to 'D:\export_syntaxon.csv'  with csv header delimiter ';' encoding 'UTF8';

  copy (
 select "nom_champ","table_champ",description  from referentiels.champs where nom_champ IN 
 ('libelleCatalogue','idCatalogue','codeEnregistrementSerieGeoserie','codeEnregistrementSyntax',
 'idSyntaxon','nomCompletSyntaxon','idSyntaxonRetenu','nomSyntaxonRetenu','rangSyntaxon','idSerieGeoserie',
 'nomCompletSerieGeoserie', 'nomFrancaisSerieGeoserie', 'codeTypeSerieGeoserie'  
  'idGeosigmafacies','codeFacies','libelleGeoSigmafacies', 
  'codeEnregistrementCortegeSyntax',
  'idGeosigmafacies',
  'libelleGeoSigmafacies',
  'codeEnregistrementSyntax',
  'idSyntaxonRetenu',
  'nomSyntaxonRetenu',
  'rqSyntaxon',
  'pourcentageTheoriqSyntax',
  'codeTeteSerie') and
 table_champ in ('st_catalogue_description','st_serie_petitegeoserie','st_cortege_syntaxonomique', 'st_syntaxon') order by nom_champ asc )
 to 'D:\export_metadonnees.csv'  with csv header delimiter ';' encoding 'LATIN1';
 

copy syntaxa.st_ref_type_facies to 'D:\export_referentiel_type_facies.csv'  with csv header delimiter ';' encoding 'UTF8';

copy syntaxa.st_ref_type_seriegeoserie to 'D:\export_referentiel_type_seriegeoserie.csv'  with csv header delimiter ';' encoding 'UTF8';

copy syntaxa.st_ref_tete_serie to 'D:\export_referentiel_tete_serie.csv'  with csv header delimiter ';' encoding 'UTF8';

 


 