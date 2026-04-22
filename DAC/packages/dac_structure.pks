create or replace package dac_structure
authid definer
as
  /**
    Package: DAC_STRUCTURE
      Business API for maintaining the structural model of Dimensional Access Control.
   */

  /**
    Procedure: merge_entity_type
      Creates or updates an entity type.

    Parameters:
      p_row - Entity type access view row. Only local table columns and translatable text columns are used.

    Errors:
      Raises PIT, translation, and database constraint errors from <DAC_ADMIN.merge_entity_type>.
   */
  procedure merge_entity_type(
    p_row in dac_entity_types_v%rowtype);

  /**
    Procedure: merge_entity
      Creates or updates a matrix participant entity.

    Parameters:
      p_row - Entity access view row. Enriched entity type columns are ignored for writes.

    Errors:
      Raises foreign key and database constraint errors from <DAC_ADMIN.merge_entity>.
   */
  procedure merge_entity(
    p_row in dac_entities_v%rowtype);

  /**
    Procedure: merge_dimension
      Creates or updates a dimension.

    Parameters:
      p_row - Dimension access view row. Only local table columns and translatable text columns are used.

    Errors:
      Raises PIT, translation, and database constraint errors from <DAC_ADMIN.merge_dimension>.
   */
  procedure merge_dimension(
    p_row in dac_dimensions_v%rowtype);

  /**
    Procedure: merge_dimension_node
      Creates or updates a dimension node.

    Parameters:
      p_row - Dimension node access view row. Enriched parent and dimension columns are ignored for writes.

    Errors:
      Raises PIT, translation, foreign key, hierarchy, and database constraint errors from <DAC_ADMIN.merge_dimension_node>.
   */
  procedure merge_dimension_node(
    p_row in dac_dimension_nodes_v%rowtype);

  /**
    Procedure: move_dimension_node
      Moves an existing dimension node below a new parent or to the root level.

    Parameters:
      p_ddn_id - Technical dimension node ID to move.
      p_new_ddn_id - New parent dimension node ID. Null moves the node to the root level.
      p_ddn_display_sequence - Optional new display order. If omitted, the current display order is retained.

    Errors:
      Raises a PIT error if the node does not exist, if the new parent is in another dimension,
      or if the new parent is the node itself or one of its descendants. Also raises errors from <DAC_ADMIN.merge_dimension_node>.
   */
  procedure move_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type,
    p_new_ddn_id in dac_dimension_nodes_v.ddn_ddn_id%type,
    p_ddn_display_sequence in dac_dimension_nodes_v.ddn_display_sequence%type default null);

  /**
    Procedure: deactivate_entity
      Marks an entity inactive.

    Parameters:
      p_den_id - Technical entity ID to deactivate.

    Errors:
      Raises a PIT error if the entity does not exist. Also raises errors from <DAC_ADMIN.merge_entity>.
   */
  procedure deactivate_entity(
    p_den_id in dac_entities_v.den_id%type);

  /**
    Procedure: deactivate_dimension_node
      Marks a dimension node inactive.

    Parameters:
      p_ddn_id - Technical dimension node ID to deactivate.

    Errors:
      Raises a PIT error if the node does not exist. Also raises errors from <DAC_ADMIN.merge_dimension_node>.
   */
  procedure deactivate_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type);

end dac_structure;
/
