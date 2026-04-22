
define grant=&1.
define object=&2.
@&spool_dir.step 'Grant &grant. right on &object. to &GRANTEE. with grant option'

GRANT &grant. ON &object. TO &GRANTEE. WITH GRANT OPTION;

