prompt Installing DAC

set define on
set verify off
set serveroutput on size unlimited
set echo off
set feedback on
set lines 200
set pages 9999

whenever sqlerror exit sql.sqlcode rollback
whenever oserror exit 11 rollback

@@install_component.sql

prompt DAC installation finished
