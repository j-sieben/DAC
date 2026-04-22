create or replace force view dac_dimensions_v as
select ddi_id,
       pti_name ddi_name,
       pti_description ddi_description,
       ddi_is_restrictive,
       ddi_is_filter,
       ddi_active,
       ddi_display_sequence,
       ddi_created_at,
       ddi_updated_at
  from dac_dimensions
  join pit_translatable_item_v
    on ddi_id = pti_id
   and ddi_pgr_id = pti_pmg_name;

comment on table dac_dimensions_v is 'Read access view for dimensional topologies.';
comment on column dac_dimensions_v.ddi_id is 'Primary key of the dimension.';
comment on column dac_dimensions_v.ddi_name is 'Translated display name of the dimension.';
comment on column dac_dimensions_v.ddi_description is 'Translated description of the dimension.';
comment on column dac_dimensions_v.ddi_is_restrictive is 'Flag indicating whether target entities located in this dimension require matching subject locations.';
comment on column dac_dimensions_v.ddi_is_filter is 'Flag indicating whether the dimension also provides data filter values.';
comment on column dac_dimensions_v.ddi_active is 'Flag indicating whether the dimension is active.';
comment on column dac_dimensions_v.ddi_display_sequence is 'Display order of the dimension.';
comment on column dac_dimensions_v.ddi_created_at is 'Creation timestamp.';
comment on column dac_dimensions_v.ddi_updated_at is 'Last update timestamp.';

