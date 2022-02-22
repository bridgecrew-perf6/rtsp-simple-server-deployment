terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
#  host    = "npipe:////.//pipe//docker_engine"
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
  ports {
    internal = 9997
    external = 9997
  }
  ports {
    internal = 9998
    external = 9998
  }
  env = [
    "RTSP_PROTOCOLS=tcp"
  ]
  volumes {
    host_path = "/home/wipu/Workspaces/rtsp-simple-server-deployment/rtsp-simple-server.yml"
    container_path = "/rtsp-simple-server.yml"
    read_only = true
  }
  volumes {
    host_path = "/data/cctv-data"
    container_path = "/data/"
  }

}
