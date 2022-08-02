module "master" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${local.name}-master"

  engine               = local.engine
  engine_version       = local.engine_version
  family               = local.family
  major_engine_version = local.major_engine_version
  instance_class       = local.instance_class

  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage
  storage_encrypted     = true
  kms_key_id = aws_kms_key.rds_key.arn

  name     = "${local.identifier}master"
  username = var.username
  password = var.password
  port     = local.port
  iam_database_authentication_enabled = true

  multi_az               = true
  create_db_subnet_group = false
  db_subnet_group_name   = "${local.db_subnet_group}"
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_ids = var.database_subnets
  monitoring_interval = 5
  monitoring_role_arn = var.monitoring_role_arn

  maintenance_window              = "Sat:05:10-Sat:07:10"
  backup_window                   = "02:00-05:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  final_snapshot_identifier_prefix = "final-${local.name}"

  # Backups are required in order to create a replica
  backup_retention_period = 30
  skip_final_snapshot     = true
  deletion_protection     = true
  ca_cert_identifier = local.ca_cert_identifier
  tags = var.tags
}