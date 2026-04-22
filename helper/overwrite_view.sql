/************************************************************************************************************
** View re-definieren, wird verwendet, wenn eine gegrantete View unter gleichem Namen neu definiert werden soll
*************************************************************************************************************/

define script_path = '&make_dir.drop_synonym'
define synname = &viewname.
@check_dir.not_has_synonym

define script_path = '&view_dir.&viewname..vw'
@&spool_dir.step 'Create view &viewname. (&script_path.)'
@&script_path.
