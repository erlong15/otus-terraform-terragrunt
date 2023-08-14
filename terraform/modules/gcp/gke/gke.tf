# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

resource "google_compute_network" "ololo_network" {
  name = "ololo-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "ololo_subnetwork" {
  name = "ololo-subnet"
  ip_cidr_range = "10.10.0.0/16"
  network = google_compute_network.ololo_network.name
  secondary_ip_range {
    range_name    = "ololo-pods"
    ip_cidr_range = "10.20.0.0/16"
  }
  secondary_ip_range {
    range_name    = "ololo-services"
    ip_cidr_range = "10.21.0.0/16"
  }    
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = "gke-ololo"
  region                     = var.region
  zones                      = var.zones
  network                    = google_compute_network.ololo_network.name
  subnetwork                 = google_compute_subnetwork.ololo_subnetwork.name
  ip_range_pods              = "ololo-pods"
  ip_range_services          = "ololo-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false

  node_pools = [
    {
      name                      = "ololo-pool"
      machine_type              = "e2-medium"
      node_locations            = "europe-north1-a"
      min_count                 = 1
      max_count                 = 3
      local_ssd_count           = 0
      disk_size_gb              = 20
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      auto_repair               = true
      auto_upgrade              = true
      preemptible               = false
      initial_node_count        = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    ololo-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    ololo-pool = {
      ololo-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    ololo-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    ololo-pool = [
      {
        key    = "ololo-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    ololo-pool = [
      "ololo-pool",
    ]
  }
}