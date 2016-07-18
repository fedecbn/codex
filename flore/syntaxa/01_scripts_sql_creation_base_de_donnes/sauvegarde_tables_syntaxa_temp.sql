--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-07-18 16:20:55

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = syntaxa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 363 (class 1259 OID 20909)
-- Name: temp_st_annuaire_organismes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_annuaire_organismes (
    "idOrganisme" character varying,
    "acronymeOrganisme" character varying,
    "libOrganisme" character varying
);


ALTER TABLE temp_st_annuaire_organismes OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 20915)
-- Name: temp_st_annuaire_personnes; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_annuaire_personnes (
    "idPersonne" character varying,
    prenom character varying,
    nom character varying
);


ALTER TABLE temp_st_annuaire_personnes OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 20903)
-- Name: temp_st_biblio; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_biblio (
    "idBiblio" character varying,
    "codeEnregistrement" character varying,
    "libPublication" character varying,
    "urlPublication" character varying,
    "codePublication" character varying
);


ALTER TABLE temp_st_biblio OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 20819)
-- Name: temp_st_catalogue_description; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_catalogue_description (
    "identifiantCatalogue" character varying,
    "libelleCatalogue" character varying,
    "versionCatalogue" character varying,
    "typeCatalogue" character varying,
    "dateCreationCatalogue" character varying,
    "dateMiseAJourCatalogue" character varying,
    "idCollaborateurCatalogue" character varying,
    "idTerritoireCatalogue" character varying,
    "codeTypeTerritoireCatalogue" character varying,
    "codeTerritoireCatalogue" character varying,
    "libelleTerritoireCatalogue" character varying,
    "empriseTerritoireCatalogue" character varying,
    "remarqueTerritoireCatalogue" character varying
);


ALTER TABLE temp_st_catalogue_description OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 20861)
-- Name: temp_st_chorologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_chorologie (
    "idChorologie" character varying,
    "codeEnregistrement" character varying,
    "statutChorologie" character varying,
    "idTerritoire" character varying
);


ALTER TABLE temp_st_chorologie OWNER TO postgres;

--
-- TOC entry 365 (class 1259 OID 20921)
-- Name: temp_st_collaborateur; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_collaborateur (
    "idCollaborateur" character varying,
    "identifiantCatalogue" character varying,
    "idOrganisme" character varying,
    "acronymeOrganisme" character varying,
    "idPersonne" character varying,
    prenom character varying,
    nom character varying
);


ALTER TABLE temp_st_collaborateur OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 20885)
-- Name: temp_st_correspondance_hic; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_correspondance_hic (
    "idCorresHIC" character varying,
    "codeEnregistrement" character varying,
    "typeEnregistrement" character varying,
    "codeHIC" character varying,
    "libHIC" character varying,
    "rqHIC" character varying
);


ALTER TABLE temp_st_correspondance_hic OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 20867)
-- Name: temp_st_correspondance_pvf; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_correspondance_pvf (
    "idCorrespondancePVF" character varying,
    "idRattachementPVF" character varying,
    "codeEnregistrementSyntaxon" character varying,
    "codeReferentiel" character varying,
    "versionReferentiel" character varying,
    "identifiantSyntaxonRetenu" character varying,
    "nomSyntaxonRetenu" character varying,
    "identifiantSyntaxonOrigine" character varying
);


ALTER TABLE temp_st_correspondance_pvf OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 20879)
-- Name: temp_st_cortege_floristique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_cortege_floristique (
    "idCortegeFloristique" character varying,
    "codeEnregistrementSyntaxon" character varying,
    "idRattachementReferentiel" character varying,
    "typeTaxon" character varying
);


ALTER TABLE temp_st_cortege_floristique OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 20837)
-- Name: temp_st_cortege_syntaxonomique; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_cortege_syntaxonomique (
    "codeEnregistrementCortegeSyntax" character varying,
    "idGeosigmafacies" character varying,
    "libelleGeoSigmafacies" character varying,
    "codeEnregistrementSyntax" character varying,
    "idSyntaxonRetenu" character varying,
    "nomSyntaxonRetenu" character varying,
    "rqSyntaxon" character varying,
    "pourcentageTheoriqSyntax" character varying,
    "codeTeteSerie" character varying
);


ALTER TABLE temp_st_cortege_syntaxonomique OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 20897)
-- Name: temp_st_etage_bioclim; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_etage_bioclim (
    "idCorresEtageBioclim" character varying,
    "codeEnregistrement" character varying,
    "codeEtageBioclim" character varying,
    "libEtageBioclim" character varying
);


ALTER TABLE temp_st_etage_bioclim OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 20891)
-- Name: temp_st_etage_veg; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_etage_veg (
    "idCorresEtageveg" character varying,
    "codeEnregistrement" character varying,
    "codeEtageVeg" character varying,
    "libEtageVeg" character varying
);


ALTER TABLE temp_st_etage_veg OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 20831)
-- Name: temp_st_geo_sigmafacies; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_geo_sigmafacies (
    "idGeosigmafacies" character varying,
    "codeEnregistrementSerieGeoserie" character varying,
    "codeFacies" character varying,
    "libelleGeoSigmafacies" character varying,
    dominance character varying,
    usage character varying,
    "remarqueVariabilite" character varying
);


ALTER TABLE temp_st_geo_sigmafacies OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 20873)
-- Name: temp_st_geomorphologie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_geomorphologie (
    "idVegGeomorpho" character varying,
    "codeEnregistrement" character varying,
    "idGeomorphologie" character varying,
    "libGeomorphologie" character varying
);


ALTER TABLE temp_st_geomorphologie OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 20843)
-- Name: temp_st_indicateurs_floristiques; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_indicateurs_floristiques (
    "idIndicateurFlor" character varying,
    "idGeosigmafacies" character varying,
    "idRattachementReferentiel" character varying
);


ALTER TABLE temp_st_indicateurs_floristiques OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 20825)
-- Name: temp_st_serie_petitegeoserie; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_serie_petitegeoserie (
    "idCatalogue" character varying,
    "codeEnregistrementSerieGeoserie" character varying,
    "idSerieGeoserie" character varying,
    "nomSerieGeoserie" character varying,
    "auteurSerieGeoserie" character varying,
    "nomCompletSerieGeoserie" character varying,
    "remarqueNomenclaturale" character varying,
    "typeSynonymie" character varying,
    "idSerieGeoserieRetenu" character varying,
    "nomSerieGeoserieRetenu" character varying,
    "nomSerieGeoserieRaccourci" character varying,
    "idSerieGeoserieSup" character varying,
    "codeTypeSerieGeoserie" character varying,
    "codeCategorieSerieGeoserie" character varying,
    "codeRangSerieGeoserie" character varying,
    "nomFrancaisSerieGeoserie" character varying,
    "diagnoseCourteSerieGeoserie" character varying,
    confusion character varying,
    "confusionRemarque" character varying,
    "repartitionGenerale" character varying,
    "repartitionTerritoire" character varying,
    "aireMinimale" character varying,
    "typePhysionomique" character varying,
    "lithologiePedologieHumus" character varying,
    geomorphologie character varying,
    "humiditePrincipale" character varying,
    "humiditeSecondaire" character varying,
    "phPrincipal" character varying,
    "phSecondaire" character varying,
    exposition character varying,
    "descriptionEcologie" character varying,
    "remarqueVariabilite" character varying,
    "remarqueRarete" character varying,
    "etatConservation" character varying
);


ALTER TABLE temp_st_serie_petitegeoserie OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 20855)
-- Name: temp_st_suivi_enregistrement; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_suivi_enregistrement (
    "idSuivi" character varying,
    "codeEnregistrement" character varying,
    "dateSuivi" character varying,
    "idAuteurSuivi" character varying,
    "prenomAuteurSuivi" character varying,
    "nomAuteurSuivi" character varying,
    "actionSuivi" character varying
);


ALTER TABLE temp_st_suivi_enregistrement OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 33039)
-- Name: temp_st_syntaxon; Type: TABLE; Schema: syntaxa; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_st_syntaxon (
    "idCatalogue" character varying,
    "codeEnregistrementSyntax" character varying,
    "idSyntaxon" character varying,
    "nomSyntaxon" character varying,
    "auteurSyntaxon" character varying,
    "nomCompletSyntaxon" character varying,
    "rqNomenclaturale" character varying,
    "typeSynonymie" character varying,
    "idSyntaxonRetenu" character varying,
    "nomSyntaxonRetenu" character varying,
    "nomSyntaxonRaccourci" character varying,
    "rangSyntaxon" character varying,
    "idSyntaxonSup" character varying,
    "nomFrancaisSyntaxon" character varying,
    "diagnoseCourteSyntaxon" character varying,
    "idCritique" character varying,
    "rqCritique" character varying,
    "repartitionGenerale" character varying,
    "repartitionTerritoire" character varying,
    "periodeDebObsOptimale" character varying,
    "periodeFinObsOptimale" character varying,
    "rqPhenologie" character varying,
    "aireMinimale" character varying,
    "typeBiologiqueDom" character varying,
    "typePhysionomique" character varying,
    "rqPhysionomie" character varying,
    "humiditePrincipale" character varying,
    "humiditeSecondaire" character varying,
    "phPrincipal" character varying,
    "phSecondaire" character varying,
    trophie character varying,
    temperature character varying,
    luminosite character varying,
    exposition character varying,
    salinite character varying,
    neige character varying,
    continentalite character varying,
    ombroclimat character varying,
    climat character varying,
    "descriptionEcologie" character varying,
    "remarqueVariabilite" character varying
);


ALTER TABLE temp_st_syntaxon OWNER TO postgres;

--
-- TOC entry 2847 (class 0 OID 0)
-- Dependencies: 363
-- Name: temp_st_annuaire_organismes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_annuaire_organismes FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_annuaire_organismes FROM postgres;
GRANT ALL ON TABLE temp_st_annuaire_organismes TO postgres;
GRANT ALL ON TABLE temp_st_annuaire_organismes TO user_codex;


--
-- TOC entry 2848 (class 0 OID 0)
-- Dependencies: 364
-- Name: temp_st_annuaire_personnes; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_annuaire_personnes FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_annuaire_personnes FROM postgres;
GRANT ALL ON TABLE temp_st_annuaire_personnes TO postgres;
GRANT ALL ON TABLE temp_st_annuaire_personnes TO user_codex;


--
-- TOC entry 2849 (class 0 OID 0)
-- Dependencies: 362
-- Name: temp_st_biblio; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_biblio FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_biblio FROM postgres;
GRANT ALL ON TABLE temp_st_biblio TO postgres;
GRANT ALL ON TABLE temp_st_biblio TO user_codex;


--
-- TOC entry 2850 (class 0 OID 0)
-- Dependencies: 349
-- Name: temp_st_catalogue_description; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_catalogue_description FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_catalogue_description FROM postgres;
GRANT ALL ON TABLE temp_st_catalogue_description TO postgres;
GRANT ALL ON TABLE temp_st_catalogue_description TO user_codex;


--
-- TOC entry 2851 (class 0 OID 0)
-- Dependencies: 355
-- Name: temp_st_chorologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_chorologie FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_chorologie FROM postgres;
GRANT ALL ON TABLE temp_st_chorologie TO postgres;
GRANT ALL ON TABLE temp_st_chorologie TO user_codex;


--
-- TOC entry 2852 (class 0 OID 0)
-- Dependencies: 365
-- Name: temp_st_collaborateur; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_collaborateur FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_collaborateur FROM postgres;
GRANT ALL ON TABLE temp_st_collaborateur TO postgres;
GRANT ALL ON TABLE temp_st_collaborateur TO user_codex;


--
-- TOC entry 2853 (class 0 OID 0)
-- Dependencies: 359
-- Name: temp_st_correspondance_hic; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_correspondance_hic FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_correspondance_hic FROM postgres;
GRANT ALL ON TABLE temp_st_correspondance_hic TO postgres;
GRANT ALL ON TABLE temp_st_correspondance_hic TO user_codex;


--
-- TOC entry 2854 (class 0 OID 0)
-- Dependencies: 356
-- Name: temp_st_correspondance_pvf; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_correspondance_pvf FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_correspondance_pvf FROM postgres;
GRANT ALL ON TABLE temp_st_correspondance_pvf TO postgres;
GRANT ALL ON TABLE temp_st_correspondance_pvf TO user_codex;


--
-- TOC entry 2855 (class 0 OID 0)
-- Dependencies: 358
-- Name: temp_st_cortege_floristique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_cortege_floristique FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_cortege_floristique FROM postgres;
GRANT ALL ON TABLE temp_st_cortege_floristique TO postgres;
GRANT ALL ON TABLE temp_st_cortege_floristique TO user_codex;


--
-- TOC entry 2856 (class 0 OID 0)
-- Dependencies: 352
-- Name: temp_st_cortege_syntaxonomique; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_cortege_syntaxonomique FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_cortege_syntaxonomique FROM postgres;
GRANT ALL ON TABLE temp_st_cortege_syntaxonomique TO postgres;
GRANT ALL ON TABLE temp_st_cortege_syntaxonomique TO user_codex;


--
-- TOC entry 2857 (class 0 OID 0)
-- Dependencies: 361
-- Name: temp_st_etage_bioclim; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_etage_bioclim FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_etage_bioclim FROM postgres;
GRANT ALL ON TABLE temp_st_etage_bioclim TO postgres;
GRANT ALL ON TABLE temp_st_etage_bioclim TO user_codex;


--
-- TOC entry 2858 (class 0 OID 0)
-- Dependencies: 360
-- Name: temp_st_etage_veg; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_etage_veg FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_etage_veg FROM postgres;
GRANT ALL ON TABLE temp_st_etage_veg TO postgres;
GRANT ALL ON TABLE temp_st_etage_veg TO user_codex;


--
-- TOC entry 2859 (class 0 OID 0)
-- Dependencies: 351
-- Name: temp_st_geo_sigmafacies; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_geo_sigmafacies FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_geo_sigmafacies FROM postgres;
GRANT ALL ON TABLE temp_st_geo_sigmafacies TO postgres;
GRANT ALL ON TABLE temp_st_geo_sigmafacies TO user_codex;


--
-- TOC entry 2860 (class 0 OID 0)
-- Dependencies: 357
-- Name: temp_st_geomorphologie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_geomorphologie FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_geomorphologie FROM postgres;
GRANT ALL ON TABLE temp_st_geomorphologie TO postgres;
GRANT ALL ON TABLE temp_st_geomorphologie TO user_codex;


--
-- TOC entry 2861 (class 0 OID 0)
-- Dependencies: 353
-- Name: temp_st_indicateurs_floristiques; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_indicateurs_floristiques FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_indicateurs_floristiques FROM postgres;
GRANT ALL ON TABLE temp_st_indicateurs_floristiques TO postgres;
GRANT ALL ON TABLE temp_st_indicateurs_floristiques TO user_codex;


--
-- TOC entry 2862 (class 0 OID 0)
-- Dependencies: 350
-- Name: temp_st_serie_petitegeoserie; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_serie_petitegeoserie FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_serie_petitegeoserie FROM postgres;
GRANT ALL ON TABLE temp_st_serie_petitegeoserie TO postgres;
GRANT ALL ON TABLE temp_st_serie_petitegeoserie TO user_codex;


--
-- TOC entry 2863 (class 0 OID 0)
-- Dependencies: 354
-- Name: temp_st_suivi_enregistrement; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_suivi_enregistrement FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_suivi_enregistrement FROM postgres;
GRANT ALL ON TABLE temp_st_suivi_enregistrement TO postgres;
GRANT ALL ON TABLE temp_st_suivi_enregistrement TO user_codex;


--
-- TOC entry 2864 (class 0 OID 0)
-- Dependencies: 371
-- Name: temp_st_syntaxon; Type: ACL; Schema: syntaxa; Owner: postgres
--

REVOKE ALL ON TABLE temp_st_syntaxon FROM PUBLIC;
REVOKE ALL ON TABLE temp_st_syntaxon FROM postgres;
GRANT ALL ON TABLE temp_st_syntaxon TO postgres;
GRANT ALL ON TABLE temp_st_syntaxon TO user_codex;


-- Completed on 2016-07-18 16:20:56

--
-- PostgreSQL database dump complete
--

