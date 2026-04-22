
column script new_value SCRIPT
set termout off
SELECT CASE WHEN COUNT(*) = 0
         THEN '&help_dir.modify_tab2listpart. &1. &2. &3. '
         ELSE '&help_dir.null'
       END script
  FROM user_tab_partitions
 WHERE table_name = UPPER('&1.');
set termout on


@&script.
