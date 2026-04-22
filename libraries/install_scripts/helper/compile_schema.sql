@&spool_dir.h3 'Compile invalid objects'

@&spool_dir.step 'Resetting package state'
@&std_dir.reset_state

set serveroutput on

declare
  cursor invalid_object_cur
  is
    select owner,
           object_name,
           object_type,
           decode(object_type, 'TYPE', 1,'TYPE BODY', 2, 'PACKAGE', 3, 'PACKAGE BODY', 4, 5) recompile_order
      from all_objects
     where object_type in ('PACKAGE', 'PACKAGE BODY', 'VIEW', 'PROCEDURE', 'FUNCTION', 'MATERIALIZED VIEW', 'SYNONYM','TYPE', 'TYPE BODY')
       and status != 'VALID'
       and owner = upper('&INSTALL_USER.')
     order by recompile_order;
     
  cursor invalid_cur is
    select lower(object_type || ' ' || object_name)object
      from user_objects
     where status = 'INVALID';
  l_msg varchar2(1000 byte);
  l_has_invalid_objects boolean := false;
  type error_list_t is table of varchar2(1000 byte) index by varchar2(128 byte);
  l_error_list error_list_t;
begin
  dbms_utility.compile_schema(schema => upper('&INSTALL_USER.'), compile_all => false);
  
  for i in 1..3 loop
    for cur_rec in invalid_object_cur  loop
      begin
        case cur_rec.object_type
        when 'TYPE' then
          execute immediate 'ALTER ' || cur_rec.object_type || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
        when 'TYPE BODY' then
          execute immediate 'ALTER TYPE ' || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE BODY';
        when 'PACKAGE' then
          execute immediate 'ALTER ' || cur_rec.object_type || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
        when 'PACKAGE BODY' then
          execute immediate 'ALTER PACKAGE "' || cur_rec.owner || 
              '"."' || cur_rec.object_name || '" COMPILE BODY';
        when 'VIEW' then
          execute immediate 'ALTER ' || cur_rec.object_type || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
        when 'PROCEDURE' then
          execute immediate 'ALTER ' || cur_rec.object_type || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE'; 
        when 'FUNCTION' then
          execute immediate 'ALTER ' || cur_rec.object_type || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE'; 
        when 'MATERIALIZED VIEW' then
          execute immediate 'ALTER ' || cur_rec.object_type || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
        when 'SYNONYM' then
          execute immediate 'ALTER ' || cur_rec.object_type || 
              ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
        end case;
      exception
        when others then
          null;
      end;
    end loop;
  end loop;
  
  l_msg := '&h3.List of invalid objects';
  dbms_output.put_line(l_msg);
  &UTIL_OWNER..spool_pkg.insertSpool('&KOMPONENTE.', '&INSTALL_USER.', l_msg);
  
  for o in invalid_cur loop
    l_has_invalid_objects := true;
    l_msg := '&s1.' || o.object;
    dbms_output.put_line(l_msg);
    $IF $$HAS_SPOOL $THEN
    &UTIL_OWNER..spool_pkg.insertSpool('&KOMPONENTE.', '&INSTALL_USER.', l_msg);
    $END
  end loop;
  
  if not l_has_invalid_objects then
    l_msg := '&s1.All objects are valid';
    dbms_output.put_line(l_msg);
    $IF $$HAS_SPOOL $THEN
    &UTIL_OWNER..spool_pkg.insertSpool('&KOMPONENTE.', '&INSTALL_USER.', l_msg);
    $END
  end if;
end;
/
