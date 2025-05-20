variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region where the Cloud Run service will be deployed."
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
}

variable "image_url" {
  description = "The URL of the container image (e.g., 'us-central1-docker.pkg.dev/PROJECT_ID/REPO/IMAGE:TAG')."
  type        = string
}

variable "container_port" {
  description = "The port your container listens on."
  type        = number
  default     = 8080 # Common for Spring Boot
}

variable "env_vars" {
  description = "A map of environment variables to set for the container."
  type        = map(string)
  default     = {}
}

variable "min_instance_count" {
  description = "Minimum number of container instances. Set to 0 for cost savings on low traffic."
  type        = number
  default     = 0
}

variable "max_instance_count" {
  description = "Maximum number of container instances for auto-scaling."
  type        = number
  default     = 2 # Adjust based on expected load
}

variable "cpu_limit" {
  description = "CPU limit for the container (e.g., '1', '2', '1000m', '2000m')."
  type        = string
  default     = "1" # Corresponds to 1 vCPU
}

variable "memory_limit" {
  description = "Memory limit for the container (e.g., '512Mi', '1Gi', '2Gi')."
  type        = string
  default     = "512Mi" # Adjust based on your Spring Boot app's needs
}

variable "allow_unauthenticated" {
  description = "Set to true to allow public access to the Cloud Run service."
  type        = bool
  default     = true # Change to false if you want to manage access via IAM or Ingress
}

variable "labels" {
  description = "A map of labels to apply to the Cloud Run service."
  type        = map(string)
  default     = {}
}

variable "subnet_name" {
  description = "name of the subnet used"
  type        = string
  default     = "default"
}

variable "machine_type" {
    description = "machine type"
    type        = string
    default     = "n1-standard-1"
}
