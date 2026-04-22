create or replace force view dac_effective_access_reasons_v as
select dear_id,
       dear_dea_id,
       dea_subject_den_id dear_dea_subject_den_id,
       dea_subject_den_display_name dear_dea_subject_den_display_name,
       dea_target_den_id dear_dea_target_den_id,
       dea_target_den_display_name dear_dea_target_den_display_name,
       dear_ddi_id,
       ddi_name dear_ddi_name,
       dear_subject_ddn_id,
       s.ddn_name dear_subject_ddn_name,
       dear_target_ddn_id,
       t.ddn_name dear_target_ddn_name,
       dear_dms_id,
       dms_name dear_dms_name,
       dear_reason_code,
       dear_details
  from dac_effective_access_reasons
  join dac_effective_accesses_v
    on dear_dea_id = dea_id
  join dac_dimensions_v
    on dear_ddi_id = ddi_id
  join dac_match_states_v
    on dear_dms_id = dms_id
  left join dac_dimension_nodes_v s
    on dear_subject_ddn_id = s.ddn_id
  left join dac_dimension_nodes_v t
    on dear_target_ddn_id = t.ddn_id;

comment on table dac_effective_access_reasons_v is 'Read access view for per-dimension effective access explanations.';
comment on column dac_effective_access_reasons_v.dear_id is 'Primary key of the access reason row.';
comment on column dac_effective_access_reasons_v.dear_dea_id is 'Foreign key to DAC_EFFECTIVE_ACCESSES.';
comment on column dac_effective_access_reasons_v.dear_dea_subject_den_id is 'Subject entity ID of the effective access row.';
comment on column dac_effective_access_reasons_v.dear_dea_subject_den_display_name is 'Display name of the subject entity.';
comment on column dac_effective_access_reasons_v.dear_dea_target_den_id is 'Target entity ID of the effective access row.';
comment on column dac_effective_access_reasons_v.dear_dea_target_den_display_name is 'Display name of the target entity.';
comment on column dac_effective_access_reasons_v.dear_ddi_id is 'Foreign key to DAC_DIMENSIONS.';
comment on column dac_effective_access_reasons_v.dear_ddi_name is 'Translated dimension name.';
comment on column dac_effective_access_reasons_v.dear_subject_ddn_id is 'Foreign key to DAC_DIMENSION_NODES for the subject side of the match.';
comment on column dac_effective_access_reasons_v.dear_subject_ddn_name is 'Translated subject-side dimension node name.';
comment on column dac_effective_access_reasons_v.dear_target_ddn_id is 'Foreign key to DAC_DIMENSION_NODES for the target side of the match.';
comment on column dac_effective_access_reasons_v.dear_target_ddn_name is 'Translated target-side dimension node name.';
comment on column dac_effective_access_reasons_v.dear_dms_id is 'Foreign key to DAC_MATCH_STATES.';
comment on column dac_effective_access_reasons_v.dear_dms_name is 'Translated match state name.';
comment on column dac_effective_access_reasons_v.dear_reason_code is 'Technical reason code explaining this dimension match.';
comment on column dac_effective_access_reasons_v.dear_details is 'Optional human readable details.';

