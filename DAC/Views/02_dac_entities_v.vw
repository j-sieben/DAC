create or replace force view dac_entities_v as
select den_id,
       den_det_id,
       det_name den_det_name,
       det_is_subject den_det_is_subject,
       den_external_id,
       den_display_name,
       den_description,
       den_active_from,
       den_active_to,
       den_active,
       den_created_at,
       den_updated_at
  from dac_entities
  join dac_entity_types_v
    on den_det_id = det_id;

comment on table dac_entities_v is 'Read access view for matrix participants.';
comment on column dac_entities_v.den_id is 'Primary key of the entity.';
comment on column dac_entities_v.den_det_id is 'Foreign key to DAC_ENTITY_TYPES.';
comment on column dac_entities_v.den_det_name is 'Translated display name of the entity type.';
comment on column dac_entities_v.den_det_is_subject is 'Flag indicating whether this entity type can be evaluated as access subject.';
comment on column dac_entities_v.den_external_id is 'Stable technical identifier of the entity in its owning application context.';
comment on column dac_entities_v.den_display_name is 'Display name of the entity.';
comment on column dac_entities_v.den_description is 'Optional description of the entity.';
comment on column dac_entities_v.den_active_from is 'Start date for entity validity.';
comment on column dac_entities_v.den_active_to is 'End date for entity validity.';
comment on column dac_entities_v.den_active is 'Flag indicating whether the entity is active.';
comment on column dac_entities_v.den_created_at is 'Creation timestamp.';
comment on column dac_entities_v.den_updated_at is 'Last update timestamp.';

