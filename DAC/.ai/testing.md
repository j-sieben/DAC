# Testing Context

## Current Test Package

utPLSQL package:

```text
unit_tests/dac_access_demo_test.pks
unit_tests/dac_access_demo_test.pkb
```

Installer:

```text
unit_tests/install_tests.sql
```

## Current Coverage Themes

The demo test suite covers:

- positive access through matching restrictive dimension assignment
- hierarchy matching through parent/child distribution-list nodes
- default deny through `NO_MATCH`
- unrestricted target behavior through `NOT_APPLICABLE`
- inactive subject entity is absent
- inactive target entity is absent
- expired assignments are ignored
- inactive assignments are ignored
- future assignments are ignored
- multiple restrictive dimensions must all match
- a user with one of several assignments can match
- inactive target node and inactive dimension do not restrict access
- default validity dates in admin assignment merge
- default validity dates in admin entity merge
- invalid entity validity band is rejected

## Important Semantic Updates

Tests were updated after removing assignment modes:

- Alice cannot read the Controlling report because she lacks a matching
  distribution-list assignment. Expected reason is now
  `RESTRICTIVE_DIMENSION_MISMATCH` and per-dimension state `NO_MATCH`.

- Ivan can read the confidential Project A document because his Project A
  assignment matches the child node through the hierarchy. There is no longer an
  exclusion override.

## Known Tooling Constraint

In this AI environment there is no local `sqlplus` or `sqlcl`, so compilation
and utPLSQL execution must be done externally. Static checks used so far:

```sh
rg -n "pattern" DAC unit_tests
```

The user has repeatedly run tests in Oracle and reported green results before
the latest assignment-mode removal. After structural changes, rerun install and
tests in Oracle.
