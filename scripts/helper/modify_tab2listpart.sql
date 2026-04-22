/************************************************************************************************************
-- Tabelle in List Partitionierte umwandeln
*************************************************************************************************************/

@&spool_dir.step 'Convert table &1. to list partitioning on column &2. with partition &3.'
alter table &1. modify partition by list (&2.) (partition &3. values (DEFAULT));
