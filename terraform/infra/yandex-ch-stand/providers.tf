
terraform {
  required_version = ">= 0.13"

  required_providers {
    yandex = {
     source  = "yandex-cloud/yandex"
      version = "> 0.6"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}

provider "yandex" {
  token     = var.yc_oauth_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_main_zone
}
