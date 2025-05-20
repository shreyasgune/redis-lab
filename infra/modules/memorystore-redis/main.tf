
resource "google_redis_instance" "chat_app_redis" {
  name               = var.instance_name
  region             = var.region
  memory_size_gb     = var.memory_size_gb
  tier               = var.tier
  redis_version      = var.redis_version
  auth_enabled       = var.auth_enabled
  connect_mode       = var.connect_mode
  authorized_network = var.network
  reserved_ip_range  = var.reserved_range
  display_name       = var.display_name
  labels             = var.labels

  maintenance_policy {
    weekly_maintenance_window {
      day = var.maintenance_day
      start_time {
        hours   = tonumber(split(":", var.maintenance_start_time)[0])
        minutes = tonumber(split(":", var.maintenance_start_time)[1])
      }
    }
  }

  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
}
