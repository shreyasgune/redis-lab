output "host" {
  value       = google_redis_instance.chat_app_redis.host
  description = "The host name of the Redis instance."
}

output "port" {
  value       = google_redis_instance.chat_app_redis.port
  description = "The port number of the Redis instance."
}

output "auth_string" {
  value       = google_redis_instance.chat_app_redis.auth_string
  sensitive   = true
  description = "The generated auth string if auth is enabled."
}