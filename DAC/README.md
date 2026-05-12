# DAC

Dimensional Access Control data model for matrix-based authorization decisions.

This directory contains the actual installable DAC component. Repository-level
helpers live in `../install_scripts`; tests live in `../unit_tests`.

## Installation Layout

- Repository-level `../install.sh` and `../install.cmd` run the SQL installer
  through SQL*Plus using `../install_scripts/install/install.sql`.
- The generic installer treats missing object-category scripts as optional.
- Repository-level uninstall/drop actions call `Pre_Install/drop_all.sql`
  explicitly before the generic uninstall path.

Object sources are organized in the installer target architecture:

- `Mat_views`: materialized effective access objects.
- `Packages`: PL/SQL package specifications and bodies.
- `Pre_Install`: drop and pre-install scripts.
- `Scripts`: message, lookup, and base configuration scripts.
- `Tables`: base table DDL.
- `Views`: read and calculation views.

Object categories without DAC objects do not need local directories or no-op
install files.

The repository-root shell and batch launchers change into this directory before
invoking SQL*Plus so relative component includes resolve.

Unit-test seed data and test packages live below `../unit_tests` and are
installed through the repository-root `install_tests` action.
