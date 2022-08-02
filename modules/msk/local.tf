locals{

   
    cluster_name = "${var.platform}-${var.host}-${var.env}-${var.resource}"
    msk_kms_description = "This is to encrypt the msk at rest"
    kms_key_alias_name = "alias/${local.cluster_name}-rest-key"

}