output "cluster_name" {
  value       = "${aws_rds_cluster.default.cluster_identifier}"
  description = "Cluster Identifier"
}

output "cluster_param_group" {
  value = "${aws_rds_cluster_parameter_group.default.name}"
}

output "instance_identifier" {
  value = "${aws_rds_cluster_instance.default.*.identifier}"
}

output "instance_param_group" {
  value = "${aws_db_parameter_group.default.name}"
}

output "reader_endpoint" {
  value = "${aws_rds_cluster.default.reader_endpoint}"
}

output "all_instance_endpoints_list" {
  value = ["${aws_rds_cluster_instance.default.*.endpoint}"]
}

output "cluster_endpoint" {
  value = "${aws_rds_cluster.default.endpoint}"
}
