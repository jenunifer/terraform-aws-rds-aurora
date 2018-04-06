module "test-aurora-1" {
  source                 = "jenunifer/rds-aurora/aws"
  cluster_identifier     = "test-aurora-1"
  azs                    = ["us-west-2a"]
  rds_username           = "testuser"
  rds_password           = "testpassword"
  vpc_id                 = "vpc-xxxxxx"
  subnet_group_name      = "aws_subnet_group"
  vpc_security_group_ids = ["sg-bahaahaha"]
  role                   = "test"
  pool_id		 = "1"
  tags = {
    team          = "test-team"
    env           = "stage"
    workload-type = "other"
    role          = "test"
  }

  replica_count       = 2
  publicly_accessible = false
}
