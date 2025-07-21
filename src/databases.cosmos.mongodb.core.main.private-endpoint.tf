# https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-private-endpoints?tabs=arm-bicep#api-types-and-private-zone-names
resource "azurerm_private_dns_zone" "privatelink_cosmos_mongodb" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.core.name
}

resource "azurerm_private_endpoint" "cosmosdb_account_core" {
  name                = "${azurerm_cosmosdb_account.core_main.name}-pe"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  subnet_id           = azurerm_subnet.spoke_core_databases.id

  private_service_connection {
    name                           = "core-main-cosmosdb-account-private-service-connection"
    private_connection_resource_id = azurerm_cosmosdb_account.core_main.id
    subresource_names              = ["MongoDB"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "mongo-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_cosmos_mongodb.id]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_core_mongodb" {
  name                  = "privatelink-cosmos-mongodb-vnet-spoke-core-link"
  resource_group_name   = azurerm_resource_group.core.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_cosmos_mongodb.name
  virtual_network_id    = azurerm_virtual_network.spoke_core.id
  registration_enabled  = true # Set to true if you want to allow automatic DNS registration of private endpoints in this VNet
}
