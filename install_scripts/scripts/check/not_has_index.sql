/************************************************************************************************************
-- pruefen, ob Index bereits vorhanden 
*************************************************************************************************************/

column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) != 0
         THEN '&make_dir.drop_index &1.'
         ELSE '&help_dir.null'
       END script
  FROM user_objects
 WHERE object_type = 'INDEX'
   AND object_name = UPPER('&1.');
set termout on

@&script.
