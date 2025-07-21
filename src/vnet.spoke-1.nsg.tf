resource "azurerm_network_security_group" "spoke_1_databases" {
  name                = "spoke-1-databases-nsg"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  security_rule {
    name                       = "AllowContainerAppEnvironmentToDatabases"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = [azurerm_subnet.spoke_1_container_app_environment.address_prefixes[0]]
    destination_address_prefix = azurerm_subnet.spoke_1_databases.address_prefixes[0]
  }

  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_subnet.spoke_1_databases.address_prefixes[0]
  }
}

resource "azurerm_subnet_network_security_group_association" "spoke_1_databases" {
  network_security_group_id = azurerm_network_security_group.spoke_1_databases.id
  subnet_id                 = azurerm_subnet.spoke_1_databases.id
}
