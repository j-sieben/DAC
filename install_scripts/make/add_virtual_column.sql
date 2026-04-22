
@&spool_dir.step 'Create virtual column &columnname. in der Tabelle &tablename. with clause "&clause."'
alter table &tablename. add (&columnname. &datatype. generated always as (&clause.) virtual);
