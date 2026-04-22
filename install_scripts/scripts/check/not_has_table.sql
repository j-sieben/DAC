/************************************************************************************************************
-- pruefen, ob Tabelle nicht vorhanden ist
*************************************************************************************************************/

column script new_value SCRIPT
column msg new_value MSG
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&help_dir.null'
         ELSE '&scriptname.'
       END script
  FROM user_objects
 WHERE object_type = 'TABLE'
   AND object_name = UPPER('&tablename.');
set termout on

@&script.
