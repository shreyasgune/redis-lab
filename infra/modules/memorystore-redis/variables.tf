variable "instance_name" {
  type        = string
  description = "The name of the Redis instance."
}

variable "region" {
  type        = string
  description = "The GCP region to create the instance in."
}

variable "memory_size_gb" {
  type        = number
  description = "The size of the Redis instance in GB."
}

variable "tier" {
  type        = string
  description = "The service tier of the Redis instance (BASIC or STANDARD_HA)."
  default     = "BASIC"
}

variable "redis_version" {
  type        = string
  description = "The version of Redis software. If not provided, latest supported version will be used."
  default     = null
}

variable "auth_enabled" {
  type        = bool
  description = "Whether to enable auth on the Redis instance."
  default     = false
}

variable "network" {
  type        = string
  description = "The full name of the Google Compute Engine network to which the instance is connected."
}

variable "reserved_range" {
  type        = string
  description = "The name of the allocated IP address range associated with the private service access connection for the instance."
}

variable "display_name" {
  type        = string
  description = "An arbitrary and optional user-provided name for the instance."
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "Resource labels to represent user provided metadata."
  default     = {}
}

variable "maintenance_day" {
  type        = string
  description = "Day of the week for maintenance window. One of MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY."
  default     = "SUNDAY"
}

variable "maintenance_hour" {
  type        = number
  description = "Hour of day (0-23) for maintenance window."
  default     = 0
}

variable "maintenance_start_time" {
  type        = string
  description = "Start time of the update window in UTC time."
  default     = "00:00"
}

variable "maintenance_duration" {
  type        = string
  description = "Duration of the maintenance window."
  default     = "3h"
}

variable "connect_mode" {
  type = string
  description = "the mode of connection"
  default = "PRIVATE_SERVICE_ACCESS"
}

variable "project_id" {
  type        = string
  description = "The project ID in which the Redis instance will be created."
  default     = null
}