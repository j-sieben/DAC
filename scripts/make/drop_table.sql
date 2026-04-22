
@&spool_dir.step 'Drop table &tablename.'

drop table &tablename. cascade constraints purge;
