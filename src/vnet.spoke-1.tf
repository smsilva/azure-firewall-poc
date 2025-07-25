resource "azurerm_virtual_network" "spoke_1" {
  name                = local.vnets.spokes.1.name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = [local.vnets.spokes.1.address_space]
}

resource "azurerm_subnet" "spoke_1_workloads" {
  name                 = local.vnets.spokes.1.subnets.workloads.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.spoke_1.name
  address_prefixes     = [local.vnets.spokes.1.subnets.workloads.address_prefix]
  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

resource "azurerm_subnet" "spoke_1_databases" {
  name                 = local.vnets.spokes.1.subnets.databases.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.spoke_1.name
  address_prefixes     = [local.vnets.spokes.1.subnets.databases.address_prefix]
  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

resource "azurerm_subnet" "spoke_1_container_app_environment" {
  name                 = local.vnets.spokes.1.subnets.container_app_environment.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.spoke_1.name
  address_prefixes     = [local.vnets.spokes.1.subnets.container_app_environment.address_prefix]

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
