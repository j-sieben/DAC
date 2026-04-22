
@&spool_dir.step 'Drop column &columnname. in table &tablename.'

begin
  update &tablename.
     set &columnname. = null;
  commit;
  exception
    when others then
      null;
end;
/

alter table &tablename. drop column &columnname.;
