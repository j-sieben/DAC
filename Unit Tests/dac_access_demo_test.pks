create or replace package dac_access_demo_test
authid definer
as
  /**
    Package: DAC_ACCESS_DEMO_TEST
      utPLSQL tests for the demo access cases seeded by DAC demo data.
   */

  --%suite(DAC access decisions tell the story of the matrix)
  --%suitepath(dac.access.demo)

  --%test(Alice can read the Project A plan because she belongs to the Project A distribution list)
  procedure alice_reads_project_a_plan;

  --%test(Alice can read the confidential Project A document because the hierarchy includes child distribution lists)
  procedure alice_reads_confidential_project_a_document;

  --%test(Alice cannot read the Controlling report because no restrictive distribution list matches)
  procedure alice_cannot_read_controlling_without_assignment;

  --%test(Bob can read the Controlling report because his distribution list matches)
  procedure bob_reads_controlling_report;

  --%test(Bob cannot read the Project A plan because no restrictive distribution list matches)
  procedure bob_cannot_read_project_a_plan;

  --%test(Alice can read the public notice because the target has no restrictive distribution list)
  procedure alice_reads_public_notice;

  --%test(Carol never appears as a subject because the user entity is inactive)
  procedure carol_is_not_evaluated_as_subject;

  --%test(The inactive archive document never appears as a target)
  procedure inactive_archive_is_not_evaluated_as_target;

  --%test(Dave cannot read Project A because his assignment expired)
  procedure dave_expired_assignment_is_ignored;

  --%test(Erin cannot read Project A because her assignment is inactive)
  procedure erin_inactive_assignment_is_ignored;

  --%test(Grace cannot read Project A before her future assignment starts)
  procedure grace_future_assignment_is_ignored;

  --%test(Frank can read the internal Project A document because every restrictive dimension matches)
  procedure frank_matches_all_restrictive_dimensions;

  --%test(Alice cannot read the internal Project A document because one restrictive dimension is missing)
  procedure alice_misses_one_restrictive_dimension;

  --%test(Heidi can read Project A because one of her distribution list assignments matches)
  procedure heidi_needs_only_one_matching_assignment;

  --%test(Ivan can read the confidential Project A document because Project A includes child distribution lists)
  procedure ivan_reads_confidential_project_a_document;

  --%test(Alice can read a document whose only target restriction is an inactive node)
  procedure inactive_target_node_is_ignored;

  --%test(Alice can read a document whose only target restriction belongs to an inactive dimension)
  procedure inactive_target_dimension_is_ignored;

  --%test(DAC admin stores the default start date when an assignment starts with null)
  procedure admin_defaults_assignment_start;

  --%test(DAC admin stores the default end date when an assignment ends with null)
  procedure admin_defaults_assignment_end;

  --%test(DAC admin stores both default dates when an entity validity band is null)
  procedure admin_defaults_entity_band;

  --%test(DAC admin rejects an entity validity band whose start is after its end)
  procedure admin_rejects_inverted_entity_band;

end dac_access_demo_test;
/
