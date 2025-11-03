#!/bin/bash
set -euo pipefail

/opt/mssql/bin/sqlservr &
SQL_PID=$!

shutdown() {
  if ps -p "$SQL_PID" >/dev/null; then
    kill -SIGTERM "$SQL_PID"
    wait "$SQL_PID"
  fi
}

trap shutdown SIGINT SIGTERM

for i in {1..30}; do
  if /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; then
    break
  fi
  echo "Waiting for SQL Server to be available..."
  sleep 2
done

if ! /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; then
  echo "SQL Server did not become available in time" >&2
  exit 1
fi

if [ -f /opt/setup/script.sql ]; then
  echo "Applying database schema..."
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -i /opt/setup/script.sql
fi

wait "$SQL_PID"
