#!/bin/bash
set -euo pipefail

/opt/mssql/bin/sqlservr &
SQL_PID=$!

function shutdown() {
    echo "Stopping SQL Server..."
    if kill -0 "$SQL_PID" >/dev/null 2>&1; then
        kill "$SQL_PID"
        wait "$SQL_PID"
    fi
    exit 0
}

trap shutdown SIGINT SIGTERM

# Wait for SQL Server to accept connections
for i in {1..60}; do
    if /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; then
        break
    fi
    echo "Waiting for SQL Server to start ($i/60)..."
    sleep 1
    if [ "$i" -eq 60 ]; then
        echo "SQL Server did not start in time" >&2
        exit 1
    fi
done

echo "Ensuring database AppBanQuanAoThoiTrangNam exists..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "IF DB_ID('AppBanQuanAoThoiTrangNam') IS NULL CREATE DATABASE [AppBanQuanAoThoiTrangNam];"

seed_marker=/var/opt/mssql/.db-seeded
if [ -f /usr/config/init.sql ] && [ ! -f "$seed_marker" ]; then
    echo "Seeding database from init.sql..."
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d AppBanQuanAoThoiTrangNam -i /usr/config/init.sql
    touch "$seed_marker"
elif [ -f "$seed_marker" ]; then
    echo "Seed data already applied; skipping init script."
fi

echo "SQL Server is ready."
wait "$SQL_PID"
