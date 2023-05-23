-- Switch to the postgres superuser to enable RLS on the artists table
RESET ROLE;
ALTER TABLE artists ENABLE ROW LEVEL SECURITY;

-- Now we don't see any rows! RLS hides all rows if no policies are 
-- declared on the table.
SET ROLE artist;
SELECT * FROM artists;
--  artist_id | name
-- -----------+------
-- (0 rows)
