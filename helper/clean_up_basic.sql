/************************************************************************************************************
** Datenbankobjekte des INSTALL_USERS aus DB entfernen
*************************************************************************************************************/

set serveroutput on

declare
  l_stmt varchar2(512);
  cursor c_obj is
    select 'drop ' || object_type || ' ' || object_name as stmt,
           '&s1.' || lower(object_type) || ' ' || lower(object_name || ' dropped') msg
      from user_objects
     where object_type in (
           'VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'TRIGGER', 'SEQUENCE')
       and generated != 'Y'
       and object_name not like 'ADCA%'
       and object_name not like 'PITA%'
       and object_name not like 'SPLITTER%'
       and object_name not like 'SPOO%'
       and object_name not in ('PARAMETER_V');
  cursor c_synonym is
    select 'drop SYNONYM ' || synonym_name as stmt,
           '&s1.Synonym ' || lower(synonym_name || ' dropped') msg
      from user_synonyms
      left join (
           select *
             from all_objects
            where owner != user)
        on table_name = object_name
     where object_name is null;
  cursor c_grant is
    select 'revoke ' || privilege || ' on ' || table_name || ' from ' || grantee as stmt,
           '&s1.Revoking privilege ' || lower(privilege) || ' on ' || lower(table_name) || ' from ' || lower(grantee) msg
      from user_tab_privs_made
     where grantor = user
       and grantee != 'PUBLIC';
begin
  for i in c_obj loop
    begin
      dbms_output.put_line(i.msg);
      execute immediate i.stmt;
    exception 
      when others then null;
    end;
  end loop;
  for s in c_synonym loop
    begin
      dbms_output.put_line(s.msg);
      execute immediate s.stmt;
    exception 
      when others then null;
    end;
  end loop;
  for i in c_grant loop
    begin
      dbms_output.put_line(i.msg);
      execute immediate i.stmt;
    exception 
      when others then null;
    end;
  end loop;
end;
/  

  
  
