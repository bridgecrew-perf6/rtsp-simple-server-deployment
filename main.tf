terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "rtsp" {
  name         = "rtsp-simple-server:latest"
  keep_locally = true
}

resource "docker_container" "rtsp" {
  image = docker_image.rtsp.latest
  name  = var.container_name
  ports {
    internal = 8554
    external = 8554
  }
  ports {
    internal = 1935
    external = 1935
  }
  ports {
    internal = 8888
    external = 8888
  }
  env = [
    "RTSP_PROTOCOLS=tcp"
  ]
  volumes {
    host_path = "C:\\Workspaces\\rtsp-simple-server\\rtsp-simple-server.yml"
    container_path = "/rtsp-simple-server.yml"
    read_only = true
  }
  volumes {
    host_path = "C:\\Workspaces\\rtsp-simple-server\\data"
    container_path = "/data/"
  }

}
