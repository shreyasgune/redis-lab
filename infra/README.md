# Infra setup

## Redis setup
For money reasons, we are using Redis (Memorystore) in GCP.


### GCP
- APIs enabled:
    - servicenetworking.googleapis.com
      -  essential for VPC peering
    - redis.googleapis.com
        - Creating and managing Redis instances (e.g., google_redis_instance).
    - compute.googleapis.com
        - Creating and managing VPC networks (e.g., google_compute_network in your network module).
        - Creating and managing subnets (e.g., google_compute_subnetwork in your network module).
       - Managing IP addresses, like the global address for peering (google_compute_global_address which you're already using in peering.tf).
        - Firewall rules, routes, and virtual machines, if you plan to add them.
    - vpcaccess.googleapis.com
      - so that cloud-run has access to the vpc where redis exists
    - run.googleapis.com
      - to enable cloud-run

### Networking
- Need to create VPC and a subnet, that will host the application as well as managed-redis solution. We'll get back a `network_id` and a `subnet_id`.
- Connection mode: `PRIVATE_SERVICE_ACCESS` which will reserve an IP range in the VPC - need to create `google_service_networking_connection` to set this up.
- Firewall rules to allow our VM to connect to Redis on port 6379. The source will be VMs IP range, the destination will be PSA (peering) IP range.

### Chat App
Decided to select cloud run as our choice of infra.
#### Why Cloud Run ?
- Serverless: You deploy your container, and Google manages the underlying infrastructure. No need to manage servers, patching, or scaling infrastructure directly.
- Pay-per-use & Scale to Zero: You only pay when your application is processing requests. If there's no traffic, Cloud Run can scale down to zero instances, meaning you pay nothing (or very little, for provisioned minimum instances if you configure them). This is extremely cost-effective for applications with variable or low traffic.
- Generous Free Tier: Cloud Run includes a perpetual free tier for a certain amount of vCPU-seconds, memory-seconds, and requests per month, which might cover a small application's needs entirely.
- Simple Deployment: Very easy to deploy a container image from Artifact Registry or Container Registry.
- Auto-scaling: Scales automatically based on incoming requests.
Integrated: Works well with other GCP services like Logging, Monitoring, and CI/CD tools.


### OpenTofu and Terragrunt
- `sudo docker buildx build --rm -t chat-app-infra:0.0.1 .`
- `sudo docker run --rm -it -v $(pwd):/redis-lab -v $GOOGLE_APPLICATION_CREDENTIALS:/gcp-sa.json -e GOOGLE_APPLICATION_CREDENTIALS=/gcp-sa.json -e SPRING_REDIS_PASSWORD $SPRING_REDIS_PASSWORD  chat-app-infra:0.0.1 bash`

### Memorystore
```
auth_string = found at https://console.cloud.google.com/memorystore/redis/locations/us-central1/instances/chat-app-redis/details/security?inv=1&invt=Abx6Mw&project=angelic-digit-297517

host = "10.237.0.12"

port = 6379
```
