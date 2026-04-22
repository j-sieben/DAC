
@&spool_dir.step 'create list partition &partition_name. in der Tabelle &tablename. mit Wert "&partition_value."'
alter table &tablename. add partition &partition_name. values ('"&partition_value."');
