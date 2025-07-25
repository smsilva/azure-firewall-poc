# https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-private-endpoints?tabs=arm-bicep#api-types-and-private-zone-names

resource "azurerm_private_dns_zone" "privatelink_cosmos_mongodb" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_core_mongodb" {
  name                  = "spoke-core-mongodb"
  resource_group_name   = azurerm_private_dns_zone.privatelink_cosmos_mongodb.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_cosmos_mongodb.name
  virtual_network_id    = azurerm_virtual_network.spoke_core.id
  registration_enabled  = false
}
