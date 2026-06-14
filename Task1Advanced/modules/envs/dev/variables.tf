variable "cloud_id"  { type = string }
variable "folder_id" { type = string }              # у каждого окружения свой каталог
variable "zone"      { type = string }

variable "environment" { type = string }            # dev | stage | prod

variable "vm_name"   { type = string }
variable "cores"     { type = number }
variable "memory"    { type = number }
variable "disk_size" { type = number }
variable "subnet_id" { type = string }

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "preemptible"   { type = bool   default = true }
variable "core_fraction" { type = number default = 100  }
variable "nat"           { type = bool   default = true }