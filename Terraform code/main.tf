
############ To Create the Resource Group #############
module "ResourceGroup" {
  source              = "./module/ResourceGroup"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

}

############# To Create the WebApp #################
module "Webapp" {
  source                  = "./module/Webapp"
  resource_group_name     = module.ResourceGroup.rg_name_out
  resource_group_location = module.ResourceGroup.rg_location_out
  OS_TYPE                = "Linux"
  SKU_NAME               = var.webapp_sku_name
  WEBAPP_PLAN_NAME       = var.webapp_plan_name
  WEBAPPNAME             = var.webapp_name
  APP_AUTOSCALE          = var.webapp_autoscale_name
  CUSTOM_EMAILS          = var.notification_email
  depends_on             = [module.ResourceGroup]

}

############# To Create the keyvault #################
module "keyvault" {
  source                  = "./module/KeyVault"
  resource_group_name     = module.ResourceGroup.rg_name_out
  resource_group_location = module.ResourceGroup.rg_location_out
  keyvault_name           = var.keyvault_name
  secret_name             = var.keyvault_secret_name
  secret_value            = var.keyvault_secret_value
  allowed_ip_rules        = var.keyvault_allowed_ip_rules
  depends_on              = [module.ResourceGroup]

}

############# To Create the ACR #################
module "ACR" {
  source                  = "./module/ACR"
  resource_group_name     = module.ResourceGroup.rg_name_out
  resource_group_location = module.ResourceGroup.rg_location_out
  registry_name           = var.registry_name
  sku                     = var.acr_sku
  public_network_access_enabled = var.acr_public_network_access_enabled
  network_rule_set_default_action = var.acr_network_default_action
  network_rule_set_ip_rules = var.acr_allowed_ip_ranges
  log_analytics_workspace = var.log_analytics_workspace
  depends_on              = [module.ResourceGroup]

}

############# To Create the AKS #################
module "AKS" {
  source                  = "./module/AKS"
  resource_group_name     = module.ResourceGroup.rg_name_out
  resource_group_location = module.ResourceGroup.rg_location_out
  node_count              = var.aks_node_count
  min_node_count          = var.aks_min_node_count
  max_node_count          = var.aks_max_node_count
  vm_size                 = var.aks_vm_size
  username                = var.aks_admin_username
  private_cluster_enabled = var.aks_private_cluster_enabled
  node_pool_zones         = var.aks_node_pool_zones
  log_analytics_workspace_id = module.ACR.log_analytics_workspace_id
  resource_group_id       = module.ResourceGroup.rg_name_id
  depends_on              = [module.ResourceGroup]

}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.ACR.registry_id
  role_definition_name = "AcrPull"
  principal_id         = module.AKS.kubelet_object_id
}

