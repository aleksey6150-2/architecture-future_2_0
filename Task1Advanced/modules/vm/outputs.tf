output "vm_id" {
  description = "ID виртуальной машины."
  value       = yandex_compute_instance.this.id
}

output "vm_name" {
  value = yandex_compute_instance.this.name
}

output "fqdn" {
  description = "Внутреннее DNS-имя ВМ."
  value       = yandex_compute_instance.this.fqdn
}

output "internal_ip" {
  value = yandex_compute_instance.this.network_interface.0.ip_address
}

output "external_ip" {
  description = "Внешний IP (null, если nat = false)."
  value       = yandex_compute_instance.this.network_interface.0.nat_ip_address
}

output "boot_disk_id" {
  value = yandex_compute_instance.this.boot_disk.0.disk_id
}

output "secondary_disk_id" {
  description = "ID подключаемого диска."
  value       = yandex_compute_disk.secondary.id
}