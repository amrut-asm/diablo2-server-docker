packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:focal"
  commit = true
  changes = [
    "WORKDIR \"/root/.wine/drive_c/Program Files/d2gs/\"",
    "ENTRYPOINT [\"supervisord\", \"-n\"]",
    "ENV LANG C.UTF-8"
  ]
}

build {
  name = "d2gs"

  sources = [
    "source.docker.ubuntu"
  ]

  provisioner "shell-local" {
    inline = [
      "mkdir generated",
      "mkdir generated/data"
    ]
  }

  provisioner "shell" {
    script = "scripts/install.sh"
  }

  provisioner "file" {
    source = "templates/d2gs.conf"
    destination = "/etc/supervisor/conf.d/"
  }

  provisioner "file" {
    sources = [
      "templates/d2gs/d2gs.reg.template",
      "templates/d2gs/D2Server.ini"
    ]
    destination = "/root/.wine/drive_c/Program Files/d2gs/"
  }

  provisioner "shell" {
    environment_vars = [
      "NETWORK_CIDR=${var.NETWORK_CIDR}",
      "INTERNAL_IP=${var.INTERNAL_IP}",
      "EXTERNAL_IP=${var.EXTERNAL_IP}",
      "D2GS_MAXGAMES=${var.D2GS_MAXGAMES}",
      "TELNET_PASSWORD_HASH=${var.TELNET_PASSWORD_HASH}",
      "D2CS_SECRET=${var.D2CS_SECRET}",
      "D2CS_MOTD=${var.D2CS_MOTD}",
      "D2CS_REALM_NAME=${var.D2CS_REALM_NAME}",
      "SV_LOCATION=${var.SV_LOCATION}",
      "SV_DESCRIPTION=${var.SV_DESCRIPTION}",
      "SV_URL=${var.SV_URL}",
      "SV_CONTACT_NAME=${var.SV_CONTACT_NAME}",
      "DOCKER_IMAGE_NAME=${var.DOCKER_IMAGE_NAME}",
      "DOCKER_IMAGE_TAG=${var.DOCKER_IMAGE_TAG}"
    ]
    script = "scripts/generate_d2gs_configs.sh"
  }

  provisioner "shell-local" {
    environment_vars = [
      "NETWORK_CIDR=${var.NETWORK_CIDR}",
      "INTERNAL_IP=${var.INTERNAL_IP}",
      "EXTERNAL_IP=${var.EXTERNAL_IP}",
      "D2GS_MAXGAMES=${var.D2GS_MAXGAMES}",
      "TELNET_PASSWORD_HASH=${var.TELNET_PASSWORD_HASH}",
      "D2CS_SECRET=${var.D2CS_SECRET}",
      "D2CS_MOTD=${var.D2CS_MOTD}",
      "D2CS_REALM_NAME=${var.D2CS_REALM_NAME}",
      "SV_LOCATION=${var.SV_LOCATION}",
      "SV_DESCRIPTION=${var.SV_DESCRIPTION}",
      "SV_URL=${var.SV_URL}",
      "SV_CONTACT_NAME=${var.SV_CONTACT_NAME}",
      "DOCKER_IMAGE_NAME=${var.DOCKER_IMAGE_NAME}",
      "DOCKER_IMAGE_TAG=${var.DOCKER_IMAGE_TAG}"
    ]
    script = "scripts/generate_pvpgn_configs.sh"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "${var.DOCKER_IMAGE_NAME}"
      tags = ["${var.DOCKER_IMAGE_TAG}"]
    }

    post-processor "docker-save" {
      path = "generated/nanibot-d2gs.tar"
    }
  }
}