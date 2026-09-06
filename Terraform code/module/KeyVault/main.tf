
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set"
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = var.allowed_ip_rules
  }
}

resource "azurerm_key_vault_secret" "db-pwd" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = azurerm_key_vault.keyvault.id
}

# resource "azurerm_key_vault_access_policy" "policy" {
#   key_vault_id = azurerm_key_vault.keyvault.id
#
#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = "11111111-1111-1111-1111-111111111111" # SPN ID
#
#   key_permissions = [
#     "get",
#   ]
#
#   secret_permissions = [
#     "get",
#   ]
# }