/**
  Materialized View: DAC_EFFECTIVE_ACCESS_REASONS
    Published per-dimension explanation rows for effective access decisions.

  Columns:
    dear_id - Stable technical key of the access reason row
    dear_dea_id - Reference to DAC_EFFECTIVE_ACCESSES
    dear_ddi_id - Reference to DAC_DIMENSIONS
    dear_subject_ddn_id - Relevant subject-side dimension node
    dear_target_ddn_id - Relevant target-side dimension node
    dear_dms_id - Match state for this dimension
    dear_reason_code - Technical reason code explaining this dimension match
    dear_details - Human-readable details for this dimension match
 */
create materialized view dac_effective_access_reasons
build immediate
refresh complete on demand
start with trunc(sysdate) + 1 + 2/24
next trunc(sysdate) + 1 + 2/24
as
select dadr_subject_den_id || ':' || dadr_target_den_id || ':' || dadr_ddi_id dear_id,
       dadr_subject_den_id || ':' || dadr_target_den_id dear_dea_id,
       dadr_ddi_id dear_ddi_id,
       dadr_subject_ddn_id dear_subject_ddn_id,
       dadr_target_ddn_id dear_target_ddn_id,
       dadr_dms_id dear_dms_id,
       dadr_dms_id dear_reason_code,
       dadr_reason dear_details
  from dac_access_decision_reasons_v;

create unique index dac_effective_access_reasons_pk on dac_effective_access_reasons (dear_id);
create index dac_effective_access_reasons_idx_dea on dac_effective_access_reasons (dear_dea_id);
create index dac_effective_access_reasons_idx_ddi on dac_effective_access_reasons (dear_ddi_id);
create index dac_effective_access_reasons_idx_dms on dac_effective_access_reasons (dear_dms_id);

comment on column dac_effective_access_reasons.dear_id is 'Stable technical key of the access reason row.';
comment on column dac_effective_access_reasons.dear_dea_id is 'Foreign key value to DAC_EFFECTIVE_ACCESSES.DEA_ID.';
comment on column dac_effective_access_reasons.dear_ddi_id is 'Foreign key value to DAC_DIMENSIONS.DDI_ID.';
comment on column dac_effective_access_reasons.dear_subject_ddn_id is 'Relevant subject-side dimension node ID, if any.';
comment on column dac_effective_access_reasons.dear_target_ddn_id is 'Relevant target-side dimension node ID, if any.';
comment on column dac_effective_access_reasons.dear_dms_id is 'Match state ID for this dimension.';
comment on column dac_effective_access_reasons.dear_reason_code is 'Technical reason code explaining this dimension match.';
comment on column dac_effective_access_reasons.dear_details is 'Human-readable details for this dimension match.';
