locals {
  cloud_id           = "b1gdooc1qviqeqtios79"
  folder_id          = "b1gs8l524fffjnjjep2q" #otus-labs
  folder_test_id     = "b1g69dmheko09a0asuq1" #test
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
  folder_id = local.folder_test_id
  zone      = local.zone
  token     = var.yc_token
  alias     = "test"
}