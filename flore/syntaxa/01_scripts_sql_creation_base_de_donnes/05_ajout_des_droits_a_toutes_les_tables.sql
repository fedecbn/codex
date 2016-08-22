--SELECT 'GRANT ALL PRIVILEGES ON syntaxa.'||table_name||' TO user_codex;' FROM information_schema.tables WHERE table_schema = 'syntaxa';

GRANT ALL PRIVILEGES ON syntaxa.temp_st_serie_petitegeoserie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_geo_sigmafacies TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_indicateurs_floristiques TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_syntaxon TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_chorologie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_correspondance_pvf TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_suivi_enregistrement TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_geomorphologie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_cortege_floristique TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_correspondance_hic TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_etage_veg TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_etage_bioclim TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_biblio TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_annuaire_organismes TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.fsd_syntaxa TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_cortege_syntaxonomique TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_annuaire_personnes TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_exposition TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_categorie_seriegeoserie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_type_seriegeoserie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_rang_syntaxon TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_rang_seriegeoserie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_type_facies TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_tete_serie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_indicateurs_floristiques TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_periode TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_catalogue_description TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.temp_st_collaborateur TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_humidite TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_reaction TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_trophie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_type_synonymie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_critique TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_action_suivi TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_type_physionomique TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_temperature TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_lumiere TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_neige TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_continentalite TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_salinite TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_rivasmartinez_ombroclimat TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_chorologie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_suivi_enregistrement TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.liste_geo TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_statut_chorologie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_pvf TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_correspondance_pvf TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_geomorpho TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_geomorphologie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_cortege_floristique TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.referentiel_taxo TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_geo_sigmafacies TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_hic TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_cortege_syntaxonomique TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_correspondance_hic TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_etage_veg TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_etage_veg TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_etage_bioclim TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_etage_bioclim TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_biblio TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_annuaire_personnes TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_serie_petitegeoserie TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_eunis TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_catalogue_description TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_correspondance_eunis TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_collaborateur TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_annuaire_organismes TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_syntaxon TO user_codex;
GRANT ALL PRIVILEGES ON syntaxa.st_ref_type_taxon TO user_codex;



grant all on TABLE syntaxa."st_chorologie_idChorologie_seq" TO user_codex;
grant all on TABLE syntaxa."st_catalogue_description_id_tri_seq" TO user_codex;
grant all on TABLE syntaxa.st_syntaxon_uid_seq TO user_codex;
grant all on TABLE syntaxa."st_correspondance_pvf_idCorrespondancePVF_seq" TO user_codex;
grant all on TABLE syntaxa."st_etage_veg_idCorresEtageveg_seq" TO user_codex;
grant all on TABLE syntaxa."st_biblio_idBiblio_seq" TO user_codex;
grant all on TABLE syntaxa."st_correspondance_hic_idCorresHIC_seq" TO user_codex;
grant all on TABLE syntaxa."st_correspondance_eunis_idCorresEUNIS_seq" TO user_codex;
grant all on TABLE syntaxa."st_etage_veg_idCorresEtageveg_seq" TO user_codex;
grant all on TABLE syntaxa."st_etage_bioclim_idCorresEtageBioclim_seq" TO user_codex;
grant all on TABLE syntaxa."st_cortege_floristique_idCortegeFloristique_seq" TO user_codex;





 



