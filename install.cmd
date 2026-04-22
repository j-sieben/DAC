@echo off
setlocal

if "%~1"=="" (
  echo Usage: %~nx0 ^<user/password@service^> [install^|install_tests^|uninstall]
  exit /b 2
)

set "CONNECT_STRING=%~1"
set "ACTION=%~2"
if "%ACTION%"=="" set "ACTION=install"
set "UNIT_TEST_DIR=%~dp0unit_tests"
set "INSTALL_DIR=%~dp0install_scripts\install"
set "INSTALL_SCRIPTS_DIR=%~dp0install_scripts"
set "INSTALL_SCRIPT=%INSTALL_DIR%\install.sql"
set "PRE_INSTALL_SCRIPT="

if /I "%ACTION%"=="install" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\install.sql"
) else if /I "%ACTION%"=="install_tests" (
  set "INSTALL_SCRIPT=%UNIT_TEST_DIR%\install_tests.sql"
) else if /I "%ACTION%"=="tests" (
  set "INSTALL_SCRIPT=%UNIT_TEST_DIR%\install_tests.sql"
) else if /I "%ACTION%"=="test" (
  set "INSTALL_SCRIPT=%UNIT_TEST_DIR%\install_tests.sql"
) else if /I "%ACTION%"=="uninstall" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\uninstall_component.sql"
  set "PRE_INSTALL_SCRIPT=@^&pre_dir.drop_all.sql"
) else if /I "%ACTION%"=="drop" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\uninstall_component.sql"
  set "PRE_INSTALL_SCRIPT=@^&pre_dir.drop_all.sql"
) else if /I "%ACTION%"=="drop_all" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\uninstall_component.sql"
  set "PRE_INSTALL_SCRIPT=@^&pre_dir.drop_all.sql"
) else (
  echo Unknown action: %ACTION%
  echo Usage: %~nx0 ^<user/password@service^> [install^|install_tests^|uninstall]
  exit /b 2
)

for /f "tokens=1 delims=/" %%A in ("%CONNECT_STRING%") do set "UTIL_OWNER=%%A"
if "%UTIL_OWNER%"=="" set "UTIL_OWNER=DAC"
if "%UTIL_OWNER%"=="%CONNECT_STRING%" set "UTIL_OWNER=DAC"

pushd "%~dp0DAC"
(
  echo set define on
  echo set verify off
  echo set serveroutput on size 1000000
  echo set echo off
  echo set feedback off
  echo set lines 120
  echo set pages 9999
  echo set heading off
  echo set headsep off
  echo set termout off
  echo whenever sqlerror exit 90 rollback
  echo whenever oserror exit 11 rollback
  echo define std_dir=%INSTALL_DIR%\
  echo define root_dir=%INSTALL_SCRIPTS_DIR%\
  echo define unit_test_dir=%UNIT_TEST_DIR%\
  echo define unit_test_pack_dir=%UNIT_TEST_DIR%\Packages\
  echo define unit_test_scripts_dir=%UNIT_TEST_DIR%\Scripts\
  echo define COMPONENT=DAC
  echo define KOMPONENTE=DAC
  echo define util_owner=%UTIL_OWNER%
  echo @"%INSTALL_DIR%\defines.sql"
  echo column install_user new_value install_user noprint
  echo column has_spool new_value has_spool noprint
  echo select user install_user from dual;
  echo select case count^(^*^) when 0 then 'false' else 'true' end has_spool
  echo   from all_objects
  echo  where object_type = 'PACKAGE BODY'
  echo    and object_name = 'SPOOL_PKG';
  echo alter session set plsql_ccflags = 'HAS_SPOOL:^&HAS_SPOOL.';
  echo set termout on
  if defined PRE_INSTALL_SCRIPT echo %PRE_INSTALL_SCRIPT%
  echo @"%INSTALL_SCRIPT%"
  echo exit
) | sqlplus -S -L "%CONNECT_STRING%"
set "SQLPLUS_EXIT=%ERRORLEVEL%"
popd

exit /b %SQLPLUS_EXIT%
