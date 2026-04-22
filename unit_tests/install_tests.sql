prompt Installing DAC utPLSQL tests

define dac_scripts_dir=&scripts_dir.
define dac_pack_dir=&pack_dir.

define scripts_dir=&unit_test_scripts_dir.
define scriptname=install_scripts.sql
@&help_dir.run_script

define pack_dir=&unit_test_pack_dir.
define scripts_dir=&unit_test_pack_dir.
define scriptname=install_pks.sql
@&help_dir.run_script

define scriptname=install_pkb.sql
@&help_dir.run_script

define scripts_dir=&dac_scripts_dir.
define pack_dir=&dac_pack_dir.
