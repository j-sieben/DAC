# DAC

Dimensional Access Control data model for matrix-based authorization decisions.

This directory contains the actual installable DAC component. Repository-level
helpers live in `../install_scripts`; tests live in `../unit_tests`.

## Installation Layout

- Repository-level `../install.sh` and `../install.cmd` run the SQL installer
  through SQL*Plus using `../install_scripts/install/install.sql`.
- The generic installer calls `Pre_Install/clean_up_install.sql` before
  installing component objects. This local script is intentionally non-destructive.
- Repository-level uninstall/drop actions call `Pre_Install/drop_all.sql`
  explicitly before the generic uninstall path.

Object sources are organized in the installer target architecture:

- `Applications`: APEX application installers; currently empty.
- `Functions`: standalone functions; currently empty.
- `Grants`: grant scripts; currently empty.
- `Mat_views`: materialized effective access objects.
- `Packages`: PL/SQL package specifications and bodies.
- `Pre_Install`: cleanup and pre-install scripts.
- `Procedures`: standalone procedures; currently empty.
- `Scripts`: message, lookup, base configuration, and run-once scripts.
- `Sequences`: sequences; currently empty.
- `Synonyms`: synonyms; currently empty.
- `Tables`: base table DDL.
- `Triggers`: triggers; currently empty.
- `Types`: object type specifications and bodies; currently empty.
- `Views`: read and calculation views.

Each directory has an `install_*.sql` file. Empty object types are represented by
no-op install files that print that there is nothing to install.

The repository-root shell and batch launchers change into this directory before
invoking SQL*Plus so relative component includes resolve.

Unit-test seed data and test packages live below `../unit_tests` and are
installed through the repository-root `install_tests` action.
