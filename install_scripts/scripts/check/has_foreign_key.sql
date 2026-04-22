
column script new_value SCRIPT  
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&script_path.'
         ELSE '&std_dir.null'
       END script
  FROM user_constraints
 WHERE table_name = UPPER('&tablename.')
   AND constraint_name = UPPER('&fk_name.')
   AND constraint_type = 'R';
set termout on

@&script.
