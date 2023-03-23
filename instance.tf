resource "azurerm_resource_group" "lab_01" {
  name     = var.azure_rg
  location = var.azure_region
}

resource "azurerm_virtual_network" "vnet_lab01" {
  name                = "vnet-lab01"
  address_space       = ["10.1.0.0/16"]
  location            = var.azure_region
  resource_group_name = var.azure_rg
}

resource "azurerm_subnet" "subnet_lab01" {
  name                 = "subnet-lab01"
  resource_group_name  = var.azure_rg
  virtual_network_name = azurerm_virtual_network.vnet_lab01.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_network_interface" "nic_lab01" {
  name                = "nic_lab01"
  location            = var.azure_region
  resource_group_name = var.azure_rg

  ip_configuration {
    name                          = "ip-lab01"
    subnet_id                     = azurerm_subnet.subnet_lab01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pib_lab01.id
  }
}

resource "azurerm_public_ip" "pib_lab01" {
  name                    = "pib-lab01"
  location                = var.azure_region
  resource_group_name     = var.azure_rg
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "PRD"
  }
}


resource "azurerm_linux_virtual_machine" "vm-linux-lab01" {
  name                            = "vm-linux-lab01"
  resource_group_name             = var.azure_rg
  location                        = var.azure_region
  size                            = "Standard_B4ms"
  admin_username                  = "posilva"
  admin_password                  = "EstouFeliz@1234"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic_lab01.id,
  ]

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
    tags = {
      "LAB" = "lab_01"
    }
  }

  
resource "azurerm_network_interface" "nic_2_lab01" {
  name                = "nic_2_lab01"
  location            = var.azure_region
  resource_group_name = var.azure_rg

  ip_configuration {
    name                          = "ip-2-lab01"
    subnet_id                     = azurerm_subnet.subnet_lab01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pib_2_lab01.id
  }
}

resource "azurerm_public_ip" "pib_2_lab01" {
  name                    = "pib-2-lab01"
  location                = var.azure_region
  resource_group_name     = var.azure_rg
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "PRD"
  }
}

  resource "azurerm_windows_virtual_machine" "vm-win-lab01" {
  name                = "vm-win-lab01"
  resource_group_name = var.azure_rg
  location            = var.azure_region
  size                = "Standard_DS1_v2"
  admin_username      = "pablo.silva"
  admin_password      = "EstouFeliz@1234"
  network_interface_ids = [
    azurerm_network_interface.nic_2_lab01.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}