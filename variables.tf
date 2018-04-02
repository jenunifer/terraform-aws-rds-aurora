variable "cluster_identifier" {
  type = "string"
}

variable "azs" {
  type        = "list"
  description = "List of AZs to use"
}

variable "db_name" {
  type        = "string"
  default     = "dba_ops"
  description = "Database name"
}

variable "rds_username" {
  type        = "string"
  description = "(Required unless a snapshot_identifier is provided) Username for the master DB user"
}

variable "rds_password" {
  type        = "string"
  description = "(Required unless a snapshot_identifier is provided) Password for the master DB user"
}

variable "backup_retention_period" {
  type        = "string"
  default     = "7"
  description = "How long to keep backups for (in days)"
}

variable "preferred_backup_window" {
  type        = "string"
  default     = "02:00-03:00"
  description = "When to perform DB backups"
}

variable "preferred_maintenance_window" {
  type        = "string"
  default     = "sun:05:00-sun:06:00"
  description = "When to perform DB maintenance"
}

variable "apply_immediately" {
  type        = "string"
  default     = "false"
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
}

variable "final_snapshot_identifier" {
  type        = "string"
  default     = ""
  description = "The name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too."
}

variable "skip_final_snapshot" {
  type        = "string"
  default     = "false"
  description = "Should a final snapshot be created on cluster destroy"
}

variable "vpc_security_group_ids" {
  type        = "list"
  default     = []
  description = "(Optional) List of VPC security groups to associate(default [])"
}

variable "tags" {
  type        = "map"
  description = "Additional tags (e.g. map(`workload-type`,`role`,`team`, `env`)"
}

variable "engine" {
  type        = "string"
  default     = "aurora"
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
}

variable "engine-version" {
  type        = "string"
  default     = "5.7.12a"
  description = "Aurora database engine version."
}

variable "replica_count" {
  type        = "string"
  default     = "0"
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
}

variable "security_groups" {
  type        = "list"
  description = "VPC Security Group IDs"
  default     = []
}

variable "instance_type" {
  type        = "string"
  default     = "db.t2.medium"
  description = "Instance typeuse to use"
}

variable "cluster_family" {
  type        = "string"
  description = "The family of the DB cluster parameter group"
  default     = "aurora5.7"
}

variable "auto_minor_version_upgrade" {
  type        = "string"
  default     = "true"
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
}

variable "db_cluster_parameters" {
  type        = "list"
  default     = []
  description = "List of DB cluster parameters to apply"
}

variable "db_instance_parameters" {
  type = "list"

  default = [
    {
      name  = "slow_query_log"
      value = "1"
    },
    {
      name  = "slow_query_log_file"
      value = "/rdsdbdata/log/slowquery/mysql-slowquery.log	"
    },
  ]

  description = "List of DB instances parameters to apply"
}

variable "db_parameter_group_name" {
  type        = "string"
  default     = "default.aurora5.6"
  description = "The name of a DB parameter group to use"
}

variable "db_cluster_parameter_group_name" {
  type        = "string"
  default     = "default.aurora5.6"
  description = "The name of a DB Cluster parameter group to use"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID to create the cluster in (e.g. `vpc-a22222ee`)"
}

variable "rds_subnet_ids" {
  type        = "list"
  description = "List of VPC subnet IDs"
}

variable "rds_security_group_ids" {
  type = "list"
}

variable "subnets" {
  type        = "list"
  description = "List of subnet IDs to use"
}

variable "snapshot_identifier" {
  type        = "string"
  default     = ""
  description = "DB snapshot to create this database from"
}

variable "db_parameter_group_name" {
  type        = "string"
  default     = "default.aurora5.6"
  description = "The name of a DB parameter group to use"
}

variable "db_cluster_parameter_group_name" {
  type        = "string"
  default     = "default.aurora5.6"
  description = "The name of a DB Cluster parameter group to use"
}

variable "db_port" {
  type        = "string"
  default     = "3306"
  description = "Database port"
}
