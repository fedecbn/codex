--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = referentiels, pg_catalog;

--
-- Data for Name: ajustmt; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO ajustmt (id_ajustmt, cd_ajustmt, lib_ajustmt) VALUES (0, '0', '');
INSERT INTO ajustmt (id_ajustmt, cd_ajustmt, lib_ajustmt) VALUES (2, '-2', '(+2)');
INSERT INTO ajustmt (id_ajustmt, cd_ajustmt, lib_ajustmt) VALUES (1, '-1', '(+1)');
INSERT INTO ajustmt (id_ajustmt, cd_ajustmt, lib_ajustmt) VALUES (-2, '2', '(-2)');
INSERT INTO ajustmt (id_ajustmt, cd_ajustmt, lib_ajustmt) VALUES (-1, '1', '(-1)');


--
-- Name: ajustmt_id_ajustmt_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('ajustmt_id_ajustmt_seq', 1, false);


--
-- Data for Name: aoo; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (0, '', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (1, '0', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (2, '< 10', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (3, '< 20', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (4, '< 30', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (5, '< 500', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (6, '< 2 000', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (7, '< 3 000', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (8, '≥ 3 000', NULL);
INSERT INTO aoo (id_aoo, cd_aoo, lib_aoo) VALUES (9, 'Inconnu', NULL);


--
-- Name: aoo_id_aoo_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('aoo_id_aoo_seq', 1, false);


--
-- Data for Name: avancement; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO avancement (id, cd, lib) VALUES (0, 0, NULL);
INSERT INTO avancement (id, cd, lib) VALUES (2, 2, 'en cours');
INSERT INTO avancement (id, cd, lib) VALUES (3, 3, 'réalisée');
INSERT INTO avancement (id, cd, lib) VALUES (1, 1, 'à réaliser');


--
-- Data for Name: cat_a; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (0, '', '');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (1, 'RE', 'Disparue au niveau régional');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (2, 'CR*', 'Disparue ?');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (3, 'CR', 'En danger critique');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (4, 'EN', 'En danger');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (5, 'VU', 'Vulnérable');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (6, 'NT', 'Quasi menacée');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (7, 'LC', 'Préoccupation mineure');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (8, 'DD', 'Données insuffisantes');
INSERT INTO cat_a (id_cat_a, cd_cat_a, lib_cat_a) VALUES (9, 'NE', 'Non évalué');


--
-- Name: cat_a_id_cat_a_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('cat_a_id_cat_a_seq', 1, false);


--
-- Data for Name: categorie; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (0, '', '');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (1, 'RE', 'Disparue au niveau régional');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (2, 'CR*', 'Disparue ?');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (3, 'CR', 'En danger critique');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (4, 'EN', 'En danger');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (5, 'VU', 'Vulnérable');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (6, 'NT', 'Quasi menacée');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (7, 'LC', 'Préoccupation mineure');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (8, 'DD', 'Données insuffisantes');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (9, 'NE', 'Non évalué');
INSERT INTO categorie (id_cat, cd_cat, lib_cat) VALUES (10, 'NA', 'Non évaluable');


--
-- Data for Name: categorie_final; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (0, '', '');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (1, 'RE', 'Disparue au niveau régional');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (2, 'CR*', 'Disparue ?');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (3, 'CR', 'En danger critique');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (4, 'EN', 'En danger');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (5, 'VU', 'Vulnérable');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (6, 'NT', 'Quasi menacée');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (7, 'LC', 'Préoccupation mineure');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (8, 'DD', 'Données insuffisantes');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (9, 'NE', 'Non évalué');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (10, 'NA', 'Non évaluable');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (11, 'EX', 'Éteinte');
INSERT INTO categorie_final (id_cat, cd_cat, lib_cat) VALUES (12, 'EW', 'Disparue à l''état sauvage');


--
-- Name: categorie_final_id_cat_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('categorie_final_id_cat_seq', 1, false);


--
-- Name: categorie_id_cat_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('categorie_id_cat_seq', 1, false);


--
-- Data for Name: cbn; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (1, 'CBN-ALP', 'CBN Alpin');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (2, 'CBN-BAL', 'CBN de Bailleul');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (3, 'CBN-BRE', 'CBN de Brest');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (4, 'CBN-COR', 'CBN de Corse');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (5, 'CBN-FRC', 'CBN de Franche-Comté');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (6, 'CBN-PMP', 'CBN des Pyrénées et de Midi-Pyrénées');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (7, 'CBN-BPA', 'CBN du Bassin Parisien');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (8, 'CBN-MCE', 'CBN du Massif central');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (12, 'GUY', '[Guyane]');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (13, 'GDE', '[Grand Est]');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (14, 'GUA', '[Guadeloupe]');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (15, 'MAR', '[Martinique]');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (16, 'FCBN', 'FCBN');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (0, 'inconnu', 'inconnu');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (9, 'CBN-MED', 'CBN Méditerranéen de Porquerolles');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (10, 'CBN-SAT', 'CBN Sud-Atlantique');
INSERT INTO cbn (id_cbn, cd_cbn, lib_cbn) VALUES (11, 'CBN-MAS', 'CBN Mascarin');


--
-- Data for Name: champs; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--

INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (31, 'eee', 'idp', 'val', 'Présence à l''internationale', 'statut_inter_pres', 'pays', NULL, NULL, true, NULL, 'idp_pres', true, 'statut_inter');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (33, 'eee', 'idp', 'val', 'Statut invasive avérée à l''international', 'statut_inter_invav', 'pays', NULL, NULL, true, NULL, 'idp_invav', true, 'statut_inter');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (32, 'eee', 'idp', 'val', 'Indigénat à l''internationale', 'statut_inter_indig', 'pays', NULL, NULL, true, NULL, 'idp_indig', true, 'statut_inter');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (45, 'eee', 'ids', 'val', 'Source - viabilité des graines et reproduction', 'liste_source_5', NULL, NULL, NULL, true, NULL, 'ids5', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (44, 'eee', 'ids', 'val', 'Source - indigénat en France', 'liste_source_4', NULL, NULL, NULL, true, NULL, 'ids4', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (43, 'eee', 'ids', 'val', 'Source - présence en France', 'liste_source_3', NULL, NULL, NULL, true, NULL, 'ids3', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (41, 'eee', 'ids', 'val', 'Source - présence international', 'liste_source_1', NULL, NULL, NULL, true, NULL, 'ids1', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (53, 'eee', 'ids', 'val', 'Source - densité de la population', 'liste_source_13', NULL, NULL, NULL, true, NULL, 'ids13', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (52, 'eee', 'ids', 'val', 'Source - habitat espèce', 'liste_source_12', NULL, NULL, NULL, true, NULL, 'ids12', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (51, 'eee', 'ids', 'val', 'Source - taxonomie', 'liste_source_11', NULL, NULL, NULL, true, NULL, 'ids11', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (86, 'lr', 'nbm5_post1990', 'int', 'Nb maille après 1990(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbm5_post1990', false, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (87, 'lr', 'nbm5_post2000', 'int', 'Nb maille après 2000(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbm5_post2000', false, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (187, 'catnat', 'type_statut', 'val', 'Statuts', 'statut', 'statut', NULL, NULL, false, 'type_statut', 'type_statut', false, 'statut');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (50, 'eee', 'ids', 'val', 'Source - statut invasive avérée en France', 'liste_source_10', NULL, NULL, NULL, true, NULL, 'ids10', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (38, 'eee', 'idr', 'val', 'Présence en France', 'statut_natio_pres', 'region', 3, NULL, true, 'presence', 'idr_pres', true, NULL);
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (39, 'eee', 'idr', 'val', 'Indigénat en France', 'statut_natio_indig', 'region', NULL, NULL, true, NULL, 'idr_indig', true, NULL);
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (185, 'catnat', 'indi', 'string', 'Indigenat', 'statut_nat', 'indigenat', 6, NULL, true, 'indi', 'indi', true, 'statut_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (188, 'catnat', 'id_statut', 'string', 'Indigénat régional', 'statut_reg', NULL, NULL, NULL, true, 'statut_INDI', 'statut_INDI', true, 'statut_reg');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (192, 'catnat', 'id_statut', 'string', 'Liste rouge régionale', 'statut_reg', NULL, NULL, NULL, true, 'statut_LR', 'statut_LR', true, 'statut_reg');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (193, 'catnat', 'id_statut', 'string', 'Présence régionale', 'statut_reg', NULL, NULL, NULL, true, 'statut_PRES', 'statut_PRES', true, 'statut_reg');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (89, 'lr', 'nbcommune', 'int', 'Nb commune après 1990(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbcommune', false, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (194, 'catnat', 'id_statut', 'string', 'Endemisme régionale', 'statut_reg', NULL, NULL, NULL, true, 'statut_END', 'statut_END', true, 'statut_reg');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (190, 'catnat', 'presence', 'string', 'Présence', 'statut_nat', NULL, NULL, NULL, true, 'presence', 'presence', true, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (1, 'lr', 'etape', 'val', 'Etape évaluation', 'evaluation', 'etape', 0, NULL, true, 'etape', 'etape', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (49, 'eee', 'ids', 'val', 'Source - statut invasive avérée international', 'liste_source_9', NULL, NULL, NULL, true, NULL, 'ids9', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (48, 'eee', 'ids', 'val', 'Source - type biologique', 'liste_source_8', NULL, NULL, NULL, true, NULL, 'ids8', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (47, 'eee', 'ids', 'val', 'Source - mode de dispersion', 'liste_source_7', NULL, NULL, NULL, true, NULL, 'ids7', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (46, 'eee', 'ids', 'val', 'Source - croissance végétative', 'liste_source_6', NULL, NULL, NULL, true, NULL, 'ids6', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (186, 'catnat', 'cd_rang', 'val', 'Rang', 'taxons_nat', 'rang', 3, NULL, true, 'cd_rang', 'cd_rang', false, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (153, 'eee', 'commentaire', 'string', 'Commentaire', 'taxons', NULL, NULL, NULL, true, NULL, 'commentaire', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (102, 'lr', 'declin_cont_iv', 'bool', 'Déclin continu(Nb Loc)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_iv', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (101, 'lr', 'declin_cont_ii', 'bool', 'Déclin continu(AOO)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_ii', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (61, 'eee', 'ida', 'val', 'Argument - densité de la population', 'liste_argument_13', NULL, NULL, NULL, true, NULL, 'ida13', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (109, 'lr', 'reduc_eff_precis', 'int', 'Réduction de l''effectif(précis)', 'chorologie', NULL, NULL, NULL, true, NULL, 'reduc_eff_precis', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (83, 'lr', 'menace', 'bool', 'Menace', 'evaluation', NULL, NULL, NULL, true, NULL, 'menace', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (147, 'eee', 'eval_expert', 'string', 'Évaluation experte', 'evaluation', NULL, 15, NULL, true, 'eval_expert', 'eval_expert', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (60, 'eee', 'ida', 'val', 'Argument - habitat espèce', 'liste_argument_12', NULL, NULL, NULL, true, NULL, 'ida12', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (152, 'eee', 'eval_tot', 'val', 'Évaluation finale', 'evaluation', NULL, 10, NULL, true, 'eval_tot', 'eval_tot', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (144, 'eee', 'liste_eval', 'val', 'Liste évaluation eee', 'evaluation', NULL, 12, NULL, true, 'liste_eval', 'liste_eval', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (149, 'eee', 'ind_b', 'int', 'Score weber risque propagation', 'evaluation', NULL, 7, NULL, true, 'ind_b', 'ind_b', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (146, 'eee', 'carac_avere', 'val', 'caractère invasive avérée', 'evaluation', NULL, 14, NULL, true, 'carac_avere', 'carac_avere', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (191, 'catnat', 'nom_reg', 'string', 'Nom de la région', 'statut_reg', 'region', NULL, NULL, true, 'nom_reg', 'nom_reg', true, 'statut_reg');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (104, 'lr', 'fluct_extrem_iv', 'bool', 'Fluctuation extrême(Nb Loc)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_iv', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (103, 'lr', 'fluct_extrem_ii', 'bool', 'Fluctuation extrême(AOO)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_ii', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (59, 'eee', 'ida', 'val', 'Argument - taxonomie', 'liste_argument_11', NULL, NULL, NULL, true, NULL, 'ida11', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (58, 'eee', 'ida', 'val', 'Argument - type biologique', 'liste_argument_8', NULL, NULL, NULL, true, NULL, 'ida8', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (150, 'eee', 'ind_c', 'int', 'Score weber risque impact', 'evaluation', NULL, 8, NULL, true, 'ind_c', 'ind_c', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (159, 'eee', 'fiab', 'bool', 'Fiabilité - taxonomie', 'fiab_11', NULL, NULL, NULL, true, NULL, 'fiab11', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (158, 'eee', 'fiab', 'bool', 'Fiabilité - habitat espèce', 'fiab_12', NULL, NULL, NULL, true, NULL, 'fiab12', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (157, 'eee', 'fiab', 'bool', 'Fiabilité - densité de la population', 'fiab_13', NULL, NULL, NULL, true, NULL, 'fiab13', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (156, 'eee', 'fiab', 'bool', 'Fiabilité - présence international', 'fiab_1', NULL, NULL, NULL, true, NULL, 'fiab1', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (155, 'eee', 'fiab', 'bool', 'Fiabilité - indigenat international', 'fiab_2', NULL, NULL, NULL, true, NULL, 'fiab2', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (154, 'eee', 'fiab', 'bool', 'Fiabilité - présence en France', 'fiab_3', NULL, NULL, NULL, true, NULL, 'fiab3', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (57, 'eee', 'ida', 'val', 'Argument - mode de dispersion', 'liste_argument_7', NULL, NULL, NULL, true, NULL, 'ida7', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (56, 'eee', 'ida', 'val', 'Argument - croissance végétative', 'liste_argument_6', NULL, NULL, NULL, true, NULL, 'ida6', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (55, 'eee', 'ida', 'val', 'Argument - viabilité des graines et reproduction', 'liste_argument_5', NULL, NULL, NULL, true, NULL, 'ida5', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (64, 'eee', 'ida', 'val', 'Argument - synthèse C (risques d''impact)', 'liste_argument_16', NULL, NULL, NULL, true, NULL, 'ida16', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (76, 'eee', 'idq', 'val', 'Reponse - Densité de population', 'liste_reponse_cg12', 'liste_reponse', NULL, NULL, true, NULL, 'cg12', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (71, 'eee', 'idq', 'val', 'Reponse - Croissance végétative', 'liste_reponse_bg6', 'liste_reponse', NULL, NULL, true, NULL, 'bg6', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (189, 'catnat', 'uid', 'int', 'Identifiant unique', 'taxons_nat', NULL, NULL, NULL, true, 'uid', 'uid', false, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (69, 'eee', 'idq', 'val', 'Reponse - Etendue de sa répartition au niveau mondial', 'liste_reponse_ag4', 'liste_reponse', NULL, NULL, true, NULL, 'ag4', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (68, 'eee', 'idq', 'val', 'Distribution géographique en Europe', 'liste_reponse_ag3', 'liste_reponse', NULL, NULL, true, NULL, 'ag3', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (67, 'eee', 'idq', 'val', 'Reponse - Statut de l''espèce en Europe', 'liste_reponse_ag2', 'liste_reponse', NULL, NULL, true, NULL, 'ag2', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (66, 'eee', 'idq', 'val', 'Reponse - Correspondance climatique', 'liste_reponse_ag1', 'liste_reponse', NULL, NULL, true, NULL, 'ag1', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (160, 'eee', 'fiab', 'bool', 'Fiabilité - statut invasive avérée en France', 'fiab_10', NULL, NULL, NULL, true, NULL, 'fiab10', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (42, 'eee', 'ids', 'val', 'Source - indigenat international', 'liste_source_2', NULL, NULL, NULL, true, NULL, 'ids2', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (63, 'eee', 'ida', 'val', 'Argument - synthèse B (risques de propagation)', 'liste_argument_15', NULL, NULL, NULL, true, NULL, 'ida15', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (19, 'lr', 'cat_synt_reg', 'val', 'Catégorie  Synthèse régionale', 'evaluation', 'categorie_final', 18, NULL, true, 'cat_synt_reg', 'cat_synt_reg', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (18, 'lr', 'cat_euro', 'val', 'Catégorie Europe', 'evaluation', 'categorie_final', 17, NULL, true, 'cat_euro', 'cat_euro', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (179, 'catnat', 'endemisme', 'bool', 'Endemisme', 'statut_nat', NULL, 9, NULL, true, 'endemisme', 'endemisme', true, 'statut_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (167, 'eee', 'ind_tot', 'int', 'Score de Weber', 'evaluation', NULL, 9, NULL, true, 'ind_tot', 'ind_tot', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (16, 'lr', 'cat_fin', 'val', 'Catégorie Nationale finale', 'evaluation', 'categorie_final', 15, NULL, true, 'cat_fin', 'cat_fin', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (182, 'eee', 'gbif_url', 'string', 'URL données GBIF', 'taxons', NULL, 16, NULL, true, 'gbif_url', 'gbif_url', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (125, 'lr', 'cat_c2', 'val', 'Catégorie C2', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_c2', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (22, 'lr', 'avancement', 'val', 'Avancement évaluation', 'evaluation', 'avancement', 21, NULL, true, 'avancement', 'avancement', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (7, 'lr', 'endemisme', 'bool', 'Endemisme', 'taxons', NULL, 6, NULL, true, 'endemisme', 'endemisme', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (12, 'lr', 'cat_a', 'val', 'Catégorie A', 'evaluation', 'categorie_final', 11, NULL, true, 'cat_a', 'cat_a', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (28, 'lr', 'cat_a1', 'val', 'Catégorie A1', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_a1', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (27, 'lr', 'cat_a234', 'val', 'Catégorie A2, A3 et A4', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_a234', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (23, 'lr', 'cat_ini', 'val', 'Catégorie Nationale initiale', 'evaluation', 'categorie_final', NULL, NULL, true, NULL, 'cat_ini', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (62, 'eee', 'ida', 'val', 'Argument - synthèse A (risques introduction et installation)', 'liste_argument_14', NULL, NULL, NULL, true, NULL, 'ida14', true, 'liste_argument');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (26, 'lr', 'cat_d2', 'val', 'Catégorie D2', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_d2', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (15, 'lr', 'cat_d', 'val', 'Catégorie D', 'evaluation', 'categorie_final', 14, NULL, true, 'cat_d', 'cat_d', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (14, 'lr', 'cat_c', 'val', 'Catégorie C', 'evaluation', 'categorie_final', 13, NULL, true, 'cat_c', 'cat_c', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (13, 'lr', 'cat_b', 'val', 'Catégorie B', 'evaluation', 'categorie_final', 12, NULL, true, 'cat_b', 'cat_b', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (75, 'eee', 'idq', 'val', 'Reponse - Habitats de l''espèce', 'liste_reponse_cg11', 'liste_reponse', NULL, NULL, true, NULL, 'cg11', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (21, 'lr', 'notes', 'string', 'Notes', 'evaluation', NULL, 20, NULL, true, 'notes', 'notes', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (17, 'lr', 'just_fin', 'string', 'Justification évaluation nationale', 'evaluation', NULL, 16, NULL, true, 'just_fin', 'just_fin', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (74, 'eee', 'idq', 'val', 'Reponse - Taxonomie', 'liste_reponse_cg10', 'liste_reponse', NULL, NULL, true, NULL, 'cg10', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (73, 'eee', 'idq', 'val', 'Reponse - Type biologique', 'liste_reponse_bg8', 'liste_reponse', NULL, NULL, true, NULL, 'bg8', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (72, 'eee', 'idq', 'val', 'Reponse - Mode de dispersion', 'liste_reponse_bg7', 'liste_reponse', NULL, NULL, true, NULL, 'bg7', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (166, 'eee', 'fiab', 'bool', 'Fiabilité - indigénat en France', 'fiab_4', NULL, NULL, NULL, true, NULL, 'fiab4', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (165, 'eee', 'fiab', 'bool', 'Fiabilité - viabilité des graines et reproduction', 'fiab_5', NULL, NULL, NULL, true, NULL, 'fiab5', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (164, 'eee', 'fiab', 'bool', 'Fiabilité - croissance végétative', 'fiab_6', NULL, NULL, NULL, true, NULL, 'fiab6', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (163, 'eee', 'fiab', 'bool', 'Fiabilité - mode de dispersion', 'fiab_7', NULL, NULL, NULL, true, NULL, 'fiab7', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (162, 'eee', 'fiab', 'bool', 'Fiabilité - type biologique', 'fiab_8', NULL, NULL, NULL, true, NULL, 'fiab8', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (161, 'eee', 'fiab', 'bool', 'Fiabilité - statut invasive avérée international', 'fiab_9', NULL, NULL, NULL, true, NULL, 'fiab9', true, 'liste_source');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (176, 'catnat', 'lr', 'string', 'Liste rouge', 'statut_nat', NULL, 7, NULL, true, 'lr', 'lr', true, 'statut_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (178, 'catnat', 'rarete', 'string', 'Indice de rarete', 'statut_nat', NULL, 8, NULL, true, 'rarete', 'rarete', true, 'statut_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (168, 'eee', 'idr', 'int', 'Echelle de Lavergne', 'statut_inter_lavergne', NULL, 5, NULL, true, 'lavergne', 'idr', true, 'statut_natio');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (77, 'eee', 'idq', 'val', 'Reponse - Mauvaise herbe agricole ailleurs', 'liste_reponse_cg9', 'liste_reponse', NULL, NULL, true, NULL, 'cg9', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (70, 'eee', 'idq', 'val', 'Reponse - Viabilité des graines et reproduction', 'liste_reponse_bg5', 'liste_reponse', NULL, NULL, true, NULL, 'bg5', true, 'liste_reponse');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (40, 'eee', 'idr', 'val', 'Statut invasive avérée en France', 'statut_natio_invav', 'region', 4, NULL, true, 'invav', 'idr_invav', true, NULL);
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (151, 'eee', 'fiab_tot', 'int', 'Fiabilité totale', 'evaluation', NULL, 11, NULL, true, 'fiab_tot', 'fiab_tot', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (8, 'lr', 'aoo4', 'int', 'AOO 4km²', 'chorologie', NULL, 7, NULL, true, 'aoo4', 'aoo4', false, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (20, 'lr', 'nb_reg_evalue', 'int', 'Nb régions évaluées', 'evaluation', NULL, 19, NULL, true, 'nb_reg_evalue', 'nb_reg_evalue', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (455, 'droit_refnat', 'niveau_refnat', 'val', 'Niveau de droit', 'utilisateur', 'droit_refnat', 4, NULL, false, 'niveau_refnat', 'niveau_refnat', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (6, 'lr', 'id_indi', 'val', 'Indigenat', 'taxons', 'indigenat', 5, NULL, true, 'id_indi', 'id_indi', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (145, 'eee', 'carac_emerg', 'val', 'caractère émergent', 'evaluation', NULL, 13, NULL, true, 'carac_emerg', 'carac_emerg', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (106, 'lr', 'id_nbindiv', 'val', 'Nb individus(intervalle)', 'chorologie', 'nbindiv', NULL, NULL, true, NULL, 'id_nbindiv', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (9, 'lr', 'aoo_precis', 'int', 'AOO estimé', 'chorologie', NULL, 8, NULL, true, 'aoo_precis', 'aoo_precis', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (148, 'eee', 'ind_a', 'int', 'Score weber risque introduction installation', 'evaluation', NULL, 6, NULL, true, 'ind_a', 'ind_a', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (136, 'lr', 'just_preced', 'string', 'Justification précédente', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_preced', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (137, 'lr', 'just_euro', 'string', 'Justification évaluation européene', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_euro', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (173, 'catnat', 'nom_vern', 'string', 'Nom vernaculaire', 'taxons_nat', NULL, 4, NULL, true, 'nom_vern', 'nom_vern', false, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (169, 'catnat', 'famille', 'string', 'Famille taxon', 'taxons_nat', NULL, 1, NULL, true, 'famille', 'famille', false, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (174, 'catnat', 'hybride', 'bool', 'Hybride', 'taxons_nat', NULL, 5, NULL, true, 'hybride', 'hybride', false, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (171, 'catnat', 'nom_sci', 'string', 'Nom scientifique', 'taxons_nat', NULL, 2, NULL, true, 'nom_sci', 'nom_sci', false, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (88, 'lr', 'nbm5_total', 'int', 'Nb maille total(calculé)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbm5_total', false, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (11, 'lr', 'nbm5_post1990_est', 'int', 'Nb de maille après 1990', 'chorologie', NULL, 10, NULL, true, 'nbm5_post1990_est', 'nbm5_post1990_est', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (10, 'lr', 'nbloc_precis', 'int', 'Nb de localité(s)', 'chorologie', NULL, 9, NULL, true, 'nbloc_precis', 'nbloc_precis', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (85, 'lr', 'id_nbloc', 'val', 'Nb localité(intervalle)', 'chorologie', 'nbloc', NULL, NULL, true, NULL, 'id_nbloc', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (90, 'lr', 'just_a', 'string', 'Justification critère A', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_a', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (93, 'lr', 'just_d', 'string', 'Justification critère D', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_d', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (92, 'lr', 'just_c', 'string', 'Justification critère C', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_c', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (91, 'lr', 'just_b', 'string', 'Justification critère B', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_b', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (94, 'lr', 'just_e', 'string', 'Justification critère E', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_e', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (134, 'lr', 'just_ini', 'string', 'Justification initiale', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_ini', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (140, 'lr', 'commentaire', 'string', 'Commentaire', 'evaluation', NULL, NULL, NULL, true, NULL, 'commentaire', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (84, 'lr', 'id_aoo', 'val', 'AOO(intervalle)', 'chorologie', 'aoo', NULL, NULL, true, NULL, 'id_aoo', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (128, 'lr', 'crit_d1', 'string', 'Critère D1', 'evaluation', NULL, NULL, NULL, true, NULL, 'crit_d1', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (96, 'lr', 'limite_aire', 'bool', 'Taxon en limite d''aire', 'taxons', NULL, NULL, NULL, true, NULL, 'limite_aire', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (113, 'lr', 'declin_cont_iii', 'bool', 'Déclin continu(habitat)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_iii', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (112, 'lr', 'declin_cont_v', 'bool', 'Déclin continu(individus)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_v', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (111, 'lr', 'declin_cont_i', 'bool', 'Déclin continu(sous population)', 'chorologie', NULL, NULL, NULL, true, NULL, 'declin_cont_i', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (108, 'lr', 'immigration', 'bool', 'Immigration', 'chorologie', NULL, NULL, NULL, true, NULL, 'immigration', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (107, 'lr', 'pop_transfront', 'bool', 'Population transfrontalière', 'chorologie', NULL, NULL, NULL, true, NULL, 'pop_transfront', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (105, 'lr', 'nbindiv_precis', 'bool', 'Nb individus(précis)', 'chorologie', NULL, NULL, NULL, true, NULL, 'nbindiv_precis', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (100, 'lr', 'fragmt_sev', 'bool', 'Fragmentation sévère', 'chorologie', NULL, NULL, NULL, true, NULL, 'fragmt_sev', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (141, 'lr', 'just_synt_reg', 'string', 'Synthèse des justification régionales', 'evaluation', NULL, NULL, NULL, true, NULL, 'just_synt_reg', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (98, 'lr', 'sous_obs', 'bool', 'Taxon sous-observé en métropole', 'taxons', NULL, NULL, NULL, true, NULL, 'sous_obs', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (97, 'lr', 'aire_disjointe', 'bool', 'Taxon en aire disjointe', 'taxons', NULL, NULL, NULL, true, NULL, 'aire_disjointe', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (138, 'lr', 'cd_ajustmt', 'val', 'Ajustement évaluation', 'evaluation', 'ajustmt', NULL, NULL, true, NULL, 'cd_ajustmt', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (127, 'lr', 'cat_d1', 'val', 'Catégorie D1', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_d1', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (123, 'lr', 'cat_c1', 'val', 'Catégorie C1', 'evaluation', 'categorie', NULL, NULL, true, NULL, 'cat_c1', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (131, 'lr', 'cat_e', 'val', 'Catégorie E', 'evaluation', 'categorie_final', NULL, NULL, true, NULL, 'cat_e', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (118, 'lr', 'crit_a1', 'val', 'Critère A1', 'evaluation', 'crit_a1', NULL, NULL, true, NULL, 'crit_a1', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (120, 'lr', 'crit_a2', 'val', 'Critère A2', 'evaluation', 'crit_a234', NULL, NULL, true, NULL, 'crit_a2', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (121, 'lr', 'crit_a3', 'val', 'Critère A3', 'evaluation', 'crit_a234', NULL, NULL, true, NULL, 'crit_a3', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (122, 'lr', 'crit_a4', 'val', 'Critère A4', 'evaluation', 'crit_a234', NULL, NULL, true, NULL, 'crit_a4', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (124, 'lr', 'crit_c1', 'val', 'Critère C1', 'evaluation', 'crit_c1', NULL, NULL, true, NULL, 'crit_c1', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (126, 'lr', 'crit_c2', 'val', 'Critère C2', 'evaluation', 'crit_c2', NULL, NULL, true, NULL, 'crit_c2', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (114, 'lr', 'id_tendance_pop', 'val', 'Tendance de la population', 'chorologie', 'tendance_pop', NULL, NULL, true, NULL, 'id_tendance_pop', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (130, 'lr', 'crit_d2', 'string', 'Critère D2', 'evaluation', NULL, NULL, NULL, true, NULL, 'crit_d2', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (116, 'lr', 'fluct_extrem_v', 'bool', 'Fluctuation extrême(individus)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_v', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (115, 'lr', 'fluct_extrem_iii', 'bool', 'Fluctuation extrême(sous population)', 'chorologie', NULL, NULL, NULL, true, NULL, 'fluct_extrem_iii', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (110, 'lr', 'id_reduc_eff', 'val', 'Réduction de l''effectif(intervalle)', 'chorologie', 'reduc_eff', NULL, NULL, true, NULL, 'id_reduc_eff', true, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (143, 'lr', 'aoo1', 'int', 'AOO(1km²)', 'chorologie', NULL, NULL, NULL, true, NULL, 'aoo1', false, 'chorologie');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (135, 'lr', 'cat_preced', 'val', 'Catégorie précédente', 'evaluation', 'categorie_final', NULL, NULL, true, NULL, 'cat_preced', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (142, 'lr', 'nb_reg_presence', 'int', 'Nombre de régions où le taxon est présent', 'evaluation', NULL, NULL, NULL, true, NULL, 'nb_reg_presence', false, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (139, 'lr', 'id_raison_ajust', 'val', 'Explication ajustement évaluation', 'evaluation', 'raison_ajust', NULL, NULL, true, NULL, 'id_raison_ajust', true, 'evaluation');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (198, 'defaut', 'info_int', 'int', 'Entier', 'base', NULL, 3, NULL, true, 'info_int', 'info_int', true, 'base');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (199, 'defaut', 'info_bool', 'bool', 'booléen', 'base', NULL, 4, NULL, true, 'info_bool', 'info_bool', true, 'base');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (440, 'droit_lr', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (441, 'droit_lr', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (442, 'droit_lr', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (2, 'lr', 'famille', 'string', 'Famille taxon', 'taxons', NULL, 1, NULL, true, 'famille', 'famille', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (95, 'lr', 'nom_vern', 'string', 'Nom vernaculaire', 'taxons', NULL, NULL, NULL, true, NULL, 'nom_vern', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (195, 'defaut', 'uid', 'int', 'Identifiant unique', 'base', NULL, 0, NULL, true, 'uid', 'uid', true, 'base');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (196, 'defaut', 'info_text', 'string', 'Texte', 'base', NULL, 1, NULL, true, 'info_text', 'info_text', true, 'base');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (197, 'defaut', 'info_real', 'float', 'Reel', 'base', NULL, 2, NULL, true, 'info_real', 'info_real', true, 'base');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (456, 'droit_eee', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (451, 'droit_refnat', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (452, 'droit_refnat', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (453, 'droit_refnat', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (99, 'lr', 'hybride', 'bool', 'Taxon hybride', 'taxons', NULL, NULL, NULL, true, NULL, 'hybride', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (457, 'droit_eee', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (458, 'droit_eee', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (443, 'droit_lr', 'id_cbn', 'val', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (445, 'droit_lr', 'niveau_lr', 'val', 'Niveau de droit', 'utilisateur', 'droit_lr', 4, NULL, false, 'niveau_lr', 'niveau_lr', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (446, 'droit_catnat', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (447, 'droit_catnat', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (448, 'droit_catnat', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (460, 'droit_eee', 'niveau_eee', 'val', 'Niveau de droit', 'utilisateur', 'droit_eee', 4, NULL, false, 'niveau_eee', 'niveau_eee', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (449, 'droit_catnat', 'id_cbn', 'val', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (450, 'droit_catnat', 'niveau_catnat', 'val', 'Niveau de droit', 'utilisateur', 'droit_catnat', 4, NULL, false, 'niveau_catnat', 'niveau_catnat', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (386, 'refnat', 'uid', 'int', 'Identifiant unique', 'taxons', NULL, NULL, NULL, true, 'uid', 'uid', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (387, 'refnat', 'cd_nom', 'int', 'Code unique du taxon dans TAXREF', 'taxons', NULL, 0, NULL, true, 'cd_nom', 'cd_nom', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (388, 'refnat', 'cd_ref', 'int', 'Code de référence du taxon dans TAXREF', 'taxons', NULL, 1, NULL, true, 'cd_ref', 'cd_ref', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (389, 'refnat', 'cd_taxsup', 'int', 'Code de référence du taxon supérieur dans TAXREF', 'taxons', NULL, NULL, NULL, true, 'cd_taxsup', 'cd_taxsup', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (390, 'refnat', 'rang', 'string', 'Rang taxonomique', 'taxons', NULL, 3, NULL, true, 'rang', 'rang', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (391, 'refnat', 'regne', 'string', 'Regne', 'taxons', NULL, NULL, NULL, true, 'regne', 'regne', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (392, 'refnat', 'phylum', 'string', 'Phylum', 'taxons', NULL, NULL, NULL, true, 'phylum', 'phylum', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (393, 'refnat', 'classe', 'string', 'Classe', 'taxons', NULL, NULL, NULL, true, 'classe', 'classe', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (394, 'refnat', 'ordre', 'string', 'Ordre', 'taxons', NULL, NULL, NULL, true, 'ordre', 'ordre', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (395, 'refnat', 'famille', 'string', 'Famille', 'taxons', NULL, 4, NULL, true, 'famille', 'famille', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (396, 'refnat', 'group1_inpn', 'string', 'Groupe principal', 'taxons', NULL, NULL, NULL, true, 'group1_inpn', 'group1_inpn', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (397, 'refnat', 'group2_inpn', 'string', 'Groupe secondaire', 'taxons', NULL, 5, NULL, true, 'group2_inpn', 'group2_inpn', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (184, 'lr', 'uid', 'int', 'Identifiant unique', 'taxons', NULL, NULL, NULL, true, NULL, 'uid', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (3, 'lr', 'cd_ref', 'int', 'CD REF', 'taxons', NULL, 2, NULL, true, 'cd_ref', 'cd_ref', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (4, 'lr', 'nom_sci', 'string', 'Nom scientifique', 'taxons', NULL, 3, NULL, true, 'nom_sci', 'nom_sci', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (5, 'lr', 'id_rang', 'val', 'Rang', 'taxons', 'rang', 4, NULL, true, 'id_rang', 'id_rang', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (183, 'eee', 'uid', 'int', 'Identifiant unique', 'taxons', NULL, NULL, NULL, true, NULL, 'uid', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (35, 'eee', 'nom_sci', 'string', 'Nom scientifique', 'taxons', NULL, 1, NULL, true, 'nom_sci', 'nom_sci', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (37, 'eee', 'nom_verna', 'string', 'Nom Vernaculaire', 'taxons', NULL, NULL, NULL, true, NULL, 'nom_verna', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (34, 'eee', 'cd_ref', 'int', 'Code REF.', 'taxons', NULL, 0, NULL, true, 'cd_ref', 'cd_ref', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (170, 'catnat', 'cd_ref', 'int', 'Code REF.', 'taxons_nat', NULL, 0, NULL, true, 'cd_ref', 'cd_ref', false, 'taxons_nat');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (36, 'eee', 'lib_rang', 'val', 'Rang', 'taxons', 'rang', 2, NULL, true, 'lib_rang', 'lib_rang', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (477, 'droit_lsi', 'id_user', 'string', 'Code utilisateur', 'utilisateur', NULL, 0, NULL, false, 'id_user', 'id_user', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (478, 'droit_lsi', 'prenom', 'string', 'Prénom', 'utilisateur', NULL, 1, NULL, false, 'prenom', 'prenom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (479, 'droit_lsi', 'nom', 'string', 'Nom', 'utilisateur', NULL, 2, NULL, false, 'nom', 'nom', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (482, 'droit_lsi', 'ref_lsi', 'bool', 'Référent LSI', 'utilisateur', NULL, 5, NULL, false, 'ref_lsi', 'ref_lsi', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (480, 'droit_lsi', 'id_cbn', 'val', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (481, 'droit_lsi', 'niveau_lsi', 'val', 'Niveau de droit', 'utilisateur', 'droit_lsi', 4, NULL, false, 'niveau_lsi', 'niveau_lsi', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (398, 'refnat', 'lb_nom', 'string', 'Nom du taxon', 'taxons', NULL, NULL, NULL, true, 'lb_nom', 'lb_nom', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (399, 'refnat', 'lb_auteur', 'string', 'Autorité du taxon', 'taxons', NULL, NULL, NULL, true, 'lb_auteur', 'lb_auteur', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (432, 'refnat', 'modif', 'bool', 'Taxon différent de la dernière version de TAXREF', 'taxons', NULL, 14, NULL, true, 'modif', 'modif', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (425, 'refnat', 'pres_v2', 'bool', 'Taxon présent dans taxref v2', 'taxons', NULL, 7, NULL, true, 'pres_v2', 'pres_v2', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (400, 'refnat', 'nom_complet', 'string', 'Nom complet du taxon', 'taxons', NULL, 2, NULL, true, 'nom_complet', 'nom_complet', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (401, 'refnat', 'nom_complet_html', 'string', 'Nom complet du taxon - version html', 'taxons', NULL, NULL, NULL, true, 'nom_complet_html', 'nom_complet_html', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (402, 'refnat', 'nom_valide', 'string', 'Nom valide du taxon', 'taxons', NULL, NULL, NULL, true, 'nom_valide', 'nom_valide', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (403, 'refnat', 'nom_vern', 'string', 'Nom vernaculaire du taxon', 'taxons', NULL, NULL, NULL, true, 'nom_vern', 'nom_vern', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (404, 'refnat', 'nom_vern_eng', 'string', 'Nom vernaculaire anglais du taxon', 'taxons', NULL, NULL, NULL, true, 'nom_vern_eng', 'nom_vern_eng', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (405, 'refnat', 'habitat', 'int', 'Habitat du taxon', 'taxons', NULL, NULL, NULL, true, 'habitat', 'habitat', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (406, 'refnat', 'fr', 'string', 'FR', 'taxons', NULL, 6, NULL, true, 'fr', 'fr', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (407, 'refnat', 'gf', 'string', 'GF', 'taxons', NULL, NULL, NULL, true, 'gf', 'gf', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (408, 'refnat', 'mar', 'string', 'MAR', 'taxons', NULL, NULL, NULL, true, 'mar', 'mar', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (409, 'refnat', 'gua', 'string', 'GUA', 'taxons', NULL, NULL, NULL, true, 'gua', 'gua', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (410, 'refnat', 'sm', 'string', 'SM', 'taxons', NULL, NULL, NULL, true, 'sm', 'sm', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (411, 'refnat', 'sb', 'string', 'SB', 'taxons', NULL, NULL, NULL, true, 'sb', 'sb', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (412, 'refnat', 'spm', 'string', 'SPM', 'taxons', NULL, NULL, NULL, true, 'spm', 'spm', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (413, 'refnat', 'may', 'string', 'MAY', 'taxons', NULL, NULL, NULL, true, 'may', 'may', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (414, 'refnat', 'epa', 'string', 'EPA', 'taxons', NULL, NULL, NULL, true, 'epa', 'epa', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (415, 'refnat', 'reu', 'string', 'REU', 'taxons', NULL, NULL, NULL, true, 'reu', 'reu', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (416, 'refnat', 'taaf', 'string', 'TAAF', 'taxons', NULL, NULL, NULL, true, 'taaf', 'taaf', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (417, 'refnat', 'pf', 'string', 'PF', 'taxons', NULL, NULL, NULL, true, 'pf', 'pf', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (418, 'refnat', 'nc', 'string', 'NC', 'taxons', NULL, NULL, NULL, true, 'nc', 'nc', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (419, 'refnat', 'cli', 'string', 'CLI', 'taxons', NULL, NULL, NULL, true, 'cli', 'cli', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (420, 'refnat', 'url', 'string', 'URL', 'taxons', NULL, NULL, NULL, true, 'url', 'url', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (421, 'refnat', 'hybride', 'bool', 'Taxon hybride', 'taxons', NULL, NULL, NULL, true, 'hybride', 'hybride', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (423, 'refnat', 'catnat', 'bool', 'Appartient au module CATNAT', 'taxons', NULL, NULL, NULL, true, 'catnat', 'catnat', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (424, 'refnat', 'eee', 'bool', 'Appartient au module EEE', 'taxons', NULL, NULL, NULL, true, 'eee', 'eee', true, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (426, 'refnat', 'pres_v3', 'bool', 'Taxon présent dans taxref v3', 'taxons', NULL, 8, NULL, true, 'pres_v3', 'pres_v3', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (427, 'refnat', 'pres_v4', 'bool', 'Taxon présent dans taxref v4', 'taxons', NULL, 9, NULL, true, 'pres_v4', 'pres_v4', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (428, 'refnat', 'pres_v5', 'bool', 'Taxon présent dans taxref v5', 'taxons', NULL, 10, NULL, true, 'pres_v5', 'pres_v5', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (429, 'refnat', 'pres_v6', 'bool', 'Taxon présent dans taxref v6', 'taxons', NULL, 11, NULL, true, 'pres_v6', 'pres_v6', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (430, 'refnat', 'pres_v7', 'bool', 'Taxon présent dans taxref v7', 'taxons', NULL, 12, NULL, true, 'pres_v7', 'pres_v7', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (431, 'refnat', 'pres_v8', 'bool', 'Taxon présent dans taxref v8', 'taxons', NULL, 13, NULL, true, 'pres_v8', 'pres_v8', false, 'taxons');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (469, 'lsi', 'id', 'int', 'identifiant de la news', 'news', NULL, 0, NULL, true, 'id', 'id', false, 'news');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (471, 'lsi', 'title', 'string', 'titre de la news', 'news', NULL, 2, NULL, true, 'title', 'title', true, 'news');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (472, 'lsi', 'abstract', 'string', 'extrait de la news', 'news', NULL, 3, NULL, true, 'abstract', 'abstract', true, 'news');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (474, 'lsi', 'link', 'string', 'lien de la news', 'news', NULL, 5, NULL, true, 'link', 'link', true, 'news');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (475, 'lsi', 'link_2', 'string', 'lien de la news', 'news', NULL, 6, NULL, true, 'link_2', 'link_2', true, 'news');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (476, 'lsi', 'date', 'string', 'lien de la news', 'news', NULL, 7, NULL, true, 'date', 'date', true, 'news');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (470, 'lsi', 'id_subject', 'val', 'sujet de la news', 'news', 'subject', 1, NULL, true, 'id_subject', 'id_subject', true, 'news');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (473, 'lsi', 'libelle_tag', 'string', 'tag de la news', 'tag', NULL, 4, NULL, true, 'libelle_tag', 'libelle_tag', true, 'tag');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (483, 'droit_lr', 'ref_lr', 'bool', 'Référent LSI', 'utilisateur', NULL, 5, NULL, false, 'ref_lr', 'ref_lr', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (484, 'droit_eee', 'ref_eee', 'bool', 'Référent LSI', 'utilisateur', NULL, 5, NULL, false, 'ref_eee', 'ref_eee', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (485, 'droit_catnat', 'ref_catnat', 'bool', 'Référent LSI', 'utilisateur', NULL, 5, NULL, false, 'ref_catnat', 'ref_catnat', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (486, 'droit_refnat', 'ref_refnat', 'bool', 'Référent LSI', 'utilisateur', NULL, 5, NULL, false, 'ref_refnat', 'ref_refnat', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (459, 'droit_eee', 'id_cbn', 'val', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (454, 'droit_refnat', 'id_cbn', 'val', 'Institution', 'utilisateur', 'cbn', 3, NULL, false, 'id_cbn', 'id_cbn', false, 'utilisateur');
INSERT INTO champs (id, rubrique_champ, nom_champ, type, description, table_champ, referentiel, pos, description_longue, export_display, nom_champ_synthese, champ_interface, modifiable, table_bd) VALUES (422, 'refnat', 'lr', 'bool', 'Appartient au module LR', 'taxons', NULL, NULL, NULL, true, 'lr', 'lr', true, 'taxons');


--
-- Name: champs_id_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: postgres
--

SELECT pg_catalog.setval('champs_id_seq', 486, true);


--
-- Data for Name: champs_ref; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--

INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (24, 'etape', 'cd', 'lib', 'referentiels', 'etape', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (25, 'id_indi', 'id_indi', 'cd_indi', 'referentiels', 'indigenat', NULL, 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (2, 'indigenat', 'id_indi', 'lib_indi', 'referentiels', 'indigenat', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (1, 'rang', 'id_rang', 'lib_rang', 'referentiels', 'rang', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (12, 'raison_ajust', 'id_raison_ajust', 'lib_raison_ajust', 'referentiels', 'raison_ajust', 'id_raison_ajust', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (26, 'region', 'insee_reg', 'region', 'eee', 'region', '', 'catnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (27, 'statut', 'type_statut', 'lib_statut', 'referentiels', 'statut', '', 'catnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (28, 'indigenat', 'cd_indi', 'lib_indi', 'referentiels', 'indigenat', '', 'catnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (29, 'categorie_final', 'cd_cat', 'cd_cat', 'referentiels', 'categorie_final', '', 'catnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (16, 'categorie_final', 'id_cat', 'cd_cat', 'referentiels', 'categorie_final', 'id_cat', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (15, 'categorie', 'id_cat', 'cd_cat', 'referentiels', 'categorie', 'id_cat', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (14, 'tendance_pop', 'id_tendance_pop', 'lib_tendance_pop', 'referentiels', 'tendance_pop', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (13, 'chgt_cat', 'cd_chgt_cat', 'lib_chgt_cat', 'referentiels', 'chgt_cat', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (11, 'ajustmt', 'cd_ajustmt', 'lib_ajustmt', 'referentiels', 'ajustmt', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (10, 'crit_c2', 'id_crit_c2', 'cd_crit_c2', 'referentiels', 'crit_c2', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (9, 'crit_c1', 'id_crit_c1', 'cd_crit_c1', 'referentiels', 'crit_c1', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (8, 'crit_a234', 'id_crit_a234', 'cd_crit_a234', 'referentiels', 'crit_a234', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (7, 'crit_a1', 'id_crit_a1', 'cd_crit_a1', 'referentiels', 'crit_a1', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (6, 'reduc_eff', 'id_reduc_eff', 'cd_reduc_eff', 'referentiels', 'reduc_eff', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (5, 'nbindiv', 'id_nbindiv', 'cd_nbindiv', 'referentiels', 'nbindiv', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (4, 'nbloc', 'id_nbloc', 'cd_nbloc', 'referentiels', 'nbloc', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (3, 'aoo', 'id_aoo', 'cd_aoo', 'referentiels', 'aoo', 'id_aoo', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (17, 'pays', 'idp', 'pays', 'eee', 'pays', '', 'eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (18, 'region', 'idr', 'region', 'eee', 'region', '', 'eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (19, 'liste_source', 'ids', 'libelle', 'eee', 'liste_source', '', 'eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (20, 'liste_argument', 'ida', 'libelle', 'eee', 'liste_argument', '', 'eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (21, 'liste_question', 'code_question', 'libelle_question', 'eee', 'liste_reponse', '', 'eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (22, 'liste_reponse', 'idq', 'libelle_court_reponse', 'eee', 'liste_reponse', '', 'eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (30, 'avancement', 'cd', 'lib', 'referentiels', 'avancement', '', 'lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (36, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (39, 'droit_lr', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_lr');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (40, 'droit_catnat', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_catnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (41, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_catnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (42, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_refnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (43, 'droit_refnat', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_refnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (44, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (45, 'droit_eee', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (47, 'rang', 'cd_rang', 'lib_rang', 'referentiels', 'rang', NULL, 'catnat');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (48, 'rang', 'cd_rang', 'lib_rang', 'referentiels', 'rang', NULL, 'eee');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (49, 'subject', 'id_subject', 'libelle_subject', 'lsi', 'subject', NULL, 'lsi');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (50, 'cbn', 'id_cbn', 'lib_cbn', 'referentiels', 'cbn', '', 'droit_lsi');
INSERT INTO champs_ref (id, nom_ref, cle, valeur, schema, table_ref, orderby, rubrique_ref) VALUES (51, 'droit_lsi', 'cd', 'lib', 'referentiels', 'droit', '', 'droit_lsi');


--
-- Name: champs_ref_id_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: postgres
--

SELECT pg_catalog.setval('champs_ref_id_seq', 51, true);


--
-- Data for Name: chgt_cat; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO chgt_cat (id_chgt_cat, cd_chgt_cat, lib_chgt_cat) VALUES (0, '', '');
INSERT INTO chgt_cat (id_chgt_cat, cd_chgt_cat, lib_chgt_cat) VALUES (1, 'V', 'Changement véritable (V)');
INSERT INTO chgt_cat (id_chgt_cat, cd_chgt_cat, lib_chgt_cat) VALUES (2, 'Nvc', 'Changement non véritable (NV) - lié à l’amélioration des connaissances (NVc)');
INSERT INTO chgt_cat (id_chgt_cat, cd_chgt_cat, lib_chgt_cat) VALUES (3, 'NVt', 'Changement non véritable (NV)-  lié à un changement taxonomique (NVt)');
INSERT INTO chgt_cat (id_chgt_cat, cd_chgt_cat, lib_chgt_cat) VALUES (4, 'Nve', 'Changement non véritable (NV)- lié à une erreur d’évaluation antérieure (NVe)');
INSERT INTO chgt_cat (id_chgt_cat, cd_chgt_cat, lib_chgt_cat) VALUES (5, 'NVm', 'Changement non véritable (NV)- lié à un changement de la méthodologie ou des lignes directrices d’application (NVm)');
INSERT INTO chgt_cat (id_chgt_cat, cd_chgt_cat, lib_chgt_cat) VALUES (6, 'Non', 'Aucun changement (Non)');


--
-- Name: chgt_cat_id_chgt_cat_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('chgt_cat_id_chgt_cat_seq', 1, false);


--
-- Data for Name: crit_a1; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (0, '', NULL);
INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (1, '100%', NULL);
INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (2, '≥ 90%', NULL);
INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (3, '≥ 70%', NULL);
INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (4, '≥ 50%', NULL);
INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (5, '≥ 40%', NULL);
INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (6, '< 40%', NULL);
INSERT INTO crit_a1 (id_crit_a1, cd_crit_a1, lib_crit_a1) VALUES (7, 'Inconnu', NULL);


--
-- Name: crit_a1_id_crit_a1_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('crit_a1_id_crit_a1_seq', 1, false);


--
-- Data for Name: crit_a234; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (0, '', NULL);
INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (1, '100%', NULL);
INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (2, '≥ 80%', NULL);
INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (3, '≥ 50%', NULL);
INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (4, '≥ 30%', NULL);
INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (5, '≥ 20%', NULL);
INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (6, '< 20%', NULL);
INSERT INTO crit_a234 (id_crit_a234, cd_crit_a234, lib_crit_a234) VALUES (7, 'Inconnu', NULL);


--
-- Name: crit_a234_id_crit_a234_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('crit_a234_id_crit_a234_seq', 1, false);


--
-- Data for Name: crit_c1; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO crit_c1 (id_crit_c1, cd_crit_c1, lib_crit_c1) VALUES (0, '', NULL);
INSERT INTO crit_c1 (id_crit_c1, cd_crit_c1, lib_crit_c1) VALUES (1, 'Inconnu', NULL);
INSERT INTO crit_c1 (id_crit_c1, cd_crit_c1, lib_crit_c1) VALUES (2, '<10', NULL);
INSERT INTO crit_c1 (id_crit_c1, cd_crit_c1, lib_crit_c1) VALUES (3, '10 à 20', NULL);
INSERT INTO crit_c1 (id_crit_c1, cd_crit_c1, lib_crit_c1) VALUES (4, '20 à 25', NULL);
INSERT INTO crit_c1 (id_crit_c1, cd_crit_c1, lib_crit_c1) VALUES (5, '25 et plus', NULL);


--
-- Name: crit_c1_id_crit_c1_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('crit_c1_id_crit_c1_seq', 1, false);


--
-- Data for Name: crit_c2; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO crit_c2 (id_crit_c2, cd_crit_c2, lib_crit_c2) VALUES (0, '', '');
INSERT INTO crit_c2 (id_crit_c2, cd_crit_c2, lib_crit_c2) VALUES (1, 'CR', 'En danger critique');
INSERT INTO crit_c2 (id_crit_c2, cd_crit_c2, lib_crit_c2) VALUES (2, 'EN', 'En danger');
INSERT INTO crit_c2 (id_crit_c2, cd_crit_c2, lib_crit_c2) VALUES (3, 'VU', 'Vulnérable');
INSERT INTO crit_c2 (id_crit_c2, cd_crit_c2, lib_crit_c2) VALUES (4, 'Inconnu', 'Inconnu');


--
-- Name: crit_c2_id_crit_c2_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('crit_c2_id_crit_c2_seq', 1, false);


--
-- Data for Name: droit; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO droit (id, cd, lib) VALUES (0, 0, 'Pas d''accès');
INSERT INTO droit (id, cd, lib) VALUES (1, 1, 'Lecteur');
INSERT INTO droit (id, cd, lib) VALUES (2, 64, 'Participant');
INSERT INTO droit (id, cd, lib) VALUES (3, 128, 'Evaluateur');
INSERT INTO droit (id, cd, lib) VALUES (4, 255, 'Administrateur');
INSERT INTO droit (id, cd, lib) VALUES (5, 512, 'Super Admin');


--
-- Data for Name: etape; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO etape (id, cd, lib) VALUES (0, 0, NULL);
INSERT INTO etape (id, cd, lib) VALUES (1, 1, 'pré-eval');
INSERT INTO etape (id, cd, lib) VALUES (2, 2, 'éval');
INSERT INTO etape (id, cd, lib) VALUES (3, 3, 'post-eval');


--
-- Data for Name: indigenat; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO indigenat (id_indi, cd_indi, lib_indi) VALUES (0, '', '');
INSERT INTO indigenat (id_indi, cd_indi, lib_indi) VALUES (1, 'I', 'Indigène');
INSERT INTO indigenat (id_indi, cd_indi, lib_indi) VALUES (2, 'I?', 'Cryptogène');
INSERT INTO indigenat (id_indi, cd_indi, lib_indi) VALUES (3, 'E', 'Exotique');


--
-- Name: indigenat_id_indi_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('indigenat_id_indi_seq', 1, false);


--
-- Data for Name: liste_rouge; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--

INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (0, '', '');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (1, 'EX', 'Éteinte');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (2, 'EW', 'Disparue à l état sauvage');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (3, 'RE', 'Disparue au niveau régional');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (4, 'CR*', 'Disparue ?');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (5, 'CR', 'En danger critique');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (6, 'EN', 'En danger');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (7, 'VU', 'Vulnérable');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (8, 'NT', 'Quasi menacée');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (9, 'LC', 'Préoccupation mineure');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (10, 'DD', 'Données insuffisantes');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (11, 'NE', 'Non évalué');
INSERT INTO liste_rouge (id_cat, cd_cat, lib_cat) VALUES (12, 'NA', 'Non évaluable');


--
-- Data for Name: nbindiv; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (0, '', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (1, '0', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (2, '< 50', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (3, '< 250', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (4, '< 1 000', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (5, '< 2 000', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (6, '< 2 500', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (7, '< 10 000', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (8, '≤ 15 000', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (9, '> 15 000', NULL);
INSERT INTO nbindiv (id_nbindiv, cd_nbindiv, lib_nbindiv) VALUES (10, 'Inconnu', NULL);


--
-- Name: nbindiv_id_nbindiv_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('nbindiv_id_nbindiv_seq', 1, false);


--
-- Data for Name: nbloc; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO nbloc (id_nbloc, cd_nbloc, lib_nbloc) VALUES (0, '', NULL);
INSERT INTO nbloc (id_nbloc, cd_nbloc, lib_nbloc) VALUES (1, '1', NULL);
INSERT INTO nbloc (id_nbloc, cd_nbloc, lib_nbloc) VALUES (2, '≤ 5', NULL);
INSERT INTO nbloc (id_nbloc, cd_nbloc, lib_nbloc) VALUES (3, '≤ 10', NULL);
INSERT INTO nbloc (id_nbloc, cd_nbloc, lib_nbloc) VALUES (4, '≤ 15', NULL);
INSERT INTO nbloc (id_nbloc, cd_nbloc, lib_nbloc) VALUES (5, '> 15', NULL);


--
-- Name: nbloc_id_nbloc_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('nbloc_id_nbloc_seq', 2, true);


--
-- Data for Name: raison_ajust; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO raison_ajust (id_raison_ajust, cd_raison_ajust, lib_raison_ajust) VALUES (1, 'V', 'Changement véritable (V)');
INSERT INTO raison_ajust (id_raison_ajust, cd_raison_ajust, lib_raison_ajust) VALUES (2, 'Nvc', 'Changement non véritable (NV) - lié à l’amélioration des connaissances (NVc)');
INSERT INTO raison_ajust (id_raison_ajust, cd_raison_ajust, lib_raison_ajust) VALUES (3, 'NVt', 'Changement non véritable (NV)-  lié à un changement taxonomique (NVt)');
INSERT INTO raison_ajust (id_raison_ajust, cd_raison_ajust, lib_raison_ajust) VALUES (4, 'Nve', 'Changement non véritable (NV)- lié à une erreur d’évaluation antérieure (NVe)');
INSERT INTO raison_ajust (id_raison_ajust, cd_raison_ajust, lib_raison_ajust) VALUES (5, 'NVm', 'Changement non véritable (NV)- lié à un changement de la méthodologie ou des lignes directrices d’application (NVm)');
INSERT INTO raison_ajust (id_raison_ajust, cd_raison_ajust, lib_raison_ajust) VALUES (6, 'Non', 'Aucun changement (Non)');
INSERT INTO raison_ajust (id_raison_ajust, cd_raison_ajust, lib_raison_ajust) VALUES (0, '0', '');


--
-- Name: raison_ajust_id_raison_ajust_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('raison_ajust_id_raison_ajust_seq', 1, false);


--
-- Data for Name: rang; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (0, '', '');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (1, 'ES', 'espèce');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (2, 'SSES', 'sous-espèce');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (3, 'VAR', 'variété');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (4, 'SVAR', 'sous-variété');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (5, 'FO', 'forme');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (6, 'SSFO', 'sous-forme');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (7, 'RACE', 'Race');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (8, 'CAR', 'Cultivar');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (9, 'KD', 'Règne');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (10, 'PH', 'Phylum');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (11, 'CL', 'Classe');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (12, 'OR', 'Ordre');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (13, 'FM', 'Famille');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (14, 'GN', 'Genre');
INSERT INTO rang (id_rang, cd_rang, lib_rang) VALUES (15, 'AGES', 'Agrégat');


--
-- Name: rang_id_rang_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('rang_id_rang_seq', 2, true);


--
-- Data for Name: reduc_eff; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (0, '', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (1, '100%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (2, '≥ 90%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (3, '≥ 80%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (4, '≥ 70%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (5, '≥ 50%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (6, '≥ 40%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (7, '≥ 30%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (8, '≥ 20%', NULL);
INSERT INTO reduc_eff (id_reduc_eff, cd_reduc_eff, lib_reduc_eff) VALUES (9, '< 20%', NULL);


--
-- Name: reduc_eff_id_reduc_eff_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('reduc_eff_id_reduc_eff_seq', 1, false);


--
-- Data for Name: regions; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--

INSERT INTO regions (id_reg, nom_reg) VALUES (1, 'Guadeloupe');
INSERT INTO regions (id_reg, nom_reg) VALUES (2, 'Martinique');
INSERT INTO regions (id_reg, nom_reg) VALUES (3, 'Guyane');
INSERT INTO regions (id_reg, nom_reg) VALUES (4, 'La Réunion');
INSERT INTO regions (id_reg, nom_reg) VALUES (6, 'Mayotte');
INSERT INTO regions (id_reg, nom_reg) VALUES (11, 'Île-de-France');
INSERT INTO regions (id_reg, nom_reg) VALUES (21, 'Champagne-Ardenne');
INSERT INTO regions (id_reg, nom_reg) VALUES (22, 'Picardie');
INSERT INTO regions (id_reg, nom_reg) VALUES (23, 'Haute-Normandie');
INSERT INTO regions (id_reg, nom_reg) VALUES (24, 'Centre');
INSERT INTO regions (id_reg, nom_reg) VALUES (25, 'Basse-Normandie');
INSERT INTO regions (id_reg, nom_reg) VALUES (26, 'Bourgogne');
INSERT INTO regions (id_reg, nom_reg) VALUES (31, 'Nord-Pas-de-Calais');
INSERT INTO regions (id_reg, nom_reg) VALUES (41, 'Lorraine');
INSERT INTO regions (id_reg, nom_reg) VALUES (42, 'Alsace');
INSERT INTO regions (id_reg, nom_reg) VALUES (43, 'Franche-Comté');
INSERT INTO regions (id_reg, nom_reg) VALUES (52, 'Pays de la Loire');
INSERT INTO regions (id_reg, nom_reg) VALUES (53, 'Bretagne');
INSERT INTO regions (id_reg, nom_reg) VALUES (54, 'Poitou-Charentes');
INSERT INTO regions (id_reg, nom_reg) VALUES (72, 'Aquitaine');
INSERT INTO regions (id_reg, nom_reg) VALUES (73, 'Midi-Pyrénées');
INSERT INTO regions (id_reg, nom_reg) VALUES (74, 'Limousin');
INSERT INTO regions (id_reg, nom_reg) VALUES (82, 'Rhône-Alpes');
INSERT INTO regions (id_reg, nom_reg) VALUES (83, 'Auvergne');
INSERT INTO regions (id_reg, nom_reg) VALUES (91, 'Languedoc-Roussillon');
INSERT INTO regions (id_reg, nom_reg) VALUES (93, 'Provence-Alpes-Côte d''Azur');
INSERT INTO regions (id_reg, nom_reg) VALUES (94, 'Corse');


--
-- Data for Name: statut; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--

INSERT INTO statut (id, type_statut, lib_statut) VALUES (1, 'INDI', 'Indigénat');
INSERT INTO statut (id, type_statut, lib_statut) VALUES (2, 'LR', 'Liste rouge');
INSERT INTO statut (id, type_statut, lib_statut) VALUES (3, 'RAR', 'Rareté');
INSERT INTO statut (id, type_statut, lib_statut) VALUES (4, 'END', 'Endémisme');
INSERT INTO statut (id, type_statut, lib_statut) VALUES (5, 'PRES', 'Présence');


--
-- Name: statut_id_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: postgres
--

SELECT pg_catalog.setval('statut_id_seq', 5, true);


--
-- Data for Name: taxref_5; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--



--
-- Data for Name: taxref_7; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--



--
-- Data for Name: tendance_pop; Type: TABLE DATA; Schema: referentiels; Owner: pg_user
--

INSERT INTO tendance_pop (id_tendance_pop, cd_tendance_pop, lib_tendance_pop) VALUES (0, '', '');
INSERT INTO tendance_pop (id_tendance_pop, cd_tendance_pop, lib_tendance_pop) VALUES (1, 'aug', 'augmentation');
INSERT INTO tendance_pop (id_tendance_pop, cd_tendance_pop, lib_tendance_pop) VALUES (2, 'dim', 'diminution');
INSERT INTO tendance_pop (id_tendance_pop, cd_tendance_pop, lib_tendance_pop) VALUES (3, 'sta', 'stable');
INSERT INTO tendance_pop (id_tendance_pop, cd_tendance_pop, lib_tendance_pop) VALUES (4, '?', 'inconnue');


--
-- Name: tendance_pop_id_tendance_pop_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: pg_user
--

SELECT pg_catalog.setval('tendance_pop_id_tendance_pop_seq', 1, false);


--
-- Data for Name: user_ref; Type: TABLE DATA; Schema: referentiels; Owner: postgres
--

INSERT INTO user_ref (idu, cd, lib) VALUES (1, 0, 'Pas d''accès');
INSERT INTO user_ref (idu, cd, lib) VALUES (2, 1, 'Lecteur');
INSERT INTO user_ref (idu, cd, lib) VALUES (3, 64, 'Participant');
INSERT INTO user_ref (idu, cd, lib) VALUES (4, 128, 'Evaluateur');
INSERT INTO user_ref (idu, cd, lib) VALUES (5, 255, 'Administrateur');
INSERT INTO user_ref (idu, cd, lib) VALUES (6, 512, 'Super Admin');


--
-- Name: user_ref_idu_seq; Type: SEQUENCE SET; Schema: referentiels; Owner: postgres
--

SELECT pg_catalog.setval('user_ref_idu_seq', 6, true);


--
-- PostgreSQL database dump complete
--

