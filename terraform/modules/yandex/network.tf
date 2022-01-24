resource "yandex_vpc_network" "main_network" {
  name        = var.network_name
}

resource "yandex_vpc_subnet" "main_subnet" {
  network_id     = yandex_vpc_network.main_network.id
  zone           = var.network_zone
  v4_cidr_blocks = var.cidr_blocks
}

resource "yandex_vpc_address" "main_address" {
  for_each = var.servers
  name = each.key
  external_ipv4_address {
    zone_id = each.value.zone
  }
}