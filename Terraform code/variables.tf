variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "delphi-prod-rg"
}

variable "resource_group_location" {
  type        = string
  description = "Azure region for production deployment"
  default     = "UAE North"
}

variable "webapp_sku_name" {
  type        = string
  description = "App Service plan SKU"
  default     = "P1v3"
}

variable "webapp_plan_name" {
  type        = string
  description = "App Service plan name"
  default     = "delphi-web-plan-prod"
}

variable "webapp_name" {
  type        = string
  description = "Web App name"
  default     = "delphi-webapp-prod-7861"
}

variable "webapp_autoscale_name" {
  type        = string
  description = "Autoscale profile name"
  default     = "delphi-webapp-autoscale-prod"
}

variable "notification_email" {
  type        = string
  description = "Operations notification email"
  default     = "ops@example.com"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name"
  default     = "delphiprodkv7861"
}

variable "keyvault_secret_name" {
  type        = string
  description = "Key Vault secret name"
  default     = "DatabasePassword"
}

variable "keyvault_secret_value" {
  type        = string
  description = "Key Vault secret value. Supply through secure pipeline variable or tfvars, not in source."
  sensitive   = true
}

variable "keyvault_allowed_ip_rules" {
  type        = list(string)
  description = "Allowed CIDR ranges for Key Vault public endpoint"
  default     = []
}

variable "registry_name" {
  type        = string
  description = "ACR name"
  default     = "delphiacr7861"
}

variable "acr_sku" {
  type        = string
  description = "ACR SKU"
  default     = "Premium"
}

variable "acr_public_network_access_enabled" {
  type        = bool
  description = "Enable public network access to ACR"
  default     = true
}

variable "acr_network_default_action" {
  type        = string
  description = "Default network action for ACR"
  default     = "Deny"
}

variable "acr_allowed_ip_ranges" {
  type        = list(string)
  description = "Allowed CIDR ranges for ACR"
  default     = []
}

variable "log_analytics_workspace" {
  type        = string
  description = "Log Analytics Workspace name"
  default     = "delphi-law-prod"
}

variable "aks_node_count" {
  type        = number
  description = "Default AKS node count"
  default     = 3
}

variable "aks_min_node_count" {
  type        = number
  description = "AKS minimum node count"
  default     = 3
}

variable "aks_max_node_count" {
  type        = number
  description = "AKS maximum node count"
  default     = 6
}

variable "aks_vm_size" {
  type        = string
  description = "AKS node VM size"
  default     = "Standard_D4s_v5"
}

variable "aks_admin_username" {
  type        = string
  description = "AKS Linux admin username"
  default     = "azureadmin"
}

variable "aks_private_cluster_enabled" {
  type        = bool
  description = "Enable AKS private cluster"
  default     = true
}

variable "aks_node_pool_zones" {
  type        = list(string)
  description = "Availability zones for AKS node pool"
  default     = ["1", "2", "3"]
}
