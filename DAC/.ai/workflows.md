# Workflows

## Install

Run from the `dac_ddl` directory so relative `@@` paths resolve:

```sql
cd /Volumes/Projekte/KIS_Monitor/version_3_1/berechtigungsmatrix/dac_ddl
@install.sql
```

If running from VSCode, ensure the SQL runner working directory is:

```text
/Volumes/Projekte/KIS_Monitor/version_3_1/berechtigungsmatrix/dac_ddl
```

Symptom of wrong working directory:

```text
SP2-0310: opening file not possible: "tables/00_dac_match_states.sql"
```

## Reinstall / Cleanup

Use:

```sql
@drop_all.sql
```

`drop_all.sql` is deliberately not included by `install.sql`.

It drops packages, views, materialized views, and tables in dependency-safe
order. Missing objects are skipped.

## Tests

Install tests:

```sql
@tests/install_tests.sql
```

Then run utPLSQL according to the local database tooling.

## Refresh Published Access

Manual publication:

```sql
begin
  dac_admin.refresh_effective_accesses;
end;
/
```

Status:

```sql
select *
  from dac_effective_access_status_v;
```

The MVs also define a daily complete refresh around 02:00:

```sql
refresh complete on demand
start with trunc(sysdate) + 1 + 2/24
next trunc(sysdate) + 1 + 2/24
```

## Useful Access Query

Documents first, only users with published access:

```sql
select dea_target_den_id document_id,
       dea_target_den_display_name document_name,
       dear_ddi_name dimension_name,
       dear_target_ddn_name document_dimension_node,
       dea_subject_den_id user_id,
       dea_subject_den_display_name user_name,
       dear_subject_ddn_name user_dimension_node,
       dear_details reason,
       dea_calculated_at published_at
  from dac_effective_accesses_v
  join dac_effective_access_reasons_v
    on dear_dea_id = dea_id
 where dea_access = 'Y'
   and dea_target_den_det_id = 'DOCUMENT'
   and dea_subject_den_det_id = 'USER'
 order by dea_target_den_display_name,
          dear_ddi_name,
          dea_subject_den_display_name;
```

