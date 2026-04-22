---
name: oracle-database-table-conventions
description: Use this skill when creating or changing Oracle database table DDL, especially DAC/Berechtigungsmatrix tables, PL/SQL install scripts, lookup tables, constraints, comments, and PIT translatable item integration.
---

# Oracle Database Table Conventions

Use these conventions for Oracle DDL changes in this project unless the user explicitly overrides them.

## Files And Workflow

- Put DDL statements into separate files per table.
- Keep install scripts explicit and ordered: lookup/master tables before dependent tables, seed scripts after their tables and before dependent data.
- Use `apply_patch` for edits.
- After editing, search for stale column names, stale comments, stale constraints, and old value-list checks.

## Naming

- Table names are English and plural.
- DAC table names start with `DAC_`.
- Column prefixes are derived from the table name word parts, including `DAC`, with at least three characters and uniqueness across tables:
  - `DAC_ENTITY_TYPES` -> `DET`
  - `DAC_ENTITIES` -> `DEN`
  - `DAC_DIMENSIONS` -> `DDI`
  - `DAC_DIMENSION_NODES` -> `DDN`
  - `DAC_ENTITY_NODE_ASSIGNMENTS` -> `DENA`
  - `DAC_EFFECTIVE_ACCESSES` -> `DEA`
  - `DAC_EFFECTIVE_ACCESS_REASONS` -> `DEAR`
- Prefixes may be longer than three characters when the table name has more word parts.
- Primary key columns are named `<prefix>_ID`.
- Do not add separate `<prefix>_KEY` columns when `<prefix>_ID` is already alphanumeric and stable.
- Keep external reference columns only when they identify an entity in an owning external application context, not as a second local key.
- Foreign key columns are named `<own_prefix>_<referenced_column>`, with a role segment when needed, e.g. `dea_subject_den_id`.
- Do not shorten constraint names for Oracle's old 30-byte limit; Oracle 12+ supports 128-byte identifiers.

## Datatypes

- Technical alphanumeric identifiers, including IDs, are `varchar2(128 byte)`.
- Human-readable names are typically `varchar2(... char)`.
- Boolean-like flags are currently `char(1 byte)` but should be named as future booleans.
- Do not suffix flags with `_yn`; `is` in the column name is enough when applicable.

## Constraints

- Constraints must be named.
- Prefer inline column constraints where they belong:
  - `den_display_name varchar2(400 char) constraint den_display_name_nn not null`
  - `det_active char(1 byte) default on null 'Y' constraint det_active_chk check(det_active in ('Y', 'N'))`
- Boolean checks use only `check(<column> in ('Y', 'N'))`.
- Do not add a separate `not null` constraint for Boolean flags unless the user explicitly asks.
- Do not add `and <column> is not null` to Boolean checks.
- Use `default on null` for Boolean defaults.
- For PL/SQL package defaults against PIT `core`, use `pit_util.C_TRUE` and `pit_util.C_FALSE` for current char-based flags. Do not use the Oracle 23ai-oriented `core_23` assumptions unless the target database is explicitly 23ai.
- Use structural check constraints for structural invariants, such as date ranges or parent/self exclusion.

## Lookup Tables

- Do not model business value lists as `check (... in (...))`.
- Use small lookup/master tables plus foreign keys for business codes such as assignment modes or match states.
- Seed lookup values in a separate install/data script.
- Boolean `Y/N` is the exception and may remain a check because it can later become Oracle `boolean`.

## Internationalized Master Data

For translatable master/lookup tables, use the PIT translatable item pattern:

```sql
/**
  Table: DAC_EXAMPLES
    Short table description.

  Columns:
    dex_id - Primary key, also reference to PIT_TRANSLATABLE_ITEM
    dex_pgr_id - Message group, is required as a reference to Translatable Item. Constant value DAC
    dex_active - Flag indicating whether the row is active

  Dependencies:
    dex_id, dex_pgr_id - references <PIT_TRANSLATABLE_ITEM> (pti_uid, pti_upmg)
 */
create table dac_examples (
  dex_id varchar2(128 byte) constraint dex_id_chk check(dex_id = upper(dex_id) and regexp_instr(dex_id, '^[A-Z][A-Z0-9_]+$') = 1),
  dex_pgr_id varchar2(128 byte) default on null 'DAC' constraint dex_pgr_id_chk check(dex_pgr_id = 'DAC'),
  dex_active char(1 byte) default on null 'Y' constraint dex_active_chk check(dex_active in ('Y', 'N')),
  constraint dac_examples_pk primary key (dex_id),
  constraint dex_pti_fk foreign key(dex_id, dex_pgr_id)
    references b3m_utils.pit_translatable_item(pti_uid, pti_upmg)
);

create index dex_pti_fk_ix on dac_examples(dex_id, dex_pgr_id);
comment on table dac_examples is 'Short table description.';
comment on column dac_examples.dex_id is 'Primary key, also reference to PIT_TRANSLATABLE_ITEM.';
comment on column dac_examples.dex_pgr_id is 'Message group, is required as a reference to Translatable Item. Constant value DAC.';
comment on column dac_examples.dex_active is 'Flag indicating whether the row is active.';
```

- The message group for DAC is always `DAC`.
- Translatable base tables do not store their own `<prefix>_name` or `<prefix>_description` columns.
- Provide `<prefix>_name` and `<prefix>_description` through access views from `pit_translatable_item_v`.
- Keep the existing English DAC column names in access views; do not translate column names into German aliases such as `*_beschreibung` or `*_aktiv`.
- Add Natural Docs comments before `create table`.
- Add regular `comment on table` and `comment on column` statements after the DDL.
- Do not add PIT translation FKs to transaction/calculation tables unless their own labels are translatable master data.

Example access view pattern:

```sql
create or replace force view dac_assignment_modes_v as
select dam_id,
       pti_name dam_name,
       pti_description dam_description,
       dam_display_sequence,
       dam_active
  from dac_assignment_modes
  join pit_translatable_item_v
    on dam_id = pti_id
   and dam_pgr_id = pti_pmg_name;
```

## Access Layer

- Build read access through `*_v` views.
- Build write access through packages that operate on these views and encapsulate base table changes.
- Document access packages with Natural Docs comments:
  - Public package description and public methods are documented in the package specification.
  - Public method comments in the package specification include `Parameters:` and `Errors:` sections.
  - Public method implementations in the package body get only `Procedure: <method>` plus `See: <PACKAGE.method>`.
  - Private methods are documented in the package body.
- For master data packages, provide:
  - `validate_* (p_row in <view>%rowtype)`
  - `merge_*` with scalar parameters
  - overloaded `merge_* (p_row in <view>%rowtype)`
  - `delete_*`
- `merge_*` methods for translatable master data call `pit_admin.merge_translatable_item` for name/description, then merge the technical base table.
- `delete_*` methods check dependent usage first, delete the base row, then call `pit_admin.delete_translatable_item`.
- Use `pit.enter_mandatory` and `pit.leave_mandatory` around package operations.

## DAC Modeling Notes

- DAC means Dimensional Access Control.
- Model participants uniformly as entities where practical: users, reports, rules, modules, and other assets.
- Users are special because they can be evaluated as subjects, but they are still entities.
- Put entity-specific attributes into satellite/external tables that reference `DAC_ENTITIES`, not into the DAC core tables.
- A restrictive dimension restricts access only when the target asset is located in that dimension; if the target is not located there, the dimension imposes no restriction.
