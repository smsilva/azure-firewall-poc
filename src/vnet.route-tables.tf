resource "azurerm_route_table" "spoke_core_route_table" {
  name                = "spoke-core-route-table"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  route {
    name                   = "to_firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = local.firewall.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "spoke_core_route_table_association_workloads" {
  route_table_id = azurerm_route_table.spoke_core_route_table.id
  subnet_id      = azurerm_subnet.spoke_core_workloads.id
}

resource "azurerm_subnet_route_table_association" "spoke_core_route_table_association_databases" {
  route_table_id = azurerm_route_table.spoke_core_route_table.id
  subnet_id      = azurerm_subnet.spoke_core_databases.id
}

resource "azurerm_subnet_route_table_association" "spoke_core_route_table_association_cae" {
  route_table_id = azurerm_route_table.spoke_core_route_table.id
  subnet_id      = azurerm_subnet.spoke_core_container_app_environment.id
}

resource "azurerm_route_table" "spoke_1_route_table" {
  name                = "spoke-1-route-table"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  route {
    name                   = "to_firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = local.firewall.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "spoke_1_route_table_association_workloads" {
  route_table_id = azurerm_route_table.spoke_1_route_table.id
  subnet_id      = azurerm_subnet.spoke_1_workloads.id
}

resource "azurerm_subnet_route_table_association" "spoke_1_route_table_association_databases" {
  route_table_id = azurerm_route_table.spoke_1_route_table.id
  subnet_id      = azurerm_subnet.spoke_1_databases.id
}

resource "azurerm_subnet_route_table_association" "spoke_1_route_table_association_cae" {
  route_table_id = azurerm_route_table.spoke_1_route_table.id
  subnet_id      = azurerm_subnet.spoke_1_container_app_environment.id
}

resource "azurerm_route_table" "spoke_2_route_table" {
  name                = "spoke-2-route-table"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  route {
    name                   = "to_firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = local.firewall.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "spoke_2_route_table_association_workloads" {
  route_table_id = azurerm_route_table.spoke_2_route_table.id
  subnet_id      = azurerm_subnet.spoke_2_workloads.id
}

resource "azurerm_subnet_route_table_association" "spoke_2_route_table_association_databases" {
  route_table_id = azurerm_route_table.spoke_2_route_table.id
  subnet_id      = azurerm_subnet.spoke_2_databases.id
}

resource "azurerm_subnet_route_table_association" "spoke_2_route_table_association_cae" {
  route_table_id = azurerm_route_table.spoke_2_route_table.id
  subnet_id      = azurerm_subnet.spoke_2_container_app_environment.id
}
