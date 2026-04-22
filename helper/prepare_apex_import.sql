@&spool_dir.step 'Prepare APEX import'

declare
  l_workspace_id number;
begin
  select workspace_id 
    into l_workspace_id
    from apex_workspaces
   where workspace = '&APEX_WS.';
    
  apex_application_install.set_application_id(&APP_ID.);
  apex_application_install.set_application_alias('&APP_ALIAS.');
  apex_application_install.set_workspace_id(l_workspace_id);
  apex_util.set_security_group_id(l_workspace_id);
end;
/

