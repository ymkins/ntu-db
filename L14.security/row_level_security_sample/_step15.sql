SET ROLE "artist:2";
SELECT * FROM albums;
--  album_id | artist_id |       title        |  released
-- ----------+-----------+--------------------+------------
--         1 |         3 | Under Construction | 2002-11-12
--         2 |         1 | Return to Wherever | 2019-07-11
-- (2 rows)

SELECT * FROM songs;
--  song_id | album_id |      title
-- ---------+----------+------------------
--        1 |        2 | Hidden Potential
-- (1 row)
