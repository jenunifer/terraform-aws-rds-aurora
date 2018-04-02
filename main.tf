// Declare datasource grabbing regions AZs to call when creating instances in seperate zones.
data "aws_availability_zones" "available" {}

// Create single DB instance
resource "aws_rds_cluster_instance" "cluster_instance_0" {
  identifier                   = "${aws_rds_cluster.default.id}-0"
  cluster_identifier           = "${aws_rds_cluster.default.id}"
  engine                       = "${aws_rds_cluster.default.engine}"
  engine_version               = "${aws_rds_cluster.default.engine_version}"
  instance_class               = "${var.instance_type}"
  publicly_accessible          = "${var.publicly_accessible}"
  db_subnet_group_name         = "${var.db_subnet_group_name}"
  db_parameter_group_name      = "${aws_db_parameter_group.default.name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "0"

  tags {
    role           = "${var.rds_role}"
    workgroup-type = "other"
    team           = "${var.rds_team}"
    env            = "${var.env}"
  }
}

// Create 'n' number of additional DB instance(s) in same cluster

resource "aws_rds_cluster_instance" "cluster_instance_n" {
  depends_on                   = ["aws_rds_cluster_instance.cluster_instance_0"]
  count                        = "${var.replica_count}"
  cluster_identifier           = "${aws_rds_cluster.default.id}"
  engine                       = "${aws_rds_cluster.default.engine}"
  engine_version               = "${aws_rds_cluster.default.engine_version}"
  identifier                   = "${aws_rds_cluster.default.id}-${count.index + 1}"
  instance_class               = "${var.instance_type}"
  publicly_accessible          = false
  db_subnet_group_name         = "${var.db_subnet_group_name}"
  db_parameter_group_name      = "${aws_db_parameter_group.default.name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "${count.index + 1}"

  tags {
    role           = "${var.rds_role}"
    workgroup-type = "other"
    team           = "${var.rds_team}"
    env            = "${var.env}"
  }
}

// Creates a new RDS Aurora cluster
resource "aws_rds_cluster" "default" {
  cluster_identifier              = "${var.cluster_identifier}"
  availability_zones              = ["${var.azs}"]
  database_name                   = "${var.db_name}"
  master_username                 = "${var.rds_username}"
  master_password                 = "${var.rds_password}"
  backup_retention_period         = "${var.backup_retention_period}"
  preferred_backup_window         = "${var.preferred_backup_window}"
  preferred_maintenance_window    = "${var.preferred_maintenance_window}"
  final_snapshot_identifier       = "${aws_rds_cluster.default.id}-final"
  snapshot_identifier             = "${var.snapshot_identifier}"
  apply_immediately               = "${var.apply_immediately}"
  vpc_security_group_ids          = ["${var.vpc_security_group_ids}"]
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.default.name}"
  tags                            = "${var.tags}"
  engine                          = "${var.engine}"
  engine_version                  = "${var.engine_version}"
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
