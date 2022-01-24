variable "servers" {
    type = map(object({
        cores = number
        memory = number
        zone = string
        boot_disk_size = number
        boot_disk_type = string
    }))
}

variable "allow_stopping_for_update" {
    type = bool
    default = false
}

variable "platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Nodes platform id"
}

variable "cidr_blocks" {
    type = list(string)
}

variable "network_name" {
    type = string
}

variable "network_zone" {
    type = string 
    default = "ru-central1-a"
}