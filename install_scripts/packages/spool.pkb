CREATE OR REPLACE PACKAGE BODY spool_pkg
AS

  ---------------------------------------------------------------------------------
  -- Prozedur: insertSpool
  --
  -- Historie:
  -- 26.06.2018 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------
  PROCEDURE insertSpool (ip_AmsKomponente IN spool.spoo_ams_komponente%TYPE,
                         ip_Benutzer IN spool.spoo_benutzer%TYPE,
                         ip_Text IN spool.spoo_text%TYPE )
  IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    INSERT INTO SPOOL(spoo_id, spoo_ams_komponente, spoo_benutzer, spoo_text)
    VALUES (spoo_id_seq.NEXTVAL, UPPER(ip_AmsKomponente), UPPER(ip_Benutzer), ip_Text);
    COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END insertSpool;
  ---------------------------------------------------------------------------------


  ---------------------------------------------------------------------------------
  -- Prozedur: deleteSpool
  --
  -- Historie:
  -- 27.06.2018 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------
  PROCEDURE deleteSpool (ip_AmsKomponente IN spool.spoo_ams_komponente%TYPE,
                         ip_Benutzer IN spool.spoo_benutzer%TYPE)
  IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    DELETE SPOOL
     WHERE spoo_benutzer = UPPER(ip_Benutzer)
       AND spoo_ams_komponente = UPPER(ip_AmsKomponente);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Spool-Loeschen fuer ' || UPPER(ip_Benutzer) || '/' || UPPER(ip_AmsKomponente) || ' erfolgreich.');

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Spool-Loeschen fuer ' || UPPER(ip_Benutzer) || '/' || UPPER(ip_AmsKomponente) || ' nicht erfolgreich.');
  END deleteSpool;
  ---------------------------------------------------------------------------------

END spool_pkg;
/
