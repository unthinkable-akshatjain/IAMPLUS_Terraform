output "bastion_ip" {
  value = aws_eip.bastion.public_ip
}

output "kms_key_arn" {
  value = aws_kms_key.bastion_volume_key.arn
}

output "bastion_sg" {
  value = module.host_security_group.security_group_id
}
