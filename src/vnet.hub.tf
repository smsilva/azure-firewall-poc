resource "azurerm_virtual_network" "hub" {
  name                = local.vnets.hub.name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = [local.vnets.hub.address_space]
}

resource "azurerm_subnet" "hub_firewall" {
  name                 = local.vnets.hub.subnets.firewall.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [local.vnets.hub.subnets.firewall.address_prefix]
}

resource "azurerm_subnet" "hub_bastion" {
  name                 = local.vnets.hub.subnets.bastion.name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [local.vnets.hub.subnets.bastion.address_prefix]
}
