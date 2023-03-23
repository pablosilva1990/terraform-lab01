terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  backend "azurerm" {
    resource_group_name = "cloud-shell-storage-eastus"
    storage_account_name = "cs21003200207f6706b"
    container_name = "terraform-state"
    key = "main.tfstate"
  } 
}


provider "azurerm" {
  features {}
}
