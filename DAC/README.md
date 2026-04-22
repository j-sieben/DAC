# DAC

Dimensional Access Control data model for matrix-based authorization decisions.

This directory contains the actual installable DAC component. Repository-level
helpers live in `../install_scripts`; tests live in `../unit_tests`.

## Installation Layout

- `install.sql` installs the DAC component.
- `reinstall.sql` drops and reinstalls the DAC component.
- `drop_all.sql` drops DAC objects through `Pre_Install/clean_up_install.sql`.
- Repository-level `../install.sh` and `../install.cmd` run the SQL installer
  through SQL*Plus.

Object sources are organized in the installer target architecture:

- `Applications`: APEX application installers; currently empty.
- `Functions`: standalone functions; currently empty.
- `Grants`: grant scripts; currently empty.
- `Help_Packages`: helper package specifications and bodies; currently empty.
- `Mat_views`: materialized effective access objects.
- `Packages`: PL/SQL package specifications and bodies.
- `Pre_Install`: cleanup and pre-install scripts.
- `Procedures`: standalone procedures; currently empty.
- `Scripts`: message, lookup, base configuration, demo seed, and run-once scripts.
- `Sequences`: sequences; currently empty.
- `Synonyms`: synonyms; currently empty.
- `Tables`: base table DDL.
- `Triggers`: triggers; currently empty.
- `Types`: object type specifications and bodies; currently empty.
- `Views`: read and calculation views.

Each directory has an `install_*.sql` file. Empty object types are represented by
no-op install files that print that there is nothing to install.

The SQL entry points are intended to run from this `DAC` directory so relative
SQL*Plus `@@` includes resolve. The repository-root shell and batch launchers
change into this directory before invoking SQL*Plus.
