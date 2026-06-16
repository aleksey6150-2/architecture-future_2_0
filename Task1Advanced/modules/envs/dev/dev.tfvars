cloud_id  = "b1g_xxx_cloud"
folder_id = "b1g_xxx_dev"        # отдельный каталог под dev
zone      = "ru-central1-a"
environment = "dev"

vm_name   = "future-dev-app-1"
cores     = 2
memory    = 2
disk_size = 20
subnet_id = "e9b_xxx_dev_subnet"

ssh_public_key_path = "~/.ssh/id_rsa.pub"

# dev экономит ресурсы: прерываемая ВМ, burstable CPU, публичный IP для удобства
preemptible   = true
core_fraction = 20
nat           = true