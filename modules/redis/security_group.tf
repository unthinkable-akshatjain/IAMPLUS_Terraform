resource "aws_security_group" "redis_security_group" {
  name        = "${local.name}-security-group"
  vpc_id      = var.vpc_id
  tags = var.tags
}

resource "aws_security_group_rule" "redis_networks_ingress" {
  type              = "ingress"
  from_port         = local.port
  to_port           = local.port
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.redis_security_group.id
}