-- Insert an album (album_id=4) with a future release date

INSERT INTO albums (artist_id, title, released)
    VALUES (1, 'Future Album', '2050-01-01');
	
INSERT INTO songs (album_id, title)
    VALUES (4, 'Future Song 1');
	
SELECT * FROM albums;
SELECT * FROM songs;