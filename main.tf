terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.83.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "jatinrg1"
    storage_account_name = "jatinstorage1"
    container_name       = "tfstatefile"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg1" {
  name     = "jatinrg1"
  location = "West Europe"
}

resource "azurerm_storage_account" "storagetf1" {
  depends_on = [ azurerm_resource_group.rg1 ]     // depends on will run code parelle means TF will create RG first  and then storage ac.
  name                     = "jatinstorage1"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}


