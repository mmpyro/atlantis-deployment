resource "google_compute_network" "network" {
  name    = var.network
  project = var.project
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet
  network       = google_compute_network.network.self_link
  ip_cidr_range = "10.0.0.0/16"
  region = var.location
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.network.self_link
  project = var.project

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat-router"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.project

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "default" {
  name    = "master-webhook"
  network = google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.source_ranges
  priority      = 1000
  target_tags   = var.tags
}