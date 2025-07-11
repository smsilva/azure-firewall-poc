resource "azurerm_firewall_policy" "default" {
  name                     = "${local.firewall_name}-policy"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  sku                      = var.firewall_sku_tier
  threat_intelligence_mode = "Alert"
}
