WITH account_info(account_id, first_name, last_name, email) AS (
  SELECT account_id, first_name, last_name, email
  FROM car_portal_app.account
  LIMIT 1)
SELECT to_json(account_info) FROM account_info;
