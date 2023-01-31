SELECT to_json(row(account_id, first_name, last_name, email))
  FROM car_portal_app.account
  LIMIT 1;
