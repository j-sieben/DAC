set define on
set verify off
set serveroutput on size 1000000
set echo off
set feedback off
set lines 120
set pages 9999
set heading off
set headsep off

whenever sqlerror exit 90 rollback
whenever oserror exit 11 rollback

column util_owner new_value util_owner noprint
column install_user new_value install_user noprint
column has_spool new_value has_spool noprint

select user util_owner from dual;
select user install_user from dual;
select case count(*) when 0 then 'false' else 'true' end has_spool
  from all_objects
 where object_type = 'PACKAGE BODY'
   and object_name = 'SPOOL_PKG';

define std_dir=install_scripts/install/
define root_dir=install_scripts/
define unit_test_dir=unit_tests/
define COMPONENT=DAC
define KOMPONENTE=DAC

@&std_dir.defines

define app_dir=unit_tests/Applications/
define pre_dir=unit_tests/Pre_Install/
define func_dir=unit_tests/Functions/
define grants_dir=unit_tests/Grants/
define pack_dir=unit_tests/Packages/
define proc_dir=unit_tests/Procedures/
define scripts_dir=unit_tests/Scripts/
define seq_dir=unit_tests/Sequences/
define syn_dir=unit_tests/Synonyms/
define table_dir=unit_tests/Tables/
define trg_dir=unit_tests/Triggers/
define type_dir=unit_tests/Types/
define view_dir=unit_tests/Views/
define mat_view_dir=unit_tests/Mat_views/

alter session set plsql_ccflags = 'HAS_SPOOL:&HAS_SPOOL.';

prompt ********************************************************************************
prompt *** Start DAC test installation
prompt ********************************************************************************

prompt **  Reset package state
@&help_dir.reset_state

prompt **  Create test package specifications
@unit_tests/Packages/install_pks.sql

prompt **  Create test package bodies
@unit_tests/Packages/install_pkb.sql

prompt **  Seed test data
@unit_tests/Scripts/install_scripts.sql

prompt **  Compile schema
@&help_dir.compile_schema

prompt ********************************************************************************
prompt *** Finished DAC test installation
prompt ********************************************************************************

exit 0
