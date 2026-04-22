
define add_script = &make_dir.add_list_partition

column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&add_script.'
         ELSE '&std_dir.null'
       END script
  FROM user_tab_partitions
 WHERE table_name = UPPER('&tablename.')
   AND partition_name = UPPER('&partition_name.');
set termout on

@&script.
