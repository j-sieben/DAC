@echo off
setlocal

if "%~1"=="" (
  echo Usage: %~nx0 ^<user/password@service^> [install^|uninstall]
  exit /b 2
)

set "CONNECT_STRING=%~1"
set "ACTION=%~2"
if "%ACTION%"=="" set "ACTION=install"
set "INSTALL_DIR=%~dp0install_scripts\install"
set "INSTALL_SCRIPTS_DIR=%~dp0install_scripts"
set "INSTALL_SCRIPT=%INSTALL_DIR%\install.sql"

if /I "%ACTION%"=="install" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\install.sql"
) else if /I "%ACTION%"=="uninstall" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\uninstall_component.sql"
) else if /I "%ACTION%"=="drop" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\uninstall_component.sql"
) else if /I "%ACTION%"=="drop_all" (
  set "INSTALL_SCRIPT=%INSTALL_DIR%\uninstall_component.sql"
) else (
  echo Unknown action: %ACTION%
  echo Usage: %~nx0 ^<user/password@service^> [install^|uninstall]
  exit /b 2
)

for /f "tokens=1 delims=/" %%A in ("%CONNECT_STRING%") do set "UTIL_OWNER=%%A"
if "%UTIL_OWNER%"=="" set "UTIL_OWNER=DAC"
if "%UTIL_OWNER%"=="%CONNECT_STRING%" set "UTIL_OWNER=DAC"

pushd "%~dp0DAC"
(
  echo define std_dir=%INSTALL_DIR%\
  echo define root_dir=%INSTALL_SCRIPTS_DIR%\
  echo define COMPONENT=DAC
  echo define KOMPONENTE=DAC
  echo define util_owner=%UTIL_OWNER%
  echo @"%INSTALL_DIR%\defines.sql"
  echo @"%INSTALL_SCRIPT%"
  echo exit
) | sqlplus -L "%CONNECT_STRING%"
set "SQLPLUS_EXIT=%ERRORLEVEL%"
popd

exit /b %SQLPLUS_EXIT%
