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

run_scripts() {
  for script in ./db_scripts/${1}/*.sh
  do
    >&2 echo "Running db script $script"
    $script ${2}
  done
}

if [ ! -f /.initialized ]; then
  echo "Initializing container"
  run_scripts "ddl" "$host"
  run_scripts "dml" "$host"
  touch /.initialized
fi

>&2 echo "Postgres is up - executing command"
exec $cmd