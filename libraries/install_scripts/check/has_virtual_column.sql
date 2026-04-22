
column script new_value SCRIPT
set termout off
select case when count(*) = 0
         then '&make_dir.add_virtual_column'
         else '&std_dir.null'
       end script
  from user_tab_columns
 where table_name = upper('&tablename.')
   and column_name = upper('&columname.');
set termout on

@&script.
