include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/cloud-run-service"
}

inputs = {
    project_id = "angelic-digit-297517" 
    service_name = "my-spring-boot-app-dev" 
    image_url = "docker.io/sgune/chat-app:test"

    network               = "chat-app-network"
    subnet_name           = "chat-app-subnetwork"
    machine_type          = "f1-micro"

    container_port = 8080 # Default Spring Boot port
  
    # Set environment variables for your Spring Boot application
    env_vars = {
    #   SPRING_PROFILES_ACTIVE = "dev"
    #   SPRING_REDIS_HOST = "10.237.0.12"
      SPRING_REDIS_HOST = "localhost" # to connect to sidecar redis for now
      SPRING_REDIS_PORT = "6379"
    #   SPRING_REDIS_PASSWORD = get_env("SPRING_REDIS_PASSWORD")
    }
    # Adjust scaling and resources as needed
    min_instance_count = 0     # Scale to zero to save costs when idle
    max_instance_count = 1
    cpu_limit          = "1"   # 1 vCPU
    memory_limit       = "1Gi" # 1 GiB RAM for Spring Boot (adjust as needed)

    allow_unauthenticated = true # Make it publicly accessible for testing

    labels = {
      environment = "dev"
      app         = "spring-boot-chat-app"
    }

}


