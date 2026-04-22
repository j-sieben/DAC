create or replace package dac_assignments
authid definer
as
  /**
    Package: DAC_ASSIGNMENTS
      Business API for maintaining positive entity assignments in the Dimensional Access Control matrix.
   */

  /**
    Procedure: assign_entity
      Creates or updates an entity-node assignment.

    Parameters:
      p_row - Entity-node assignment access view row.

    Errors:
      Raises foreign key, date range, uniqueness, and database constraint errors from <DAC_ADMIN.merge_entity_node_assignment>.
   */
  procedure assign_entity(
    p_row in dac_entity_node_assignments_v%rowtype);

  /**
    Procedure: remove_assignment
      Removes an entity assignment from one dimension node.

    Parameters:
      p_den_id - Entity ID whose assignment is removed.
      p_ddn_id - Dimension node ID whose assignment is removed.

    Errors:
      Raises database errors from <DAC_ADMIN.delete_entity_node_assignment>.
   */
  procedure remove_assignment(
    p_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type);

  /**
    Procedure: remove_entity_from_node
      Removes an entity assignment from one dimension node.

    Parameters:
      p_den_id - Entity ID whose assignment is removed.
      p_ddn_id - Dimension node ID whose assignment is removed.

    Errors:
      Raises database errors from <DAC_ADMIN.delete_entity_node_assignment>.
   */
  procedure remove_entity_from_node(
    p_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type);

  /**
    Procedure: replace_entity_assignments
      Removes all assignments for an entity in a dimension and assigns the entity to one node.

    Parameters:
      p_row - Entity-node assignment access view row containing the new entity, node, and validity period.
      p_ddi_id - Dimension ID whose assignments are replaced.

    Errors:
      Raises a PIT error if the new node does not belong to the requested dimension.
      Also raises errors from <DAC_ADMIN.delete_entity_node_assignment> and <DAC_ADMIN.merge_entity_node_assignment>.
   */
  procedure replace_entity_assignments(
    p_row in dac_entity_node_assignments_v%rowtype,
    p_ddi_id in dac_dimension_nodes_v.ddn_ddi_id%type);

  /**
    Procedure: copy_entity_assignments
      Copies all active assignments from one entity to another entity.

    Parameters:
      p_source_den_id - Source entity ID.
      p_target_den_id - Target entity ID.
      p_replace_existing - Flag indicating whether existing target assignments are removed before copying.

    Errors:
      Raises database errors from <DAC_ADMIN.delete_entity_node_assignment> and <DAC_ADMIN.merge_entity_node_assignment>.
   */
  procedure copy_entity_assignments(
    p_source_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_target_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_replace_existing in varchar2 default pit_util.C_FALSE);

end dac_assignments;
/
