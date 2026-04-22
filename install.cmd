@echo off
setlocal

if "%~1"=="" (
  echo Usage: %~nx0 ^<user/password@service^> [install.sql^|reinstall.sql^|drop_all.sql]
  exit /b 2
)

set "CONNECT_STRING=%~1"
set "INSTALL_SCRIPT=%~2"
if "%INSTALL_SCRIPT%"=="" set "INSTALL_SCRIPT=install.sql"

pushd "%~dp0DAC"
sqlplus -L "%CONNECT_STRING%" @"%INSTALL_SCRIPT%"
set "SQLPLUS_EXIT=%ERRORLEVEL%"
popd

exit /b %SQLPLUS_EXIT%
