output "arn" {
  description = "Amazon Resource Name (ARN) of the MSK cluster."
  value       = module.msk-cluster.arn
}

output "encryption_at_rest_kms_key_arn" {
  description = "The ARN of the KMS key used for encryption at rest of the broker data volumes."
  value = module.msk-cluster.encryption_at_rest_kms_key_arn
}

output "bootstrap_brokers" {
  description = " A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client_broker encryption in transit is set o PLAINTEXT or TLS_PLAINTEXT."
  value       = module.msk-cluster.bootstrap_brokers
}

output "zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster."
  value       = module.msk-cluster.zookeeper_connect_string
}
