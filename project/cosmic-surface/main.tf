provider "google" {
  project = local.project
  region  = local.region
  version = "~> 2.15"
}

terraform {
  backend "gcs" {
    bucket      = "tf-mmk8s-state"
    prefix      = "terraform/state"
    credentials = "../../token.json"
  }
}

module "nat" {
  source  = "../../modules/network"
  project = local.project
  location  = local.location
}

module "gke" {
  source       = "../../modules/gke"
  network_name = module.nat.network_name
  project      = local.project
  location     = local.region
}
