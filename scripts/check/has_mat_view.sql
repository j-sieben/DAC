
column script new_value script
column msg new_value msg
set termout off
select case when count(*) = 0
         then '&help_dir.null'
         else '&make_dir.drop_mat_view'
       end script,
       case when count(*) = 1
         then 'Drop materialized view &mvname.'
         else 'Materialized view &mvname. does not exist'
       end msg
  from user_objects
 where object_type = 'MATERIALIZED VIEW'
   and object_name = upper('&mvname.');
set termout on

@&spool_dir.step "&MSG."
@&script.

set termout off
select case when count(*) = 0
         then '&script_path.'
         else '&help_dir.null'
       end script,
       case when count(*) = 0
         then 'Create materialized view &mvname. (&script_path.)'
         else 'Materialized view &mvname. exists already'
       end msg
  from user_objects
 where object_type = 'MATERIALIZED VIEW'
   and object_name = upper('&mvname.');
set termout on


@&spool_dir.step "&MSG."
@&script.
