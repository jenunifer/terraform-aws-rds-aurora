// The 'writer' endpoint for the cluster
output "cluster_identifier" {
  description = "Cluster Identifier"
  value       = "${aws_rds_cluster.default.id}"
}

output "cluster_endpoint" {
  description = "Cluster endpoint"
  value       = "${aws_rds_cluster.default.endpoint}"
}

// A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas
output "reader_endpoint" {
  description = "Reader endpoint"
  value       = "${aws_rds_cluster.default.reader_endpoint}"
}
