
define script_path = '&type_dir.&typename..tpb'
@&spool_dir.step 'Create type body of &typename. (&script_path.)'
@&script_path.
show errors
