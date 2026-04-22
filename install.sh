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
UNIT_TEST_DIR="$SCRIPT_DIR/unit_tests"
INSTALL_DIR="$SCRIPT_DIR/install_scripts/install"
INSTALL_SCRIPTS_DIR="$SCRIPT_DIR/install_scripts"
INSTALL_SCRIPT="$INSTALL_DIR/install.sql"
PRE_INSTALL_SCRIPT=""

case "$ACTION" in
  install)
    INSTALL_SCRIPT="$INSTALL_DIR/install.sql"
    ;;
  install_tests|tests|test)
    INSTALL_SCRIPT="$UNIT_TEST_DIR/install_tests.sql"
    ;;
  uninstall|drop|drop_all)
    INSTALL_SCRIPT="$INSTALL_DIR/uninstall_component.sql"
    PRE_INSTALL_SCRIPT='@&pre_dir.drop_all.sql'
    ;;
  *)
    echo "Unknown action: $ACTION"
    echo "Usage: $0 <user/password@service> [install|install_tests|uninstall]"
    exit 2
    ;;
esac

UTIL_OWNER="${CONNECT_STRING%%/*}"
if [ "$UTIL_OWNER" = "$CONNECT_STRING" ] || [ -z "$UTIL_OWNER" ]; then
  UTIL_OWNER="DAC"
fi

cd "$COMPONENT_DIR"
sqlplus -S -L "$CONNECT_STRING" <<SQL
set define on
set verify off
set serveroutput on size 1000000
set echo off
set feedback off
set lines 120
set pages 9999
set heading off
set headsep off
set termout off
whenever sqlerror exit 90 rollback
whenever oserror exit 11 rollback
define std_dir=$INSTALL_DIR/
define root_dir=$INSTALL_SCRIPTS_DIR/
define unit_test_dir=$UNIT_TEST_DIR/
define unit_test_pack_dir=$UNIT_TEST_DIR/Packages/
define unit_test_scripts_dir=$UNIT_TEST_DIR/Scripts/
define COMPONENT=DAC
define KOMPONENTE=DAC
define util_owner=$UTIL_OWNER
@"$INSTALL_DIR/defines.sql"
column install_user new_value install_user noprint
column has_spool new_value has_spool noprint
select user install_user from dual;
select case count(*) when 0 then 'false' else 'true' end has_spool
  from all_objects
 where object_type = 'PACKAGE BODY'
   and object_name = 'SPOOL_PKG';
alter session set plsql_ccflags = 'HAS_SPOOL:&HAS_SPOOL.';
set termout on
$PRE_INSTALL_SCRIPT
@"$INSTALL_SCRIPT"
exit
SQL
