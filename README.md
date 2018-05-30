
## Example config file

rds-aurora.tf
```
variable "azs" {
  type    = "list"
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

locals {
  local_pool_id = "1"
  local_prefix  = "d"

  common_tags = {
    terraform     = "true"
    team          = "dev-team"
    env           = "stage"
    workload-type = "other"
    role          = "mysqltest"
  }
}

module "mysqltest-sta-1" {
  source = "../rds-aurora"

  rds_username           = "rds_admin"
  rds_password           = "test"
  vpc_id                 = "vpc-test"
  subnet_group_name      = "aws_sg_group"
  vpc_security_group_ids = ["test-sec-group"]
  azs                    = ["${var.azs}"]

  pool_id       = "${local.local_pool_id}"
  env           = "${local.common_tags["env"]}"
  role          = "${local.common_tags["role"]}"
  replica_count = 1

  tags = "${merge(local.common_tags)}"
}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | string | `false` | no |
| auto_minor_version_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | string | `true` | no |
| availability_zone |  | string | `` | no |
| azs | List of AZs to use | list | - | yes |
| azs |  | list | `<list>` | no |
| backup_retention_period | How long to keep backups for (in days) | string | `7` | no |
| cluster_identifier |  | string | `` | no |
| db_cluster_parameter_group_name | The name of a DB Cluster parameter group to use | string | `default.aurora5.7` | no |
| db_cluster_parameters | List of DB cluster parameters to apply | list | `<list>` | no |
| db_instance_parameters | A list of DB parameter maps to apply | list | `<list>` | no |
| db_name | Database name | string | - | yes |
| db_parameter_group_name | The name of a DB parameter group to use | string | `aurora-mysql5.7` | no |
| db_port | Database port | string | `3306` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | string | `aurora-mysql` | no |
| engine_version | Aurora database engine version. | string | `5.7.12` | no |
| env | Environment (prod/stage/dev) | string | `` | no |
| family | The family of the DB cluster parameter group | string | `aurora-mysql5.7` | no |
| final_snapshot_identifier | The name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | string | `` | no |
| instance_type | Instance type to use.  The module (for defaults) creates db.t2.medium for production and db.t2.small for staging. | string | `db.t2.medium` | no |
| pool_id | For use if cluster/instances have an additional identifier at the end of name. | string | `1` | no |
| preferred_backup_window | When to perform DB backups | string | `02:00-03:00` | no |
| preferred_maintenance_window | When to perform DB maintenance | string | `sun:05:00-sun:06:00` | no |
| prefix | ID prefix. (h/o/p) | string | `h` | no |
| publicly_accessible |  | string | `false` | no |
| rds_password | (Required unless a snapshot_identifier is provided) Password for the master DB user | string | - | yes |
| rds_username | (Required unless a snapshot_identifier is provided) Username for the master DB user | string | - | yes |
| replica_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | string | `0` | no |
| role |  | string | `` | no |
| skip_final_snapshot | Should a final snapshot be created on cluster destroy | string | `false` | no |
| snapshot_identifier | DB snapshot to create this database from | string | `` | no |
| subnet_group_name | Subnet Group Name (Has to match cluster for instances.) | string | `` | no |
| tags | Additional tags (e.g. map(`workload-type`,`role`,`team`, `env`) | map | `<map>` | no |
| team | Team that owns the data. | string | `` | no |
| vpc_id | VPC ID to create the cluster in (e.g. `vpc-a22222ee`) | string | `` | no |
| vpc_security_group_ids | List of VPC security groups to associate(default []) | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | Cluster endpoint |
| cluster_identifier | The 'writer' endpoint for the cluster |
| reader_endpoint | A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas |

