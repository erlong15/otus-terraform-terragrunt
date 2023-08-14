variable "yc_oauth_token" {
  description = "YC OAuth token"
  default     = ""
  type        = string
}

variable "yc_cloud_id" {
  description = "ID of a cloud"
  default     = ""
  type        = string
}

variable "yc_folder_id" {
  description = "ID of a folder"
  default     = ""
  type        = string
}

variable "yc_main_zone" {
  description = "The main availability zone"
  default     = "ru-central1-a"
  type        = string
}

variable "default_labels" {
  description = "Set of labels"
  default     = { "env" = "prod", "deployment" = "terraform" }
  type        = map(string)
}

variable "trainig_subnets" {
  type = any
  description = "CIDRs of training vpc subnets"
  default = [
                        {
                        "v4_cidr_blocks": "10.110.0.0/16",
                        "zone": "ru-central1-a"
                        },
                        {
                        "v4_cidr_blocks": "10.120.0.0/16",
                        "zone": "ru-central1-b"
                        },
                        {
                        "v4_cidr_blocks": "10.130.0.0/16",
                        "zone": "ru-central1-c"
                        }
                    ]

}
variable "ch_shards_matrix" {
  type = any
  description = "cluster shards"
  default =  [
                        {
                        "title": "shard1_replica1"
                        "shard_name": "shard1"
                        "v4_cidr_blocks": "10.110.0.0/16",                       
                        },
                        {
                        "title": "shard1_replica2"
                        "shard_name": "shard1"
                        "v4_cidr_blocks": "10.120.0.0/16",
                        },
                        {
                        "title": "shard2_replica1"
                        "shard_name": "shard2"
                        "v4_cidr_blocks": "10.110.0.0/16",                       
                        },
                        {
                        "title": "shard2_replica1"
                        "shard_name": "shard2"
                        "v4_cidr_blocks": "10.120.0.0/16",
                        }
                    ]
}

variable "kafka_subnet" {
      description = "CIDR of kafka subnet"
      type        = string
      default     = "10.110.0.0/16"
}

variable "pgsql_subnet" {
      description = "CIDR of PostgreSQL subnet"
      type        = string
      default     = "10.110.0.0/16"
}

variable "vm_subnet" {
      description = "CIDR of student VM subnet"
      type        = string
      default     = "10.110.0.0/16"
}

variable "student_vm_image" {
      description = "Student VM image id"
      type        = string
      default     = "fd83f6fme22a8p70mdne"  # ch-lab-template
}

