resource "azurerm_cosmosdb_account" "spoke_1_main" {
  count                                 = var.cosmos_mongodb_spoke_1_enabled ? 1 : 0
  name                                  = "${random_pet.resource_group_name.id}-spoke-1-main"
  location                              = azurerm_resource_group.spoke_1.location
  resource_group_name                   = azurerm_resource_group.spoke_1.name
  offer_type                            = "Standard"
  kind                                  = "MongoDB"
  mongo_server_version                  = "4.2"
  tags                                  = {}
  network_acl_bypass_for_azure_services = false
  is_virtual_network_filter_enabled     = true
  public_network_access_enabled         = true
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
    location          = azurerm_resource_group.spoke_1.location
    failover_priority = 0
  }

  dynamic "virtual_network_rule" {
    for_each = [
      azurerm_subnet.spoke_1_container_app_environment.id,
    ]
    content {
      id                                   = virtual_network_rule.value
      ignore_missing_vnet_service_endpoint = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  ip_range_filter = toset(concat(
    local.azure_firewall_portal_ips,
    local.public_outbound_ips,
  ))
}
