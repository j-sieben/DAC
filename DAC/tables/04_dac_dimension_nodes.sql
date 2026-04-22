/**
  Table: DAC_DIMENSION_NODES
    Hierarchical nodes within dimensions.

  Columns:
    ddn_id - Primary key, also reference to PIT_TRANSLATABLE_ITEM
    ddn_pgr_id - Message group, is required as a reference to Translatable Item. Constant value DAC
    ddn_ddi_id - Reference to DAC_DIMENSIONS
    ddn_ddn_id - Reference to the parent DAC_DIMENSION_NODES row
    ddn_active - Flag indicating whether the node is active
    ddn_display_sequence - Display order of the node
    ddn_created_at - Creation timestamp
    ddn_updated_at - Last update timestamp

  Dependencies:
    ddn_id, ddn_pgr_id - references <PIT_TRANSLATABLE_ITEM> (pti_uid, pti_upmg)
    ddn_ddi_id - references <DAC_DIMENSIONS> (ddi_id)
    ddn_ddi_id, ddn_ddn_id - references <DAC_DIMENSION_NODES> (ddn_ddi_id, ddn_id)
 */
create table dac_dimension_nodes (
  ddn_id varchar2(128 byte) constraint ddn_id_chk check(ddn_id = upper(ddn_id) and regexp_instr(ddn_id, '^[A-Z][A-Z0-9_]+$') = 1),
  ddn_pgr_id varchar2(128 byte) default on null 'DAC' constraint ddn_pgr_id_chk check(ddn_pgr_id = 'DAC'),
  ddn_ddi_id varchar2(128 byte) constraint ddn_ddi_id_nn not null,
  ddn_ddn_id varchar2(128 byte),
  ddn_active char(1 byte) default on null 'Y'
    constraint ddn_active_chk check (ddn_active in ('Y', 'N')),
  ddn_display_sequence number(10,0) default 10 constraint ddn_display_sequence_nn not null,
  ddn_created_at timestamp default systimestamp constraint ddn_created_at_nn not null,
  ddn_updated_at timestamp,
  constraint dac_dimension_nodes_pk primary key (ddn_id),
  constraint dac_dimension_nodes_uk_dim_id unique (ddn_ddi_id, ddn_id),
  constraint dac_dimension_nodes_fk_ddi foreign key (ddn_ddi_id)
    references dac_dimensions (ddi_id) on delete cascade,
  constraint dac_dimension_nodes_fk_parent foreign key (ddn_ddi_id, ddn_ddn_id)
    references dac_dimension_nodes (ddn_ddi_id, ddn_id) on delete cascade,
  constraint ddn_pti_fk foreign key (ddn_id, ddn_pgr_id)
    references b3m_utils.pit_translatable_item (pti_uid, pti_upmg),
  constraint dac_dimension_nodes_ck_parent check (ddn_ddn_id is null or ddn_ddn_id <> ddn_id)
);

create index dac_dimension_nodes_idx_parent on dac_dimension_nodes (ddn_ddn_id);
create index ddn_pti_fk_ix on dac_dimension_nodes (ddn_id, ddn_pgr_id);

comment on table dac_dimension_nodes is 'Hierarchical nodes within dimensions.';
comment on column dac_dimension_nodes.ddn_id is 'Primary key, also reference to PIT_TRANSLATABLE_ITEM.';
comment on column dac_dimension_nodes.ddn_pgr_id is 'Message group, is required as a reference to Translatable Item. Constant value DAC.';
comment on column dac_dimension_nodes.ddn_ddi_id is 'Foreign key to DAC_DIMENSIONS.DDI_ID.';
comment on column dac_dimension_nodes.ddn_ddn_id is 'Foreign key to the parent DAC_DIMENSION_NODES.DDN_ID.';
comment on column dac_dimension_nodes.ddn_active is 'Flag indicating whether the node is active.';
comment on column dac_dimension_nodes.ddn_display_sequence is 'Display order of the node.';
comment on column dac_dimension_nodes.ddn_created_at is 'Creation timestamp.';
comment on column dac_dimension_nodes.ddn_updated_at is 'Last update timestamp.';
