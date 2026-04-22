create or replace package dac_admin
authid definer
as
  /**
    Package: DAC_ADMIN
      Administrative API for dimensional access control master data and assignments.
   */

  C_PMG_NAME constant varchar2(128) := 'DAC';

  /**
    Procedure: validate_match_state
      Validates a match state row.

    Parameters:
      p_row - Match state access view row to validate.

    Errors:
      Raises validation errors once match state rules are implemented.
   */
  procedure validate_match_state(
    p_row in dac_match_states_v%rowtype);

  /**
    Procedure: merge_match_state
      Creates or updates a match state and its translatable text.

    Parameters:
      p_dms_id - Technical match state ID.
      p_dms_name - Translated match state name for the default language.
      p_dms_description - Translated match state description for the default language.
      p_dms_display_sequence - Display order of the match state.
      p_dms_active - Flag indicating whether the match state is active.

    Errors:
      Raises PIT errors from <PIT_ADMIN.merge_translatable_item> and database constraint errors from <DAC_MATCH_STATES>.
   */
  procedure merge_match_state(
    p_dms_id in dac_match_states_v.dms_id%type,
    p_dms_name in dac_match_states_v.dms_name%type,
    p_dms_description in dac_match_states_v.dms_description%type,
    p_dms_display_sequence in dac_match_states_v.dms_display_sequence%type default 10,
    p_dms_active in dac_match_states_v.dms_active%type default pit_util.C_TRUE);

  /**
    Procedure: merge_match_state
      Creates or updates a match state from an access view row.

    Parameters:
      p_row - Match state access view row. Only local table columns and translatable text columns are used.

    Errors:
      Raises validation errors, PIT errors from <PIT_ADMIN.merge_translatable_item>, and database constraint errors from <DAC_MATCH_STATES>.
   */
  procedure merge_match_state(
    p_row in dac_match_states_v%rowtype);

  /**
    Procedure: delete_match_state
      Deletes a match state and its translatable text.

    Parameters:
      p_dms_id - Technical match state ID to delete.

    Errors:
      Raises foreign key errors if the match state is still referenced, and PIT errors from <PIT_ADMIN.delete_translatable_item>.
   */
  procedure delete_match_state(
    p_dms_id in dac_match_states_v.dms_id%type);

  /**
    Procedure: validate_entity_type
      Validates an entity type row.

    Parameters:
      p_row - Entity type access view row to validate.

    Errors:
      Raises validation errors once entity type rules are implemented.
   */
  procedure validate_entity_type(
    p_row in dac_entity_types_v%rowtype);

  /**
    Procedure: merge_entity_type
      Creates or updates an entity type and its translatable text.

    Parameters:
      p_det_id - Technical entity type ID.
      p_det_name - Translated entity type name for the default language.
      p_det_description - Translated entity type description for the default language.
      p_det_is_subject - Flag indicating whether entities of this type can be access subjects.
      p_det_active - Flag indicating whether the entity type is active.
      p_det_display_sequence - Display order of the entity type.

    Errors:
      Raises PIT errors from <PIT_ADMIN.merge_translatable_item> and database constraint errors from <DAC_ENTITY_TYPES>.
   */
  procedure merge_entity_type(
    p_det_id in dac_entity_types_v.det_id%type,
    p_det_name in dac_entity_types_v.det_name%type,
    p_det_description in dac_entity_types_v.det_description%type,
    p_det_is_subject in dac_entity_types_v.det_is_subject%type default pit_util.C_FALSE,
    p_det_active in dac_entity_types_v.det_active%type default pit_util.C_TRUE,
    p_det_display_sequence in dac_entity_types_v.det_display_sequence%type default 10);

  /**
    Procedure: merge_entity_type
      Creates or updates an entity type from an access view row.

    Parameters:
      p_row - Entity type access view row. Only local table columns and translatable text columns are used.

    Errors:
      Raises validation errors, PIT errors from <PIT_ADMIN.merge_translatable_item>, and database constraint errors from <DAC_ENTITY_TYPES>.
   */
  procedure merge_entity_type(
    p_row in dac_entity_types_v%rowtype);

  /**
    Procedure: delete_entity_type
      Deletes an entity type and its translatable text.

    Parameters:
      p_det_id - Technical entity type ID to delete.

    Errors:
      Raises foreign key errors if the entity type is still referenced, and PIT errors from <PIT_ADMIN.delete_translatable_item>.
   */
  procedure delete_entity_type(
    p_det_id in dac_entity_types_v.det_id%type);

  /**
    Procedure: validate_entity
      Validates an entity row.

    Parameters:
      p_row - Entity access view row to validate.

    Errors:
      Raises <MSG.DAC_INVALID_VALIDITY_BAND> if the entity validity band is inverted.
   */
  procedure validate_entity(
    p_row in dac_entities_v%rowtype);

  /**
    Procedure: merge_entity
      Creates or updates a matrix participant entity.

    Parameters:
      p_den_id - Technical entity ID.
      p_den_det_id - Entity type ID.
      p_den_external_id - Stable technical identifier in the owning application context.
      p_den_display_name - Display name of the entity.
      p_den_description - Optional description of the entity.
      p_den_active_from - Start date for entity validity.
      p_den_active_to - End date for entity validity.
      p_den_active - Flag indicating whether the entity is active.

    Errors:
      Applies default validity limits for null date boundaries. Raises <MSG.DAC_INVALID_VALIDITY_BAND>, foreign key errors for unknown entity types, and database constraint errors from <DAC_ENTITIES>.
   */
  procedure merge_entity(
    p_den_id in dac_entities_v.den_id%type,
    p_den_det_id in dac_entities_v.den_det_id%type,
    p_den_external_id in dac_entities_v.den_external_id%type,
    p_den_display_name in dac_entities_v.den_display_name%type,
    p_den_description in dac_entities_v.den_description%type default null,
    p_den_active_from in dac_entities_v.den_active_from%type default date '1900-01-01',
    p_den_active_to in dac_entities_v.den_active_to%type default date '9999-12-31',
    p_den_active in dac_entities_v.den_active%type default pit_util.C_TRUE);

  /**
    Procedure: merge_entity
      Creates or updates a matrix participant entity from an access view row.

    Parameters:
      p_row - Entity access view row. Enriched entity type columns are ignored for writes.

    Errors:
      Applies default validity limits for null date boundaries. Raises <MSG.DAC_INVALID_VALIDITY_BAND>, foreign key errors for unknown entity types, and database constraint errors from <DAC_ENTITIES>.
   */
  procedure merge_entity(
    p_row in dac_entities_v%rowtype);

  /**
    Procedure: delete_entity
      Deletes a matrix participant entity.

    Parameters:
      p_den_id - Technical entity ID to delete.

    Errors:
      Raises foreign key errors if the entity is still referenced outside cascaded dependencies.
   */
  procedure delete_entity(
    p_den_id in dac_entities_v.den_id%type);

  /**
    Procedure: validate_dimension
      Validates a dimension row.

    Parameters:
      p_row - Dimension access view row to validate.

    Errors:
      Raises validation errors once dimension rules are implemented.
   */
  procedure validate_dimension(
    p_row in dac_dimensions_v%rowtype);

  /**
    Procedure: merge_dimension
      Creates or updates a dimension and its translatable text.

    Parameters:
      p_ddi_id - Technical dimension ID.
      p_ddi_name - Translated dimension name for the default language.
      p_ddi_description - Translated dimension description for the default language.
      p_ddi_is_restrictive - Flag indicating whether target assignments restrict access.
      p_ddi_is_filter - Flag indicating whether the dimension provides filter values.
      p_ddi_active - Flag indicating whether the dimension is active.
      p_ddi_display_sequence - Display order of the dimension.

    Errors:
      Raises PIT errors from <PIT_ADMIN.merge_translatable_item> and database constraint errors from <DAC_DIMENSIONS>.
   */
  procedure merge_dimension(
    p_ddi_id in dac_dimensions_v.ddi_id%type,
    p_ddi_name in dac_dimensions_v.ddi_name%type,
    p_ddi_description in dac_dimensions_v.ddi_description%type,
    p_ddi_is_restrictive in dac_dimensions_v.ddi_is_restrictive%type default pit_util.C_FALSE,
    p_ddi_is_filter in dac_dimensions_v.ddi_is_filter%type default pit_util.C_FALSE,
    p_ddi_active in dac_dimensions_v.ddi_active%type default pit_util.C_TRUE,
    p_ddi_display_sequence in dac_dimensions_v.ddi_display_sequence%type default 10);

  /**
    Procedure: merge_dimension
      Creates or updates a dimension from an access view row.

    Parameters:
      p_row - Dimension access view row. Only local table columns and translatable text columns are used.

    Errors:
      Raises validation errors, PIT errors from <PIT_ADMIN.merge_translatable_item>, and database constraint errors from <DAC_DIMENSIONS>.
   */
  procedure merge_dimension(
    p_row in dac_dimensions_v%rowtype);

  /**
    Procedure: delete_dimension
      Deletes a dimension and its translatable text.

    Parameters:
      p_ddi_id - Technical dimension ID to delete.

    Errors:
      Raises foreign key errors if the dimension is still referenced outside cascaded dependencies, and PIT errors from <PIT_ADMIN.delete_translatable_item>.
   */
  procedure delete_dimension(
    p_ddi_id in dac_dimensions_v.ddi_id%type);

  /**
    Procedure: validate_dimension_node
      Validates a dimension node row.

    Parameters:
      p_row - Dimension node access view row to validate.

    Errors:
      Raises validation errors once dimension node rules are implemented.
   */
  procedure validate_dimension_node(
    p_row in dac_dimension_nodes_v%rowtype);

  /**
    Procedure: merge_dimension_node
      Creates or updates a dimension node and its translatable text.

    Parameters:
      p_ddn_id - Technical dimension node ID.
      p_ddn_ddi_id - Dimension ID the node belongs to.
      p_ddn_ddn_id - Parent dimension node ID. Null indicates a root node.
      p_ddn_name - Translated dimension node name for the default language.
      p_ddn_description - Translated dimension node description for the default language.
      p_ddn_active - Flag indicating whether the dimension node is active.
      p_ddn_display_sequence - Display order of the dimension node within its context.

    Errors:
      Raises PIT errors from <PIT_ADMIN.merge_translatable_item>, foreign key errors for unknown dimensions or parent nodes, self-parent check errors, and database constraint errors from <DAC_DIMENSION_NODES>.
   */
  procedure merge_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type,
    p_ddn_ddi_id in dac_dimension_nodes_v.ddn_ddi_id%type,
    p_ddn_ddn_id in dac_dimension_nodes_v.ddn_ddn_id%type,
    p_ddn_name in dac_dimension_nodes_v.ddn_name%type,
    p_ddn_description in dac_dimension_nodes_v.ddn_description%type,
    p_ddn_active in dac_dimension_nodes_v.ddn_active%type default pit_util.C_TRUE,
    p_ddn_display_sequence in dac_dimension_nodes_v.ddn_display_sequence%type default 10);

  /**
    Procedure: merge_dimension_node
      Creates or updates a dimension node from an access view row.

    Parameters:
      p_row - Dimension node access view row. Enriched parent and dimension columns are ignored for writes.

    Errors:
      Raises validation errors, PIT errors from <PIT_ADMIN.merge_translatable_item>, foreign key errors for unknown dimensions or parent nodes, self-parent check errors, and database constraint errors from <DAC_DIMENSION_NODES>.
   */
  procedure merge_dimension_node(
    p_row in dac_dimension_nodes_v%rowtype);

  /**
    Procedure: delete_dimension_node
      Deletes a dimension node and its translatable text.

    Parameters:
      p_ddn_id - Technical dimension node ID to delete.

    Errors:
      Raises foreign key errors if the dimension node is still referenced outside cascaded dependencies, and PIT errors from <PIT_ADMIN.delete_translatable_item>.
   */
  procedure delete_dimension_node(
    p_ddn_id in dac_dimension_nodes_v.ddn_id%type);

  /**
    Procedure: validate_entity_node_assignment
      Validates an entity-node assignment row.

    Parameters:
      p_row - Entity-node assignment access view row to validate.

    Errors:
      Raises <MSG.DAC_INVALID_VALIDITY_BAND> if the assignment validity band is inverted.
   */
  procedure validate_entity_node_assignment(
    p_row in dac_entity_node_assignments_v%rowtype);

  /**
    Procedure: merge_entity_node_assignment
      Creates or updates an assignment locating an entity in a dimension node.

    Parameters:
      p_dena_den_id - Entity ID to locate in the matrix.
      p_dena_ddn_id - Dimension node ID assigned to the entity.
      p_dena_valid_from - Start date for assignment validity.
      p_dena_valid_to - End date for assignment validity.
      p_dena_active - Flag indicating whether the assignment is active.

    Errors:
      Applies default validity limits for null date boundaries. Raises <MSG.DAC_INVALID_VALIDITY_BAND>, foreign key errors for unknown entities or dimension nodes, uniqueness errors, and database constraint errors from <DAC_ENTITY_NODE_ASSIGNMENTS>.
   */
  procedure merge_entity_node_assignment(
    p_dena_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_dena_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type,
    p_dena_valid_from in dac_entity_node_assignments_v.dena_valid_from%type default date '1900-01-01',
    p_dena_valid_to in dac_entity_node_assignments_v.dena_valid_to%type default date '9999-12-31',
    p_dena_active in dac_entity_node_assignments_v.dena_active%type default pit_util.C_TRUE);

  /**
    Procedure: merge_entity_node_assignment
      Creates or updates an entity-node assignment from an access view row.

    Parameters:
      p_row - Entity-node assignment access view row. Enriched entity, node, and dimension columns are ignored for writes.

    Errors:
      Applies default validity limits for null date boundaries. Raises <MSG.DAC_INVALID_VALIDITY_BAND>, foreign key errors for unknown entities or dimension nodes, uniqueness errors, and database constraint errors from <DAC_ENTITY_NODE_ASSIGNMENTS>.
   */
  procedure merge_entity_node_assignment(
    p_row in dac_entity_node_assignments_v%rowtype);

  /**
    Procedure: delete_entity_node_assignment
      Deletes an entity-node assignment.

    Parameters:
      p_dena_den_id - Entity ID whose assignment is deleted.
      p_dena_ddn_id - Dimension node ID whose assignment is deleted.

    Errors:
      Raises database constraint errors if the assignment is still referenced outside cascaded dependencies.
   */
  procedure delete_entity_node_assignment(
    p_dena_den_id in dac_entity_node_assignments_v.dena_den_id%type,
    p_dena_ddn_id in dac_entity_node_assignments_v.dena_ddn_id%type);

  /**
    Procedure: refresh_effective_accesses
      Publishes the current calculated access matrix by refreshing the effective access materialized views.

    Errors:
      Raises DBMS_MVIEW refresh errors.
   */
  procedure refresh_effective_accesses;

end dac_admin;
/
