# Berechtigungsmatrix

Diese Kopie isoliert die Berechtigungsverwaltung aus der KIS Monitor Anwendung.

## Inhalt

- `scripts/core/authentication`: urspruengliche Installations-, Parameter-, Meldungs- und Daten-Skripte des Authentifizierungsmoduls.
- `scripts/changes_3_1_0`: Change-Skripte, die vom Authentication-Installationsskript direkt referenziert werden.
- `src/kismon/sql/tables`: zentrale Tabellen und Materialized Views der Berechtigungsverwaltung.
- `src/kismon/sql/types`: SQL-Objekttypen fuer `USER_GRANTS` und Hierarchie-Nodes.
- `src/kismon/sql/views`: Views, die die Matrix auf Module, Reports, Regeln, Stationen, Fachrichtungen und Standardbenutzer abbilden.
- `src/kismon/sql/root_views`: weitere Konsumenten-Views aus `src/kismon/sql`, die `USER_GRANTS` nutzen.
- `src/kismon/plsql`: Packages fuer Benutzerverwaltung, Matrixberechnung, Hierarchiepflege und Admin-UI-Anbindung.
- `src/kismon/apex/javascript/plugins`: Frontend-Assets fuer die Hierarchie-/Checkbox-Darstellung.
- `src/kismon/apex/themes/delta`: jQuery-UI/Accordion-Assets, die von aelteren APEX-Exports bzw. Templates referenziert werden.
- `src/kismon/application_exports` und `scripts/changes_3_1_0/apex_application.sql`: APEX-Exports mit der Plugin-Definition `DE.CONDES-SOFTWARE.APEX/ASSIGN_HIERARCHY`.
- `installations/krefeld/KISMON_APP_2000_RUN_ONLY.sql`: aelterer APEX-Export mit eingebetteten `create_plugin_file`-Bloecken; relevant, weil nicht alle `accordionHierarchy`-Dateien als lose Quellen im Repository vorhanden sind.

## Kernobjekte

- `AUTH_USERS`: Anwendungsbenutzer.
- `TREE_CATEGORY`, `TREE`, `TREE_ACCESS_TYPE`, `TREE_ACCESS`: Hierarchie- und Rechtezuordnung.
- `STANDARD_USER`: Template-Benutzer und automatisierte Standardbenutzerpflege.
- `USER_GRANTS`: Materialized View der berechneten Berechtigungsmatrix.
- `AUTH_USER`: API fuer Login, Benutzerverwaltung, Rechtepflege und Berechnung von `USER_GRANTS`.
- `UTL_HIERARCHY` und `PLUGIN_HIERARCHY`: Pflege der zugrunde liegenden Hierarchien und UI-Speicherung.
- `PLUGIN_HIERARCHY.render_accordion_hierarchy`: APEX-Region-Plugin-Renderer fuer die Matrixdimensionen als Akkordeon mit Checkbox-Hierarchien.
- `assign_hierarchy/jQuery.Tree.js` und `assign_hierarchy/css/jQuery.Tree.css`: aeltere Checkbox-Tree-Implementierung mit den Checkbox-Bildern.
- `jstree/jquery.jstree.js` plus `_lib` und Themes: Laufzeit fuer die neuere Hierarchieanzeige mit Checkbox-Plugin.

## Hinweise

Diese Kopie ist eine fachliche Isolation der Berechtigungsmatrix, keine vollstaendige Standalone-Installation. Die Packages referenzieren weiterhin gemeinsame Infrastruktur des Originalsystems, z.B. `PIT`, `MSG`, `UTIL`, `PARAM`, `CONSTANTS`, `VERSION`, `APEX` und teilweise fachliche Tabellen wie `KISMON_SUB_MODULES` oder `HIERARCHY_DEFINITION`.

Im Quellbaum ist keine lose Datei `plugins/accordionHierarchy/js/ui.accordionHierarchy.js` auffindbar, obwohl `PLUGIN_HIERARCHY` sie zur Laufzeit referenziert. Deshalb wurden die APEX-Exports mitkopiert; dort sind Plugin-Definitionen und teils Plugin-Dateien eingebettet.
