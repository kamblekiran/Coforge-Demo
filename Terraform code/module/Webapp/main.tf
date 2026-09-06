

### To Create the Azure Webapp Plan ################
resource "azurerm_service_plan" "webplan" {
  name                = var.WEBAPP_PLAN_NAME
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = var.OS_TYPE
  sku_name            = var.SKU_NAME
}

resource "azurerm_linux_web_app" "app" {
  name                = var.WEBAPPNAME
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.webplan.id
  https_only          = true
  client_affinity_enabled = false

  site_config {
    always_on         = true
    minimum_tls_version = "1.2"
    health_check_path = "/healthz"
    ftps_state        = "Disabled"
    application_stack {
      dotnet_version = "6.0" # "v3.0", "v4.0", "5.0", "v6.0"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "SOME_KEY"                 = "some-value"
  }

}
### To Create the Azure Auto Scale based on the CPU Percentage ################
resource "azurerm_monitor_autoscale_setting" "autscale" {
  name                = var.APP_AUTOSCALE
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  target_resource_id  = azurerm_service_plan.webplan.id

  profile {
    name = "defaultProfile"
    capacity {
      default = 2
      minimum = 2
      maximum = 5
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.webplan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.webplan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }
  ### To Send the Alert ################
  notification {
    email {
      send_to_subscription_administrator    = false
      send_to_subscription_co_administrator = false
      custom_emails                         = [var.CUSTOM_EMAILS]
    }
  }
}