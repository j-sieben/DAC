prompt Installing DAC utPLSQL tests

define dac_app_dir=&app_dir.
define dac_pre_dir=&pre_dir.
define dac_func_dir=&func_dir.
define dac_grants_dir=&grants_dir.
define dac_pack_dir=&pack_dir.
define dac_proc_dir=&proc_dir.
define dac_scripts_dir=&scripts_dir.
define dac_seq_dir=&seq_dir.
define dac_syn_dir=&syn_dir.
define dac_table_dir=&table_dir.
define dac_trg_dir=&trg_dir.
define dac_type_dir=&type_dir.
define dac_view_dir=&view_dir.
define dac_mat_view_dir=&mat_view_dir.

define app_dir=&unit_test_dir.Applications/
define pre_dir=&unit_test_dir.Pre_Install/
define func_dir=&unit_test_dir.Functions/
define grants_dir=&unit_test_dir.Grants/
define pack_dir=&unit_test_dir.Packages/
define proc_dir=&unit_test_dir.Procedures/
define scripts_dir=&unit_test_dir.Scripts/
define seq_dir=&unit_test_dir.Sequences/
define syn_dir=&unit_test_dir.Synonyms/
define table_dir=&unit_test_dir.Tables/
define trg_dir=&unit_test_dir.Triggers/
define type_dir=&unit_test_dir.Types/
define view_dir=&unit_test_dir.Views/
define mat_view_dir=&unit_test_dir.Mat_views/

@&std_dir.install_component

define app_dir=&dac_app_dir.
define pre_dir=&dac_pre_dir.
define func_dir=&dac_func_dir.
define grants_dir=&dac_grants_dir.
define pack_dir=&dac_pack_dir.
define proc_dir=&dac_proc_dir.
define scripts_dir=&dac_scripts_dir.
define seq_dir=&dac_seq_dir.
define syn_dir=&dac_syn_dir.
define table_dir=&dac_table_dir.
define trg_dir=&dac_trg_dir.
define type_dir=&dac_type_dir.
define view_dir=&dac_view_dir.
define mat_view_dir=&dac_mat_view_dir.
