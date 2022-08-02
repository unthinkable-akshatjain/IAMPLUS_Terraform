locals {
  eks_prefix = "${var.platform}-${var.host}-${var.env}"
  cluster_name = "${local.eks_prefix}-${var.resource}"
  cluster_version = "1.20"

  # KMS Keys
  secret_kms_description    = "This Key is used to encrypt the k8s secrets"
  secret_kms_key_alias_name = "alias/${local.cluster_name}-secret-key"
  logs_kms_description    = "This Key is used to encrypt the eks-cluster logs"
  logs_kms_key_alias_name = "alias/${local.cluster_name}-log-key"
}
