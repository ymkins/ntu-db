GRANT SELECT ON artists TO artist;
GRANT SELECT, DELETE ON fans TO fan;
GRANT SELECT, INSERT, DELETE ON fan_follows TO fan;
GRANT SELECT ON artists TO fan;
GRANT SELECT ON albums TO fan;
GRANT SELECT, UPDATE (name), DELETE ON artists TO artist;
GRANT SELECT, INSERT, UPDATE (title, released), DELETE ON albums TO artist;
