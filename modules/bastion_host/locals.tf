locals {
  kms_description    = "This Key is used to encrypt the host volume"
  kms_key_alias_name = "alias/${var.resource}-state-key"

  host_prefix = "${var.platform}-${var.host}-${var.env}"

  user_data = <<EOF
                    #!/bin/bash
                    echo "Hello!! Production Bastion"
                EOF
}
