resource "azurerm_virtual_network" "spoke_2" {
  name                = local.vnets.spokes.2.name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = [local.vnets.spokes.2.address_space]
}

resource "azurerm_subnet" "spoke_2_workloads" {
  name                 = local.vnets.spokes.2.subnets.workloads.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.spoke_2.name
  address_prefixes     = [local.vnets.spokes.2.subnets.workloads.address_prefix]
}

resource "azurerm_subnet" "spoke_2_databases" {
  name                 = local.vnets.spokes.2.subnets.databases.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.spoke_2.name
  address_prefixes     = [local.vnets.spokes.2.subnets.databases.address_prefix]
  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

resource "azurerm_subnet" "spoke_2_container_app_environment" {
  name                 = local.vnets.spokes.2.subnets.container_app_environment.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.spoke_2.name
  address_prefixes     = [local.vnets.spokes.2.subnets.container_app_environment.address_prefix]

  delegation {
    name = "Microsoft.App.environments"

    service_delegation {
      name    = "Microsoft.App/environments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
