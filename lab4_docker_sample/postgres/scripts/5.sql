SELECT memcache_add('/'||account_id, (
  SELECT to_json(foo)
    FROM (
      SELECT account_id, first_name, last_name, email) AS FOO)::text)
  FROM car_portal_app.account;
