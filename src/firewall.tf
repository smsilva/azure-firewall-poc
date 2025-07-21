locals {
  firewall_name = "wasp-fw"
}

resource "azurerm_public_ip" "firewall" {
  name                = "azure-firewall"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}

resource "azurerm_firewall" "default" {
  name                = local.firewall_name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier
  zones               = ["1", "2", "3"]

  ip_configuration {
    name                 = "default-public-ip"
    subnet_id            = azurerm_subnet.hub_firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }

  firewall_policy_id = azurerm_firewall_policy.default.id
}

locals {
  firewall = {
    private_ip_address = azurerm_firewall.default.ip_configuration[0].private_ip_address
    public_ip_address  = azurerm_public_ip.firewall.ip_address
  }
}
