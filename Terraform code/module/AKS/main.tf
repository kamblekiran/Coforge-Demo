
terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.5"  # Or whichever version you prefer
    }
  }
}

resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.resource_group_location
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  resource_group_name = var.resource_group_name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id
  private_cluster_enabled       = var.private_cluster_enabled
  azure_policy_enabled          = true
  role_based_access_control_enabled = true
  oidc_issuer_enabled           = true
  workload_identity_enabled     = true
  local_account_disabled        = true
  sku_tier                      = "Standard"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "agentpool"
    vm_size             = var.vm_size
    node_count          = var.node_count
    auto_scaling_enabled = true
    min_count           = var.min_node_count
    max_count           = var.max_node_count
    zones               = var.node_pool_zones
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }
}