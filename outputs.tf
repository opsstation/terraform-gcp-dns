output "type" {
  description = "The DNS zone type."
  value       = var.type
}

output "name" {
  description = "The DNS zone name."
  value = element(
    concat(
      google_dns_managed_zone.peering[*].name,
      google_dns_managed_zone.forwarding[*].name,
      google_dns_managed_zone.private[*].name,
      google_dns_managed_zone.public[*].name,
      google_dns_managed_zone.reverse_lookup[*].name,
      google_dns_managed_zone.service_directory[*].name
    ),
    0,
  )
}

output "domain" {
  description = "The DNS zone domain."
  value = element(
    concat(
      google_dns_managed_zone.peering[*].dns_name,
      google_dns_managed_zone.forwarding[*].dns_name,
      google_dns_managed_zone.private[*].dns_name,
      google_dns_managed_zone.public[*].dns_name,
      google_dns_managed_zone.reverse_lookup[*].dns_name,
      google_dns_managed_zone.service_directory[*].dns_name
    ),
    0,
  )
}

output "name_servers" {
  description = "The DNS zone name servers."
  value = flatten(
    concat(
      google_dns_managed_zone.peering[*].name_servers,
      google_dns_managed_zone.forwarding[*].name_servers,
      google_dns_managed_zone.private[*].name_servers,
      google_dns_managed_zone.public[*].name_servers,
      google_dns_managed_zone.reverse_lookup[*].name_servers,
      google_dns_managed_zone.service_directory[*].name_servers
    ),
  )
}

output "zone_id" {
  description = "An identifier for the resource with format."
  value = flatten(
    concat(
      google_dns_managed_zone.peering[*].id,
      google_dns_managed_zone.forwarding[*].id,
      google_dns_managed_zone.private[*].id,
      google_dns_managed_zone.public[*].id,
      google_dns_managed_zone.reverse_lookup[*].id,
      google_dns_managed_zone.service_directory[*].id
    ),
  )
}

output "managed_zone_id" {
  description = "An identifier for the resource with format."
  value = flatten(
    concat(
      google_dns_managed_zone.peering[*].managed_zone_id,
      google_dns_managed_zone.forwarding[*].managed_zone_id,
      google_dns_managed_zone.private[*].managed_zone_id,
      google_dns_managed_zone.public[*].managed_zone_id,
      google_dns_managed_zone.reverse_lookup[*].managed_zone_id,
      google_dns_managed_zone.service_directory[*].managed_zone_id
    ),
  )
}

output "creation_time" {
  description = "The time that this resource was created on the server."
  value = flatten(
    concat(
      google_dns_managed_zone.peering[*].creation_time,
      google_dns_managed_zone.forwarding[*].creation_time,
      google_dns_managed_zone.private[*].creation_time,
      google_dns_managed_zone.public[*].creation_time,
      google_dns_managed_zone.reverse_lookup[*].creation_time,
      google_dns_managed_zone.service_directory[*].creation_time
    ),
  )
}