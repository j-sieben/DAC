/************************************************************************************************************
-- pruefen, ob Script bereits gelaufen ist
*************************************************************************************************************/

column script new_value script
column msg new_value msg
set termout off
select case when count(*) = 0
         then '&script_path.'
         else '&help_dir.null'
       end script,
       case when count(*) = 0
         then '&s1.Script &script_path. was already executed'
         else '&s1.Running script &script_path.'
       end script
  from &util_owner..run_once
 where script_name = '&script_path.'
   and version > &version.;
set termout on

@&spool_dir.step "MSG."

merge into &util_owner..run_once t
using (select '&script_path.' script_name, &version. version
         from dual) s
   on (t.script_name = s.script_name
  and  t.version = s.version)
 when not matched then insert(script_name, version)
      values (s.script_name, s.version);
      
commit;
