/************************************************************************************************************
** Re-define view, is used if a granted view is to be redefined under the same name
** This version creates a 1:1 copy of the granted view
*************************************************************************************************************/

define script_path = '&make_dir.drop_synonym'
define synname = &viewname.
@&check_dir.not_has_synonym

@&spool_dir.step 'Copy view &viewname. (&viewname.)'
@&make_dir.copy_view
