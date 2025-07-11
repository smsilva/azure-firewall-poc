resource "azurerm_ip_group" "spoke_core" {
  name                = "ipg-spoke-core"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  cidrs = [
    local.vnets.spokes.core.address_space
  ]
}

resource "azurerm_ip_group" "spokes_customers" {
  name                = "ipg-spokes-customers"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  cidrs = [
    local.vnets.spokes.1.address_space,
    local.vnets.spokes.2.address_space,
  ]
}
