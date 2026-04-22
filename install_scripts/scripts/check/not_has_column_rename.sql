/************************************************************************************************************
-- pruefen, ob Tabellenspalte zu aendern vorhanden 
*************************************************************************************************************/

column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&help_dir.null'
         ELSE '&4. &1. &2. &3.'
       END script
  FROM user_tab_columns
 WHERE table_name = UPPER('&1.')
   AND column_name = UPPER('&2.')
   AND UPPER('&3.') not in 
            (Select column_name 
               FROM user_tab_columns
              WHERE table_name = UPPER('&1.') 
                AND column_name = UPPER('&3.')
             );
set termout on

@&script.
