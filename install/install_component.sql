/************************************************************************************************************
** Create database object for the database user
*************************************************************************************************************/

@&spool_dir.new_line 'Remove existing objects (&pre_dir.clean_up_install)'
@&pre_dir.clean_up_install

@&spool_dir.new_line 'Create synonyms (&syn_dir.install_syn)'
@&syn_dir.install_syn

@&spool_dir.new_line 'Resetting package state'
@&help_dir.reset_state

@&spool_dir.new_line 'Prepare installation (&pre_dir.install_scripts)'
@&pre_dir.install_scripts

@&spool_dir.new_line 'Create sequences (&seq_dir.install_seq)'
@&seq_dir.install_seq

@&spool_dir.new_line 'Create tables (&table_dir.install_tables)'
@&table_dir.install_tables

@&spool_dir.new_line 'Change tables (&table_dir.change_tables)'
@&table_dir.change_tables

@&spool_dir.new_line 'Create trigger (&trg_dir.install_trigger)'
@&trg_dir.install_trigger

@&spool_dir.new_line 'Create views (&view_dir.install_views)'
@&view_dir.install_views

@&spool_dir.new_line 'Create type specifactions (&type_dir.install_tps)'
@&type_dir.install_tps

@&spool_dir.new_line 'Create package specifications (&pack_dir.install_pks)'
@&pack_dir.install_pks

@&spool_dir.new_line 'Create MatViews (&mat_view_dir.install_mat_views)'
@&mat_view_dir.install_mat_views

@&spool_dir.new_line 'Create type bodies (&type_dir.install_tpb)'
@&type_dir.install_tpb

@&spool_dir.new_line 'Create package bodies (&pack_dir.install_pkb)'
@&pack_dir.install_pkb

@&spool_dir.new_line 'Execute procedures (&proc_dir.install_procedures)'
@&proc_dir.install_procedures

@&spool_dir.new_line 'Execute functions (&func_dir.install_functions)'
@&func_dir.install_functions

@&spool_dir.new_line 'Resetting package state'
@&help_dir.reset_state

@&spool_dir.new_line 'Execute scripts (&scripts_dir.install_scripts)'
@&scripts_dir.install_scripts

@&spool_dir.new_line 'Assign grants (&grants_dir.install_grants)'
@&grants_dir.install_grants

-- applications must be installed before the scripts, otherwise rule groups may not be created
@&spool_dir.new_line 'Install APEX applications (&app_dir.install_app)'
@&app_dir.install_app

@&spool_dir.new_line 'run Run Once Scripts (&scripts_dir.install_run_once)'
@&scripts_dir.install_run_once

@&spool_dir.new_line 'Compile schema (&help_dir.compile_schema)'
@&help_dir.compile_schema
