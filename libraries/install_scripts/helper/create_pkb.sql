
define script_path = '&pack_dir.&packname..pkb'
@&spool_dir._step 'Create package body (&script_path.)'
@&script_path.
show errors
