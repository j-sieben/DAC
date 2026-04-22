/************************************************************************************************************
** Dokumentation im Erfolgsfall
*************************************************************************************************************
** Historie:
** 01.07.2018 S. Harbrecht Erstellung
*************************************************************************************************************/
SET DEFINE ON
SET VERIFY OFF
SET SERVEROUTPUT ON SIZE 1000000
SET ECHO OFF
SET FEEDBACK OFF
SET LINES 120
SET PAGES 9999

COLUMN datumuhrzeit new_value DATUMUHRZEIT

SELECT TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS') DATUMUHRZEIT FROM dual;

@&spool_dir.section 'Installation der Komponente erfolgreich &DATUMUHRZEIT.' 
@&std_dir.insert_spool 
PROMPT &MSG.

@&spool_dir.step '&sh1.Schema kompilieren - Aufruf compile_schema'
@&std_dir.compile_schema

exit 0
