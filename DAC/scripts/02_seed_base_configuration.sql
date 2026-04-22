prompt Seeding DAC base configuration

begin
  dac_admin.merge_entity_type(
    p_det_id => 'USER',
    p_det_name => 'Benutzer',
    p_det_description => q'[Berechtigter Benutzer, aus dessen Perspektive Zugriffsentscheidungen ausgewertet werden.]',
    p_det_is_subject => pit_util.C_TRUE,
    p_det_display_sequence => 10);

  dac_admin.merge_entity_type(
    p_det_id => 'TOPOLOGY',
    p_det_name => 'Topologie',
    p_det_description => q'[Organisationseinheit wie Abteilung, Team oder vergleichbare organisatorische Verortung.]',
    p_det_is_subject => pit_util.C_FALSE,
    p_det_display_sequence => 20);

  dac_admin.merge_entity_type(
    p_det_id => 'JOB',
    p_det_name => 'Berufsgruppe',
    p_det_description => q'[Berufs- oder Funktionsgruppe wie Geschäftsführer, Abteilungsleiter oder Teamleiter.]',
    p_det_is_subject => pit_util.C_FALSE,
    p_det_display_sequence => 30);

  dac_admin.merge_entity_type(
    p_det_id => 'DISTRIBUTION_LIST',
    p_det_name => 'Distribution List',
    p_det_description => q'[Verteiler für Dokumente und andere zielgerichtet verteilte Inhalte.]',
    p_det_is_subject => pit_util.C_FALSE,
    p_det_display_sequence => 40);

  dac_admin.merge_dimension(
    p_ddi_id => 'TOPOLOGY',
    p_ddi_name => 'Topologie',
    p_ddi_description => q'[Filterdimension für organisatorische Verortungen wie Abteilungen und Teams.]',
    p_ddi_is_restrictive => pit_util.C_FALSE,
    p_ddi_is_filter => pit_util.C_TRUE,
    p_ddi_display_sequence => 10);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'TOPOLOGY_DEPARTMENT',
    p_ddn_ddi_id => 'TOPOLOGY',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Abteilung',
    p_ddn_description => q'[Organisatorische Einheit auf Abteilungsebene.]',
    p_ddn_display_sequence => 10);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'TOPOLOGY_TEAM',
    p_ddn_ddi_id => 'TOPOLOGY',
    p_ddn_ddn_id => 'TOPOLOGY_DEPARTMENT',
    p_ddn_name => 'Team',
    p_ddn_description => q'[Organisatorische Einheit auf Teamebene.]',
    p_ddn_display_sequence => 20);

  dac_admin.merge_dimension(
    p_ddi_id => 'JOB',
    p_ddi_name => 'Berufsgruppe',
    p_ddi_description => q'[Filterdimension für Berufs- und Funktionsgruppen.]',
    p_ddi_is_restrictive => pit_util.C_FALSE,
    p_ddi_is_filter => pit_util.C_TRUE,
    p_ddi_display_sequence => 20);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'JOB_MANAGING_DIRECTOR',
    p_ddn_ddi_id => 'JOB',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Geschäftsführer',
    p_ddn_description => q'[Geschäftsführende Rolle oder vergleichbare Leitungsfunktion.]',
    p_ddn_display_sequence => 10);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'JOB_DEPARTMENT_LEAD',
    p_ddn_ddi_id => 'JOB',
    p_ddn_ddn_id => 'JOB_MANAGING_DIRECTOR',
    p_ddn_name => 'Abteilungsleiter',
    p_ddn_description => q'[Leitungsrolle für eine Abteilung.]',
    p_ddn_display_sequence => 20);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'JOB_TEAM_LEAD',
    p_ddn_ddi_id => 'JOB',
    p_ddn_ddn_id => 'JOB_DEPARTMENT_LEAD',
    p_ddn_name => 'Teamleiter',
    p_ddn_description => q'[Leitungsrolle für ein Team.]',
    p_ddn_display_sequence => 30);

  dac_admin.merge_dimension(
    p_ddi_id => 'DISTRIBUTION_LIST',
    p_ddi_name => 'Distribution List',
    p_ddi_description => q'[Restriktive Dimension für Verteiler. Explizite Ausschlüsse können den Zugriff auf verteilte Dokumente verhindern.]',
    p_ddi_is_restrictive => pit_util.C_TRUE,
    p_ddi_is_filter => pit_util.C_FALSE,
    p_ddi_display_sequence => 30);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'DISTRIBUTION_LIST_PROJECT_A',
    p_ddn_ddi_id => 'DISTRIBUTION_LIST',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Projekt A',
    p_ddn_description => q'[Verteiler für Dokumente und Informationen zum Projekt A.]',
    p_ddn_display_sequence => 10);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'DISTRIBUTION_LIST_CONTROLLING',
    p_ddn_ddi_id => 'DISTRIBUTION_LIST',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Controlling',
    p_ddn_description => q'[Verteiler für Controlling-Dokumente und -Informationen.]',
    p_ddn_display_sequence => 20);

  dac_admin.merge_dimension_node(
    p_ddn_id => 'DISTRIBUTION_LIST_RESTRUCTURING',
    p_ddn_ddi_id => 'DISTRIBUTION_LIST',
    p_ddn_ddn_id => null,
    p_ddn_name => 'Restrukturierung',
    p_ddn_description => q'[Verteiler für Dokumente und Informationen zur Restrukturierung.]',
    p_ddn_display_sequence => 30);

  commit;
end;
/
