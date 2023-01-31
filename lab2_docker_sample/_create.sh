#!/bin/bash
docker run \
  --name=postgres \
  --rm \
  --volume=$(pwd)/schema.sql:/docker-entrypoint-initdb.d/schema.sql \
  --volume=$(pwd):/repo \
  --env=PSQLRC=/repo/.psqlrc \
  --env=POSTGRES_PASSWORD=foo \
  postgres:latest -c log_statement=all
