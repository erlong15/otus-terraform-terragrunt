

terraform {
  source = "../../../terraform/modules/yandex"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}

inputs = {
  servers      = include.root.locals.servers
  cidr_blocks  = ["10.51.21.0/24"]
  network_name = "test_network"
}