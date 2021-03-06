variable "role" {
  type    = "string"
  default = ""
}

variable "cluster_identifier" {
  type    = "string"
  default = ""
}

variable "availability_zone" {
  type    = "string"
  default = ""
}

variable "publicly_accessible" {
  type    = "string"
  default = "false"
}

variable "azs" {
  type        = "list"
  description = "List of AZs to use"
}

variable "db_name" {
  type        = "string"
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

variable "pool_id" {
  type        = "string"
  description = "For use if cluster/instances have an additional identifier at the end of name."
  default     = "1"
}

variable "prefix" {
  type        = "string"
  description = "ID prefix. (h/o/p)"
  default     = ""
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

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`workload-type`,`role`,`team`, `env`)"
}

variable "engine" {
  type        = "string"
  default     = "aurora-mysql"
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
}

variable "team" {
  type        = "string"
  description = "Team that owns the data."
  default     = ""
}

variable "env" {
  type        = "string"
  description = "Environment (prod/stage/dev)"
  default     = ""
}

variable "engine_version" {
  type        = "string"
  default     = "5.7.12"
  description = "Aurora database engine version."
}

variable "replica_count" {
  type        = "string"
  default     = "0"
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
}

variable "instance_type" {
  type        = "string"
  default     = "db.t2.medium"
  description = "Instance type to use.  The module (for defaults) creates db.t2.medium for production and db.t2.small for staging."
}

variable "family" {
  type        = "string"
  description = "The family of the DB cluster parameter group"
  default     = "aurora-mysql5.7"
}

variable "auto_minor_version_upgrade" {
  type        = "string"
  default     = "true"
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
}

variable "db_cluster_parameters" {
  type        = "list"
  description = "List of DB cluster parameters to apply"

  default = [
    {
      name         = "innodb_strict_mode"
      value        = "0"
      apply_method = "pending-reboot"
    },
  ]
}

variable "db_instance_parameters" {
  type        = "list"
  description = "A list of DB parameter maps to apply"

  default = [
    {
      name  = "innodb_buffer_pool_dump_at_shutdown"
      value = "1"
    },
    {
      name  = "innodb_buffer_pool_load_at_startup"
      value = "1"
    },
    {
      name  = "log_output"
      value = "TABLE"
    },
    {
      name  = "log_warnings"
      value = "2"
    },
    {
      name  = "slow_query_log"
      value = "1"
    },
    {
      name  = "long_query_time"
      value = ".5"
    },
  ]
}

variable "db_parameter_group_name" {
  type        = "string"
  default     = "aurora-mysql5.7"
  description = "The name of a DB parameter group to use"
}

variable "db_cluster_parameter_group_name" {
  type        = "string"
  default     = "default.aurora5.7"
  description = "The name of a DB Cluster parameter group to use"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID to create the cluster in (e.g. `vpc-a22222ee`)"
  default     = ""
}

variable "subnet_group_name" {
  type        = "string"
  description = "Subnet Group Name (Has to match cluster for instances.)"
  default     = ""
}

variable "vpc_security_group_ids" {
  type        = "list"
  description = "List of VPC security groups to associate(default [])"
}

variable "snapshot_identifier" {
  type        = "string"
  default     = ""
  description = "DB snapshot to create this database from"
}

variable "db_port" {
  type        = "string"
  default     = "3306"
  description = "Database port"
}
