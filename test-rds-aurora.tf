variable "azs" {
  type    = "list"
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

# The below are used for each pool in this roles config.
# To add another pool for this instance, you will follow the below:
# 1. include a new local_pool_id_# (increment to next pool up)
# 2. copy and paste one module
# 3. update where the pool Id references are to add the new one.

locals {
  local_pool_id = "1"
  local_prefix  = "s"

  common_tags = {
    terraform     = "true"
    team          = "team-dev"
    env           = "stage"
    workload-type = "other"
    role          = "mysqltest"
  }
}

module "mysqltest-sta-1" {
  source = "../rds-aurora"

  rds_username           = "rds_user_admin"
  rds_password           = "test"
  vpc_id                 = "vpc-test"
  subnet_group_name      = "sg_test"
  vpc_security_group_ids = ["test-sec-group"]
  azs                    = ["${var.azs}"]

  pool_id       = "${local.local_pool_id}"
  env           = "${local.common_tags["env"]}"
  role          = "${local.common_tags["role"]}"
  replica_count = 1

  tags = "${merge(local.common_tags)}"
}
