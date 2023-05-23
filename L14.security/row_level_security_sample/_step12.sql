-- To control visibility of songs, we simply query for the corresponding album
-- and the RLS policy on the albums table will determine if we can see the
-- album. If we see the album, we'll see the songs.
DROP POLICY viewable_by_all ON songs;
CREATE POLICY viewable_by_all ON songs
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM albums
            WHERE albums.album_id = songs.album_id
        )
    );
	