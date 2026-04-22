
@&spool_dir.h4 'Create synonyms for user &GRANTEE.'

declare
  cursor object_cur is
    select lower(object_name) object_name
      from all_objects
     where owner = upper('&grantee.')
       and instr(object_type, 'BODY') = 0
       and object_type not in ('INDEX');
begin
  for o in object_cur loop
    begin
      execute immediate 'create or replace synonym ' || o.object_name || ' for &grantee..' || o.object_name;
      dbms_output.put_line('&s1.Synonym ' || o.object_name || ' created');
    exception
      when others then
        dbms_output.put_line('&s1.Error creating synonym ' || o.object_name || ': ' || substr(sqlerrm, 12));
    end;
  end loop;
end;
/
