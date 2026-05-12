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

define std_dir=../install_scripts/install/
define root_dir=../install_scripts/
define unit_test_dir=../unit_tests/
define COMPONENT=DAC
define KOMPONENTE=DAC

@&std_dir.defines

alter session set plsql_ccflags = 'HAS_SPOOL:&HAS_SPOOL.';

prompt ********************************************************************************
prompt *** Start installation of component DAC
prompt ********************************************************************************

prompt **  Reset package state
@&help_dir.reset_state

prompt **  Run pre-install scripts
@Pre_Install/install_scripts.sql

prompt **  Create tables
@Tables/install_tables.sql

prompt **  Create views
@Views/install_views.sql

prompt **  Create package specifications
@Packages/install_pks.sql

prompt **  Create materialized views
@Mat_views/install_mat_views.sql

prompt **  Create package bodies
@Packages/install_pkb.sql

prompt **  Reset package state
@&help_dir.reset_state

prompt **  Seed configuration
@Scripts/install_scripts.sql

prompt **  Compile schema
@&help_dir.compile_schema

prompt ********************************************************************************
prompt *** Finished installation of component DAC
prompt ********************************************************************************

exit 0
