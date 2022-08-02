output "es_arn" {
  value = module.es_cluster.domain_arn
  description = "ARN of the Elasticsearch domain"
}

output "es_name" {
  value = module.es_cluster.domain_name
  description = "	Name of the Elasticsearch domain"
}

output "es_endpoint" {
  value = module.es_cluster.domain_endpoint
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
}

output "kibana_endpoint" {
  value = module.es_cluster.kibana_endpoint
  description = "Domain-specific endpoint for Kibana without https scheme"
}