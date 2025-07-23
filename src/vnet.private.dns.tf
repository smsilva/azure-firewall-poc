locals {
  private_dns_zone_name = "${azurerm_resource_group.default.location}.azurecontainerapps.io"
}

resource "azurerm_private_dns_zone" "default" {
  name                = local.private_dns_zone_name
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub" {
  name                  = "hub"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_core" {
  name                  = "spoke-core"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.spoke_core.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_1" {
  name                  = "spoke-1"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.spoke_1.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_2" {
  name                  = "spoke-2"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.spoke_2.id
  registration_enabled  = false
}

resource "azurerm_private_dns_a_record" "container_app_env_core" {
  name                = local.container_app_environments.core.custom_domain
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.core.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_core_wildcard" {
  name                = "*.${local.container_app_environments.core.custom_domain}"
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.core.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_1" {
  name                = local.container_app_environments.spoke_1.custom_domain
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_1.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_1_wildcard" {
  name                = "*.${local.container_app_environments.spoke_1.custom_domain}"
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_1.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_2" {
  name                = local.container_app_environments.spoke_2.custom_domain
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_2.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_2_wildcard" {
  name                = "*.${local.container_app_environments.spoke_2.custom_domain}"
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_2.private_ip_address]
}
