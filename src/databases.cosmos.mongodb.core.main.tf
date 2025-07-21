resource "azurerm_cosmosdb_account" "core_main" {
  name                                  = "${random_pet.resource_group_name.id}-core-main"
  location                              = azurerm_resource_group.core.location
  resource_group_name                   = azurerm_resource_group.core.name
  offer_type                            = "Standard"
  kind                                  = "MongoDB"
  mongo_server_version                  = "4.2"
  tags                                  = {}
  network_acl_bypass_for_azure_services = true
  is_virtual_network_filter_enabled     = true
  public_network_access_enabled         = false
  automatic_failover_enabled            = false

  dynamic "capabilities" {
    for_each = concat(
      ["EnableMongo"],
      ["EnableServerless"],
    )
    content {
      name = capabilities.value
    }
  }

  capacity {
    total_throughput_limit = 500
  }

  consistency_policy {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  geo_location {
    location          = azurerm_resource_group.core.location
    failover_priority = 0
  }

  identity {
    type = "SystemAssigned"
  }
}
