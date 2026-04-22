/************************************************************************************************************
-- pruefen, ob MatView nicht vorhanden ist
*************************************************************************************************************/

column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&help_dir.null'
         ELSE '&cript_path.'
       END script
  FROM user_objects
 WHERE object_type = 'MATERIALIZED VIEW'
   AND object_name = UPPER('&tablename.');
set termout on

@&script.
