locals {
  cloud_id           = "b1ga9aooiodscmmouobm"
  folder_id          = "b1g416evp4dl2eef88nt"
  floder_test_id     = "b1gms5goflgecu065agg"
  zone               = "ru-central1-a"
}

terraform {
  required_version = ">= 1.0.1"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.61.0"
    }
  }
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "otus-tfstate"
    region   = "ru-central1"
    key      = "environments/otus/yandex/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
  zone      = local.zone
  token     = var.yc_token
}

provider "yandex" {
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
  zone      = local.zone
  token     = var.yc_token
  alias     = "test"
}