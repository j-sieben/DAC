create or replace package body dac_assignments
as
  /**
    Package: DAC_ASSIGNMENTS Body
      Business API for maintaining positive entity assignments in the Dimensional Access Control matrix.
   */

  /**
    Procedure: delete_assignments
      Deletes assignments matching entity, node, and optionally dimension.
   */
  procedure delete_assignments(
    p_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type default null,
    p_ddi_id in dac_dimension_nodes_v.ddn_ddi_id%type default null)
  as
  begin
    for rec in (
      select dena_den_id,
             dena_ddn_id
        from dac_entity_node_assignments_v
       where dena_den_id = p_den_id
         and (p_ddn_id is null or dena_ddn_id = p_ddn_id)
         and (p_ddi_id is null or dena_ddn_ddi_id = p_ddi_id)
    )
    loop
      dac_admin.delete_entity_node_assignment(
        p_dena_den_id => rec.dena_den_id,
        p_dena_ddn_id => rec.dena_ddn_id);
    end loop;
  end delete_assignments;


  /**
    Procedure: validate_node_dimension
      Checks that a dimension node belongs to a dimension.
   */
  procedure validate_node_dimension(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type,
    p_ddi_id in dac_dimension_nodes_v.ddn_ddi_id%type)
  as
    l_count pls_integer;
  begin
    select count(*)
      into l_count
      from dac_dimension_nodes_v
     where ddn_id = p_ddn_id
       and ddn_ddi_id = p_ddi_id;

    if l_count = 0 then
      pit.raise_error(
        p_message_name => msg.DAC_DIMENSION_NODE_NOT_IN_DIMENSION,
        p_msg_args => msg_args(p_ddn_id, p_ddi_id));
    end if;
  end validate_node_dimension;


  /**
    Procedure: assign_entity
      See: <DAC_ASSIGNMENTS.assign_entity>
   */
  procedure assign_entity(
    p_row in dac_entity_node_assignments_v%rowtype)
  as
  begin
    pit.enter_mandatory('assign_entity',
      p_params => msg_params(
                    msg_param('p_row.dena_den_id', p_row.dena_den_id),
                    msg_param('p_row.dena_ddn_id', p_row.dena_ddn_id)));

    dac_admin.merge_entity_node_assignment(p_row);

    pit.leave_mandatory;
  end assign_entity;


  /**
    Procedure: remove_assignment
      See: <DAC_ASSIGNMENTS.remove_assignment>
   */
  procedure remove_assignment(
    p_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type)
  as
  begin
    pit.enter_mandatory('remove_assignment',
      p_params => msg_params(
                    msg_param('p_den_id', p_den_id),
                    msg_param('p_ddn_id', p_ddn_id)));

    delete_assignments(
      p_den_id => p_den_id,
      p_ddn_id => p_ddn_id);

    pit.leave_mandatory;
  end remove_assignment;


  /**
    Procedure: remove_entity_from_node
      See: <DAC_ASSIGNMENTS.remove_entity_from_node>
   */
  procedure remove_entity_from_node(
    p_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type)
  as
  begin
    pit.enter_mandatory('remove_entity_from_node',
      p_params => msg_params(
                    msg_param('p_den_id', p_den_id),
                    msg_param('p_ddn_id', p_ddn_id)));

    delete_assignments(
      p_den_id => p_den_id,
      p_ddn_id => p_ddn_id);

    pit.leave_mandatory;
  end remove_entity_from_node;


  /**
    Procedure: replace_entity_assignments
      See: <DAC_ASSIGNMENTS.replace_entity_assignments>
   */
  procedure replace_entity_assignments(
    p_row in dac_entity_node_assignments_v%rowtype,
    p_ddi_id in dac_dimension_nodes_v.ddn_ddi_id%type)
  as
  begin
    pit.enter_mandatory('replace_entity_assignments',
      p_params => msg_params(
                    msg_param('p_row.dena_den_id', p_row.dena_den_id),
                    msg_param('p_ddi_id', p_ddi_id),
                    msg_param('p_row.dena_ddn_id', p_row.dena_ddn_id)));

    validate_node_dimension(
      p_ddn_id => p_row.dena_ddn_id,
      p_ddi_id => p_ddi_id);

    delete_assignments(
      p_den_id => p_row.dena_den_id,
      p_ddi_id => p_ddi_id);

    dac_admin.merge_entity_node_assignment(p_row);

    pit.leave_mandatory;
  end replace_entity_assignments;


  /**
    Procedure: copy_entity_assignments
      See: <DAC_ASSIGNMENTS.copy_entity_assignments>
   */
  procedure copy_entity_assignments(
    p_source_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_target_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_replace_existing in varchar2)
  as
    l_row dac_entity_node_assignments_v%rowtype;
  begin
    pit.enter_mandatory('copy_entity_assignments',
      p_params => msg_params(
                    msg_param('p_source_den_id', p_source_den_id),
                    msg_param('p_target_den_id', p_target_den_id),
                    msg_param('p_replace_existing', p_replace_existing)));

    if p_replace_existing = pit_util.C_TRUE then
      delete_assignments(
        p_den_id => p_target_den_id);
    end if;

    for rec in (
      select dena_ddn_id,
             dena_valid_from,
             dena_valid_to
        from dac_entity_node_assignments_v
       where dena_den_id = p_source_den_id
         and dena_active = pit_util.C_TRUE
    )
    loop
      l_row.dena_den_id := p_target_den_id;
      l_row.dena_ddn_id := rec.dena_ddn_id;
      l_row.dena_valid_from := rec.dena_valid_from;
      l_row.dena_valid_to := rec.dena_valid_to;
      l_row.dena_active := pit_util.C_TRUE;

      dac_admin.merge_entity_node_assignment(l_row);
    end loop;

    pit.leave_mandatory;
  end copy_entity_assignments;

end dac_assignments;
/
