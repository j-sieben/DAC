create or replace force view dac_effective_access_status_v as
select max(case when mview_name = 'DAC_EFFECTIVE_ACCESSES' then last_refresh_date end) dea_last_refresh_date,
       max(case when mview_name = 'DAC_EFFECTIVE_ACCESSES' then refresh_method end) dea_refresh_method,
       max(case when mview_name = 'DAC_EFFECTIVE_ACCESSES' then staleness end) dea_staleness,
       max(case when mview_name = 'DAC_EFFECTIVE_ACCESSES' then compile_state end) dea_compile_state,
       max((select count(*) from dac_effective_accesses)) dea_row_count,
       max(case when mview_name = 'DAC_EFFECTIVE_ACCESS_REASONS' then last_refresh_date end) dear_last_refresh_date,
       max(case when mview_name = 'DAC_EFFECTIVE_ACCESS_REASONS' then refresh_method end) dear_refresh_method,
       max(case when mview_name = 'DAC_EFFECTIVE_ACCESS_REASONS' then staleness end) dear_staleness,
       max(case when mview_name = 'DAC_EFFECTIVE_ACCESS_REASONS' then compile_state end) dear_compile_state,
       max((select count(*) from dac_effective_access_reasons)) dear_row_count
  from user_mviews
 where mview_name in ('DAC_EFFECTIVE_ACCESSES', 'DAC_EFFECTIVE_ACCESS_REASONS');

comment on table dac_effective_access_status_v is 'Refresh status for the published DAC effective access materialized views.';
comment on column dac_effective_access_status_v.dea_last_refresh_date is 'Last refresh date of DAC_EFFECTIVE_ACCESSES.';
comment on column dac_effective_access_status_v.dea_refresh_method is 'Configured refresh method of DAC_EFFECTIVE_ACCESSES.';
comment on column dac_effective_access_status_v.dea_staleness is 'Oracle staleness state of DAC_EFFECTIVE_ACCESSES.';
comment on column dac_effective_access_status_v.dea_compile_state is 'Oracle compile state of DAC_EFFECTIVE_ACCESSES.';
comment on column dac_effective_access_status_v.dea_row_count is 'Number of currently published effective access decisions.';
comment on column dac_effective_access_status_v.dear_last_refresh_date is 'Last refresh date of DAC_EFFECTIVE_ACCESS_REASONS.';
comment on column dac_effective_access_status_v.dear_refresh_method is 'Configured refresh method of DAC_EFFECTIVE_ACCESS_REASONS.';
comment on column dac_effective_access_status_v.dear_staleness is 'Oracle staleness state of DAC_EFFECTIVE_ACCESS_REASONS.';
comment on column dac_effective_access_status_v.dear_compile_state is 'Oracle compile state of DAC_EFFECTIVE_ACCESS_REASONS.';
comment on column dac_effective_access_status_v.dear_row_count is 'Number of currently published effective access reason rows.';
