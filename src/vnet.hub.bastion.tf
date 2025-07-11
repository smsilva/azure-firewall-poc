resource "azurerm_bastion_host" "hub_bastion" {
  name                = "bastion-host"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  ip_configuration {
    name                 = "bastion-public-ip-config"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}

resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastion-public-ip"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
