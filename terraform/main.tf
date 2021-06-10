terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider


resource "azurerm_resource_group" "samplerg01" {
  name = "samplerg02"
  location = "eastus"

  tags = {
    "rgowner" = "ranjit"
  }
}
