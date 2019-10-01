#!/bin/bash

#  Start pgclimb command !
set -o errexit
set -o pipefail
set -o nounset

# wait for Postgres. On error, this script will exit too
source ./pgwait.sh

# For backward compatibility, allow both PG* and POSTGRES_* forms,
# with the non-standard POSTGRES_* form taking precedence.
# An error will be raised if neither form is given, except for the PGPORT
export PGHOST="${POSTGRES_HOST:-${PGHOST?}}"
export PGDATABASE="${POSTGRES_DB:-${PGDATABASE?}}"
export PGUSER="${POSTGRES_USER:-${PGUSER?}}"
export PGPASSWORD="${POSTGRES_PASSWORD:-${PGPASSWORD?}}"
export PGPORT="${POSTGRES_PORT:-${PGPORT:-5432}}"

pgclimb --password "$PGPASSWORD" \
        --host "$PGHOST" \
        --port "$PGPORT" \
        --dbname="$PGDATABASE" \
        --username="$PGUSER" \
        "$@"
