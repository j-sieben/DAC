prompt Seeding DAC lookup values

begin
  dac_admin.merge_match_state(
    p_dms_id => 'MATCH',
    p_dms_name => 'Treffer',
    p_dms_description => 'Die Verortungen von Subjekt und Ziel stimmen in dieser Dimension überein.',
    p_dms_display_sequence => 10);

  dac_admin.merge_match_state(
    p_dms_id => 'NO_MATCH',
    p_dms_name => 'Kein Treffer',
    p_dms_description => 'Die Verortungen von Subjekt und Ziel stimmen in dieser Dimension nicht überein.',
    p_dms_display_sequence => 20);

  dac_admin.merge_match_state(
    p_dms_id => 'NOT_APPLICABLE',
    p_dms_name => 'Nicht anwendbar',
    p_dms_description => 'Diese Dimension schränkt die ausgewertete Zugriffsentscheidung nicht ein.',
    p_dms_display_sequence => 30);

  dac_admin.merge_match_state(
    p_dms_id => 'FILTER_VALUE',
    p_dms_name => 'Filterwert',
    p_dms_description => 'Dieser Eintrag beschreibt einen durch die Dimension beigesteuerten Filterwert.',
    p_dms_display_sequence => 40);

  commit;
end;
/
