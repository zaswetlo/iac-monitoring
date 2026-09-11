resource "docker_network" "monitoring" {
  name = "monitoring"
}

resource "docker_volume" "prometheus_data" {
  name = "prometheus_data"
}

resource "docker_volume" "grafana_data" {
  name = "grafana_data"
}

resource "docker_image" "prometheus" {
  name = var.prometheus_image
}

resource "docker_image" "grafana" {
  name = var.grafana_image
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
