
define script_path = '&pack_dir.&packname..pks'
@&spool_dir.step 'Create package specification (&script_path.)'
@&script_path.
show errors
