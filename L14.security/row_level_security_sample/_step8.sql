-- Change to the user account corresponding to the artist TWRP (artist_id=1)
SET ROLE "artist:1";
-- Add an album (album_id=2) and a song to that album
INSERT INTO albums (artist_id, title, released)
    VALUES (1, 'Return to Wherever', '2019-07-11');
INSERT INTO songs (album_id, title)
    VALUES (2, 'Hidden Potential');
	
SELECT * FROM albums;
SELECT * FROM songs;