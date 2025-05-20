# Tofu and Google Provider configs
terraform {
  required_version = ">= 1.6.2"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = " >= 6.35.0"
    }
  }
}

provider "google" {
  project = "angelic-digit-297517"
  region  = "us-central1"
  zone    = "us-central1-a"
}

