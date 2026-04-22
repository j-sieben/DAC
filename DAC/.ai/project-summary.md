# Berechtigungsmatrix Project Summary

## Purpose

The project implements a Dimensional Access Control (DAC) model for deciding
which subject entities, primarily users, may access target entities, such as
documents. Access is based on positive assignments of entities to dimension
nodes.

The current model is deliberately default-deny:

- A target asset is restrictive only when it is assigned to an active node in an
  active restrictive dimension.
- A subject gets access only when it has a matching positive assignment in every
  restrictive dimension that applies to the target.
- Missing subject assignment means no access.
- There is no assignment mode and no explicit negative assignment.

## Current Location

Core DDL lives under:

```text
berechtigungsmatrix/dac_ddl
```

Important entry points:

- `install.sql` installs the DAC model, packages, seed data, materialized views,
  and read views.
- `drop_all.sql` drops DAC objects for easier reinstall. It is intentionally not
  included by `install.sql`.
- `tests/install_tests.sql` installs the utPLSQL demo test package.

## Core Tables

- `dac_match_states`
  Lookup for per-dimension calculation states: `MATCH`, `NO_MATCH`,
  `NOT_APPLICABLE`, `FILTER_VALUE`.

- `dac_entity_types`
  Defines entity categories. The important subject flag is `det_is_subject`.

- `dac_entities`
  Matrix participants. Users and documents are both entities. Active flag and
  validity band determine whether entities participate in current calculation.

- `dac_dimensions`
  Defines dimensions. `ddi_is_restrictive = 'Y'` means target assignments in
  that dimension restrict access. `ddi_is_filter = 'Y'` identifies filter
  dimensions.

- `dac_dimension_nodes`
  Hierarchical nodes inside a dimension. Parent is `ddn_ddn_id`. Hierarchical
  matching currently treats ancestor/descendant as related in both directions.

- `dac_entity_node_assignments`
  Positive assignment of an entity to a dimension node. Primary key is:

```sql
(dena_den_id, dena_ddn_id)
```

There is intentionally no `dena_id` and no assignment mode.

## Calculation Views

- `dac_access_decision_reasons_v`
  Canonical live per-dimension calculation. It builds active subject-target
  pairs, active restrictive dimensions, active assignments, hierarchy closure,
  and returns one reason row per restrictive dimension per subject-target pair.

- `dac_access_decisions_v`
  Canonical live overall access decision. It aggregates reason rows:

  - any `NO_MATCH` -> `dad_access = 'N'`
  - any `MATCH` and no `NO_MATCH` -> `dad_access = 'Y'`
  - no restrictive target assignments -> `dad_access = 'Y'`

## Published Access Matrix

Reads should normally use the materialized effective access objects:

- `dac_effective_accesses`
  Materialized view over `dac_access_decisions_v`.

- `dac_effective_access_reasons`
  Materialized view over `dac_access_decision_reasons_v`.

- `dac_effective_accesses_v`
  Read view enriching the effective access MV with entity display names/types and
  MV refresh timestamp.

- `dac_effective_access_reasons_v`
  Read view enriching the effective reason MV with dimension/node/match-state
  names.

- `dac_effective_access_status_v`
  Shows last refresh date, refresh method, staleness, compile state, and row
  counts for the effective access MVs.

The materialized views refresh complete on demand and have a daily `NEXT`
refresh around 02:00.

## Packages

- `dac_admin`
  Low-level administrative merge/delete API for master data and assignments.
  Also publishes the current access matrix via:

```sql
dac_admin.refresh_effective_accesses;
```

- `dac_structure`
  Business API for structural changes such as merge/deactivate/move of entity
  types, entities, dimensions, and dimension nodes.

- `dac_assignments`
  Business API for positive entity assignments. It supports assign, remove,
  replace assignments in a dimension, and copy assignments between entities.

## Seed Data

- `data/00_seed_messages.sql`
  PIT/message definitions used by validation.

- `data/01_seed_lookup_values.sql`
  Match state lookup values.

- `data/02_seed_base_configuration.sql`
  Base entity types, dimensions, and dimension nodes.

- `data/03_seed_demo_access_cases.sql`
  Demo users, demo documents, and positive assignments used by the utPLSQL demo
  tests.

