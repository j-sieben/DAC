/**
  Table: DAC_ENTITY_NODE_ASSIGNMENTS
    Assignments locating entities in dimension nodes.

  Columns:
    dena_den_id - Reference to DAC_ENTITIES
    dena_ddn_id - Reference to DAC_DIMENSION_NODES
    dena_valid_from - Start date for assignment validity
    dena_valid_to - End date for assignment validity
    dena_active - Flag indicating whether the assignment is active
    dena_created_at - Creation timestamp
    dena_updated_at - Last update timestamp

  Dependencies:
    dena_den_id - references <DAC_ENTITIES> (den_id)
    dena_ddn_id - references <DAC_DIMENSION_NODES> (ddn_id)
 */
create table dac_entity_node_assignments (
  dena_den_id varchar2(128 byte) constraint dena_den_id_nn not null,
  dena_ddn_id varchar2(128 byte) constraint dena_ddn_id_nn not null,
  dena_valid_from date default date '1900-01-01' constraint dena_valid_from_nn not null,
  dena_valid_to date default date '9999-12-31' constraint dena_valid_to_nn not null,
  dena_active char(1 byte) default on null 'Y'
    constraint dena_active_chk check (dena_active in ('Y', 'N')),
  dena_created_at timestamp default systimestamp constraint dena_created_at_nn not null,
  dena_updated_at timestamp,
  constraint dac_entity_node_assignments_pk primary key (dena_den_id, dena_ddn_id),
  constraint dac_entity_node_assignments_fk_den foreign key (dena_den_id)
    references dac_entities (den_id) on delete cascade,
  constraint dac_entity_node_assignments_fk_ddn foreign key (dena_ddn_id)
    references dac_dimension_nodes (ddn_id) on delete cascade,
  constraint dac_entity_node_assignments_ck_dates check (dena_valid_from <= dena_valid_to)
);

create index dac_entity_node_assignments_idx_den on dac_entity_node_assignments (dena_den_id);
create index dac_entity_node_assignments_idx_ddn on dac_entity_node_assignments (dena_ddn_id);

comment on table dac_entity_node_assignments is 'Assignments locating entities in dimension nodes.';
comment on column dac_entity_node_assignments.dena_den_id is 'Foreign key to DAC_ENTITIES.DEN_ID.';
comment on column dac_entity_node_assignments.dena_ddn_id is 'Foreign key to DAC_DIMENSION_NODES.DDN_ID.';
comment on column dac_entity_node_assignments.dena_valid_from is 'Start date for assignment validity.';
comment on column dac_entity_node_assignments.dena_valid_to is 'End date for assignment validity.';
comment on column dac_entity_node_assignments.dena_active is 'Flag indicating whether the assignment is active.';
comment on column dac_entity_node_assignments.dena_created_at is 'Creation timestamp.';
comment on column dac_entity_node_assignments.dena_updated_at is 'Last update timestamp.';
