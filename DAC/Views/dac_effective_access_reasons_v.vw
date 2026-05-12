create or replace force view dac_effective_access_reasons_v as
select dear_id,
       dear_subject_den_id,
       s_den.den_display_name dear_subject_den_display_name,
       dear_target_den_id,
       t_den.den_display_name dear_target_den_display_name,
       dear_ddi_id,
       ddi_name dear_ddi_name,
       dear_subject_ddn_id,
       s_ddn.ddn_name dear_subject_ddn_name,
       dear_target_ddn_id,
       t_ddn.ddn_name dear_target_ddn_name,
       dear_dms_id,
       dms_name dear_dms_name,
       dear_reason_code,
       dear_details
  from dac_effective_access_reasons
  join dac_entities_v s_den
    on dear_subject_den_id = s_den.den_id
  join dac_entities_v t_den
    on dear_target_den_id = t_den.den_id
  join dac_dimensions_v
    on dear_ddi_id = ddi_id
  join dac_match_states_v
    on dear_dms_id = dms_id
  left join dac_dimension_nodes_v s_ddn
    on dear_subject_ddn_id = s_ddn.ddn_id
  left join dac_dimension_nodes_v t_ddn
    on dear_target_ddn_id = t_ddn.ddn_id;

comment on table dac_effective_access_reasons_v is 'Read access view for per-dimension effective access explanations.';
comment on column dac_effective_access_reasons_v.dear_id is 'Primary key of the access reason row.';
comment on column dac_effective_access_reasons_v.dear_subject_den_id is 'Subject entity ID of the effective access row.';
comment on column dac_effective_access_reasons_v.dear_subject_den_display_name is 'Display name of the subject entity.';
comment on column dac_effective_access_reasons_v.dear_target_den_id is 'Target entity ID of the effective access row.';
comment on column dac_effective_access_reasons_v.dear_target_den_display_name is 'Display name of the target entity.';
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
