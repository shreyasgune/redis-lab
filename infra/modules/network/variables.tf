variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

variable "network_description" {
  description = "A description for the VPC network."
  type        = string
  default     = "Managed by Terraform"
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "subnet_cidr" {
  description = "The IP CIDR range for the subnet."
  type        = string
}

variable "subnet_region" {
  description = "The region for the subnet."
  type        = string
}

variable "peering_address_name" {
  description = "The name for the reserved IP range for VPC peering."
  type        = string
  default     = "google-managed-services"
}

variable "peering_address_prefix_length" {
  description = "The prefix length of the reserved IP range for VPC peering."
  type        = number
  default     = 16 # Example: /16 range, adjust as needed
}

variable "peering_service" {
  description = "The service to connect to via VPC peering (e.g., servicenetworking.googleapis.com)."
  type        = string
  default     = "servicenetworking.googleapis.com"
}

variable "project_id" {
  description = "The project ID where the resources will be created."
  type        = string
  default     = null
}