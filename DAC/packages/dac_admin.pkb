create or replace package body dac_admin
as
  /**
    Package: DAC_ADMIN Body
      Administrative API for dimensional access control master data and assignments.
   */

  /**
    Procedure: validate_match_state
      See: <DAC_ADMIN.validate_match_state>
   */
  procedure validate_match_state(
    p_row in dac_match_states_v%rowtype)
  as
  begin
    pit.enter_mandatory('validate_match_state');
    pit.leave_mandatory;
  end validate_match_state;


  /**
    Procedure: merge_match_state
      See: <DAC_ADMIN.merge_match_state>
   */
  procedure merge_match_state(
    p_dms_id in dac_match_states_v.dms_id%type,
    p_dms_name in dac_match_states_v.dms_name%type,
    p_dms_description in dac_match_states_v.dms_description%type,
    p_dms_display_sequence in dac_match_states_v.dms_display_sequence%type,
    p_dms_active in dac_match_states_v.dms_active%type)
  as
  begin
    pit.enter_mandatory('merge_match_state',
      p_params => msg_params(msg_param('p_dms_id', p_dms_id)));

    pit_admin.merge_translatable_item(
      p_pti_id => p_dms_id,
      p_pti_pml_name => pit_util.C_DEFAULT_LANGUAGE,
      p_pti_pmg_name => C_PMG_NAME,
      p_pti_name => p_dms_name,
      p_pti_description => p_dms_description);

    merge into dac_match_states t
    using (select p_dms_id dms_id,
                  p_dms_display_sequence dms_display_sequence,
                  p_dms_active dms_active
             from dual) s
       on (t.dms_id = s.dms_id)
     when matched then update set
          t.dms_display_sequence = s.dms_display_sequence,
          t.dms_active = s.dms_active
     when not matched then insert(dms_id, dms_display_sequence, dms_active)
          values(s.dms_id, s.dms_display_sequence, s.dms_active);

    pit.leave_mandatory;
  end merge_match_state;


  /**
    Procedure: merge_match_state
      See: <DAC_ADMIN.merge_match_state>
   */
  procedure merge_match_state(
    p_row in dac_match_states_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_match_state');
    validate_match_state(p_row);
    merge_match_state(
      p_dms_id => p_row.dms_id,
      p_dms_name => p_row.dms_name,
      p_dms_description => p_row.dms_description,
      p_dms_display_sequence => p_row.dms_display_sequence,
      p_dms_active => p_row.dms_active);
    pit.leave_mandatory;
  end merge_match_state;


  /**
    Procedure: delete_match_state
      See: <DAC_ADMIN.delete_match_state>
   */
  procedure delete_match_state(
    p_dms_id in dac_match_states_v.dms_id%type)
  as
  begin
    pit.enter_mandatory('delete_match_state',
      p_params => msg_params(msg_param('p_dms_id', p_dms_id)));

    delete from dac_match_states
     where dms_id = p_dms_id;

    pit_admin.delete_translatable_item(
      p_pti_id => p_dms_id,
      p_pti_pmg_name => C_PMG_NAME);

    pit.leave_mandatory;
  end delete_match_state;


  /**
    Procedure: validate_entity_type
      See: <DAC_ADMIN.validate_entity_type>
   */
  procedure validate_entity_type(
    p_row in dac_entity_types_v%rowtype)
  as
  begin
    pit.enter_mandatory('validate_entity_type');
    pit.leave_mandatory;
  end validate_entity_type;


  /**
    Procedure: merge_entity_type
      See: <DAC_ADMIN.merge_entity_type>
   */
  procedure merge_entity_type(
    p_det_id in dac_entity_types_v.det_id%type,
    p_det_name in dac_entity_types_v.det_name%type,
    p_det_description in dac_entity_types_v.det_description%type,
    p_det_is_subject in dac_entity_types_v.det_is_subject%type,
    p_det_active in dac_entity_types_v.det_active%type,
    p_det_display_sequence in dac_entity_types_v.det_display_sequence%type)
  as
  begin
    pit.enter_mandatory('merge_entity_type',
      p_params => msg_params(msg_param('p_det_id', p_det_id)));

    pit_admin.merge_translatable_item(
      p_pti_id => p_det_id,
      p_pti_pml_name => pit_util.C_DEFAULT_LANGUAGE,
      p_pti_pmg_name => C_PMG_NAME,
      p_pti_name => p_det_name,
      p_pti_description => p_det_description);

    merge into dac_entity_types t
    using (select p_det_id det_id,
                  p_det_is_subject det_is_subject,
                  p_det_active det_active,
                  p_det_display_sequence det_display_sequence
             from dual) s
       on (t.det_id = s.det_id)
     when matched then update set
          t.det_is_subject = s.det_is_subject,
          t.det_active = s.det_active,
          t.det_display_sequence = s.det_display_sequence,
          t.det_updated_at = systimestamp
     when not matched then insert(det_id, det_is_subject, det_active, det_display_sequence)
          values(s.det_id, s.det_is_subject, s.det_active, s.det_display_sequence);

    pit.leave_mandatory;
  end merge_entity_type;


  /**
    Procedure: merge_entity_type
      See: <DAC_ADMIN.merge_entity_type>
   */
  procedure merge_entity_type(
    p_row in dac_entity_types_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_entity_type');
    validate_entity_type(p_row);
    merge_entity_type(
      p_det_id => p_row.det_id,
      p_det_name => p_row.det_name,
      p_det_description => p_row.det_description,
      p_det_is_subject => p_row.det_is_subject,
      p_det_active => p_row.det_active,
      p_det_display_sequence => p_row.det_display_sequence);
    pit.leave_mandatory;
  end merge_entity_type;


  /**
    Procedure: delete_entity_type
      See: <DAC_ADMIN.delete_entity_type>
   */
  procedure delete_entity_type(
    p_det_id in dac_entity_types_v.det_id%type)
  as
  begin
    pit.enter_mandatory('delete_entity_type',
      p_params => msg_params(msg_param('p_det_id', p_det_id)));

    delete from dac_entity_types
     where det_id = p_det_id;

    pit_admin.delete_translatable_item(
      p_pti_id => p_det_id,
      p_pti_pmg_name => C_PMG_NAME);

    pit.leave_mandatory;
  end delete_entity_type;


  /**
    Procedure: validate_entity
      See: <DAC_ADMIN.validate_entity>
   */
  procedure validate_entity(
    p_row in dac_entities_v%rowtype)
  as
  begin
    pit.enter_mandatory('validate_entity');

    if coalesce(p_row.den_active_from, date '1900-01-01') > coalesce(p_row.den_active_to, date '9999-12-31') then
      pit.raise_error(
        p_message_name => msg.DAC_INVALID_VALIDITY_BAND,
        p_msg_args => msg_args('DAC_ENTITIES'));
    end if;

    pit.leave_mandatory;
  end validate_entity;


  /**
    Procedure: merge_entity
      See: <DAC_ADMIN.merge_entity>
   */
  procedure merge_entity(
    p_den_id in dac_entities_v.den_id%type,
    p_den_det_id in dac_entities_v.den_det_id%type,
    p_den_external_id in dac_entities_v.den_external_id%type,
    p_den_display_name in dac_entities_v.den_display_name%type,
    p_den_description in dac_entities_v.den_description%type,
    p_den_active_from in dac_entities_v.den_active_from%type,
    p_den_active_to in dac_entities_v.den_active_to%type,
    p_den_active in dac_entities_v.den_active%type)
  as
    l_den_active_from dac_entities_v.den_active_from%type := coalesce(p_den_active_from, date '1900-01-01');
    l_den_active_to dac_entities_v.den_active_to%type := coalesce(p_den_active_to, date '9999-12-31');
  begin
    pit.enter_mandatory('merge_entity',
      p_params => msg_params(msg_param('p_den_id', p_den_id)));

    if l_den_active_from > l_den_active_to then
      pit.raise_error(
        p_message_name => msg.DAC_INVALID_VALIDITY_BAND,
        p_msg_args => msg_args('DAC_ENTITIES'));
    end if;

    merge into dac_entities t
    using (select p_den_id den_id,
                  p_den_det_id den_det_id,
                  p_den_external_id den_external_id,
                  p_den_display_name den_display_name,
                  p_den_description den_description,
                  l_den_active_from den_active_from,
                  l_den_active_to den_active_to,
                  p_den_active den_active
             from dual) s
       on (t.den_id = s.den_id)
     when matched then update set
          t.den_det_id = s.den_det_id,
          t.den_external_id = s.den_external_id,
          t.den_display_name = s.den_display_name,
          t.den_description = s.den_description,
          t.den_active_from = s.den_active_from,
          t.den_active_to = s.den_active_to,
          t.den_active = s.den_active,
          t.den_updated_at = systimestamp
     when not matched then insert(
          den_id, den_det_id, den_external_id, den_display_name, den_description,
          den_active_from, den_active_to, den_active)
          values(
          s.den_id, s.den_det_id, s.den_external_id, s.den_display_name, s.den_description,
          s.den_active_from, s.den_active_to, s.den_active);

    pit.leave_mandatory;
  end merge_entity;


  /**
    Procedure: merge_entity
      See: <DAC_ADMIN.merge_entity>
   */
  procedure merge_entity(
    p_row in dac_entities_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_entity');
    validate_entity(p_row);
    merge_entity(
      p_den_id => p_row.den_id,
      p_den_det_id => p_row.den_det_id,
      p_den_external_id => p_row.den_external_id,
      p_den_display_name => p_row.den_display_name,
      p_den_description => p_row.den_description,
      p_den_active_from => p_row.den_active_from,
      p_den_active_to => p_row.den_active_to,
      p_den_active => p_row.den_active);
    pit.leave_mandatory;
  end merge_entity;


  /**
    Procedure: delete_entity
      See: <DAC_ADMIN.delete_entity>
   */
  procedure delete_entity(
    p_den_id in dac_entities_v.den_id%type)
  as
  begin
    pit.enter_mandatory('delete_entity',
      p_params => msg_params(msg_param('p_den_id', p_den_id)));

    delete from dac_entities
     where den_id = p_den_id;

    pit.leave_mandatory;
  end delete_entity;


  /**
    Procedure: validate_dimension
      See: <DAC_ADMIN.validate_dimension>
   */
  procedure validate_dimension(
    p_row in dac_dimensions_v%rowtype)
  as
  begin
    pit.enter_mandatory('validate_dimension');
    pit.leave_mandatory;
  end validate_dimension;


  /**
    Procedure: merge_dimension
      See: <DAC_ADMIN.merge_dimension>
   */
  procedure merge_dimension(
    p_ddi_id in dac_dimensions_v.ddi_id%type,
    p_ddi_name in dac_dimensions_v.ddi_name%type,
    p_ddi_description in dac_dimensions_v.ddi_description%type,
    p_ddi_is_restrictive in dac_dimensions_v.ddi_is_restrictive%type,
    p_ddi_is_filter in dac_dimensions_v.ddi_is_filter%type,
    p_ddi_active in dac_dimensions_v.ddi_active%type,
    p_ddi_display_sequence in dac_dimensions_v.ddi_display_sequence%type)
  as
  begin
    pit.enter_mandatory('merge_dimension',
      p_params => msg_params(msg_param('p_ddi_id', p_ddi_id)));

    pit_admin.merge_translatable_item(
      p_pti_id => p_ddi_id,
      p_pti_pml_name => pit_util.C_DEFAULT_LANGUAGE,
      p_pti_pmg_name => C_PMG_NAME,
      p_pti_name => p_ddi_name,
      p_pti_description => p_ddi_description);

    merge into dac_dimensions t
    using (select p_ddi_id ddi_id,
                  p_ddi_is_restrictive ddi_is_restrictive,
                  p_ddi_is_filter ddi_is_filter,
                  p_ddi_active ddi_active,
                  p_ddi_display_sequence ddi_display_sequence
             from dual) s
       on (t.ddi_id = s.ddi_id)
     when matched then update set
          t.ddi_is_restrictive = s.ddi_is_restrictive,
          t.ddi_is_filter = s.ddi_is_filter,
          t.ddi_active = s.ddi_active,
          t.ddi_display_sequence = s.ddi_display_sequence,
          t.ddi_updated_at = systimestamp
     when not matched then insert(
          ddi_id, ddi_is_restrictive, ddi_is_filter, ddi_active, ddi_display_sequence)
          values(
          s.ddi_id, s.ddi_is_restrictive, s.ddi_is_filter, s.ddi_active, s.ddi_display_sequence);

    pit.leave_mandatory;
  end merge_dimension;


  /**
    Procedure: merge_dimension
      See: <DAC_ADMIN.merge_dimension>
   */
  procedure merge_dimension(
    p_row in dac_dimensions_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_dimension');
    validate_dimension(p_row);
    merge_dimension(
      p_ddi_id => p_row.ddi_id,
      p_ddi_name => p_row.ddi_name,
      p_ddi_description => p_row.ddi_description,
      p_ddi_is_restrictive => p_row.ddi_is_restrictive,
      p_ddi_is_filter => p_row.ddi_is_filter,
      p_ddi_active => p_row.ddi_active,
      p_ddi_display_sequence => p_row.ddi_display_sequence);
    pit.leave_mandatory;
  end merge_dimension;


  /**
    Procedure: delete_dimension
      See: <DAC_ADMIN.delete_dimension>
   */
  procedure delete_dimension(
    p_ddi_id in dac_dimensions_v.ddi_id%type)
  as
  begin
    pit.enter_mandatory('delete_dimension',
      p_params => msg_params(msg_param('p_ddi_id', p_ddi_id)));

    delete from dac_dimensions
     where ddi_id = p_ddi_id;

    pit_admin.delete_translatable_item(
      p_pti_id => p_ddi_id,
      p_pti_pmg_name => C_PMG_NAME);

    pit.leave_mandatory;
  end delete_dimension;


  /**
    Procedure: validate_dimension_node
      See: <DAC_ADMIN.validate_dimension_node>
   */
  procedure validate_dimension_node(
    p_row in dac_dimension_nodes_v%rowtype)
  as
  begin
    pit.enter_mandatory('validate_dimension_node');
    pit.leave_mandatory;
  end validate_dimension_node;


  /**
    Procedure: merge_dimension_node
      See: <DAC_ADMIN.merge_dimension_node>
   */
  procedure merge_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type,
    p_ddn_ddi_id in dac_dimension_nodes_v.ddn_ddi_id%type,
    p_ddn_ddn_id in dac_dimension_nodes_v.ddn_ddn_id%type,
    p_ddn_name in dac_dimension_nodes_v.ddn_name%type,
    p_ddn_description in dac_dimension_nodes_v.ddn_description%type,
    p_ddn_active in dac_dimension_nodes_v.ddn_active%type,
    p_ddn_display_sequence in dac_dimension_nodes_v.ddn_display_sequence%type)
  as
  begin
    pit.enter_mandatory('merge_dimension_node',
      p_params => msg_params(msg_param('p_ddn_id', p_ddn_id)));

    pit_admin.merge_translatable_item(
      p_pti_id => p_ddn_id,
      p_pti_pml_name => pit_util.C_DEFAULT_LANGUAGE,
      p_pti_pmg_name => C_PMG_NAME,
      p_pti_name => p_ddn_name,
      p_pti_description => p_ddn_description);

    merge into dac_dimension_nodes t
    using (select p_ddn_id ddn_id,
                  p_ddn_ddi_id ddn_ddi_id,
                  p_ddn_ddn_id ddn_ddn_id,
                  p_ddn_active ddn_active,
                  p_ddn_display_sequence ddn_display_sequence
             from dual) s
       on (t.ddn_id = s.ddn_id)
     when matched then update set
          t.ddn_ddi_id = s.ddn_ddi_id,
          t.ddn_ddn_id = s.ddn_ddn_id,
          t.ddn_active = s.ddn_active,
          t.ddn_display_sequence = s.ddn_display_sequence,
          t.ddn_updated_at = systimestamp
     when not matched then insert(
          ddn_id, ddn_ddi_id, ddn_ddn_id, ddn_active, ddn_display_sequence)
          values(
          s.ddn_id, s.ddn_ddi_id, s.ddn_ddn_id, s.ddn_active, s.ddn_display_sequence);

    pit.leave_mandatory;
  end merge_dimension_node;


  /**
    Procedure: merge_dimension_node
      See: <DAC_ADMIN.merge_dimension_node>
   */
  procedure merge_dimension_node(
    p_row in dac_dimension_nodes_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_dimension_node');
    validate_dimension_node(p_row);
    merge_dimension_node(
      p_ddn_id => p_row.ddn_id,
      p_ddn_ddi_id => p_row.ddn_ddi_id,
      p_ddn_ddn_id => p_row.ddn_ddn_id,
      p_ddn_name => p_row.ddn_name,
      p_ddn_description => p_row.ddn_description,
      p_ddn_active => p_row.ddn_active,
      p_ddn_display_sequence => p_row.ddn_display_sequence);
    pit.leave_mandatory;
  end merge_dimension_node;


  /**
    Procedure: delete_dimension_node
      See: <DAC_ADMIN.delete_dimension_node>
   */
  procedure delete_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type)
  as
  begin
    pit.enter_mandatory('delete_dimension_node',
      p_params => msg_params(msg_param('p_ddn_id', p_ddn_id)));

    delete from dac_dimension_nodes
     where ddn_id = p_ddn_id;

    pit_admin.delete_translatable_item(
      p_pti_id => p_ddn_id,
      p_pti_pmg_name => C_PMG_NAME);

    pit.leave_mandatory;
  end delete_dimension_node;


  /**
    Procedure: validate_entity_node_assignment
      See: <DAC_ADMIN.validate_entity_node_assignment>
   */
  procedure validate_entity_node_assignment(
    p_row in dac_entity_node_assignments_v%rowtype)
  as
  begin
    pit.enter_mandatory('validate_entity_node_assignment');

    if coalesce(p_row.dena_valid_from, date '1900-01-01') > coalesce(p_row.dena_valid_to, date '9999-12-31') then
      pit.raise_error(
        p_message_name => msg.DAC_INVALID_VALIDITY_BAND,
        p_msg_args => msg_args('DAC_ENTITY_NODE_ASSIGNMENTS'));
    end if;

    pit.leave_mandatory;
  end validate_entity_node_assignment;


  /**
    Procedure: merge_entity_node_assignment
      See: <DAC_ADMIN.merge_entity_node_assignment>
   */
  procedure merge_entity_node_assignment(
    p_dena_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_dena_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type,
    p_dena_valid_from in dac_entity_node_assignments_v.dena_valid_from%type,
    p_dena_valid_to in dac_entity_node_assignments_v.dena_valid_to%type,
    p_dena_active in dac_entity_node_assignments_v.dena_active%type)
  as
    l_dena_valid_from dac_entity_node_assignments_v.dena_valid_from%type := coalesce(p_dena_valid_from, date '1900-01-01');
    l_dena_valid_to dac_entity_node_assignments_v.dena_valid_to%type := coalesce(p_dena_valid_to, date '9999-12-31');
  begin
    pit.enter_mandatory('merge_entity_node_assignment',
      p_params => msg_params(
                    msg_param('p_dena_den_id', p_dena_den_id),
                    msg_param('p_dena_ddn_id', p_dena_ddn_id)));

    if l_dena_valid_from > l_dena_valid_to then
      pit.raise_error(
        p_message_name => msg.DAC_INVALID_VALIDITY_BAND,
        p_msg_args => msg_args('DAC_ENTITY_NODE_ASSIGNMENTS'));
    end if;

    merge into dac_entity_node_assignments t
    using (select p_dena_den_id dena_den_id,
                  p_dena_ddn_id dena_ddn_id,
                  l_dena_valid_from dena_valid_from,
                  l_dena_valid_to dena_valid_to,
                  p_dena_active dena_active
             from dual) s
       on (t.dena_den_id = s.dena_den_id
       and t.dena_ddn_id = s.dena_ddn_id)
     when matched then update set
          t.dena_valid_from = s.dena_valid_from,
          t.dena_valid_to = s.dena_valid_to,
          t.dena_active = s.dena_active,
          t.dena_updated_at = systimestamp
     when not matched then insert(
          dena_den_id, dena_ddn_id, dena_valid_from, dena_valid_to, dena_active)
          values(
          s.dena_den_id, s.dena_ddn_id, s.dena_valid_from, s.dena_valid_to, s.dena_active);

    pit.leave_mandatory;
  end merge_entity_node_assignment;


  /**
    Procedure: merge_entity_node_assignment
      See: <DAC_ADMIN.merge_entity_node_assignment>
   */
  procedure merge_entity_node_assignment(
    p_row in dac_entity_node_assignments_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_entity_node_assignment');
    validate_entity_node_assignment(p_row);
    merge_entity_node_assignment(
      p_dena_den_id => p_row.dena_den_id,
      p_dena_ddn_id => p_row.dena_ddn_id,
      p_dena_valid_from => p_row.dena_valid_from,
      p_dena_valid_to => p_row.dena_valid_to,
      p_dena_active => p_row.dena_active);
    pit.leave_mandatory;
  end merge_entity_node_assignment;


  /**
    Procedure: delete_entity_node_assignment
      See: <DAC_ADMIN.delete_entity_node_assignment>
   */
  procedure delete_entity_node_assignment(
    p_dena_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_dena_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type)
  as
  begin
    pit.enter_mandatory('delete_entity_node_assignment',
      p_params => msg_params(
                    msg_param('p_dena_den_id', p_dena_den_id),
                    msg_param('p_dena_ddn_id', p_dena_ddn_id)));

    delete from dac_entity_node_assignments
     where dena_den_id = p_dena_den_id
       and dena_ddn_id = p_dena_ddn_id;

    pit.leave_mandatory;
  end delete_entity_node_assignment;


  /**
    Procedure: refresh_effective_accesses
      See: <DAC_ADMIN.refresh_effective_accesses>
   */
  procedure refresh_effective_accesses
  as
  begin
    pit.enter_mandatory('refresh_effective_accesses');

    dbms_mview.refresh(
      list => 'DAC_EFFECTIVE_ACCESSES,DAC_EFFECTIVE_ACCESS_REASONS',
      method => 'C',
      atomic_refresh => true);

    pit.leave_mandatory;
  end refresh_effective_accesses;

end dac_admin;
/
