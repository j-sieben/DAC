/************************************************************************************************************
** Datenbanksynonyme des INSTALL_USERS aus DB entfernen
*************************************************************************************************************/

@&spool_dir.h4 'Drop synonyms on objects of user &grantee.'

declare
  cursor syn_cur is
    select synonym_name
      from user_synonyms
     where table_owner = '&grantee.';
begin
  for syn in syn_cur loop
    execute immediate 'drop synonym ' || syn.synonym_name;
    dbms_output.put_line('&s1.Synonym ' || syn.synonym_name || ' dropped');
  end loop;
end;
/
