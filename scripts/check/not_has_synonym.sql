/************************************************************************************************************
-- pruefen, ob Synonym bereits vorhanden 
*************************************************************************************************************/

column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&help_dir.null'
         ELSE q'^&script_path.^'
       END script
  FROM user_synonyms
 WHERE synonym_name = UPPER('&synname.');
set termout on

@&script.
