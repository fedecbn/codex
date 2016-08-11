--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = lsi, pg_catalog;

--
-- Data for Name: subject; Type: TABLE DATA; Schema: lsi; Owner: postgres
--

INSERT INTO subject (id_subject, libelle_subject) VALUES (3, 'Des coups de pouce');
INSERT INTO subject (id_subject, libelle_subject) VALUES (4, 'Des données et des cartes');
INSERT INTO subject (id_subject, libelle_subject) VALUES (2, 'Des technologies, logiciels et matériels');
INSERT INTO subject (id_subject, libelle_subject) VALUES (5, 'Des évènements et formations');
INSERT INTO subject (id_subject, libelle_subject) VALUES (1, 'Les actus du réseau');


--
-- Name: subject_id_subject_seq; Type: SEQUENCE SET; Schema: lsi; Owner: postgres
--

SELECT pg_catalog.setval('subject_id_subject_seq', 5, true);


--
-- Data for Name: tag; Type: TABLE DATA; Schema: lsi; Owner: postgres
--

INSERT INTO tag (id_tag, libelle_tag) VALUES (1, 'QGIS');
INSERT INTO tag (id_tag, libelle_tag) VALUES (2, 'Postgresql');
INSERT INTO tag (id_tag, libelle_tag) VALUES (3, 'CBN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (4, 'FCBN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (13, 'Biodiversité');
INSERT INTO tag (id_tag, libelle_tag) VALUES (14, 'Flore');
INSERT INTO tag (id_tag, libelle_tag) VALUES (16, 'Outil naturaliste');
INSERT INTO tag (id_tag, libelle_tag) VALUES (20, 'OSM');
INSERT INTO tag (id_tag, libelle_tag) VALUES (24, 'GeoJSON');
INSERT INTO tag (id_tag, libelle_tag) VALUES (25, 'Web');
INSERT INTO tag (id_tag, libelle_tag) VALUES (26, 'Drone');
INSERT INTO tag (id_tag, libelle_tag) VALUES (27, 'GBIF');
INSERT INTO tag (id_tag, libelle_tag) VALUES (28, 'GPS');
INSERT INTO tag (id_tag, libelle_tag) VALUES (29, 'Nomade');
INSERT INTO tag (id_tag, libelle_tag) VALUES (30, 'Webmapping');
INSERT INTO tag (id_tag, libelle_tag) VALUES (31, 'SIG');
INSERT INTO tag (id_tag, libelle_tag) VALUES (32, 'JavaScript');
INSERT INTO tag (id_tag, libelle_tag) VALUES (33, 'R');
INSERT INTO tag (id_tag, libelle_tag) VALUES (34, 'OpenLayer');
INSERT INTO tag (id_tag, libelle_tag) VALUES (35, 'Open Data');
INSERT INTO tag (id_tag, libelle_tag) VALUES (36, 'MNHN/SPN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (37, 'Standard');
INSERT INTO tag (id_tag, libelle_tag) VALUES (38, 'IGN');
INSERT INTO tag (id_tag, libelle_tag) VALUES (39, '3D');
INSERT INTO tag (id_tag, libelle_tag) VALUES (40, 'Postgis');
INSERT INTO tag (id_tag, libelle_tag) VALUES (41, 'BRGM');
INSERT INTO tag (id_tag, libelle_tag) VALUES (42, 'SI');
INSERT INTO tag (id_tag, libelle_tag) VALUES (43, 'ONEMA');
INSERT INTO tag (id_tag, libelle_tag) VALUES (45, 'BigData');
INSERT INTO tag (id_tag, libelle_tag) VALUES (46, 'SINP');
INSERT INTO tag (id_tag, libelle_tag) VALUES (47, 'Lidar');
INSERT INTO tag (id_tag, libelle_tag) VALUES (48, 'Rasberry-pi');
INSERT INTO tag (id_tag, libelle_tag) VALUES (50, 'Phytosociologie');
INSERT INTO tag (id_tag, libelle_tag) VALUES (51, 'Base de données');
INSERT INTO tag (id_tag, libelle_tag) VALUES (52, 'INSPIRE');
INSERT INTO tag (id_tag, libelle_tag) VALUES (53, 'Climat');
INSERT INTO tag (id_tag, libelle_tag) VALUES (54, 'OGC');
INSERT INTO tag (id_tag, libelle_tag) VALUES (55, 'Dev');
INSERT INTO tag (id_tag, libelle_tag) VALUES (56, 'Cartographie');
INSERT INTO tag (id_tag, libelle_tag) VALUES (57, 'Sécurité');
INSERT INTO tag (id_tag, libelle_tag) VALUES (58, 'Télédétection');
INSERT INTO tag (id_tag, libelle_tag) VALUES (59, 'Open Source');
INSERT INTO tag (id_tag, libelle_tag) VALUES (49, 'Google');
INSERT INTO tag (id_tag, libelle_tag) VALUES (44, 'Crowdsourcing');
INSERT INTO tag (id_tag, libelle_tag) VALUES (60, 'Git');
INSERT INTO tag (id_tag, libelle_tag) VALUES (61, 'Git');


--
-- Name: tag_id_tag_seq; Type: SEQUENCE SET; Schema: lsi; Owner: postgres
--

SELECT pg_catalog.setval('tag_id_tag_seq', 61, true);


--
-- PostgreSQL database dump complete
--

