#!/usr/bin/env bash
set -euo pipefail

DB_HOST="${DB_HOST:-sql}"
DB_PORT="${DB_PORT:-1433}"

echo "Waiting for SQL Server at ${DB_HOST}:${DB_PORT}..."
for i in {1..60}; do
  if (echo >/dev/tcp/${DB_HOST}/${DB_PORT}) >/dev/null 2>&1; then
    echo "SQL Server is up."
    break
  fi
  sleep 2
done

echo "Starting AppAPI..."
exec dotnet AppAPI.dll

