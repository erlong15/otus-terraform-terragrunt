include "root" {
  path = find_in_parent_folders()
  expose = true

}


terraform {
  source = "../../../terraform/modules/yandex"
}

inputs = {
  servers      = include.root.locals.servers
  cidr_blocks  = ["10.51.20.0/24"]
  network_name = "dec_network"

}