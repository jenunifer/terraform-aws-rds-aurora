
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_password | (Required unless a snapshot_identifier is provided) Password for the master DB user | string | - | yes |
| admin_user | (Required unless a snapshot_identifier is provided) Username for the master DB user | string | - | yes |
| apply_immediately |  | string | `true` | no |
| availability_zones | List of Availability Zones that instances in the DB cluster can be created in | list | - | yes |
| backup_window | Daily time range during which the backups happen | string | `07:00-09:00` | no |
| cluster_family | The family of the DB cluster parameter group | string | `aurora5.7` | no |
| cluster_identifier |  | string | - | yes |
| cluster_size | Number of DB instances to create in the cluster | string | `2` | no |
| db_cluster_parameters | List of DB cluster parameters to apply | list | `<list>` | no |
| db_instance_parameters | List of DB instances parameters to apply | list | `<list>` | no |
| db_name | Database name | string | `dba_ops` | no |
| db_port | Database port | string | `3306` | no |
| engine | The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-postgresql` | string | `aurora` | no |
| engine_version | The version number of the database engine to use. Default is aurora5.6 | string | - | yes |
| instance_type | Instance type to use | string | `db.t2.medium` | no |
| maintenance_window | Weekly time range during which system maintenance can occur, in UTC | string | `wed:03:00-wed:04:00` | no |
| rds_security_group_ids |  | list | - | yes |
| rds_subnet_ids | List of VPC subnet IDs | list | - | yes |
| retention_period | Number of days to retain backups for | string | `7` | no |
| security_groups | List of security groups to be allowed to connect to the DB instance | list | - | yes |
| snapshot_identifier | Specifies whether or not to create this cluster from a snapshot | string | - | yes |
| tags | Additional tags (e.g. map(`workload-type`,`role`,`team`, `env`) | map | - | yes |
| vpc_id | VPC ID to create the cluster in (e.g. `vpc-a22222ee`) | string | - | yes |
| vpc_security_group_ids | (Optional) List of VPC security groups to associate(default []) | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| all_instance_endpoints_list |  |
| cluster_endpoint |  |
| cluster_name | Cluster Identifier |
| cluster_param_group |  |
| instance_identifier |  |
| instance_param_group |  |
| reader_endpoint |  |

