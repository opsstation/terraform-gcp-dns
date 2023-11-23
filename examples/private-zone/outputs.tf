output "name_servers" {
  description = "Zone name servers."
  value       = module.dns_private_zone.name_servers
}

output "id" {
  description = "An identifier for the resource with format."
  value       = module.dns_private_zone.zone_id
}

output "managed_zone_id" {
  description = "An identifier for the resource with format."
  value       = module.dns_private_zone.managed_zone_id
}

output "creation_time" {
  description = "The time that this resource was created on the server."
  value       = module.dns_private_zone.creation_time
}