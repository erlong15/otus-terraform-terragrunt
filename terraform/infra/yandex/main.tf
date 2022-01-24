locals {
    resources = {
            memory = 4
            cores  = 2
            zone = "ru-central1-a"
            boot_disk_size = 20
            boot_disk_type = "network-ssd"
        }

    servers = {
        "master" = local.resources
        "slave" = local.resources
    }
}
module "dev" {
    source = "../../modules/yandex"
    servers = local.servers
    cidr_blocks = ["10.51.21.0/24"]
    network_name = "dev_network"
}

module "test" {
    source = "../../modules/yandex"
    servers = local.servers
    cidr_blocks = ["10.51.20.0/24"]
    network_name = "test_network"
    providers = {
        yandex = yandex.test
    }
}