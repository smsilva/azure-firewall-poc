resource "azurerm_virtual_network" "spoke_core" {
  name                = local.vnets.spokes.core.name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = [local.vnets.spokes.core.address_space]
}

resource "azurerm_subnet" "spoke_core_workloads" {
  name                              = local.vnets.spokes.core.subnets.workloads.name
  resource_group_name               = azurerm_resource_group.default.name
  virtual_network_name              = azurerm_virtual_network.spoke_core.name
  address_prefixes                  = [local.vnets.spokes.core.subnets.workloads.address_prefix]
  private_endpoint_network_policies = "Enabled"
  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

resource "azurerm_subnet" "spoke_core_databases" {
  name                              = local.vnets.spokes.core.subnets.databases.name
  resource_group_name               = azurerm_resource_group.default.name
  virtual_network_name              = azurerm_virtual_network.spoke_core.name
  address_prefixes                  = [local.vnets.spokes.core.subnets.databases.address_prefix]
  private_endpoint_network_policies = "Enabled"
  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

resource "azurerm_subnet" "spoke_core_container_app_environment" {
  name                              = local.vnets.spokes.core.subnets.container_app_environment.name
  resource_group_name               = azurerm_resource_group.default.name
  virtual_network_name              = azurerm_virtual_network.spoke_core.name
  address_prefixes                  = [local.vnets.spokes.core.subnets.container_app_environment.address_prefix]
  private_endpoint_network_policies = "Enabled"

  delegation {
    name = "Microsoft.App.environments"

    service_delegation {
      name    = "Microsoft.App/environments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}
