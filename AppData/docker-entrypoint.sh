#!/bin/bash
set -euo pipefail

if [ -z "${ConnectionStrings__DBContext:-}" ]; then
    echo "ConnectionStrings__DBContext environment variable is required." >&2
    exit 1
fi

max_attempts=${MIGRATION_MAX_RETRIES:-20}
delay_seconds=${MIGRATION_RETRY_DELAY:-5}

if [ "$#" -eq 0 ]; then
    set -- database update --project AppData/AppData.csproj --startup-project AppAPI/AppAPI.csproj
fi

cmd=(dotnet ef "$@")
for ((attempt = 1; attempt <= max_attempts; attempt++)); do
    if "${cmd[@]}"; then
        echo "Command '${cmd[*]}' completed successfully."
        exit 0
    fi

    if (( attempt == max_attempts )); then
        echo "Command '${cmd[*]}' failed after $attempt attempts." >&2
        exit 1
    fi

    echo "Command '${cmd[*]}' failed (attempt $attempt); retrying in ${delay_seconds}s..."
    sleep "$delay_seconds"
done
