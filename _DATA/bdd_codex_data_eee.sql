--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = eee, pg_catalog;

--
-- Data for Name: liste_argument; Type: TABLE DATA; Schema: eee; Owner: pg_user
--

INSERT INTO liste_argument (ida, libelle) VALUES (5, 'Argument - viabilité des graines et reproduction');
INSERT INTO liste_argument (ida, libelle) VALUES (6, 'Argument - croissance végétative');
INSERT INTO liste_argument (ida, libelle) VALUES (7, 'Argument - mode de dispersion');
INSERT INTO liste_argument (ida, libelle) VALUES (8, 'Argument - type biologique');
INSERT INTO liste_argument (ida, libelle) VALUES (11, 'Argument - taxonomie');
INSERT INTO liste_argument (ida, libelle) VALUES (12, 'Argument - habitat espèce');
INSERT INTO liste_argument (ida, libelle) VALUES (13, 'Argument - densité de la population');
INSERT INTO liste_argument (ida, libelle) VALUES (16, 'Argument - synthèse C (risques d''impact)');
INSERT INTO liste_argument (ida, libelle) VALUES (15, 'Argument - synthèse B (risques de propagation)');
INSERT INTO liste_argument (ida, libelle) VALUES (14, 'Argument - synthèse A (risques introduction et installation)');


--
-- Name: liste_argument_ida_seq; Type: SEQUENCE SET; Schema: eee; Owner: pg_user
--

SELECT pg_catalog.setval('liste_argument_ida_seq', 1, false);


--
-- Data for Name: liste_reponse; Type: TABLE DATA; Schema: eee; Owner: pg_user
--

INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (2, 'ag1', 'Correspondance climatique', 'La répartition géographique mondiale de cette espèce (naturelle ou zones d''introduction) n’inclut aucune des 4 zones climatiques françaises', 'répartition inclut aucune des 4 zones climatiques', 0, 'ag', 1);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (5, 'ag2', 'Statut de l''espèce en Europe', 'l''espèce est indigène en Europe (tout ou partie)', 'indigène en Europe ', 0, 'ag', 2);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (6, 'ag2', 'Statut de l''espèce en Europe', 'L’espèce est exotique dans toute l’Europe', 'exotique en Europe', 2, 'ag', 2);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (9, 'ag3', 'Distribution géographique en Europe', 'L’espèce est présente dans 1 pays d’Europe ou absente', '0 à 1 pays d''Europe', 1, 'ag', 3);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (10, 'ag3', 'Distribution géographique en Europe', 'L’espèce est présente dans 2 à 5 pays d’Europe', '2 à 5 pays d''Europe', 2, 'ag', 3);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (11, 'ag3', 'Distribution géographique en Europe', 'L’espèce est présente dans plus de 5 pays d’Europe', 'plus de 5 pays d''Europe', 3, 'ag', 3);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (15, 'ag4', 'Etendue de sa répartition au niveau mondial', 'La répartition mondiale de l’espèce (native et introduite) est limitée, elle est restreinte à une petite zone sur un continent.', 'répartition mondiale limitée', 0, 'ag', 4);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (19, 'bg5', 'Viabilité des graines et reproduction', 'L’espèce produit approximativement peu de graines ou des graines non viables', 'peu de graines ou non viables', 1, 'bg', 5);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (20, 'bg5', 'Viabilité des graines et reproduction', 'L’espèce produit approximativement beaucoup de  graines ', 'beaucoup de graines', 3, 'bg', 5);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (21, 'bg5', 'Viabilité des graines et reproduction', 'Pas de données', 'pas de données', 2, 'bg', 5);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (25, 'bg6', 'Croissance végétative', 'L''espèce n''a pas de croissance végétative', 'pas de croissance végétative', 0, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (26, 'bg6', 'Croissance végétative', 'Si c''est un arbre ou un arbuste, l''espèce est capable de drageonner ou de marcotter', 'drageonnage/marcotage (arb,arbt)', 2, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (27, 'bg6', 'Croissance végétative', 'L''espèce est bulbeuse ou un tubercule', 'bulbe/tubercule', 1, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (28, 'bg6', 'Croissance végétative', 'L''espèce développe des rhizomes ou des stolons', 'rhizomes/stolons', 4, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (29, 'bg6', 'Croissance végétative', 'L''espèce se fragmente facilement, et les fragments peuvent être dispersés et produire de nouvelles plantes', 'fragments', 4, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (30, 'bg6', 'Croissance végétative', 'Autre ou ne sait pas', 'autre ou ne sait pas', 2, 'bg', 6);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (37, 'bg7', 'Mode de dispersion', 'Fruits charnus d''un diamètre inférieur à 5 cm', 'petits fruits charnus (max 5cm)', 2, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (38, 'bg7', 'Mode de dispersion', 'Fruits charnus dépassant 10 cm de longueur ou de diamètre', 'gros fruits charnus (+10 cm)', 0, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (40, 'bg7', 'Mode de dispersion', 'Fruits secs et les graines ont développé des structures pour une dispersion par les animaux sur de longues distances (épines, crochets)', 'zoochorie des fruits secs et les graines', 4, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (41, 'bg7', 'Mode de dispersion', 'L''espèce assure sa propre dispersion des graines', 'dispersion propre', 1, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (42, 'bg7', 'Mode de dispersion', 'Il existe une dispersion sur de longues distances par l’eau', 'hydrochorie', 4, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (43, 'bg7', 'Mode de dispersion', 'Autre ou ne sait pas', 'Autre ou ne sait pas', 2, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (52, 'bg8', 'Type biologique', 'Grande annuelle (> 80 cm)', 'Grande annuelle', 2, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (53, 'bg8', 'Type biologique', 'Ligneuse', 'Ligneuse', 4, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (54, 'bg8', 'Type biologique', 'Petite herbacée vivace (< 80 cm)', 'Petite herbacée vivace', 2, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (55, 'bg8', 'Type biologique', 'Grande herbacée vivace (> 80 cm)', 'Grande herbacée vivace', 4, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (56, 'bg8', 'Type biologique', 'Aquatique flottante', 'Aquatique flottante', 4, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (1, 'ag1', 'Correspondance climatique', 'La répartition géographique mondiale de cette espèce (naturelle ou zones d''introduction) inclut au moins une des  4 zones climatiques françaises', 'répartition inclut au moins une des 4 zones climatiques', 2, 'ag', 1);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (16, 'ag4', 'Etendue de sa répartition au niveau mondial', 'La répartition mondiale de l’espèce (native et introduite) est étendue à plus de 15° de latitude ou de longitude sur un continent ou couvre plus d''un continent', 'répartition mondiale étendue', 3, 'ag', 4);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (39, 'bg7', 'Mode de dispersion', 'Fruits secs et les graines ont développé des structures pour une dispersion par le vent sur de longues distances (aigrettes, poils ou ailes)', 'anémochorie des fruits secs et les graines', 4, 'bg', 7);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (51, 'bg8', 'Type biologique', 'Petite annuelle (< 80 cm)', 'Petite annuelle', 0, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (57, 'bg8', 'Type biologique', 'Autre', 'Autre', 2, 'bg', 8);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (65, 'cg9', 'Mauvaise herbe agricole ailleurs', 'L''espèce est mentionnée au moins 3 fois dans le monde comme une EEE avérée ', 'mentionnée au moins 3 fois dans le monde', 3, 'cg', 9);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (66, 'cg9', 'Mauvaise herbe agricole ailleurs', 'L''espèce est mentionnée moins de 3 fois comme une EEE avérée dans le monde ', 'mentionnée moins de 3 fois dans le monde', 0, 'cg', 9);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (69, 'cg10', 'Taxonomie', 'L''espèce appartient à un genre connu comme envahissant et mentionné dans le GCW', 'genre connu comme envahissant', 3, 'cg', 10);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (70, 'cg10', 'Taxonomie', 'L''espèce n’appartient pas à un genre connu comme envahissant et mentionné dans le GCW', 'genre non connu comme envahissant', 0, 'cg', 10);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (73, 'cg11', 'Habitats de l''espèce', 'Lacs, rivières et bords de rivières ou ruisseaux', 'Lacs, rivières', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (74, 'cg11', 'Habitats de l''espèce', 'Tourbière ou marécage', 'Tourbière', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (75, 'cg11', 'Habitats de l''espèce', 'Prairies (humides ou sèches)', 'Prairies', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (76, 'cg11', 'Habitats de l''espèce', 'Forêts', 'Forêts', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (77, 'cg11', 'Habitats de l''espèce', 'Dunes côtières et plages de sable', 'Dunes, plages', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (78, 'cg11', 'Habitats de l''espèce', 'Côtes rocheuses et falaises maritimes', 'Côtes rocheuses et falaises', 3, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (79, 'cg11', 'Habitats de l''espèce', 'Autre', 'Autre', 0, 'cg', 11);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (87, 'cg12', 'Densité de population', 'L''espèce apparaît en population éparse', 'population éparse', 0, 'cg', 12);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (88, 'cg12', 'Densité de population', 'L''espèce forme occasionnellement des peuplements denses', 'occasionnellement denses', 2, 'cg', 12);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (89, 'cg12', 'Densité de population', 'L''espèce forme de grands peuplements monospécifiques', 'peuplements monospécifiques', 4, 'cg', 12);
INSERT INTO liste_reponse (idq, code_question, libelle_question, libelle_reponse, libelle_court_reponse, indicateur, code_eval, coor_ids) VALUES (90, 'cg12', 'Densité de population', 'Non documentée', 'Non documentée', 0, 'cg', 12);


--
-- Name: liste_reponse_idq_seq; Type: SEQUENCE SET; Schema: eee; Owner: pg_user
--

SELECT pg_catalog.setval('liste_reponse_idq_seq', 1, false);


--
-- Data for Name: liste_source; Type: TABLE DATA; Schema: eee; Owner: pg_user
--

INSERT INTO liste_source (ids, libelle) VALUES (4, 'Source - indigénat en France');
INSERT INTO liste_source (ids, libelle) VALUES (3, 'Source - présence en France');
INSERT INTO liste_source (ids, libelle) VALUES (6, 'Source - croissance végétative');
INSERT INTO liste_source (ids, libelle) VALUES (7, 'Source - mode de dispersion');
INSERT INTO liste_source (ids, libelle) VALUES (8, 'Source - type biologique');
INSERT INTO liste_source (ids, libelle) VALUES (10, 'Source - statut invasive avérée en France');
INSERT INTO liste_source (ids, libelle) VALUES (13, 'Source - densité de la population');
INSERT INTO liste_source (ids, libelle) VALUES (1, 'Source - présence international');
INSERT INTO liste_source (ids, libelle) VALUES (2, 'Source - indigenat international');
INSERT INTO liste_source (ids, libelle) VALUES (5, 'Source - viabilité des graines et reproduction');
INSERT INTO liste_source (ids, libelle) VALUES (9, 'Source - statut invasive avérée international');
INSERT INTO liste_source (ids, libelle) VALUES (11, 'Source - taxonomie');
INSERT INTO liste_source (ids, libelle) VALUES (12, 'Source - habitat espèce');


--
-- Name: liste_source_ids_seq; Type: SEQUENCE SET; Schema: eee; Owner: pg_user
--

SELECT pg_catalog.setval('liste_source_ids_seq', 1, false);


--
-- Data for Name: pays; Type: TABLE DATA; Schema: eee; Owner: pg_user
--

INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (1, 'Asia', 'Afghanistan', NULL, NULL, 60, 74, 29, 38);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (2, 'Africa', 'Afrique du Sud', NULL, NULL, 14, 37, -46, -22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (3, 'Europe', 'Albanie', NULL, NULL, 19, 21, 39, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (4, 'Africa', 'Algérie', NULL, NULL, -8, 11, 18, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (5, 'Europe', 'Allemagne', NULL, NULL, 5.8, 15, 47, 55);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (6, 'Europe', 'Andorre', NULL, NULL, 1.4, 1.7, 42, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (7, 'Africa', 'Angola', NULL, NULL, 11, 24, -18, -4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (8, 'North America', 'Anguilla', NULL, NULL, -63, -62, 18, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (9, 'Antarctica', 'Antarctique', NULL, NULL, -18, 180, -90, -60);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (10, 'North America', 'Antigua-et-Barbuda', NULL, NULL, -61, -61, 16, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (11, 'North America', 'Antilles Néerlandaises', NULL, NULL, -69, -68, 12, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (12, 'Asia', 'Arabie Saoudite', NULL, NULL, 34, 55, 15, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (13, 'South America', 'Argentine', NULL, NULL, -73, -53, -55, -21);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (14, 'Asia', 'Arménie', NULL, NULL, 43, 46, 38, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (15, 'North America', 'Aruba', NULL, NULL, -70, -69, 12, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (16, 'Oceania', 'Atoll Johnston', NULL, NULL, -16, -16, 16, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (17, 'Oceania', 'Australie', NULL, NULL, 112, 158, -54, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (18, 'Europe', 'Autriche', NULL, NULL, 9.5, 17, 46, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (19, 'Asia', 'Azerbaïdjan', NULL, NULL, 44, 50, 38, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (20, 'North America', 'Bahamas', NULL, NULL, -78, -72, 20, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (21, 'Asia', 'Bahreïn', NULL, NULL, 50, 50, 25, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (22, 'Asia', 'Bangladesh', NULL, NULL, 88, 92, 20, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (23, 'North America', 'Barbade', NULL, NULL, -59, -59, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (24, 'Europe', 'Bélarus', NULL, NULL, 23, 32, 51, 56);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (25, 'Europe', 'Belgique', NULL, NULL, 2.5, 6.3, 49, 51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (26, 'North America', 'Belize', NULL, NULL, -89, -87, 15, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (27, 'Africa', 'Bénin', NULL, NULL, 0.7, 3.8, 6.2, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (28, 'North America', 'Bermudes', NULL, NULL, -64, -64, 32, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (29, 'Asia', 'Bhoutan', NULL, NULL, 88, 92, 26, 28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (30, 'South America', 'Bolivie', NULL, NULL, -69, -57, -22, -9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (31, 'Europe', 'Bosnie-Herzégovine', NULL, NULL, 15, 19, 42, 45);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (32, 'Africa', 'Botswana', NULL, NULL, 19, 29, -26, -17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (33, 'South America', 'Brésil', NULL, NULL, -74, -34, -33, 5.2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (34, 'Asia', 'Brunéi Darussalam', NULL, NULL, 114, 115, 4, 5);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (35, 'Europe', 'Bulgarie', NULL, NULL, 22, 28, 41, 44);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (36, 'Africa', 'Burkina Faso', NULL, NULL, -5, 2.3, 9.3, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (37, 'Africa', 'Burundi', NULL, NULL, 28, 30, -4, -2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (38, 'Asia', 'Cambodge', NULL, NULL, 102, 107, 10, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (39, 'Africa', 'Cameroun', NULL, NULL, 8.5, 16, 1.6, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (40, 'North America', 'Canada', NULL, NULL, -14, -52, 41, 83);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (41, 'Africa', 'Cap-vert', NULL, NULL, -25, -22, 14, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (42, 'South America', 'Chili', NULL, NULL, -10, -66, -55, -17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (43, 'Asia', 'Chine', NULL, NULL, 73, 134, 18, 53);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (44, 'Asia', 'Chypre', NULL, NULL, 32, 34, 34, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (45, 'Asia', 'Cisjordanie', NULL, NULL, 34, 35, 31, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (46, 'South America', 'Colombie', NULL, NULL, -81, -66, -4, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (47, 'Africa', 'Comores', NULL, NULL, 43, 44, -12, -11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (48, 'Asia', 'Corée du Nord', NULL, NULL, 124, 130, 37, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (49, 'Asia', 'Corée du Sud', NULL, NULL, 126, 129, 33, 38);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (50, 'North America', 'Costa Rica', NULL, NULL, -85, -82, 8, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (51, 'Africa', 'Côte d''Ivoire', NULL, NULL, -8, -2, 4.3, 10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (52, 'Europe', 'Croatie', NULL, NULL, 13, 19, 42, 46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (53, 'North America', 'Cuba', NULL, NULL, -84, -74, 19, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (54, 'Europe', 'Danemark', NULL, NULL, 8, 15, 54, 57);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (55, 'Africa', 'Djibouti', NULL, NULL, 41, 43, 10, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (56, 'North America', 'Dominique', NULL, NULL, -61, -61, 15, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (57, 'Africa', 'Égypte', NULL, NULL, 24, 36, 21, 31);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (58, 'North America', 'El Salvador', NULL, NULL, -90, -87, 13, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (59, 'Asia', 'Émirats Arabes Unis', NULL, NULL, 51, 56, 22, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (60, 'South America', 'Équateur', NULL, NULL, -91, -75, -5, 1.4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (61, 'Africa', 'Érythrée', NULL, NULL, 36, 43, 12, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (62, 'Europe', 'Espagne', NULL, NULL, -18, 4.3, 27, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (63, 'Europe', 'Estonie', NULL, NULL, 21, 28, 57, 59);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (64, ' Federated States of', 'États Fédérés de Micronésie', NULL, NULL, 158, 163, 5.2, 6.9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (65, 'North America', 'États-Unis', NULL, NULL, -17, 179, 18, 71);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (66, 'Africa', 'Éthiopie', NULL, NULL, 32, 47, 3.4, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (67, 'Oceania', 'Fidji', NULL, NULL, -18, 180, -19, -16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (68, 'Europe', 'Finlande', NULL, NULL, 19, 31, 59, 70);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (69, 'Europe', 'France', NULL, NULL, -4, 9.5, 41, 51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (70, 'Africa', 'Gabon', NULL, NULL, 8.7, 14, -3, 2.3);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (71, 'Africa', 'Gambie', NULL, NULL, -16, -13, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (72, 'Asia', 'Géorgie', NULL, NULL, 40, 46, 41, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (73, 'Antarctica', 'Géorgie du Sud et les Îles Sandwich du Sud', NULL, NULL, -38, -26, -58, -53);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (74, 'Africa', 'Ghana', NULL, NULL, -3, 1.2, 4.7, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (75, 'Europe', 'Gibraltar', NULL, NULL, -5, -5, 36, 36);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (76, 'Europe', 'Grèce', NULL, NULL, 19, 28, 34, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (77, 'North America', 'Grenade', NULL, NULL, -61, -61, 11, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (78, 'North America', 'Groenland', NULL, NULL, -73, -12, 59, 83);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (79, 'North America', 'Guadeloupe', NULL, NULL, -61, -61, 15, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (80, 'Oceania', 'Guam', NULL, NULL, 144, 144, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (81, 'North America', 'Guatemala', NULL, NULL, -92, -88, 13, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (82, 'Europe', 'Guernesey', NULL, NULL, -2, -2, 49, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (83, 'Africa', 'Guinée', NULL, NULL, -15, -7, 7.1, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (84, 'Africa', 'Guinée Équatoriale', NULL, NULL, 8.4, 11, 0.9, 3.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (85, 'Africa', 'Guinée-Bissau', NULL, NULL, -16, -13, 10, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (86, 'South America', 'Guyana', NULL, NULL, -61, -56, 1.1, 8.5);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (87, 'South America', 'Guyane Française', NULL, NULL, -54, -51, 2.1, 5.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (88, 'North America', 'Haïti', NULL, NULL, -74, -71, 18, 20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (89, 'North America', 'Honduras', NULL, NULL, -89, -83, 12, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (90, 'Asia', 'Hong-Kong', NULL, NULL, 114, 114, 22, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (91, 'Europe', 'Hongrie', NULL, NULL, 16, 22, 45, 48);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (92, 'Oceania', 'Île Baker', NULL, NULL, -17, -17, 0.2, 0.2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (93, 'Antarctica', 'Île Bouvet', NULL, NULL, 3.3, 3.4, -54, -54);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (94, 'Oceania', 'Île Christmas', NULL, NULL, 105, 105, -10, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (95, 'Europe', 'Île de Man', NULL, NULL, -4, -4, 54, 54);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (96, 'Oceania', 'Île Howland', NULL, NULL, -17, -17, 0.7, 0.8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (97, 'North America', 'Île Jan Mayen', NULL, NULL, -9, -7, 70, 71);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (98, 'Oceania', 'Île Jarvis', NULL, NULL, -16, -16, 0, 0);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (99, 'Africa', 'Île Juan de Nova', NULL, NULL, 42, 42, -17, -17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (100, 'Oceania', 'Île Norfolk', NULL, NULL, 167, 167, -29, -29);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (101, 'Oceania', 'Île Pitcairn', NULL, NULL, -13, -12, -25, -24);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (102, 'Oceania', 'Île Wake', NULL, NULL, 166, 166, 19, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (103, 'South America', 'Îles (malvinas) Falkland', NULL, NULL, -61, -57, -52, -51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (104, 'Europe', 'Îles Åland', NULL, NULL, 19, 21, 59, 60);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (105, 'North America', 'Îles Caïmanes', NULL, NULL, -81, -81, 19, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (106, 'Oceania', 'Îles Cocos (Keeling)', NULL, NULL, 96, 96, -12, -12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (107, 'Oceania', 'Îles Cook', NULL, NULL, -16, -15, -21, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (108, 'Europe', 'Îles Féroé', NULL, NULL, -7, -6, 61, 62);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (109, 'Africa', 'Îles Glorieuses', NULL, NULL, 47, 47, -11, -11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (110, 'Antarctica', 'Îles Heard et Mcdonald', NULL, NULL, 73, 73, -53, -52);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (111, 'Oceania', 'Îles Mariannes du Nord', NULL, NULL, 145, 145, 14, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (112, 'Oceania', 'Îles Marshall', NULL, NULL, 162, 169, 5.6, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (113, 'Oceania', 'Îles Midway', NULL, NULL, -17, -17, 28, 28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (114, 'Oceania', 'Îles Salomon', NULL, NULL, 155, 166, -11, -6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (115, 'North America', 'Îles Turks et Caïques', NULL, NULL, -72, -71, 21, 21);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (116, 'North America', 'Îles Vierges Britanniques', NULL, NULL, -64, -64, 18, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (117, 'North America', 'Îles Vierges des États-Unis', NULL, NULL, -64, -64, 17, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (118, 'Asia', 'Inde', NULL, NULL, 68, 97, 6.7, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (119, 'Asia', 'Indonésie', NULL, NULL, 95, 141, -10, 5.9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (120, 'Asia', 'Iran', NULL, NULL, 44, 63, 25, 39);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (122, 'Europe', 'Irlande', NULL, NULL, -10, -6, 51, 55);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (123, 'Europe', 'Islande', NULL, NULL, -24, -13, 63, 66);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (124, 'Asia', 'Israël', NULL, NULL, 34, 35, 29, 33);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (125, 'Europe', 'Italie', NULL, NULL, 6.6, 18, 36, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (126, 'North America', 'Jamaïque', NULL, NULL, -78, -76, 17, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (127, 'Asia', 'Japon', NULL, NULL, 123, 145, 24, 45);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (128, 'Europe', 'Jersey', NULL, NULL, -2, -2, 49, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (129, 'Asia', 'Jordanie', NULL, NULL, 34, 39, 29, 33);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (130, 'Asia', 'Kazakhstan', NULL, NULL, 46, 87, 40, 55);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (131, 'Africa', 'Kenya', NULL, NULL, 33, 41, -4, 4.6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (132, 'Asia', 'Kirghizistan', NULL, NULL, 69, 80, 39, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (133, 'Oceania', 'Kiribati', NULL, NULL, -15, -15, 1.7, 2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (134, 'Asia', 'Koweït', NULL, NULL, 46, 48, 28, 30);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (135, 'Asia', 'Laos', NULL, NULL, 100, 107, 13, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (136, 'Africa', 'Lesotho', NULL, NULL, 27, 29, -30, -28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (137, 'Europe', 'Lettonie', NULL, NULL, 20, 28, 55, 58);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (138, 'Asia', 'Liban', NULL, NULL, 35, 36, 33, 34);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (139, 'Africa', 'Libéria', NULL, NULL, -11, -7, 4.3, 8.5);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (140, 'Africa', 'Libye', NULL, NULL, 9.3, 25, 19, 33);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (141, 'Europe', 'Liechtenstein', NULL, NULL, 9.4, 9.6, 47, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (142, 'Europe', 'Lituanie', NULL, NULL, 20, 26, 53, 56);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (143, 'Europe', 'Luxembourg', NULL, NULL, 5.7, 6.5, 49, 50);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (144, 'Asia', 'Macao', NULL, NULL, 113, 113, 22, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (145, 'Europe', 'Macédoine', NULL, NULL, 20, 23, 40, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (146, 'Africa', 'Madagascar', NULL, NULL, 43, 50, -25, -11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (147, 'Asia', 'Malaisie', NULL, NULL, 32, 35, -17, -9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (148, 'Africa', 'Malawi', NULL, NULL, 99, 119, 0.8, 7.3);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (149, 'Asia', 'Maldives', NULL, NULL, 72, 73, 0, 7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (150, 'Africa', 'Mali', NULL, NULL, -12, 4.2, 10, 25);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (151, 'Europe', 'Malte', NULL, NULL, 14, 14, 35, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (152, 'Africa', 'Maroc', NULL, NULL, -13, -1, 27, 35);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (153, 'North America', 'Martinique', NULL, NULL, -61, -60, 14, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (154, 'Africa', 'Maurice', NULL, NULL, 57, 63, -20, -19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (155, 'Africa', 'Mauritanie', NULL, NULL, -17, -4, 14, 27);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (156, 'Africa', 'Mayotte', NULL, NULL, 45, 45, -12, -12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (157, 'North America', 'Mexique', NULL, NULL, -11, -86, 14, 32);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (159, 'Europe', 'Monaco', NULL, NULL, 7.3, 7.4, 43, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (160, 'Asia', 'Mongolie', NULL, NULL, 87, 119, 41, 52);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (161, 'Europe', 'Montenegro', NULL, NULL, 18, 20, 41, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (162, 'North America', 'Montserrat', NULL, NULL, -62, -62, 16, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (163, 'Africa', 'Mozambique', NULL, NULL, 30, 40, -26, -10);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (164, 'Asia', 'Myanmar', NULL, NULL, 92, 101, 9.8, 28);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (165, 'Africa', 'Namibie', NULL, NULL, 11, 25, -28, -16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (166, 'Oceania', 'Nauru', NULL, NULL, 166, 166, 0, 0);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (167, 'Asia', 'Népal', NULL, NULL, 80, 88, 26, 30);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (168, 'North America', 'Nicaragua', NULL, NULL, -87, -83, 10, 15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (169, 'Africa', 'Niger', NULL, NULL, 0.1, 15, 11, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (170, 'Africa', 'Nigéria', NULL, NULL, 2.6, 14, 4.2, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (171, 'Oceania', 'Niué', NULL, NULL, -16, -16, -19, -18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (172, 'Europe', 'Norvège', NULL, NULL, 4.7, 31, 57, 71);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (173, 'Oceania', 'Nouvelle-Calédonie', NULL, NULL, 163, 168, -22, -20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (174, 'Oceania', 'Nouvelle-Zélande', NULL, NULL, -17, 178, -52, -34);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (175, 'Asia', 'Oman', NULL, NULL, 51, 59, 16, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (176, 'Africa', 'Ouganda', NULL, NULL, 29, 35, -1, 4.2);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (177, 'Asia', 'Ouzbékistan', NULL, NULL, 55, 73, 37, 45);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (178, 'Asia', 'Pakistan', NULL, NULL, 60, 77, 23, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (179, 'Oceania', 'Palaos', NULL, NULL, 134, 134, 7.3, 7.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (180, 'North America', 'Panama', NULL, NULL, -83, -77, 7.2, 9.6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (181, 'Oceania', 'Papouasie-Nouvelle-Guinée', NULL, NULL, 140, 155, -11, -1);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (182, 'South America', 'Paraguay', NULL, NULL, -62, -54, -27, -19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (183, 'Europe', 'Pays-Bas', NULL, NULL, 3.3, 7.2, 50, 53);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (184, 'South America', 'Pérou', NULL, NULL, -81, -68, -18, 0);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (185, 'Asia', 'Philippines', NULL, NULL, 116, 126, 5, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (186, 'Europe', 'Pologne', NULL, NULL, 14, 24, 49, 54);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (187, 'Oceania', 'Polynésie Française', NULL, NULL, -15, -13, -17, -8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (188, 'North America', 'Porto Rico', NULL, NULL, -67, -65, 17, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (189, 'Europe', 'Portugal', NULL, NULL, -31, -6, 32, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (190, 'Asia', 'Qatar', NULL, NULL, 50, 51, 24, 26);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (191, 'Africa', 'République Centrafricaine', NULL, NULL, 14, 27, 2.2, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (192, 'Africa', 'République Démocratique du Congo', NULL, NULL, 12, 31, -13, 5.3);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (193, 'North America', 'République Dominicaine', NULL, NULL, -72, -68, 17, 19);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (194, 'Africa', 'République du Congo', NULL, NULL, 11, 18, -5, 3.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (121, 'Asia', 'Irak', NULL, NULL, 38, 48, 29, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (195, 'Europe', 'République Tchèque', NULL, NULL, 12, 18, 48, 51);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (196, 'Africa', 'Réunion', NULL, NULL, 55, 55, -21, -20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (197, 'Europe', 'Roumanie', NULL, NULL, 20, 29, 43, 48);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (198, 'Europe', 'Royaume-Uni', NULL, NULL, -8, 1.7, 49, 60);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (199, 'Asie', 'Russie', NULL, NULL, -18, 180, 41, 81);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (200, 'Africa', 'Rwanda', NULL, NULL, 28, 30, -2, -1);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (201, 'Africa', 'Sahara Occidental', NULL, NULL, -17, -8, 20, 27);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (202, 'North America', 'Saint-Kitts-et-Nevis', NULL, NULL, -62, -62, 17, 17);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (203, 'Europe', 'Saint-Marin', NULL, NULL, 12, 12, 43, 43);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (204, 'North America', 'Saint-Pierre-et-Miquelon', NULL, NULL, -56, -56, 46, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (205, 'Europe', 'Saint-Siège (état de la Cité du Vatican)', NULL, NULL, 41, 41, 12, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (206, 'North America', 'Saint-Vincent-et-les Grenadines', NULL, NULL, -61, -61, 13, 13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (207, 'Africa', 'Sainte-Hélène', NULL, NULL, -5, -5, -16, -15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (208, 'North America', 'Sainte-Lucie', NULL, NULL, -61, -60, 13, 14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (209, 'Oceania', 'Samoa', NULL, NULL, -17, -17, -14, -13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (210, 'Oceania', 'Samoa Américaines', NULL, NULL, -17, -17, -14, -14);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (211, 'Africa', 'Sao Tomé-et-Principe', NULL, NULL, 6.4, 7.4, 0, 1.7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (212, 'Africa', 'Sénégal', NULL, NULL, -17, -11, 12, 16);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (213, 'Europe', 'Serbie', NULL, NULL, 18, 23, 41, 46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (214, 'Africa', 'Seychelles', NULL, NULL, 46, 55, -9, -4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (215, 'Africa', 'Sierra Leone', NULL, NULL, -13, -10, 6.9, 9.9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (216, 'Asia', 'Singapour', NULL, NULL, 103, 103, 1.2, 1.4);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (217, 'Europe', 'Slovaquie', NULL, NULL, 16, 22, 47, 49);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (218, 'Europe', 'Slovénie', NULL, NULL, 13, 16, 45, 46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (219, 'Africa', 'Somalie', NULL, NULL, 40, 51, -1, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (220, 'Africa', 'Soudan', NULL, NULL, 21, 38, 3.4, 22);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (221, 'Asia', 'Sri Lanka', NULL, NULL, 79, 81, 5.9, 9.8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (222, 'Europe', 'Suède', NULL, NULL, 11, 24, 55, 69);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (223, 'Europe', 'Suisse', NULL, NULL, 5.9, 10, 45, 47);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (224, 'South America', 'Suriname', NULL, NULL, -58, -53, 1.8, 6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (225, 'Europe', 'Svalbard', NULL, NULL, 10, 33, 74, 80);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (226, 'Africa', 'Swaziland', NULL, NULL, 30, 32, -27, -25);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (227, 'Asia', 'Syrie', NULL, NULL, 35, 42, 32, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (228, 'Asia', 'Tadjikistan', NULL, NULL, 67, 75, 36, 41);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (229, 'Asia', 'Taïwan', NULL, NULL, 118, 122, 21, 25);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (231, 'Africa', 'Tchad', NULL, NULL, 13, 24, 7.4, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (232, 'Antarctica', 'Terres Australes Françaises', NULL, NULL, 51, 70, -49, -46);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (233, 'Africa', 'Territoire Britannique de l''Océan Indien', NULL, NULL, 72, 72, -7, -7);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (234, 'Asia', 'Territoire Palestinien Occupé', NULL, NULL, 34, 34, 31, 31);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (235, 'Asia', 'Thaïlande', NULL, NULL, 97, 105, 5.6, 20);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (236, 'Oceania', 'Timor-Leste', NULL, NULL, -9, -8, 123, 127);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (237, 'Africa', 'Togo', NULL, NULL, 0, 1.7, 6.1, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (238, 'Oceania', 'Tokelau', NULL, NULL, -17, -17, -9, -9);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (239, 'Oceania', 'Tonga', NULL, NULL, -17, -17, -21, -18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (240, 'North America', 'Trinité-et-Tobago', NULL, NULL, -61, -60, 10, 11);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (241, 'Africa', 'Tunisie', NULL, NULL, 7.4, 11, 30, 37);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (242, 'Asia', 'Turkménistan', NULL, NULL, 52, 66, 35, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (243, 'Asia', 'Turquie', NULL, NULL, 25, 44, 35, 42);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (244, 'Oceania', 'Tuvalu', NULL, NULL, 176, 179, -8, -6);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (245, 'Europe', 'Ukraine', NULL, NULL, 22, 40, 44, 52);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (246, 'South America', 'Uruguay', NULL, NULL, -58, -53, -34, -30);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (247, 'Oceania', 'Vanuatu', NULL, NULL, 166, 169, -20, -13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (248, 'South America', 'Venezuela', NULL, NULL, -73, -59, 0.6, 12);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (250, 'Oceania', 'Wallis et Futuna', NULL, NULL, -17, -17, -14, -13);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (251, 'Asia', 'Yémen', NULL, NULL, 42, 54, 12, 18);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (252, 'Africa', 'Zambie', NULL, NULL, 21, 33, -18, -8);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (253, 'Africa', 'Zimbabwe', NULL, NULL, 25, 33, -22, -15);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (158, 'Europe', 'Moldavie', NULL, NULL, 26, 30, 45, 48);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (249, 'Asia', 'Vietnam', NULL, NULL, 102, 109, 8.5, 23);
INSERT INTO pays (idp, continent, pays, zone, region_biogeo, x_min, x_max, y_min, y_max) VALUES (230, 'Africa', 'Tanzanie', NULL, NULL, 29, 40, -11, 0);


--
-- Name: pays_idp_seq; Type: SEQUENCE SET; Schema: eee; Owner: pg_user
--

SELECT pg_catalog.setval('pays_idp_seq', 1, false);


--
-- Data for Name: region; Type: TABLE DATA; Schema: eee; Owner: pg_user
--

INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (1, 42, NULL, 'Alsace', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (2, 72, NULL, 'Aquitaine', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (3, 83, NULL, 'Auvergne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (4, 25, NULL, 'Basse-Normandie', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (5, 26, NULL, 'Bourgogne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (6, 53, NULL, 'Bretagne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (7, 24, NULL, 'Centre', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (8, 21, NULL, 'Champagne-Ardenne', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (9, 94, NULL, 'Corse', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (10, 43, NULL, 'Franche-Comté', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (11, 1, NULL, 'Guadeloupe', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (12, 3, NULL, 'Guyane', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (13, 23, NULL, 'Haute-Normandie', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (14, 11, NULL, 'Île-de-France', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (15, 4, NULL, 'La Réunion', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (16, 91, NULL, 'Languedoc-Roussillon', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (17, 74, NULL, 'Limousin', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (18, 41, NULL, 'Lorraine', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (19, 2, NULL, 'Martinique', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (20, 6, NULL, 'Mayotte', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (21, 73, NULL, 'Midi-Pyrénées', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (22, 31, NULL, 'Nord-Pas-de-Calais', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (23, 52, NULL, 'Pays de la Loire', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (24, 22, NULL, 'Picardie', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (25, 54, NULL, 'Poitou-Charentes', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (26, 93, NULL, 'Provence-Alpes-Côte d''Azur', NULL);
INSERT INTO region (idr, insee_reg, cbn, region, region_biogeo) VALUES (27, 82, NULL, 'Rhône-Alpes', NULL);


--
-- PostgreSQL database dump complete
--

