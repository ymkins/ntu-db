RESET ROLE;
-- Enable RLS on albums and songs, and make them viewable by everyone.
ALTER TABLE albums ENABLE ROW LEVEL SECURITY;
ALTER TABLE songs ENABLE ROW LEVEL SECURITY;
CREATE POLICY viewable_by_all ON albums
    FOR SELECT
    USING (true);
CREATE POLICY viewable_by_all ON songs
    FOR SELECT
    USING (true);

-- Limit create/edit/delete of albums to the "owning" artist.
CREATE POLICY affect_own_albums ON albums
    FOR ALL
    TO artist
    USING (artist_id = substr(current_user, 8)::int);
-- Limit create/edit/delete of songs to the "owning" artist of the album.
CREATE POLICY affect_own_songs ON songs
    FOR ALL
    TO artist
    USING (
        -- Alternative:
        -- (SELECT artist_id FROM albums WHERE songs.album_id = album_id
        -- ) = substr(current_user, 8)::int
        --
        -- Alternative:
        -- (SELECT artist_id = substr(current_user, 8)::int
        -- FROM albums WHERE albums.album_id = songs.album_id)
        --
        --
        EXISTS (
            SELECT 1 FROM albums
            WHERE albums.album_id = songs.album_id
            AND albums.artist_id = substr(current_user, 8)::int
        )
    );

-- Add a Missy Elliott (artist_id=3) album (album_id=1) for testing below
INSERT INTO albums (artist_id, title, released)
    VALUES (3, 'Under Construction', '2002-11-12');

SELECT * FROM artists;
