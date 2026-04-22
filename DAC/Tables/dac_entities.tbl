/**
  Table: DAC_ENTITIES
    Matrix participants such as users, reports, rules, modules or other application assets.

  Columns:
    den_id - Primary key of the entity
    den_det_id - Reference to DAC_ENTITY_TYPES
    den_external_id - Stable technical identifier of the entity in its owning application context
    den_display_name - Display name of the entity
    den_description - Optional description of the entity
    den_active_from - Start date for entity validity
    den_active_to - End date for entity validity
    den_active - Flag indicating whether the entity is active
    den_created_at - Creation timestamp
    den_updated_at - Last update timestamp

  Dependencies:
    den_det_id - references <DAC_ENTITY_TYPES> (det_id)
 */
create table dac_entities (
  den_id varchar2(128 byte) constraint den_id_nn not null,
  den_det_id varchar2(128 byte) constraint den_det_id_nn not null,
  den_external_id varchar2(128 byte) constraint den_external_id_nn not null,
  den_display_name varchar2(400 char) constraint den_display_name_nn not null,
  den_description varchar2(1000 char),
  den_active_from date default date '1900-01-01' constraint den_active_from_nn not null,
  den_active_to date default date '9999-12-31' constraint den_active_to_nn not null,
  den_active char(1 byte) default on null 'Y'
    constraint den_active_chk check (den_active in ('Y', 'N')),
  den_created_at timestamp default systimestamp constraint den_created_at_nn not null,
  den_updated_at timestamp,
  constraint dac_entities_pk primary key (den_id),
  constraint dac_entities_uk_external unique (den_det_id, den_external_id),
  constraint dac_entities_fk_det foreign key (den_det_id)
    references dac_entity_types (det_id) on delete cascade,
  constraint dac_entities_ck_dates check (den_active_from <= den_active_to)
);

create index dac_entities_idx_det on dac_entities (den_det_id);

comment on table dac_entities is 'Matrix participants such as users, reports, rules, modules or other application assets.';
comment on column dac_entities.den_id is 'Primary key of the entity.';
comment on column dac_entities.den_det_id is 'Foreign key to DAC_ENTITY_TYPES.DET_ID.';
comment on column dac_entities.den_external_id is 'Stable technical identifier of the entity in its owning application context.';
comment on column dac_entities.den_display_name is 'Display name of the entity.';
comment on column dac_entities.den_description is 'Optional description of the entity.';
comment on column dac_entities.den_active_from is 'Start date for entity validity.';
comment on column dac_entities.den_active_to is 'End date for entity validity.';
comment on column dac_entities.den_active is 'Flag indicating whether the entity is active.';
comment on column dac_entities.den_created_at is 'Creation timestamp.';
comment on column dac_entities.den_updated_at is 'Last update timestamp.';
