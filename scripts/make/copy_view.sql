column view_owner new_value view_owner

set termout off
select owner view_owner
  from all_views
 where view_name = upper('&viewname.')
   and owner != user;
set termout on
 
create or replace force view &viewname. as
select *
  from &view_owner..&viewname.;
  
