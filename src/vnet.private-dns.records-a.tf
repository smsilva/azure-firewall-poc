resource "azurerm_private_dns_a_record" "container_app_env_core" {
  name                = local.private_dns_zone_record_base_core
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.core.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_core_wildcard" {
  name                = "*.${local.private_dns_zone_record_base_core}"
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.core.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_1" {
  name                = local.private_dns_zone_record_base_spoke_1
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_1.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_1_wildcard" {
  name                = "*.${local.private_dns_zone_record_base_spoke_1}"
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_1.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_2" {
  name                = local.private_dns_zone_record_base_spoke_2
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_2.private_ip_address]
}

resource "azurerm_private_dns_a_record" "container_app_env_spoke_2_wildcard" {
  name                = "*.${local.private_dns_zone_record_base_spoke_2}"
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 300
  records             = [local.container_app_environments.spoke_2.private_ip_address]
}
