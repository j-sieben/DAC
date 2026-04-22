
@&spool_dir.step 'Drop index &indexname.'

begin 
  execute immediate 'drop index &indexname.';
exception 
  when others then 
    null;
end;
/
