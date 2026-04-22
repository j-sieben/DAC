create or replace force view dac_access_decision_reasons_v as
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
  ),
  active_dimensions as (
    select ddi_id,
           ddi_name,
           ddi_display_sequence
      from dac_dimensions_v
     where ddi_active = 'Y'
       and ddi_is_restrictive = 'Y'
  ),
  active_assignments as (
    select dena_den_id,
           dena_ddn_id,
           dena_ddn_name,
           dena_ddn_ddi_id
      from dac_entity_node_assignments_v
      join dac_dimension_nodes_v
        on dena_ddn_id = ddn_id
      join dac_dimensions_v
        on dena_ddn_ddi_id = ddi_id
     where dena_active = 'Y'
       and ddn_active = 'Y'
       and ddi_active = 'Y'
       and trunc(sysdate) between dena_valid_from and dena_valid_to
  ),
  node_closure as (
    select ddn_ddi_id,
           connect_by_root ddn_id ancestor_ddn_id,
           ddn_id descendant_ddn_id
      from dac_dimension_nodes_v
     where ddn_active = 'Y'
   connect by nocycle prior ddn_id = ddn_ddn_id
          and prior ddn_ddi_id = ddn_ddi_id
  ),
  related_nodes as (
    select ddn_ddi_id,
           ancestor_ddn_id left_ddn_id,
           descendant_ddn_id right_ddn_id
      from node_closure
    union
    select ddn_ddi_id,
           descendant_ddn_id left_ddn_id,
           ancestor_ddn_id right_ddn_id
      from node_closure
  ),
  target_scope as (
    select dena_den_id,
           dena_ddn_ddi_id,
           count(*) target_include_count
      from active_assignments
     group by dena_den_id,
              dena_ddn_ddi_id
  ),
  include_matches as (
    select access_pairs.subject_den_id,
           access_pairs.target_den_id,
           target_assignments.dena_ddn_ddi_id ddi_id,
           min(subject_assignments.dena_ddn_id) subject_ddn_id,
           min(subject_assignments.dena_ddn_name) subject_ddn_name,
           min(target_assignments.dena_ddn_id) target_ddn_id,
           min(target_assignments.dena_ddn_name) target_ddn_name,
           count(*) match_count
      from access_pairs
      join active_assignments subject_assignments
        on access_pairs.subject_den_id = subject_assignments.dena_den_id
      join active_assignments target_assignments
        on access_pairs.target_den_id = target_assignments.dena_den_id
       and subject_assignments.dena_ddn_ddi_id = target_assignments.dena_ddn_ddi_id
      join related_nodes
        on subject_assignments.dena_ddn_ddi_id = related_nodes.ddn_ddi_id
       and subject_assignments.dena_ddn_id = related_nodes.left_ddn_id
       and target_assignments.dena_ddn_id = related_nodes.right_ddn_id
     group by access_pairs.subject_den_id,
              access_pairs.target_den_id,
              target_assignments.dena_ddn_ddi_id
  )
select access_pairs.subject_den_id dadr_subject_den_id,
       access_pairs.subject_det_id dadr_subject_det_id,
       access_pairs.subject_det_name dadr_subject_det_name,
       access_pairs.subject_display_name dadr_subject_display_name,
       access_pairs.target_den_id dadr_target_den_id,
       access_pairs.target_det_id dadr_target_det_id,
       access_pairs.target_det_name dadr_target_det_name,
       access_pairs.target_display_name dadr_target_display_name,
       active_dimensions.ddi_id dadr_ddi_id,
       active_dimensions.ddi_name dadr_ddi_name,
       include_matches.subject_ddn_id dadr_subject_ddn_id,
       include_matches.subject_ddn_name dadr_subject_ddn_name,
       include_matches.target_ddn_id dadr_target_ddn_id,
       include_matches.target_ddn_name dadr_target_ddn_name,
       case
         when target_scope.target_include_count is null then 'NOT_APPLICABLE'
         when include_matches.match_count > 0 then 'MATCH'
         else 'NO_MATCH'
       end dadr_dms_id,
       case
         when target_scope.target_include_count is null then 'Ziel ist in dieser restriktiven Dimension nicht verortet.'
         when include_matches.match_count > 0 then 'Subjekt und Ziel liegen in derselben Hierarchie dieser restriktiven Dimension.'
         else 'Das Ziel ist in dieser restriktiven Dimension verortet, das Subjekt aber nicht passend.'
       end dadr_reason,
       active_dimensions.ddi_display_sequence dadr_display_sequence
  from access_pairs
 cross join active_dimensions
  left join target_scope
    on access_pairs.target_den_id = target_scope.dena_den_id
   and active_dimensions.ddi_id = target_scope.dena_ddn_ddi_id
  left join include_matches
    on access_pairs.subject_den_id = include_matches.subject_den_id
   and access_pairs.target_den_id = include_matches.target_den_id
   and active_dimensions.ddi_id = include_matches.ddi_id;

comment on table dac_access_decision_reasons_v is 'Calculated per-dimension explanations for dimensional access decisions.';
comment on column dac_access_decision_reasons_v.dadr_subject_den_id is 'Subject entity ID from whose perspective access is evaluated.';
comment on column dac_access_decision_reasons_v.dadr_subject_det_id is 'Entity type ID of the subject entity.';
comment on column dac_access_decision_reasons_v.dadr_subject_det_name is 'Translated entity type name of the subject entity.';
comment on column dac_access_decision_reasons_v.dadr_subject_display_name is 'Display name of the subject entity.';
comment on column dac_access_decision_reasons_v.dadr_target_den_id is 'Target entity ID for which access is evaluated.';
comment on column dac_access_decision_reasons_v.dadr_target_det_id is 'Entity type ID of the target entity.';
comment on column dac_access_decision_reasons_v.dadr_target_det_name is 'Translated entity type name of the target entity.';
comment on column dac_access_decision_reasons_v.dadr_target_display_name is 'Display name of the target entity.';
comment on column dac_access_decision_reasons_v.dadr_ddi_id is 'Restrictive dimension ID used for this reason row.';
comment on column dac_access_decision_reasons_v.dadr_ddi_name is 'Translated dimension name.';
comment on column dac_access_decision_reasons_v.dadr_subject_ddn_id is 'Relevant subject-side dimension node ID, if any.';
comment on column dac_access_decision_reasons_v.dadr_subject_ddn_name is 'Translated subject-side dimension node name, if any.';
comment on column dac_access_decision_reasons_v.dadr_target_ddn_id is 'Relevant target-side dimension node ID, if any.';
comment on column dac_access_decision_reasons_v.dadr_target_ddn_name is 'Translated target-side dimension node name, if any.';
comment on column dac_access_decision_reasons_v.dadr_dms_id is 'Calculated match state ID for this dimension.';
comment on column dac_access_decision_reasons_v.dadr_reason is 'Human-readable explanation for the calculated match state.';
comment on column dac_access_decision_reasons_v.dadr_display_sequence is 'Display order of the restrictive dimension.';
