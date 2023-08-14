variable "network_id" {
  type = string
}

variable "cluster_name" {
  type        = string
  description = "Unique for the cloud name of a cluster"
}

variable "description" {
  type    = string
  default = null
}

variable "security_group_ids" {
  type = list(string)
  default = null
  description = "A set of ids of security groups assigned to hosts of the cluster"
}

variable "resource_preset_id" {
  type        = string
  default     = "s2.small"
  description = "Id of a resource preset which means count of vCPUs and amount of RAM per host"
}

variable "disk_size" {
  type        = number
  default     = 100
  description = "Disk size in GiB"
}

variable "disk_type_id" {
  type        = string
  default     = "network-ssd"
  description = "Disk type: 'network-ssd', 'network-hdd', 'local-ssd'"
}

variable "database_version" {
  type        = string
  default     = "22.3"
  description = "Version of ClickHouse"
}

variable "labels" {
  type = map
  default = {
    deployment = "terraform"
  }
}

variable "backup_window_start_hours" {
  type        = number
  default     = 0
  description = "The hour at which backup will be started"
}

variable "backup_window_start_minutes" {
  type        = number
  default     = 0
  description = "The minutes at which backup will be started"
}

variable "users" {
  type = list(object(
    {
      name     = string
      password = string
    }
  ))
  default = [
    {
      name     = "user1"
      password = ""
    }
  ]
}

variable "user_permissions" {
  type = map(list(object(
    {
      database_name = string
    }
  )))
  default = {
    "user1" : [
      {
        database_name = "db1"
      }
    ]
  }
}

variable "databases" {
  type = list(object({
    name = string
  }))
  default = [{
    name = "db1"
  }]
}

variable "hosts" {
  type = list(object({
    zone             = string
    subnet_id        = string
    assign_public_ip = bool
    shard_name       = string
  }))
  description = "Parameters of hosts: zone - name of VPC zone, subnet_id - ID of a subnet"
}

variable "access_web_sql" {
  type    = bool
  default = false
}

variable "access_data_lens" {
  type    = bool
  default = false
}
