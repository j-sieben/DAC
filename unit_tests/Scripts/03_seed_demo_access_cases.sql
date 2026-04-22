prompt Seeding DAC demo access cases

begin
  dac_admin.merge_entity_type(
    p_det_id => 'DOCUMENT',
    p_det_name => 'Dokument',
    p_det_description => q'[Dokument oder vergleichbares Ziel-Asset, dessen Zugriff über die Matrix ausgewertet wird.]',
    p_det_is_subject => pit_util.C_FALSE,
    p_det_display_sequence => 50);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A_CONFIDENTIAL',
    p_ddn_ddi_id => 'DISTRIBUTION_LIST',
    p_ddn_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A',
    p_ddn_name => 'Projekt A vertraulich',
    p_ddn_description => q'[Unterverteiler für vertrauliche Dokumente und Informationen zum Projekt A.]',
    p_ddn_display_sequence => 15);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'TOPOLOGY_INACTIVE_TEAM',
    p_ddn_ddi_id => 'TOPOLOGY',
    p_ddn_ddn_id => 'TOPOLOGY_DEPARTMENT',
    p_ddn_name => 'Inaktives Team',
    p_ddn_description => q'[Inaktiver Testknoten zur Prüfung deaktivierter Hierarchieeinträge.]',
    p_ddn_active => pit_util.C_FALSE,
    p_ddn_display_sequence => 90);

  dac_admin.merge_dimension(
    p_ddi_id => 'ACCESS_ZONE',
    p_ddi_name => 'Zugriffszone',
    p_ddi_description => q'[Zweite restriktive Dimension zur Prüfung mehrdimensionaler Zugriffsvoraussetzungen.]',
    p_ddi_is_filter => pit_util.C_FALSE,
    p_ddi_is_restrictive => pit_util.C_TRUE,
    p_ddi_display_sequence => 40);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'ACCESS_ZONE_INTERNAL',
    p_ddn_ddi_id => 'ACCESS_ZONE',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Intern',
    p_ddn_description => q'[Interne Zugriffszone.]',
    p_ddn_display_sequence => 10);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'ACCESS_ZONE_EXTERNAL',
    p_ddn_ddi_id => 'ACCESS_ZONE',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Extern',
    p_ddn_description => q'[Externe Zugriffszone.]',
    p_ddn_display_sequence => 20);

  dac_admin.merge_dimension(
    p_ddi_id => 'ACCESS_PHASE',
    p_ddi_name => 'Zugriffsphase',
    p_ddi_description => q'[Inaktive restriktive Testdimension. Zuordnungen in dieser Dimension dürfen den Zugriff nicht einschränken.]',
    p_ddi_is_filter => pit_util.C_FALSE,
    p_ddi_is_restrictive => pit_util.C_TRUE,
    p_ddi_active => pit_util.C_FALSE,
    p_ddi_display_sequence => 50);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'ACCESS_PHASE_DRAFT',
    p_ddn_ddi_id => 'ACCESS_PHASE',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Entwurf',
    p_ddn_description => q'[Testknoten in einer inaktiven restriktiven Dimension.]',
    p_ddn_display_sequence => 10);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'DISTRIBUTION_LIST_INACTIVE_CASE',
    p_ddn_ddi_id => 'DISTRIBUTION_LIST',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Inaktiver Verteiler',
    p_ddn_description => q'[Inaktiver Verteiler zur Prüfung deaktivierter Zielrestriktionen.]',
    p_ddn_active => pit_util.C_FALSE,
    p_ddn_display_sequence => 90);

  dac_admin.merge_entity(
    p_den_id => 'USER_ALICE',
    p_den_det_id => 'USER',
    p_den_external_id => 'alice',
    p_den_display_name => 'Alice Beispiel',
    p_den_description => q'[Aktiver Testbenutzer mit Zugriff auf Projekt A und Ausschluss für Controlling.]');

  dac_admin.merge_entity(
    p_den_id => 'USER_BOB',
    p_den_det_id => 'USER',
    p_den_external_id => 'bob',
    p_den_display_name => 'Bob Beispiel',
    p_den_description => q'[Aktiver Testbenutzer mit Zugriff auf Controlling.]');

  dac_admin.merge_entity(
    p_den_id => 'USER_CAROL',
    p_den_det_id => 'USER',
    p_den_external_id => 'carol',
    p_den_display_name => 'Carol Inaktiv',
    p_den_description => q'[Inaktiver Testbenutzer. Darf in der Zugriffsmatrix nicht als Subjekt erscheinen.]',
    p_den_active => pit_util.C_FALSE);

  dac_admin.merge_entity(
    p_den_id => 'USER_DAVE',
    p_den_det_id => 'USER',
    p_den_external_id => 'dave',
    p_den_display_name => 'Dave Abgelaufen',
    p_den_description => q'[Aktiver Testbenutzer mit abgelaufener Zuordnung.]');

  dac_admin.merge_entity(
    p_den_id => 'USER_ERIN',
    p_den_det_id => 'USER',
    p_den_external_id => 'erin',
    p_den_display_name => 'Erin Inaktive Zuordnung',
    p_den_description => q'[Aktiver Testbenutzer mit inaktiver Zuordnung.]');

  dac_admin.merge_entity(
    p_den_id => 'USER_FRANK',
    p_den_det_id => 'USER',
    p_den_external_id => 'frank',
    p_den_display_name => 'Frank Mehrdimensional',
    p_den_description => q'[Aktiver Testbenutzer mit passenden Zuordnungen in mehreren restriktiven Dimensionen.]');

  dac_admin.merge_entity(
    p_den_id => 'USER_GRACE',
    p_den_det_id => 'USER',
    p_den_external_id => 'grace',
    p_den_display_name => 'Grace Zukünftig',
    p_den_description => q'[Aktiver Testbenutzer mit künftig gültiger Zuordnung.]');

  dac_admin.merge_entity(
    p_den_id => 'USER_HEIDI',
    p_den_det_id => 'USER',
    p_den_external_id => 'heidi',
    p_den_display_name => 'Heidi Mehrfachzuordnung',
    p_den_description => q'[Aktiver Testbenutzer mit mehreren Zuordnungen in derselben restriktiven Dimension.]');

  dac_admin.merge_entity(
    p_den_id => 'USER_IVAN',
    p_den_det_id => 'USER',
    p_den_external_id => 'ivan',
    p_den_display_name => 'Ivan Konflikt',
    p_den_description => q'[Aktiver Testbenutzer mit Include und Exclude in derselben Hierarchie.]');

  dac_admin.merge_entity(
    p_den_id => 'DOC_PROJECT_A_PLAN',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-project-a-plan',
    p_den_display_name => 'Projekt A Plan',
    p_den_description => q'[Aktives Dokument im Verteiler Projekt A.]');

  dac_admin.merge_entity(
    p_den_id => 'DOC_PROJECT_A_SECRET',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-project-a-secret',
    p_den_display_name => 'Projekt A vertraulich',
    p_den_description => q'[Aktives Dokument im untergeordneten Verteiler Projekt A vertraulich.]');

  dac_admin.merge_entity(
    p_den_id => 'DOC_CONTROLLING_REPORT',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-controlling-report',
    p_den_display_name => 'Controlling Report',
    p_den_description => q'[Aktives Dokument im Verteiler Controlling.]');

  dac_admin.merge_entity(
    p_den_id => 'DOC_PUBLIC_NEWS',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-public-news',
    p_den_display_name => 'Allgemeine Mitteilung',
    p_den_description => q'[Aktives Dokument ohne restriktive Verteilerzuordnung.]');

  dac_admin.merge_entity(
    p_den_id => 'DOC_INACTIVE_ARCHIVE',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-inactive-archive',
    p_den_display_name => 'Inaktives Archivdokument',
    p_den_description => q'[Inaktives Zieldokument. Darf in der Zugriffsmatrix nicht als Ziel erscheinen.]',
    p_den_active => pit_util.C_FALSE);

  dac_admin.merge_entity(
    p_den_id => 'DOC_PROJECT_A_INTERNAL',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-project-a-internal',
    p_den_display_name => 'Projekt A Intern',
    p_den_description => q'[Aktives Dokument mit zwei restriktiven Zielvorgaben: Projekt A und interne Zugriffszone.]');

  dac_admin.merge_entity(
    p_den_id => 'DOC_INACTIVE_NODE_RESTRICTION',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-inactive-node-restriction',
    p_den_display_name => 'Dokument mit inaktivem Verteiler',
    p_den_description => q'[Aktives Dokument, dessen einzige restriktive Zielzuordnung auf einem inaktiven Knoten liegt.]');

  dac_admin.merge_entity(
    p_den_id => 'DOC_INACTIVE_DIMENSION_RESTRICTION',
    p_den_det_id => 'DOCUMENT',
    p_den_external_id => 'doc-inactive-dimension-restriction',
    p_den_display_name => 'Dokument mit inaktiver Dimension',
    p_den_description => q'[Aktives Dokument, dessen einzige restriktive Zielzuordnung in einer inaktiven Dimension liegt.]');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_ALICE',
    p_dena_ddn_id => 'TOPOLOGY_TEAM');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_ALICE',
    p_dena_ddn_id => 'JOB_TEAM_LEAD');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_ALICE',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_BOB',
    p_dena_ddn_id => 'TOPOLOGY_DEPARTMENT');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_BOB',
    p_dena_ddn_id => 'JOB_DEPARTMENT_LEAD');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_BOB',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_CONTROLLING');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_CAROL',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_DAVE',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A',
    p_dena_valid_from => date '2020-01-01',
    p_dena_valid_to => date '2020-12-31');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_ERIN',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A',
    p_dena_active => pit_util.C_FALSE);

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_ERIN',
    p_dena_ddn_id => 'TOPOLOGY_INACTIVE_TEAM');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_FRANK',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_FRANK',
    p_dena_ddn_id => 'ACCESS_ZONE_INTERNAL');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_GRACE',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A',
    p_dena_valid_from => date '2099-01-01',
    p_dena_valid_to => date '2099-12-31');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_HEIDI',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_CONTROLLING');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_HEIDI',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'USER_IVAN',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_PROJECT_A_PLAN',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_PROJECT_A_SECRET',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A_CONFIDENTIAL');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_CONTROLLING_REPORT',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_CONTROLLING');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_INACTIVE_ARCHIVE',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_PROJECT_A_INTERNAL',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_PROJECT_A_INTERNAL',
    p_dena_ddn_id => 'ACCESS_ZONE_INTERNAL');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_INACTIVE_NODE_RESTRICTION',
    p_dena_ddn_id => 'DISTRIBUTION_LIST_INACTIVE_CASE');

  dac_admin.merge_entity_node_assignment(
    p_dena_den_id => 'DOC_INACTIVE_DIMENSION_RESTRICTION',
    p_dena_ddn_id => 'ACCESS_PHASE_DRAFT');

  commit;
end;
/
