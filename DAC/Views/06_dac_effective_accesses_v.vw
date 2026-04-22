create or replace force view dac_effective_accesses_v as
select dea_id,
       dea_subject_den_id,
       s.den_display_name dea_subject_den_display_name,
       s.den_det_id dea_subject_den_det_id,
       s.den_det_name dea_subject_den_det_name,
       dea_target_den_id,
       t.den_display_name dea_target_den_display_name,
       t.den_det_id dea_target_den_det_id,
       t.den_det_name dea_target_den_det_name,
       dea_access,
       dea_match_reason,
       cast(m.last_refresh_date as timestamp) dea_calculated_at
  from dac_effective_accesses
  join dac_entities_v s
    on dea_subject_den_id = s.den_id
  join dac_entities_v t
    on dea_target_den_id = t.den_id
 cross join (
    select last_refresh_date
      from user_mviews
     where mview_name = 'DAC_EFFECTIVE_ACCESSES'
  ) m;

comment on table dac_effective_accesses_v is 'Read access view for published materialized effective access decisions.';
comment on column dac_effective_accesses_v.dea_id is 'Primary key of the effective access row.';
comment on column dac_effective_accesses_v.dea_subject_den_id is 'Foreign key to DAC_ENTITIES for the evaluated subject.';
comment on column dac_effective_accesses_v.dea_subject_den_display_name is 'Display name of the evaluated subject.';
comment on column dac_effective_accesses_v.dea_subject_den_det_id is 'Entity type ID of the evaluated subject.';
comment on column dac_effective_accesses_v.dea_subject_den_det_name is 'Translated entity type name of the evaluated subject.';
comment on column dac_effective_accesses_v.dea_target_den_id is 'Foreign key to DAC_ENTITIES for the evaluated target asset.';
comment on column dac_effective_accesses_v.dea_target_den_display_name is 'Display name of the evaluated target asset.';
comment on column dac_effective_accesses_v.dea_target_den_det_id is 'Entity type ID of the evaluated target asset.';
comment on column dac_effective_accesses_v.dea_target_den_det_name is 'Translated entity type name of the evaluated target asset.';
comment on column dac_effective_accesses_v.dea_access is 'Flag indicating whether access is granted.';
comment on column dac_effective_accesses_v.dea_match_reason is 'Technical reason code for the overall access decision.';
comment on column dac_effective_accesses_v.dea_calculated_at is 'Timestamp of the last materialized view refresh.';
