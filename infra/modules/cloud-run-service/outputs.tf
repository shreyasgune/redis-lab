output "service_url" {
  description = "The URL of the deployed Cloud Run service."
  value       = google_cloud_run_v2_service.spring_boot_app.uri
}

output "service_name" {
  description = "The name of the deployed Cloud Run service."
  value       = google_cloud_run_v2_service.spring_boot_app.name
}