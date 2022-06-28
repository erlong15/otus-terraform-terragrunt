include "my_env" {
  path   = find_in_parent_folders("dev.hcl")
  expose = true
}

locals {
  common_env_vars  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

generate = local.common_env_vars.generate

terraform {
  source = "../../../../../terraform/modules/gcp/gke"
}

inputs = {
  project_id          = include.my_env.locals.project_id
  cluster_name_suffix = "ololo"
  region              = include.my_env.locals.region

}
