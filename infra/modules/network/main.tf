

resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false # We'll create subnets explicitly
  description             = var.network_description
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.subnet_region
  network       = google_compute_network.vpc.self_link
}