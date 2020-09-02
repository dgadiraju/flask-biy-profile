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

PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" << EOF
CREATE DATABASE sms_db;
CREATE USER sms_user WITH ENCRYPTED PASSWORD 'itversity';
GRANT ALL PRIVILEGES ON DATABASE sms_db TO sms_user;

\c sms_db

CREATE TABLE IF NOT EXISTS hw (
    i INT PRIMARY KEY,
    s VARCHAR(30)
);

INSERT INTO hw VALUES (1, 'Hello') ON CONFLICT DO NOTHING;
INSERT INTO hw VALUES (2, 'World') ON CONFLICT DO NOTHING;


GRANT ALL PRIVILEGES ON DATABASE sms_db TO sms_user;
GRANT ALL ON TABLE hw to PUBLIC;
EOF

>&2 echo "Postgres is up - executing command"
exec $cmd