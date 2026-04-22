create or replace force view dac_dimension_nodes_v as
select dn.ddn_id,
       dn.ddn_ddi_id,
       ddi_name ddn_ddi_name,
       dn.ddn_ddn_id,
       pti_parent.pti_name ddn_ddn_name,
       pti_node.pti_name ddn_name,
       pti_node.pti_description ddn_description,
       dn.ddn_active,
       dn.ddn_display_sequence,
       dn.ddn_created_at,
       dn.ddn_updated_at
  from dac_dimension_nodes dn
  join pit_translatable_item_v pti_node
    on dn.ddn_id = pti_node.pti_id
   and dn.ddn_pgr_id = pti_node.pti_pmg_name
  join dac_dimensions_v
    on dn.ddn_ddi_id = ddi_id
  left join dac_dimension_nodes pn
    on dn.ddn_ddi_id = pn.ddn_ddi_id
   and dn.ddn_ddn_id = pn.ddn_id
  left join pit_translatable_item_v pti_parent
    on pn.ddn_id = pti_parent.pti_id
   and pn.ddn_pgr_id = pti_parent.pti_pmg_name;

comment on table dac_dimension_nodes_v is 'Read access view for hierarchical dimension nodes.';
comment on column dac_dimension_nodes_v.ddn_id is 'Primary key of the dimension node.';
comment on column dac_dimension_nodes_v.ddn_ddi_id is 'Foreign key to DAC_DIMENSIONS.';
comment on column dac_dimension_nodes_v.ddn_ddi_name is 'Translated display name of the dimension.';
comment on column dac_dimension_nodes_v.ddn_ddn_id is 'Foreign key to the parent DAC_DIMENSION_NODES row.';
comment on column dac_dimension_nodes_v.ddn_ddn_name is 'Translated display name of the parent dimension node.';
comment on column dac_dimension_nodes_v.ddn_name is 'Translated display name of the dimension node.';
comment on column dac_dimension_nodes_v.ddn_description is 'Translated description of the dimension node.';
comment on column dac_dimension_nodes_v.ddn_active is 'Flag indicating whether the node is active.';
comment on column dac_dimension_nodes_v.ddn_display_sequence is 'Display order of the node.';
comment on column dac_dimension_nodes_v.ddn_created_at is 'Creation timestamp.';
comment on column dac_dimension_nodes_v.ddn_updated_at is 'Last update timestamp.';
