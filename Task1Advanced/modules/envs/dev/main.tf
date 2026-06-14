terraform {
  required_version = ">= 1.5"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "vm" {
  source = "../../modules/vm"

  # Обязательные параметры из задания:
  vm_name        = var.vm_name
  cores          = var.cores
  memory         = var.memory
  disk_size      = var.disk_size
  subnet_id      = var.subnet_id
  ssh_public_key = file(pathexpand(var.ssh_public_key_path))

  # Параметры, которыми окружения осмысленно различаются:
  zone          = var.zone
  preemptible   = var.preemptible
  core_fraction = var.core_fraction
  nat           = var.nat

  labels = {
    env     = var.environment
    project = "future-2-0"
  }
}