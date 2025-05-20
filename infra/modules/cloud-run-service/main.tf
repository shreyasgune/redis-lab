resource "google_cloud_run_v2_service" "spring_boot_app" {
  project  = var.project_id
  location = var.region
  name     = var.service_name

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
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  # Optional: Add labels
  labels = var.labels
}

resource "google_vpc_access_connector" "connector" {
  name          = "run-vpc"
  subnet {
    name = var.subnet_name
  }
  machine_type = var.machine_type
  min_instances = 2
  max_instances = 3
  region        = var.region
}

# IAM policy to allow unauthenticated (public) access
resource "google_cloud_run_service_iam_member" "invoker" {
  count    = var.allow_unauthenticated ? 1 : 0
  project  = google_cloud_run_v2_service.spring_boot_app.project
  location = google_cloud_run_v2_service.spring_boot_app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
  service = google_cloud_run_v2_service.spring_boot_app.name
}