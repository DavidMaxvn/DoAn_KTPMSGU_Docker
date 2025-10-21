#!/bin/bash
set -euo pipefail

# Allow optional custom command execution
if [[ $# -gt 0 ]]; then
  exec "$@"
fi

cd /src

max_attempts=${MIGRATION_MAX_RETRIES:-12}
delay_seconds=${MIGRATION_RETRY_DELAY:-5}

for attempt in $(seq 1 "$max_attempts"); do
  echo "Applying Entity Framework Core migrations (attempt ${attempt}/${max_attempts})..."
  if dotnet ef database update --project AppData/AppData.csproj --startup-project AppAPI/AppAPI.csproj; then
    echo "Database migrations applied successfully."
    exit 0
  fi

  echo "Migrations failed. Waiting ${delay_seconds}s before retrying..."
  sleep "$delay_seconds"
done

echo "ERROR: Unable to apply database migrations after ${max_attempts} attempts." >&2
exit 1
