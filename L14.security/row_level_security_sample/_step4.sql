-- Let's change the policy to use an expression that depends 
-- on a value in the row.
RESET ROLE;
ALTER POLICY testing ON artists
    USING (name = 'Steely Dan');

-- Now, we see that only 1 row passes the policy's test.
SET ROLE artist;
SELECT * FROM artists;
--  artist_id |    name
-- -----------+------------
--          2 | Steely Dan
-- (1 row)
