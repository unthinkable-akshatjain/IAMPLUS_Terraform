resource "aws_eip" "bastion" {
  instance = module.ec2_instance.id
  vpc      = true
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "${local.host_prefix}-${var.resource}"

  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  monitoring                  = true
  associate_public_ip_address = true
  cpu_credits                 = "unlimited"

  vpc_security_group_ids = [module.host_security_group.security_group_id]
  subnet_id              = var.subnet_id

  user_data_base64 = base64encode(local.user_data)

  iam_instance_profile = var.iam_role
  tags = var.tags

  root_block_device = [
    {
      delete_on_termination = false
      volume_type = "gp2"
      volume_size = var.volume_size
      encrypted   = true
      kms_key_id  = aws_kms_key.bastion_volume_key.arn
    }
  ]

  volume_tags = var.tags
}
