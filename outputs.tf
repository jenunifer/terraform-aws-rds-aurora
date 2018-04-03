// The 'writer' endpoint for the cluster
output "cluster_endpoint" {
  description = "Cluster endpoint"
  value = "${aws_rds_cluster.default.endpoint}"
}

// Comma separated list of all DB instance endpoints running in cluster
output "all_instance_endpoints_list" {
  	description = "List of all instances in cluster."
	value = ["${aws_rds_cluster_instance.cluster_instance.*.endpoint}"]
}

// A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas
output "reader_endpoint" {
  description = "Reader endpoint"
  value = "${aws_rds_cluster.default.reader_endpoint}"
}
