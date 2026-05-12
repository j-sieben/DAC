#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <user/password@service> [install|install_tests|uninstall]"
  exit 2
fi

CONNECT_STRING="$1"
ACTION="${2:-install}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPONENT_DIR="$SCRIPT_DIR/DAC"
INSTALL_SCRIPT="$COMPONENT_DIR/install.sql"

case "$ACTION" in
  install)
    INSTALL_SCRIPT="$COMPONENT_DIR/install.sql"
    ;;
  install_tests|tests|test)
    INSTALL_SCRIPT="$COMPONENT_DIR/install_tests.sql"
    ;;
  uninstall|drop|drop_all)
    INSTALL_SCRIPT="$COMPONENT_DIR/uninstall.sql"
    ;;
  *)
    echo "Unknown action: $ACTION"
    echo "Usage: $0 <user/password@service> [install|install_tests|uninstall]"
    exit 2
    ;;
esac

cd "$COMPONENT_DIR"
sqlplus -S -L "$CONNECT_STRING" @"$INSTALL_SCRIPT"
