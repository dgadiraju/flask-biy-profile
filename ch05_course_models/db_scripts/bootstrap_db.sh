#!/bin/sh
# bootstrap_db.sh

set -e

host="$1"
shift
cmd="$@"

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

./db_scripts/01_create_db.sh "$host"
./db_scripts/02_create_tables.sh "$host"
./db_scripts/03_insert_courses.sh "$host"

>&2 echo "Postgres is up - executing command"
exec $cmd