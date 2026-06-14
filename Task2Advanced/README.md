# Task2Advanced — CI/CD + удалённое состояние

Инфраструктура из Task1 разворачивается через пайплайн с удалённым state в
S3-совместимом хранилище (Yandex Object Storage). Локального state нет.

## Предварительная настройка (один раз)
1. Создать сервисный аккаунт и выдать роли (минимально необходимые):
    - на каталог окружения — editor/compute.* ;
    - на бакет state — storage.editor.
2. Создать бакет для состояния (приватный, versioning ON, шифрование ON):
   `future20-tfstate`.
3. Создать статический ключ доступа SA для S3 (access key id + secret).
4. Создать авторизованный ключ SA (JSON) для провайдера.

## Секреты CI (GitHub Secrets / GitLab CI Variables)
| Секрет                  | Назначение                              |
|-------------------------|-----------------------------------------|
| YC_SA_KEY               | JSON авторизованного ключа SA (провайдер) |
| YC_S3_ACCESS_KEY_ID     | access key к Object Storage (backend)   |
| YC_S3_SECRET_ACCESS_KEY | secret key к Object Storage (backend)   |

В коде секретов нет. backend читает ключи из AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY.

## Логика пайплайна
- Pull Request → fmt + validate + plan по dev/stage/prod, план сохраняется артефактом.
- Ручной запуск (workflow_dispatch) с выбором окружения → apply.
- apply применяет ровно отревьюенный план (terraform apply tfplan).
- Гейт аппрува: GitHub Environments → Required reviewers для prod/stage
  (в GitLab — when: manual + protected environment).

## Изоляция
- Свой ключ state на каждое окружение: <env>/terraform.tfstate.
- Свой каталог и свой <env>.tfvars на окружение (из Task1).
- Свои креды/окружения CI; prod защищён обязательным ревью.

## Локальный запуск (для проверки, без CI)
export YC_SERVICE_ACCOUNT_KEY_FILE=~/sa-key.json
export AWS_ACCESS_KEY_ID=...      # ключ Object Storage
export AWS_SECRET_ACCESS_KEY=...
cd Task2Advanced/envs/dev
terraform init
terraform plan  -var-file=dev.tfvars -out=tfplan
terraform apply tfplan