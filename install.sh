#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <user/password@service> [install|uninstall]"
  exit 2
fi

CONNECT_STRING="$1"
ACTION="${2:-install}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPONENT_DIR="$SCRIPT_DIR/DAC"
INSTALL_DIR="$SCRIPT_DIR/install_scripts/install"
INSTALL_SCRIPTS_DIR="$SCRIPT_DIR/install_scripts"
INSTALL_SCRIPT="$INSTALL_DIR/install.sql"

case "$ACTION" in
  install)
    INSTALL_SCRIPT="$INSTALL_DIR/install.sql"
    ;;
  uninstall|drop|drop_all)
    INSTALL_SCRIPT="$INSTALL_DIR/uninstall_component.sql"
    ;;
  *)
    echo "Unknown action: $ACTION"
    echo "Usage: $0 <user/password@service> [install|uninstall]"
    exit 2
    ;;
esac

UTIL_OWNER="${CONNECT_STRING%%/*}"
if [ "$UTIL_OWNER" = "$CONNECT_STRING" ] || [ -z "$UTIL_OWNER" ]; then
  UTIL_OWNER="DAC"
fi

cd "$COMPONENT_DIR"
sqlplus -L "$CONNECT_STRING" <<SQL
define std_dir=$INSTALL_DIR/
define root_dir=$INSTALL_SCRIPTS_DIR/
define COMPONENT=DAC
define KOMPONENTE=DAC
define util_owner=$UTIL_OWNER
@"$INSTALL_DIR/defines.sql"
@"$INSTALL_SCRIPT"
exit
SQL
