
resource "yandex_mdb_kafka_cluster" "mdb_kafka" {
  environment         = "PRODUCTION"
  name                = "yc-training-kafka"
  network_id          = module.vpc.vpc_id
  security_group_ids  = [yandex_vpc_default_security_group.ch-training-sg.id]

  labels = var.default_labels
    config {
      version          = "2.8"
      assign_public_ip = false
      brokers_count    = 1
      
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "network-ssd"
          resource_preset_id = "s2.micro"
        }
      }
      zones   =  [module.vpc.subnets[var.kafka_subnet].zone ]
      
    }
}