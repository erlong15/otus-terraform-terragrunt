resource "yandex_mdb_postgresql_cluster" "mdb_pgsql" {
  name                = "yc-training-pgsql"
  environment         = "PRODUCTION"
  network_id          =  module.vpc.vpc_id
  security_group_ids  = [yandex_vpc_default_security_group.ch-training-sg.id] 

   labels = var.default_labels

  config {
    version = 14
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = "20"
    }
  }

  host {
    zone      = module.vpc.subnets[var.pgsql_subnet].zone
    subnet_id = module.vpc.subnets[var.pgsql_subnet].id
  }
}