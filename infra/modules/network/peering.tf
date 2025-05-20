resource "google_compute_global_address" "peering_address" {
  name          = var.peering_address_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.peering_address_prefix_length
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "peering_connection" {
  network                 = google_compute_network.vpc.id
  service                 = var.peering_service
  reserved_peering_ranges = [google_compute_global_address.peering_address.name]

  # Ensure the global address is created before attempting the connection
  depends_on = [google_compute_global_address.peering_address]
}

# It's good practice to enable the Service Networking API for the project
# This resource is not strictly part of the peering setup within the module,
# but it's a common prerequisite. You might manage this at a higher level (e.g., project setup).

# resource "google_project_service" "service_networking" {
#   service = "servicenetworking.googleapis.com"
#   disable_on_destroy = false
# }