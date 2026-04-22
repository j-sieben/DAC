/************************************************************************************************************
** Create database object for the database user
*************************************************************************************************************/

@&spool_dir.new_line 'Remove existing objects (&pre_dir.clean_up_install)'
define optional_script = &pre_dir.clean_up_install
define optional_missing_msg = 'keine bestehende Installation zu entfernen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create synonyms (&syn_dir.install_syn)'
define optional_script = &syn_dir.install_syn
define optional_missing_msg = 'keine Synonyme anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Resetting package state'
@&help_dir.reset_state

@&spool_dir.new_line 'Prepare installation (&pre_dir.install_scripts)'
define optional_script = &pre_dir.install_scripts
define optional_missing_msg = 'keine Vorinstallationsskripte auszufuehren'
@&help_dir.run_optional

@&spool_dir.new_line 'Create sequences (&seq_dir.install_seq)'
define optional_script = &seq_dir.install_seq
define optional_missing_msg = 'keine Sequenzen anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create tables (&table_dir.install_tables)'
define optional_script = &table_dir.install_tables
define optional_missing_msg = 'keine Tabellen anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Change tables (&table_dir.change_tables)'
define optional_script = &table_dir.change_tables
define optional_missing_msg = 'keine Aenderungen fuer Tabellen vorhanden'
@&help_dir.run_optional

@&spool_dir.new_line 'Create trigger (&trg_dir.install_trigger)'
define optional_script = &trg_dir.install_trigger
define optional_missing_msg = 'keine Trigger anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create views (&view_dir.install_views)'
define optional_script = &view_dir.install_views
define optional_missing_msg = 'keine Views anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create type specifactions (&type_dir.install_tps)'
define optional_script = &type_dir.install_tps
define optional_missing_msg = 'keine Type-Spezifikationen anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create package specifications (&pack_dir.install_pks)'
define optional_script = &pack_dir.install_pks
define optional_missing_msg = 'keine Package-Spezifikationen anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create MatViews (&mat_view_dir.install_mat_views)'
define optional_script = &mat_view_dir.install_mat_views
define optional_missing_msg = 'keine Materialized Views anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create type bodies (&type_dir.install_tpb)'
define optional_script = &type_dir.install_tpb
define optional_missing_msg = 'keine Type-Bodys anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Create package bodies (&pack_dir.install_pkb)'
define optional_script = &pack_dir.install_pkb
define optional_missing_msg = 'keine Package-Bodys anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Execute procedures (&proc_dir.install_procedures)'
define optional_script = &proc_dir.install_procedures
define optional_missing_msg = 'keine Prozeduren anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Execute functions (&func_dir.install_functions)'
define optional_script = &func_dir.install_functions
define optional_missing_msg = 'keine Funktionen anzulegen'
@&help_dir.run_optional

@&spool_dir.new_line 'Resetting package state'
@&help_dir.reset_state

@&spool_dir.new_line 'Execute scripts (&scripts_dir.install_scripts)'
define optional_script = &scripts_dir.install_scripts
define optional_missing_msg = 'keine Skripte auszufuehren'
@&help_dir.run_optional

@&spool_dir.new_line 'Assign grants (&grants_dir.install_grants)'
define optional_script = &grants_dir.install_grants
define optional_missing_msg = 'keine Rechte zu vergeben'
@&help_dir.run_optional

-- applications must be installed before the scripts, otherwise rule groups may not be created
@&spool_dir.new_line 'Install APEX applications (&app_dir.install_app)'
define optional_script = &app_dir.install_app
define optional_missing_msg = 'keine APEX-Anwendung zu installieren'
@&help_dir.run_optional

@&spool_dir.new_line 'run Run Once Scripts (&scripts_dir.install_run_once)'
define optional_script = &scripts_dir.install_run_once
define optional_missing_msg = 'keine einmaligen Skripte auszufuehren'
@&help_dir.run_optional

@&spool_dir.new_line 'Compile schema (&help_dir.compile_schema)'
@&help_dir.compile_schema
