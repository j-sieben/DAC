/**
  Table: DAC_DIMENSIONS
    Dimensional topologies used to locate entities and derive access decisions.

  Columns:
    ddi_id - Primary key, also reference to PIT_TRANSLATABLE_ITEM
    ddi_pgr_id - Message group, is required as a reference to Translatable Item. Constant value DAC
    ddi_is_restrictive - Flag indicating whether target entities located in this dimension require matching subject locations
    ddi_is_filter - Flag indicating whether the dimension also provides data filter values
    ddi_active - Flag indicating whether the dimension is active
    ddi_display_sequence - Display order of the dimension
    ddi_created_at - Creation timestamp
    ddi_updated_at - Last update timestamp

  Dependencies:
    ddi_id, ddi_pgr_id - references <PIT_TRANSLATABLE_ITEM> (pti_uid, pti_upmg)
 */
create table dac_dimensions (
  ddi_id varchar2(128 byte) constraint ddi_id_chk check(ddi_id = upper(ddi_id) and regexp_instr(ddi_id, '^[A-Z][A-Z0-9_]+$') = 1),
  ddi_pgr_id varchar2(128 byte) default on null 'DAC' constraint ddi_pgr_id_chk check(ddi_pgr_id = 'DAC'),
  ddi_is_restrictive char(1 byte) default on null 'N'
    constraint ddi_is_restrictive_chk check (ddi_is_restrictive in ('Y', 'N')),
  ddi_is_filter char(1 byte) default on null 'N'
    constraint ddi_is_filter_chk check (ddi_is_filter in ('Y', 'N')),
  ddi_active char(1 byte) default on null 'Y'
    constraint ddi_active_chk check (ddi_active in ('Y', 'N')),
  ddi_display_sequence number(10,0) default 10 constraint ddi_display_sequence_nn not null,
  ddi_created_at timestamp default systimestamp constraint ddi_created_at_nn not null,
  ddi_updated_at timestamp,
  constraint dac_dimensions_pk primary key (ddi_id),
  constraint ddi_pti_fk foreign key (ddi_id, ddi_pgr_id)
    references b3m_utils.pit_translatable_item (pti_uid, pti_upmg)
);

create index ddi_pti_fk_ix on dac_dimensions (ddi_id, ddi_pgr_id);

comment on table dac_dimensions is 'Dimensional topologies used to locate entities and derive access decisions.';
comment on column dac_dimensions.ddi_id is 'Primary key, also reference to PIT_TRANSLATABLE_ITEM.';
comment on column dac_dimensions.ddi_pgr_id is 'Message group, is required as a reference to Translatable Item. Constant value DAC.';
comment on column dac_dimensions.ddi_is_restrictive is 'Flag indicating whether target entities located in this dimension require matching subject locations.';
comment on column dac_dimensions.ddi_is_filter is 'Flag indicating whether the dimension also provides data filter values.';
comment on column dac_dimensions.ddi_active is 'Flag indicating whether the dimension is active.';
comment on column dac_dimensions.ddi_display_sequence is 'Display order of the dimension.';
comment on column dac_dimensions.ddi_created_at is 'Creation timestamp.';
comment on column dac_dimensions.ddi_updated_at is 'Last update timestamp.';
