

locals {
    cred_file_path = "~/.ssh/ololo-masterclass-9dc3ee72050e.json"
    project_id  = "ololo-masterclass"
    region = "europe-north1" 
}

generate "provider" {
  path      = "provider_gen.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "google" {
  credentials = file("${local.cred_file_path}")
  project = "${local.project_id}"
  region  = "${local.region}"
}
EOF
}