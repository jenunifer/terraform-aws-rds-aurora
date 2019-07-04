locals {
  local_pool_id = "${var.pool_id}"
  local_prefix  = "${var.prefix}"

  common_tags = {
    terraform     = "true"
    team          = "${var.team}"
    env           = "${var.env}"
    workload-type = "other"
    role          = "${var.role}"
  }
}

resource "aws_rds_cluster_instance" "cluster_instance_0" {
  identifier         = "${aws_rds_cluster.default.cluster_identifier}-00-${substr(element(var.azs, 0), -2, -1)}"
  availability_zone  = "${element(var.azs, 0)}"
  cluster_identifier = "${aws_rds_cluster.default.cluster_identifier}"
  engine             = "${aws_rds_cluster.default.engine}"
  engine_version     = "${aws_rds_cluster.default.engine_version}"
  instance_class     = "${local.common_tags["env"] == "stage" ? "db.t2.small" : var.instance_type }"

  publicly_accessible          = "${var.publicly_accessible}"
  db_parameter_group_name      = "${aws_db_parameter_group.default.name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "0"
  db_subnet_group_name         = "${var.subnet_group_name}"

  tags = "${merge(local.common_tags, var.tags)}"
}

// Create 'n' number of additional DB instance(s) in same cluster
resource "aws_rds_cluster_instance" "cluster_instance_n" {
  depends_on         = ["aws_rds_cluster_instance.cluster_instance_0"]
  count              = "${var.replica_count}"
  engine             = "${aws_rds_cluster.default.engine}"
  availability_zone  = "${element(var.azs, count.index + 1)}"
  engine_version     = "${aws_rds_cluster.default.engine_version}"
  identifier         = "${aws_rds_cluster.default.cluster_identifier}-0${count.index + 1}-${substr(element(var.azs, count.index + 1), -2, -1)}"
  cluster_identifier = "${aws_rds_cluster.default.cluster_identifier}"
  instance_class     = "${local.common_tags["env"] == "stage" ? "db.t2.small" : var.instance_type }"

  publicly_accessible          = "${var.publicly_accessible}"
  db_parameter_group_name      = "${aws_db_parameter_group.default.name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "${count.index + 1}"
  db_subnet_group_name         = "${var.subnet_group_name}"

  tags = "${merge(local.common_tags, var.tags)}"
}

// Creates a new RDS Aurora cluster0
resource "aws_rds_cluster" "default" {
  cluster_identifier              = "${local.local_prefix != "" ? format("%s-", local.local_prefix) : ""}${local.common_tags["role"]}-${local.common_tags["env"] == "stage" ? "sta" : local.common_tags["env"]}-p${local.local_pool_id}"
  availability_zones              = ["${var.azs}"]
  database_name                   = "${var.db_name}"
  master_username                 = "${var.rds_username}"
  master_password                 = "${var.rds_password}"
  backup_retention_period         = "${var.backup_retention_period}"
  preferred_backup_window         = "${var.preferred_backup_window}"
  preferred_maintenance_window    = "${var.preferred_maintenance_window}"
  final_snapshot_identifier       = "${aws_rds_cluster_parameter_group.default.id}-final"
  snapshot_identifier             = "${var.snapshot_identifier}"
  apply_immediately               = "${var.apply_immediately}"
  vpc_security_group_ids          = ["${var.vpc_security_group_ids}"]
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.default.id}"
  db_subnet_group_name            = "${var.subnet_group_name}"
  tags                            = "${merge(local.common_tags, var.tags)}"
  engine                          = "${var.engine}"
  engine_version                  = "${var.engine_version}"
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "${local.local_prefix != "" ? format("%s-", local.local_prefix) : ""}${format("%s-%s-cpg-%s", var.role, var.env, var.pool_id)}"
  description = "DB cluster parameter group"
  family      = "${var.family}"
  parameter   = ["${var.db_cluster_parameters}"]
}

resource "aws_db_parameter_group" "default" {
  name        = "${local.local_prefix != "" ? format("%s-", local.local_prefix) : ""}${format("%s-%s-dpg-%s", var.role, var.env, var.pool_id)}"
  description = "DB Instance parameter group"
  family      = "${var.family}"
  parameter   = ["${var.db_instance_parameters}"]
}
