cloud_id  = "b1g_xxx_cloud"
folder_id = "b1g_xxx_prod"
zone      = "ru-central1-a"
environment = "prod"

vm_name   = "future-prod-app-1"
cores     = 8
memory    = 32
disk_size = 500
subnet_id = "e9b_xxx_prod_subnet"

ssh_public_key_path = "~/.ssh/id_prod.pub"

# prod: выделенный CPU, не прерываемая, БЕЗ публичного IP (доступ только из сети)
preemptible   = false
core_fraction = 100
nat           = false