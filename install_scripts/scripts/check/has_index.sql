
column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&make_dir.add_index'
         ELSE '&std_dir.null'
       END script
  FROM user_objects
 WHERE object_type = 'INDEX'
   AND object_name = UPPER('&indexname.');
set termout on

@&script.

