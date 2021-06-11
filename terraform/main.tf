provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "myrg" {
  name = "devrg01"
  location = "eastus"
}

resource "azurerm_virtual_network" "mastervnet" {
  name                = "mastervnet"
  address_space       = ["172.16.0.0/16"]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet" "web" {
  name                 = "web"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.mastervnet.name
  address_prefixes     = ["172.16.1.0/24"]
}

resource "azurerm_network_interface" "webserver001" {
  name                = "webserver001-nic"
  location            = azurerm_resource_group.myrg.name
  resource_group_name = azurerm_resource_group.myrg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "webserver001" {
  name                = "webserver001"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_D1_v2"
  admin_username      = "ranjit"
  network_interface_ids = [
    azurerm_network_interface.webserver001.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(".ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
