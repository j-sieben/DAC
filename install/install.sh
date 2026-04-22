#!/bin/bash
##############################################################
# Skriptname: install.sh 
# Aufruf    : ./install.sh
#
#
##############################################################

##############################################################
# Zentrale Fehlerbehandlung fuer fehlerhaften Ablauf
##############################################################
fehlerexit ()
{
echo "========================================================================="
echo "Error during installation of component $COMPONENT"
echo "========================================================================="
DATUM=`date +%d.%m.%y-%H:%M:%S`
echo "$DATUM"
exit
}

DIRNAME=`basename ${PWD}`

. ./get_connect_info.sh

export ROOT_DIR="${PWD}/"
export STD_DIR="${PWD}/../install_scripts/install/"
export KOMPONENTE="B3M"
export NLS_LANG=GERMAN_GERMANY.AL32UTF8

##############################################################
# Ausgaben nur ins Log-File
##############################################################
LOGPATH=$(dirname "$0")
LOGFILE="Install_$COMPONENT.log"

echo "start_install.sh - Komponente $COMPONENT "
##############################################################

##############################################################
# Beginn ausgeben...
##############################################################
echo "start_install.sh - Beginn der Installation der Komponente $COMPONENT "$1""

INSTALL_SCRIPT="$STD_DIR/install.sql"
if [ x"${SERVICE_NAME}" == "x" ]; then 
     echo "SERVICE_NAME is not assigned to a variable"
     exit 1
fi
echo "connecting to ${INSTALL_USER}/**********@${SERVICE_NAME}"

sqlplus /nolog << FF
 connect ${INSTALL_USER}/"${INSTALL_USER_PW}"@${SERVICE_NAME} 
 set sqlprompt ""
 define apex_auth=${APEX_AUTH}
 define std_dir=${STD_DIR}
 define help_dir=${ROOT_DIR}scripts/helper/
 define root_dir=${ROOT_DIR} 
 spool ${LOGFILE}
 @${INSTALL_SCRIPT}
 exit 0;
FF 
sqlret=$?

exit
