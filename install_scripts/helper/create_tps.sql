
define script_path = '&type_dir.&typename..tps'
@&spool_dir.step 'Create type specification for &typename. (&script_path.)'
whenever sqlerror continue
set termout off
@&script_path.
set termout on
whenever sqlerror exit
