-- Alternate implementation using only PERMISSIVE (rather than RESTRICTIVE)
-- policies.
DROP POLICY viewable_by_all ON albums;
DROP POLICY hide_unreleased_from_fans ON albums;
DROP POLICY hide_unreleased_from_other_artists ON albums;
CREATE POLICY viewable_by_all ON albums
    FOR SELECT
    USING (released <= now());
-- Reminder: We previously created an affect_own_albums policy on albums that
-- already allows the artist to see their own albums. We re-create that policy
-- here for reference:
DROP POLICY affect_own_albums ON albums;
CREATE POLICY affect_own_albums ON albums
    -- FOR ALL
    TO artist
    USING (artist_id = substr(current_user, 8)::int);
	