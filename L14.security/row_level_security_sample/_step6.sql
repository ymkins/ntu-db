-- Trying to update a row that no policy gives us access to simply results
-- in no rows updating.
UPDATE artists SET name = 'Ella Fitzgerald' WHERE name = 'Steely Dan';
-- UPDATE 0