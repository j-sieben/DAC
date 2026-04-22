create or replace package body dac_access_demo_test
as
  /**
    Package: DAC_ACCESS_DEMO_TEST Body
      utPLSQL tests for the demo access cases seeded by DAC demo data.
   */

  /**
    Procedure: assert_access
      Checks the overall access decision for one subject-target pair.
   */
  procedure assert_access(
    p_subject_den_id in dac_access_decisions_v.dad_subject_den_id%type,
    p_target_den_id in dac_access_decisions_v.dad_target_den_id%type,
    p_expected_access in dac_access_decisions_v.dad_access%type,
    p_expected_reason in dac_access_decisions_v.dad_match_reason%type)
  as
    l_row_count pls_integer;
    l_access dac_access_decisions_v.dad_access%type;
    l_reason dac_access_decisions_v.dad_match_reason%type;
  begin
    select count(*),
           max(dad_access),
           max(dad_match_reason)
      into l_row_count,
           l_access,
           l_reason
      from dac_access_decisions_v
     where dad_subject_den_id = p_subject_den_id
       and dad_target_den_id = p_target_den_id;

    ut.expect(l_row_count).to_equal(1);
    ut.expect(l_access).to_equal(p_expected_access);
    ut.expect(l_reason).to_equal(p_expected_reason);
  end assert_access;


  /**
    Procedure: assert_reason
      Checks the per-dimension reason for one subject-target pair.
   */
  procedure assert_reason(
    p_subject_den_id in dac_access_decision_reasons_v.dadr_subject_den_id%type,
    p_target_den_id in dac_access_decision_reasons_v.dadr_target_den_id%type,
    p_ddi_id in dac_access_decision_reasons_v.dadr_ddi_id%type,
    p_expected_dms_id in dac_access_decision_reasons_v.dadr_dms_id%type)
  as
    l_row_count pls_integer;
    l_dms_id dac_access_decision_reasons_v.dadr_dms_id%type;
  begin
    select count(*),
           max(dadr_dms_id)
      into l_row_count,
           l_dms_id
      from dac_access_decision_reasons_v
     where dadr_subject_den_id = p_subject_den_id
       and dadr_target_den_id = p_target_den_id
       and dadr_ddi_id = p_ddi_id;

    ut.expect(l_row_count).to_equal(1);
    ut.expect(l_dms_id).to_equal(p_expected_dms_id);
  end assert_reason;


  /**
    Procedure: assert_subject_is_absent
      Checks that an entity is not evaluated as active access subject.
   */
  procedure assert_subject_is_absent(
    p_subject_den_id in dac_access_decisions_v.dad_subject_den_id%type)
  as
    l_row_count pls_integer;
  begin
    select count(*)
      into l_row_count
      from dac_access_decisions_v
     where dad_subject_den_id = p_subject_den_id;

    ut.expect(l_row_count).to_equal(0);
  end assert_subject_is_absent;


  /**
    Procedure: assert_target_is_absent
      Checks that an entity is not evaluated as active access target.
   */
  procedure assert_target_is_absent(
    p_target_den_id in dac_access_decisions_v.dad_target_den_id%type)
  as
    l_row_count pls_integer;
  begin
    select count(*)
      into l_row_count
      from dac_access_decisions_v
     where dad_target_den_id = p_target_den_id;

    ut.expect(l_row_count).to_equal(0);
  end assert_target_is_absent;


  /**
    Procedure: assert_reason_is_absent
      Checks that a restrictive dimension is not evaluated for one subject-target pair.
   */
  procedure assert_reason_is_absent(
    p_subject_den_id in dac_access_decision_reasons_v.dadr_subject_den_id%type,
    p_target_den_id in dac_access_decision_reasons_v.dadr_target_den_id%type,
    p_ddi_id in dac_access_decision_reasons_v.dadr_ddi_id%type)
  as
    l_row_count pls_integer;
  begin
    select count(*)
      into l_row_count
      from dac_access_decision_reasons_v
     where dadr_subject_den_id = p_subject_den_id
       and dadr_target_den_id = p_target_den_id
       and dadr_ddi_id = p_ddi_id;

    ut.expect(l_row_count).to_equal(0);
  end assert_reason_is_absent;


  /**
    Procedure: alice_reads_project_a_plan
      See: <DAC_ACCESS_DEMO_TEST.alice_reads_project_a_plan>
   */
  procedure alice_reads_project_a_plan
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'RESTRICTIVE_DIMENSIONS_MATCH');

    assert_reason(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'MATCH');
  end alice_reads_project_a_plan;


  /**
    Procedure: alice_reads_confidential_project_a_document
      See: <DAC_ACCESS_DEMO_TEST.alice_reads_confidential_project_a_document>
   */
  procedure alice_reads_confidential_project_a_document
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PROJECT_A_SECRET',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'RESTRICTIVE_DIMENSIONS_MATCH');

    assert_reason(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PROJECT_A_SECRET',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'MATCH');
  end alice_reads_confidential_project_a_document;


  /**
    Procedure: alice_cannot_read_controlling_without_assignment
      See: <DAC_ACCESS_DEMO_TEST.alice_cannot_read_controlling_without_assignment>
   */
  procedure alice_cannot_read_controlling_without_assignment
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_CONTROLLING_REPORT',
      p_expected_access => pit_util.C_FALSE,
      p_expected_reason => 'RESTRICTIVE_DIMENSION_MISMATCH');

    assert_reason(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_CONTROLLING_REPORT',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'NO_MATCH');
  end alice_cannot_read_controlling_without_assignment;


  /**
    Procedure: bob_reads_controlling_report
      See: <DAC_ACCESS_DEMO_TEST.bob_reads_controlling_report>
   */
  procedure bob_reads_controlling_report
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_BOB',
      p_target_den_id => 'DOC_CONTROLLING_REPORT',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'RESTRICTIVE_DIMENSIONS_MATCH');

    assert_reason(
      p_subject_den_id => 'USER_BOB',
      p_target_den_id => 'DOC_CONTROLLING_REPORT',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'MATCH');
  end bob_reads_controlling_report;


  /**
    Procedure: bob_cannot_read_project_a_plan
      See: <DAC_ACCESS_DEMO_TEST.bob_cannot_read_project_a_plan>
   */
  procedure bob_cannot_read_project_a_plan
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_BOB',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_expected_access => pit_util.C_FALSE,
      p_expected_reason => 'RESTRICTIVE_DIMENSION_MISMATCH');

    assert_reason(
      p_subject_den_id => 'USER_BOB',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'NO_MATCH');
  end bob_cannot_read_project_a_plan;


  /**
    Procedure: alice_reads_public_notice
      See: <DAC_ACCESS_DEMO_TEST.alice_reads_public_notice>
   */
  procedure alice_reads_public_notice
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PUBLIC_NEWS',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'NO_RESTRICTIVE_TARGET_ASSIGNMENTS');

    assert_reason(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PUBLIC_NEWS',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'NOT_APPLICABLE');
  end alice_reads_public_notice;


  /**
    Procedure: carol_is_not_evaluated_as_subject
      See: <DAC_ACCESS_DEMO_TEST.carol_is_not_evaluated_as_subject>
   */
  procedure carol_is_not_evaluated_as_subject
  as
  begin
    assert_subject_is_absent('USER_CAROL');
  end carol_is_not_evaluated_as_subject;


  /**
    Procedure: inactive_archive_is_not_evaluated_as_target
      See: <DAC_ACCESS_DEMO_TEST.inactive_archive_is_not_evaluated_as_target>
   */
  procedure inactive_archive_is_not_evaluated_as_target
  as
  begin
    assert_target_is_absent('DOC_INACTIVE_ARCHIVE');
  end inactive_archive_is_not_evaluated_as_target;


  /**
    Procedure: dave_expired_assignment_is_ignored
      See: <DAC_ACCESS_DEMO_TEST.dave_expired_assignment_is_ignored>
   */
  procedure dave_expired_assignment_is_ignored
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_DAVE',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_expected_access => pit_util.C_FALSE,
      p_expected_reason => 'RESTRICTIVE_DIMENSION_MISMATCH');

    assert_reason(
      p_subject_den_id => 'USER_DAVE',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'NO_MATCH');
  end dave_expired_assignment_is_ignored;


  /**
    Procedure: erin_inactive_assignment_is_ignored
      See: <DAC_ACCESS_DEMO_TEST.erin_inactive_assignment_is_ignored>
   */
  procedure erin_inactive_assignment_is_ignored
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ERIN',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_expected_access => pit_util.C_FALSE,
      p_expected_reason => 'RESTRICTIVE_DIMENSION_MISMATCH');

    assert_reason(
      p_subject_den_id => 'USER_ERIN',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'NO_MATCH');
  end erin_inactive_assignment_is_ignored;


  /**
    Procedure: grace_future_assignment_is_ignored
      See: <DAC_ACCESS_DEMO_TEST.grace_future_assignment_is_ignored>
   */
  procedure grace_future_assignment_is_ignored
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_GRACE',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_expected_access => pit_util.C_FALSE,
      p_expected_reason => 'RESTRICTIVE_DIMENSION_MISMATCH');

    assert_reason(
      p_subject_den_id => 'USER_GRACE',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'NO_MATCH');
  end grace_future_assignment_is_ignored;


  /**
    Procedure: frank_matches_all_restrictive_dimensions
      See: <DAC_ACCESS_DEMO_TEST.frank_matches_all_restrictive_dimensions>
   */
  procedure frank_matches_all_restrictive_dimensions
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_FRANK',
      p_target_den_id => 'DOC_PROJECT_A_INTERNAL',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'RESTRICTIVE_DIMENSIONS_MATCH');

    assert_reason(
      p_subject_den_id => 'USER_FRANK',
      p_target_den_id => 'DOC_PROJECT_A_INTERNAL',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'MATCH');

    assert_reason(
      p_subject_den_id => 'USER_FRANK',
      p_target_den_id => 'DOC_PROJECT_A_INTERNAL',
      p_ddi_id => 'ACCESS_ZONE',
      p_expected_dms_id => 'MATCH');
  end frank_matches_all_restrictive_dimensions;


  /**
    Procedure: alice_misses_one_restrictive_dimension
      See: <DAC_ACCESS_DEMO_TEST.alice_misses_one_restrictive_dimension>
   */
  procedure alice_misses_one_restrictive_dimension
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PROJECT_A_INTERNAL',
      p_expected_access => pit_util.C_FALSE,
      p_expected_reason => 'RESTRICTIVE_DIMENSION_MISMATCH');

    assert_reason(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PROJECT_A_INTERNAL',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'MATCH');

    assert_reason(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_PROJECT_A_INTERNAL',
      p_ddi_id => 'ACCESS_ZONE',
      p_expected_dms_id => 'NO_MATCH');
  end alice_misses_one_restrictive_dimension;


  /**
    Procedure: heidi_needs_only_one_matching_assignment
      See: <DAC_ACCESS_DEMO_TEST.heidi_needs_only_one_matching_assignment>
   */
  procedure heidi_needs_only_one_matching_assignment
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_HEIDI',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'RESTRICTIVE_DIMENSIONS_MATCH');

    assert_reason(
      p_subject_den_id => 'USER_HEIDI',
      p_target_den_id => 'DOC_PROJECT_A_PLAN',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'MATCH');
  end heidi_needs_only_one_matching_assignment;


  /**
    Procedure: ivan_reads_confidential_project_a_document
      See: <DAC_ACCESS_DEMO_TEST.ivan_reads_confidential_project_a_document>
   */
  procedure ivan_reads_confidential_project_a_document
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_IVAN',
      p_target_den_id => 'DOC_PROJECT_A_SECRET',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'RESTRICTIVE_DIMENSIONS_MATCH');

    assert_reason(
      p_subject_den_id => 'USER_IVAN',
      p_target_den_id => 'DOC_PROJECT_A_SECRET',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'MATCH');
  end ivan_reads_confidential_project_a_document;


  /**
    Procedure: inactive_target_node_is_ignored
      See: <DAC_ACCESS_DEMO_TEST.inactive_target_node_is_ignored>
   */
  procedure inactive_target_node_is_ignored
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_INACTIVE_NODE_RESTRICTION',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'NO_RESTRICTIVE_TARGET_ASSIGNMENTS');

    assert_reason(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_INACTIVE_NODE_RESTRICTION',
      p_ddi_id => 'DISTRIBUTION_LIST',
      p_expected_dms_id => 'NOT_APPLICABLE');
  end inactive_target_node_is_ignored;


  /**
    Procedure: inactive_target_dimension_is_ignored
      See: <DAC_ACCESS_DEMO_TEST.inactive_target_dimension_is_ignored>
   */
  procedure inactive_target_dimension_is_ignored
  as
  begin
    assert_access(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_INACTIVE_DIMENSION_RESTRICTION',
      p_expected_access => pit_util.C_TRUE,
      p_expected_reason => 'NO_RESTRICTIVE_TARGET_ASSIGNMENTS');

    assert_reason_is_absent(
      p_subject_den_id => 'USER_ALICE',
      p_target_den_id => 'DOC_INACTIVE_DIMENSION_RESTRICTION',
      p_ddi_id => 'ACCESS_PHASE');
  end inactive_target_dimension_is_ignored;


  /**
    Procedure: admin_defaults_assignment_start
      See: <DAC_ACCESS_DEMO_TEST.admin_defaults_assignment_start>
   */
  procedure admin_defaults_assignment_start
  as
    l_dena_valid_from dac_entity_node_assignments.dena_valid_from%type;
  begin
    dac_admin.merge_entity_node_assignment(
      p_dena_den_id => 'USER_ALICE',
      p_dena_ddn_id => 'DISTRIBUTION_LIST_RESTRUCTURING',
      p_dena_valid_from => null,
      p_dena_valid_to => date '9999-12-31');

    select dena_valid_from
      into l_dena_valid_from
      from dac_entity_node_assignments
     where dena_den_id = 'USER_ALICE'
       and dena_ddn_id = 'DISTRIBUTION_LIST_RESTRUCTURING';

    ut.expect(l_dena_valid_from).to_equal(date '1900-01-01');
  end admin_defaults_assignment_start;


  /**
    Procedure: admin_defaults_assignment_end
      See: <DAC_ACCESS_DEMO_TEST.admin_defaults_assignment_end>
   */
  procedure admin_defaults_assignment_end
  as
    l_dena_valid_to dac_entity_node_assignments.dena_valid_to%type;
  begin
    dac_admin.merge_entity_node_assignment(
      p_dena_den_id => 'USER_BOB',
      p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A',
      p_dena_valid_from => date '1900-01-01',
      p_dena_valid_to => null);

    select dena_valid_to
      into l_dena_valid_to
      from dac_entity_node_assignments
     where dena_den_id = 'USER_BOB'
       and dena_ddn_id = 'DISTRIBUTION_LIST_PROJECT_A';

    ut.expect(l_dena_valid_to).to_equal(date '9999-12-31');
  end admin_defaults_assignment_end;


  /**
    Procedure: admin_defaults_entity_band
      See: <DAC_ACCESS_DEMO_TEST.admin_defaults_entity_band>
   */
  procedure admin_defaults_entity_band
  as
    l_den_active_from dac_entities.den_active_from%type;
    l_den_active_to dac_entities.den_active_to%type;
  begin
    dac_admin.merge_entity(
      p_den_id => 'USER_TEST_DEFAULT_BAND',
      p_den_det_id => 'USER',
      p_den_external_id => 'test-default-band',
      p_den_display_name => 'Test Default Band',
      p_den_active_from => null,
      p_den_active_to => null);

    select den_active_from,
           den_active_to
      into l_den_active_from,
           l_den_active_to
      from dac_entities
     where den_id = 'USER_TEST_DEFAULT_BAND';

    ut.expect(l_den_active_from).to_equal(date '1900-01-01');
    ut.expect(l_den_active_to).to_equal(date '9999-12-31');
  end admin_defaults_entity_band;


  /**
    Procedure: admin_rejects_inverted_entity_band
      See: <DAC_ACCESS_DEMO_TEST.admin_rejects_inverted_entity_band>
   */
  procedure admin_rejects_inverted_entity_band
  as
    l_error_raised char(1 byte) := pit_util.C_FALSE;
  begin
    begin
      dac_admin.merge_entity(
        p_den_id => 'USER_TEST_INVERTED_BAND',
        p_den_det_id => 'USER',
        p_den_external_id => 'test-inverted-band',
        p_den_display_name => 'Test Inverted Band',
        p_den_active_from => date '2025-12-31',
        p_den_active_to => date '2025-01-01');
    exception
      when others then
        l_error_raised := pit_util.C_TRUE;
    end;

    ut.expect(l_error_raised).to_equal(pit_util.C_TRUE);
  end admin_rejects_inverted_entity_band;

end dac_access_demo_test;
/
