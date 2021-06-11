terraform {
  backend "azure" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "sangeeta" {
  name = "sangeeta001"
  location = "eastus"

  tags = {
    "rgowner" = "sangeta"
  }
}
