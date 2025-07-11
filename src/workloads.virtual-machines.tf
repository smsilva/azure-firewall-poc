resource "azurerm_linux_virtual_machine" "spoke_core" {
  name                = "spoke-core"
  resource_group_name = azurerm_resource_group.core.name
  location            = azurerm_resource_group.core.location
  size                = var.virtual_machine_size

  admin_username                  = var.admin_username
  admin_password                  = var.virtual_machine_password
  network_interface_ids           = [azurerm_network_interface.spoke_core.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "spoke_core" {
  name                = "spoke-core"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name

  ip_configuration {
    name                          = "private-ip"
    subnet_id                     = azurerm_subnet.spoke_core_workloads.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spoke_1" {
  name                = "spoke-1"
  resource_group_name = azurerm_resource_group.spoke_1.name
  location            = azurerm_resource_group.spoke_1.location
  size                = var.virtual_machine_size

  admin_username                  = var.admin_username
  admin_password                  = var.virtual_machine_password
  network_interface_ids           = [azurerm_network_interface.spoke_1.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "spoke_1" {
  name                = "spoke-1"
  location            = azurerm_resource_group.spoke_1.location
  resource_group_name = azurerm_resource_group.spoke_1.name

  ip_configuration {
    name                          = "private-ip"
    subnet_id                     = azurerm_subnet.spoke_1_workloads.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spoke_2" {
  name                = "spoke-2"
  resource_group_name = azurerm_resource_group.spoke_2.name
  location            = azurerm_resource_group.spoke_2.location
  size                = var.virtual_machine_size

  admin_username                  = var.admin_username
  admin_password                  = var.virtual_machine_password
  network_interface_ids           = [azurerm_network_interface.spoke_2.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "spoke_2" {
  name                = "spoke-2"
  location            = azurerm_resource_group.spoke_2.location
  resource_group_name = azurerm_resource_group.spoke_2.name

  ip_configuration {
    name                          = "private-ip"
    subnet_id                     = azurerm_subnet.spoke_2_workloads.id
    private_ip_address_allocation = "Dynamic"
  }
}
