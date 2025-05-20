output "network_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.vpc.name
}

output "network_self_link" {
  description = "The self_link of the VPC network."
  value       = google_compute_network.vpc.self_link
}

output "subnet_name" {
  description = "The name of the subnet."
  value       = google_compute_subnetwork.subnet.name
}

output "subnet_self_link" {
  description = "The self_link of the subnet."
  value       = google_compute_subnetwork.subnet.self_link
}

output "subnet_cidr_range" {
  description = "The IP CIDR range of the subnet."
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

output "peering_reserved_range_name" {
  description = "The name of the reserved IP address range for VPC peering."
  value       = google_compute_global_address.peering_address.name
}