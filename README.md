
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | string | `false` | no |
| auto_minor_version_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | string | `true` | no |
| azs | List of AZs to use | list | - | yes |
| backup_retention_period | How long to keep backups for (in days) | string | `7` | no |
| cluster_identifier |  | string | `` | no |
| db_cluster_parameter_group_name | The name of a DB Cluster parameter group to use | string | `default.aurora5.7` | no |
| db_cluster_parameters | List of DB cluster parameters to apply | list | `<list>` | no |
| db_instance_parameters | List of DB instances parameters to apply | list | `<list>` | no |
| db_name | Database name | string | `dba_ops` | no |
| db_parameter_group_name | The name of a DB parameter group to use | string | `default.aurora5.7` | no |
| db_port | Database port | string | `3306` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | string | `aurora` | no |
| engine_version | Aurora database engine version. | string | `5.7.12a` | no |
| env | Environment (prod/stage/dev) | string | `` | no |
| family | The family of the DB cluster parameter group | string | `aurora5.7` | no |
| final_snapshot_identifier | The name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | string | `` | no |
| instance_type | Instance typeuse to use | string | `db.t2.medium` | no |
| pool_id | For use if cluster/instances have an additional identifier at the end of name. | string | `` | no |
| preferred_backup_window | When to perform DB backups | string | `02:00-03:00` | no |
| preferred_maintenance_window | When to perform DB maintenance | string | `sun:05:00-sun:06:00` | no |
| prefix | ID prefix. | string | `` | no |
| publicly_accessible |  | string | `false` | no |
| rds_password | (Required unless a snapshot_identifier is provided) Password for the master DB user | string | - | yes |
| rds_username | (Required unless a snapshot_identifier is provided) Username for the master DB user | string | - | yes |
| replica_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | string | `0` | no |
| role |  | string | `` | no |
| skip_final_snapshot | Should a final snapshot be created on cluster destroy | string | `false` | no |
| snapshot_identifier | DB snapshot to create this database from | string | `` | no |
| subnet_group_name | Subnet Group Name (Has to match cluster for instances.) | string | `` | no |
| tags | Additional tags (e.g. map(`workload-type`,`role`,`team`, `env`) | map | `<map>` | no |
| vpc_id | VPC ID to create the cluster in (e.g. `vpc-a22222ee`) | string | `` | no |
| vpc_security_group_ids | (Optional) List of VPC security groups to associate(default []) | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | Cluster endpoint |
| cluster_identifier | The 'writer' endpoint for the cluster |
| reader_endpoint | A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas |

