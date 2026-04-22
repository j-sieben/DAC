
@&spool_dir.step 'Drop materialized view &tablename'

begin 
  execute immediate 'drop materialized view &mvname.';
exception 
  when others then 
    null;
end;
/