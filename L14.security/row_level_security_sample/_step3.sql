-- Let's create a simple RLS policy that applies to all roles and commands
-- and allows access to all rows.
RESET ROLE;
CREATE POLICY testing ON artists
    USING (true);

-- The expression "true" is true for all rows, so all rows are visible.
SET ROLE artist;
SELECT * FROM artists;
--  artist_id |          name
-- -----------+-------------------------
--          1 | Tupper Ware Remix Party
--          2 | Steely Dan
--          3 | Missy Elliott
-- (3 rows)
