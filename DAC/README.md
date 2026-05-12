# DAC

Dimensional Access Control data model for matrix-based authorization decisions.

This directory contains the actual installable DAC component. Repository-level
helpers live in `../install_scripts`; tests live in `../unit_tests`.

## Installation Layout

- Repository-level `../install.sh` and `../install.cmd` still exist for wrapper-based installs.
- Direct SQLcl entry scripts are available as `../install.sql`, `../install_tests.sql`, `../uninstall.sql`.
- The same direct entry scripts also exist locally as `install.sql`, `install_tests.sql`, `uninstall.sql` when working from the `DAC` directory.
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

## Direct SQLcl Usage

From the repository root:

`sql user/password@service @install.sql`

`sql user/password@service @install_tests.sql`

`sql user/password@service @uninstall.sql`

From the `DAC` directory:

`sql user/password@service @install.sql`

`sql user/password@service @install_tests.sql`

`sql user/password@service @uninstall.sql`

Unit-test seed data and test packages live below `../unit_tests` and are
installed through the repository-root `install_tests` action.
