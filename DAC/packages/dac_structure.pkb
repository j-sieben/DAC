create or replace package body dac_structure
as
  /**
    Package: DAC_STRUCTURE Body
      Business API for maintaining the structural model of Dimensional Access Control.
   */

  /**
    Procedure: merge_entity_type
      See: <DAC_STRUCTURE.merge_entity_type>
   */
  procedure merge_entity_type(
    p_row in dac_entity_types_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_entity_type',
      p_params => msg_params(msg_param('p_row.det_id', p_row.det_id)));

    dac_admin.merge_entity_type(p_row);

    pit.leave_mandatory;
  end merge_entity_type;


  /**
    Procedure: merge_entity
      See: <DAC_STRUCTURE.merge_entity>
   */
  procedure merge_entity(
    p_row in dac_entities_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_entity',
      p_params => msg_params(msg_param('p_row.den_id', p_row.den_id)));

    dac_admin.merge_entity(p_row);

    pit.leave_mandatory;
  end merge_entity;


  /**
    Procedure: merge_dimension
      See: <DAC_STRUCTURE.merge_dimension>
   */
  procedure merge_dimension(
    p_row in dac_dimensions_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_dimension',
      p_params => msg_params(msg_param('p_row.ddi_id', p_row.ddi_id)));

    dac_admin.merge_dimension(p_row);

    pit.leave_mandatory;
  end merge_dimension;


  /**
    Procedure: merge_dimension_node
      See: <DAC_STRUCTURE.merge_dimension_node>
   */
  procedure merge_dimension_node(
    p_row in dac_dimension_nodes_v%rowtype)
  as
  begin
    pit.enter_mandatory('merge_dimension_node',
      p_params => msg_params(msg_param('p_row.ddn_id', p_row.ddn_id)));

    dac_admin.merge_dimension_node(p_row);

    pit.leave_mandatory;
  end merge_dimension_node;


  /**
    Procedure: move_dimension_node
      See: <DAC_STRUCTURE.move_dimension_node>
   */
  procedure move_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type,
    p_new_ddn_id in dac_dimension_nodes_v.ddn_ddn_id%type,
    p_ddn_display_sequence in dac_dimension_nodes_v.ddn_display_sequence%type)
  as
    l_node dac_dimension_nodes_v%rowtype;
    l_parent dac_dimension_nodes_v%rowtype;
    l_descendant_count pls_integer;
  begin
    pit.enter_mandatory('move_dimension_node',
      p_params => msg_params(
                    msg_param('p_ddn_id', p_ddn_id),
                    msg_param('p_new_ddn_id', p_new_ddn_id)));

    begin
      select *
        into l_node
        from dac_dimension_nodes_v
       where ddn_id = p_ddn_id;
    exception
      when no_data_found then
        pit.raise_error(
          p_message_name => msg.DAC_DIMENSION_NODE_NOT_FOUND,
          p_msg_args => msg_args(p_ddn_id));
    end;

    if p_new_ddn_id is not null then
      if p_new_ddn_id = p_ddn_id then
        pit.raise_error(
          p_message_name => msg.DAC_DIMENSION_NODE_PARENT_SELF);
      end if;

      begin
        select *
          into l_parent
          from dac_dimension_nodes_v
         where ddn_id = p_new_ddn_id;
      exception
        when no_data_found then
          pit.raise_error(
            p_message_name => msg.DAC_PARENT_DIMENSION_NODE_NOT_FOUND,
            p_msg_args => msg_args(p_new_ddn_id));
      end;

      if l_parent.ddn_ddi_id <> l_node.ddn_ddi_id then
        pit.raise_error(
          p_message_name => msg.DAC_DIMENSION_NODE_PARENT_OTHER_DIMENSION);
      end if;

      select count(*)
        into l_descendant_count
        from (
          select ddn_id
            from dac_dimension_nodes_v
           start with ddn_id = p_ddn_id
         connect by nocycle prior ddn_id = ddn_ddn_id
                and prior ddn_ddi_id = ddn_ddi_id
        )
       where ddn_id = p_new_ddn_id;

      if l_descendant_count > 0 then
        pit.raise_error(
          p_message_name => msg.DAC_DIMENSION_NODE_PARENT_DESCENDANT);
      end if;
    end if;

    l_node.ddn_ddn_id := p_new_ddn_id;
    l_node.ddn_display_sequence := coalesce(p_ddn_display_sequence, l_node.ddn_display_sequence);

    dac_admin.merge_dimension_node(l_node);

    pit.leave_mandatory;
  end move_dimension_node;


  /**
    Procedure: deactivate_entity
      See: <DAC_STRUCTURE.deactivate_entity>
   */
  procedure deactivate_entity(
    p_den_id in dac_entities_v.den_id%type)
  as
    l_entity dac_entities_v%rowtype;
  begin
    pit.enter_mandatory('deactivate_entity',
      p_params => msg_params(msg_param('p_den_id', p_den_id)));

    begin
      select *
        into l_entity
        from dac_entities_v
       where den_id = p_den_id;
    exception
      when no_data_found then
        pit.raise_error(
          p_message_name => msg.DAC_ENTITY_NOT_FOUND,
          p_msg_args => msg_args(p_den_id));
    end;

    l_entity.den_active := pit_util.C_FALSE;

    dac_admin.merge_entity(l_entity);

    pit.leave_mandatory;
  end deactivate_entity;


  /**
    Procedure: deactivate_dimension_node
      See: <DAC_STRUCTURE.deactivate_dimension_node>
   */
  procedure deactivate_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type)
  as
    l_node dac_dimension_nodes_v%rowtype;
  begin
    pit.enter_mandatory('deactivate_dimension_node',
      p_params => msg_params(msg_param('p_ddn_id', p_ddn_id)));

    begin
      select *
        into l_node
        from dac_dimension_nodes_v
       where ddn_id = p_ddn_id;
    exception
      when no_data_found then
        pit.raise_error(
          p_message_name => msg.DAC_DIMENSION_NODE_NOT_FOUND,
          p_msg_args => msg_args(p_ddn_id));
    end;

    l_node.ddn_active := pit_util.C_FALSE;

    dac_admin.merge_dimension_node(l_node);

    pit.leave_mandatory;
  end deactivate_dimension_node;

end dac_structure;
/
