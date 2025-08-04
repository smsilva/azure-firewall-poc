locals {
  private_dns_zone_name                = "${azurerm_resource_group.default.location}.azurecontainerapps.io"
  private_dns_zone_record_base_core    = local.container_app_environments.core.custom_domain
  private_dns_zone_record_base_spoke_1 = local.container_app_environments.spoke_1.custom_domain
  private_dns_zone_record_base_spoke_2 = local.container_app_environments.spoke_2.custom_domain
}

resource "azurerm_private_dns_zone" "default" {
  name                = local.private_dns_zone_name
  resource_group_name = azurerm_resource_group.default.name
}
