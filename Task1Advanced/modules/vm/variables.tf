variable "vm_name" {
  description = "Имя ВМ, обычно с окружением: future-dev-app-1."
  type        = string
}

variable "cores" {
  description = "Количество vCPU."
  type        = number
  validation {
    condition     = var.cores >= 2 && var.cores <= 32
    error_message = "cores должно быть в диапазоне 2..32."
  }
}

variable "memory" {
  description = "Объём RAM в гигабайтах."
  type        = number
  validation {
    condition     = var.memory >= 1 && var.memory <= 256
    error_message = "memory (ГБ) должно быть в диапазоне 1..256."
  }
}

variable "disk_size" {
  description = "Размер подключаемого (вторичного) диска в ГБ."
  type        = number
}

variable "subnet_id" {
  description = "ID подсети для сетевого интерфейса ВМ."
  type        = string
}

variable "ssh_public_key" {
  description = "Содержимое публичного SSH-ключа."
  type        = string
  # Публичный ключ не секрет, поэтому sensitive не ставим.
}

# ---- Необязательные параметры с дефолтами (переопределяются на окружении) ----

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "platform_id" {
  description = "Поколение CPU."
  type        = string
  default     = "standard-v3"
}

variable "image_family" {
  description = "Семейство образа ОС для загрузочного диска."
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "boot_disk_size" {
  type    = number
  default = 20
}

variable "disk_type" {
  description = "network-hdd | network-ssd | network-ssd-nonreplicated."
  type        = string
  default     = "network-ssd"
}

variable "core_fraction" {
  description = "Гарантированная доля vCPU: 100 = выделенные, 20 = burstable (dev)."
  type        = number
  default     = 100
}

variable "preemptible" {
  description = "Прерываемая ВМ (дешевле; подходит для dev/stage)."
  type        = bool
  default     = false
}

variable "nat" {
  description = "Выдавать ли публичный IP интерфейсу."
  type        = bool
  default     = false
}

variable "ssh_user" {
  type    = string
  default = "ubuntu"
}

variable "labels" {
  type    = map(string)
  default = {}
}