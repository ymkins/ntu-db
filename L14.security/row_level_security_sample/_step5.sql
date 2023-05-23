RESET ROLE;
-- Create a login/role for a specific artist. We'll design the role name to be
-- "artist:N" where N is the artist_id. So, "artist:1" will be the account for
-- Tupper Ware Remix Party.
-- NOTE: We have to quote the role name because it contains a colon.
CREATE ROLE "artist:1" LOGIN;
GRANT artist TO "artist:1";

-- Let's make all artists visible to all users again
DROP POLICY testing ON artists;
CREATE POLICY viewable_by_all ON artists
    FOR SELECT
    USING (true);

-- We create an RLS policy specific to the "artist" role/group and the UPDATE
-- command. The policy makes rows from the "artists" table available if the
-- row's artist_id matches the number in the current user's name (i.e.
-- a db role name of "artist:1" makes the row with artist_id=1 available).
CREATE POLICY update_self ON artists
    FOR UPDATE
    TO artist
    USING (artist_id = substr(current_user, 8)::int);

SET ROLE "artist:1";
-- Even though we try to update the name for all artists in the table, the RLS
-- policy limits our update to only the row we "own" (i.e. that has an artist_id
-- matching our db role name).
UPDATE artists SET name = 'TWRP';
-- UPDATE 1
SELECT * FROM artists;
--  artist_id |     name
-- -----------+---------------
--          2 | Steely Dan
--          3 | Missy Elliott
--          1 | TWRP
-- (3 rows)