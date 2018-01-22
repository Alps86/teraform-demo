variable "count" { default = 3 }

resource "docker_container" "app" {
    name  = "${terraform.workspace}-data"
    image = "${docker_image.app.latest}"
    must_run = true
    restart = "always"
}

# Start a container
resource "docker_container" "web" {
    count = "${var.count}"
    name  = "${terraform.workspace}-web-${count.index}"
    image = "${docker_image.nginx.latest}"
    env = [
        "SERVICE_NAME=${terraform.workspace}_web",
        "NAME=web-${count.index}"
    ]
    links = ["${terraform.workspace}-fpm-${count.index}:fpm"]
    volumes = [
        {
            from_container = "${terraform.workspace}-data"
            volume_name = "/code/public"
            read_only = true
        }
    ]
    must_run = true
    restart = "always"
    depends_on = ["docker_container.fpm"]
}

resource "docker_container" "fpm" {
    count = "${var.count}"
    name  = "${terraform.workspace}-fpm-${count.index}"
    image = "${docker_image.fpm.latest}"
    env = [
        "SERVICE_NAME=${terraform.workspace}_fpm",
        "APP_ENV=prod",
        "NAME=fpm-${count.index}"
    ]
    volumes = [
        {
            from_container = "${terraform.workspace}-data"
            volume_name = "/code"
            read_only = true
        }
    ]
    depends_on = ["docker_container.app"]
}

resource "docker_image" "nginx" {
    name = "localhost:5000/nginx-base:latest"
}

resource "docker_image" "fpm" {
    name = "localhost:5000/php-base:latest"
}

resource "docker_image" "app" {
    name = "localhost:5000/app:latest"
}

terraform {
  backend "consul" {
    address = "consul:8500"
    path    = "app"
    lock    = false
  }
}