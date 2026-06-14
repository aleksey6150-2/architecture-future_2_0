# vm_module - переиспользуемый модуль ВМ (Yandex Cloud)

Модуль создаёт виртуальную машину с подключаемым (вторичным) диском и сетевым
интерфейсом. Не содержит значений окружений - вся специфика передаётся через
переменные. Используется из окружений dev / stage / prod.

## Структура
- `modules/vm/` - переиспользуемый модуль (ресурсы ВМ, диск, сеть)
- `envs/<env>/` - корневые конфигурации окружений (провайдер + вызов модуля + tfvars)

## Входные параметры модуля
| Параметр          | Тип    | Обяз. | По умолчанию    | Назначение                       |
|-------------------|--------|-------|-----------------|----------------------------------|
| vm_name           | string | да    | -               | Имя ВМ                           |
| cores             | number | да    | -               | vCPU                             |
| memory            | number | да    | -               | RAM, ГБ                          |
| disk_size         | number | да    | -               | Размер подключаемого диска, ГБ   |
| subnet_id         | string | да    | -               | ID подсети                       |
| ssh_public_key    | string | да    | -               | Содержимое публичного SSH-ключа  |
| zone              | string | нет   | ru-central1-a   | Зона доступности                 |
| platform_id       | string | нет   | standard-v3     | Поколение CPU                    |
| image_family      | string | нет   | ubuntu-2204-lts | Семейство образа ОС              |
| boot_disk_size    | number | нет   | 20              | Размер загрузочного диска, ГБ    |
| disk_type         | string | нет   | network-ssd     | Тип дисков                       |
| core_fraction     | number | нет   | 100             | Доля vCPU (20 = burstable)       |
| preemptible       | bool   | нет   | false           | Прерываемая ВМ                   |
| nat               | bool   | нет   | false           | Публичный IP                     |

## Выходы
| Выход             | Назначение                          |
|-------------------|-------------------------------------|
| vm_id             | ID ВМ                               |
| vm_name           | Имя ВМ                              |
| fqdn              | Внутреннее DNS-имя                  |
| internal_ip       | Внутренний IP                       |
| external_ip       | Внешний IP (null, если nat=false)   |
| boot_disk_id      | ID загрузочного диска               |
| secondary_disk_id | ID подключаемого диска              |

## Запуск
1. Аутентификация в Yandex Cloud:
   export YC_TOKEN=$(yc iam create-token)
2. Перейти в нужное окружение и применить его конфигурацию:
   cd envs/dev
   terraform init
   terraform plan  -var-file=dev.tfvars
   terraform apply -var-file=dev.tfvars

Для stage/prod - аналогично со своими -var-file.