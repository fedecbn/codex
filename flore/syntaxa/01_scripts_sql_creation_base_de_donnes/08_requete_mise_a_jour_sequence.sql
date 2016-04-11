SELECT MAX(uid) FROM refnat.taxons;
SELECT nextval('refnat.taxons_uid_seq');
SELECT setval('refnat.taxons_uid_seq', COALESCE((SELECT MAX(uid)+1 FROM refnat.taxons), 1), false);

