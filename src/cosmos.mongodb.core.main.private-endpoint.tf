resource "azurerm_private_endpoint" "cosmosdb_account_core" {
  name                = azurerm_cosmosdb_account.core_main.name
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  subnet_id           = azurerm_subnet.spoke_core_databases.id

  private_service_connection {
    name                           = "cosmos-mongodb"
    private_connection_resource_id = azurerm_cosmosdb_account.core_main.id
    subresource_names              = ["MongoDB"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "cosmos-mongodb"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_cosmos_mongodb.id]
  }
}
