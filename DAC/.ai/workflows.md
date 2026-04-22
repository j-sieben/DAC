# Workflows

## Install

Run from the `DAC` directory so relative `@@` paths resolve:

```sql
cd /path/to/repository/DAC
@install.sql
```

Shell wrappers are available from the repository root:

```sh
cd /path/to/repository
./install.sh user/password@service
```

Windows:

```bat
cd \path\to\repository
install.cmd user/password@service
```

Pass `reinstall.sql` or `drop_all.sql` as second argument to run those component
entry points.

The component follows the install helper target architecture. All standard
object folders exist below `DAC/`; folders without DAC objects contain no-op
`install_*.sql` files that print that nothing is installed for that type.

## Reinstall / Cleanup

Use:

```sql
@drop_all.sql
```

`drop_all.sql` is deliberately not included by `install.sql`.

It drops packages, views, materialized views, and tables in dependency-safe
order. Missing objects are skipped.

For a full rebuild:

```sql
@reinstall.sql
```

## Tests

Install tests:

```sql
cd ../unit_tests
@install_tests.sql
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
