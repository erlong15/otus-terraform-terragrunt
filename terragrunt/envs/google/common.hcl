locals {
    cred_file_path = "~/.ssh/ololo-masterclass-9dc3ee72050e.json"
    tf_state_bucket = "tf-state-ololo"
}


generate "backend" {
  path      = "backend_gen.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket  = "${local.tf_state_bucket}"
    prefix  = "terraform/state"
    credentials = "${local.cred_file_path}"
  }    
}
EOF
}