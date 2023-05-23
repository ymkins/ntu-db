-- Allow artists to create albums with a future release date, but only the
-- owning artist should be able to see these not-yet-released albums.

RESET ROLE;
-- Reminder: We previously created a viewable_by_all policy on albums that shows
-- all rows to SELECT queries issued by all roles. We re-create that policy here
-- for reference:
DROP POLICY viewable_by_all ON albums;
CREATE POLICY viewable_by_all ON albums
    FOR SELECT
    USING (true);
-- For fans: restrict visibility to albums with a release date in the past.
CREATE POLICY hide_unreleased_from_fans ON albums
    AS RESTRICTIVE
    FOR SELECT
    TO fan
    USING (released <= now());
-- For artists: restrict visibility to albums with a release date in the past,
-- unless the role issuing the query is the owning artist.
CREATE POLICY hide_unreleased_from_other_artists ON albums
    AS RESTRICTIVE
    FOR SELECT
    TO artist
    USING (released <= now() or (artist_id = substr(current_user, 8)::int));
	