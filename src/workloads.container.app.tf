resource "azurerm_container_app" "core_app_1" {
  name                         = "app-1"
  workload_profile_name        = "Consumption"
  container_app_environment_id = azurerm_container_app_environment.core.id
  resource_group_name          = azurerm_resource_group.core.name
  revision_mode                = "Single"

  template {
    min_replicas = 1
    max_replicas = 3

    container {
      name   = "app"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.75
      memory = "1.5Gi"
    }
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  depends_on = [
    azurerm_container_app_environment.core,
    azurerm_firewall_policy_rule_collection_group.hub_spoke_default_rules,
  ]
}

resource "azurerm_container_app" "spoke_1_app_1" {
  name                         = "app-1"
  workload_profile_name        = "Consumption"
  container_app_environment_id = azurerm_container_app_environment.spoke_1.id
  resource_group_name          = azurerm_resource_group.spoke_1.name
  revision_mode                = "Single"

  template {
    min_replicas = 1
    max_replicas = 3

    container {
      name   = "app"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.75
      memory = "1.5Gi"
    }
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  depends_on = [
    azurerm_container_app_environment.spoke_1,
    azurerm_firewall_policy_rule_collection_group.hub_spoke_default_rules,
  ]
}

resource "azurerm_container_app" "spoke_2_app_1" {
  name                         = "app-1"
  workload_profile_name        = "Consumption"
  container_app_environment_id = azurerm_container_app_environment.spoke_2.id
  resource_group_name          = azurerm_resource_group.spoke_2.name
  revision_mode                = "Single"

  template {
    min_replicas = 1
    max_replicas = 3

    container {
      name   = "app"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.75
      memory = "1.5Gi"
    }
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  depends_on = [
    azurerm_container_app_environment.spoke_2,
    azurerm_firewall_policy_rule_collection_group.hub_spoke_default_rules,
  ]
}
