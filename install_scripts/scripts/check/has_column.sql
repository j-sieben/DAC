
column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN q'^&script_path.^'
         ELSE '&help_dir.null'
       END script
  FROM user_tab_columns
 WHERE table_name = UPPER('&tablename.')
   AND column_name = UPPER('&columnname.');
set termout on

@&script.
