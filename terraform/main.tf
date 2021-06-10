terraform {
  backend "azure" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "samplerg02" {
  name = "samplerg02"
  location = "eastus"

  tags = {
    "rgowner" = "ranjit"
  }
}
