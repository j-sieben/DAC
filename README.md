# DAC

Dimensional Access Control - matrix-based authorization for applications.

## Repository Layout

- `DAC`: installable DAC component and source logic.
- `install_scripts`: shared installation helpers imported as subtree; SQL
  helper collections live below `install_scripts/scripts`.
- `unit_tests`: utPLSQL tests for the DAC component.

Additional sibling directories may be added later for tooling, documentation, or
other integration assets.

## Install

Run the component installer from the repository root:

```sh
./install.sh user/password@service
```

Windows:

```bat
install.cmd user/password@service
```

Pass `reinstall.sql` or `drop_all.sql` as second argument to run those component
entry points instead of `install.sql`.
