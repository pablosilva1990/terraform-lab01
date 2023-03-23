resource "azurerm_storage_account" "sto_lab01" {
  name                     = "sto23032023lab01"
  resource_group_name      =  var.azure_rg
  location                 =  var.azure_region
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}