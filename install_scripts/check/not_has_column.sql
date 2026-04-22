/************************************************************************************************************
-- pruefen, ob Tabellenspalte zu aendern vorhanden 
*************************************************************************************************************/

column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&std_dir.null'
         ELSE '&script_path.'
       END script
  FROM user_tab_columns
 WHERE table_name = UPPER('&tablename.')
   AND column_name = UPPER('&columnname.');
set termout on

@&script.
