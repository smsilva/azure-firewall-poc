resource "azurerm_firewall_policy_rule_collection_group" "hub_spoke_default_rules" {
  name               = "default-rules"
  firewall_policy_id = azurerm_firewall_policy.default.id
  priority           = 100

  network_rule_collection {
    name     = "AllowDefaultNetworkRules"
    priority = 100
    action   = "Allow"

    rule {
      name      = "AllowAzureDefaultIP"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["80", "32526", "53"]
      destination_addresses = ["168.63.129.16"]
    }

    rule {
      name      = "AllowDNS"
      protocols = ["UDP"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["53"]
      destination_addresses = ["8.8.8.8", "8.8.4.4"]
    }

    rule {
      name      = "AllowNTP"
      protocols = ["UDP"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["123"]
      destination_addresses = ["*"]
    }
  }

  network_rule_collection {
    name     = "AllowContainerAppNetworkRules"
    priority = 200
    action   = "Allow"

    rule {
      name      = "allow-mcr"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["mcr.microsoft.com", "*.data.mcr.microsoft.com"]
    }

    rule {
      name      = "allow-acr"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["*.azurecr.io", "*.blob.core.windows.net", "login.microsoft.com"]
    }

    rule {
      name      = "allow-identity"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["*.identity.azure.net", "login.microsoftonline.com", "*.login.microsoftonline.com", "*.login.microsoft.com"]
    }

    rule {
      name      = "allow-docker-hub"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["hub.docker.com", "registry-1.docker.io", "production.cloudflare.docker.com"]
    }

    rule {
      name      = "allow-microsoft-container-registry"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["MicrosoftContainerRegistry", "AzureFrontDoorFirstParty"]
    }

    rule {
      name      = "allow-azure-container-registry"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["AzureContainerRegistry"]
    }

    rule {
      name      = "allow-azure-key-vault"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["AzureKeyVault"]
    }

    rule {
      name      = "allow-managed-identity"
      protocols = ["Any"]
      source_ip_groups = [
        azurerm_ip_group.spoke_core.id,
        azurerm_ip_group.spokes_customers.id,
      ]
      destination_ports     = ["*"]
      destination_addresses = ["AzureActiveDirectory"]
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "spoke_core_rules" {
  name               = "spoke-core-rules"
  firewall_policy_id = azurerm_firewall_policy.default.id
  priority           = 200

  network_rule_collection {
    name     = "AllowSpokeCoreToCustomers"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "core-to-customers"
      protocols             = ["Any"]
      source_ip_groups      = [azurerm_ip_group.spoke_core.id]
      destination_ip_groups = [azurerm_ip_group.spokes_customers.id]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "spoke_customers_rules" {
  name               = "spoke-customers-rules"
  firewall_policy_id = azurerm_firewall_policy.default.id
  priority           = 300

  network_rule_collection {
    name     = "AllowCustomersToSpokeCore"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "customers-to-core"
      protocols             = ["Any"]
      source_ip_groups      = [azurerm_ip_group.spokes_customers.id]
      destination_ip_groups = [azurerm_ip_group.spoke_core.id]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "spoke_customers_block" {
  name               = "spoke-customers-block"
  firewall_policy_id = azurerm_firewall_policy.default.id
  priority           = 400

  network_rule_collection {
    name     = "BlockCustomersToCustomers"
    priority = 100
    action   = "Deny"

    rule {
      name                  = "customers-to-customers"
      protocols             = ["Any"]
      source_ip_groups      = [azurerm_ip_group.spokes_customers.id]
      destination_ip_groups = [azurerm_ip_group.spokes_customers.id]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "spoke_customers_internet" {
  name               = "spoke-customers-internet"
  firewall_policy_id = azurerm_firewall_policy.default.id
  priority           = 500

  network_rule_collection {
    name     = "AllowCustomersToInternet"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "customers-to-internet"
      protocols             = ["Any"]
      source_ip_groups      = [azurerm_ip_group.spokes_customers.id]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "spoke_core_internet" {
  name               = "spoke-core-internet"
  firewall_policy_id = azurerm_firewall_policy.default.id
  priority           = 600

  network_rule_collection {
    name     = "AllowCoreToInternet"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "core-to-internet"
      protocols             = ["Any"]
      source_ip_groups      = [azurerm_ip_group.spoke_core.id]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}
