resource "aws_rds_cluster_instance" "cluster_instance_0" {
  identifier                   = "${aws_rds_cluster.default.cluster_identifier}-00"
  cluster_identifier           = "${aws_rds_cluster.default.cluster_identifier}"
  engine                       = "${aws_rds_cluster.default.engine}"
  engine_version               = "${aws_rds_cluster.default.engine_version}"
  instance_class               = "${var.instance_type}"
  publicly_accessible          = "${var.publicly_accessible}"
  db_parameter_group_name      = "${aws_db_parameter_group.default.name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "0"
  db_subnet_group_name         = "${var.subnet_group_name}"

  tags = "${var.tags}"
}

// Create 'n' number of additional DB instance(s) in same cluster
resource "aws_rds_cluster_instance" "cluster_instance_n" {
  depends_on                   = ["aws_rds_cluster_instance.cluster_instance_0"]
  count                        = "${var.replica_count}"
  engine                       = "${aws_rds_cluster.default.engine}"
  engine_version               = "${aws_rds_cluster.default.engine_version}"
  identifier                   = "${aws_rds_cluster.default.cluster_identifier}-0${count.index + 1}"
  cluster_identifier           = "${aws_rds_cluster.default.cluster_identifier}"
  instance_class               = "${var.instance_type}"
  publicly_accessible          = "${var.publicly_accessible}"
  db_parameter_group_name      = "${aws_db_parameter_group.default.name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "${count.index + 1}"
  db_subnet_group_name         = "${var.subnet_group_name}"
  tags                         = "${var.tags}"
}

// Creates a new RDS Aurora cluster0
resource "aws_rds_cluster" "default" {
  cluster_identifier              = "${var.cluster_identifier}"
  availability_zones              = ["${element(split(",", var.azs), count.index)}"]
  database_name                   = "${var.db_name}"
  master_username                 = "${var.rds_username}"
  master_password                 = "${var.rds_password}"
  backup_retention_period         = "${var.backup_retention_period}"
  preferred_backup_window         = "${var.preferred_backup_window}"
  preferred_maintenance_window    = "${var.preferred_maintenance_window}"
  final_snapshot_identifier       = "${var.cluster_identifier}-final"
  snapshot_identifier             = "${var.cluster_identifier}"
  apply_immediately               = "${var.apply_immediately}"
  vpc_security_group_ids          = ["${var.vpc_security_group_ids}"]
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.default.id}"
  db_subnet_group_name            = "${var.subnet_group_name}"
  tags                            = "${var.tags}"
  engine                          = "${var.engine}"
  engine_version                  = "${var.engine_version}"
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "${format("%s-%s-%s", var.role, var.env, var.pool_id)}"
  description = "DB cluster parameter group"
  family      = "${var.family}"
  parameter   = ["${var.db_cluster_parameters}"]
}

resource "aws_db_parameter_group" "default" {
  name        = "${format("%s-%s-%s", var.role, var.env, var.pool_id)}"
  description = "DB Instance parameter group"
  family      = "${var.family}"
  parameter   = ["${var.db_instance_parameters}"]
}
