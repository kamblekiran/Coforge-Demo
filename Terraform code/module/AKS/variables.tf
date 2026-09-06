variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"

}


variable "resource_group_id" {
  type        = string
  description = "resource group id"

}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "min_node_count" {
  type        = number
  description = "Minimum node count for autoscaling."
  default     = 3
}

variable "max_node_count" {
  type        = number
  description = "Maximum node count for autoscaling."
  default     = 6
}

variable "vm_size" {
  type        = string
  description = "VM size for AKS node pool."
  default     = "Standard_D4s_v5"
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Enable AKS private cluster."
  default     = true
}

variable "node_pool_zones" {
  type        = list(string)
  description = "Availability zones for the default node pool."
  default     = ["1", "2", "3"]
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics workspace resource ID for AKS monitoring."
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}