prompt Dropping DAC database objects
prompt This script is called by the generic install and uninstall orchestration.

declare
  procedure drop_object(
    p_object_type in varchar2,
    p_object_name in varchar2)
  as
  begin
    execute immediate 'drop ' || p_object_type || ' ' || p_object_name;
    dbms_output.put_line('Dropped ' || p_object_type || ' ' || p_object_name);
  exception
    when others then
      if sqlcode in (-4043, -942, -12003) then
        dbms_output.put_line('Skipped missing ' || p_object_type || ' ' || p_object_name);
      else
        raise;
      end if;
  end drop_object;
begin
  drop_object('package', 'dac_access_demo_test');
  drop_object('package', 'dac_assignments');
  drop_object('package', 'dac_structure');
  drop_object('package', 'dac_admin');

  drop_object('view', 'dac_effective_access_status_v');
  drop_object('view', 'dac_effective_access_reasons_v');
  drop_object('view', 'dac_effective_accesses_v');
  drop_object('view', 'dac_access_decisions_v');
  drop_object('view', 'dac_access_decision_reasons_v');
  drop_object('view', 'dac_entity_node_assignments_v');
  drop_object('view', 'dac_dimension_nodes_v');
  drop_object('view', 'dac_dimensions_v');
  drop_object('view', 'dac_entities_v');
  drop_object('view', 'dac_entity_types_v');
  drop_object('view', 'dac_match_states_v');

  drop_object('materialized view', 'dac_effective_access_reasons');
  drop_object('materialized view', 'dac_effective_accesses');

  drop_object('table', 'dac_entity_node_assignments cascade constraints');
  drop_object('table', 'dac_dimension_nodes cascade constraints');
  drop_object('table', 'dac_dimensions cascade constraints');
  drop_object('table', 'dac_entities cascade constraints');
  drop_object('table', 'dac_entity_types cascade constraints');
  drop_object('table', 'dac_match_states cascade constraints');
end;
/
