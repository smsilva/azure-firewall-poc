locals {
  public_outbound_ips = [
    "201.80.161.224"
  ]

  azure_firewall_portal_ips = [
    "13.88.56.148",
    "13.91.105.215",
    "13.95.130.121",
    "20.245.81.54",
    "4.210.172.107",
    "40.118.23.126",
    "40.80.152.199",
    "40.91.218.243",
  ]
}

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
