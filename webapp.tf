resource "azurerm_app_service_plan" "appplan-lab01" {
  name                = "appplanlab01"
  location            = var.azure_region
  resource_group_name = var.azure_rg

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webapp-lab01" {
  name                = "webapplab2303"
  location            = var.azure_region
  resource_group_name = var.azure_rg
  app_service_plan_id = azurerm_app_service_plan.appplan-lab01.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
}