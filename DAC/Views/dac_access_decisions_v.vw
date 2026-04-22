create or replace force view dac_access_decisions_v as
with
  active_entities as (
    select den_id,
           den_det_id,
           den_det_name,
           den_det_is_subject,
           den_display_name
      from dac_entities_v
     where den_active = 'Y'
       and trunc(sysdate) between den_active_from and den_active_to
  ),
  subject_entities as (
    select den_id,
           den_det_id,
           den_det_name,
           den_display_name
      from active_entities
     where den_det_is_subject = 'Y'
  ),
  target_entities as (
    select den_id,
           den_det_id,
           den_det_name,
           den_display_name
      from active_entities
  ),
  access_pairs as (
    select s.den_id subject_den_id,
           s.den_det_id subject_det_id,
           s.den_det_name subject_det_name,
           s.den_display_name subject_display_name,
           t.den_id target_den_id,
           t.den_det_id target_det_id,
           t.den_det_name target_det_name,
           t.den_display_name target_display_name
      from subject_entities s
      join target_entities t
        on s.den_id <> t.den_id
  )
select access_pairs.subject_den_id dad_subject_den_id,
       min(access_pairs.subject_det_id) dad_subject_det_id,
       min(access_pairs.subject_det_name) dad_subject_det_name,
       min(access_pairs.subject_display_name) dad_subject_display_name,
       access_pairs.target_den_id dad_target_den_id,
       min(access_pairs.target_det_id) dad_target_det_id,
       min(access_pairs.target_det_name) dad_target_det_name,
       min(access_pairs.target_display_name) dad_target_display_name,
       case
         when coalesce(sum(case when dadr_dms_id = 'NO_MATCH' then 1 else 0 end), 0) > 0 then 'N'
         else 'Y'
       end dad_access,
       case
         when coalesce(sum(case when dadr_dms_id = 'NO_MATCH' then 1 else 0 end), 0) > 0 then 'RESTRICTIVE_DIMENSION_MISMATCH'
         when coalesce(sum(case when dadr_dms_id = 'MATCH' then 1 else 0 end), 0) > 0 then 'RESTRICTIVE_DIMENSIONS_MATCH'
         else 'NO_RESTRICTIVE_TARGET_ASSIGNMENTS'
       end dad_match_reason,
       coalesce(
         listagg(dadr_ddi_name || ': ' || dadr_reason, chr(10)) within group (order by dadr_display_sequence, dadr_ddi_name),
         'Es ist keine aktive restriktive Dimension vorhanden.'
       ) dad_reason
  from access_pairs
  left join dac_access_decision_reasons_v
    on access_pairs.subject_den_id = dadr_subject_den_id
   and access_pairs.target_den_id = dadr_target_den_id
 group by access_pairs.subject_den_id,
          access_pairs.target_den_id;

comment on table dac_access_decisions_v is 'Calculated dimensional access decisions between subject entities and target entities.';
comment on column dac_access_decisions_v.dad_subject_den_id is 'Subject entity ID from whose perspective access is evaluated.';
comment on column dac_access_decisions_v.dad_subject_det_id is 'Entity type ID of the subject entity.';
comment on column dac_access_decisions_v.dad_subject_det_name is 'Translated entity type name of the subject entity.';
comment on column dac_access_decisions_v.dad_subject_display_name is 'Display name of the subject entity.';
comment on column dac_access_decisions_v.dad_target_den_id is 'Target entity ID for which access is evaluated.';
comment on column dac_access_decisions_v.dad_target_det_id is 'Entity type ID of the target entity.';
comment on column dac_access_decisions_v.dad_target_det_name is 'Translated entity type name of the target entity.';
comment on column dac_access_decisions_v.dad_target_display_name is 'Display name of the target entity.';
comment on column dac_access_decisions_v.dad_access is 'Flag indicating whether the calculated access decision grants access.';
comment on column dac_access_decisions_v.dad_match_reason is 'Technical reason code for the overall calculated access decision.';
comment on column dac_access_decisions_v.dad_reason is 'Aggregated human-readable explanation of the calculated access decision.';
