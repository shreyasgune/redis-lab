include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/memorystore-redis"
}

# https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs
inputs = {
  instance_name   = "chat-app-redis"
  region          = "us-central1"
  memory_size_gb  = 1
  tier            = "STANDARD_HA"
  redis_version   = "REDIS_7_2"
  auth_enabled    = true
  display_name    = "chat-app-redis-instance"
  labels = {
    environment = "dev"
    owner       = "sgune"
  }
  maintenance_day        = "FRIDAY"
  maintenance_hour       = 2
  maintenance_start_time = "02:00"
  maintenance_duration   = "1h"
  network                = dependency.network.outputs.network_self_link
  reserved_range         = dependency.network.outputs.peering_reserved_range_name
}

dependency "network" {
  config_path = "../networking" # Assuming you have a network module
  mock_outputs = {
    # This is important for running Terragrunt commands like plan or validate when the actual network infrastructure hasn't been applied yet
    network_self_link = "projects/mock-project/global/networks/default"
    # Assuming your network module outputs the name of the reserved IP range for Redis
    peering_reserved_range_name = "mock-redis-ip-range"
  }
}


