
column script new_value SCRIPT
column msg new_value MSG
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&script_path.'
         ELSE '&std_dir.null'
       END script,
       CASE WHEN COUNT(*) = 0
         THEN '&s1.Creating table &tablename. (&script_path.)'
         ELSE '&s1.Table &tablename. exists'
       END msg
  FROM user_objects
 WHERE object_type = 'TABLE'
   AND object_name = UPPER('&tablename.');
set termout on

@&spool_dir.step "&MSG."
@&script.
