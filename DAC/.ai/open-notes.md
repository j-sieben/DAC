# Open Notes

## Upgrade Scripts

The project currently focuses on clean install/reinstall. For existing schemas,
the following changes are destructive and would need a migration script if data
must be preserved:

- `dac_assignment_modes` table/view removed.
- `dena_dam_id` removed from `dac_entity_node_assignments`.
- `dena_id` previously removed from `dac_entity_node_assignments`.
- effective access tables were replaced by materialized views.

`Pre_Install/clean_up_install.sql` is intentionally non-destructive because the
generic installer calls it during normal install. Use the repository-level
uninstall/drop action, which calls `Pre_Install/drop_all.sql`, for a clean
rebuild. This is still not a migration.

## Materialized View Caveats

The effective access MVs use complete refresh. This is intentional because the
live views are complex and include hierarchy traversal and current-date validity
logic.

Do not add table comments to MVs; use file header comments plus column comments.

## Hierarchy Semantics

`dac_access_decision_reasons_v` currently treats nodes as related both
ancestor-to-descendant and descendant-to-ancestor through `related_nodes`.
This means a parent assignment can match a child target node and vice versa.

If future requirements need stricter directionality, this is the key place to
change.

## Project Decoupling

The user intends to detach `berechtigungsmatrix` from the KISMON repository
context. When doing that, watch for references to shared utilities such as:

- PIT/PIT_ADMIN/PIT_UTIL
- MSG constants
- `msg_args`, `msg_params`, `msg_param`

Those dependencies are used by packages and seed messages. Decide whether they
remain external prerequisites or need to be brought into the standalone project.

## VSCode SQL Runner

The component install scripts rely on relative SQL*Plus includes. The
repository-root launchers change into the `DAC` directory before invoking the
generic installer from `install_scripts/install`.
