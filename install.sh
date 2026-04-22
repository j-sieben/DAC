#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <user/password@service> [install.sql|reinstall.sql|drop_all.sql]"
  exit 2
fi

CONNECT_STRING="$1"
INSTALL_SCRIPT="${2:-install.sql}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPONENT_DIR="$SCRIPT_DIR/DAC"

cd "$COMPONENT_DIR"
sqlplus -L "$CONNECT_STRING" @"$INSTALL_SCRIPT"
