column script new_value SCRIPT
column msg new_value MSG
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&script_path.'
         ELSE '&std_dir.null'
       END script,
       CASE WHEN COUNT(*) = 0
         THEN '&s1.Creating sequence &seqname. (&script_path.)'
         ELSE '&s1.Sequence &seqname. exists'
       END msg
  FROM user_objects
 WHERE object_type = 'SEQUENCE'
   AND object_name = UPPER('&seqname.');
set termout on

@&spool_dir.step "&MSG."
@&script;