resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  provider = google-beta
  project  = var.project
  location = var.location


  remove_default_node_pool = true
  initial_node_count       = var.number_of_nodes
  enable_legacy_abac       = true
  network                  = var.network_name

  dynamic "ip_allocation_policy" {
    for_each = local.vpc_native
    content {}
  }

  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    enable_private_endpoint = false
  }

  release_channel {
    channel = var.release_channel
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = local.node_pool_name
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = var.number_of_nodes

  node_config {
    preemptible  = true
    machine_type = var.vm_type


    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags = var.tags
  }
}