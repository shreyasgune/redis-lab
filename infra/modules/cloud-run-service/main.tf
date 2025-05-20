resource "google_cloud_run_v2_service" "spring_boot_app" {
  project  = var.project_id
  location = var.region
  name     = var.service_name
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      min_instance_count = var.min_instance_count
      max_instance_count = var.max_instance_count
    }

    containers {
      image = var.image_url
      ports {
        container_port = var.container_port
      }
      resources {
        limits = {
          cpu    = var.cpu_limit
          memory = var.memory_limit
        }
        # startup_cpu_boost = true # Consider for faster Spring Boot startup
      }
      # Common environment variables for the container
      dynamic "env"  {
        for_each = var.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
      depends_on = ["redis-service"]
    }

    containers {
        image = "redis:alpine"
        name = "redis-service"
        # ports {
        #   container_port = 6379
        # }
        startup_probe {
          initial_delay_seconds = 0
          timeout_seconds = 1
          period_seconds = 3
          failure_threshold = 1
          tcp_socket {
            port = 6379
          }
        }
        resources {
          limits = {
            cpu    = "0.5" # 500m CPU
            memory = "512Mi" # 512 MiB RAM
          }
        }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  # Optional: Add labels
  labels = var.labels
}

# resource "google_vpc_access_connector" "connector" {
#   name          = "run-vpc"
#   subnet {
#     name = var.subnet_name
#   }
#   machine_type = var.machine_type
#   min_instances = 2
#   max_instances = 3
#   region        = var.region
# }

# IAM policy to allow unauthenticated (public) access
resource "google_cloud_run_service_iam_member" "invoker" {
  count    = var.allow_unauthenticated ? 1 : 0
  project  = google_cloud_run_v2_service.spring_boot_app.project
  location = google_cloud_run_v2_service.spring_boot_app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
  service = google_cloud_run_v2_service.spring_boot_app.name
}