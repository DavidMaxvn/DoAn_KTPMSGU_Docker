#!/usr/bin/env bash
# Helper script to build and start the full stack with Docker Compose.
# Usage: ./run-docker-compose.sh
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
docker compose up --build
