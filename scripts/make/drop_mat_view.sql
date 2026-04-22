
begin 
  execute immediate 'drop materialized view &mvname.';
exception 
  when others then 
    null;
end;
/