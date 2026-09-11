variable "prometheus_port" {
  description = "Port exposed by Prometheus"
  type        = number
  default     = 9090
}

variable "grafana_port" {
  description = "Port exposed by Grafana"
  type        = number
  default     = 3000
}

variable "nodeexporter_port" {
  description = "Port exposed by Node Exporter"
  type        = number
  default     = 9100
}

variable "prometheus_image" {
  description = "Prometheus Docker image"
  type        = string
  default     = "prom/prometheus:latest"
}

variable "grafana_image" {
  description = "Grafana Docker image"
  type        = string
  default     = "grafana/grafana:latest"
}

variable "nodeexporter_image" {
  description = "Node Exporter Docker image"
  type        = string
  default     = "prom/node-exporter:latest"
}
