variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "skip_provisioners" {
  type        = bool
  description = "Flag to skip local-exec provisioners"
  default     = false
}

variable "enable_binary_authorization" {
  description = "Enable BinAuthZ Admission controller"
  default     = false
}

variable "zones" {
    type = list
    default = ["europe-north1-a", "europe-north1-b", "europe-north1-c"]
}