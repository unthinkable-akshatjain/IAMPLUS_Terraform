locals {
  name = "${var.platform}-${var.host}-${var.env}-${var.resource}"
  identifier = "${var.platform}${var.host}${var.env}${var.resource}"
  engine                = "postgres"
  engine_version        = "11.10"
  family                = "postgres11" # DB parameter group
  major_engine_version  = "11"         # DB option group
  instance_class        = "db.m5.xlarge"
  allocated_storage     = 200
  max_allocated_storage = 1000
  port                  = 5432

  ca_cert_identifier = "rds-ca-2019-${var.region}"

  db_subnet_group = "${var.platform}-${var.host}-${var.env}"

  rds_kms_key_alias_name = "alias/${local.name}-key"
  rds_kms_description = "This key is to encrypt the storage of RDS"
}