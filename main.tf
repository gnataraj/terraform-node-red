terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {}

resource "random_string" "random1" {
  length           = 4
  special          = false
  upper=false
  }

resource "random_string" "random2" {
  length           = 4
  special          = false
  upper = false
  }


resource "docker_image" "nodered-image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered-container1" {
  name  = join("-", ["nodered", random_string.random1.result])
  image = docker_image.nodered-image.latest
  ports {
    internal = 1880
    //external = 1880
  }
}

resource "docker_container" "nodered-container2" {
  name  = join("-", ["nodered", random_string.random2.result])
  image = docker_image.nodered-image.latest
  ports {
    internal = 1880
    //external = 1880
  }
}



 output "container-name1" {
   value       = docker_container.nodered-container1.name
   description = "name of the docker container1"

 }

 output "container-name2" {
   value       = docker_container.nodered-container2.name
   description = "name of the docker container1"

 }
output "ip-address1" {
  value       = join(":", [docker_container.nodered-container1.ip_address, docker_container.nodered-container1.ports[0].external])
  description = "ip address of the container"

}

output "ip-address2" {
  value       = join(":", [docker_container.nodered-container2.ip_address, docker_container.nodered-container2.ports[0].external])
  description = "ip address of the container"

}