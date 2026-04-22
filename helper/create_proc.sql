
define script_path = '&proc_dir.&procname..prc'
@&spool_dir.step 'Create procedure &procname. (&script_path.)'
@&script_path.
