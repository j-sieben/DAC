prompt Seeding DAC messages

begin
  pit_admin.merge_message_group(
    p_pmg_name => 'DAC',
    p_pmg_description => 'Nachrichten und übersetzbare Stammdaten für Dimensional Access Control');

  pit_admin.merge_message(
    p_pms_name => 'DAC_DIMENSION_NODE_NOT_FOUND',
    p_pms_text => q'[Der Dimensionsknoten "#1#" existiert nicht.]',
    p_pms_description => q'[Ein angeforderter Dimensionsknoten konnte nicht gefunden werden.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'DAC_PARENT_DIMENSION_NODE_NOT_FOUND',
    p_pms_text => q'[Der übergeordnete Dimensionsknoten "#1#" existiert nicht.]',
    p_pms_description => q'[Ein angeforderter übergeordneter Dimensionsknoten konnte nicht gefunden werden.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'DAC_ENTITY_NOT_FOUND',
    p_pms_text => q'[Die Entität "#1#" existiert nicht.]',
    p_pms_description => q'[Eine angeforderte Entität konnte nicht gefunden werden.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'DAC_DIMENSION_NODE_PARENT_SELF',
    p_pms_text => q'[Ein Dimensionsknoten darf nicht unter sich selbst verschoben werden.]',
    p_pms_description => q'[Die Zielposition eines Dimensionsknotens verweist auf den Knoten selbst.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'DAC_DIMENSION_NODE_PARENT_OTHER_DIMENSION',
    p_pms_text => q'[Ein Dimensionsknoten darf nicht in eine andere Dimension verschoben werden.]',
    p_pms_description => q'[Der neue übergeordnete Knoten liegt in einer anderen Dimension als der zu verschiebende Knoten.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'DAC_DIMENSION_NODE_PARENT_DESCENDANT',
    p_pms_text => q'[Ein Dimensionsknoten darf nicht unter einen eigenen Nachfolger verschoben werden.]',
    p_pms_description => q'[Die Zielposition eines Dimensionsknotens liegt innerhalb seines eigenen Teilbaums.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'DAC_DIMENSION_NODE_NOT_IN_DIMENSION',
    p_pms_text => q'[Der Dimensionsknoten "#1#" gehört nicht zur Dimension "#2#".]',
    p_pms_description => q'[Eine Zuordnung verweist auf einen Dimensionsknoten, der nicht zur angegebenen Dimension gehört.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'DAC_INVALID_VALIDITY_BAND',
    p_pms_text => q'[Das Gültigkeitsband "#1#" ist ungültig. Der Beginn darf nicht nach dem Ende liegen.]',
    p_pms_description => q'[Ein Gültigkeitsband wurde mit vertauschten Grenzen übergeben.]',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pmg_name => 'DAC',
    p_pms_pml_name => 'GERMAN');

  pit_admin.create_message_package;

  commit;
end;
/
