#!/usr/bin/env bash
set -euo pipefail

SQLCMD="/opt/mssql-tools18/bin/sqlcmd"
DB_HOST="${DB_HOST:-sql}"
DB_PORT="${DB_PORT:-1433}"
DB_USER="${DB_USER:-sa}"
DB_NAME="AppBanQuanAoThoiTrangNam"
SEED_SCRIPT="/init/scriptquanao_new.sql"

if [[ ! -f "$SEED_SCRIPT" ]]; then
  echo "Seed script not found: $SEED_SCRIPT"
  exit 1
fi

if [[ ! -x "$SQLCMD" ]]; then
  echo "sqlcmd not found at $SQLCMD"
  exit 1
fi

if ! command -v iconv >/dev/null 2>&1; then
  echo "iconv is required but not found in container"
  exit 1
fi

if [[ -z "${SA_PASSWORD:-}" ]]; then
  echo "SA_PASSWORD is not set"
  exit 1
fi

echo "Waiting for SQL Server at ${DB_HOST}:${DB_PORT}..."
for i in {1..90}; do
  if "$SQLCMD" -S "${DB_HOST},${DB_PORT}" -U "$DB_USER" -P "$SA_PASSWORD" -C -Q "SELECT 1" >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

"$SQLCMD" -S "${DB_HOST},${DB_PORT}" -U "$DB_USER" -P "$SA_PASSWORD" -C -Q "IF DB_ID(N'${DB_NAME}') IS NULL CREATE DATABASE [${DB_NAME}];"

table_exists="$("$SQLCMD" -S "${DB_HOST},${DB_PORT}" -U "$DB_USER" -P "$SA_PASSWORD" -C -h -1 -W -Q "SET NOCOUNT ON; SELECT COUNT(*) FROM [${DB_NAME}].sys.tables WHERE name = N'SanPham';")"
table_exists="$(echo "$table_exists" | tr -d '\r[:space:]')"

if [[ "$table_exists" != "0" ]]; then
  echo "Database schema already exists. Skipping seed."
  exit 0
fi

# SSMS exports this file as UTF-16 LE; convert to UTF-8 for text processing tools.
iconv -f UTF-16LE -t UTF-8 "$SEED_SCRIPT" > /tmp/docker-seed.utf8.sql

start_line="$(grep -n -m1 "^USE \[${DB_NAME}\]" /tmp/docker-seed.utf8.sql | cut -d: -f1)"
if [[ -z "$start_line" ]]; then
  echo "Could not find 'USE [${DB_NAME}]' in $SEED_SCRIPT"
  exit 1
fi

tail -n +"$start_line" /tmp/docker-seed.utf8.sql > /tmp/docker-seed.sql

echo "Initializing database schema and seed data..."
"$SQLCMD" -S "${DB_HOST},${DB_PORT}" -U "$DB_USER" -P "$SA_PASSWORD" -C -d "$DB_NAME" -i /tmp/docker-seed.sql
echo "Database initialization completed."