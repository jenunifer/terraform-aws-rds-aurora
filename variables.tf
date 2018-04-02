variable "cluster_identifier" {
  type = "string"
}

variable "availability_zones" {
  type        = "list"
  description = "List of Availability Zones that instances in the DB cluster can be created in"
}

variable "db_name" {
  type        = "string"
  default     = "dba_ops"
  description = "Database name"
}

variable "admin_user" {
  type        = "string"
  description = "(Required unless a snapshot_identifier is provided) Username for the master DB user"
}

variable "admin_password" {
  type        = "string"
  description = "(Required unless a snapshot_identifier is provided) Password for the master DB user"
}

variable "retention_period" {
  type        = "string"
  default     = "7"
  description = "Number of days to retain backups for"
}

variable "backup_window" {
  type        = "string"
  default     = "07:00-09:00"
  description = "Daily time range during which the backups happen"
}

variable "maintenance_window" {
  type        = "string"
  default     = "wed:03:00-wed:04:00"
  description = "Weekly time range during which system maintenance can occur, in UTC"
}

variable "apply_immediately" {
  type    = "string"
  default = "true"
}

variable "vpc_security_group_ids" {
  type        = "list"
  description = "(Optional) List of VPC security groups to associate(default [])"
}

variable "tags" {
  type        = "map"
  description = "Additional tags (e.g. map(`workload-type`,`role`,`team`, `env`)"
}

variable "engine" {
  type        = "string"
  default     = "aurora"
  description = "The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-postgresql`"
}

variable "engine_version" {
  type        = "string"
  description = "The version number of the database engine to use. Default is aurora5.6"
}

variable "cluster_size" {
  type        = "string"
  default     = "2"
  description = "Number of DB instances to create in the cluster"
}

variable "instance_type" {
  type        = "string"
  default     = "db.t2.medium"
  description = "Instance type to use"
}

variable "cluster_family" {
  type        = "string"
  description = "The family of the DB cluster parameter group"
  default     = "aurora5.7"
}

variable "db_cluster_parameters" {
  type        = "list"
  default     = []
  description = "List of DB cluster parameters to apply"
}

variable "db_instance_parameters" {
  type        = "list"
  default     = []
  description = "List of DB instances parameters to apply"
}

variable "security_groups" {
  type        = "list"
  description = "List of security groups to be allowed to connect to the DB instance"
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

variable "snapshot_identifier" {
  type        = "string"
  description = "Specifies whether or not to create this cluster from a snapshot"
}

variable "db_port" {
  type        = "string"
  default     = "3306"
  description = "Database port"
}
