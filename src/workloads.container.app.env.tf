resource "azurerm_resource_group" "core" {
  name     = "${random_pet.resource_group_name.id}-core"
  location = var.location
}

resource "azurerm_resource_group" "spoke_1" {
  name     = "${random_pet.resource_group_name.id}-spoke-1"
  location = var.location
}

resource "azurerm_resource_group" "spoke_2" {
  name     = "${random_pet.resource_group_name.id}-spoke-2"
  location = var.location
}

resource "azurerm_container_app_environment" "core" {
  name                               = "core"
  location                           = azurerm_resource_group.core.location
  resource_group_name                = azurerm_resource_group.core.name
  infrastructure_subnet_id           = azurerm_subnet.spoke_core_container_app_environment.id
  infrastructure_resource_group_name = "${azurerm_resource_group.core.name}-infra"
  internal_load_balancer_enabled     = true

  workload_profile {
    name                  = "D4"
    workload_profile_type = "D4"
    minimum_count         = 0
    maximum_count         = 1
  }
}

resource "azurerm_container_app_environment" "spoke_1" {
  name                               = "spoke-1"
  location                           = azurerm_resource_group.spoke_1.location
  resource_group_name                = azurerm_resource_group.spoke_1.name
  infrastructure_subnet_id           = azurerm_subnet.spoke_1_container_app_environment.id
  infrastructure_resource_group_name = "${azurerm_resource_group.spoke_1.name}-infra"
  internal_load_balancer_enabled     = true

  workload_profile {
    name                  = "D4"
    workload_profile_type = "D4"
    minimum_count         = 0
    maximum_count         = 1
  }
}

resource "azurerm_container_app_environment" "spoke_2" {
  name                               = "spoke-2"
  location                           = azurerm_resource_group.spoke_2.location
  resource_group_name                = azurerm_resource_group.spoke_2.name
  infrastructure_subnet_id           = azurerm_subnet.spoke_2_container_app_environment.id
  infrastructure_resource_group_name = "${azurerm_resource_group.spoke_2.name}-infra"
  internal_load_balancer_enabled     = true

  workload_profile {
    name                  = "D4"
    workload_profile_type = "D4"
    minimum_count         = 0
    maximum_count         = 1
  }
}

locals {
  container_app_environments = {
    core = {
      id                 = azurerm_container_app_environment.core.id
      name               = azurerm_container_app_environment.core.name
      custom_domain      = split(".", azurerm_container_app_environment.core.default_domain)[0]
      default_domain     = azurerm_container_app_environment.core.default_domain
      private_ip_address = azurerm_container_app_environment.core.static_ip_address
    }

    spoke_1 = {
      id                 = azurerm_container_app_environment.spoke_1.id
      name               = azurerm_container_app_environment.spoke_1.name
      custom_domain      = split(".", azurerm_container_app_environment.spoke_1.default_domain)[0]
      default_domain     = azurerm_container_app_environment.spoke_1.default_domain
      private_ip_address = azurerm_container_app_environment.spoke_1.static_ip_address
    }

    spoke_2 = {
      id                 = azurerm_container_app_environment.spoke_2.id
      name               = azurerm_container_app_environment.spoke_2.name
      custom_domain      = split(".", azurerm_container_app_environment.spoke_2.default_domain)[0]
      default_domain     = azurerm_container_app_environment.spoke_2.default_domain
      private_ip_address = azurerm_container_app_environment.spoke_2.static_ip_address
    }
  }
}
