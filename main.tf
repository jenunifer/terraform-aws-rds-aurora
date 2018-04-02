// Declare datasource grabbing regions AZs to call when creating instances in seperate zones.
data "aws_availability_zones" "available" {}

// Creates a new RDS Aurora cluster
resource "aws_rds_cluster" "default" {
  cluster_identifier              = "${var.cluster_identifier}"
  availability_zones              = ["${slice(data.aws_availability_zones.available.names, 0, 2)}"]
  database_name                   = "${var.db_name}"
  master_username                 = "${var.admin_user}"
  master_password                 = "${var.admin_password}"
  backup_retention_period         = "${var.retention_period}"
  preferred_backup_window         = "${var.backup_window}"
  preferred_maintenance_window    = "${var.maintenance_window}"
  final_snapshot_identifier       = "${aws_rds_cluster.default.id}-final"
  snapshot_identifier             = "${var.snapshot_identifier}"
  skip_final_snapshot             = false
  apply_immediately               = "${var.apply_immediately}"
  vpc_security_group_ids          = ["${var.vpc_security_group_ids}"]
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.default.name}"
  tags                            = "${var.tags}"
  engine                          = "${var.engine}"
  engine_version                  = "${var.engine_version}"
}

// Creates instance(s) under the above cluster.
resource "aws_rds_cluster_instance" "default" {
  count                   = "${var.cluster_size}"
  identifier              = "${aws_rds_cluster.default.id}-${count.index}"
  cluster_identifier      = "${aws_rds_cluster.default.id}"
  instance_class          = "${var.instance_type}"
  publicly_accessible     = false
  tags                    = "${var.tags}"
  engine                  = "${aws_rds_cluster.default.engine}"
  engine_version          = "${aws_rds_cluster.default.engine_version}"
  db_parameter_group_name = "${aws_db_parameter_group.default.name}"
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "${aws_rds_cluster.default.id}"
  description = "DB cluster parameter group"
  parameter   = ["${var.db_cluster_parameters}"]
}

resource "aws_db_parameter_group" "default" {
  name        = "${aws_rds_cluster.default.id}"
  description = "DB Instance parameter group"
  parameter   = ["${var.db_instance_parameters}"]
}

