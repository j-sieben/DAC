CREATE OR REPLACE PACKAGE spool_pkg
AS

  ---------------------------------------------------------------------------------
  -- Procedure: insertSpool
  --
  -- Zweck: Die Methode traegt einen Satz für eine DB-Installation in die
  -- SPOOL-Tabelle ein.
  --
  -- Parameter: ip_AmsKomponente(input) - AMS-Komponente zu der die gespoolten Daten gehoeren
  --            ip_Benutzer(input) - Benutzer, unter dem die Installation ablaeuft
  --            ip_Text (input) - einzutragender Text
  --
  ---------------------------------------------------------------------------------
  PROCEDURE insertSpool (ip_AmsKomponente IN spool.spoo_ams_komponente%TYPE,
                         ip_Benutzer IN spool.spoo_benutzer%TYPE,
                         ip_Text IN spool.spoo_text%TYPE );
  ---------------------------------------------------------------------------------


  ---------------------------------------------------------------------------------
  -- Procedure: deleteSpool
  --
  -- Zweck: Die Methode loescht alle Saetze für einen User aus der SPOOL-Tabelle
  --
  -- Parameter: ip_AmsKomponente(input) - AMS-Komponente zu der die gespoolten Daten gehoeren
  --            ip_Benutzer(input) - Benutzer, fuer den die Saetze geloescht werden
  --
  ---------------------------------------------------------------------------------
  PROCEDURE deleteSpool (ip_AmsKomponente IN spool.spoo_ams_komponente%TYPE,
                         ip_Benutzer IN spool.spoo_benutzer%TYPE);
  ---------------------------------------------------------------------------------

END spool_pkg;
/
