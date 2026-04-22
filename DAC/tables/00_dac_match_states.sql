/**
  Table: DAC_MATCH_STATES
    Lookup table for technical match states used in per-dimension access explanations.

  Columns:
    dms_id - Primary key, also reference to PIT_TRANSLATABLE_ITEM
    dms_pgr_id - Message group, is required as a reference to Translatable Item. Constant value DAC
    dms_display_sequence - Display order of the match state
    dms_active - Flag indicating whether the match state is active

  Dependencies:
    dms_id, dms_pgr_id - references <PIT_TRANSLATABLE_ITEM> (pti_uid, pti_upmg)
 */
create table dac_match_states (
  dms_id varchar2(128 byte) constraint dms_id_chk check(dms_id = upper(dms_id) and regexp_instr(dms_id, '^[A-Z][A-Z0-9_]+$') = 1),
  dms_pgr_id varchar2(128 byte) default on null 'DAC' constraint dms_pgr_id_chk check(dms_pgr_id = 'DAC'),
  dms_display_sequence number(10,0) default 10 constraint dms_display_sequence_nn not null,
  dms_active char(1 byte) default on null 'Y'
    constraint dms_active_chk check (dms_active in ('Y', 'N')),
  constraint dac_match_states_pk primary key (dms_id),
  constraint dms_pti_fk foreign key (dms_id, dms_pgr_id)
    references b3m_utils.pit_translatable_item (pti_uid, pti_upmg)
);

create index dms_pti_fk_ix on dac_match_states (dms_id, dms_pgr_id);

comment on table dac_match_states is 'Lookup table for technical match states used in per-dimension access explanations.';
comment on column dac_match_states.dms_id is 'Primary key, also reference to PIT_TRANSLATABLE_ITEM.';
comment on column dac_match_states.dms_pgr_id is 'Message group, is required as a reference to Translatable Item. Constant value DAC.';
comment on column dac_match_states.dms_display_sequence is 'Display order of the match state.';
comment on column dac_match_states.dms_active is 'Flag indicating whether the match state is active.';
