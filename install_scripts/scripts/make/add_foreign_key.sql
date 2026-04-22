
@&spool_dir.step 'Add foreign key &fk_name. at table &tablename., referencing &fk_table.'
alter table &tablename. add constraint &fk_name. foreign key (&columnname.)
  references &fk_table (&fk_column);
