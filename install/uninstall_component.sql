/************************************************************************************************************
** Remove database objects of the INSTALL_USER
*************************************************************************************************************/
@&spool_dir.h1 'Begin uninstall_component'

@&spool_dir.h2 'Remove existing installation (clean_up_install)'
define optional_script = &pre_dir.clean_up_install
define optional_missing_msg = 'keine bestehende Installation zu entfernen'
@&help_dir.run_optional

@&spool_dir.h2 'Remove application (&app_dir.uninstall_app)'
define optional_script = &app_dir.uninstall_app
define optional_missing_msg = 'keine Anwendung zu entfernen'
@&help_dir.run_optional

@&spool_dir.h2 'Recompile schema (&help_dir.compile_schema)'
@&help_dir.compile_schema

@&spool_dir.h1 'End uninstall_component'
