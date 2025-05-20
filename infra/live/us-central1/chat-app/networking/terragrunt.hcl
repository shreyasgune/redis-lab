include {
  path = find_in_parent_folders()
}
terraform {
  # Configure the Terraform module source.
  # This example points to a local module located at ../modules/network.
  #
  # You can replace this with other sources, for example:
  # - A Git repository: source = "git::https://example.com/user/repo.git//modules/network?ref=v1.0.0"
  # - The Terraform Registry: source = "terraform-aws-modules/vpc/aws"
  #
  # Adjust the path or URL to point to your specific network module.
  source = "../../../../modules/network"
}

inputs = {
  network_name    = "chat-app-network"     
  subnet_name = "chat-app-subnetwork"   
  subnet_cidr = "10.0.0.0/28" # 16 IPs, 14 usable
  subnet_region = "us-central1" 
}