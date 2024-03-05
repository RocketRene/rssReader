terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}


provider "docker" {
  host = "unix:///var/run/docker.sock"

}

resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_image" "rssReader" {
  name         = "rssreader:latest"
  keep_locally = true

  build {
    context    = path.cwd
    # dockerfile = "/home/rene/openTofu/rssReader/dockerfile"

  }
}
resource "docker_network" "app_network" {
  name = "app_network"
}

resource "docker_container" "postgres" {
  name    = "postgres_db"
  image   = docker_image.postgres.name
  network_mode = "app_network"
  ports {
    internal = 5432
    external = 5432
  }
  env = [
    "POSTGRES_USER=myuser",
    "POSTGRES_PASSWORD=mypassword",
    "POSTGRES_DB=mydb"
  ]
}

resource "docker_container" "rssReader" {
  name    = "rssreader"
  image   = docker_image.rssReader.name
  network_mode = "app_network"
  ports {
    internal = 8080
    external = 8080
  }
  env = [
    "DB_URL=postgres://myuser:mypassword@postgres_db:5432/mydb?sslmode=disable",
    "PORT=8080"
  ]
}

