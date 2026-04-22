/************************************************************************************************************
** Installation der Komponente
*************************************************************************************************************/
set define on
set verify off
set serveroutput on size 1000000
set echo off
set feedback off
set lines 120
set pages 9999
set heading off
set headsep off

set termout off
whenever sqlerror exit 90 rollback;
whenever oserror exit 11 rollback;

@&std_dir.defines

column now new_value now
column version new_value version
col install_user new_val install_user format a30

select to_char(sysdate,'DD.MM.YYYY HH24:MI:SS') now,
       to_char(sysdate,'DD.MM.YYYY') version,
       user as install_user
  from dual;

col has_spool new_val has_spool format a15

select case count(*) 
         when 0 then 'false' else 'true'
       end has_spool
  from all_objects
 where object_type = 'PACKAGE BODY'
   and object_name = 'SPOOL_PKG';

alter session set plsql_ccflags = 'HAS_SPOOL:&HAS_SPOOL.';

@&spool_dir.h1 'Check wether SPOOL table is available'

set termout on
set serveroutput on

declare
begin
  $IF $$HAS_SPOOL $THEN
    dbms_output.put_line('&s1.Delete SPOOL table entries for component &COMPONENT., user &INSTALL_USER.');
    &util_owner..spool_pkg.deletespool('&COMPONENT.','&INSTALL_USER.');
  $ELSE
    NULL;
  $END
end;
/

@&spool_dir.section "Start installation of component &COMPONENT.: &NOW."

@&std_dir.install_component

select to_char(sysdate,'DD.MM.YYYY HH24:MI:SS') now from dual;

@&spool_dir.section 'Finalized installation of component &COMPONENT.: &NOW.'

exit 0
