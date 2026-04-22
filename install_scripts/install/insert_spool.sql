begin
  $IF $$HAS_SPOOL $THEN
    &util_owner..spool_pkg.insertSpool(
      '&KOMPONENTE.',
      '&INSTALL_USER.',
      q'[&MSG.]');
  $ELSE
    null;
  $END
end;
/
