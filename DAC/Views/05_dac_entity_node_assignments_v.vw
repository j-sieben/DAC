create or replace force view dac_entity_node_assignments_v as
select dena_den_id,
       den_display_name dena_den_display_name,
       den_det_id dena_den_det_id,
       den_det_name dena_den_det_name,
       dena_ddn_id,
       ddn_name dena_ddn_name,
       ddn_ddi_id dena_ddn_ddi_id,
       ddn_ddi_name dena_ddn_ddi_name,
       dena_valid_from,
       dena_valid_to,
       dena_active,
       dena_created_at,
       dena_updated_at
  from dac_entity_node_assignments
  join dac_entities_v
    on dena_den_id = den_id
  join dac_dimension_nodes_v
    on dena_ddn_id = ddn_id;

comment on table dac_entity_node_assignments_v is 'Read access view for entity-node assignments.';
comment on column dac_entity_node_assignments_v.dena_den_id is 'Foreign key to DAC_ENTITIES.';
comment on column dac_entity_node_assignments_v.dena_den_display_name is 'Display name of the assigned entity.';
comment on column dac_entity_node_assignments_v.dena_den_det_id is 'Entity type ID of the assigned entity.';
comment on column dac_entity_node_assignments_v.dena_den_det_name is 'Translated entity type name of the assigned entity.';
comment on column dac_entity_node_assignments_v.dena_ddn_id is 'Foreign key to DAC_DIMENSION_NODES.';
comment on column dac_entity_node_assignments_v.dena_ddn_name is 'Translated display name of the assigned dimension node.';
comment on column dac_entity_node_assignments_v.dena_ddn_ddi_id is 'Dimension ID of the assigned dimension node.';
comment on column dac_entity_node_assignments_v.dena_ddn_ddi_name is 'Translated dimension name of the assigned dimension node.';
comment on column dac_entity_node_assignments_v.dena_valid_from is 'Start date for assignment validity.';
comment on column dac_entity_node_assignments_v.dena_valid_to is 'End date for assignment validity.';
comment on column dac_entity_node_assignments_v.dena_active is 'Flag indicating whether the assignment is active.';
comment on column dac_entity_node_assignments_v.dena_created_at is 'Creation timestamp.';
comment on column dac_entity_node_assignments_v.dena_updated_at is 'Last update timestamp.';
