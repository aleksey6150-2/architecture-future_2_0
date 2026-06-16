terraform {
  required_version = ">= 1.5"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100"
    }
  }
}

# Берём свежий образ ОС по семейству
data "yandex_compute_image" "this" {
  family = var.image_family
}

# Подключаемый (вторичный) диск
resource "yandex_compute_disk" "secondary" {
  name   = "${var.vm_name}-data"
  type   = var.disk_type
  zone   = var.zone
  size   = var.disk_size
  labels = var.labels
}

resource "yandex_compute_instance" "this" {
  name        = var.vm_name
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.this.id
      size     = var.boot_disk_size
      type     = var.disk_type
    }
  }

  # Присоединяем заранее созданный вторичный диск.
  secondary_disk {
    disk_id = yandex_compute_disk.secondary.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = var.nat
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  # SSH-ключ прокидывается через метаданные облака (cloud-init).
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }

  labels = var.labels
}