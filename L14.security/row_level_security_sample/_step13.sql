-- Test that the owning artist can see future albums and songs, but other
-- artists and fans cannot see them.
SET ROLE "artist:1";
SELECT * FROM albums;
--  album_id | artist_id |       title        |  released
-- ----------+-----------+--------------------+------------
--         1 |         3 | Under Construction | 2002-11-12
--         2 |         1 | Return to Wherever | 2019-07-11
--         4 |         1 | Secret Project     | 2050-01-01
-- (3 rows)

SELECT * FROM songs;
--  song_id | album_id |      title
-- ---------+----------+------------------
--        1 |        2 | Hidden Potential
--        4 |        4 | Untitled Song 1
-- (2 rows)
