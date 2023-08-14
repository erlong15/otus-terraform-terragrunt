resource "random_password" "pwd" {
  count   = 1
  length = 16
  special = true
  min_special = 1
  upper = true
  min_upper = 1
  lower = true
  min_lower = 1
  numeric = true
  min_numeric = 1
  override_special = "_%@"
}

resource "yandex_mdb_clickhouse_cluster" "managed_clickhouse" {
  name        = var.cluster_name
  network_id  = var.network_id
  description = var.description
  labels      = var.labels
  environment = "PRODUCTION"
  embedded_keeper = true
  version     = var.database_version
  security_group_ids  = var.security_group_ids

  clickhouse {
    
    resources {
      resource_preset_id = var.resource_preset_id
      disk_size          = var.disk_size
      disk_type_id       = var.disk_type_id
    }
  }

  
  dynamic "user" {
    for_each = var.users
    content {
      name     = user.value.name
      password = user.value.password == "" || user.value.password == null ? random_password.pwd[0].result : user.value.password

      dynamic "permission" {
        for_each = var.user_permissions[user.value.name]
        content {
          database_name = permission.value.database_name
        }
      }
    }
  }

  dynamic "database" {
    for_each = var.databases
    content {
      name = database.value.name
    }
  }

  dynamic "host" {
    for_each = var.hosts
    content {
      zone             = host.value.zone
      subnet_id        = host.value.subnet_id
      type             = "CLICKHOUSE"
      assign_public_ip = host.value.assign_public_ip
      shard_name       = host.value.shard_name == "" || host.value.shard_name == null ? "shard1" : host.value.shard_name
    }
  }
  cloud_storage {
    enabled = true
  }

  
  backup_window_start {
    hours   = var.backup_window_start_hours
    minutes = var.backup_window_start_minutes
  }

  access {
    data_lens = var.access_data_lens
    web_sql   = var.access_web_sql
  }

  
}
