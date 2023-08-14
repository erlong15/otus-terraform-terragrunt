
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
    name = "main"
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
