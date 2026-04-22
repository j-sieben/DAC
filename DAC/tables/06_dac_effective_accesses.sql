/**
  Materialized View: DAC_EFFECTIVE_ACCESSES
    Published effective access matrix between subject entities and target entities.

  Columns:
    dea_id - Stable technical key of the effective access row
    dea_subject_den_id - Reference to DAC_ENTITIES for the evaluated subject
    dea_target_den_id - Reference to DAC_ENTITIES for the evaluated target asset
    dea_access - Flag indicating whether access is granted
    dea_match_reason - Technical reason code for the overall access decision
 */
create materialized view dac_effective_accesses
build immediate
refresh complete on demand
start with trunc(sysdate) + 1 + 2/24
next trunc(sysdate) + 1 + 2/24
as
select dad_subject_den_id || ':' || dad_target_den_id dea_id,
       dad_subject_den_id dea_subject_den_id,
       dad_target_den_id dea_target_den_id,
       dad_access dea_access,
       dad_match_reason dea_match_reason
  from dac_access_decisions_v;

create unique index dac_effective_accesses_pk on dac_effective_accesses (dea_id);
create unique index dac_effective_accesses_uk_pair on dac_effective_accesses (dea_subject_den_id, dea_target_den_id);
create index dac_effective_accesses_idx_subject on dac_effective_accesses (dea_subject_den_id);
create index dac_effective_accesses_idx_target on dac_effective_accesses (dea_target_den_id);

comment on column dac_effective_accesses.dea_id is 'Stable technical key of the effective access row.';
comment on column dac_effective_accesses.dea_subject_den_id is 'Foreign key value to DAC_ENTITIES.DEN_ID for the evaluated subject.';
comment on column dac_effective_accesses.dea_target_den_id is 'Foreign key value to DAC_ENTITIES.DEN_ID for the evaluated target asset.';
comment on column dac_effective_accesses.dea_access is 'Flag indicating whether access is granted.';
comment on column dac_effective_accesses.dea_match_reason is 'Technical reason code for the overall access decision.';
