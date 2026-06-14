cloud_id  = "b1g_xxx_cloud"
folder_id = "b1g_xxx_stage"
zone      = "ru-central1-b"
environment = "stage"

vm_name   = "future-stage-app-1"
cores     = 4
memory    = 8
disk_size = 100
subnet_id = "e9b_xxx_stage_subnet"

ssh_public_key_path = "~/.ssh/id_rsa.pub"

preemptible   = false
core_fraction = 100
nat           = true