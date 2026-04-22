
define grant=&1.
define object=&2.
@&spooldir.step 'Grant &1. right on &2. to &GRANTEE.'

grant &grant. on &object. to &grantee.;
