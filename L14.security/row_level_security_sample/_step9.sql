-- Trying to add an album to another artist fails the RLS policy
INSERT INTO albums (artist_id, title, released)
    VALUES (2, 'Pretzel Logic', '1974-02-20');
-- ERROR:  42501: new row violates row-level security policy for table "albums"
-- LOCATION:  ExecWithCheckOptions, execMain.c:2058

-- Trying to add a song to Missy Elliott's album fails the RLS policy
INSERT INTO songs (album_id, title)
    VALUES (1, 'Work It');
-- ERROR:  42501: new row violates row-level security policy for table "songs"
-- LOCATION:  ExecWithCheckOptions, execMain.c:2058
