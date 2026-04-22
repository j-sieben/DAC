create or replace force view dac_entity_types_v as
select det_id,
       pti_name det_name,
       pti_description det_description,
       det_is_subject,
       det_active,
       det_display_sequence,
       det_created_at,
       det_updated_at
  from dac_entity_types
  join pit_translatable_item_v
    on det_id = pti_id
   and det_pgr_id = pti_pmg_name;

comment on table dac_entity_types_v is 'Read access view for entity types participating in dimensional access control.';
comment on column dac_entity_types_v.det_id is 'Primary key of the entity type.';
comment on column dac_entity_types_v.det_name is 'Translated display name of the entity type.';
comment on column dac_entity_types_v.det_description is 'Translated description of the entity type.';
comment on column dac_entity_types_v.det_is_subject is 'Flag indicating whether entities of this type can be evaluated as access subjects.';
comment on column dac_entity_types_v.det_active is 'Flag indicating whether the entity type is active.';
comment on column dac_entity_types_v.det_display_sequence is 'Display order of the entity type.';
comment on column dac_entity_types_v.det_created_at is 'Creation timestamp.';
comment on column dac_entity_types_v.det_updated_at is 'Last update timestamp.';

