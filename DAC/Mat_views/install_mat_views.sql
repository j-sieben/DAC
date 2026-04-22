prompt Creating DAC materialized views

define mvname=dac_effective_accesses
@&help_dir.create_mat_view

define mvname=dac_effective_access_reasons
@&help_dir.create_mat_view

prompt Creating DAC effective access views

define dac_scripts_dir=&scripts_dir.
define scripts_dir=&view_dir.
define scriptname=install_effective_views.sql
@&help_dir.run_script
define scripts_dir=&dac_scripts_dir.
