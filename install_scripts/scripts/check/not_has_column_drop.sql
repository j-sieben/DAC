
column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&help_dir.null'
         ELSE '&3. &1. &2.'
       END script
  FROM user_tab_columns
 WHERE table_name = UPPER('&1.')
   AND column_name = UPPER('&2.');
set termout on

@&script.
