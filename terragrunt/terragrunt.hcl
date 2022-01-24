locals {
  servers = {
    "master" = {
      memory         = 4
      cores          = 2
      zone           = "ru-central1-a"
      boot_disk_size = 20
      boot_disk_type = "network-ssd"
    }
    "slave" = {
      memory         = 4
      cores          = 2
      zone           = "ru-central1-a"
      boot_disk_size = 20
      boot_disk_type = "network-ssd"
    }
  }
  s3_access_key = get_env("AWS_ACCESS_KEY_ID")
  s3_secret_key = get_env("AWS_SECRET_ACCESS_KEY")
  s3_bucket     = "otus-tfstate"
  s3_region     = "ru-central1"

  yc_token = get_env("YC_TOKEN")
  yc_cloud_id  = "b1ga9aooiodscmmouobm"
  yc_folder_dev_id = "b1g416evp4dl2eef88nt"
  yc_folder_test_id = "b1gms5goflgecu065agg"
  yc_zone      = "ru-central1-a"
  
}

/* remote_state {
  backend = "s3"
  config = {
    endpoint = "storage.yandexcloud.net"
    bucket   = local.s3_bucket
    region   = local.s3_region
    key      = "environments/dev/yandex/terraform.tfstate"
    access_key                  = "${local.s3_access_key}"
    secret_key                  = "${local.s3_secret_key}"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
} */

generate "provider" {
  path      = "provider_gen.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "yandex" {
  token     = "${local.yc_token}"
  cloud_id  = "${local.yc_cloud_id}"
  folder_id = "${local.yc_folder_dev_id}"
  zone      = "${local.yc_zone}"
}
provider "yandex" {
  alias     = "test"
  token     = "${local.yc_token}"
  cloud_id  = "${local.yc_cloud_id}"
  folder_id = "${local.yc_folder_test_id}"
  zone      = "${local.yc_zone}"
}
EOF
}

generate "backend" {
  path      = "backend_gen.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "${local.s3_bucket}"
    region                      = "${local.s3_region}"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    access_key                  = "${local.s3_access_key}"
    secret_key                  = "${local.s3_secret_key}"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
EOF
}