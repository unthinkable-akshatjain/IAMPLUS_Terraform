resource "aws_key_pair" "generate_key_pair" {
  key_name = "${local.kp_prefix}-${var.resource}-key"
  public_key = var.public_key
  tags = var.tags
}