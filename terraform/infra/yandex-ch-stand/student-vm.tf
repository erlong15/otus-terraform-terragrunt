
resource "yandex_compute_disk" "bastion-disk" {
  name     = "yc-training-bastion-disk"
  type     = "network-ssd"
  zone     = module.vpc.subnets[var.vm_subnet].zone
  image_id = var.student_vm_image

  labels = var.default_labels
}

resource "yandex_compute_instance" "bastion-instance" {
  name        = "yc-training-bastion"
  description = "Bastion VM"
  platform_id = "standard-v3"
  zone        = module.vpc.subnets[var.vm_subnet].zone

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    disk_id = yandex_compute_disk.bastion-disk.id
  }

  network_interface {
    nat       = true
    subnet_id = module.vpc.subnets[var.vm_subnet].id
    security_group_ids  = [yandex_vpc_default_security_group.ch-training-sg.id] 
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}