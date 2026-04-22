# Design Decisions

## Positive-Only Assignments

Assignment modes were removed. The model no longer supports `INCLUDE` or
`EXCLUDE`; an entity-node assignment is positive by definition.

Rationale:

- Missing access is visible because users report it.
- Excess access is usually silent and therefore dangerous.
- Explicit negative assignments create a tempting but operationally risky model:
  broad access with a few exceptions.
- New users and new sensitive assets should be safe by default and require
  explicit positive assignment.

Consequence:

- `dac_entity_node_assignments` has no `dena_dam_id`.
- `dac_assignment_modes` table/view and related admin APIs are gone.
- Match state `EXCLUDED` is gone.
- Access denial is represented by `NO_MATCH`, not by negative override.

## No Technical Assignment ID

`dena_id` was removed. `dac_entity_node_assignments` uses a composite primary
key:

```sql
(dena_den_id, dena_ddn_id)
```

Rationale:

- The row has no independent business identity.
- A technical key encouraged encoded names in seeds and APIs.
- The natural uniqueness is entity plus dimension node.
- Multiple validity bands for the same entity/node were explicitly rejected as a
  logical maintenance burden.

## Materialized Effective Access

The effective access matrix is materialized using materialized views rather than
manually maintained tables.

Rationale:

- Reads are frequent, permission changes are rare.
- Materialized views communicate that the data is derived and published.
- Admins can control the publication time by explicitly refreshing.
- Daily refresh handles expiring validity bands.

Important objects:

- `dac_access_decisions_v` and `dac_access_decision_reasons_v` are the canonical
  live calculation.
- `dac_effective_accesses` and `dac_effective_access_reasons` are published
  materialized snapshots.
- `dac_admin.refresh_effective_accesses` performs an explicit complete refresh.

## Refresh Is Publication

Saving a permission change does not immediately publish it to effective access
readers. The publication moment is the refresh of the materialized views.

This is intentional so admins can stage changes and decide when they become
public.

## Table Comments on MVs

Do not add `comment on table` statements for materialized views in this project.
Column comments are allowed. MV descriptions should remain in file header
comments.

## KISMON Decoupling

The project is being separated from the broader KISMON context. Future AI work
should use this `.ai` folder and the files under `berechtigungsmatrix/dac_ddl`
as the local source of truth.

