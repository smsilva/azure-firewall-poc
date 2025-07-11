output "firewall_private_ip" {
  value = local.firewall.private_ip_address
}

output "firewall_public_ip" {
  value = local.firewall.public_ip_address
}

output "cae_core_default_domain" {
  value = azurerm_container_app_environment.core.default_domain
}

output "private_dns_zone_name" {
  value = local.private_dns_zone_name
}

output "container_app_environments" {
  value = local.container_app_environments
}
