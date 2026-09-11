resource "docker_network" "monitoring" {
  name = "monitoring"
}

resource "docker_volume" "prometheus_data" {
  name = "prometheus_data"
}

resource "docker_volume" "grafana_data" {
  name = "grafana_data"
}

resource "docker_volume" "nodeexporter_data" {
  name = "nodeexporte_data"
}

resource "docker_image" "prometheus" {
  name = var.prometheus_image
}

resource "docker_image" "grafana" {
  name = var.grafana_image
}

resource "docker_image" "nodeexporter" {
  name = var.nodeexporter_image
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.image_id

  ports {
    internal = 9090
    external = var.prometheus_port
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }

  volumes {
    volume_name    = docker_volume.prometheus_data.name
    container_path = "/prometheus"
  }

  volumes {
    host_path      = abspath("${path.module}/prometheus/prometheus.yml")
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.image_id

  ports {
    internal = 3000
    external = var.grafana_port
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }

  volumes {
    volume_name    = docker_volume.grafana_data.name
    container_path = "/var/lib/grafana"
  }
}

resource "docker_container" "nodeexporter" {
  name  = "nodeexporter"
  image = docker_image.nodeexporter.image_id

  ports {
    internal = 9100
    external = var.nodeexporter_port
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }

  volumes {
    volume_name    = docker_volume.nodeexporter_data.name
    container_path = "/metrics"
  }
}
