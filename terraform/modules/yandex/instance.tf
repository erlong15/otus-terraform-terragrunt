data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-1804-lts"
}

resource "yandex_compute_instance" "server" {
  for_each = var.servers
  allow_stopping_for_update = var.allow_stopping_for_update
  name                      = each.key
  platform_id               = var.platform_id
  zone                      = each.value.zone

  resources {
    memory = each.value.memory
    cores  = each.value.cores
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = each.value.boot_disk_size
      type     = each.value.boot_disk_type
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.main_subnet.id
    nat            = true
    nat_ip_address = yandex_vpc_address.main_address[each.key].external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  lifecycle {
    ignore_changes = [
      boot_disk[0].initialize_params[0].image_id,
      metadata
    ]
  }
}

