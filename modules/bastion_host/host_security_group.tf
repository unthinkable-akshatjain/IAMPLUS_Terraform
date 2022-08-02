module "host_security_group" {
    source = "terraform-aws-modules/security-group/aws"
    name = "${local.host_prefix}-${var.resource}-security-group"
    description = "Security Group for ${var.resource}"
    vpc_id = var.vpc_id
    ingress_with_cidr_blocks = var.ingress_rules
}
