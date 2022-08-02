module "es_security_group" {
    source = "terraform-aws-modules/security-group/aws"
    name = "${local.cluster_name}-security-group"
    description = "Security Group for ${var.resource}"
    vpc_id = var.vpc_id
    ingress_cidr_blocks = [var.vpc_cidr]
    egress_rules        = ["all-all"]
}
