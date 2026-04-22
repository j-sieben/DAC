/************************************************************************************************************
** Remove database objects of the INSTALL_USER
*************************************************************************************************************/
@&spool_dir.h1 'Begin uninstall_component'

@&spool_dir.h2 'Remove existing installation (clean_up_install)'
@clean_up_install

@&spool_dir.h2 'Remove application (&app_dir.uninstall_app)'
@&app_dir.uninstall_app

@&spool_dir.h2 'Recompile schema (&help_dir.compile_schema)'
@&help_dir.compile_schema

@&spool_dir.h1 'End uninstall_component'

