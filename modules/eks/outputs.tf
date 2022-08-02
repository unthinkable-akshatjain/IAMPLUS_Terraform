output "cluster_id" {
  value = module.eks-cluster.cluster_id
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready."
}

output "aws_auth_config_map" {
  value = module.eks-cluster.config_map_aws_auth
  description = "A kubernetes configuration to authenticate to this EKS cluster."
}

output "cluster_endpoint" {
  value = module.eks-cluster.cluster_endpoint
  description = "The endpoint for your EKS Kubernetes API."
}

output "oidc_arn" {
  value = module.eks-cluster.oidc_provider_arn
  description = "The ARN of the OIDC Provider"
}

output "cluster_arn" {
  value = module.eks-cluster.cluster_arn
  description = "The Amazon Resource Name (ARN) of the cluster"
}

output "cluster_oidc_issuer_url" {
  value = module.eks-cluster.cluster_oidc_issuer_url
  description = "The URL of the EKS OIDC Provider"
}