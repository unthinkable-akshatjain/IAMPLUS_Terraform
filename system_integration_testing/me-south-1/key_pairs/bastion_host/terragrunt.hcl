include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../modules//key_pair//"
}

# Please enter the public key before applying
locals {
    
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDITZ/8wXT+OaWSWwLdTLBzYV3+COfZHwAyfe6bUfuCW59cWhJU/GbGd0y2tQV3We9+KqMIJBoH2vd+B18zYAXOy0bQapUOd+IPGYiFc1RyvI2tqqe4G73t/0W56z04xdMiW2S7YcWWXI1ojSHMn1e2r/mU688dNnOf8irKKHwGYAHI4RdF68VZ/fu8cIpNMvMJcywiJ9oGc6XpdWXDfqN7HGcL6d5Wxoc1Kbdj4KBiILGbgOkZDzLwnMT4oN/iCQlD8/qTIE7K0Mw4iTeTROmLfObqfxmz4WGllStQt4BUjZBSZ1GaKwi/9bewpOC87J0TbhZQRmKf6YgJQp8RbCIAnFpUeVEYKz3ax6pq2KJVJCNRFPme8rmK9Im4wVboMHpkXY4PonV01xrDCpYorbewqWq8vCu3dTD3bpfw6eBgn7+5Iio54osmP/LNw4Yvt7LbJluYQepw3Hm/E4S624Zd9IOReVzquaVFuZZH9JD9WooqLHAZMlcIe1C+5hVX71U= shubham-unthinkable@shubham-unthinkable"
    resource = "bastion"
}

inputs = {
    env = include.locals.env
    platform = include.locals.platform
    host = include.locals.host
    region = include.locals.aws_region
    tags = include.locals.tags
    public_key = local.public_key
    resource = local.resource
}