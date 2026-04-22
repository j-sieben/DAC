create or replace force view dac_match_states_v as
select dms_id,
       pti_name dms_name,
       pti_description dms_description,
       dms_display_sequence,
       dms_active
  from dac_match_states
  join pit_translatable_item_v
    on dms_id = pti_id
   and dms_pgr_id = pti_pmg_name;

comment on table dac_match_states_v is 'Read access view for effective access match states.';
comment on column dac_match_states_v.dms_id is 'Primary key of the match state.';
comment on column dac_match_states_v.dms_name is 'Translated display name of the match state.';
comment on column dac_match_states_v.dms_description is 'Translated description of the match state.';
comment on column dac_match_states_v.dms_display_sequence is 'Display order of the match state.';
comment on column dac_match_states_v.dms_active is 'Flag indicating whether the match state is active.';

