# Start a container
resource "docker_container" "fpm" {
    env = [
        "SERVICE_NAME=${terraform.workspace}_fpm",
        "APP_ENV=dev",
        "NAME=fpm-${count.index}"
    ]
#    volumes = [
#        {
#            host_path = "/home/alps86/PhpstormProjects/teraform/code"
#            container_path = "/code"
#        }
#    ]
}

resource "docker_container" "app" {
#    volumes = [
#        {
#            host_path = "/home/alps86/PhpstormProjects/teraform/code"
#            container_path = "/code"
#        }
#    ]
}
