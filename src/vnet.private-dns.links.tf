resource "azurerm_private_dns_zone_virtual_network_link" "hub" {
  name                  = "hub"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_core" {
  name                  = "spoke-core"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.spoke_core.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_1" {
  name                  = "spoke-1"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.spoke_1.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_2" {
  name                  = "spoke-2"
  resource_group_name   = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.spoke_2.id
  registration_enabled  = false
}
