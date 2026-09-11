output "prometheus_url" {
  description = "Prometheus URL"
  value       = "http://localhost:${var.prometheus_port}"
}

output "grafana_url" {
  description = "Grafana URL"
  value       = "http://localhost:${var.grafana_port}"
}

output "nodeexporter_url" {
  description = "Node Exporter URL"
  value = "http://localhost:${var.nodeexporter_port}"
}
