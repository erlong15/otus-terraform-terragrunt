module "vpc" {
  source       = "./modules/networking"  
  create_vpc   = true
  network_name = "training-network"
  domain_name  = "yandex-cloud-training"
  folder_id    =  var.yc_folder_id
  subnets      =  var.trainig_subnets
  labels =  var.default_labels
}

module "clickhouse" {
   source = "./modules/mdb-clickhouse"
    cluster_name = "yc-training-clickhouse"
    network_id   = module.vpc.vpc_id
    description  = "Main taraining ClickHouse database cluster"
    security_group_ids = [yandex_vpc_default_security_group.ch-training-sg.id] 
    labels = var.default_labels

    resource_preset_id = "s2.small"
    disk_size          = 24 #GiB
    disk_type_id       = "network-ssd"

    access_web_sql     = true
    access_data_lens   = true            

    hosts = [ for shard in var.ch_shards_matrix :      
      {   
         
          subnet_id   = module.vpc.subnets[shard.v4_cidr_blocks].id
          zone   = module.vpc.subnets[shard.v4_cidr_blocks].zone
          assign_public_ip = false
          shard_name       = shard.shard_name
      }
      
    ]

}

output "clickhouse-cluster-hosts-fqdns"{
    value = module.clickhouse.cluster_hosts_fqdns
}

output "clickhouse-cluster-users"{
    value = module.clickhouse.cluster_users
     sensitive = true
}

output "clickhouse-cluster-users-passwords"{
    value = module.clickhouse.cluster_users_passwords
    sensitive = true
}


