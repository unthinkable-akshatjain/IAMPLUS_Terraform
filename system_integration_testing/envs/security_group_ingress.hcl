locals {
  ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Ingress for SSH to bastion from Daffodil"
      cidr_blocks = "14.141.28.114/32"
    }
  ]
  egress = [
    {
      rule = "all-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}