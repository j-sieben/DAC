/************************************************************************************************************
-- pruefen, ob Fremdschluessel bereits vorhanden, wenn ja Skript ausfuehren 
*************************************************************************************************************/

column script new_value SCRIPT  
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&std_dir.null'
         ELSE '&table_dir.&3.'
       END script
  FROM user_constraints
 WHERE table_name = UPPER('&1.')
   AND constraint_name = UPPER('&2.')
   AND constraint_type = 'R';
set termout on


@&script.
