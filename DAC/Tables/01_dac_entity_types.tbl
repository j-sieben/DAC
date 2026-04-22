/**
  Table: DAC_ENTITY_TYPES
    Entity types participating in dimensional access control, such as USER, REPORT, RULE or MODULE.

  Columns:
    det_id - Primary key, also reference to PIT_TRANSLATABLE_ITEM
    det_pgr_id - Message group, is required as a reference to Translatable Item. Constant value DAC
    det_is_subject - Flag indicating whether entities of this type can be evaluated as access subjects
    det_active - Flag indicating whether the entity type is active
    det_display_sequence - Display order of the entity type
    det_created_at - Creation timestamp
    det_updated_at - Last update timestamp

  Dependencies:
    det_id, det_pgr_id - references <PIT_TRANSLATABLE_ITEM> (pti_uid, pti_upmg)
 */
create table dac_entity_types (
  det_id varchar2(128 byte) constraint det_id_chk check(det_id = upper(det_id) and regexp_instr(det_id, '^[A-Z][A-Z0-9_]+$') = 1),
  det_pgr_id varchar2(128 byte) default on null 'DAC' constraint det_pgr_id_chk check(det_pgr_id = 'DAC'),
  det_is_subject char(1 byte) default on null 'N'
    constraint det_is_subject_chk check (det_is_subject in ('Y', 'N')),
  det_active char(1 byte) default on null 'Y'
    constraint det_active_chk check (det_active in ('Y', 'N')),
  det_display_sequence number(10,0) default 10 constraint det_display_sequence_nn not null,
  det_created_at timestamp default systimestamp constraint det_created_at_nn not null,
  det_updated_at timestamp,
  constraint dac_entity_types_pk primary key (det_id),
  constraint det_pti_fk foreign key (det_id, det_pgr_id)
    references b3m_utils.pit_translatable_item (pti_uid, pti_upmg)
);

create index det_pti_fk_ix on dac_entity_types (det_id, det_pgr_id);

comment on table dac_entity_types is 'Entity types participating in dimensional access control, such as USER, REPORT, RULE or MODULE.';
comment on column dac_entity_types.det_id is 'Primary key, also reference to PIT_TRANSLATABLE_ITEM.';
comment on column dac_entity_types.det_pgr_id is 'Message group, is required as a reference to Translatable Item. Constant value DAC.';
comment on column dac_entity_types.det_is_subject is 'Flag indicating whether entities of this type can be evaluated as access subjects.';
comment on column dac_entity_types.det_active is 'Flag indicating whether the entity type is active.';
comment on column dac_entity_types.det_display_sequence is 'Display order of the entity type.';
comment on column dac_entity_types.det_created_at is 'Creation timestamp.';
comment on column dac_entity_types.det_updated_at is 'Last update timestamp.';
