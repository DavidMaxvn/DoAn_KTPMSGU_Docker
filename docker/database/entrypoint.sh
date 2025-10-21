#!/bin/bash
set -euo pipefail

SQLCMD="/opt/mssql-tools18/bin/sqlcmd"
if [[ ! -x $SQLCMD ]]; then
  SQLCMD="/opt/mssql-tools/bin/sqlcmd"
fi

/opt/mssql/bin/sqlservr &
SQLSERVER_PID=$!

# Wait for SQL Server to accept connections
for i in {1..60}; do
  if "$SQLCMD" -C -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; then
    break
  fi
  echo "Waiting for SQL Server to be available ($i/60)..."
  sleep 2
done

if ! "$SQLCMD" -C -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; then
  echo "SQL Server did not start in time" >&2
  exit 1
fi

# Initialize database only once
INIT_MARKER="/var/opt/mssql/data/.db_initialized"
if [[ ! -f "$INIT_MARKER" ]]; then
  echo "Creating database AppBanQuanAoThoiTrangNam if it does not exist..."
  "$SQLCMD" -C -S localhost -U sa -P "$SA_PASSWORD" -Q "IF DB_ID(N'AppBanQuanAoThoiTrangNam') IS NULL CREATE DATABASE [AppBanQuanAoThoiTrangNam];"

  if [[ -f /docker-entrypoint-initdb.d/init.sql ]]; then
    echo "Running seed script..."
    "$SQLCMD" -C -S localhost -U sa -P "$SA_PASSWORD" -d AppBanQuanAoThoiTrangNam -i /docker-entrypoint-initdb.d/init.sql
  fi

  touch "$INIT_MARKER"
  echo "Database initialization completed."
else
  echo "Database already initialized, skipping seed script."
fi

wait "$SQLSERVER_PID"
