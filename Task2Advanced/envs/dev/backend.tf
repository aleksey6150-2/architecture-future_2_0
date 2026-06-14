terraform {
  backend "s3" {
    bucket = "future20-tfstate"        # один бакет на все окружения
    key    = "dev/terraform.tfstate"   # СВОЙ ключ на окружение = изоляция state
    region = "ru-central1"

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    # Object Storage S3-совместимо, но это не AWS - глушим AWS-специфичные проверки:
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true

    # Нативная блокировка состояния через lock-объект в том же бакете (Terraform >= 1.10).
    # Раньше для этого нужна была таблица DynamoDB (в Yandex - YDB Document API).
    use_lockfile = true
  }
}