terraform {
  backend "azurerm" {
    resource_group_name  = "rg-chandra"
    storage_account_name = "stgchandra"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}